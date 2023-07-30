Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5548B7686EF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 19:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjG3R65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjG3R64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:58:56 -0400
Received: from sonic302-21.consmr.mail.ir2.yahoo.com (sonic302-21.consmr.mail.ir2.yahoo.com [87.248.110.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F942E6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1690739932; bh=qdmZlgfteMifBTTRwS+MuuJoyBhIjTJdVNv+FQYKI6c=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=TPqRt/D4v5cIIUffCfrsXEJ2cj2/M0Gvr40n8Ikujk02jXv6A0Y7C7+QV0FtV/l4aSI2mOh26thkKlnI9LZ/778cwIddla0N7UetWmIm7kpMd5PChICUD2hh+C9nEVgvfuYw2SwwGb8g772fVGjSeOjWBfBed0nE484GNAmcgSlWZnt8E700FzyD5a62N4Udy0uBRRTGlUU65siEanimVfWnzqnKh3erYEfF9x7AiMqBdh8K2R/HD2D8HTbFUGL3Sbb93cDI0H7vchu+RLw+b1fnGPGKjHqim4A0C1Pk/YwqzeWIUO/jzmy3ecqayZzW2TKTGQv1anxpg50h61ShPQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1690739932; bh=SE1LGEcuKKt+RF+O1daF7g2no92d/TJtm6esaQd8jtI=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=m+a2NubljPbNjpS/I0fALoxN8x+AFA6ItwCLKVDYuWNWL8Rqco4VzPT4ycCFRBbMWfFJgXtOHUsB9dBltd39Nl2onu3IlE47vJW772zSabdWDrB0lISNKUNTmt1201tH1Uof2efwovXuPSU1DWo/MCnJsIbUCFapCn/Y5M1fP7X3zY/7irdwBwDOs1CXi1hgXpUUIfFntJo5lm9BI584yAQ3I9AlaZwHTJpL+U6wGt4WYTNn8Qjl11p//cwSwkqD2IaGii7ReyUBGVoFjaO4uOnNJuE6pKdi94m4E9HIBpvsY5zxXW1fFiMGIPfel5dTiemcn6hkKQoeII2tBl5XqQ==
X-YMail-OSG: LXNV7YUVM1m4q6BXHuyV2ByO5wHVtjLRn0C7WNEpRGqNZCSpstQSBB4aA4hRUqG
 yzIFgGcAysxWxcQdzcLD6x7pT19Y9aCVDlel4jCG.hi2jqJl9KuxnZNyqmmmfw25SJzy8h1yxjaf
 Y76vXf2OEI2w5qmPAQg6whv6d_AU0y62MlktmXrY2bsfWaQmA1R_Mmh59liMSWNYXOcH4iIDmt.X
 _CRDkk.XWfVAG5Mk5xgKc2op33ZnWVK3femIvHBBSHEQpgMZXQId_di7tKBPPrW._LLdp7hsoqGF
 h1F4Q5hTKKmac7fxVUA7hTn6UCCfl1VAbwBwKvmKxlMcBI4F7YUTfQ_qYhihkBuwkMf_1WU5Rc_P
 HqXu9FMQ5InVIVjQ3CZjDiehZ3jCS3Ld5a.d5pd6RSqPUVAVKWjCp4_tDEImBu26RBvCsniif70p
 2_6oeHxOCxsvodOtwvmfhLDf7JeTFHfIxVo9HALG5M0qgqo6Lj9vSyiSo95LQMRENYUa6xidXgoS
 Qe35qaRUcFR_Jpj5VJaMgMIaJrL19Qm01PSTb0VeJu1zke3CBIbagfbk0ti12_4nMyk3h624tiwV
 edVjth4NCsazkEUIQb1FLfKJiou9XJkC9e3a3g_7UtsTsNedzFuVszg2zdOLipifswkOAG..rUk3
 pHk2qT1Ac1Uy6jsq52D_KYIHpBb7J1X90Ww_QSKRDTJQQHtHZP6Bj_8rWogfPRlCsPPjmX0d2wNn
 7HZImw2zoxpirJeyVlec7ARhHqEVKFPLZKSMX_yPcymEEGcRcby2qHgaavi2muBM0l6VZ34myqtV
 VH4DvIEAuNUcxAAskqzRDqWlM9dCop90h7e7A5VQ7KMfdlpVINvGPYk7rcKs1PwM5nI2uMJarRjp
 KDE3NkC6JWOryS_O_Z4VP7k4.ZaMfwPLp0MWIF1_i.aYjglJHUk8cKawBGmv2S6UMZsr38nf8S8u
 lJ2gM2Y2hpvq5bOOA1gBWnS86AOL6eO169bEnFPPvtmz7jt0hRqaS9fE_E3K6NJhMiXJU7kFO68F
 3RpbyMouFqIkG4U5DEuFRKPT.Yv0gViuf9oHXJw16gdlOM9A0u3j_d4vLTI2DJ13n_Qq6pZTAmnn
 fGnFem8nqlx0KpBVD096EhOVyyy5AaQajjrjzZiZ8DQgS8bdc5nhAEoQWCe9BEElqJ7K_nCjiDcb
 mPfVc1x_D.nz4B6Q2SDRCVMPiAt2Sj4x2ib1mslDcINLfWOu4mKS00z2Q_rphIeWNxeNp2ux.tdR
 mqkYciXEh5Z05ZltnaPDtoXfaxuGBGMNT5ai2Ra67tdHGXi5ZPPnO1ClgLfuTp5gHt_L02gXcXUk
 ryx_.L9sF.YZq8PcsNP3HJdFkQAKHRgtucX1q3DXDDeawQAoGsbSFTQT67ZAhniWNbIRSryjjpQR
 vhXRzl6RHn5ps_n3qnverRsN8_9w3jsU4YYaU3W2g8urUhFomVgybyiA1HfXskumynxtYv92Ovux
 VqXs1GVUGGeEmCqfodsxeT.5xF56p9cT8LYVLn9oYXoTsshqFbv0Cv.oImkECycB6Sehwr7BHnNE
 w3j76UKqqNnco50Hl4WtPDfY8OAUCNJYJwbRHjGZD1CtotrYSwH58qqdXG20kCeeOYMVjQ7V9GDP
 YdzgqcBSM6okww3tFo7yoO0WwEcRB6FBH37..Gs._xigD4N.RnP6_eVa_1EA6xex0VFa3Vy3Pcos
 QDsx0d4SAPEQCe8hBUfQVaqzivI23OWYdBcBweCjhlaRojyneD8sfSsfBk2Gq.o_rNjPT1c.PZWi
 1abYsdvl.6RLBzp_KsPkhKIjlYc.dyHbCU3nNX57I4MxTYNlwGhwDNr1lelNf6T7hgs_sa3NMrAS
 KVOu5VEUoKpZ0u8YHYjRQfcsirerWtX6Ahh7Ku06BGPXs0WFSoebGJyU4I8rlgkRnKd1qXDWFDBa
 yIFusshKRrITwoe.JW79U.JPWJ1gdb6E18dj6YjXsy4Wea.E6FYpdt1lEF4z_OrfaSGx_Et0yK7r
 eKlWtIAG2YS6g8aorH2YMBuW.FJ8M1nH6UIfcKixziQMVUTvZ3LZ0FAvvjbL2hhWyRJ1s78X5XTS
 D60rQvr6xC.K35XNg3lMcbExsStgdVpNz2jG3G1UYM8TZ6G71j.x83GZ6BmEZw43BOAM8hYjTZEL
 hkb_lbDvmERtXzUaVZR1oIzFcnJn2OYfXPOZGGY9.XYgP09ke2zf8ox4asah1TwCYTjf3rY2TzvQ
 5UCslaL0N3veINW9XhOP6ZzSkr96nHp9OjwqQLqk5tcgCJVkRYkOy2a9w4KOBss0XbY0.VfR86Xa
 09M1hT.wF
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 863f03c4-a2b9-49af-9003-742551aabaca
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Sun, 30 Jul 2023 17:58:52 +0000
Received: by hermes--production-ir2-7b7ddb79d8-nb2vw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b6bf6624ec9fc85e0e6c51824a35a031;
          Sun, 30 Jul 2023 17:58:48 +0000 (UTC)
Message-ID: <bac8be58-8cac-4bf3-5754-974c7d7ecdba@rocketmail.com>
Date:   Sun, 30 Jul 2023 19:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [GIT PULL] Immutable branch between MFD and Power due for the
 v6.5 merge window
Content-Language: en-US
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
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1684182964.git.jahau.ref@rocketmail.com>
 <cover.1684182964.git.jahau@rocketmail.com>
 <20230609064753.GL3635807@google.com>
 <faff027d-2a6a-22ca-2487-2ae05223fabd@rocketmail.com>
 <20230619103524.GA1472962@google.com>
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20230619103524.GA1472962@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21647 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

The patch 6 "power: supply: rt5033_charger: Add cable detection and USB 
OTG supply" of the series v6 RESEND of rt5033-charger is still missing.

On 19.06.23 12:35, Lee Jones wrote:
> Sebastian,
> 
> On Fri, 16 Jun 2023, Jakob Hauser wrote:

...

>> I just realized that there is one patch missing in the immutable branch
>> "ib-mfd-power-v6.5" [1]. Unfortunately I haven't noticed earlier. The
>> immutable branch holds 9 patches, the patchset has 10 patches [2]. The
>> missing patch is No. 6 "power: supply: rt5033_charger: Add cable detection
>> and USB OTG supply".
> 
> Did you take this pull-request?
> 
> If so, would you like to apply the missing patch or would you like me to
> take it via MFD (without a subsequent PR)?
> 
>> As this patch No. 6 affects only the file
>> drivers/power/supply/rt5033_charger.c and is the last patch on that file,
>> it's no problem to add this patch on top of the other patches.
>>
>> Could you submit another pull request for the v6.5 merge window to add this
>> patch?
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=ib-mfd-power-6.5
>> [2] https://lore.kernel.org/linux-pm/cover.1684182964.git.jahau@rocketmail.com/T/#t
...

The lore link of the series v6 RESEND is above [2]. The patchwork link 
to v6 RESEND is:
https://patchwork.kernel.org/project/linux-pm/list/?series=747771&state=%2A&archive=both

Additionally, there were two follow-up clean-up patches. There were no 
review comments so far. Lore and patchwork links are:
https://lore.kernel.org/linux-pm/cover.1686948074.git.jahau@rocketmail.com/T/#t
https://patchwork.kernel.org/project/linux-pm/list/?series=758018&state=%2A&archive=both

Could you apply those three patches? (1x patch 6 of v6 RESEND series + 
2x clean-up patches.)

I've just noticed that a new patch by Rob was added to rt5033-charger. 
Can you rebase the other three patches by your own or do you want me to 
rebase and resend them?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/power/supply/rt5033_charger.c?id=2ce8284c31156c432df60d4497ec68cca04e128f

Kind regards,
Jakob
