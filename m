Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EC979F635
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjINBQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjINBQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:16:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03941713;
        Wed, 13 Sep 2023 18:16:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DJG0vI015364;
        Thu, 14 Sep 2023 01:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=DH4o36rFvJWDjMj2ew6Glk0/lNgA4vmJi+mJX3RDrUE=;
 b=uXJ6zkxgLWe5ZBuXPJ6bAcZPPP843UJTkQg961oY7VMM2zP23NuZpNpIKlhGwp1Ft2bx
 /i/wEk2DvNJaliVGDisvTXnYCWlM+CWPtOVKRlR1PwJLB+FNiR+neCLdvij+ITv+LQ8S
 W+zYfydQ1t+U99FfN4TDBJI73fShbtcGWABKYyDOkDjWAa4jAZVApe5kdvhWl7MZEAwV
 TveubdTJHMZ8OVYUwPPuV+r6kCtMKzjFvtKLL6GAYra46Sp8FdK7oVwWatViyPRLRPTd
 dKdRRD1h52XWbE6TvjYo9XqL3y0ADWlyZ/4n1UiWLwTRIvXe9BxRFkK+mm3m+YP4WHz2 XQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t37jr2x7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 01:16:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38E10Ltx002351;
        Thu, 14 Sep 2023 01:16:31 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5e9m68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 01:16:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdHghhijFe/BipZfQDpbeGvNjh+rzwj4RkMXYANRREhfWDf3UBkdeiK8D8Mr8o6zq9L0WW5ADOLflMl4zijqo1OZdEtw58ndx+5EL5QJt2jtGAIvX1/nTnxwY92OeA1wVMU95Rqkeg9dmpPk0dWaNApHJED9Cz7hU4q9+CEuNehgsCEwVeMwHl4Ptcbj5xOOSa+7O5007P8gQVQu4+mR74+9JCfZ1jMupimLR0jbQAAb5NAZHoQNE34NiS0ENDlDUderCMQYSif3PUr8OJiUdqJNqN3/XkwLZ7aPNUuzSIAFX4eP79mmOjJH9iS7yr1AKmbna01XLLIWJaP54O1ECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DH4o36rFvJWDjMj2ew6Glk0/lNgA4vmJi+mJX3RDrUE=;
 b=BJM7ZkbD4ALMqAhvztICvt8RqzHZ9huZD5WLzA7GKcCD4qobFZcrkkVkOy5XieL2vE6R/s+UHqyFu0XYlHmdIwrNOORLICMa5mMiTvvlywq0jF9choLYzZwnw3gdop7od+8KMoB4EPLfocdhr29/VDrrRWi7d4wWF95kp6kPugOX3F/LY3/LGa5NUpWlYka0SQ2IMi1bZzb+CdTC1L7ggkzvhFvU4Q8NWHx0XpcEjwHIl+yoiV0LOeQeZYXIvqbL9SbbkxEns0DqrCqgTts+yaIXJHLaBH4TUP+0cLf3UlSP/4yQxxh0gZDr7vH32yY3LYI8DZNkaBpvPn1+pLca7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DH4o36rFvJWDjMj2ew6Glk0/lNgA4vmJi+mJX3RDrUE=;
 b=esGdEaojfsPrev0vNccAl2ND6eCrn0IccfajotxS53fxD7dFUxbMvorMj/SYHOOKBmENz86C8kLrzEZWRuzrzC8UTJpfL+O6RmUMCHxLjFHwIj3LaBKzJWKaD7RjirZigC8VIX8Jt6DxvtCQYBdNHuRzkaQ1JU8nioMI18X/JeA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4589.namprd10.prod.outlook.com (2603:10b6:a03:2d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.36; Thu, 14 Sep
 2023 01:16:24 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 01:16:24 +0000
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V8 0/5] scsi: ufs: qcom: Align programming sequence as
 per HW spec
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1led9eeqr.fsf@ca-mkp.ca.oracle.com>
References: <20230905052400.13935-1-quic_nitirawa@quicinc.com>
Date:   Wed, 13 Sep 2023 21:16:21 -0400
In-Reply-To: <20230905052400.13935-1-quic_nitirawa@quicinc.com> (Nitin Rawat's
        message of "Tue, 5 Sep 2023 10:53:55 +0530")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:5:335::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB4589:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd76212-b717-4827-71e1-08dbb4c0363c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vzYNXOX037rV7jhJr4sbPjWB7UnG03q8HsZ3Xa+chZPccKkTsevHSd1uW8efwIxDuXeTl0uPQL6LEkPG9DeM7NocETJY+HynrlOFf9H0OYqGrbWG08mpumAOnx4qDPMDJ+fqvaUd+xQAEW61s0XVml+OykVpkuFbIT++/g3jADEv2+Wcu6d5fDwbaUUFjbZpBTkp6IYnT2UWs29E54A6EphDakOz0AIu1QdzCVerJmHMIzNOk1oKodRGSta+kwpBfw9jv5fubJxmbnt+40NBWixed9mBrI1aFPAtdEKFhl9TVXeS458F4grnqOCkG4KEKFwkiJTLfjZISMItDi8gjnt6TYDior+B5CveZ896XKh7h+ep8W4tLeqL+i36pRUjytlgVoi/MwOSYXSH3gp9Uu+YoGQjTz9zggwziT62kp6K8dhbFRVjDpAWqzVKLWq2E+lrJdOrKD92PoMsxlP4pf7wQqI1H8eKMJCosIi0WECMv37WK16GOJq3Y/91G1sDv4RKi5FqbXqQJoNmWGn4pUuW3KuB0Q+K0oQqg8XupDgrXpKlMGntj97ljqGI8S2A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199024)(1800799009)(186009)(6666004)(26005)(316002)(8936002)(8676002)(4326008)(5660300002)(7416002)(41300700001)(66476007)(558084003)(6506007)(6486002)(86362001)(36916002)(66556008)(66946007)(6916009)(2906002)(6512007)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0udxdymAskTkwfl1/0Zf0N5iOP8copSamx9QzKMTxu4nW7PeYGDYbL0s8ma2?=
 =?us-ascii?Q?vo+41k3R0pwN2EgdrgFj3F2URXtOaL9ACPdfqrCevhWATOAiVcTU6tCMP5UP?=
 =?us-ascii?Q?9lQyq1zEPuX/yO+DotG6K0qpcNrx8Md6yO0O4/R7EXSvR06FgYWjOjI0FBDn?=
 =?us-ascii?Q?0m/EtEmgFZN59yMYQmDnf3sLaEgjzBxbWgnp1ri+DQVMH0C3wPSBv7dNiK1O?=
 =?us-ascii?Q?KQJGEVBNCM/XrpvpX5q69oRDcW2snOhZieVYbobX2M87xdpeAm1Gu3K8cUjK?=
 =?us-ascii?Q?K2GkR6aQ4gVrnKWyzePQMYr3y0aUSL58jIx7TKOYmI9SDqE2au5D0LLq3lFL?=
 =?us-ascii?Q?qofOyvugd8/nHOTjyEIMHWU37ogGlyTCXNKkFkcp9FjFx822JO8J6GW0hcLz?=
 =?us-ascii?Q?/yZgIjBJLipR5RYHPp6EXc9HFtGkMZylZsZrDUbOy/WK4VORANFQ9p5GRdAC?=
 =?us-ascii?Q?RQb+9WbqLn+D0+SgZSPmiZaGYahbGd+0uMzWONTku8iZK2lABwQGO/VSyEft?=
 =?us-ascii?Q?e3kqzOlQ6r9RBPcE8jxTBDMMwZAaZpex/5+teafHCg63W8nokOx9JqBKrxiZ?=
 =?us-ascii?Q?kunBmCllIPoG3XooAaUm99dwdFPf1BDLROms/zkHMS5wE7oFbaiTkmzyeCDH?=
 =?us-ascii?Q?1yIYFg2rIr+7CYpTWR4ck88RU1pqQs9gEpFVP1wDXoXN8s5iyyzxs/vZ2pIq?=
 =?us-ascii?Q?HeGOU0yfGyXjR/cffSbXmFUBqNWI96O8cs/f2AqByMCHpT3wZRtW3hTTKDox?=
 =?us-ascii?Q?P+6uzF7tAWWU/owaVitH/y5hTppJ+FYWVUl0wqH1yuzOSy/HWJpHbFTh+660?=
 =?us-ascii?Q?rHLUPq4ts058g1/iae29x0F0VKsjFnQPh53UDpcdO/I+lF4p+4a6PXuLPZSq?=
 =?us-ascii?Q?QKmxs8xYXkIebqLFk2B+bY24Kz3xp4kcrzUN7wuUpeT9/LMH0ANNsXhMAnp3?=
 =?us-ascii?Q?fF2oBUD0U44J+ubjZTFw5tkDmYlKi5Rlionyy5OolgDezasTKPSyNBySYoI+?=
 =?us-ascii?Q?LQ876xN/EgDeBLk+stJhVQxOTAgROTCSlj6oZJjFIeuoLP0tdteC6eSaNjNz?=
 =?us-ascii?Q?/J6ly7/85hDXJGCxCG3qNyS8r+TgRXT5b6+yvU4VREBZ35reFfn8A2ymvmYY?=
 =?us-ascii?Q?l5wuJTiixm6YRor00Cp0Q83lsH8jFPXVB5rqCYqmLUEaXpYZsncK+4RjHfCR?=
 =?us-ascii?Q?P2E68XLOfAXb/uS0sn8ehiKhadet7lfWp9hN7H7PB534PpXBRb3uLijjz+FP?=
 =?us-ascii?Q?8KnZw8dtI6PvF1UNbMcfSmIcuQob+7iCJxQkTKdHJ1SMmhDvcbe+ZEevvWW4?=
 =?us-ascii?Q?9ge+adFyRDGpNiAe98UDkghhJQW1VuOCV9RT5KDOit6Yx2ria932kW92K/D4?=
 =?us-ascii?Q?i0QUefumFsnAKgPOp/tH3gyX27UqMOx+wLmG4g6lJv7qW8XR6U9+71S8D31J?=
 =?us-ascii?Q?l4Qo/dXz2BfC/V6yOtCquF2OH8jQgOgK2/mEOFQV5cZCdfog/DRptKhmAybc?=
 =?us-ascii?Q?nQ0uxyMwQQy5X7vf468XJfDQpL/6v4aoF2wfmhxvTF/N0TWaKZG43347TsGx?=
 =?us-ascii?Q?swoR0dZOk3Xvfoq11rcmWxqwJL9m8wbN/m9sy1mX3LH72KxZoepquhv6v1bl?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VAd7cIZAcz0HpL/WAZpyzav1K9Skl35w16NUqdFj8SYdl3A/HCVauIscSKfew0PRFN+fZOCTZ8PmkuspmZBns+XqNafz7DsSaDPeu+yr+J7OnmjLjvZq2Jvs266dUNcoiaGnSl9j3b05NkttBx7a+FAQMHxDwyVy9LJL203yXV2StHJSrdQuPTJy6PBPtSzmS40iQgxs6PDFRliS+ade02NKS94XHEq1+XVP6n6xEDj3J8oVW1Vuq+t075120/3vTGZMGkj/KGYf4zIoDDIiO2CYZpKhncy5YFWSLHSyQbM30r99MlNiFhZTirPm9dIJ7SoaryQgJpLQjJ1tKIllJzxN0O6PK0EOlfRTxXRejosrQU3+qVMpAaCUdmORIUqLDhspf8KxT7I9rruhZLbzYCgjMLx5dQHdh6XvDOI8wV/a/N4f3ADusEMvrItB3UuZvlhSpyY5mIVJsCnWK0b/A67cqcvz/9DKWt8oz00A6nw7M8B7MfXpawZ1u+YF0dn+fueai1MJ3KwfmPb+A51S9yvjyl/iCz59Nw3lSyaMY966tbTWCqfl0qKskT9k8VgK9fr3SPyU78WkMcjKdS2fBsHAePLrN9SIxIQYPN+8mml0hx1Qr4H4gaT/UTt5bZXj9fFwq5I09OvOjoCtm9krU3Ldl2HtRSTa+j6ZBsv+0mDIRkfXDawhpS5DuqpRntwpyft75kHMSJyYIzCxOIVJgdJXRC4d6+2BhTif16EplI6m5oTkDljCxVIIDkdbUxuEw5Eh7H/Lim6seTQlh29UI8pkDb5YWR6Yn/cwImg70B14+fpN1GDH2Py2SlUSNXguiG7d1PHYP85I5f6KH/xzx+8vUJjK71LurdB7aV3IOlMTi4++3GbIhmBTYxyKiC45VAGsBuLkhhDmhwleTlkECg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd76212-b717-4827-71e1-08dbb4c0363c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 01:16:24.1120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ccWNAZMRV5vHNI9c2Tc2S8WraB31xWeJdPV2eIB9hubypmoE2dthhpbyoZ2t/y+mRc/ixKyV0u8hx18WwU0Dsdg2g4VhJyJNcJRLE59xB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=488 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140009
X-Proofpoint-ORIG-GUID: GSysL6jLxETVG6gj8dH6y1fTiWkrLFI9
X-Proofpoint-GUID: GSysL6jLxETVG6gj8dH6y1fTiWkrLFI9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nitin,

> This patch series adds programming support for Qualcomm UFS V4 and
> above to align avoid with Hardware Specification. This patch series
> will address stability and performance issues.

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
