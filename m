Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C30B79F614
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjINBFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjINBFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:05:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31CA1713;
        Wed, 13 Sep 2023 18:05:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38E0bFId013601;
        Thu, 14 Sep 2023 01:05:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=LXWoWbNTlNkgI1PHk3r3CFIAprCaWxDk7l5PvjV5BRE=;
 b=AoVk/ur9dmWFliESwJKunOvlJGotSgLfVccrLtye8U+JHt1OkXrt9aQcTSW+NWppkbU6
 nzqMbALunub4rcTQRu/63aWWCvJHf1TSgIm7gsomZisiXCJeu/t0srUkDXSbcuCd6p3w
 zyIJiNRbAa8dPYNKr/SdJGesqV7qOjVnH+PWTbcSd9Ks+q9uqp14WxwdMDMT3YqpCeZW
 vz8lKP6c1z+DdaPG8eoL5Ljv9z15xuoCpf6WA1UZVdDjqFUQ0qruKV4Ly4juq10q4YyI
 K6JI2vFAraVJ31KdcE/ktNSLkgn0aR0SO/EerShI1sAo6AcY2v/nVM5DMWJs+6Q+fft/ nQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kkgm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 01:05:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38E0A6Ir033008;
        Thu, 14 Sep 2023 01:05:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0wkh9yfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 01:05:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnbM6Av3rERnu78DLly48NwwWQL6q0eSyBjF07zC7CcoeRuRQumJXqg1kdaEb5yhJo1IhlPcj0o3wheLujcmZnrYsyEW6a75xz7hxWBHeXXEBgigOUqP3Zv/GQ4ht3Ed76gg+7YDVyODiG57qWd1CJz4AWji437N8Oh3Yb7HceyAYkFVnZZku5lp+3aXUCNh15UdCQ0EUNvOCvEDwIfX4LWnOJLv3UeGOnFwnogJPtPi/SSCA/QZ5IWsuTy9trDnu99V+XvbvUo7cReg3c6Bz8arL9lw/3G5FHcLT9/0xszvLdXiPls7akMbJdkrgZ9j8kIbFQa7QBB/nYiToM3GWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXWoWbNTlNkgI1PHk3r3CFIAprCaWxDk7l5PvjV5BRE=;
 b=E7uHIf4ROzw/DGEuF363obAAV+4EqKEddVAkh2a90BGHQbRdLYiTCIjf+VfFG4CtbRwobU/xrKuGr5EBy+w4t/2VZM2MWnDFnYrd8AGw6iAuOk2bXaZni1clUvDwTgNdcfMorwHZ0cwX5tkO3QqloA5EeaFkcTbjuz/6NSzk1Ml7E3MtL7aEpk7ogAEypf6TQ/QQXGPhCY3/TuyPqcoCmmgTW7R8ZeHSAts9bjnEy8YLwGuQCGgknik6PM1qRCPxGnenj7hBT7mQDYLC1JoYEEahpaMFdmp06pCxKsIw+LrlwySAR3xVmXmGZfXGvNoXzermAabXM8DVKNx3knFVIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXWoWbNTlNkgI1PHk3r3CFIAprCaWxDk7l5PvjV5BRE=;
 b=toO9dUTNNgdTgFy/iAhndsHwmI5TLDe5jH36TmooLqCkhpFhX27lR1z/C386AWVEX9FhAvSXBdatxXeTw/v2NVod/eINfUb0xOHB/i0lAQVGjZoa/wO2H3O0SGsig1KRrfTMJlo/JLKGEBMm7DXMgqET27xRydodza7x/dXXbnc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BY5PR10MB4244.namprd10.prod.outlook.com (2603:10b6:a03:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.33; Thu, 14 Sep
 2023 01:05:19 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 01:05:19 +0000
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Stanley Chu <stanley.chu@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-scsi@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] scsi: ufs: do not look for unsupported
 vdd-hba-max-microamp
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq134zhfttp.fsf@ca-mkp.ca.oracle.com>
References: <20230906113302.201888-1-krzysztof.kozlowski@linaro.org>
Date:   Wed, 13 Sep 2023 21:05:17 -0400
In-Reply-To: <20230906113302.201888-1-krzysztof.kozlowski@linaro.org>
        (Krzysztof Kozlowski's message of "Wed, 6 Sep 2023 13:33:02 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0093.namprd11.prod.outlook.com
 (2603:10b6:806:d1::8) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BY5PR10MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f813683-c111-48c5-e6fe-08dbb4beaa27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJezNXeNlCQClhSZXzjJ7yPpO1rHmXZVpreFZza3F790BnEaQO1Iemyr87Jil60Wuck5dauQN48fA7t8rTbQZ+gmh3OEQhDz5rYtHIw2mzPHhe8xhw4gYW3jeQg1CmBczyLCzV53bw8jwJdhdlWlfrFGjUr7ZJdJnuHBO58DFpSYqiEJEaVKI9ll2S3EaEB5Dtzzb3K7RcBllhANNJslGZONetXuYmA7Tsr6kQgI+afFxPqI3ssYmvJoEIdeq0/eguWpiVsXnXiV+i2qMp9zeY0qNgKpQ8ZRI1S6QwLeSM3I0XhlajtG5DnwfGBcCn2haDzWs8MX6yql60ymbuwA6ucWXLI1zOJkMyziaiIikoM+6FAx/BOtT1zCa7zBInJBt3VyiuKnyMSV6CqGG29iHcJwUcNsVS4LTWnfG+wBVGNZmdnyiQj2dIAre1zQtSM4Kw8eBJ2Kr97cBDQ5GIOOe3RITv9+UmgCjQK/1HVXhFNyomPJCdXfVlFUofu9gfKUqfoN97IJOn1tDTVPVhS+MhoLZ4Mm4whaa6yaro4r0TCJUlLLftVyhJkgpA+xen0E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(1800799009)(451199024)(186009)(316002)(6486002)(36916002)(6506007)(38100700002)(86362001)(558084003)(2906002)(26005)(6512007)(478600001)(54906003)(4326008)(8936002)(8676002)(5660300002)(83380400001)(6916009)(41300700001)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8XwkLDiSW9HQmoxTJSYTiqzFA3byGuFFh4XqDkFnUVgtCrswg+152kfQIdYA?=
 =?us-ascii?Q?Ha/uYbFLiR22WphiAv9bfuDOwtLCH0Oqe4nK5eQ122gjYKDEkSiO54q5yap2?=
 =?us-ascii?Q?T049eo2M0sMSvAPlEGbhnkwUfES048eyn1t2jRKsoQfDnHuJt9WQ/csvid0p?=
 =?us-ascii?Q?1LBbpuqi0b2PL8+gTgMrDH+w6puJBd7cVxJiE/sjHahyCkOxFLDgOwJWrfBG?=
 =?us-ascii?Q?pQ9z4zUKbR6sePzvZ4HTHHf4gyRxd1WwlvY3l7UmhQtGeGRSQP/kcLQWhTN6?=
 =?us-ascii?Q?v4fKoIoXXENdL51q11xByWGs7FjRFXWES2Kcd1m8NfonXlan1P8dTOxaiYnH?=
 =?us-ascii?Q?y9Qg0YFDErH4bBM/YyL6sep+Hg4+WSMknUu7AlLQ/vq6PK32GyMZIILy8PLx?=
 =?us-ascii?Q?IznHqPlL4+O0yhf6cl2ZGx75ExjNSkWkxSVmxT1ap7dbKZgjkBc0m9XTqNWK?=
 =?us-ascii?Q?P3xTogfjfR6TeHnpUB3RkGsc4DT/puhnb+lJUMQGSw8Rgp4391c5fP9Hvdpn?=
 =?us-ascii?Q?k6cIWaPyuljX1pj93Skcx8Nk+e4Av5j7qxLqSKqzruSGg4+FvFTUqvNXq7g0?=
 =?us-ascii?Q?187at0ZCrMY/nuWxH5qA3cyFyjOYTH6lxtndm8Zoc9dcA5hVZwMLzYZARxTB?=
 =?us-ascii?Q?Ds8hYZbdupYHdA2vk3ZLYh2eWGl1fHlOnSU20NFa6LCoV9lCDryBPC/8sgff?=
 =?us-ascii?Q?JDL0D6x64NugCdnGoUKaIRXzSApWRPlJgnF+Yc7v5atPCTHLzCcU1R6AELUq?=
 =?us-ascii?Q?pgazr7jOK2sbplw6InT2Y6xgHkqt6x3Tf9h13YrmdMnZJdOU9IuaNzywASS6?=
 =?us-ascii?Q?2ZauG69FQEy8o1HSMYv1dwf/0+g8ZWVPbvs0dRsDG8xI8tRmjlgr0J/MOBMR?=
 =?us-ascii?Q?kX0iJcixRoy3xOEj+fazUNYHo9eCI5sqiSqM9FrPsobmixT3LcOxz29R5k9K?=
 =?us-ascii?Q?qGyZBb8yglDnrV0qVVbR3228ElJo7iDvn9Uprd26kKrL+A5g+dAvIpCXv3y7?=
 =?us-ascii?Q?4yazQPaXGzxfMZ7MpNxRFatnQLcynTftv1dzN5j/aPQIhWuykaDgmYG1daQi?=
 =?us-ascii?Q?kBwMoS7jt/C2xw1Wa3NJHq6FR1icjYxkCSVtuPRL0feExGLzsAhpDy80R/AN?=
 =?us-ascii?Q?o5174SmEBYoLzDcr9kkt1tdTbEkcMe3nqlHcibWMaWQ/bv6GisYTDGhCQPXG?=
 =?us-ascii?Q?OzKZuakpnnMNYF5XqwTSaqjS+SjDOP96JIIB1+9wRwX0wm3Wc1iKeG3SJ5WD?=
 =?us-ascii?Q?O5lJrOR22kMLmOZiEhWo7Xm2E2oD/qflTy4Bbs69J3RZ/t70AHVyg06hqvO5?=
 =?us-ascii?Q?MWy5bMNZwN7YI7L5PigdY9K+6y6h5ppoKqSuHpVLvxo5zqujRcQEaJHd3guI?=
 =?us-ascii?Q?I0i+hKN5pciNQhaaEDdmgOoT4uUjwWDy7MHueDR1ayXAHubKDiyQeBpmzzBM?=
 =?us-ascii?Q?lha+Z3fzx+NxKznwUUj1BD/2bCl1cekFG5EvNy1WIDjA5F0fJd0Re/P6wNkb?=
 =?us-ascii?Q?sPW63MNzbyswWoEg7QPEIlxd2+rjWnnLIppMoRjyKGt9WWVsZCyNb1XRJFsq?=
 =?us-ascii?Q?3aN76vfifAEIxORnnBKPtBehP2wVheHJExBH04Ojxrcb8wrM5OC0j/6qPNe3?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lt4HfevweWUmkZA6n9F48FHTO3fF467GbpV+bjJt0DqN0yWP6M/UOAAjk6QM?=
 =?us-ascii?Q?YXnls4InkuwlMlTIyXQ7+gUCd310RDt3rEUI6PJJ+z210XxdWSNpIwXE2djA?=
 =?us-ascii?Q?Bc4nOHHKu/4PFQkMvI5V2q4p6ZwXOJEPLmIysQULtn3TuhfxirVuPGM1V3/2?=
 =?us-ascii?Q?LZ+Adgx93myIL2yge/Sf9bf524CPbG7NbBPGnGoNZvwxQ2aiUQxi17QGzflF?=
 =?us-ascii?Q?yBCESj8i9AS9vPEfjNlZOk0HWbDvwdrkWSmPau7va1tZk+C6ZIBH28PSFGaI?=
 =?us-ascii?Q?b5Z21uarmyeMPLbR/EQ1VzOQ5/dHnHdtykVq0HJ8IjWWkq8ODW/zSrSNwfSI?=
 =?us-ascii?Q?bz4+f4MsSeiuCw8ufVo4gjjfVWo8/65Jw8aRVCtW9nAYG3uyUYzxD03NmNWr?=
 =?us-ascii?Q?1KsDCSPUMyUYJ+LHAiQ6LNmGqt8l9ycHY+iIV/kRSXiCO3MSEOiyqS7QCRIA?=
 =?us-ascii?Q?JnFdsr+Dxm6HvM1bFGJamFbPHWQXKaQ1HWOwNuGLx/HkccO78wT99XunQbJn?=
 =?us-ascii?Q?Zsint/z98G2skR9EG5Cct0AEo2ox1R+ywnVkQYmHDCl7+5eIfv/ffPgzdKwd?=
 =?us-ascii?Q?OUhnJOrWc+4aZGJVpDLVYxcYM0lgIvsDwzBVsVXN96IxYA/nMqFDahkZOEY9?=
 =?us-ascii?Q?PgL9w0WRP4vOqCOPF2fNJhYtVlt2yNH3eygkf5idBmmBnzKJOH5vGN4agJQx?=
 =?us-ascii?Q?97N7AbTW47WZu6opUhKIu0Et7sTnC4lDXG+qZG6nZJPT/qXK0uWKHbUUHhsS?=
 =?us-ascii?Q?8rp7+2muOPe5pWWUUzD5lOVPLIP6PvQ//+spQHWe3HFScOSNSKFQL4YYiJd+?=
 =?us-ascii?Q?x6mwUTEBVA7UPuzXZgL9hziCoW+cD3Yz8IBk15yP4WSjfXeKAB/CSOvWKjPu?=
 =?us-ascii?Q?BAfDve8FATAc+3wB0s/Pth1NfgdJcvE+9LSvuvZGN4o7MtRyMap8TsqmPl3I?=
 =?us-ascii?Q?SkrkxWBE/wr764EQUb4aqnq+/xV1FRLbwp6qpE5V+7c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f813683-c111-48c5-e6fe-08dbb4beaa27
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 01:05:19.5822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plrFeQswnUQ3v8rM1zh1/G3ft3kMf3YMoyqcADqCi8apqtNKUE/2OsY9Kp0K63V2zR8jHpvY9+aWBTpztq7lxzJJZr9am+NyYFs7M+YM9v8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=824 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140008
X-Proofpoint-GUID: peoPo_-FOTo-N4eYvkU0NGB_YKI9_h21
X-Proofpoint-ORIG-GUID: peoPo_-FOTo-N4eYvkU0NGB_YKI9_h21
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Krzysztof,

> Bindings do not allow vdd-hba-max-microamp property and the driver
> does not use it (does not control load of vdd-hba supply). Skip
> looking for this property to avoid misleading dmesg messages:

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
