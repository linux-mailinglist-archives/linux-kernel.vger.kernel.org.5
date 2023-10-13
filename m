Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EB97C8CC7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjJMSGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMSGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:06:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9232483;
        Fri, 13 Oct 2023 11:06:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DI4WLl032638;
        Fri, 13 Oct 2023 18:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=vaD/UyOgCzH1f4BWhGyZ86jeahW3IqcsyGoJ0uzGvVw=;
 b=HJ6ldSZQiFmzHyasbQs5aeQH8SUUp5UzVOGVBx+BnNx5cDris5QsGMM9/ULwLD0Vi2gJ
 0GOLh9lNSDIQAHJn+I8VtLCAEMAWF6xi762H0qwfSj9bfkLgKGcyrumpInqdHZulf8E5
 L014PYXp/NMCQwsh9NEx5VdjRijTOm3kZhS+PrVC7Lor3asrI4g6Gm+FnYTgEmZ5spgl
 1XxFOgMHQM+3p+2zyd1qAEVsU6ssKrux7mbqzB5kcti03a3MzvVsPlqJ0MRNGqUGVTVw
 iNEYEH/14gkkJsB1S1lvfPMjne6SyQevQpAxp4qZ9KWsBbWU9z3sPZuqSDyII0naIyWD nA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjxxudjhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 18:06:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DH1Rh5040182;
        Fri, 13 Oct 2023 18:06:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tpteaxna3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 18:06:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUEL1D93EekOWXVjnPQJt/oUb6g1wRSB/a8tY19U1w1PF5b/iFrftQ2wUoJuI8ZxdDFxPAsOMywmMPeSusf7F1sFNzjUdeqWFm1nskUvoyYqWaNQfftOX9K18xypwkV0jhRdLiH6nywCj5uB26xb84ec5BerNZqBX3lT1snwFnN53FPt4bTWK6AYdpW71x3hEEJXDdi3Ct437naXipQSGr+ucV8+LMlNfBk7F74RbNFkGxQcoExWS6lMBca0SnGd8Fr4IfgkBCEtSmOnVqcdrAcWrOiQqYG6c1QsYDUkVUAx9Ww5o4Eh14QyUeR1CwwdghWFMthoUvJW1m7dFkU8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaD/UyOgCzH1f4BWhGyZ86jeahW3IqcsyGoJ0uzGvVw=;
 b=PMgTo8N/47qBj3EI5dVD0O9cqDQ5+eIWb2fwy8bWyAo2FOrkw7NyIC0I7zDQoe4AZ1Cyu2cMoKeGWPa72ISub7wioC7ufTcm9elCLuXfUPJF50+VaRdc26NCkDT+ZBf8zuwY2DED2gs4vmQPkOT4SuS1nfO8Ab/emQ0zwiEqpHgHcGDZZy05Ly8nrzpKyFKj4rxM2VyEU8SUueCdwjHxPGjDyKX+lDMnov41CGau/9ucb+glSbJsoMqc0GIDrSIdFLI8JxO7H1GLNULDPl4UWDNqlIPfVKRZc+kW9XvJSbJEZAi+xsEXJJYMvaGrPxe0s3jOdxGmF3sjKnHta3mS2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaD/UyOgCzH1f4BWhGyZ86jeahW3IqcsyGoJ0uzGvVw=;
 b=t6vz5y0kbDOz3kw4DccadaFYqbDtDN6imVCPdDIxH6DNCaMpBhQOTdAelLd5VPTowag4O9dyXr2/sCFzXdWSNXwwJSZ3K6vC79ehOS7VKZPgdLr8Zp2HvA5NcHpPFQAQI5654ONQjiceS5TmPB6KsDn1JuPTqWUMHj582xBaS78=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY8PR10MB6852.namprd10.prod.outlook.com (2603:10b6:930:84::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 18:06:11 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1ae3:44f0:f5b:2383]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1ae3:44f0:f5b:2383%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 18:06:10 +0000
To:     Wenchao Hao <haowenchao2@huawei.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Richard Cochran <richardcochran@gmail.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <louhongxiang@huawei.com>
Subject: Re: [PATCH] scsi: libfc: Fix potential NULL pointer dereference in
 fc_lport_ptp_setup
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wmvql7nb.fsf@ca-mkp.ca.oracle.com>
References: <20231011130350.819571-1-haowenchao2@huawei.com>
Date:   Fri, 13 Oct 2023 14:06:08 -0400
In-Reply-To: <20231011130350.819571-1-haowenchao2@huawei.com> (Wenchao Hao's
        message of "Wed, 11 Oct 2023 21:03:50 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:a03:100::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY8PR10MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f1e937-3ad5-436d-698a-08dbcc17148e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJIEXxI5RNtUF5zvXhyxS4TmHjckR7sw0DwXJ1epEOhcYFL2mfLbpZ1MXaMTodM7oV+TvgJLlbqndI69QkGdLaMtX0s7CxwTZaZwqc5J+uVLl7gl+KFMd2oH3JtVGmn5X5WxlimOtJYUl/ebI1tnk4CdKlaRGKM8b4saTDE7pWQoXz9ubGegR+GHT5xf6swnp+6EdurWHVgLqTEV5L6SfTB/luFOob3A+JPWkpOk234CpmAp1+6dC1vlyL+KAvpbn4uQT3yAjCJLReQ2Q3xImJx1IazQZ8hXyve7PQsEktTIy/QF39daFOJFd76VxABrdIzjHoofHyMSyr+Hvmr92uGd/nPWevUuaKOAmtLZbVaKZw7E+ODZPC/x0EVDQsPe/9M+mYVoYeDBdc3Y3qezerqBwSigLDBHRZ2RyGFnmxRA/30U8kLj6CEL4D/bNnBfbjqcyPJrQtNIEet+xoHcJwViDebYawJEd3XZYWNEA4jnrfGSL4MM7fMJFeTFEwhF3G/7ruqGqCRY2nUqHHkjoagLDZeN1aiQjneuUhGLgf5vKVY4xKIWXUVSmFQ7GV1/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(366004)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6486002)(6512007)(36916002)(478600001)(41300700001)(6916009)(83380400001)(4744005)(54906003)(66556008)(5660300002)(66946007)(26005)(8676002)(8936002)(316002)(66476007)(2906002)(4326008)(86362001)(38100700002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fq9Vu14BE9FBTbs6nmPoEUpyGraa7lDNly+P4kD0UaQfrxs4brW087+OFCy5?=
 =?us-ascii?Q?Z0Un4taqn9irhgQEkMDLJtZFj+AAwgHMvxVtsOvyZsOKlUuOjTtoy9Esfr1O?=
 =?us-ascii?Q?BNgd7tmUf5GIY5R5lh3du52VKpcSfyUjua5n3zc2l93p9ZvPIQHJB6syT15b?=
 =?us-ascii?Q?cOFH32cEDGaceNM04d4g+zgyzUnQs6ci1OuOWv6SZjp4bPJyETKSuIHubS8f?=
 =?us-ascii?Q?Tiq/y/Dp93SkCpSCUYtKG6l26Hf51OuUTNmJ6l+xnSU2JbxLx8tRWlr8/JE5?=
 =?us-ascii?Q?MP0m2VxfXp9zKAGFGA1qbuQIw77FEnDAI4bnzkHJip1F45EhXLCic2hkLIz6?=
 =?us-ascii?Q?ATtBgEI9N+Itt2JQ/Ax6sX/MuAY+Kx1x7VB4YJnpLuOM2fMN0gmqpJf+SIyA?=
 =?us-ascii?Q?5KJ8ko4VHQwdoj/z2kOUCF8MoFitBVeY96+IDIV3n/qwXewIR1vN6GZxwsww?=
 =?us-ascii?Q?oalbA3Cqmk+rpdiF75l+LWespuGPpEo1jqsrVyNd5eOzkYa/h98ES3PJRhac?=
 =?us-ascii?Q?VLqQ02MvLlvl6sESDC332yEaROxC68vMEt0QWL8sGxUFgMPJG73gklXoMgON?=
 =?us-ascii?Q?t/d/A4WSzhsjPdjUojqIZd+48Y7vIW4TrUjJr/8ZXBkvvDKNcJGPalqapPkm?=
 =?us-ascii?Q?h3oBpxxUB0/hvNX/nF0606xCXB6zG0E0rnD9k6VIeEiApl1s5Q24bLehG9AP?=
 =?us-ascii?Q?6nPeEZM7G5MBc4uoLoG7+dAx2PP2JQgv3ASgHS7hwszrDVC0iIzF5eo4D+QN?=
 =?us-ascii?Q?0eT7ahVKcEKyNHWKPgI/hXWl3KqadBC3Bs9CxkmwPo+pnJyl1crH3lHKd4Jl?=
 =?us-ascii?Q?y1QExloSrSK+Sw6L4b0K+Co0vJjhx7t+RFDgH2zVDkw4ivqwu/ejfNQhzpy9?=
 =?us-ascii?Q?bpZVte4BDrdXBYrVyE90M6KkuqyA2gY4ER0n/DByr8JTbLhddt/l+Sr+x0wA?=
 =?us-ascii?Q?d1BPIC0/Ki+HS7LP9h+ME5o/AUUScKiXlTwpERB0vmfvOfaW5x+dPg7mzjVn?=
 =?us-ascii?Q?0pc3O8F7HouxOCLewWLR6kmjKSb3QAqQ2gIw1YB04njDfaQRJkHT1/tfboSC?=
 =?us-ascii?Q?k9LjtLsk9WBv6NoY8zmf2SrHZ6kAEvC+iXjSwI9FnSBMmVvOTcys5eEc5uRA?=
 =?us-ascii?Q?7SO7uTAiFIsDjtvzWHsvnOaypq/GfPfxPpEawjFCPxXX/1Akf8xRtyK92sUa?=
 =?us-ascii?Q?6BLFvYJmkBKDoUwO+a/c77OZ50g8BfS+dNFvyhzXhbjawX0IbgZKvbtaOBgi?=
 =?us-ascii?Q?0o5CmhyvR896aCb4rqtHjpZNBp/Bb4T63F2QWnmyA0JX5MYOanyj88/uuvs6?=
 =?us-ascii?Q?a+OjYhP3+8xj1vpVTnZzbxGvK1xe/7Ud3dI08Lf1GfRZozIhe1xwpJDopmRy?=
 =?us-ascii?Q?JF9rihd/ak7UMm9xjb15PCyj14vsHfsk67c2rxXLSae3L8s6k4sp8Qwkr/8m?=
 =?us-ascii?Q?5ESIH30ZD65kpplZ9eT5BxwKnEcQyylzMDtZtzYHojQDsihMwYid8wbYA9IP?=
 =?us-ascii?Q?YJrQ8eofIpd0KHSO24v2x1jXEXbWCkdQtgA1ZXUutoRM2TT4bjot3Mqa0+TD?=
 =?us-ascii?Q?FZD1+nOVqD2j3JGeps6dg99x0h+M3ANsO3bGYtbfk31cSs7Pp3hPHQ9jGP4w?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pCkL/2vyh/jUlt2aEcKF9LN7aC6bNTSDUtoZxXWFi33cB0pI5L9qNqAMwJj7LN9GmmbAQX7fSp7jAN+9afoYEQnuLZexMn81hqZ1LZVMFn/C8ObPkp/e26HwoAguWx/RZA/1mVtzVHAlSRk/rvZojEfDoZ0QeW3FK/bX8kV2hNdSBqZKidFwGZqgBdZSwayAo+PR+qrSScxU32h0evr2W3HRwrjHoKy+p2f+wn+fFaKpFfNdtq8s2be6qtN2RiDVBeyTdEJa+7JzhWCS0yn1vE751g4Kc9Zg8l71wReCKrx7k0v2caYaCgAjrWropL94IflX0eYrk5jnHfWv/ILRNbIwXP9mliyl8QEbNOZqis3t6dR9/oDoz7Zeq1SexLR0T8xhGR70W0edTvm0BRTFvCHvZMliZrUs4+6dJgtMF6TZSGPyXDtyIXe94QrfgRRMNp9rHUyX9oR9yFXDt+BfZml8IlNUyzJapMNbMkkDzxQOJXFxgEl5vN6XH5ao+1x86ZH3FVf/MeFCPxHC22YrslKRLjVLxaSh5O/GAvpNXerB+m8xOw7zRC+4B2+QjG+QnWVGXTM3SaxRCQTIfaEcmCjB1bhBFwxNvQX+OhIOQlM96XPtooVa0FxpIg23h6xMLifJNO6Bs3cxkcxC0DP9kxcLChjfvc+3QOI873x9lQT4zTShD4MBtwxnFLhcEmqcPBRStWvt9xZcwDZZ43tYVv7AgTpa+yd5yVa69LVn5+dJiAMWSccoaWR4qIBK+ikJnnV3pciFLIDmW+7NDPkm8fuBPIK9UtI0UEO92MaLvApzwnFFyrOlQGOzZHYTTVKdAjmUMuD9Lug/2n3ECkoMhhY/yQSm5PcJuVpapxtjQx0VJ94WCX340dY3vT9YFmzo
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f1e937-3ad5-436d-698a-08dbcc17148e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 18:06:10.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3THSkyHbJbtf/SHvF9t29tm1HIcWNZrycX6Wcfnb+DoMytwiLDH3rncmhCmBgJ3ASt+kvS9q9Kr3LAFkPNhkqHA34w4dXCAr5+oOxSCfE6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_09,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=807 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130155
X-Proofpoint-GUID: hPFL5b6Mf3Ke0q4ybJ1XM-BFMvOPfuE-
X-Proofpoint-ORIG-GUID: hPFL5b6Mf3Ke0q4ybJ1XM-BFMvOPfuE-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wenchao,

> fc_lport_ptp_setup() did not check the return value of
> fc_rport_create() which is possible to return NULL which would cause a
> NULL pointer dereference. Address this issue by checking return value
> of fc_rport_create() and log error message on fc_rport_create()
> failed.

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
