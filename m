Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CBF775025
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjHIBJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjHIBJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:09:34 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33A11BFB;
        Tue,  8 Aug 2023 18:09:30 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378MiFMY019954;
        Wed, 9 Aug 2023 01:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=npEtDJP3XCnrPL1feDg/Q6wHp0m5L7vFcu0U+xumPR0=;
 b=34JI6IWrWPQVE9sa+5aQPvn6EbUsTxwjHL9EZ1dApjcGfdJNI6wae41nFcgw5lbTCa5a
 Hs5eBvtwkOA0qU6T3C2OJsk9N9l3Dr2LZdUg4xW5s8DryCycViM9pWmFrfP1MljRv9Zq
 LAVvDDXUtcwHDJu4DDao/oidWIZvMSW05qSmn9i06MYyFdGxCcBIdX0gce4pb+qdkm2y
 K8jUVx18hx6qsjOu4dj169cthwMJqH1FZ0yFIbnYvlyLGv8o+2mXqXzRj7gtviM8nDgm
 LeiWrnF4IJX3X1iUfx4u5gV6sRrR9s8pYOlr2OosNRdMf8CF+L6BKV4E6P1AdNo5SD0d 5Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9d12f5rb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 01:08:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 378NwGTu022906;
        Wed, 9 Aug 2023 01:08:40 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv6uj6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 01:08:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ln6DY2Iru8H3w9UDZFNYPjLD/UndHHuL3A/9Y2augUfr2UusdeMIj8pKuuvdKt00b6FZoMI1tZzf4d8s+RDw6+MZEDigENzXCyP5gwPo1oOfm+bpUb/7av27X+SZTCXuADsAvpsaqzbxdnk4ONbIhxr9vKj7CWWSZS5K9RvIutKNZPUN9h6N7MFrVHjGPN1raGAmdsVAJmbhYb/zbMbH/UfR54r4xuAfXaoeGlYZHp23LAse3fJOapVhfTxpjWNvEgkNTDQYz+s1Yo+F8PMiW8x9omqKIruLnstqGXelAc1M1dHFAjlisS39NLFHEXh0c4yZnrrAWxYf/yQ9xh3pJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npEtDJP3XCnrPL1feDg/Q6wHp0m5L7vFcu0U+xumPR0=;
 b=afF/W2y8CkhSqkkyifk69vwyesfHpDaOkSjS4k6O+jGH2MGTQhrCqIj2bmgjndNwpMQhEyIhDHOIm0W8Yp6ZUku0wVjbEuhMqgwxNetw4LwQOq+j5SYlajEh9r2nYPTNdhy7FUmE8900Cavp1eo+qcZLwA5+1m0OgRy9F7m5t6d87g6KIA0Gz3yTk6AJ7yU4eQ3bWcj+L/ihNYtHlrufoIdEAZC5pZpPDLN2Ed7EfrBf7dyvZUuVksqplCILOLNgre5hZB9/GJySI+6El/0fMCg87m/pVJ2iAw8aKV32gAXkv6Hi3AMjDvBbZKrxIxff8NeTGvv81fzU/qVcCrhE+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npEtDJP3XCnrPL1feDg/Q6wHp0m5L7vFcu0U+xumPR0=;
 b=S9RWRj1USZj0Xw5NPU8H8L4eemiN1Nr/V1mTj3LVOFq8KTBeaaiqi51dbtODz/CgRYGZdmj7VATUm/nNxixP419NdvE09xgBMfSihuFzhnAzzGeoYZLFznIEvlpDT9Hvn6eOi2PGOBhS030bP206CwPOqHXHavRA+gUkB3grwzY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB4877.namprd10.prod.outlook.com (2603:10b6:5:3a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 01:08:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 01:08:38 +0000
Date:   Tue, 8 Aug 2023 21:08:35 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the block tree with the nfsd tree
Message-ID: <ZNLnE5VHprCMAB/e@tissot.1015granger.net>
References: <20230809110334.63b7c566@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809110334.63b7c566@canb.auug.org.au>
X-ClientProxiedBy: CH2PR08CA0030.namprd08.prod.outlook.com
 (2603:10b6:610:5a::40) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB4877:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c5f94b-458b-48c4-221c-08db98752989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5aoeGR/YSRYLpTPGxeadG0ah/zrhDolcJvUlU4av71KZfjMS/4pmWWjoVEIFNoMWNdDJu6zCgYq/fiNo3LgqOjIwQWX3ogbYQQf+rf5gTBGwhAtGw2v4ZS5UUtJRE4JZk/12W4ZUY+vFCzZZzuZLyzMgyxcoiU4Sr6pVue/N4A+chq6UahGgmtyOVaoMHrlD+K29djHFoCNo/jATN/H2V2XlVcaKAO1Tf3muQriNP7QMRZg4C/fNc0wYViXxaiAaI5EPSXNg7ymd49VmByo/hjo6X+SnW3bLKcwLDcLseOduiXfEeCL2f5Jw7bxh/EqKD/47BApD1ZTrNRRsFxflYM5V3miVco7V45gg/vDQD6/IOcBjXEOyHT3vYRjxqqkt8pFa84Kv61VuQLm7yzH6M6CMMmpjMJOlH9QG7ZSPZEyVVYpNkuITlIVzwW6Kogm5MAKqzW8ZEKJF4P2/u8awMZkkVOLscgPOQVIHlou6+b9CKpcNSchpZHoAIYY+6YRsqfQ9iL5Y2jht7aCu5I8yBIJ6nnYBmSyJQW/bBxy124OEDUIfCYxD6DJOXD1DDGV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(136003)(376002)(1800799006)(451199021)(186006)(8936002)(8676002)(5660300002)(44832011)(4326008)(316002)(41300700001)(86362001)(83380400001)(6916009)(2906002)(6486002)(9686003)(6512007)(6666004)(6506007)(26005)(66556008)(66476007)(66946007)(478600001)(38100700002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nI6/N7zTRHVIaQKSfvqrwk3Udw1eu7kdC8sGFz6ykOtnxOv+sm4lSJmsmHf0?=
 =?us-ascii?Q?Vb1H2AONydRCsWwQxjv4zErIzv9/zeglOkMDxi3zX61+Nih9N2nMNgGcyAdQ?=
 =?us-ascii?Q?nzAWrCdUIfbjQnvv+v3EMnmTEyaBqavXzou17US0SmSka7xoACaYR58mUAS5?=
 =?us-ascii?Q?38Kl0/Hwgk9585czMVKpKaHnM7DntF5Fj8Kf/a+C3/1GDW8qO8TtqhAYhfBM?=
 =?us-ascii?Q?9TN6GunB5eVQvn7/q3+80oIG7s8YKUTTUuP6fUa4qMqzO0KSzhLi5rRJP3aZ?=
 =?us-ascii?Q?2qBsh0kAq0fz3bUrKaYig9JdyrcaKCJD9Lfrh6TkJcC+ZHrcB+ofLu/h4r68?=
 =?us-ascii?Q?iqfPFZSUPmOrYTiCm3S0kXRROh4vpGucgh+Q/c1fSm48sq9oGMXblRxag9EK?=
 =?us-ascii?Q?7uVTudz4/7olvhj8SObwIrDQ6eL3lYz/pSLZd5QlXrsds2iUWFAh6FVVuSzg?=
 =?us-ascii?Q?7LNC5H2xoHkUcb3j+8AVvs3xHT1w5r9DMfXZmn3kaZorLcrM8BpDz5/CpKB8?=
 =?us-ascii?Q?iCRDYojUMPCRvDtW+Dz7W6ydMRjJUi8NO/7pvAk+L8jtyo7OrDPDjrElgFrh?=
 =?us-ascii?Q?v+OE9r+kr/+tONQeJMN2bo2j4brWODVeYQRAx14KQObp22fxPdpIK4gORu9p?=
 =?us-ascii?Q?5aseNlA227RtD4VJOiTF9t4qohmRtzwBAMXCr2kayiJaZcLF1qDEH2uiu2RX?=
 =?us-ascii?Q?nVtcVZLE2IE1wqtIOIHAUoxXFpYCXPWSVWWfc2ggOUNHBzyqATY8fJP0CdXJ?=
 =?us-ascii?Q?/GPMpmnUAwKiweQNZr1oRONVj5rygyX9ncs/xS1mNYqDHZn8kMdXueYAI+bQ?=
 =?us-ascii?Q?UHp7ewubo924B+W1OeNSdlDLCMGcNCGFp3zAswTviZUVuyQCC4YpCpidRYi3?=
 =?us-ascii?Q?9hf6Uzc8HflssM2Lwn90MjwqjifEFGutAHQdssPo3sc7GVf/3uLw2zEODduu?=
 =?us-ascii?Q?TpTFWX8EiBfwYuDCNfhxdFO8UvoOEJ5sQ/TJ2+wPnidLs1jKZnHHxkX50EUD?=
 =?us-ascii?Q?a3kvlYqq43XHONoZpCHtBKykCE3i1KAmzqHJ/HLGLNEJIbLboH5fr7XhA210?=
 =?us-ascii?Q?afhoh3HSjwdf+I6ZZvpsvs+SquIlEMHRfCWEdtFx5cN+XMUX7rYZqhM977yE?=
 =?us-ascii?Q?41r7A0kDyArL3BIavgY8cPThjFFz2iFlkS4tFfvRZS4uCV5uNHVYfb5eBrox?=
 =?us-ascii?Q?lk8hIde7koD3t20CMu+zfCfvvnSQCFUvi8wg8hDIBLO+U543aOvsP5THEofp?=
 =?us-ascii?Q?qJVfoH+ctPf2mcvlIDt7ty1k8vnaoFuTsAaaDnL0Pmkc36Ys37JTStba4s3u?=
 =?us-ascii?Q?7edNj2yyyEKAMagZyvnx4psEHftcWL77o0H7GKHeS73wAzEVBedqD0b+KQ3n?=
 =?us-ascii?Q?lcaq8bSZzgXZgcDRszyReB8QjGqHBeO8cRAqf3VenSWPfvZ9mLLbK80UbUNB?=
 =?us-ascii?Q?PWKPuR+KLQdULpoWZFAI6+DGavcYuFaHOsVq9f0dm7Cf6JAnSI2Gf7rnt2qw?=
 =?us-ascii?Q?3sWkRlz0OfDvxuRbPQtpVX+42uL78rbux41szHjJu7WT+xdvBcU/VfjhoQIM?=
 =?us-ascii?Q?D0TS6C0VlM57QweQgZj9dt2X5ue9g2Wj5ObuYzZJ4/rEMLD639aQBa692nXh?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wDKMjHuFKBngbo9jAklCcioF6/qbXtTsmMKB/NgouPL0TsbIuKa/HUjP31ZFhrcebrSJD1s35ziUajco9oQkhBXNzAeTVE7vmCrrRCMfjk8Wr/DTQzOowjnTELl3RLVbLYLsLXfov/sIFD2BW6ABIJdamZ74fBvLtVbN+tj6ff+NdPde49DJxAma29nlSKhflaaWNM3WU6w57bRhDAwWePwX9OFUDkhKrQv4CmCBBMN2nP9Rt+iBs+HiJtPrMrztD5LAf1xgI9zRFve+i6EK/g9xBQLcTYGM9ZbxblacyCUN5tnIK/fGI4BePQ14rJwkr+kQKggxPT+MJ1iApV1fsrfz3y6T6+VqJjphp8vt7HkeZtKlCqe8qqTqzGStkdvxBgZx2op+OU1XBiFO51zoS0LtF4ZLGCwzLtzMIoYYcMY8Wnso7UBWmTb4MzenEM77HPo3B8Y3yItUDU9HvjFakeOv1tW+6oiu+TDYgoYHeQYtbgYyLuo4MXhzmlEbATP2YBqC972K7SIqCD8jOeCs+pm/pVSOydTNqJMLZFtDI2qHUmRqoiVYeeYXvSFc4qW4MiiocY4jkCYz13inMh7nGiQ5uTPIdyTf+RVj4XzS7Wj/IyJfuYdF1F/S9XWMQiTg27lFOukny42I3Xm6q8uxTUvSrEisZmgYNcMk2FatJs+dMbAAMUhVbY/x+RLBi+dTgvAzmueozo/hMuFRBHUyCZK0g0ZvxGE8FAQEI5uBOo0eLnECZGkH+N00l0lAHaqJINaYeosYX93jxxssLhxluTR0gtLoa02H1/PmCFlf4XnB6rU1BZXx6XhhO8uIahKIuNge/tg7kOKjJqjo1meIz8RuTHNjN2escjbPPHb1lgqn0ODlISTiYdaXD/fzYyeB
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c5f94b-458b-48c4-221c-08db98752989
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 01:08:37.9598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYHTVaYisJPjG1CCZaC5QjRa1Qbu2c5ojX9rHR3z2jkHZQpeqiTfV+AILCklx58RQK9GeKdViQzMaxzeH0aOSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4877
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_24,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090009
X-Proofpoint-GUID: VGxakPDzL1G59TfDPVG4pQVDk47siFmb
X-Proofpoint-ORIG-GUID: VGxakPDzL1G59TfDPVG4pQVDk47siFmb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 11:03:34AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the block tree got a conflict in:
> 
>   block/blk-flush.c
> 
> between commit:
> 
>   bed5a600c6b0 ("block: Revert 615939a2ae73")
> 
> from the nfsd tree and commits:
> 
>   28b241237470 ("blk-flush: fix rq->flush.seq for post-flush requests")
>   b175c86739d3 ("blk-flush: count inflight flush_data requests")
> 
> from the block tree.
> 
> I fixed it up (I used the former, though I wonder if 28b241237470 fixes
> what the revert is trying to work around) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Damn. I forgot bed5a was in my public tree. I haven't sent that out
for review yet. Stephen, please drop bed5a, and I will remove it
from nfsd-next as well.


-- 
Chuck Lever
