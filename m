Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAEE7DDED6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 10:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjKAJ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 05:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKAJ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 05:59:22 -0400
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA575DA;
        Wed,  1 Nov 2023 02:59:16 -0700 (PDT)
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A10bnrn021533;
        Wed, 1 Nov 2023 02:59:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
        message-id:date:subject:to:cc:references:from:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        proofpoint20171006; bh=0G//Jp8fMJyz30WsheN7gYCXM0qpGyufXOk0uhrOc
        YM=; b=ZymSuSruwJ4J+5y/s5iK2VSG1LipK1KFYmPWYiDj6bHZpPSKF8gOKoC0J
        sP0zL7L8KdYrlwEN9Rj47WqrVdZxePgzff5zu76o0L1IORA8zTa+xMKjf4kcDCwp
        E18/olNVsap2Tqkw3Uw7ZJ0OLcDY7LN0a7RCpfuP2yFEvJp8G3MxgKf/TzRDu4/l
        Fj8lwfaxGPwlK/BEjifozuyUZGc6s9fqv/4TzyjLmGXShoU+DpYrI56cj02PeUZD
        d8dlf0TZ2Nf+smU/WNOguNb8w7kp0Xcg8xf4zXAtMYqj12Jo08rpXHLthMzPY1SE
        3opN22TKun/cBkoNpjNGXjD1kk2nw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3u11cd7eh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 02:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+GnxLrf34iDrPWgxRG73Z9YukqOihbAvMVIITcInA5kZkGqa8H9pWszlyZFMjehLSwetcijZv26Zks2PouCAyRvh4ljIixD/QNDNOKXQl2dHR0ZfgJfEb2LO3RCYUnos66+3sCq0HQFsqTopAMThOTm5qQIOWjf/EQm7Yzp0fERIX9jg2MYi8Td3d8YGI3tW8fv1LA8u+Cf+gu2qTB71m0prLi6mLINNYEKRdh7/8C8QWaXNH02wuFIwuyK7cwh42zNr758H1GGoey090vUniYoj3o5vPENn35xXV465vLBlI0Cw1Ffi0TryYacp2ky/4bpwVWvLQ1u4RNE6bs0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0G//Jp8fMJyz30WsheN7gYCXM0qpGyufXOk0uhrOcYM=;
 b=ULxaNGVuE6+syY0IExAjkYegAH7za0wQDK4rInsk5Qf3seI2iDALRSF9OXDmpjrACT59jhBCDm+K+cImvlxe+qqkC9YB3jDFgwAHz5U2kxocA4UvN2YH1tNJ5pMQQM63VOqfjYzIQpb8Cn3BSw4GKgsvpYASPFxu8tDc2FU+I9I3S9ZjelmK577AlpTtLf4NaK0RqUxXcs+w9mNMvj4HY2VrQEb8w3eWzHXECIvRSb6GQUE1Zi+dOfJjQD8U0kLa+GRKvYfQqISMN/PJBIs94A3Ga7GwnrSmgbdQ5k7sNQgyFoUPxthJ+Bzyi7nwNXcZ6M5Qt0UZ+R7ezen+T5Rizw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0G//Jp8fMJyz30WsheN7gYCXM0qpGyufXOk0uhrOcYM=;
 b=uiUDE9ReYVBX057npxQx5surXMNOQhcJPiMCr1wqqsFWsnDp1+63CxdEW0BmCiweilW0NzeSY68oFk3MBhG8waKiDWYg64VcnFWwQ0ssOjVeRxnikoOPoW26Ij/V3yG3lG03UAoBiHokwGlrgmqMhHPUCl/ohErM2Bjj92g94RGj7wNJlfAdjehEQmVousWrSV8TtaDP80s7CABd8Y56C8tc4+07TeYVQwsXQ5y95zT7nAk0B2TVo+zuHdxoSdUHsyxqSM+DJXzdYlLLnVHcsWC0PA1y5iWJ9X4nOw7tS6P9VWy72MYHvt+JphQ/rK2oUD8iQvT04678mieFlZ5qEw==
Received: from DM5PR02MB3830.namprd02.prod.outlook.com (2603:10b6:4:b0::29) by
 SJ2PR02MB9368.namprd02.prod.outlook.com (2603:10b6:a03:4cf::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Wed, 1 Nov 2023 09:59:09 +0000
Received: from DM5PR02MB3830.namprd02.prod.outlook.com
 ([fe80::da33:a5a0:a73c:be9e]) by DM5PR02MB3830.namprd02.prod.outlook.com
 ([fe80::da33:a5a0:a73c:be9e%5]) with mapi id 15.20.6907.028; Wed, 1 Nov 2023
 09:59:09 +0000
Message-ID: <5d398909-ab9c-4837-a71c-7bbf5a8df013@nutanix.com>
Date:   Wed, 1 Nov 2023 09:59:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] audit: Send netlink ACK before setting connection in
 auditd_set
Content-Language: en-US
To:     audit@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
Cc:     jonathan.davies@nutanix.com, linux-kernel@vger.kernel.org
References: <CAHC9VhQBV1mcFUmXQs1-VKpAVdaAQ3EiGk-G3ybxfcBkoKGwcw@mail.gmail.com>
 <20231018092351.195715-1-chris.riches@nutanix.com>
From:   Chris Riches <chris.riches@nutanix.com>
In-Reply-To: <20231018092351.195715-1-chris.riches@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0180.namprd05.prod.outlook.com
 (2603:10b6:a03:339::35) To DM5PR02MB3830.namprd02.prod.outlook.com
 (2603:10b6:4:b0::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3830:EE_|SJ2PR02MB9368:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a348f27-5b84-42b2-6543-08dbdac1310f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xduI86p3qXp/pyXd3yD1qOtPLsV+13xAI68Oxv7nf0uQ5IFZwXRhuuFsipe1J/90CEwMe8Jgtp9hO0SFIWv9dcAn2Dh9F3Iwoy6XXfeYoiQ4sOabqbpSXyx0TygSxmPOyVD7UCM4goXzgCKvioAeXwv4r90g6aMtoOEE5zw+8wtBlS1t+43JLWUYpYP+rkT9ad8pNTp3QAnrht7k9uWg542uJYHyUa2v1LMRcQFNIxyf+2b5+aB07QiWVjvBY5uUtAdgVIr9iFLaMlQLOU1FiSI1Ie6DAMBJ5vO48G1JUpEDuTwZroRQ0fwEi9hMR7jsbdruWZyRDiU1ZWJqlDyh5DJGCUJ0jy+asa+FL+Px452y4rHzwfydMSf5CkFjdgHJA/xnOEkxwZ8ZNaPurwfAIQOvqU8bCZ5qZh/gnLEYDTP03AcZepf191D7bFOmfbS7C7zanLVdZkHuZXfY8eKuBXvG7HpUKrcuMIEBogqOyjgNU+OJlO5SFIwrOMOkRbh56NEa+gxk4gPDkE1EwE4ieeSQzGAFLAg2/g9FVZzcwApg4DCD0DJhAp9WLFJove2XZs6O3eedoxWqc9XUFb7mOWvxXOv7rHOxqtjEqEKpIiZMxKrcbZwX0jh85ZwM1iNzZLsBWvCwskeRjlI+EKT/1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3830.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6512007)(26005)(6506007)(6666004)(478600001)(83380400001)(2906002)(66556008)(41300700001)(66946007)(110136005)(5660300002)(8676002)(6486002)(66476007)(2616005)(316002)(4326008)(44832011)(8936002)(38100700002)(86362001)(31696002)(36756003)(558084003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk8vVVFKWjFUR3IvWmJyQzNvY3Q2WEtUekl4Um80bnhYWTFFeGR2MWdUZE54?=
 =?utf-8?B?dG9CR2p0Wkh2cWdTN2NiNVlKSU8vazdjVWxnMTJ1OFdVVW1wUURHVTdabGJU?=
 =?utf-8?B?cjZvbndmT21Qb2RuOFk4N24yV205ZEFrSnlGcGtIRngvNkFKZU5OMnNhQUJZ?=
 =?utf-8?B?eDFXTTJFSC9VZXRVRlltOHhCdWxkRG5ZUWwzbjlRQ2NlYWtTMEExelpCZm5K?=
 =?utf-8?B?b05pNzhXZUM3R01VUDdlaTBlQ2JmOUJjNDhxK3cxL0dIWks0SkhRZTBiVEF4?=
 =?utf-8?B?V1BGNnVROHZkeU5PWGR3bmhVazE2WmlXTmEyek4vZlk5OXpvMDRpUWx3QnZU?=
 =?utf-8?B?a05NYjRsVFAwWTlqNEV5d3Nab0M4UGdMcUx3S1duRVdTNm81WEliTWg0ODhj?=
 =?utf-8?B?WmZVaEMrUVZuRW96d3dtUW1WWDhPWXJ5cG1PRGlwZDRhb21WaGVpQXRZRzE0?=
 =?utf-8?B?bEgyU0FYL3lVMmZmTXRHWkduK3hKNlo4bHdJRFJLNVprRERpbnVRU1dtZzFz?=
 =?utf-8?B?cWpZUzJTQVlKTElqaThzK2l0SGk4THVoMGtGVU90ZTdxUUFjYy9naXRNbloz?=
 =?utf-8?B?OCs1WHA4NWF4ZUUyeHFUd0drbVpleTJicFVmTmhlY0ZFRW4vc0ZaeTZWNWdK?=
 =?utf-8?B?b1NMOWpwRktHQ3ZzSFNMUkdYL2xJbUdvWU1waUJneVlnNkRyVE9RelluNmpJ?=
 =?utf-8?B?eWpKaUFhbHdVL3IyOUVMSk5nSXNaV1gzb0JaWUhTb1hPMUtpelFnQkY0T2VH?=
 =?utf-8?B?am9JVGhPNGs4dzIxZGpMekwzRUNhWDNHZ2JSRHp0WC8wMitpbGhIWmpEMndT?=
 =?utf-8?B?YzBGSjZlNk02TVIwZTVQM2FQUWt0TEE3ZWpRN2lISXZVbXA0a2Y5ZytTZCtq?=
 =?utf-8?B?aS9zRURwK2w0T2VURkxiRk9ldDhya1ZpS095MGdXRWdhQnRZZzE3dEV3MDZZ?=
 =?utf-8?B?NWZHUmdzWlVlUHVSRTV5ZHI1UUlJcThyYldmdFEvbTdBc3FrZ25MQUxvZGpp?=
 =?utf-8?B?dkMvTTl6ckZGQkhtSEh0SzVFWDZhUGZ2YiswejZEWVpZMTJWd2toM2E1dHl1?=
 =?utf-8?B?VlhtbWxMUlh0ZnBNNlEzN3ErQ2ZIdlNDSVJsZ1ovYmxaK0kzL3NkeUNPdjd3?=
 =?utf-8?B?dkQ5MHc0aDE3MVQ5bktFeDBDMHpUakJsQVZMd1JtTktxWmFwL25Zd0tNM0ha?=
 =?utf-8?B?WDF6NUsxMjEzRU00VmU0eTNIdjJOUDg3MllpNzJaZjVvWitka1VZMGtXWkNo?=
 =?utf-8?B?VWFXR3Nhcy9VYW9QRkxkbzA4OWs5cmlvS0V6aDlCMnBadXFtWU05ZTlWZGhM?=
 =?utf-8?B?L09hL3lzZHlOOHV3TnVqeVZmQXlGYXNOVmZYR0ladFNIMk9NaisvbXQycTI5?=
 =?utf-8?B?WEN6dHVHWkVFSDRyWFZSU2lsMnJKa2xHcXE4bEtyL09lM3B3NmRjeit2NE1t?=
 =?utf-8?B?aFlBd3VpK0V4OGhUYnBabzEvRkl5QzIyTU1OajE1MkVMOEw3YmRtWGFiR3BI?=
 =?utf-8?B?c2xkU2FUVVJIQ2tKSlRzRDZ0RFNsdThxdG5jRVZPdGNnTmVaMW45VGJWNlBF?=
 =?utf-8?B?cVNLZjBxYmtxVmtHZG5PUlgrWURQNDZaOVJzTDFGWTZBbW82dXEzM0hmdm90?=
 =?utf-8?B?NDRPZTJ2RWxURGVqSmVWN1lKK0ZQdVM2NFRqQmZ4M2N1MEFWYzJFNmYyeHlG?=
 =?utf-8?B?SE82YVU2SUYyVWw0UnNVWW91QXgwRUVDazlqUHZzVU80VW1wRkF0SkNHaFI5?=
 =?utf-8?B?RzdxT1hiZnd4V2t0SHRPeFdxNWplbk1YYkpldWRlVHI4Tis4WEdVOU1tU01r?=
 =?utf-8?B?bnppT3prNHJqcTNTSkVjVGo3dDRnOFkweW1CQzBqQkIrOTlFQVVieWhxbkNO?=
 =?utf-8?B?WkcvcFZna3l1aXYzWGJ1Q3Q5ZTdpbGNDeXI2cVpTMHlYRW10VEpLOVYxenFP?=
 =?utf-8?B?VGVhS0JjYk5VV0JVb1pRcW4ya1A3UnFTVlhVd3lBSGRSc0ZsT3ZOaXpyRXBQ?=
 =?utf-8?B?c3RqWUluaCsydGl4ejE4N0Z3K1prWWZvY0dhZWpweEQ3TzdvMElUQ2dmNFR4?=
 =?utf-8?B?UzVXcnRRakJmaG9qam5CTE9hQ21GeHNmTjlLTUxRTmF6dDlrTExXRVI1a2c3?=
 =?utf-8?B?UTF1NUFaSVAra1pUQWlXc29CNSsrb1Naa0hZSXQyWlBYeDEyY0JybVZXOTZP?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a348f27-5b84-42b2-6543-08dbdac1310f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3830.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 09:59:09.2709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flbQaMCxBUXIYIi5/IJT+kFGY9n+U5IWBoFYWcRLGlrkUFvuspsaD7Zr6m4pRKar/DpDiXXWSuff7jURb0wJZE4cRGqWzJWmQEF2RkE4D0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9368
X-Proofpoint-ORIG-GUID: cPRyk4v0bdrK9z0g3oed-NwI6sAJvbJ7
X-Proofpoint-GUID: cPRyk4v0bdrK9z0g3oed-NwI6sAJvbJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_06,2023-11-01_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Is there any update on the review of the v2 patch?

Thanks,
Chris
