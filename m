Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4C081264C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 05:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443103AbjLNELL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 23:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjLNELH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 23:11:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8EED5;
        Wed, 13 Dec 2023 20:11:14 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE0TVSr016204;
        Thu, 14 Dec 2023 04:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=R/tzr1+GfRKNUf+EvXmJaSUI9DlqH027WTwj/tZqLBA=;
 b=kqzxI4YM4BcFp5hAyt2b5jsF5x/5TSPIZ3pFLGjnW39eMAei64tn88FhtJrVYsXe5TaS
 rJx4tfIKYBldeJJpQ/un2vHVHyEoZwnG2tCFrarJ21iVjRiblE0JZWVq7NmdvAV1/Ggw
 CKlE9ILshcUOfNdJbKaDjJtMiIsyzbrAtrRK16mG+1V6m6+A5kr/LWTjyf8IJjKMw0Na
 MQWgjdcrJXzFWmFGlaAU3SURgZrxpiz9Gzk/wFr3nLSjKCkuV/JfkPHj3RzR5BTXRjIJ
 DJvraWA5N1VHZGZ0/J5Q81Y6BIcDkVALyQzl8NmI8O4Rm3KoP1AqJloOiO3ZzVU8agPu dQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwgn3r1g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 04:10:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE3Z6QX008350;
        Thu, 14 Dec 2023 04:10:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep9e8gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 04:10:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrpyaqC/YVL6QpyTf1nP8Xl6MzQtj4kskOz85/1x0hJuAG5lirfSrdY9msWm1ZZhxtEi8etEXNS2cXVP5SdQb1z7WvWAgn4SPJvZp0mLyOmLHQj3T84IwenKt8eRXUrOsQsjrNMp//vImZFzZllNLeMBksuMR0a0vDq2Vrjl9w9bKxSIY1U9wwKbOhePHjIayJCWmepQXnZELOLqGFo85Pr1ioT2hA7bosdQOCwLgj3W6u9GI7FVSWcrqRnN9VTMKJ55uy18DY51GrZsJff3KlX7wVYWubjXW2HU4ISL9jtJk2/oSISp2mmtskjSdJ3lk7hfkz/gb3hehB/p9uqnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/tzr1+GfRKNUf+EvXmJaSUI9DlqH027WTwj/tZqLBA=;
 b=Z+0GGMvFYwKvmkouke3HYdLszO5adZb+LG+uNENVLoggW3QHn81W3oJYUQwhoeuKSQw+L3OV3JsaeDpSM/vlsDCu+CClPIDaT7sn/CRhzYzQMsGoRDX7reFBMweBFUh5bt+7na7o4ZvLxWLCqiKAcf5vTmuPMpJojlF7dhWzU+d/jo70/oIvxqCLy5N7kFg+6aVcVnKXR2Zt66ijZPIbY2kKqUx5BKl7xiTiAtFpPaOG6KT7H9/4VIPXWt4Ko3cjYRManHtAmINcElF7kYDvPJXkzUt8GxBtkutg1O9cJmzJ7TG6pQcxd2AdgLMw7SZ/gSzH5IWVpOD1dVMlmIxzzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/tzr1+GfRKNUf+EvXmJaSUI9DlqH027WTwj/tZqLBA=;
 b=lZNELHqsXKTmVm49heFZukr5RVmNWcSjKBmTI3TuIMhrDa+IXuJTsZoSYGxvxYAfOTICmVUuqSGwgBEniHH3BhPKzRVZZefUTng1k5QVlE6sACBYmywX5lG9+8Vy4icGD3GzwMb9qHcUb9Fulux52+uxOaYy44E+X+Gf6JCxt84=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7019.namprd10.prod.outlook.com (2603:10b6:8:14c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 04:10:44 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 04:10:43 +0000
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ahalaney@redhat.com, quic_nitirawa@quicinc.com
Subject: Re: [PATCH v2 00/17] scsi: ufs: qcom: Code cleanups
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zfydfmqu.fsf@ca-mkp.ca.oracle.com>
References: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
Date:   Wed, 13 Dec 2023 23:10:41 -0500
In-Reply-To: <20231208065902.11006-1-manivannan.sadhasivam@linaro.org>
        (Manivannan Sadhasivam's message of "Fri, 8 Dec 2023 12:28:45 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0112.namprd11.prod.outlook.com
 (2603:10b6:806:d1::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: e8410c3c-ddd1-4137-a0bf-08dbfc5aa457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wRgZv6T7P2cAHTvYECNilBmvpdyxZg6lfXrPNc+JH6jtlYxvBUZLHoUSVFPDQfWFLf9zGnEbVWQ4DkwsG3SmgkxVR0G8oGdZkuZV3e0OIjdQY9KW8fapmsKQNfLIqGnTk1hHdpKk+sJsKHQPWyP8Ho2dYohv43jN8he3s8dGn6UDUXGYOO9HiioQOH7Lb8dprEIN6FHkQyRxhoflWnqtblkhASS8UrIxQGBU2jiNlvaJ8DpnKLbkmURiNMcfSZEiPjqzc8NJbZBB/Q8xRc9BJ/konMP3sBzUt6dwM4ZOH9HMm4Ohh29OqigY63hpB9oD4Qp7Pz6G3BKw6p8y51r5mZw4LIWcGQs6cmREGkeziKN7lV53wDkJbmZpB4aw+Bnm9UG6U6R+TKFy8LLAf/+eF5o72n9dEmRiRwyKVHsP4wlfGYLm+NQdtSxUmrhzAhUyP/4wKh4/++IFBIFencIRkOppgYP0cMjs6tSBNXz/Wn6YmDw5AEu7W0Xoz6jhOeNoZrVZ7twTgX78LIQPgUCrqZ96E/JOIbXZhYSeSLGednsq+K3WdaEv3Zi3agXIygU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(38100700002)(5660300002)(7416002)(478600001)(6486002)(6512007)(2906002)(4744005)(36916002)(6916009)(316002)(66476007)(66556008)(66946007)(8676002)(4326008)(8936002)(86362001)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R5wGAxXlnyb8DQ9XishKIGSB/X5uN4lKmd5fSqo6Qs2EYqcluKNX/lPgxZPu?=
 =?us-ascii?Q?VXDon6D6qw4+19lpCT/EZYVFLJLEmbeiDq1KlsI0886sbMSg74cdTSuPXDh9?=
 =?us-ascii?Q?VR3eMhW9QT0PM6gIlAP9fFFqgVrpnuyQPlfbUAYjGOni0C/0RHZrKushHCdR?=
 =?us-ascii?Q?aUpM14tP+JlYTvkyzy0h95plc5keFLPaOBaUZcY0aEfefE6xUnSKPLJy1Bcf?=
 =?us-ascii?Q?xg3O4IMy9hfBJRnD72E7fon9y3adOhC/aNOj3gKN+vi9mo434NNiojMk+0Xh?=
 =?us-ascii?Q?mhpW9RpU2c6hA2QLe/HHIdoN7Q6wc/B+7TVd2cG9OGJx0buuEbQboVcs8pI7?=
 =?us-ascii?Q?SnR3D9YNtXeoLz8Q2cFvngsqlww7nQJVSFCCzAHSU7xPMaF9g0R9c1o3SkSP?=
 =?us-ascii?Q?kLeB9sJa6UqY+iLwffpw7Tu5y06gnoZ3RBWQdZf/7hzLyxR6g+ctgCU438X5?=
 =?us-ascii?Q?oRxGj1vPUJnx1wGEWy6dumrDbgvYUFl03szDEdSY58CelbeAo0zzwwbU1lUD?=
 =?us-ascii?Q?hHqAL9WGMHw3eon6PWPfiBiu2IXQO6/YPJWqxoEbd5/q7vhgyCXba6uB+ZmS?=
 =?us-ascii?Q?Z6qx1auKjwyte0/pN0jwx9SVAmU+h7bgP8k5ggHMrXknu3kz5BbYWSAagp5z?=
 =?us-ascii?Q?L1EPSLXkEs+WFUyvEnkOmvhIHrXRRa+6vlB+Uv0iJr4u+cQFAt3IDDhnIjhV?=
 =?us-ascii?Q?Nob1g8zCOCJJfJJBa9or1C/G/ZI6yG/cLrKqzUNbBspGh5uH0lI9arSWEFzK?=
 =?us-ascii?Q?jRpzd5ZWWdEjrcgffL4H1spsVR27CLTtRK2r1CElImhdvS2eGQrFCU4+Vz9+?=
 =?us-ascii?Q?719Xs7EzhBoQpj1vxlQSY0u5uhPcwiTTNIP3bIwVCP5ODDcLOV4TkwxI1A5q?=
 =?us-ascii?Q?zD3FdI0KECJSbrzXJEZjQ8qdaZOu528wTcz3z3m+fGwFa1uoA/kMkxtd0mPX?=
 =?us-ascii?Q?+0qnkF3ITMgvHStSk+IZFp32sGbaRapuIr7xVUNPmU8kRMau7/9oHisNn6cA?=
 =?us-ascii?Q?kqln6zdAewrz39LQb5ZNKd1RXbTkhNhj6IGjyGAMTgXhzfFxQFjpMPU21b7z?=
 =?us-ascii?Q?KdCF8z7Xs3dRGZHXR9kPaHNS8dwxq5SRlSM3AKtf2QzquD5R8u4d8mv9aMhK?=
 =?us-ascii?Q?/7o5p2hKNQeMxe5VM5y5h9WOP/CHgoAFAIFbi9YXzykyoSMT78yj9XetCNVx?=
 =?us-ascii?Q?Ly8+MRE4riCLksGdTRQUpuX0q4/AwAITlevQRTdaX+VmfFNp8WCsNyAWYn2K?=
 =?us-ascii?Q?qxZ3XM4RV62n179HJieMu19heYsCZA7HZUTIAJF3NW52sFQFosg+8664I6LH?=
 =?us-ascii?Q?ArPdU36rNWy6E7FVaJdGyu030YpgCgP7aDOX9LavZcFjlCsloiw53VJYpX4b?=
 =?us-ascii?Q?zdsVVrdKtV2pvi3/zG6FV8MxXwT5/MFhj5wicH1f0h4BeUy+i04vWwVb8byx?=
 =?us-ascii?Q?IbYzp5o74L+n3e6pw1Zx4BSR1HAiFAdjRkyKsnvxt84Ui3V1pE1wCytjDWFt?=
 =?us-ascii?Q?efEnb9vBRlG+Y2RhmeWdxeuI4nli1FQjheD/4jz++2pHIda8/rXo5e5KvQON?=
 =?us-ascii?Q?fIVI4J77G0+H2dXNvW/6zMgdI29J6nTUoIJMi87WdPKD8xI9d1zCWpNAoNnp?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PeSl4W2B2IqLfhNmOcSXkcPhAowjFbBhtPCN9mEfWxX8zhRq8ujXzzEBhWLij0K+QMKL8492MAmEgxxIXVEUs5Q6CGc4qteNwTBcLsqwfax40pG7+XXqEXWNpzNh19eOSLiCC/73RWEOFlQzq4076hOszeSjBmm9sWnFbVzYbzeUdT1Uc0bc77kxhF3JGb61j759VtoaWRbAwcfhRVaLxd4OYbmE3LuHfryn8NTzJSrSeTcjdrObcLTIx2s23Qbg+SHvjfnoVinbqgvtzXNkMfg5iR7GKO4OOCcXBZA6yYdFHCb0NzfNgmucLxNofo+TME6TiWzPZg0wRLpBa8stio37p8idmUV2xOewGrQMgc6jMkDTfthe+IadgTb8OlwNmVrjCL6VFwoNHaCdJby8n5DKWcwUTqFTSXyr78Un4OdSGyBYmxvPsd728pILBtpjr1pBHowcWkHlZw+/9iJH8s98HzYZrG7Brmo5al2lgE41L8i8yvYEe6FDGaUkXlghE3UuW0o6UuSM9aUc9sjnuUTw7LVnyyeY/F4LZbBZ0TZukJnzZVUji9olK9Y/afviKZaFwhhFzPTndcDwIx6j+VAUDfQ/lROMhnnga7fAcMI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8410c3c-ddd1-4137-a0bf-08dbfc5aa457
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 04:10:43.9160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRC6lvTN5Zaz1mSrcR4lC6aEbNPa4Po8dJAoXAW8Rd7aJT8NoVelsh6uA8eW7lRCJ6S9qJesu1u7CFegD3uWT+BFZZkJrwENsqmrGfGJQH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7019
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_01,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=862 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140022
X-Proofpoint-ORIG-GUID: aA6Z1IFSOw6nR_DofSU1Pnqivhludz7F
X-Proofpoint-GUID: aA6Z1IFSOw6nR_DofSU1Pnqivhludz7F
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Manivannan,

> This series has code some cleanups to the Qcom UFS driver. No functional
> change. In this version, I've removed code supporting legacy controllers
> ver < 2.0, as the respective platforms were never supported in upstream.
>
> Tested on: RB5 development board based on Qcom SM8250 SoC.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
