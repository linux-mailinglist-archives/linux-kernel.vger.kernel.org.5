Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65BF7DD0BB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 16:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345090AbjJaPll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 11:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345048AbjJaPlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 11:41:40 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4278F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 08:41:37 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39V8o2fI004497;
        Tue, 31 Oct 2023 15:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=date:from:to:cc:subject:message-id:references:content-type
        :in-reply-to:mime-version; s=PPS06212021; bh=q14/sUPPO2DBp7pZzXV
        f57SXH1oo03tZc8VyY99UTG8=; b=dJacKfq/S6U82vN4CKaZMIN5+PDBJi2kDQE
        kYfL7bJyMuEXyyvXhHDXEY22mzqr5FLErg/twWd18ewhyl4CL6qv8SFB/zu7HA/b
        QKOBJIT5ZabzBLYqjhMrhr3zJMOiZt7TH5yjk4R2xoRjjJLDMpqw77iMHwOVQtzi
        buHKORb9Xxrfm4LOREzTAPbkhL6d2i98WCrYQuQOdWO90C5o6FUSy5O1HNLZg7WY
        k1gc86QfyXZujaJ0GeiSYdCUmt7VXCneFyhA29abzpxVRXUq3mX0hEooLCEAHzYr
        EGj+arEY/IXZIDZQmplXUdVW2k9JyjKT/S+mqbFOnRVb4QrA0aA==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3u0s96bqfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 15:40:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVOEP/BogTog7vVdTnXL8X42lmUISn3x7cNkepMPws9M1/PRLiI0qyQXEVB52rZJGKCXjrW8jvBa8zxAgVwnJ9cf6cjJ8kW/0xrPtR70UhS0awkU4n+j48fDxjuu7NggMC+WFsroDP6OlxcqBuqBjVWAkeubSB94euvEHwUzyu2Quia3e58P2ihLsN3pUveTgdW+prpw+QJmIUWLWp3yTpVnHJK/gmWEfQ9rNpu7V5RG3y4B9rlMudNoPk8z6VF4GzK8LHYBA6K8+IBf9Irj7F7CvTV/12O/MvI7zKU/GsSKrUTdUzOpcvpjjHjsqbQpFxHvOv7SU/+NSy6sdzAoDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q14/sUPPO2DBp7pZzXVf57SXH1oo03tZc8VyY99UTG8=;
 b=nA9f2+gHo7rYVQVn1yaXPQDuRbiG1W81wiCcDoX3UQ1P4sxyFmzTo4ow1eEk7/iLuPzRCqd8DHGXvI0y0J/2Mc+EMjLBpPGCr/AjHHRIMLSUmLtkgrXJu4HhDguGufXGDwC+BXIeWRvDoHkx0MdZwB+6f2fha2iTUjWioiiZrVHZgGro5iBx9Xz/YxBGj1bX12kTBiTIGUKPpNjCAbZJonhiQt1gNZ4FKAd38E+HwCw0iitpFGKioO2kHokLHBCt29PoQkaQIJME/UeUtYsOZknNXRLoEkctq2uil08zYbYuXL3VeQkJ2RIKA7OaCfAvK6jVNcohMP4UQFF4qTxDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by MW5PR11MB5858.namprd11.prod.outlook.com (2603:10b6:303:193::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 15:40:52 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95%4]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 15:40:52 +0000
Date:   Tue, 31 Oct 2023 11:40:48 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128
 x86/alternative: Rewrite optimize_nops() some]
Message-ID: <ZUEgAAGDVqXz2Seo@windriver.com>
References: <ZT6narvE+LxX+7Be@windriver.com>
 <20231030082644.GK26550@noisy.programming.kicks-ass.net>
 <ba1369810b39f79c0b092151bfa062dd0cf505b3.camel@linuxfoundation.org>
 <20231030114450.GB12604@noisy.programming.kicks-ass.net>
 <ZT/Lmj3xAdwvLE7R@windriver.com>
 <877cn4ynms.ffs@tglx>
 <871qdbzz5f.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qdbzz5f.ffs@tglx>
X-ClientProxiedBy: YT4PR01CA0107.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::16) To IA0PR11MB7378.namprd11.prod.outlook.com
 (2603:10b6:208:432::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7378:EE_|MW5PR11MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 19772bba-b86e-4ee8-82eb-08dbda27c348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9r6/35mRJDR2uRyT327GuKS3EZnwKUOk3GBHpzQAQEdNpX9FPy6MmgNev8SQt7Vv7yefhcTIJm9TgACfqftEtmNRBLiAbKmBH0CAonL+HArEQsZv8rDpXDVAsTjCa0A5ymw1Bzuzv5x6kGMgfEVfoigcxgwx+ACAC+7/hl3DjpV8vsxHLQtsCsFVsmZx/KiajOT/t+4zGx5WVgyZYPz+MWizcP1n6U/RZC88pMN8YZHN0dhnfZnb3gyYHfxgGkPR2wN776SPYjZmwFMyWBBfN9tQ5+paOxOp4GT30QCHyMrurHyYJQGSA3YXCcQv2HCpHbE/jhmiMpMu+ppAV1eIlH+lCFDRQoJ6tsZ/+DY9xo50Jx56MSOSsoP0Bx52SQ/rETfZ9h3o8N62Dt5GH/Jh0IcjkUp/r+nzsIGTXmeREHA+6ey8VZCEgIlXFX2sAjPjogBALLkQX4oITijC8/i+b/O6/BJrAqEyi30+13tK9SFB3BuQmYrXLJ+atgzckQpo+r5DJBL6VjmByZVUrZ/FZ9Zx3p0bwl7dvDVXfVpyfcHukg3gSu1rJdP5ll5pa0i6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7378.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39850400004)(366004)(396003)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(8936002)(8676002)(6916009)(316002)(66556008)(66946007)(4326008)(66476007)(44832011)(54906003)(2906002)(478600001)(6506007)(6512007)(6666004)(6486002)(86362001)(36756003)(41300700001)(2616005)(5660300002)(26005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6U9U+Ec/C8rmfYETf/Q/vJVIyIvcASqdjQYe8z+dwHQs6OixLX36hV5P6B9t?=
 =?us-ascii?Q?7PyY+Z+cGZAusxWHgQpFSs5ckbpGMJBTmOmKHoeg1rqsK3q5TYb/u03NNLDb?=
 =?us-ascii?Q?uIsAKEDiC2WWiJsK2dI4KRM2O816qTVg9OiqM7dRl8WOCp8tSZgGZhpU/JOi?=
 =?us-ascii?Q?Avs/2NcHYhQndF/h5qdeTk+m+3mxMl6MfRtBlmYRoe3GQKZKtOeOfBGYMCCT?=
 =?us-ascii?Q?Lx+rGPLO9rRnY/SahTzjUUN8Ng2io/nYa2HIVHa7vtYN+8RsZjkaI9DQIVfM?=
 =?us-ascii?Q?3mumA07NRqhnM28HC2a4YAMfAfXF+w5CYZ7y+pluDa0jqpMV7KVU67xNoyx0?=
 =?us-ascii?Q?bCu7EbJLw/SpfTYcqwCfMSND303DhGyuZ/YHBGnYQGo9xl3Yh/B//bc1bJli?=
 =?us-ascii?Q?Hug7ezkxJxALbZ/s348Xj7N4AsAOBUDTLlA8BTNIxD6oq77j+iyAWrmsS70G?=
 =?us-ascii?Q?yF2j7jUdvJAN7yvesVepfjxWK++LMA2yhHno9QTEfLPiTeEGwPT5ylUGxOEi?=
 =?us-ascii?Q?k3bo+7Xzr9X+Y02mEU2Y9FYA/Fe3OF1wnKN/eaY1/krnQMdpnVrVn7P53VEj?=
 =?us-ascii?Q?e48nTLIYO5K8CbbdJQ6cY3/Zc58VGj/0MP+A56K+0eVud8loMGwn6iObpaZg?=
 =?us-ascii?Q?zdywnWiz5w9EXUBymoJl8OXx1FwhXvNfAwVmVIMeHD4DLnEZyr6l+XuZLewG?=
 =?us-ascii?Q?I5UPqtIQ73C+88tG3Mpu44FXAAL8skuZD93Mzjib0RhsoNds31wS75d44O0/?=
 =?us-ascii?Q?sDz3yz0I8w8EgmLZ7KmjCN1h2BvDYjSr9uuLBg3Ytf+lGAOrbpkyEEdFwCtp?=
 =?us-ascii?Q?X0fGUDUlH0X755XRzqlzndrQwsUd5gSk2ywFvTD9G/XULR6t+JDCTTB9C9nt?=
 =?us-ascii?Q?B1MQBhf6Ty4U3YFtYqrCqzaV9+SNRFtpFLayUdxPPtbDhKFHH5biyTDi0F4o?=
 =?us-ascii?Q?2IBSkrL7SE3oBtEeRqU2GTA41FFuSY0nYubqGSfQHEtzC7NtYJIki3MQwYwK?=
 =?us-ascii?Q?mWRq3eFSVkr+0W5/9g+cwGKkIXq/k4XgREtEG1uNzTANmXp4R3/mr+E0mItd?=
 =?us-ascii?Q?qiJZqWSv7h7n8j2D7mvI75aLCF+Wcm2wJf0dbMA/o7Z9XOQPj8snpW56H/yM?=
 =?us-ascii?Q?aKF2G2ebV5KqPAZxuAj3UDzolAisdsjX7cNYhl9+U1VIWzAZSVGwby79YgKW?=
 =?us-ascii?Q?CgEFDpk0PvOQ/+JS6tCwx/xkNiuT+9mmUhesxCdAY6rrFtfsGy2MeLtc2Bl/?=
 =?us-ascii?Q?Bu3sZOHrh7DIbP48AdTfvntjXIwoixzG2ImQN8DgR0uMkOOJX69K47m6LwKR?=
 =?us-ascii?Q?MEp6vllt5y9QY8ltCP75i58N5CwNXYL6yg3emXygh+vCazrRGFkyvDYT5Mug?=
 =?us-ascii?Q?YkyY25lOXvdeiEzCvjS9jElVt9yn7QCAcjzqc7qzTjdcY+QEFXikV/MyCLtg?=
 =?us-ascii?Q?cFwN4jcavFKAUqM+v1ru69xP6SUfwCRgguJPNLwYh7VuLHbe+srTm+3AlarS?=
 =?us-ascii?Q?Bihp0f/k43U0WVhXUmcreNypeZm+E9P7jB1sVHvvwOnXpP/FHIGnHNAYQFuz?=
 =?us-ascii?Q?aaj4xCe7WzO47GL0CF18uU7yk3+Y0vTSFadoFVUee0ZliykbV8GGSePVpP8+?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19772bba-b86e-4ee8-82eb-08dbda27c348
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 15:40:52.1395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cB7jC3XWFVw0qYVUuQqFlZn/h3ddV812BR/OOtHM9p81RJWSaeBqHmhqcc/+2vWjxCkDKre6moLIUQpaYjpbavZLOoj2qZGVLrLsZdjz11E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5858
X-Proofpoint-ORIG-GUID: XfkoN5JYCTmCKp9_aGpOXX3aXXIbcohN
X-Proofpoint-GUID: XfkoN5JYCTmCKp9_aGpOXX3aXXIbcohN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_02,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxlogscore=542 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2310240000 definitions=main-2310310124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128 x86/alternative: Rewrite optimize_nops() some]] On 30/10/2023 (Mon 20:30) Thomas Gleixner wrote:

> On Mon, Oct 30 2023 at 19:24, Thomas Gleixner wrote:

> > Can you add "debug-alternative" to the kernel command line and log both
> > a working and the non-working kernel output. It's noisy :)
> >
> > Also do you have a .config and the qemu command line handy?
> 
> Forgot to ask: Does the probkem persist with 6.6 ?

My bad, should have mentioned v6.6 and linux-next is impacted. Always a
conflict between burying the lead and boring people with details.

The "debug-alternative" is definitely "chatty" -- the "works" case is
easy to capture -- working on getting a snapshot of the "fails" case.

I will attach a .config to the yocto bugzilla case, for lack of a better
place to put it.

The giant sh*tshow of qemu args used by QA are as follows:

Running
paul/poky/build-qemu-x86_32/tmp/work/x86_64-linux/qemu-helper-native/1.0/recipe-sysroot-native/usr/bin/qemu-system-i386 
-device virtio-net-pci,netdev=net0,mac=52:54:00:12:34:02 -netdev
tap,id=net0,ifname=tap0,script=no,downscript=no -object
rng-random,filename=/dev/urandom,id=r
ng0 -device virtio-rng-pci,rng=rng0 -drive
file=./core-image-minimal-qemux86.rootfs.ext4.2545136,if=virtio,format=raw
-usb -device usb-tablet -usb -device usb
-kbd   -cpu IvyBridge -machine q35,i8042=off -smp 4 -m 256 -serial
tcp:127.0.0.1:45019 -serial tcp:127.0.0.1:49567  -pidfile
/folk/pgortmak/tglx/pidfile_25451
32  -S -qmp unix:./.ut8nuyx1,server,wait -qmp
unix:./.7mu5pxk1,server,nowait -nographic  -kernel
/yow-lpggp32/paul/poky/build-qemu-x86_32/tmp/deploy/images/qemux86/bzImage -append 'root=/dev/vda rw
ip=192.168.7.2::192.168.7.1:255.255.255.0::eth0:off:8.8.8.8
net.ifnames=0 console=ttyS0 console=ttyS1 oprofile.timer=
1 tsc=reliable no_timer_check rcupdate.rcu_expedited=1 swiotlb=0
debug-alternative printk.time=1'

It pains me that it fills a screen.  But there it is.
