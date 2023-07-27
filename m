Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC0C76456A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjG0FXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjG0FXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:23:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F20311D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690435404; x=1691040204; i=deller@gmx.de;
 bh=9Ba+rWrFA1c6ljXrc+1qjjYtNpjV+RX1ly8w80Fi4Vs=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=sqrp0QhNyF1+/uKFfq40dRiCySTYfpHen4TMtucLuIdIzgNZNOa2suzxKUZ2alfcd3B00K1
 NSfOY8fl1ER/541wLoV2wwmJojWdf8iNqMXGToVizXQsvcvfJnCaoHZ0KI5Wa5ITfoYCFqeu3
 Gxst2YZFcmjfeFGeVLGnUm8Ven0t2FG9yUYMVDUsoghT3uYHI+EANWe/d6fKKxiM0U8yzt26v
 9GmQANZyNsA9exfJPSlmtGhVC9ZYBF3mxl87I9SNiRRdo0k45+pz3NkoQw9l9xzrrJJJHpX8D
 a09Q6uw/vupSShET7ZmBmbVgQCLddY9rCwq+ita6JqlCnR0ETkJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.20]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXUN-1q8aq33I0N-00JelA; Thu, 27
 Jul 2023 07:23:24 +0200
Message-ID: <fea8677b-348a-dd67-4eac-12c547afa00d@gmx.de>
Date:   Thu, 27 Jul 2023 07:23:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: mm/kfence/kfence_test.c:287 test_alloc() warn: use 'gfp' here
 instead of GFP_KERNEL?
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        oe-kbuild@lists.linux.dev, Marco Elver <elver@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <9e72b7ea-9598-415d-bc55-f2f42b7fcb3b@kadam.mountain>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <9e72b7ea-9598-415d-bc55-f2f42b7fcb3b@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q4WUBWKRB56NS4WI95CxOuAsJCM7QUFH7uLOg9pzPo9C2W2/wKo
 5NCZSMv0k9M9YSzg5wtc3jW2hGxcOHK459q4zYn/luUXJEizQ2e8mNCyf579+sPlxloLotj
 GlSH/DrZXdqNuOCRtkhtux3uxQ+5PXSTu/zRdsHAaOHMuIkVGQpjKYyi18jju4Hn3nBKlOD
 kkW4Fq21LbSQPQQN2g0qw==
UI-OutboundReport: notjunk:1;M01:P0:GM5V8VKyGsU=;6Zmw/GchiKIohQKoDtRfZPJ/A/x
 MhL+ufBurSSyoDGbVj371Rf4t8YAfyvvLfrS1Y1CFZiMNw0eyfZb3tDV/gMlAMbAIDwf0tiMo
 rXKRMrl2mCe6OrHsH3yuwSq9AHAVN4CJ5mXHhxA5zM3ugCXsK54HGJoqR5d59UdhnQfWTHDed
 gRWJlEXeWr4Krih6k4mKk0Zy0Uj+hdx+5GGPWtVY6dveDAcbQCHwJJfYGl+cc4GQCax0z0iQA
 sFz88QWgQTekHWQuhrJd89syUoGrAhjL/Tz4sBkj74fVEx9GCRF0TiyEJfibm51Bw650KJhSJ
 qYme21NcfHv1nYmO37pIUJxEuStSzKoPcpiYjgoqHv6fWmeijjWhRbWruVQ7379JpqzJAmR0D
 0nn7JvF6U6ebHp8VshmT/4Gij92OAOMpmKIeAJNhlvaK5cTZFDydNempeg/+AHS57B+M/hNWB
 1Fow3qS+43/BBp7no08KaKeWRcFP6JNsNKLtuhHLHECej8OBjT6qrodcaKEjGz7y656GxmYGE
 CqZXHSNcQ9fQWRoPWOlWlDYEcc6MfmDjeTt/MCAczowakUflWz212jWAEub+y1YoblomlsVEE
 G9PoRL8CSvyErErVcJ3uaiahYanzJNzj1xHL5XhgXsQ9SYYmoDP6PYnGpmRCPGK9BRXFA9pbK
 yQYXdfaww62TRhrL98M0jhObL/0Qp3Gc/pjfLBdjjwr2gq8Ydlro+6NiScF0fxtrrvb4qHRwh
 tN0caya5Qw9femg4NvsEFd5mugTYD9Q9U8WaPgFZTpIPP569HZqD3gLr1t1NBDidRS10H0pkG
 zPvYG6mn0FqkQzV/bRIdisVkVEsmOmWAwV3NjhJv7+rV5yesaZIsdK3fwuBQuJnEXxBSSGUxB
 eujv9UZsHzmdfzZ478+sLV1UjmFA4EaEZYOWQN9LT7QNjeS1eww0KnoJsMn5G3730uM7utcwV
 SAHr8toM19n5uDlSzaxkQwOUYD8=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 06:51, Dan Carpenter wrote:
> Hi Helge,
>
> FYI, the error/warning was bisected to this commit, please ignore it if =
it's irrelevant.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
> head:   18b44bc5a67275641fb26f2c54ba7eef80ac5950
> commit: adf8e96a7ea670d45b5de7594acc67e8f4787ae6 parisc: Enable LOCKDEP =
support
> config: parisc-randconfig-m041-20230726 (https://download.01.org/0day-ci=
/archive/20230727/202307270305.L19EfaJD-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230727/20230727030=
5.L19EfaJD-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new ver=
sion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202307270305.L19EfaJD-lkp@intel.com/
>
> smatch warnings:
> mm/kfence/kfence_test.c:287 test_alloc() warn: use 'gfp' here instead of=
 GFP_KERNEL?
>
> (Just included these for the LOLs)
> mm/kfence/kfence_test.c:395 test_double_free() error: double free of 'ex=
pect.addr'
> mm/kfence/kfence_test.c:671 test_memcache_typesafe_by_rcu() error: deref=
erencing freed memory 'expect.addr'
>
> vim +/gfp +287 mm/kfence/kfence_test.c
>
> bc8fbc5f305aec Marco Elver     2021-02-25  243  static void *test_alloc(=
struct kunit *test, size_t size, gfp_t gfp, enum allocation_policy policy)
> bc8fbc5f305aec Marco Elver     2021-02-25  244  {
> bc8fbc5f305aec Marco Elver     2021-02-25  245  	void *alloc;
> bc8fbc5f305aec Marco Elver     2021-02-25  246  	unsigned long timeout, =
resched_after;
> bc8fbc5f305aec Marco Elver     2021-02-25  247  	const char *policy_name=
;
> bc8fbc5f305aec Marco Elver     2021-02-25  248
> bc8fbc5f305aec Marco Elver     2021-02-25  249  	switch (policy) {
> bc8fbc5f305aec Marco Elver     2021-02-25  250  	case ALLOCATE_ANY:
> bc8fbc5f305aec Marco Elver     2021-02-25  251  		policy_name =3D "any";
> bc8fbc5f305aec Marco Elver     2021-02-25  252  		break;
> bc8fbc5f305aec Marco Elver     2021-02-25  253  	case ALLOCATE_LEFT:
> bc8fbc5f305aec Marco Elver     2021-02-25  254  		policy_name =3D "left"=
;
> bc8fbc5f305aec Marco Elver     2021-02-25  255  		break;
> bc8fbc5f305aec Marco Elver     2021-02-25  256  	case ALLOCATE_RIGHT:
> bc8fbc5f305aec Marco Elver     2021-02-25  257  		policy_name =3D "right=
";
> bc8fbc5f305aec Marco Elver     2021-02-25  258  		break;
> bc8fbc5f305aec Marco Elver     2021-02-25  259  	case ALLOCATE_NONE:
> bc8fbc5f305aec Marco Elver     2021-02-25  260  		policy_name =3D "none"=
;
> bc8fbc5f305aec Marco Elver     2021-02-25  261  		break;
> bc8fbc5f305aec Marco Elver     2021-02-25  262  	}
> bc8fbc5f305aec Marco Elver     2021-02-25  263
> bc8fbc5f305aec Marco Elver     2021-02-25  264  	kunit_info(test, "%s: s=
ize=3D%zu, gfp=3D%x, policy=3D%s, cache=3D%i\n", __func__, size, gfp,
> bc8fbc5f305aec Marco Elver     2021-02-25  265  		   policy_name, !!test=
_cache);
> bc8fbc5f305aec Marco Elver     2021-02-25  266
> bc8fbc5f305aec Marco Elver     2021-02-25  267  	/*
> bc8fbc5f305aec Marco Elver     2021-02-25  268  	 * 100x the sample inte=
rval should be more than enough to ensure we get
> bc8fbc5f305aec Marco Elver     2021-02-25  269  	 * a KFENCE allocation =
eventually.
> bc8fbc5f305aec Marco Elver     2021-02-25  270  	 */
> 8913c610014823 Peng Liu        2022-02-11  271  	timeout =3D jiffies + m=
secs_to_jiffies(100 * kfence_sample_interval);
> bc8fbc5f305aec Marco Elver     2021-02-25  272  	/*
> bc8fbc5f305aec Marco Elver     2021-02-25  273  	 * Especially for non-p=
reemption kernels, ensure the allocation-gate
> bc8fbc5f305aec Marco Elver     2021-02-25  274  	 * timer can catch up: =
after @resched_after, every failed allocation
> bc8fbc5f305aec Marco Elver     2021-02-25  275  	 * attempt yields, to e=
nsure the allocation-gate timer is scheduled.
> bc8fbc5f305aec Marco Elver     2021-02-25  276  	 */
> 8913c610014823 Peng Liu        2022-02-11  277  	resched_after =3D jiffi=
es + msecs_to_jiffies(kfence_sample_interval);
> bc8fbc5f305aec Marco Elver     2021-02-25  278  	do {
> bc8fbc5f305aec Marco Elver     2021-02-25  279  		if (test_cache)
> bc8fbc5f305aec Marco Elver     2021-02-25  280  			alloc =3D kmem_cache_=
alloc(test_cache, gfp);
> bc8fbc5f305aec Marco Elver     2021-02-25  281  		else
> bc8fbc5f305aec Marco Elver     2021-02-25  282  			alloc =3D kmalloc(siz=
e, gfp);
>                                                                         =
                       ^^^
>
> bc8fbc5f305aec Marco Elver     2021-02-25  283
> bc8fbc5f305aec Marco Elver     2021-02-25  284  		if (is_kfence_address(=
alloc)) {
> 8dae0cfed57357 Vlastimil Babka 2021-11-03  285  			struct slab *slab =3D=
 virt_to_slab(alloc);
> 588c7fa022d7b2 Hyeonggon Yoo   2021-06-28  286  			struct kmem_cache *s =
=3D test_cache ?:
> 588c7fa022d7b2 Hyeonggon Yoo   2021-06-28 @287  					kmalloc_caches[kmal=
loc_type(GFP_KERNEL)][__kmalloc_index(size, false)];
>                                                                         =
                                             ^^^^^^^^^^
> I feel like using gfp might be correct but I'm not sure?  This code
> is from prior to this commit.  Let's add Marco to the CC.

Since this is a test program, I assume that "GFP_KERNEL" is used intention=
ally
instead of "gfp" here to check if the "kmalloc(size, gfp)" above gets the =
right kmalloc_caches[].
If so, is there a way to silence the smatch warning ("mm/kfence/kfence_tes=
t.c:287 test_alloc() warn: use 'gfp' here instead of GFP_KERNEL?") ?
But I'm not sure either, so adding Hyeonggon to the CC too...

Helge
