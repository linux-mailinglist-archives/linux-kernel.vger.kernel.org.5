Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FED87B3776
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbjI2QER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjI2QEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:04:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9BF1A7;
        Fri, 29 Sep 2023 09:04:06 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TEiIXd005451;
        Fri, 29 Sep 2023 16:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=tYSlLBZysxPl9F5Ti2T+9hJwF/EstlXSYZvP2/kbTsc=;
 b=e8jVfk2rMx72raNr/H7eu2wR8yTvOH3HqVkk6UWL5+K+Oh5BLAyyAzx3sgut4fH4/HQs
 FeSFqXPG6JbW5Aq8HTqorXrHDwSfz+dxtE9R38t/X8cfw3+PvMtrUQDNBImez3dNFcD/
 iRjNV6pPkXT6s+zZgKSgMPtnGUHW/KFfcoljSYbpB3Q8+ZDgy4z8papLlESzLutE/ANs
 9KchhY0Wy3SP7dBD+qVjQ12TVpqsYCK0nwGP5eyy7cQbvpNQw+x6dxwZbBe2DZBcI3yl
 oqmpJQbz0Rrhkazp5uLRnTDuCeENxKRycgJVhvdqDBfJAFculxssAEvgFJ4nEtj4C0TC kA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9peeex8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 16:03:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38TENQcf040728;
        Fri, 29 Sep 2023 16:03:57 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfhsnv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 16:03:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=my85tzxAJV5ffLcq1ZnX0j5+EW1Kj9YOUdmJaJDItY3eHZ7N+ARVLASIwKPXEJozxYayvAVNEspyuGP3vYQkWgshe8YNVJiogigcSdSv62grl/sjNHVxYkfEaekNtW574/ncaRI7jtubQd86mhMSg9IUTQqg+e8jW3QOv301Lw1J2YFJmPqmfQYgLVDviMt+svzGijNw5MWqu1M0DsEmCFtPP9tI8hG9024vkIxPobkzvV4FUKpkwE7xOUivtXzeKzEGsOdyYcqKehVRZAXvG1OkDzDvXdRlbQw2MjXeH8QSqYPzdeVYFCSQti6SbQDsdym6KpDLmp0qBudrzwL12w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYSlLBZysxPl9F5Ti2T+9hJwF/EstlXSYZvP2/kbTsc=;
 b=LV3+KpPAMgvaWrStCyjsoQnmxRAkWzH6Y8U6Cnm/bO7PRSHIKGYRBiJkeS5CfWNT2DQCzIZbDM7ouVZU2S8raCfcNaF71m52PZWL2VvHJieZhurTNyuvnx6br1BCKDKsLpBrd9dTpyET89UUGoiFEC3iENUtTEh9PGeIsVvn1ijLPtrIVBvZk/1MDDNmGoqrxNy4TttR+oeZu4QYp2FNXIupnksu5o4acE3nP4ny7sjSNDp2DFjsW9mAmPVXjtMvz/rlcl2KbvoYVKeKTnQwGQJf80VWXyZ7YmfIm+52eDxM7Yxdr09gg8GjUln3uK8Myqj2CT5PKbmg7x/5pJDsZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYSlLBZysxPl9F5Ti2T+9hJwF/EstlXSYZvP2/kbTsc=;
 b=VdtrDuA6qRTF7jaavWWFEfZE54i2YiGcDlm1LhM+pIuwh5d0uD4553VHb5gYDt55MXLkmn6m+cwrWVVM1Dv12/551fN9dEOP5KiuQ4XF0fn6syIhaubBR9IvRPWUMe0+UTIj6YyzKbHohjXVbWlC75lpfqlENE71whdDe0wtX8U=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH7PR10MB7840.namprd10.prod.outlook.com (2603:10b6:510:2fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 16:03:49 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::37c3:3be:d433:74e8%6]) with mapi id 15.20.6813.017; Fri, 29 Sep 2023
 16:03:49 +0000
Message-ID: <b3a5e717-90ab-42f8-8fe1-4a24fff404c3@oracle.com>
Date:   Fri, 29 Sep 2023 11:03:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: qla4xxx: fix potential deadlock on frwd/back lock
To:     Chengfeng Ye <dg573847474@gmail.com>, njavali@marvell.com,
        mrangankar@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, lduncan@suse.com,
        cleech@redhat.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230928145401.32918-1-dg573847474@gmail.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230928145401.32918-1-dg573847474@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::19) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH7PR10MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d88d0a-21a2-424e-fb72-08dbc105ab4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ElQ6T5sDZNVQBkfTtAr0W0u2Cng89XGqyxitH5KtcWwC+jTFeHEJXF0jx98W6GEbazMkcgxbuywyBvOVsMl8UaLYul7z6zvGThxIkioD1+vBPZm3WJdoV3/zl58MDg+nwbPFzKJ3c+0eu8o/GG1AYgzXJsh2jiTgjifxOtKJDRxgQegyneSgmSA4Nh03p3cKMBv4AZjtyQPeYU3zY8XJJ7YY0D5Exee0zA+xaisW/RK29QMp3q4gz5c58hRzqRwg/fEVpMZWqZHpKJFjhDHlbR6sW8/Zb69bgfX2nqQwNZugyhwJhT+nEsOn4ACoC30DrFb2tCQ3X5weytio4M8NImyC3U6qdeAHpyFqfqWdz88pvrCbN/oDI3YfLEmLxABph/qRoZlhINB3/ALnEZ0req0RId9GrmC++9rUkbXzVmY3DnXqrXHwv1BXc5M4VfIuEdf1GRk8C8o8MfVnQhO+5t+gyBck7ucjeTmP0ZkKaHdidjbcdrQX7AE5DL8ghkJNJcr/HOE4f9L6R2EKUv33nqLNURkwOSoj31fp94FnSETZwD9NorR9rk07kKpi9yMmNMkeKFwHWXwd/ROBmHAVyfsVZuKi/D8IHJ1WjWf9aLejabzos2w4UT90Vmpfe5+kml6awTWcpDqSZWqR4gest/KzHyqdYi6fmih5FgBMExg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2616005)(53546011)(6486002)(6506007)(6512007)(478600001)(83380400001)(26005)(2906002)(5660300002)(66946007)(66556008)(316002)(8936002)(66476007)(41300700001)(8676002)(4326008)(36756003)(86362001)(38100700002)(31696002)(31686004)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LytoaEpmUTFSRmxhdXZndUE4UGVIelpGUGEyRjh3YVdua2l4Mi9mZHJyZDhM?=
 =?utf-8?B?LzJwS3NtOGRhVUF3WGVnWWNWdjd2Ykh6blZpeXQvUndaMWxmckQwaDB6T1U5?=
 =?utf-8?B?WHpHOXBQT0VmMHFGZE8wM25aVUFjU2tZNGJHcnRLOERBN01PelhET0JPQzdi?=
 =?utf-8?B?dzZlREVHcVNFQS92WmFNaDM5a0w2YUY4ek9SV2FDZS9aM1g1UG5yMDhZdHV5?=
 =?utf-8?B?V0VHTDlVeTNxVGdPU2pvRS9kaEx1bWIra1JPSy9Jd3lwS2hMWTNGSVgwMUhS?=
 =?utf-8?B?eUNvM1lsZVd0blZsYytxRGQ1dmk1eDhCQ1RRQzlwOERUek5SclhUSTViWDIy?=
 =?utf-8?B?ZzdtQTFkS1NoUm1sR2pMbmpFcUZ1MnBYZGk3M2czeitkd1RPcU9BUGJadlRM?=
 =?utf-8?B?M1B4N3B3NEZzSng0Sm4wZzhaYXNyeWovV08wQlFqTlRFZElJYlh0dGJpUitK?=
 =?utf-8?B?M0VvZ1dXbVhWUTIyVldMZGNzYU0rSEJQaGRPc2VZQWlrdFh3eHhheHZTSWpz?=
 =?utf-8?B?RnBhNWlxNERyV3o1VXRSU3NvNDBpVzd6QkRKTEU4cnJkRlZIaEhyV3EyTm9H?=
 =?utf-8?B?bGJrOGlCMmZWQkJOT2RJMXdGYThoSjJ2Q3F5end6Z2NmS0tmdW1CNUhxWi9l?=
 =?utf-8?B?dHhHSUduOEY4R0t4emgvcDg4QzhCL0FON2VTL0RaUVBRV0ppV1VVaWNkK0Mx?=
 =?utf-8?B?RG1kTVBpME12MTJPQStTbGxhd3dYNUU2UzhtUXJnNlhTa1hUZUYvaUNnc1FX?=
 =?utf-8?B?cFdNSkd0b3dpMjkvU3BhWG1jL0hrWXk4OEI3bEZrWDZLM0dBZkE2UWRLYS8z?=
 =?utf-8?B?enVjY3lkb0dGZFkxOHJTbTljVzhmWWs1LzFlQTZFRzBsdTk1cGVYU0hORTZo?=
 =?utf-8?B?VEZKK2ZzZEh5L2hEbXFqWFYzc2FucHJqTnpnWW9rWEJRREpYR0psdTJ0QzRR?=
 =?utf-8?B?SEZzUHdISXg0MWs0LzNjU0huK0xIOEt2UElYb0NPVE9sUEJHSER2Uk15UmJZ?=
 =?utf-8?B?SmZ4Q3ZuRnFpTUVCYVJoR1N2V3hCYnFTV0p0VlRhZDJuTkxxWWtad2hIcjZD?=
 =?utf-8?B?WkJEQW1tcmFTRFNibXFacVRyRUlKdjVnRU9TcTdkd3E4Z1dBREdDd3B0VGZU?=
 =?utf-8?B?Yy9kaGlDblIyYlNWWTlvQ1pPV1BGdFJudWROKzI3Q2QrZHgzSmxHU2pFMmNy?=
 =?utf-8?B?YzhWeHZFMkEwK1RFVUpjVVQrajUwa1QxbWxlR2plenYyRFY5K294T0RTcHU1?=
 =?utf-8?B?M3dybWg1Nlg1cjNxMEw4RzlISnM4TFNzbWh5MUdLcmlGOTNEeldWTVoyWTg3?=
 =?utf-8?B?bXFWVGd2L1B4eW9FejVvNDFESytkV2Zob1dDOUZCUkErSUpXSGNoVUhkNHdM?=
 =?utf-8?B?cXNmZjlqR1NXdnM3KzFYQ0xSMW1TbFdDdlVxd1NUZm56VzNCSmdDVHBqZEVw?=
 =?utf-8?B?NXhlSlErMWpOU3RyOTJzL1JiaTlaYmhPeTVCb0dzNEh3V3ZtS013T1F1KzI3?=
 =?utf-8?B?SXA1cmpLcVVQUTlqZVMyWXQ4RUlka1BiUVRhR0tjRnRVc0tScEwzaGYwc1NW?=
 =?utf-8?B?OFEvRVNYd05jUVpjMlkvQ0tvMytGSm5GYVFNZ29vQXRMeVF2RXRFVUZwVnpP?=
 =?utf-8?B?dVoybjVhKzNVd1F0MWUyakRETkJUWTh1QkVyWlI1YWlvSXFsQ0R3bUM5ZHZR?=
 =?utf-8?B?SVplVDQ5eWpiQmtoL1FRc1dnYUd1RFcveWJYaXJOeW5SajY0S1lJMDRtUEh3?=
 =?utf-8?B?Vkh2WEtTdjg5ditWWnhJYktlZzJwN2Z1dEFrelZ3UUVoUzJ4VlRSdzhGRHVh?=
 =?utf-8?B?NkZyRlo5Ky8rdFFOTGVTZjRzVDdNdFRLV1lva0RlaklWOExhN1dsdlA5dFl0?=
 =?utf-8?B?bDBWZ21Ma0tIU1BsSkg3Q05HU05jZjNLYkV3ck44MEV2cU5SbTlmQ0N2NnRU?=
 =?utf-8?B?dVhtNy8weThYL3kxaUg3dlhiN3A0a1huWE1mVEpHakVNdHlLV0VRa1Y1NnpK?=
 =?utf-8?B?OCtSc01jVFhXRHFtaXRodGd3UTdwTEx0THpnVkk1T0JxMU92YnNIaGpoNHRL?=
 =?utf-8?B?MXRNUURBL3l4dHhEK0xnUUVjNjlUTHpBdm4rTFhiK2tGZ0FJMjRyVjd5Tk1J?=
 =?utf-8?B?M2ZlT2Z4eXhXaFpuMDJrSlpRSjJkYVhtSWxMdENTVld6Q2tSTFJKYkFacWZV?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XUtbcieJ0J6bX6jQi4LSrbjHv15SP6ibiaAeUosyb27VIiyWCPgMqOYbIePtEvp9KuiwJilEVBp0vVqjkeqCNjwbjCMx0MClOTqlL4JKo9g3TpXD3nsVRKfkEiQ9rx+crytpGUJoxkj7eOc519YIS4MLa6X9ntlO2eY4tE/YRl2wagvPV4UmCrcdyzLeDPN6kSVpxvu7Y6bl/3ug5I2x/X8N/Gx1ENXkZS4nN6trP24EhpSRlc8s3PTpXifDj+yVi+nZgK8bAmXVAKx/S3tCLDynFQWf+SIqNZQx2j1UGnf78GQ05dXCjqcaQaVYRo/ZL9J4tcENvcWQueT06Ia+BTz9RoWS5Y0llYD0jO54o8FYtoc+GgPU29BhCBM+9PXTNWCy/D3k9gKNKGMKKL8PEvoE/t++KHm5LHPvHdOUJ4xreOOjaBcCj87clyEbL5aIaRkjEdUhpoR3cpJ4vMk6YbUpoi4SZAkEJKPdjW6dSFXlESlzJAu6njMQslhbofeF8hzYenIwj91UZfeRlNK4dDOoCmVAiSuUtJkrdXrTaUw8CUGLQ9ymkHsaGBCV1lZh0RFNGV42ONpJEDjD7lL/Yw2lvK2/AGeV080g9xjZXcQ8R/Dg5HofKkF6k2VOgs83RqzZABFwMpKjZeT7sSRhC0wd5BLSGvvrlAsjb09TtSrW5Yf71TB1LjnyCyIDgitcAPZyYZe+IVHc1fX2v7C7YP8l11eoDQZ5wghiVnuZ7qSSWys+xNdyf5SneiNStlRVlOZx0Lu6u0u1RMtMAORcoBLSAwLceh0ufvMtcDNOFSyFL1+27Yl7rUUTpQj1k4robaFdyR/2uiiDC5631W6ppAyEPsFBPnZ7rSxs3F5ytynC8Im8eWfhnJZyBiDkB4FhNEe/OT4rYJ3WVWyyADhI2IaSZSll+AuS7w2kgCTbK00=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d88d0a-21a2-424e-fb72-08dbc105ab4b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 16:03:49.7684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIYkYOwHEq1rHSTFA8uTXgY8gZNP3Yo1QCNCYF7Sb/Lv1RynWdSg59E+3k7X84S0Mjc2J7+9m+XRTrHddm51uCoLh8XRugi0+3PFHMVvcF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7840
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_14,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290139
X-Proofpoint-ORIG-GUID: yOX9BMqCr392VBK7c51FwXMGJTDCa8Pv
X-Proofpoint-GUID: yOX9BMqCr392VBK7c51FwXMGJTDCa8Pv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/23 9:54 AM, Chengfeng Ye wrote:
> iscsi_complete_pdu() is called by several rx callback, under
> softirq context. Thus the callsite of it inside qla4xxx_task_work()
> should better disable bottom half, as work queue is executed under
> process context, it needs to protect race with softirq context
> locking to avoid deadlock.
> 
> <potential deadlock #1>
> qla4xxx_task_work()
> --> iscsi_complete_pdu()
> --> spin_lock(&conn->session->back_lock);
> <interrupt>
>    --> iscsi_tcp_data_recv_done()
>    --> iscsi_complete_pdu()
>    --> spin_lock(&conn->session->back_lock) (deadlock)
> 

This will not happen, because qla4xxx does not use the libiscsi_tcp
code. If you had a iscsi session with qla4xxx and another
iscsi session with iscsi_tcp, then you could get an interrupt like
this, but the "conn->session->back_lock" that's taken above would
be for the iscsi_tcp session.

So you would need to make sure that the above can't happen for
iscsi_tcp an iscsi_tcp session. Same with the below analysis.


> <potential deadlock #2>
> qla4xxx_task_work()
> --> iscsi_complete_pdu()
> --> __iscsi_complete_pdu()
> --> spin_lock(&conn->session->frwd_lock)
> <interrupt>
>    --> iscsi_tcp_data_recv_done()
>    --> iscsi_complete_pdu()
>    --> __iscsi_complete_pdu()
>    --> spin_lock(&conn->session->frwd_lock) (deadlock)
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 
> To avoid the problem, disable bh inside qla4xxx_task_work() before
> calling iscsi_complete_pdu().
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
> ---
>  drivers/scsi/qla4xxx/ql4_os.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
> index 675332e49a7b..c60781148e6c 100644
> --- a/drivers/scsi/qla4xxx/ql4_os.c
> +++ b/drivers/scsi/qla4xxx/ql4_os.c
> @@ -3382,7 +3382,9 @@ static void qla4xxx_task_work(struct work_struct *wdata)
>  		hdr->itt = itt;
>  		data = task_data->resp_buffer + hdr_len;
>  		data_len = task_data->resp_len - hdr_len;
> +		local_bh_disable();
>  		iscsi_complete_pdu(conn, hdr, data, data_len);
> +		local_bh_enable();
>  		break;
>  	default:
>  		ql4_printk(KERN_ERR, ha, "Passthru failed status = 0x%x\n",

