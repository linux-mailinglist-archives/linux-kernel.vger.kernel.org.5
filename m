Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA95A790BF5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 14:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbjICMoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 08:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjICMoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 08:44:11 -0400
Received: from sonic310-57.consmr.mail.ir2.yahoo.com (sonic310-57.consmr.mail.ir2.yahoo.com [77.238.177.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D0710F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 05:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1693745044; bh=F2D1iE1yYlx04Zd2TcBuELMqwAZBbMB0N8BMx6gxJL0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=M8Hx9/bTZX5u1AauSYZ/SD8ZX5tvsmpX1NOpxqodty7hV7g1ybKwoc6hCfadbv5JCfmlYR8iVmzNvAlG4wQIgp/wtIWc3Gu4FkkJG9vg9YlHsbfdFZsPaumyI58WaIePravoSWCB7nd9f/q4aLwu1V4JeC0eu5f2NecdRjciWkWB1KmW6gZ5fIFEadiOF3I2c89+791SDFCPYTmBc0Vawp4jQJQljEpAspiy5+Ou3O4WiKsHHCXWjO8YLHw5GYiGbGBTQ2zrJfugZwRd4zWZXbwgA/IA3IF2OWYybaqHQt3QWafwLLz4klI8F+5VxjUp9nb7xXjZeOfVCKlZDuYyIA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693745044; bh=qVEqmZRmXAuwhr6UK2VDLfBdRsIDroCBcDyed+SXaXD=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=N5OkB/jcaMIPaBxcLq1AHsAdTxJOf93z6ZgD+gN+6CNKE9KX5JbuaSWLMaU1cU036hn7/5yd0ygD0B/dqbjvoEpPxB/L2E+llQfRb0xmC6L/92kO0wf4SqwDVZ/MbvFIDbB1HUvSRog7l+GpN8wms5EFmBSKg+EzEoTb5plWPpXdZEhhBdbRrVx/ZVUAg3nJ3qGGkgEotpeWhqetfgE/R9Wj45YgNM9RRnrlBgLklweh/IcS0gZeDqfYzft5BSt+C5hUvOtk9TFNoM2hYS33YTnfwQv38CBgZpBOKWGAGhJ04Nvht0dKIDr/SMNyJnGITznwbSHErRiMq57wsV03Jw==
X-YMail-OSG: bhZiEwIVM1k2OeR9lebTfUeG2znd3iUZl9TQMHGJ8uGiEGkWC22tmpPcoHmnvOs
 Y7L5_XHpzQ.WBP8rUuHXIuph1_N0W5FRndFhJsZls2W_tLAJ36Tkx7To8o0afKhXyexDqpS4Ou.R
 aRAm_7TjiVp3zZxDtb1rfMiTT.wr0rUCruZUgT5n1wCwbU1qOx1Tv5PGvaZ3uD5VYmAkwWUQiq0t
 T9HOSQOvoWgpYDAbhN3UxnTcy41xB_Lg2eTdks6hWy_WPgpOIS3JtQ_0Av3N6nxbYHATjW5pdojv
 HAfgJa26TLnYxPnyfj.qlZuJRJUGCz2W0xf7UZ54fjjo5kCV.hBKyJjk7U6bK6P1pdPX0_J9IYrL
 j9kEEZoM3rFlg47qWWXAEPK6gt_2iWscG_E.C5si55l5c8ViO5zWeR_XTXZXGs.KrT_uS5_GEyh2
 xkCGqRk5Y.tGaJ63Im.an8OKSTGZYeRBLNs.syxP.dk0ZVG_Iz7u7nyIuv7WHu8pyyua5L72qw6O
 yDYAu0mh8aeSV5nPuHkogIg_bHjfSdWxsKukBcSV5Am2guVsDv3Eo6aUJLV_tTzk4DFCanHHdNR5
 cdlmn9qne2LyL_ucSXu6WH9ABL0AvWiNQKZtHRQrEbQbFHVb2MXCk7_jfzn5BDOWpGBuyLr9L.Fv
 T49Pt_7Fb.pnxKmHDWLkOKmqx51uozY2JNLVi5g.ZLyDMJ7.DxwrgEJBKMpkPnKqjOX_uboxgTo6
 p5ZXJVLvu3yr79cxI9jkh.52rtmN5BtOQcf1UEBE1Rsr_vdgQxTgDmBenIgw0WKwThAsJLQdOibF
 Yrm3UWmXSPZLg9_cXU1JhCfsYDzuU.0IdU.tUQ1Qmlf6zr3tvKRgK7FHV5k_a0NNWvkUitWzhz3p
 LkuDI1qo9yLU_EjZE7J05dt7yPUPjLXAqidvozjtArJCLLomcbCUHy3aDMY0RosWsfU_dLupJN9Y
 xn2URYZBxSEtWPb7wUagIhkfCkuMB4jnQhjle4K4NnYFYXuUVyKjEM3EDcgpUX591bop0AzsyD0j
 ZkXTI98H_NQgVoAPxSjn48TnHDrq2eP9DKOccyewF7KREdt044P6KJ.gF6Ftz1AblvJtkW.Huv_b
 lxVldPAcFWJtnowgUn_1N4iGejjke24QMTwKz3Guqx2A.6tB.Nfeu6XVVzX.EX.l0N4vpdCOfPv1
 0xKuPPeklk_5GLVW9aTxFZgzmNJJA1vB.wRJg209mmKfrdFxmCOvWqmFFG7xahSnK5_ThTf.NY4Y
 Ig8YtBI_Y_Iip1PmAZ1u.wVZisp_ZW5qbbJkg4lQ.7CyUBLkp.bfFuXVMskyBKRFg_vx82AvZLE2
 AEXUgKPaTP10xmstiBlU9icn8IQw50sLK0UIIEdN5uNMAyo8UmT349uM7SKaa6lkLyJ585DXe0iO
 3H0Y.zn6McotbdaGQKM1jzLG81w1fjU3QOrMISCeDzTXF9vbw4l2unP34YLUpA2v0ReEd01x_HFE
 bVirVYmJm5kAMICMlsbw4tyQebb3Wy3LKPLcXFFpxgN32KQllyBphB97pRDAVPwHsnVSrtUQU3ih
 EY2jstgwGDEDs2xgi798eSHpyFeTi5LUonOy8devwI4yX1bd_hnODPAI95X7XlAt8dAitvX_MEzD
 6fxEYAFRLfv5iFZ4RFLldy0PbM1TD9pn7nQYH3qTuw63qiFyjTICf6nT5IMtUruwD5exnaaj0BOb
 evuxp1qln.iTcxz9SgokAgtNhAa43cUjpM0wjK.8fuv5lersHNDvmvH2i4_KzUsZorot1oqpYZoO
 tI_YQY5VtlmypW8We1_sBOy9pvCjWc6sc2vprN_6mDltycNqgqigZ.s7jIr8xHMt_9Ef8UNgjnX3
 m6n775UWwqxZ3bnXGD4CNVySxwqozXMSISfi0oKbL3UCqx0Q6BgX4FY8EXkebhKtcg5K49u_eSyk
 Xr2jjWhq6fuyQUU9ZJsXAAv4H7vTVCWov1Iq0qBOXOTDORAWdQzV1eg03cfp8J1ogFCN94BPY.gu
 NVJFV22ny8IAk3.RsqJ0Ur75QKaSm0.z6CL5j9I0bgPt.cAJrr5YuUdd4U2tNGKwE6CwctdvpvSe
 M8JKlO5CvRjGqVApyCU36WmQ5.w9cKcX40lPeXCsjgSoKFVMY6ejRGyqr9cOrA4VgUxKkUzMCAnE
 z.T1E4DYCR7vDoFOuKCwQTb9_U4MzsOGOSdtwW3C6.P9HY4qWFHkmTfi1WDumNrxtgUKeElO5YF9
 qJFzfZC7hU50LF0F8QzKAB9TNDDZh__XcdTbPTMAKfDrY8V_VQ29QtwlxKw0mKZdUoGNqZQ--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 4659669e-6d30-4d94-a68d-148d28952431
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Sun, 3 Sep 2023 12:44:04 +0000
Received: by hermes--production-ir2-5cc57b9c45-xh7tc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8c183e8fdb0c60d40f9a5dd2022be53b;
          Sun, 03 Sep 2023 12:43:58 +0000 (UTC)
Message-ID: <96c08475-72e7-9ef4-2f16-e962f9338e78@rocketmail.com>
Date:   Sun, 3 Sep 2023 14:43:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: (subset) [PATCH v6 06/10 RESEND] power: supply: rt5033_charger:
 Add cable detection and USB OTG supply
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1684182964.git.jahau@rocketmail.com>
 <223b440ab6831f2e7302d2c49b2cfd7779d5effd.1684182964.git.jahau@rocketmail.com>
 <169226510772.947223.494995318945916008.b4-ty@kernel.org>
 <20230822070737.GP1380343@google.com>
 <20230822212909.mcnziqsuu523e4gk@mercury.elektranox.org>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20230822212909.mcnziqsuu523e4gk@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21763 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 22.08.23 23:29, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Aug 22, 2023 at 08:07:37AM +0100, Lee Jones wrote:
>> On Thu, 17 Aug 2023, Lee Jones wrote:
>>
>>> On Mon, 15 May 2023 22:57:15 +0200, Jakob Hauser wrote:
>>>> Implement cable detection by extcon and handle the driver according to the
>>>> connector type.
>>>>
>>>> There are basically three types of action: "set_charging", "set_otg" and
>>>> "set_disconnect".
>>>>
>>>> A forth helper function to "unset_otg" was added because this is used in both
>>>> "set_charging" and "set_disconnect". In the first case it covers the rather
>>>> rare event that someone changes from OTG to charging without disconnect. In
>>>> the second case, when disconnecting, the values are set back to the ones from
>>>> initialization to return into a defined state.
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [06/10] power: supply: rt5033_charger: Add cable detection and USB OTG supply
>>>          commit: c1af6bcc8583b0a1083338cd26c2090d0bcb0810
>>
>> Multiple fixes now follow this patch, so I am unapplying it.
>>
>> Sebastian, would you mind collecting it up please?
> 
> I'm leaving for a two week hiking trip (with basically no internet
> access) in some hours. My planed return date is basically when Linus
> is expected to tag 6.6-rc1, so I will not queue any more patches and
> send my pull request early (within the next few hours).
> 
> I planned to catch up with the power-supply backlog last week during
> Chaos Communication Camp, but it was too hot to do any sensible
> review. Now I expect to process the power-supply backlog in the
> week after the merge window.

The patch 6 of the rt5033-charger series v6 gathered some issues. For 
all of them a solution was provided. Thanks to everyone involved! 
However, I don't know what's the best way to put them together.

- As the patch 6 was forgotten to apply with the others of the
   patchset, in the meantime another small patch by Rob sneaked in. The
   patch 6 needs to be rebased on Rob's patch. It affects the includes.
   Would be nice to order them alphabetically after rebase.

- After patch 6 was added on top of Rob's patch in linux-next, there
   was a build failure. This is because "linux/of.h" now explicitly
   needs to be added to the rt5033-charger driver. Stephen Rothwell
   provided a fix. I'm not sure on the order: Maybe that needs to be
   added before adding patch 6 to avoid the build failure when the
   kernel test bot checks each commit separately.
 
https://lore.kernel.org/linux-next/20230821125741.3a2474d7@canb.auug.org.au/T/#u

- Beyond that, the kernel test bot also complained about undefined
   reference related to extcon. I didn't understand why this happens
   because the driver has "linux/extcon.h" included. Randy was attentive
   and provided a fix. Here again I'm not sure about the order, I guess
   this should be added before adding patch 6 to avoid build failures if
   each commit is tested separately.
   Kernel test bot complaints:
     x86_64 clang 
https://lore.kernel.org/oe-kbuild-all/202308220324.LsI8q3ML-lkp@intel.com/T/#u
     x86_64 gcc 
https://lore.kernel.org/oe-kbuild-all/202308240723.O2rW0InU-lkp@intel.com/T/#u
     arm gcc 
https://lore.kernel.org/oe-kbuild-all/202308250617.ue4uQxWa-lkp@intel.com/T/#u
   Fix by Randy:
 
https://lore.kernel.org/linux-pm/20230828224201.26823-1-rdunlap@infradead.org/T/#u

- Yang noticed that the mutex_unlock() is not handled correctly in
   some error path and provided a fix:
 
https://lore.kernel.org/linux-pm/20230822030207.644738-1-yangyingliang@huawei.com/T/#u

- There are two clean-up patches by me. They need to be rebased to the
   patches mentioned above but there shouldn't be conflicts with them.
 
https://lore.kernel.org/linux-pm/cover.1686948074.git.jahau@rocketmail.com/T/#u

Please also note that the commit hash in the linked fixes above refers 
to linux-next, where the patch 6 had been applied. As the patch was 
dropped later on, I don't know what this means for the commit hashes in 
the fixes.

What's the best way to proceed? Can you put these patches together? Or 
do you want me something to do?

Kind regards,
Jakob
