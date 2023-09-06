Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CD67940D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241509AbjIFP4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjIFP4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:56:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FB51733;
        Wed,  6 Sep 2023 08:56:26 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386FevZk006437;
        Wed, 6 Sep 2023 15:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=05S2OZ7UARdb6+jdk9/uTUA6LCh9hh8bkb5cXTDYpNQ=;
 b=R994NQw8skqEnXC+K2E8ulvkWTSAU5QxTRQ3DbEWAyF/CGHmRdNZACmrboBsx9BbN+kZ
 O5naAEPBPxkjRyRs9m6zF5QMsyldZiSWiM7Hd/Lai05m7FYgXZwXtrTPB1jpcGsJLyBX
 Jbsu5CxCj90CCJrvru5siI78ZgYlcbIHPAu/rwvaPtwqGgfSXEvuTZS2h73gB/rpsIHy
 7RoCpNXP4TqNhWMY7RWnpdkcvvW2Dc9EtanbXE7layCBS/YHcF3rmzP0eYh7bVEl/KRP
 AZozCAbh0NJlwsl3NryaUSLeyxdYBmk04D5q/+f1PRN8uVeBfr67EDh2eJ7/5aP61ee2 tQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxv8ug2eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 15:56:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386Fu50a010464;
        Wed, 6 Sep 2023 15:56:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugcpktv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Sep 2023 15:56:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDe5g0gkBichvz+IrCWsb3CXLjyZE0ADSN34Na+hpQEsdA5TEQyiWJH1XC1qZUyaNGMezUSMMB9PR5Zbq5EsdMhyiS2xeMUZbxg+fxPLiYJN6TbcqZnaKL298o5YHgTPButTOmFTNZqb7VkPwgB7BfFFwEHBLoC3zg0f5lMaup6zmTr6qA2iInLEj3vlFak3TwLvFyR986zTuTrR6OoyPBSNcEjKaKhJ4Qr4klqbq4LEDMv23QAxFF3QP2/Jvo/6O4G6nxtWlI8qutOA63Gt+OasiIN1C9Fw4PZp/uoBsX2wfBdtAT7q3XTLBB7WkgnbRid261KiFsT2n/OplNXDeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05S2OZ7UARdb6+jdk9/uTUA6LCh9hh8bkb5cXTDYpNQ=;
 b=ktA4UMrbTD4gyK6a6a2ZHThHQWfTJJUwovRLASXXkYDOBv8+h30A3lEsSR7eKTBQEEUZbfsCm+B4AHxwL+uXJ8Ti7a6LrW2wTz6OQMdjgZ5MK0eluNLPHmTM25aLY/WDH+b4WGNusget9wejI4mLJjlVsAIkw+Akp9KoxkwZNlTb6tOzmTQ99dg0hUM8oqhHO2yol/7+X0EYOD710QidinchxLHcaBJwXT9ahzEsnIjDOKjHBezbkirJMZ1CBT3vubwXCU6a0tnRfcOngtYF/MnDPcr/s+8r8+XAFw5S9/dZxUZbQ840iPltg5GuVDLp4YedRHbCucuGBXofnuebNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05S2OZ7UARdb6+jdk9/uTUA6LCh9hh8bkb5cXTDYpNQ=;
 b=soX2+0dr2V2vW5WChprX9Up+1iTusW3BnkFKOxsGnvitroRYbJozDB/C8NPlaSKxjlOl49HWx4wnF01yr9J+x8YnnVlUkW7cFcfW1sHxLAf93/dTvxsefTB0/WHoTOAh6/cbXBPYNgLKTtifCTyjVHdxQIDLJuZD04qKEt3TCFE=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CO1PR10MB4627.namprd10.prod.outlook.com (2603:10b6:303:9d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 15:56:04 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2a3e:cf81:52db:a66a]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2a3e:cf81:52db:a66a%4]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 15:56:03 +0000
Message-ID: <d0566ed5-34df-412a-82ff-29d56d499abb@oracle.com>
Date:   Wed, 6 Sep 2023 10:56:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/18] scsi: scsi_error: Introduce new error handle
 mechanism
Content-Language: en-US
To:     "haowenchao (C)" <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        louhongxiang@huawei.com, lixiaokeng@huawei.com
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
 <b8350de1-6ac8-4d5f-aaa7-7b03e2f7aa93@oracle.com>
 <7ec75e40-671b-e080-9e7b-2afd5edb25db@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <7ec75e40-671b-e080-9e7b-2afd5edb25db@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:5:40::17) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CO1PR10MB4627:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ece76e-d7fe-4b76-7c28-08dbaef1c60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rOQbm0pyqO/zNmg5pBeaCcLBWVkz1Zg7Qhif48xPBpc4MPsNao5Y8igQo7gupV/wujlJsU5eNWEHjlIDFPfcX3Fo8Mp48lWc5u1Tx1sIDZUs7egbCY5U67p3oSyEaXbt3GEWB0vCMjvRlVMW1jeOssTB0OrJ9tOFwd1wpw6XeiZB3mginGbbZd8dxq5zV2Q1st6jNAGLe3QsBvB27Voy8lcGpKpRy6fqnBjW8oiviFceTbk51ryD3JsfF56W26ugb0Qk4MZFLwIRU2UD8+PDkgf+vK4e+uY+CX4LbwZmDe6XfV6IkBWvVOl1KCbiBXwdWhUl4nDM+h2CLc1hfzVVd13/DsD4bFokTGsQcQj7nQaxQlqUJXPhT4UpuaqMdxxNns/syiW/+aUCDCKfQnUPQ35m6zk9Nf5G2iO7/vdZXVesGR7TaUS/1jc6IwGSroNrl8dwSRg123MuvSUKy2qbrxwzt0bm8dby1SLKOQXemRdxjpdYMIPAyEfzS+Nw5UAqLxGFwEcvGgJgkpO1r08WG2+tW7R7Za33AKAFWarVLUcdiFeSrI9ZTcYZhigsw6nlu9vEhijP4nBvy52aZiUjJ00yqfGk778WtCl4qSJ/iQjd5zF6oPihri8rl0nPDoSBwHBsiDZ8bmTfELukclIqSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(346002)(366004)(186009)(451199024)(1800799009)(8936002)(8676002)(4326008)(6486002)(41300700001)(316002)(66556008)(4744005)(110136005)(31686004)(5660300002)(478600001)(6512007)(6506007)(2906002)(53546011)(26005)(66476007)(2616005)(66946007)(66899024)(38100700002)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzZ0SkpvNm1iSXozT1h3M1ZpL3d0Wkg4cUFCdFRoOXlSWVp2SnBaN2llbzVa?=
 =?utf-8?B?Y0JSNUgxSk5wYWptbGNtSEVKTjQ3NDdhSUdDYWIyc2tXdHpVVVlGOEQwcTRw?=
 =?utf-8?B?V1d5S1JNb3NBTXBScFNZbGU3OGdZejNUdEhMcnAvZDFsZ3YrS214dkRuelhC?=
 =?utf-8?B?M05rVy9IQmJ2a1VwSzZmOEgzVVZ4WHlVMFZHeXIzTDdvbjRTNGt5YVk1WGdZ?=
 =?utf-8?B?dVdvakw4TGpOeXNuT2UwNnI1ZzBueFhSQWs3TkFvSDJPbTh6U2xnVUMra0s0?=
 =?utf-8?B?eHFpcU9nWjV5b1h3UWFoYnVQVXZPeGVyVE1LVzd2SzR4WUc1bVprclR2V005?=
 =?utf-8?B?STVtTUVwbXZBQzMyaDZKUlc0bUduS1ovczl5WkxiYjVBZnE5aUE3Y2ppM1VL?=
 =?utf-8?B?N3FzTVJyRFB4azArMzY0V1dMUXRZRnNRM29jaGV6eDdCNDQyNDFvbDVyYThB?=
 =?utf-8?B?Q25iT1ZIN3RSRk00UU0ydlNXWTBwd1o4c2F2UFZiRnVKM3V4VkNsaUpENEVI?=
 =?utf-8?B?T1YzdjdnS3BBTUdINy9BbzRCZFRKOXhOUEkvZVBJYU1IZExEUE5RdkpEU05q?=
 =?utf-8?B?b1pSbG1pYThFakhtSTlabUNaZ29IVEl6dDViZ0NKMXNpdEVkSUxXYmpWTGpv?=
 =?utf-8?B?ZytjdFduL0VjRklzcWJ6MWsyMTBZZ3U1dWlTSE1Fa05scXUzRWRId01LOWVy?=
 =?utf-8?B?V1AyQmh0dW9MTks5dStoUGhCY3FvWUR3LzJIUXBoOHNtb1duTlhWWXF5U24x?=
 =?utf-8?B?emkvTUJCRE5zUDlBUXkvTTM0ZGlpZ21TK2xaSjN2Qzg0OXpsNjJhWDJBS0xt?=
 =?utf-8?B?VlV6ellNOG45S1dRbGNFcFJSU2kxZjZCTFpBekpRUjRBYm5HSm5MVFhTK1ZF?=
 =?utf-8?B?Q3RkdjV2UWRFdHVzMlRWSjBZMFU5NFNxcXFEcWwrMUNpZTZ4WktjRlltWWJt?=
 =?utf-8?B?MXBvMHBvNk1KT1pwOHdadkVKcjVxUTl5WWFiTmVJU0dyRUEyek9GbFBHcmVL?=
 =?utf-8?B?N2dxS3hrN2U0NWxORXpRM2xGcnYvZ0krR1dvYW5RekFkN1p6WjhHUFhqT29R?=
 =?utf-8?B?bzN0SGRDYzhKcDFpei90Q2xXZC9iMnNBQjhHdlJ1ZjBIWTdDSGQzdWVEbDRH?=
 =?utf-8?B?ZWRoai96cVdKSW9RNFdQeUhKQTJIWm5pQzY3ZFFkc200MEVVMVBQbU1YQ0Iy?=
 =?utf-8?B?N21JMnBiLzBJQjJyZkZBTm5SNmROcVpiZDVoM1RmVDBaV3FZMlUrQlhvb3dr?=
 =?utf-8?B?eXVEM01meTVlbzBsd0xrbWIyWiszd2Y1MzNnTitxZnZ6bTRydVJ4NmdaRTBH?=
 =?utf-8?B?cGFyWGxEMmF3dm5EdXBjUGx4VW9uSUkrZyt2Kzl3bWsvU2VaaVc2azUweVNv?=
 =?utf-8?B?REVEK2FraFlMZEQwMXpEYS82MHJPOTZpamtVREZZMkVGT3JzUmk4K2ljc2tS?=
 =?utf-8?B?MUs1eGJGb2VqaDVSbTRsYUlhZmwyakFaZk1EMU1NTU9MZ21jc2k5TmhVU1I2?=
 =?utf-8?B?L2hRY250eWN2Q3J0aURjZEpMZEQxSnRjZXdpRVV5SmNWYWRyOTJaQXd0K05D?=
 =?utf-8?B?OXlkeTBxM05IWmRuQVFRWk1Pa0J0M3V4empjSGxrYXkvRnhLV0RjbXJ4dWlu?=
 =?utf-8?B?Rnd2akw0b0FQUzVoalRSV0tyM1ZVOW5wUWIzM0FRRFFlN3c5RDdKREJHNDM5?=
 =?utf-8?B?VXZFUlBWZ3hTTkJXTDF1dnNzUkR4aFpHTXF2ZW9WS0pUR3gwU1lDWlp3YnVK?=
 =?utf-8?B?T1VpRmlLN3J5dmJEdkJuZ0dmWDYybGVyMFR1NnJVamYwTW5pdUhXOE96L3RV?=
 =?utf-8?B?Z0RsZWRLVGhIa2NXUGc2Nnp5dmFLZDJnZ1Y4TEtNa3IrSGlpdGNVVTVmRk1l?=
 =?utf-8?B?ZmJNSmw3cFZDVmJzb0hkbmJjaWcxeHhzNFlsVUUvckt5ZUNKM2dzQ2R6LzdM?=
 =?utf-8?B?dDhRYUZkQjZaMlVsd3RpVWgvNjh0ZngwTCs3SE1lV0RFbEw1Nkw4dDFtcFJ6?=
 =?utf-8?B?dWowVnc4WVcvZURXS01MeHdEVDZsOVVzejVnMi94aStjTXpLcUlWTlkzTGZP?=
 =?utf-8?B?bUg1SjllRzVMTWtCNTVyYXRVWmtpSHFDU2psS3ZzWVduRWFxK2ZUM21adDk4?=
 =?utf-8?B?MWp0VG9LQ3ZWRVhlZFg5bW56dFRwVWptWTc3TkRTQk05VmRXK3M0SzhIdTZP?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UqJYYDBnwbh+XCzI7wMNTJYGE+EBCMMgN95WDnlIghDiKA1Up8NDyoBfuNTdUWNcxyRTexoAODiRESjlvwyCN4HMqDBW+mjUUl9MSyz253r1VXFYtyAXwoo7BuSdNLRrN0K4NhO7TznwYBUZXx13LxgxsPyojipvkuvOylwWCrwp8jNs1aoDnSTaKoDgXjMUNpKQLVwo8Gccw+pgi5v07N0vdIn8FeLsedgQ9fv+JOhqqycm8f0lXyDWNzKg5aaJ3iKRuyDqwO39iKR6rO8llOHTX9dWowg2x00rcrLA7Qsw7ZmMHHlyDXLtxgiAqNVvqyLla/gG6YogTomm54BRihlpHF+KpSROmOEPRpMzaO1cOCqDo6fItKORWT5QgK3cOtm83wRhKH97JNM/zPW2wD7yhy8/txtdV3AGTYyjwrAl1QyNWiMhje9Su2tKCkfSr1U7u5IVF9UB9RzN8W/jCqagmEFlDH1xzdeOElbtuDMaoqhNNFexQ2Q24+oJZ/1/jsALneE0pkN3a1hWhHh7dGx7bnVWdUBKpznk5SQG9OxFrAXQ+aGCPw72f4C6Oz62481YfpucM9Agty4uBU2zMLV/c1NWS97NXLQZuRPT123hFfulUAuY/CreuhmHVCFkkB/+iaOW2TOiRcmIP/oDseXK670zcDRMBGjCInmYU7nweB1/oZAOiph10gdEQbwm3uH2PzSXmhYzZlMVL1KxQtwIZe1sEJ5vn2gOfteZxBurPoF8yjUIC9pssVmR3vQ0oTrqwHN40umAuuza7PZ1Q4nCcSjZExzMypiCphfn6qn/2wuLznzpzPzXZIooKHhx71+Tuv2QdlC7brce42Yz4Nb/zFCEk3ToDEQ/W+EAFEY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ece76e-d7fe-4b76-7c28-08dbaef1c60b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:56:03.7275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nv7SEOYlCDb3TYA9Wm5CuziM/2D7VyHMTqwJDICwnCyHZ6Ah+GMPWH456SpmXcELWKavrttU1Iumz6eLc9yL8wgGF1CCqtpPu4DllaeueuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=971 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060138
X-Proofpoint-GUID: MKinv4t_iM7dlSWpxH3vsWB6jcmJoBnv
X-Proofpoint-ORIG-GUID: MKinv4t_iM7dlSWpxH3vsWB6jcmJoBnv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 6:15 AM, haowenchao (C) wrote:
>>
>> If the driver supports performing multiple TMFs/resets in parallel then why
>> not always enable it?
>>
> 
> Not all hardware/drivers support performing multiple TMFs/resets in parallel,
> so I think it is necessary to call scsi_device_setup_eh/scsi_device_clear_eh
> in specific drivers.

Ah shoot sorry. I edited my email before I sent it and dropped part of it.

For the scsi_device_setup_eh/scsi_device_clear_eh comment I just meant it could
be a scsi_host_template field. scsi-ml would then see it and do the
scsi_device_setup_eh/scsi_device_clear_eh calls for the driver. The drivers
then don't have to deal with doing slave callouts and handling errors.

Also for the error handling case I think we want to still proceed if
scsi_device_setup_eh fails. Just use the old EH in that case.
