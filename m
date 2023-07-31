Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E94B76A13D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjGaT2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjGaT2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:28:41 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300491982;
        Mon, 31 Jul 2023 12:28:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B9E253200929;
        Mon, 31 Jul 2023 15:28:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 31 Jul 2023 15:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1690831714; x=1690918114; bh=21+XkpRUbLZeIKu442d4wnN+PugW/pbxjsI
        iw4nwl6s=; b=HSLUgxtRyDJ3TBxG7lOWEX74r9gkMIVidtdkMmbNtWe6pS++Wj8
        2+uBak2i0yJcVxT2S3mwD/iRi2XsmoV3OgxVT4RFvIsBNoBHR8nFFnAwQ8gYaZeI
        5kC3AkFxbCFf5gSOMAB/FOowr9fKr/8acteguNjxtwvTYO3kxH7jk5qYGf5IOoCy
        qiKB5MDEIIMqPx/D0Lg9yZCofKzx/4iFGDf+wAOWlHk+Rh3Fq/TpvBsa3K1lJW8H
        1dIChU/d7137/z1IEkVR7RIzSutLC/77j+REXhRQwiiKFQSa7rjik9RNPe9hGXxD
        SA2gCRA4SUlP98/SDSVQuOj54SQ/FvOgFWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1690831714; x=1690918114; bh=21+XkpRUbLZeIKu442d4wnN+PugW/pbxjsI
        iw4nwl6s=; b=kE/jvzz99/pNxixJimgFSalnUt9k1Nl9+jEGgda8lPZcdDSGjmB
        WkUKUn0NIlLO8ckItJFXQW7XZyZVKZU1Jw+uhsbSaaVn/5CC3Irk1Oj7yW0J0Fno
        sce0bGtzgx6xu4L3e6gCqpSPZNNwHvcq5zkv3UWOk/Zp0BsYlBykwMewa3Npc9tM
        B+tBlPqxAFZpx0wvgtN9Ffp81JgLfKq8WGKouzBlTn6GTfdRbNzFkt1ui1BPpmsR
        xg3Yx8wUmX5X+eUUyMyGtVNRus0JgZaAU06bL9akJPWVYOHdWIQOGpa5JI5m74Ry
        aKAVFOkiN9ZHSvVw5J+Fi4DcuVl1iYuZSNw==
X-ME-Sender: <xms:YAvIZGZbAr3tIwZZdo3m5br1FpKey5bfxtoikAPFsCqKEfIG7PLlfg>
    <xme:YAvIZJaqHJZ6iDEsg-1-zD1lESh9EMfKKQlRwL_Rb7bxwq6C-QUQX5I4vOy6aBtr-
    skCy5Vf46cw2tjtHUs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeggdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:YAvIZA--H_mj92HwTymatoWq4T4xIQAuozShgGXezVEDFE8DAm5cDw>
    <xmx:YAvIZIrS_BMAmuajwOwrQeVSvT9fK6BVa6sxIXlyyb-zs5IVWXE_cQ>
    <xmx:YAvIZBplSaciC4t2M9551OFsq9-Zw8PJhB2uUG38cfw1lzVzth2Kjw>
    <xmx:YgvIZPiC-y-lEYLDHJdeKcNuOGyGiwG8OC0RxV_q0fxw7R_JcXusgw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AACC3B60089; Mon, 31 Jul 2023 15:28:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <58500dc7-af1b-4edb-bb2b-93be454ec151@app.fastmail.com>
In-Reply-To: <CAAhV-H7jVp2fX5Rosd8YSj_6oFdmsu5iHsBmYH_8iX2qan7r+w@mail.gmail.com>
References: <20230728074944.26746-1-zhuyinbo@loongson.cn>
 <20230728-cornball-preacher-a7e4644fcbef@wendy>
 <CAAhV-H5cfGZLvThzu_mBOphGJeUSFAu_4nZvGNFJqF5++DN2OA@mail.gmail.com>
 <20230728-unedited-thank-366462ab471d@wendy>
 <CAAhV-H7jVp2fX5Rosd8YSj_6oFdmsu5iHsBmYH_8iX2qan7r+w@mail.gmail.com>
Date:   Mon, 31 Jul 2023 21:28:11 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Huacai Chen" <chenhuacai@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>
Cc:     "Yinbo Zhu" <zhuyinbo@loongson.cn>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jianmin Lv" <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        "Liu Peibao" <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, "Liu Yun" <liuyun@loongson.cn>,
        "WANG Xuerui" <kernel@xen0n.name>
Subject: Re: [PATCH v5 0/2] soc: loongson2_pm: add power management support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023, at 16:13, Huacai Chen wrote:
> On Fri, Jul 28, 2023 at 6:18=E2=80=AFPM Conor Dooley <conor.dooley@mic=
rochip.com> wrote:

>>
>> Perhaps that someone is you, or maybe it is Yinbo, up to you guys to
>> decide :)
> I'm a "merge hater" and "rebase lover", so I think it is better that
> Arnd picks up these patches to the soc tree directly. But if
> necessary, I can also create a "soc-loongson-next" branch in my tree
> and then send PR to Arnd.

Separate patches are fine for a short series, it doesn't have
to be a pull request, but do make sure to send it to
soc@kernel.org after review is complete so I'll be sure to
take care of it in patchwork, I otherwise skip a lot of
patches as I expect them to be picked up into a platform
specific tree first.

Also, if this ends up being a genpd driver, then patches
after 6.6-rc1 need to go through Ulf's tree instead, not
the soc tree.

      Arnd
