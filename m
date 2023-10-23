Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3E07D2ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjJWHDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWHDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:03:33 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6127AEE;
        Mon, 23 Oct 2023 00:03:30 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39N5gkRL018474;
        Mon, 23 Oct 2023 07:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=message-id:date:from:subject:to:cc:content-type
        :content-transfer-encoding:mime-version; s=PPS06212021; bh=1YgGn
        DoZwQrLvIdgkrQfow2zq3P5FmqnEPeAG1oodcE=; b=iV1nQP1IBWHQfR0FmiwwV
        CWFyrT+FYaLw10QgNQBFOYUJL0vcoWsFtPLHBaGzeCsSK7uqSGwRR681NjbKRS0K
        Ms7sQ6rV15FNQ3rLXDvvi6xs7qOW47gimPBlyQxNnxzPCvCP/i4moUFJsWetVi6P
        0ZNKY/LXzphLUt6ISuKYiJDt7iuK7wNsVo14LdriOnlFbRqye8p0+8TGcWSSFJlL
        rhouscX35yjeRNunBvJtk78Lz5Nn7NKtbNnrmBiP+P4J+8LJRCu5fFohhUMPthxQ
        5Xlc2GcuINlCswdgQ0hI9VfTjulR+qd1fgQT+Gn42aK0hyZdwQbwCJ0DNb2pgoyJ
        w==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3tv5m5sn7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 07:03:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSmWAF+ZqCycvEc8zuUKS11i71dltUrDDacp/ogpwmzDteSxYM4W31x7gImk68Bl9bXvApznv6cgwNknjGsW8aQEccGegPDrB8k+B+waVQuVFyv3H+6jb1et7uGOqGFf69hBgeEfrAQa2mlc/+xOG92HUXU0mWMtDYzCMD/Aq7ZWj+Q8tGcPHtc3sFdBf9YnJNqs4IkKtDRhLWFjt40Qp+k21UQc4xdaI4VmAvj7Va6Ir/W7psR6WjsNg5iqocYTCrxfBRJxPtHE7hmx6l3F9ixvVSJyY7/qHdYsCBg1gUkBK8xeTOLSfbADGyIko1VdpTBTRDQ/ZIJwDVrr6MzXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YgGnDoZwQrLvIdgkrQfow2zq3P5FmqnEPeAG1oodcE=;
 b=I/yR4j7L4/bHn6qnv0UZwzY159Ber1MSZpcvgiCJh/dFy/kPXb0GnlSyaShxRbYkMySiufT3fFiERrvjA3trSC/+ntvs8iricp7ZjwhD71W5r4YYEplbIu5V+5QxRo/cm7RnWaOy5ju+jbE+MtVmWmwgdL2GdcJi1sV03IaM4GiEIgR4zU1BkBXdaWLg0ttja+gNNNw1R/s714YE3exfEtsc1Bf9RwscOHovzyczCADU6v/gjayWeybGuU4K7vs2rBHf0j6h0wXnnpU3ATXc7/E6WH0ZzFGtBO+QdXJRm6RaWvhhgjkYPhwnL5JhpD7ZE9KAM8o2X8qu374bFiG9vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB7738.namprd11.prod.outlook.com (2603:10b6:8:e0::6) by
 DM4PR11MB7326.namprd11.prod.outlook.com (2603:10b6:8:106::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Mon, 23 Oct 2023 07:03:18 +0000
Received: from DS7PR11MB7738.namprd11.prod.outlook.com
 ([fe80::1ca3:401e:220d:23cd]) by DS7PR11MB7738.namprd11.prod.outlook.com
 ([fe80::1ca3:401e:220d:23cd%6]) with mapi id 15.20.6907.021; Mon, 23 Oct 2023
 07:03:18 +0000
Message-ID: <d7aa45f8-adf8-ff9a-b2c4-04b0f2cc3c06@windriver.com>
Date:   Mon, 23 Oct 2023 15:01:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
From:   "Jia, Fang" <fang.jia@windriver.com>
Subject: phy: fixed link 1000 or 100 set with autoneg off
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::12) To DS7PR11MB7738.namprd11.prod.outlook.com
 (2603:10b6:8:e0::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB7738:EE_|DM4PR11MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 951feae8-c63f-41af-2109-08dbd3962247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aajEVO2mwUUjATXxx597wjFGNkwzYn0hsdK6TKOoJ5oMSkaP3sif5fOWvQuGMXNmzct+5vvprd78jIIHzH6PiLDRsNw5sxIMQuMaMBDC2cJ7+/6H9VvzrSg0RxtFGvbBHAO80M9hU7564XeuyPtAS6lYZSg36LYiNClW5ZhYD9tH1ycGpBgD3kCys3SkqznLLTMyVR3OSJg/gGLzOmEl2vpFkoJW9M7q/reCVKyx9rfrYMQGf7v5DHzSlcNpsFuVm7h95kboIDWysT+iCOnb0L2sUBJ/ntAk7Bksum/Ov+MIECuBi8cBmDd6uXLPs5Aa2jRg70oyhGYgsddoLh3zkdCZp3gnRykCJ54fhQEVj4LU37BJWJsfJs2KdP2+OIDKnISt2aYzF3gnee13mwqBd8eKW/R8LoilNkMWZRJPuiXj9FnJu5+gfABHF8J7VfCkgRIw0Z+DLHBpzVP/NN5kmfidCPfD+bvgpwU0E8s2uTXshDeSosHq1wajyewAwcGNC//9IfpSgib93yNlaR/lmLbLKZTp9WN4McPyVkCzHC52Or2Vip/mKpK4T/ix8gfj1VpDzkdTD5/W13MLeKpLsHW2Z+DAzrQJG8KHLm8Mw0J3SAr/9Lid3PJ7v6nqcg5nnPk7Sqz0lnWQdDkj+sD9561++N0oub51LZhT9RxPw/ESizwc41NtieCweAjTBTfh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB7738.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(346002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(8676002)(8936002)(4326008)(41300700001)(2906002)(5660300002)(83380400001)(6506007)(6512007)(6666004)(2616005)(26005)(31686004)(86362001)(31696002)(36756003)(38100700002)(6486002)(478600001)(66946007)(66556008)(66476007)(316002)(110136005)(221023014)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjZSZDJ3TTRCUTdXYzRjSDN2UHUvTTBDSFZOWVhkaHlHSzBSbWtFNEgwWjJh?=
 =?utf-8?B?UXJoOVBWdmxwWkJ3QWx0aHJWcGpwK1NHNktyTUE3enpmQlFLOFZuNmhmZ2ho?=
 =?utf-8?B?b2E1WFdzTnNKU2dNUXNEWHJlMzNKQUg3d1FOSzRGelN0bzlTL0xNMnFaVDJY?=
 =?utf-8?B?VzdBZFp3dXliT2NyRSttOEJ3TEZkMzlYeDJNVi84ZFhyRmRVeW5IeW9FVzJD?=
 =?utf-8?B?RStuNXFaY294bzFkWWhHUXZ3cDg5cFpkaXk1b1dBRWdqSXUwdE1qK3ZSRnJY?=
 =?utf-8?B?MUZaRkJIek9EdGZ2Y0FsTjNoOE9TY09VdHlQVms2VWNFUk5TTVJ2V3BDNHl2?=
 =?utf-8?B?dXM0b2M5T0pTZ0NXbzh4NjJ0d2lOZ2tWcFo0Q2x0Z3FpUVpiS2szcWxXRTFL?=
 =?utf-8?B?MjEwajVKNFJvcDBwZW9EVmNhc2R3aVZqTkliVjdjdlpoY1JkSS92VTIvTVhz?=
 =?utf-8?B?d2dNTUVvMURIUldCUDVrL0o2YUJycHZ3RXd5aFZrTjBZcFE3aHpMWU1NNkxv?=
 =?utf-8?B?QW54YzJUUUtHTGdabUJpVEF4ZE9rNUNhTVpTZ0laWEM0NStldXc2UEhNSHdS?=
 =?utf-8?B?WTdrTVE3cEZZUXpyNjZEcGh5TFVndkdzdEo3U3lRYkhEbFNFandJN3ZkQ1p3?=
 =?utf-8?B?Q056OXRyTFdMNHJnek1Ec0FqaU1sUEYrbGlpYmZOWDdRMGd1SytKWDRBc25Y?=
 =?utf-8?B?RmloVTBHY243QURSZmluR1VITGtEQ3hQZVo2NFlORVorajJ2R003UHk2RDRm?=
 =?utf-8?B?NXlaTHJvckpNRVkwbzNUWXY0Y2VOdExEeUQ5NFkzLzF0MmZwb2RBS0ZOS1hM?=
 =?utf-8?B?dTR0b1RpTEJBeDJVTjFiU1RGUE4zZ2sxRDZVc01yMGtrOURFSUh1L3NDSm5R?=
 =?utf-8?B?RWdkUDV4YWtuVy93emJNd1htc0duOWZUeWp5b3ZuMlA2TjdMWXdVOGdIV29C?=
 =?utf-8?B?c0NHRThMZ2o5U3diOGEwbHg1RkxKdjErSzljV3I1Sk9FUEZYT25YMDRwYnFk?=
 =?utf-8?B?d0RxVjNBZHhxVFord2FjNDdPMUpiYVFiNDF6cXNZazZhbUdBWEswTmw1Vk5x?=
 =?utf-8?B?dTAwS0EySmJHMk84QnloeFhPLzQ2VmRNNUx4dXYyaUhDN1RvMC8ySXhWakxC?=
 =?utf-8?B?WDlIdVhBV1F5ZWcvTDBDM3FhSHBhbFFQQ2cwL2EzUldYUXZxdFlqVnduaTlE?=
 =?utf-8?B?V0o2YnlrMXFzQXpVYjkwMHBFMzVVRWtWa3VUazhuYW1mZ3VyY1R1eTd1RExS?=
 =?utf-8?B?Ri9TMitra3ZlUmc2WjI5N3VCWWc4elFqcTdSc3YyNVlETlZETzltM2ZROURq?=
 =?utf-8?B?L2VoRFZBWmJCV0hyR2Z3YnM0SnRNbldwZk5lZ1pPMS9PSGRrOE9LcER1VERz?=
 =?utf-8?B?L2huMGFEdUZ6a3hNM1QwN3paSDRjdFFVZWE0elllTkJBOFVIT1l0WVo5STJl?=
 =?utf-8?B?ZDdGM0pxVzl3VlRoUGRHbFBHcGRyY0ZSTjViMXltbVNLNUtRT0JQVXo1dGU5?=
 =?utf-8?B?ZWtzc1p6RnhZaHc2SlRLcVdWT2gxTW45RkxrZC84RmxjOHRmelJHWENDVGRy?=
 =?utf-8?B?dEtUbGl3NEtqYTlTOVgxQnhjSFY0cVhNQVVqODNuK1dJOGJZZUR5NFJMWlZq?=
 =?utf-8?B?UVhOdjZtWWJEMUxiSmtWU1dGdDlHelQvNGJBU1Y5dHpYLzJhYU1OSHY5WVV4?=
 =?utf-8?B?SnMzL0VoNk5HZSt5b2tpa3VQMzNjMmRzL1BqNXBYdTE1WDRCYWI2aXBEVTVT?=
 =?utf-8?B?YUN3WmR5ZENTSEdod3RteDNSOFJLWGR6VjdrazNrMWRqQWNKZFlyaTVueGp4?=
 =?utf-8?B?cmU4bkFuR04wT24xbytFMTZUOVpLSmdDejV2ZGJyVHN4SjdCc3JhaGtOckE1?=
 =?utf-8?B?QmhDSHNzR0psUXpsMXYyNGJmQjlBUFBYL25VWk9YMUxpaGtDWms1UGFGRkFW?=
 =?utf-8?B?NmtQOWFOSkxlY2pkQkVmRnNEWWQ0RVBjTDk5S1dzREVpdDZmanBkbmdNOGpE?=
 =?utf-8?B?c2N0SVp4Umg4c1JyWTMzMGlDSkhoaGdXd2NFWTdxUUZxckJwbmlNZmxzWnRu?=
 =?utf-8?B?NTlzZ1VGUjZRd0Z2emo5QlpnSnBoNmt0eUZlUGJUR1FHaXkzOUJaKzl2M3ZL?=
 =?utf-8?Q?wC3N0V+1yOkJ95wRRX7OyXAvi?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951feae8-c63f-41af-2109-08dbd3962247
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB7738.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 07:03:17.9433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjJ22DLrt/AAlYaZAZeQPC1IEzMsEQ04BkArKohEe1JOAY5csY74GV9DK/FYCVzok0G6IvwnLCznuaGyfiBZgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7326
X-Proofpoint-GUID: Kw_07J6mcSvd_AlcySZjBcKHl-52vrwl
X-Proofpoint-ORIG-GUID: Kw_07J6mcSvd_AlcySZjBcKHl-52vrwl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_04,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=796 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310170000 definitions=main-2310230062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Experts,

We use NXP LS1046 board and face an issue about the eth interface speed.

1) Scenario

we set fixed link 1000Mb/s in device tree.

However, after we set the auto-neg off, then the eth1's speed changed to 
10M and Duplex changed to Half.
The value of /sys/class/net/eth1/speed is 10 and 
/sys/class/net/eth1/duplex is half

2) Log is as following.

# ifconfig eth1 up
# ethtool eth1
Settings for eth1:
         Supported ports: [ MII ] 

         Supported link modes:   1000baseT/Full
         Supported pause frame use: Symmetric Receive-only
         Supports auto-negotiation: Yes 
 

         Supported FEC modes: Not reported 
 

         Advertised link modes:  1000baseT/Full
         Advertised pause frame use: Symmetric Receive-only 
 

         Advertised auto-negotiation: Yes
         Advertised FEC modes: Not reported
         Speed: 1000Mb/s
         Duplex: Full
         Port: MII
         PHYAD: 1
         Transceiver: internal
         Auto-negotiation: on
         Supports Wake-on: d
         Wake-on: d
         Current message level: 0xffffffff (-1)
                                drv probe link timer ifdown ifup rx_err 
tx_err tx_queued intr tx_done rx_status pktdata hw wol 0xffff8000
         Link detected: yes

# ethtool -s eth1 autoneg off
# ethtool eth1
Settings for eth1:
         Supported ports: [ MII ]
         Supported link modes:   1000baseT/Full
         Supported pause frame use: Symmetric Receive-only
         Supports auto-negotiation: Yes
         Supported FEC modes: Not reported
         Advertised link modes:  1000baseT/Full
         Advertised pause frame use: Symmetric Receive-only
         Advertised auto-negotiation: No
         Advertised FEC modes: Not reported
         Speed: 10Mb/s
         Duplex: Half
         Port: MII
         PHYAD: 1
         Transceiver: internal
         Auto-negotiation: off
         Supports Wake-on: d
         Wake-on: d
         Current message level: 0xffffffff (-1)
                                drv probe link timer ifdown ifup rx_err 
tx_err tx_queued intr tx_done rx_status pktdata hw wol 0xffff8000
         Link detected: yes

3) After code tracing, we found that:

phy_state_machine()
	state PHY_RUNNING: phy_check_link_status()
		phy_read_status()
			genphy_read_status()
				genphy_read_status_fixed()

In genphy_read_status_fixed(), the speed and duplex changed.
It seems like the bmcr value is always 0x1000 from swphy_read_reg().

After revert the commit 726097d6d6d(net: phy: improve auto-neg emulation 
in swphy), then the Speed and Duplex shown comes back to 1000M and Full.

Could you please take a look it ? Can we revert this commit, is there 
any side impact ?

Best Regards,
Fang
