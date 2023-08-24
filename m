Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40D4786455
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 02:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238931AbjHXAxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 20:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238957AbjHXAxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 20:53:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF2F10C7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 17:53:37 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NKwTSi017396;
        Thu, 24 Aug 2023 00:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=2ykBkuCriaAW7Ri2AO5rY12lkly3B42sWtdLJy+W/dM=;
 b=G6LTF5wqV0ipP3yn5lZXSQGqp/slfvSMxeepkBduS9HuBkoCCAfvjNGkAG9O7uPv8taa
 8fSntXz/u8k3UPC33gK+M57dpHHL0K8OcZZNcJEN+hekrMrWpwsD8E9eZoIcqplaL2A5
 7OvucQenStn0e41YbtSh3QbKKKZ8/IU0CEAKAVnShO104JtFEVIzx45WGdLEW9137/cL
 29j7naASpAQgIOVpdAOqKnZAscmSWmpWHgc8p1NVPgd6KI7bg/J++Sb7k8Qx02eL6afW
 mFKpATdOSCB5gk+WJi08EUm12RfUnNopXv2JdS/oAfy4j94556M9iaSNeJhTe4xZ6v5I 5Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvu4bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 00:52:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37O0UvJV035981;
        Thu, 24 Aug 2023 00:52:35 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1ynt8t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 00:52:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bh6zEefKhUKuxb+kyOTPt7Rpv6P4bkRLkC9KnyxGz0FkM41LhGbCQzQ7B1qWq2Kb46dKBS/wkU+JSO0sJ4+SXuvxgHoi8VEj/PJPN4YBnL+5vRObTsmiZ/MIVXnWvZ+axUz0KTB7/c+I2SCLtEemR9uhyM8hsXDvvzkXvFbXubMEKOXAIvsrGdl8rPsqd74LDt7PfaIBcvXeyJxslsL/M1PsAVUAkH8xsQ6QLl+fgrQQb5VHjT5kMVeXkSezrEHYBhwLpAtrcs2/Yqia37rpWc5S5P09ADJKFX2FRmf8CRSGH2IPngWrjUc+/LPZOv9T/JMQGmXsEGnfaAgTDhGyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ykBkuCriaAW7Ri2AO5rY12lkly3B42sWtdLJy+W/dM=;
 b=HECXKpDbV4ioJHq6SLHJg2pZ/4EH/X2y2m/hcC89DQHUBoZtyVnsUm9hnepGTZlo/iSHTzPHkLrhBlH45Y+ggv0BIOnZQfsHq/aj0+uUAMulPh2O8zKho9HrhQTnCWzW5M/vJAaTH04SjZDgvuvUhVkVINTFccQM/S0UxsaGZ33PT5OIMKf7047xERkE2lgM4Q+lhubOUz2H1K5GClg0LnpLsZds0REjbY6BoD5Y33ZD8tprs3qFOKVTFZucDZIveZRlf/gO3EDTCgmtxKMTdV3XEyTSRSTuLVsMxePx7z13Y1GEMxCp0mFqsqTAIAmg4rMLBG08ZGFYBnQQ0Kozgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ykBkuCriaAW7Ri2AO5rY12lkly3B42sWtdLJy+W/dM=;
 b=ly7HBiNz7vFPan1gMuoAvpQMep16+f4QiaMgE5wVE+nuY5j/5x9kY62HpFYQinUh83TEsp+SIKCOyHZ2kR/ZNUhyBPoLMY8IZ6ekpvUuzIMuIsS+Vh4SDCT3eJUC8T0wqrZ43lhHrBgvJUz3tDriBSJFlF3rk/6aY5cdZzFHtzc=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by DS0PR10MB7397.namprd10.prod.outlook.com (2603:10b6:8:130::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Thu, 24 Aug
 2023 00:52:31 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c576:aa06:73d8:7343]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c576:aa06:73d8:7343%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 00:52:31 +0000
Date:   Wed, 23 Aug 2023 20:52:26 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Subject: Re: [PATCH 00/15] sched: EEVDF and latency-nice and/or slice-attr
Message-ID: <dlbtvvm5cewqzh5bcpl4cqhcwxmnnjb6pdle5jzywiiznlactd@cmhnpim42m3p>
References: <20230531115839.089944915@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531115839.089944915@infradead.org>
X-ClientProxiedBy: BL6PEPF0001641D.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:12) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|DS0PR10MB7397:EE_
X-MS-Office365-Filtering-Correlation-Id: bb2075fc-012f-48a7-fd10-08dba43c6575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bs7eipRKqUQISCu7Ri3QkmnUQsw2nurPab447IksIXYPd9hk/CevKc6OQps6S1lNFWCVJKNhhLwpREqE2yK2NRjt2koH6rMnMTptYbfKd0oLcPQsCbNfPXTURqqkNYX7ISvJcLZqViN+q59lzSVak2Iiv7OggNsVPyo7Vj8ezhMPeIHCdHYHyReiBCc8fLVxxf4tODlPMgJRwkHMzu+11goypE6PqnBTvzg09LuXLxQEHwBocZtXDqpMobMUAKWJmXcABUbLyMekAo8nzzleW++Y/QrChxTzMsNCaXb3FVfsyqyXcuPjn3NyiFEO0xv8BkjjmqJ7swRjlyoWr5KX1sSW1PM0R8A2Tqd9RCkRV8McOcL9aF+aHjFr4aBaSrAVnA4LPKeRbrdRInyu1kCzRMW+oCtp4+Qn5B1sSTMk3JvReDv/6Bds9tkN0kKI7IsJ6uCdT1y1kq6m35wEZvOmonwQwxugfLX7p5JbXkvQDCH+rCDL3BdAvc7kP4/d93ASJ2HiPcv4qZyxe/Og5DmMOQ/D2U8E5nXyAUBRsOn+Yuk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(136003)(366004)(346002)(396003)(186009)(1800799009)(451199024)(66899024)(6486002)(6666004)(6506007)(4326008)(6512007)(86362001)(38100700002)(2906002)(26005)(966005)(83380400001)(9686003)(478600001)(66476007)(41300700001)(66946007)(5660300002)(8936002)(66556008)(8676002)(7416002)(33716001)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ppkOwRtqyfmUEd5pFr3S7DkS61sNqvgyTTqquYAcEE0MHOkyAwsjl9reFEXQ?=
 =?us-ascii?Q?x4St2GuXA1KkoMP6fmoQ2MAp/gnh41AOHBV21KJd1/b6Tr7GRscme+QkV1fq?=
 =?us-ascii?Q?kSLyzkBt4ibfahCMjj/towk1aAOXsMjt7fEaE9sWwMWP9bQnnsN9tuhK+7ts?=
 =?us-ascii?Q?8+xebI2raYGVvDqvq4PDE11eu5Mmi+NbhsddFm6ssxFDK5zu1J07iB4osqa4?=
 =?us-ascii?Q?kKzFr7tm4v2cqxBZsOFtBMK3f41RFsdihEqn0oL9D9M1oLjqPSfSoJCCeFhl?=
 =?us-ascii?Q?0QLVkhxXc8O+cJVnxAqaQmN/Cof9x1ORDZj/VjSSqcqzqjjb3sZNJmraDW8P?=
 =?us-ascii?Q?wCWQLVAO0KXkgEmyhh8QGiZfT/753q/BAjam7srGoD+tC2jWMXgPiL1rn4mD?=
 =?us-ascii?Q?ssG9Y6ibYVxTXkmR7/LX8hyHw6f+OrfK0wQ7WmR+mNVWQNnvNPCr9dQrzwlx?=
 =?us-ascii?Q?368NAyWkxn7etzJZ1EuSe/poCXP+WtBgOKKueu9KtOzw35qBMS2rSavIJ4Y5?=
 =?us-ascii?Q?TPyqHZZMavD3V68kpDYjNm+MT41mG0iuhwZVC35ThqqPZg+oA9c/PZ79DULe?=
 =?us-ascii?Q?/bK3BR6yHi34uVDyaBIMWYg4HefDQvK7iz+TzNnkJSH2B2+S98w7Nq9tB6sL?=
 =?us-ascii?Q?4+Te9AhwkouxwFLPDbo4pERRuxIv9r18Y76mMSh+w/XvPVwnI7O7q6tjnW9E?=
 =?us-ascii?Q?VpoXYsionzLV0/7X6aUtohE+hovHTsmzyOwHVU7y6qF82XdOMOvH4seZHdGk?=
 =?us-ascii?Q?0Y01ZwTbtsl6VALggzZYraeb+lO4dmSGbhDquF3Jw4ygssMm99aFFiD3G7Rc?=
 =?us-ascii?Q?NumUrZ9w1/hP5iAH30CQSwYvJ0+vJre5RIsZn0ECz9lNfN6UFQHvSvei3WXX?=
 =?us-ascii?Q?2GP0C03kviaLh+M6gljaTu/U66NzCb5PPCGEng3TFWbh2dyLSCX0+B1gkmaI?=
 =?us-ascii?Q?St3fVkVYg3sjaFH/tgNf+A4ayZgb3wDAV0bHbzJhrcvIsC4u7Op0bzIcJiMa?=
 =?us-ascii?Q?E0wZAyeqaIpTsrkuYK8b0mPbVN1sEBV48oU42s6xaBa05imhg8DqoZ4O1Zhk?=
 =?us-ascii?Q?BLBHr+LGD6VCbEUScb3Lov25b6BKWKZrVMDnItosPxzhxsBL0RB5zCWUt5uw?=
 =?us-ascii?Q?HiYwgLI3ZCWx3U+P3Z+Y/vAWxBsVRrugKBsjSVc/ufVHfhYKiSw15JhA3ziV?=
 =?us-ascii?Q?8MILPyrR999CruSS9kSNJUXjI9Pq6hkQDxrNFr/ju4nnaQNPXElIf54VdFRW?=
 =?us-ascii?Q?j4YcWDn0iG29Yrv+R0f+6YL8NiBnUGFsIZoQvzzMDymkXXxXcT8TGMJOh6va?=
 =?us-ascii?Q?TJrSs4org/ZvP+RMn9PVveYVJlHhqHFjn3UT4ACTPi6+wS1ptO2In9wiCfdz?=
 =?us-ascii?Q?PmtRwDrpRaKYFTdccrU9zS6+N0YOmWpulfatSuij438A/FhXJi3zPNLroIvm?=
 =?us-ascii?Q?DKxV1Kfs21PkDYbKZrNqwlvXdgJWPlS9Omnmfr4ueOxp5gsgLJXft4OgDhqJ?=
 =?us-ascii?Q?pCqOtgpuRbE20vATuF3esNb3Bhk8gPbkvhHJcVA1GM2jcM8fHZhADFgNe2Zh?=
 =?us-ascii?Q?VqF/JO55prDtJecn1fApI5g30eQH6vEsRozCUC00qswKAZuynDX6GkLPG+Ou?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Y5Hd5VK5fjw6Yx7j4jDy68aZY9lfd87RLXBcsQj2vVYhKmODJBqljRO+putm?=
 =?us-ascii?Q?EQsWwa7xjw+VfI5D6LRr9oE8tzZltQIMN1NNvoUk60PfISCWEen/8Cyz5sxD?=
 =?us-ascii?Q?zhPSRy0KWoGlJ/KClTAIDNoIdl5LmJbdRh7yr2cPNJ1yB7JuWFPzclyDbT2c?=
 =?us-ascii?Q?p4nHdbDZbtPygjd/k83r0hMmL4Zw/KFc67n7WhSZQ+nQKU/MkkDnlbpppmsX?=
 =?us-ascii?Q?2dcdmQ6BFVhlxEUW0bytIB37aF3QxtkI5AZEuKd+vaX7n9KrZr9YP56zCfWR?=
 =?us-ascii?Q?NiEn+kfIbLYV5vTKbXtZ7IkATuIm88YMFgnhKCsc1kjqUO4pQixUSrwT/vlX?=
 =?us-ascii?Q?0xtt/n50mrZhKvHMPZ8oe5TzPPsb7mdn3SRoN3tCn/vryzMR+UIgQ51XVPGh?=
 =?us-ascii?Q?cTpjy/di7oB5HMVIMlVS4+FM3A8HT/Pv/nhpT44fDvs0l+hzXJRLM8Wq+upy?=
 =?us-ascii?Q?BLLrOYRrbzEdsNLGum3eYqcBobjZ0ImPEmlMraZTuZyUoj5r6nJf/JA9MKva?=
 =?us-ascii?Q?yoTiNEN/ptbTo66PnyGc+tG+CXT9z9mO+Ra46TbJPjjfaF3emXaCOMVyhNsK?=
 =?us-ascii?Q?cpPfX5oGZzOjyBvukV7GZm+lot/kfkS64f4qkeLcLvtAV4UsIp0WR2wQPwyS?=
 =?us-ascii?Q?5gm9x2JS8J7Ge+0sdTwsdzkE08gFZu0E6LA8qAoQDPBAAFyYVRsgG982tNv0?=
 =?us-ascii?Q?SKAyqU+KJv0H07f7LRRAudKG3fLLv7vu5ssMvPVIJd8Jx4PjrFNY0DTjXEvU?=
 =?us-ascii?Q?N2TK48v4N1DOvhrn0ceL5ReMzVM7HktLZGprY6Q0gHZkpmft6qPaUsKmnaCo?=
 =?us-ascii?Q?Rr/ScVWZ3IUGY0JpeMmKsmZQEZgMr7/xySBgdkKU9Fbw6Mp6IMYOVRbLZqaF?=
 =?us-ascii?Q?5DT3fOy+FTqxQBCARFNEF0ejydHRBg43RmatN+Yq3or5YekFcoJlE9UkRnPw?=
 =?us-ascii?Q?NRLd6IrZjxFJM0AZd6lcUHAd6cZGOPzxUNGKZCbRsRhBPmFLLuPIkobUH2wR?=
 =?us-ascii?Q?6D+b1dAckPfYNCBkKSyMY0wf51RoaXbt4XO1bj2SFV32Ex8hOMr+UzywzYdZ?=
 =?us-ascii?Q?rChu3dYN9CQNaUyGR+c1q2HseRpw21si1/h+z0hKcx2AhPOn0lSdupsb2TLB?=
 =?us-ascii?Q?hk4kWd5LJZF5ZsZhmzvBlx1JucqsLOctDpY57wrtptzvxz9ysWYdDe/QJqpk?=
 =?us-ascii?Q?kBWgyzpmKo60SHRh278qR3Crwt6Qgdk7FQkukthDLBUpmdhmYS51E4MGul0b?=
 =?us-ascii?Q?6RvN9riuFfOpwtGqgtNUf/qGcI2uLLlPSWAt6FVg1JiEhe4gDRyZcTnvUykN?=
 =?us-ascii?Q?0csaiii2s1C0q0UOW3gxMQSN1/IVYLtWWY7kIDUX+bLSRA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2075fc-012f-48a7-fd10-08dba43c6575
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 00:52:31.4179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWxZjbWziG+0BWyvsGLq1oYnLap7bThEWHjXcxLxTK6OTElSa0zDt3KSNC5smv5y/WDFI9/rdv6yaqdf2G1XWfw7Jn3uz9UMyORzmhK0xuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7397
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_17,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240005
X-Proofpoint-GUID: FbTwLBZnTMfU0vWF2v0Odxk6wQi8vg6M
X-Proofpoint-ORIG-GUID: FbTwLBZnTMfU0vWF2v0Odxk6wQi8vg6M
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Wed, May 31, 2023 at 01:58:39PM +0200, Peter Zijlstra wrote:
> 
> Hi!
> 
> Latest version of the EEVDF [1] patches.
> 
> The only real change since last time is the fix for tick-preemption [2], and a 
> simple safe-guard for the mixed slice heuristic.

We're seeing regressions from EEVDF with SPEC CPU, a database workload,
and a Java workload.  We tried SPEC CPU on five systems, and here are
numbers from one of them (high core count, two-socket x86 machine).

    SPECrate2017 oversubscribed by 2x (two copies of the test per CPU)

    Base: v6.3-based kernel
    EEVDF: Base + patches from May 31 [0]

    Performance comparison: >0 if EEVDF wins

    Integer
     
     -0.5% 500.perlbench_r
     -6.6% 502.gcc_r
     -8.7% 505.mcf_r
     -9.2% 520.omnetpp_r
     -6.6% 523.xalancbmk_r
     -0.7% 525.x264_r
     -2.1% 531.deepsjeng_r
     -0.4% 541.leela_r
     -0.3% 548.exchange2_r
     -2.6% 557.xz_r
     
     -3.8% Est(*) SPECrate2017_int_base
     
    Floating Point
     
     -0.6% 503.bwaves_r
     -1.3% 507.cactuBSSN_r
     -0.8% 508.namd_r
    -17.8% 510.parest_r
      0.3% 511.povray_r
     -1.0% 519.lbm_r
     -7.7% 521.wrf_r
     -2.4% 526.blender_r
     -6.1% 527.cam4_r
     -2.0% 538.imagick_r
      0.1% 544.nab_r
     -0.7% 549.fotonik3d_r
    -11.3% 554.roms_r
     
     -4.1% Est(*) SPECrate2017_fp_base
     
    (*) SPEC CPU Fair Use rules require that tests with non-production
        components must be marked as estimates.

The other machines show similarly consistent regressions, and we've tried a
v6.5-rc4-based kernel with the latest EEVDF patches from tip/sched/core
including the recent fixlet "sched/eevdf: Curb wakeup-preemption".  I can post
the rest of the numbers, but I'm trying to keep this on the shorter side for
now.

Running the database workload on a two-socket x86 server, we see
regressions of up to 6% when the number of users exceeds the number of
CPUs.

With the Java workload on another two-socket x86 server, we see a 10%
regression.

We're investigating the other benchmarks, but here's what I've found so far
with SPEC CPU.  Some schedstats showed that eevdf is tick-preemption happy
(patches below).  These stats were taken over 1 minute near the middle of a ~26
minute benchmark (502.gcc_r).

    Base: v6.5-rc4-based kernel
    EEVDF: Base + the latest EEVDF patches from tip/sched/core

    schedstat                     Base            EEVDF

    sched                    1,243,911        3,947,251

    tick_check_preempts     12,899,049
    tick_preempts            1,022,998

    check_deadline                           15,878,463
    update_deadline                           3,895,530
    preempt_deadline                          3,751,580

In both kernels, tick preemption is primarily what drives schedule()s.
Preemptions happen over three times more often for EEVDF because in the base,
tick preemption happens after a task has run through its ideal timeslice as a
fraction of sched_latency (so two tasks sharing a CPU each get 12ms on a server
with enough CPUs, sched_latency being 24ms), whereas with eevdf, a task's base
slice determines when it gets tick-preempted, and that's 3ms by default.  It
seems SPEC CPU isn't liking the increased scheduling of EEVDF in a cpu-bound
load like this.  When I set the base_slice_ns sysctl to 12000000, the
regression disappears.

I'm still thinking about how to fix it.  Pre-EEVDF, tick preemption was
more flexible in that a task's timeslice could change depending on how
much competition it had on the same CPU, but with EEVDF the timeslice is
fixed no matter what else is running, and growing or shrinking it
depending on nr_running doesn't honor whatever deadline was set for the
task.

The schedstat patch for the base:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b3e25be58e2b..fb5a35aa07ec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4996,6 +4996,8 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
        struct sched_entity *se;
        s64 delta;

+       schedstat_inc(rq_of(cfs_rq)->tick_check_preempts);
+
        /*
         * When many tasks blow up the sched_period; it is possible that
         * sched_slice() reports unusually large results (when many tasks are
@@ -5005,6 +5007,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)

        delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
        if (delta_exec > ideal_runtime) {
+               schedstat_inc(rq_of(cfs_rq)->tick_preempts);
                resched_curr(rq_of(cfs_rq));
                /*
                 * The current task ran long enough, ensure it doesn't get
@@ -5028,8 +5031,10 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
        if (delta < 0)
                return;

-       if (delta > ideal_runtime)
+       if (delta > ideal_runtime) {
+               schedstat_inc(rq_of(cfs_rq)->tick_preempts);
                resched_curr(rq_of(cfs_rq));
+       }
 }

 static void
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e93e006a942b..1bf12e271756 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1123,6 +1123,10 @@ struct rq {
        /* try_to_wake_up() stats */
        unsigned int            ttwu_count;
        unsigned int            ttwu_local;
+
+       /* tick preempt stats */
+       unsigned int            tick_check_preempts;
+       unsigned int            tick_preempts;
 #endif

 #ifdef CONFIG_CPU_IDLE
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 857f837f52cb..7997b8538b72 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -133,12 +133,13 @@ static int show_schedstat(struct seq_file *seq, void *v)

                /* runqueue-specific stats */
                seq_printf(seq,
-                   "cpu%d %u 0 %u %u %u %u %llu %llu %lu",
+                   "cpu%d %u 0 %u %u %u %u %llu %llu %lu %u %u",
                    cpu, rq->yld_count,
                    rq->sched_count, rq->sched_goidle,
                    rq->ttwu_count, rq->ttwu_local,
                    rq->rq_cpu_time,
-                   rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);
+                   rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount,
+                   rq->tick_check_preempts, rq->tick_preempts);

                seq_printf(seq, "\n");


The schedstat patch for eevdf:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cffec98724f3..675f4bbac471 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -975,18 +975,21 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
  */
 static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+       schedstat_inc(rq_of(cfs_rq)->check_deadline);
        if ((s64)(se->vruntime - se->deadline) < 0)
                return;

        /*
         * EEVDF: vd_i = ve_i + r_i / w_i
         */
+       schedstat_inc(rq_of(cfs_rq)->update_deadline);
        se->deadline = se->vruntime + calc_delta_fair(se->slice, se);

        /*
         * The task has consumed its request, reschedule.
         */
        if (cfs_rq->nr_running > 1) {
+               schedstat_inc(rq_of(cfs_rq)->preempt_deadline);
                resched_curr(rq_of(cfs_rq));
                clear_buddies(cfs_rq, se);
        }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 93c2dc80143f..c44b59556367 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1129,6 +1129,11 @@ struct rq {
        /* try_to_wake_up() stats */
        unsigned int            ttwu_count;
        unsigned int            ttwu_local;
+
+       /* update_deadline() stats */
+       unsigned int            check_deadline;
+       unsigned int            update_deadline;
+       unsigned int            preempt_deadline;
 #endif

 #ifdef CONFIG_CPU_IDLE
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 857f837f52cb..2a8bd742507d 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -133,12 +133,14 @@ static int show_schedstat(struct seq_file *seq, void *v)

                /* runqueue-specific stats */
                seq_printf(seq,
-                   "cpu%d %u 0 %u %u %u %u %llu %llu %lu",
+                   "cpu%d %u 0 %u %u %u %u %llu %llu %lu %u %u %u",
                    cpu, rq->yld_count,
                    rq->sched_count, rq->sched_goidle,
                    rq->ttwu_count, rq->ttwu_local,
                    rq->rq_cpu_time,
-                   rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);
+                   rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount,
+                   rq->check_deadline, rq->update_deadline,
+                   rq->preempt_deadline);

                seq_printf(seq, "\n");


[0] https://lore.kernel.org/all/20230531115839.089944915@infradead.org/
