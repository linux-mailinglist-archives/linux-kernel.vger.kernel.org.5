Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA0D75E47B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjGWTWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjGWTWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:22:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4ED10DE;
        Sun, 23 Jul 2023 12:22:21 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NJI365006265;
        Sun, 23 Jul 2023 19:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=OOLJz+DpRP4m+fc294Rn3UFkq7XpcXSR/Gt+slC2v5Q=;
 b=K8C/EbuloqD9W9ul08ctZFaVpemk8ozPVuDjQF2LDxJ2YQys7DvoJvk0+zKFSe6cbVVC
 O4HmIeBEuuJV8m0ZfDMlNOXn1JhPZ8f/eA5zlsHNOB28BuppfCI0yJp/e4TjcUa8QXk1
 70x6vt78T3iYrcxs+P8tEJLrig+TwAjQ/2sXovxWq+zwHYoLPZm4KUfEkRrJrGyHOpnc
 4h06o4a68+uDkeWeHo1efEFdvYWYCF61QcOSIRl15sV8zJcNWpE+MVHYBkdH4zoS2Lbq
 twhzXsZTGralCgE05WGCzKlUra0L8Af4gRIQBk7cyGSkVgVfvgIgM6UeTPVceh4fWnMV vQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qtsfjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 19:21:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36NFGKO2028215;
        Sun, 23 Jul 2023 19:21:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j8x3wj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 23 Jul 2023 19:21:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrhV2tFLHwnTeBFrh9I/UNzZz1qyjtDc8GTXijz5v18OgWJ9zLcgIRGBKYPYLGTvkBDIEb1mcUFx8t91EFs2IQ0vbE1ttQEVrTobZf+o1k5EM/J70B10j04AZIWcB65iuEYjbMu5avOuOMzPd2sMwvcdTNSQ1K8YFm3vgYg7WsVO4gxuAELEsdM+ZM+p8gFTvfx16dRPj8ocq86qIUEesJn13p5y+ANO6RDyU17ic9Rp3ynJMC1q/8zJeFrPIXPms+ZWeKgVNIlihL5XI4WopKZUSlKFOQIqM2zh9duaPLFWpdMIxjkGGP42L6kIbJtlVnaMbBoVuAjE73z5DTUTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOLJz+DpRP4m+fc294Rn3UFkq7XpcXSR/Gt+slC2v5Q=;
 b=T/dwQP15+1zFAXPMYFpwQUnbTBSAbiO5j/y/cITonBXDXTN86+dDKRTMCQJChCt+MhBsFK8jK5reAhKBt4pPjJMLyO71vDsr88QvAe5iU0HQrak1dbZFtB/9RNZgUmkhNOkD1x+oKAph9RDIP1Moeo4dRbgGHJu909RV/eJgGjoLMJvQNZAqDMJ4nF9+801Tuj8FxFaip4aBZUyl+o9RHlrb4XhhIlvQHhsgq4IRbzaYKrd5gDThIaECx9QJ7ca2oIvHyfyfL6WRmwCN/8mzLOUfSnfMtxrMOrSi6YNIizEuDg6uhrPRHKBTRsZF1L9FEKPryOBNkK7H8L/Tcrluig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOLJz+DpRP4m+fc294Rn3UFkq7XpcXSR/Gt+slC2v5Q=;
 b=UnvA6/U4INwI2u26GLMqZO0hz2tXXUswbTIeDpgRju5m9YFXP6/J4NNt7zJDTntpAgUq6eUg0ZZb/q6QjRa4dvaVFh0wMYhaPHnw9Dn4AMDJGQj15M3aRDKwivNywcEPql8FpgJHRvP4GdP+s1LqzSpSIhvTjMV0YQA9xCTTeLo=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by IA0PR10MB7302.namprd10.prod.outlook.com (2603:10b6:208:407::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 19:21:46 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::f82a:5d0:624d:9536%7]) with mapi id 15.20.6609.030; Sun, 23 Jul 2023
 19:21:46 +0000
To:     Ziqi Chen <quic_ziqichen@quicinc.com>
Cc:     quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        bvanassche@acm.org, mani@kernel.org, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        junwoo80.lee@samsung.com, martin.petersen@oracle.com,
        quic_nitirawa@quicinc.com, linux-scsi@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-arm-msm@vger.kernel.org (open list:UNIVERSAL FLASH STORAGE HOST
        CONTROLLER DRIVER...), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v1] scsi: ufs: qcom: Get queue ID from MSI index in ESI
 handler
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11qgy77sy.fsf@ca-mkp.ca.oracle.com>
References: <1689062349-77385-1-git-send-email-quic_ziqichen@quicinc.com>
Date:   Sun, 23 Jul 2023 15:21:44 -0400
In-Reply-To: <1689062349-77385-1-git-send-email-quic_ziqichen@quicinc.com>
        (Ziqi Chen's message of "Tue, 11 Jul 2023 15:59:08 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR18CA0024.namprd18.prod.outlook.com
 (2603:10b6:5:15b::37) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|IA0PR10MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d10adf6-ede0-4288-3587-08db8bb20e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OjyjuTo3CVh66mKZCeWXbs8jRgA9czAovaB+62xAOWqnydO8ecGYgBHMTPrJHxZHnci4EUM9evgh5Nt1C5niB4+Sa40BClPAYf/MJWIzyunnSOVfo4uXNXRUG4iclt/DuQDQa3ov7NWhDfa/ZbvZRL+e5vV5hFYpMqWwAfT4Bl+yIZ/GSUWbFqwW2eIVqvZDFV+jKCpQ5RFPR2AawVL8rxUsewGhTlNt8DhRICnHT8vn26cieYG+g0vxvkQpbrmciTSROq3xVq/qwkPC2R4XbBtGSz1BnTpYJq/cZa0E3HiHM9B2QmrnXMTDh+KPjTu7/Y5IhM2lhvrKNcfAhDgr4i2dW7XG4MjOpD8avDVRVLwO+3z6IvQvRq0aaBv9M6dxAN470HrZInRPMIRcHEotkkcxxZ2akGDfG0Fh3soLPw9Bi3G2rXMTetHK+YA7ZSQ150b8Y068l+IgCKo9Ab8PAyGUwfn7k05cI5p/ftRzr2rxVkD8bwjDUa8jFHg/Ow8LnBm6n8f7sz84866aWzpHka2B6umvWBDMF/srrbXhA4GfOPTBtkzsTDYZu9bZkdLH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(38100700002)(6916009)(7416002)(8936002)(8676002)(5660300002)(478600001)(54906003)(316002)(66556008)(66476007)(4326008)(66946007)(41300700001)(26005)(186003)(6506007)(6486002)(6512007)(36916002)(4744005)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZQInynKJ81yelrM+4ZwFUI+illGJOXnuyiu8zomluuzBSmNT/jonn9uZruSi?=
 =?us-ascii?Q?ajBEH3fwnnOOGzHuvwq5bv7WTSI5Wig+4LHjFNwWo8WxoiD1wdhltelDeFYX?=
 =?us-ascii?Q?zsoIeCDm7BHpBXn9M2veQ8plxS+NuqUS/qFnA9bMGSltCGCOREDGCp+Sj2QA?=
 =?us-ascii?Q?BVU3hAS9aiXeCjfVJvcnf76MpqJYBDqwkgS3IMvqiGzrFo7UeWAZMWLbyLxe?=
 =?us-ascii?Q?RmcGY4fKtUNso37wOyegtiSWD1BWEKFapYPwiu7q+HttZf/2MWY51aecTDKb?=
 =?us-ascii?Q?4H03fu25OZnHOmSgvh64wgGi65xDhiOuqAVBE0f+UbuJP+vZtbaQ9xedxT81?=
 =?us-ascii?Q?aU1DTN6WxlmE5iZtV6NRS1spFjqV4Q7F0bcu38hkvAq847Qjk0pANB3V0Mur?=
 =?us-ascii?Q?ChGW/s6XJ8YvFapFM9iTaY+WKjc85Z6owYgmfqs+P7NdCNVUz/WOYTl4jeM3?=
 =?us-ascii?Q?ugjRqDeFuj1IMUwEr1B8OwbCeBALx1xdNQameisrxX3eySzksHtmpLQwA9wA?=
 =?us-ascii?Q?ifRzWxTttprYQEKeKC54LbhcxVs1OltpzJJTT+my0NyoX27Tuqv33XiSfRj/?=
 =?us-ascii?Q?Dz7kHG3M4iF3YLP5695zpymBpS7IDp8b2lPdxjxWxjsCfBEnMwf5VGOD2Pqf?=
 =?us-ascii?Q?xOm0/gxEYcDal1RBJSYyYYvLOhOxw8iM+skZUDs+V0UPvcYZ+b2ewARHTGzv?=
 =?us-ascii?Q?8SaDGgzauIAImjWqpBgyRscb2tjbFexPlF4T1O39lzzcL8nqYbMDuhS5c9FK?=
 =?us-ascii?Q?J1Pcxq+0GEXcbSdmZCIsH8XmX1bNXdfbYIha5krPKiNZUA1GL2UfgP5uFqAu?=
 =?us-ascii?Q?3dFWLHk43U3OZM2LIUDN847hr7U8iTbPuXM3jb/mpWl1SxOoAyD+90Ar5OA/?=
 =?us-ascii?Q?GNlmi7ZK4kuSeBEJO8GvvMffZ5F8o8w/VnCQ7vWBejtsQy2KLsJ3S2SsZxSi?=
 =?us-ascii?Q?g4p/MEjgHj8NqTPfHzs7l8y7J8n7fLkYbHEoBMxqpnoKr9qzvUmBk2IDvvVj?=
 =?us-ascii?Q?eCobm2UjsX3WNcVsHh1OA4nGiIsz0jOZpuurvyaSJhlNY4XZzPBDPGjF9qpo?=
 =?us-ascii?Q?5iMJGpC01sdAWthVC2h886LwPq9pJvKNyBKK56gLQbWtkxRNU1CrKbSkkN/H?=
 =?us-ascii?Q?mcjeMqK3Oi6E2iS+2pIXsSqnK2jhLLY0oyyWMpf4O1MpHvAGWUf1yhBFkZeR?=
 =?us-ascii?Q?uTCB2TVoKVpSCgR9VMt8l6GZfIRg+sCvt44pAACtdhJuQKa1EMIs+ZIfCCYH?=
 =?us-ascii?Q?VhouAXAnZKwwN63ziMnl4p4NiiQ2gSB575RCR5eFKbqbsAwip9tjHObw7CT8?=
 =?us-ascii?Q?3+M2xII8l0u8F6Z21rPukbtxbjzZnN90tAHkO+nd+PxgBLC8506hZ94/wxYa?=
 =?us-ascii?Q?Kyc+okMdgYNULTBe0Sss96MNYXZ3O+5RMlOWcVkxJauOIT5729O4HUQWMBw2?=
 =?us-ascii?Q?B7HxT+9rWmgHKXEMokgNK0lkXMtBX69EnBil51ATu52ZOdfmIrCxeg/gA5RT?=
 =?us-ascii?Q?HPPRxArRqAz7gmHPnIiGomeJkiK++DZuS1dBWaqLxmpCmu37v7W5Ww3CdIEl?=
 =?us-ascii?Q?CYcq/8zOYSUHuXEVo2mK4obBIn2duDhjkxvYadrWuF+V4+6ZDzr/aKKEplp1?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?NJJG/XEC3R7wk+cuS5KA+gR9gWyOuNQ4GETkyGk10erZxzRNsKqnesI1FvXw?=
 =?us-ascii?Q?Y3ZWgr+yI79DTtq1QGRQaV9ncorwnSQjR3KopzgAYbDD4mH+VqHgm04tUWb2?=
 =?us-ascii?Q?ub5rqNK4Kw2RT/JD+WPTZ9OrQbGE3Zy91Ftb5hnhw9RhreujPdfe5Dk+AP+e?=
 =?us-ascii?Q?KoUynI4HzONXYQrZbewxvs8blZv6TTXCDq4dugB0JW00OQLk7ENIvQczrNiJ?=
 =?us-ascii?Q?Aj63aiKXqZl/f4fHCdbKi241FbV5AwvFQ8eGXTKQlf4WTwm6+cEk/RJ8iq3m?=
 =?us-ascii?Q?WDd4XZ2XjQ1KuhmWwh0+mgkLVAWcVGwM1WxR8Bs4r4/I08Ax0AbcnQQVaNbG?=
 =?us-ascii?Q?nzvPMemEeX/AppCCNkWXOuggLD0Ti4QnC1wxfPPPOqkhAR1WWCMOQq33JET+?=
 =?us-ascii?Q?U4whEEPn0HTK18tqBDSTNQhiDx/7QSlu0T+lFYUfHxBLa6EXKT0Pze9HGVw5?=
 =?us-ascii?Q?oRkdzmeeNlYQve28IyQJaFJbmAPpcymOMELoNpC2M6527ja68YH9/4rPmNnr?=
 =?us-ascii?Q?ESpFbByg0c4ZFx5Pl6mlNSBH8FRlwoPqcY7rQkcGvlzNfDt/OtX414nYVI7D?=
 =?us-ascii?Q?7Qpx7ktPzY7b1eLfo5bALPZigL+ZYa0nVvI/MSFkvY4Us3UOBxq0fToHYCUa?=
 =?us-ascii?Q?CwShCvvlYS5U1jQuV7+dkXWq8HM6VZVV4k+zFHPty0hXYFcBIifHDr4SgDY4?=
 =?us-ascii?Q?ygLcdBGEyqnoTTVW1k6aqKDJ3cf58oZSL5mmtnI7l5KXhKS8FkyISbxyu1jr?=
 =?us-ascii?Q?FbGTouMre7Gf/tX+iju9LQ/TLYsCwaonbonIFlwvGYw3dEXyFs/5+iRtdYf9?=
 =?us-ascii?Q?Vul7Xr5eTDGWZzFknmFQ9+GGVjnlBmivUedqwalNG98VRqt8GaI8F8D1wiCD?=
 =?us-ascii?Q?6hUWWq8hvdBwnfT216pb4dlZdQRKpYln/yVsD39JK8UCnXWJoiT3iCmwaUP0?=
 =?us-ascii?Q?BkALuMTwZC+vV5FJYQlf4rmLMXGBAL9JIA21p9sak1a5/hm6CqPv+xRvIsuf?=
 =?us-ascii?Q?+ceV5dwt/Ejdn1b/eSNv5EKMMMh5GIyap6aHYk/EiWg1EKo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d10adf6-ede0-4288-3587-08db8bb20e66
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2023 19:21:46.8105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYo+bo97OJs59KLcCQEz8o63VeesG9jEHUxywGwRR3WWZS6iCLDaplak6hp9FbKRSsHnyNfSmCTWRR843qassX+gCUcyddb5vNh4R2RZfwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7302
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-23_08,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307230181
X-Proofpoint-ORIG-GUID: 06hupt7H1hbtyvvrq4vKgBr3ZYmvo-WM
X-Proofpoint-GUID: 06hupt7H1hbtyvvrq4vKgBr3ZYmvo-WM
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ziqi,

> platform_msi_domain_alloc_irqs() does not always get consecutive IRQ
> numbers, hence queue IDs calculated out from IRQ numbers may be
> incorrect if we assume IRQ numbers are consecutive. Fix it by passing
> msi_desc to ESI handler to use msi_desc->msi_index as queue ID.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
