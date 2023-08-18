Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0C07814A7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240599AbjHRVSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240782AbjHRVRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:17:45 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A7E421B;
        Fri, 18 Aug 2023 14:17:44 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37ILGJG5031960;
        Fri, 18 Aug 2023 21:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=date:from:to:cc:subject:message-id:references:content-type
        :in-reply-to:mime-version; s=PPS06212021; bh=iYRBnMIEQnhS563B+4S
        1PgPFBiLe7+w6oLy5WDxbMss=; b=ax5/aawfsAaffGB2p9Mv0CMrgbs+fr2Kc9b
        1o2U94L7zGmIRyESrcxuhMw6DOb64H2lN4dk378WJQiLkoUT1pw8TD1kCsmuDoj5
        J+MBcmldJxOZoS/ADeBPnrKZEOWpVoXs/R3gC4cOXbOS9EQpDQFV2iIr5H26RzlS
        TEiYp69jo/hs0LxFzQ7tjMSTBmu1cNlVgNS2z29NBdY3AY3H37ozsVQ/xJZDAiAC
        14UrdGhW/n9lyp/K3smQm/2ws/n7+Fh2X1r17cq8IfQhZ0fyBYSP5UxnJVHdggbB
        45bjFgSUpQzu/ExiTEG18dhBsyBqCtF9V0fSdAyX1QnN8By366w==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3se125xatr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 21:17:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCgU3uEOarI75yGimqa7PMYct1RJ+tFKENWW4Sjpvak0kzAVsoVyrqYOlQmeZxTAwbskgrewCAizxBMKoTzWPzHAGbU3lQiy4SRXVd5Rlz5//19YJFPolLujOwXQch5wggkhHIgNMgA/Cqu/UX3GAHT10ub8lYdUWF4JR+QYcm9N9GUbJNHtTNDMFj7dlBveCQp55PXhm0HuTSJ63rDnqqAMIA+KWEbnO3Ruo/5FRBsPK5jHdBggypm9kzTBI53ive5V9XDdkXuSMUJBOEkPYVlN6IS9LMUKmPp5A+hgYdjXOoyknlv5sgaeIMDVfPJwgekOtJMvBul7QnbAwZX9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYRBnMIEQnhS563B+4S1PgPFBiLe7+w6oLy5WDxbMss=;
 b=n2dAQud33hTPTDcqs3GpkEGSW4r4kKld837n9lTrUqZsE1MfABm+aq0MmuRGpbIVi5pRHkcQvsHHecOPPRdiEkmGwEXwtJOt0IqasfWW8dCwEhIMJvXV3nr2jVF56/5hh9V6rYFJYmsjaU3m3JVEgJ1tlD+uXznPpDOwSOR+lfEgqw+YeuFcUUQElBd2K9CvxqNBQL84uHQi8Ktwzda1KmPV5iaytzrN5xSGVTlhkgh3V4nbPAKISssq8SnrJAAq6O85AM1BSLZS/Sanm8XLR7qaAujgKDd2QftkA/Ak9hYAhtjGI1QhrhxP2yblVz4jZG9rgzGglHrZB+3+aK8kVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by PH7PR11MB6521.namprd11.prod.outlook.com (2603:10b6:510:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 21:17:37 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::16a1:cf75:23cf:6e52]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::16a1:cf75:23cf:6e52%5]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 21:17:37 +0000
Date:   Fri, 18 Aug 2023 17:17:33 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Clark Williams <williams@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [ANNOUNCE] 6.1.46-rt13
Message-ID: <ZN/f7T8hoLzKLmnr@windriver.com>
References: <169237369832.691481.13351444607835949475@demetrius>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169237369832.691481.13351444607835949475@demetrius>
X-ClientProxiedBy: BLAPR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:208:329::26) To IA0PR11MB7378.namprd11.prod.outlook.com
 (2603:10b6:208:432::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7378:EE_|PH7PR11MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: c799b24a-c299-4c49-3927-08dba0308c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGIHExkpJ0CKr9VyRFEoy1twWxOnL0h1cXhpvN08jrfJtvdSDohIXGPuAeDeM55QIigqCIpy6ZEF4HVnk6WtkaL21Is0oSOusgREETTAF2ldcbjPEtLxA+m315SaX2Ywb1EWFDWp0ppudPzRUbBvDo94FtutRga7D+grJ1Fea6jDAkD4fdaJJGLyL4Jav1ZppieDR28ivjIni37QqpN8tXFnNrmeDzNf0JW8SmXQiWRPq5ATjkei01Sl6KCo6h3S8HdcMLCuuRlC15gKDjoufTufVEiZR2z4WjLMHhIsqcHEHAsNGeUpoZ1z13hGWL1wkBsbnShjljZlqrwIsoEFx5g69K14DxfHFUSqDa7KZ0mOmYet68feVpezQtE/8Qabm5xbUTVAUMvlJE5hEoGdRao6es1F5cyJY2vltkrG7HfQPt4rhMmTsSImFIyFp09G/lAB0jaIkaPE9ry4SqQB7S+BM+MyuMrOqwmj83751HXuuVswJlTMbzcyRY1hxWzYkA8bFcDNXLLxFvzpKSXzwAx3ywlj94184gJ3yHMFhg+kyCNN1mTh1VkXF6D+A+qjyenpb/Tictc7LYA7qioYLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7378.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39850400004)(396003)(346002)(136003)(451199024)(1800799009)(186009)(86362001)(44832011)(5660300002)(2616005)(41300700001)(2906002)(316002)(66556008)(6916009)(66476007)(66946007)(54906003)(966005)(8676002)(8936002)(4326008)(478600001)(6666004)(6486002)(38100700002)(6506007)(6512007)(36756003)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nTk2KnxZc4fhWk+RFb7zuWNM/0sVUFEEaJr/O1wUGOjMbWSM61QB1965s/Wg?=
 =?us-ascii?Q?36DvHFoewNVCIcIhCt1pC8nTJkOSCKnb0Fd7pM8ZiCjIgwNkTn136DHsszb5?=
 =?us-ascii?Q?IcMpz7vPdH8qMi7NxbfXJnwj0/HDZTesjhncM2pC36Vd+QpKp2sZe6rMkNOi?=
 =?us-ascii?Q?50pAv2r9DUoe/Kw+8iXqoOkuwfQncNOqpA1rBpO1TyGhTyeZDhrUD9MBPh/d?=
 =?us-ascii?Q?99lFfxe34J5ZV1geXRzhuLi+Bg1Pv9/YA/0gq3QEXDER8qEb0TFKpJ/bI8Sw?=
 =?us-ascii?Q?EHfAfwaMbUHOqiKx/Pn9JncSNPYJ7kkPu9SPiUwb6MVMtH8QN7qlpEVzOV3g?=
 =?us-ascii?Q?oW9ifm6tyd/mqDlXmVgJFDPi1ccTSrcBytCDEzQRqVcF7t+2i5kns7uZnJDR?=
 =?us-ascii?Q?yahxa+Ro1mQzzqxtnpJpBdz0nFnDJ3onTNpWi71d903U0H+FXt9WMGs91WZw?=
 =?us-ascii?Q?fPS+jo2TApK7Czb/vJIk5a3gLfqdFOinnMCOWx1npHLuVx2aduWHVZL7jN2l?=
 =?us-ascii?Q?bFRFWNWBSAwUsc6P/m3pUYl5IAUyaU3svipqPVH79qlTQ6VHooCVzn4U6e+R?=
 =?us-ascii?Q?XTDa3bN9E7FWVlc/RFW4Z15fbkFFkRBFBTL6CP8gdscdv5akErG3dUrgV0DW?=
 =?us-ascii?Q?XN5haaYlm7Qkzge5xkLS5+uHRkXScAVz7MyUnqS3+Iad3oHKIr8dHWqa5wUq?=
 =?us-ascii?Q?8kY+C36Hrlemb9Rs2Ts7Nk3z/WR6sw5wiSJ4KWFhHS7I85KcyUK+qas7JkLj?=
 =?us-ascii?Q?qCqV/Sb2RsW8/6XqMZXnNPn/b3Mo4/XrUmBMOOiYE9D6eaRQ71KncmbirpZ6?=
 =?us-ascii?Q?CrtEsvXREZaHqX88l4S7MvS0DWjqoprV3p+/9MAwe5L04O2ex1/i7cI7Er2E?=
 =?us-ascii?Q?HKZBcTbusPLjtjqT/uBxl1X9jsPWXku8CeQ0coVZcV3lzjSFUZe+zA3/L/ib?=
 =?us-ascii?Q?bogtUGFaaYivZBtvp5by7B79GmFkAaXUlyqDTJuHGcjhjfN+f7gybUfaFGdU?=
 =?us-ascii?Q?610ZH0pXpZqNCzCQmNyLwc9nSp9iPHv+12UiWrOifAqPbyDMofwLFEkG5hNu?=
 =?us-ascii?Q?oI3ROjNjbJMuDKzVMkLCgRBoaq1DSFVV0RaAHKzsPNHQ+IQm4j+uk6bReArE?=
 =?us-ascii?Q?Pscq480MJ4N2jEyEimqML6uoBo2Z+6waLoUBvUZhhSg4lxtYAakTHBFpaJIv?=
 =?us-ascii?Q?tn5bVFYF6+j8dycTQYgz61BxrvAC30xr+7aVbpaZsBpf3VnazB6r4kCAPKpJ?=
 =?us-ascii?Q?XOQA9kUwBMbIou5FOTvzPACgOpxgNordKDj4lgidNcssB7QK/G/ek9nN0snL?=
 =?us-ascii?Q?07C0QKDjTEOefNYFIHECJgX59Iymb89DWDhLjD14ttiPGHMT7zR1OV/nPXz7?=
 =?us-ascii?Q?iY02p1z2233b8jAlvouKClderaT0MWvSEZYCAmftOMQ4k08/Ady66ufQVCYu?=
 =?us-ascii?Q?SqLypxFKmeNkvePpNyhj9dxo04u+MDBhhqMzsQCywANfSbznc4v8NyHxGfII?=
 =?us-ascii?Q?cHTBeQ17/EXqMrZ23aVbCHRxL1fjDq8r/SXC4dg+n1L+sd8l36wASpy9S8il?=
 =?us-ascii?Q?WDXpY9QL/hGZdVYN6KJG5taOMlZtGFcwlG99c3M1vEl2v/DAYJ+Bc0f4JmUn?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c799b24a-c299-4c49-3927-08dba0308c14
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 21:17:37.3824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+g1Gu53eWDsmBLe6Lfx4XeJaHkho0fNPWImOxB+eNLFkNE3xG+iJgYssZQ3tH4XRRdrQ084/Hn5WrZZPND+5dVMW9FKATBq1BTuUWZlIJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6521
X-Proofpoint-GUID: aNxKAtY9Hhol3NXR2RGeLoXAEDq3AhBi
X-Proofpoint-ORIG-GUID: aNxKAtY9Hhol3NXR2RGeLoXAEDq3AhBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_26,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=831 spamscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2306200000 definitions=main-2308180194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[[ANNOUNCE] 6.1.46-rt13] On 18/08/2023 (Fri 15:48) Clark Williams wrote:

> Hello RT-list!
> 
> I'm pleased to announce the 6.1.46-rt13 stable release.
> 
> You can get this release via the git tree at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> 
>   branch: v6.1-rt
>   Head SHA1: 3ba4bc39d170fb7191c4898ef84416417a0e9f19

Hi Clark,

Seems like something went wrong with the upload?  I see this:

  commit d50b0124e9a24d79938b163da023619f37609c37 (tag: v6.1.46-rt13, v6.1-rt)
  Author: Clark Williams <clrkwllms@kernel.org>
  Date:   Fri Aug 18 10:43:54 2023 -0500

    'Linux 6.1.46-rt13-00077-gd80d902430d6-dirt'

Right branch, right tag.  But the wrong head SHA and none of the staged
6.1-rt13-rc1 commits are present and a work-in-progress shortlog, it seems.

linux-stable-rt$git log --oneline ^v6.1.38-rt12-rebase~ v6.1-rt-next ^v6.1.46
7daf1cab0002 (HEAD -> v6.1-rt-next, tag: v6.1.38-rt13-rc1) 'Linux 6.1.38-rt13-rc1'
ebeedde0a78d tracing/timer: Add missing hrtimer modes to decode_hrtimer_mode().
1ff77af1aaa6 revert: "softirq: Let ksoftirqd do its job"
142cca5c238a locking/rwbase: Mitigate indefinite writer starvation
192f4a9d7370 io-mapping: don't disable preempt on RT in io_mapping_map_atomic_wc().
38cb75102052 (tag: v6.1.38-rt12-rebase) 'Linux 6.1.38-rt12 REBASE'
linux-stable-rt$

That aside, thanks for maintaining this.
Paul.
--

> 
> Or to build 6.1.46-rt13 directly, the following patches should be applied:
> 
>   https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz
> 
>   https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.46.xz
> 
>   https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.46-rt13.patch.xz
> 
> 
> Enjoy!
> Clark
