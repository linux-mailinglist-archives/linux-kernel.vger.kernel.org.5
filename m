Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4149B7FD8F9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbjK2OJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjK2OJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:09:33 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE65DE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:09:39 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4087C5C0190;
        Wed, 29 Nov 2023 09:09:39 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 29 Nov 2023 09:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701266979; x=1701353379; bh=+q
        u+qeNh3+1C6ZkG6XZRXQVSJWWMjxNHbgHk/fpruJc=; b=hibmqUm9vmYkMuw/R1
        w6/buezUiY/Et9DQD6vpIa6GC3RJ34uL4xlPVxydIzzwDxBXzvqajOxoR66/NQTU
        VZ8MFgwDKVTZD+5XGeZsLFcx9K0cTFHhw5eL5tE53Vhe585pmrB5O6DpmjZtgL/e
        nsRyflwAYTiO+8jx/ENkSmevCHfXdPN2UFCR6gGlPzVsLqMd9equ4Cm7eG/k8Mj0
        EoiWmJAOH8MdJ+/C0O3oY7rayWuZdzviQp5fFtFSSWB2DN+wN0CXkj2E1mGMNOoh
        bFYqXzvA8xFLawC2xat8x/TxLc4HNFomdKjTfRIKM5gTBApXthpX7GK20pJIzISo
        sA9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701266979; x=1701353379; bh=+qu+qeNh3+1C6
        ZkG6XZRXQVSJWWMjxNHbgHk/fpruJc=; b=y5DWYflcwlq4zKSOYBTE0QIf91ADt
        QGHs0XfIYrShCW3l4VJvRol0IYFdDpMgJpLHQ+jT0sRJ2l6FK53qX05yshg0S/qj
        VZrr29kYdj3WqYyP+v97xBvr8TvL57XYrBhBfM4pPpn5P5ste4lWSg1F6d837V3t
        ZrRKwr5XXl0WPTabwGo3RnMf0qb61IaywgEqNlwaOm66wPeu/tPH59huIGXh7qpM
        UoH/vZbW81ZVZiMKgt3GhhdCfW3JrMujx0CkxZ07jG5iYK+g4TzLvknNmEx5mYmh
        4HenuxS6kgh45VC2mY9xabtBPvRn+13pg/5YUFDwDEmB5J2cI88ZdIALg==
X-ME-Sender: <xms:IkZnZcp5E_Sm0ufACYRUf9SBPFhT0DCb_h1ue8UcWSsVsQri2uw9lg>
    <xme:IkZnZSpz5CXX3CPFkdU9S1FisB-duf8ITBW9eVm3LEMxwLD_p0yDfUZrWptJ7Zd7L
    3WfGqH3UbeD46TGd0M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeihedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:IkZnZRMd1e_tBwyFZo3UuVugRX1LPMzo9GT3elLRN_LJfE9tGtrgWA>
    <xmx:IkZnZT7fQyJgtgr9NBu2hStpJr36QhX9VzN6cYJUchE4aTh0KYU4Aw>
    <xmx:IkZnZb6F415No54jHkEAOnqp19Ap2uita_bOFWLtlDsGqgCDJ8dHqw>
    <xmx:I0ZnZap-7LZiMVr8P20vvkQfOI5l2Sw0-rigAPxA4RiAyDXWalKsCw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B4A21B6008D; Wed, 29 Nov 2023 09:09:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <81e78cb7-ec97-4cec-ac3a-674e296af93b@app.fastmail.com>
In-Reply-To: <20231128140818.261541-1-herve.codina@bootlin.com>
References: <20231128140818.261541-1-herve.codina@bootlin.com>
Date:   Wed, 29 Nov 2023 15:09:17 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Herve Codina" <herve.codina@bootlin.com>,
        "Qiang Zhao" <qiang.zhao@nxp.com>, "Leo Li" <leoyang.li@nxp.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Shengjiu Wang" <shengjiu.wang@gmail.com>,
        "Xiubo Li" <Xiubo.Lee@gmail.com>,
        "Fabio Estevam" <festevam@gmail.com>,
        "Nicolin Chen" <nicoleotsuka@gmail.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Mark Brown" <broonie@kernel.org>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/17] Prepare the PowerQUICC QMC and TSA for the HDLC QMC driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023, at 15:07, Herve Codina wrote:
> Hi,
>
> This series updates PowerQUICC QMC and TSA drivers to prepare the
> support for the QMC HDLC driver.
>
> Patches were previously sent as part of a full feature series:
> "Add support for QMC HDLC, framer infrastructure and PEF2256 framer" [1]
>
> The full feature series reached the v9 iteration.
> The v1 was sent the 07/25/2023 followed by the other iterations
> (07/26/2023, 08/09/2023, 08/18/2023, 09/12/2023, 09/22/2023, 09/28/2023,
> 10/11/23, 11/15/2023) and was ready to be merged in its v8.
>   https://lore.kernel.org/linux-kernel/20231025123215.5caca7d4@kernel.org/
>
> The lack of feedback from the Freescale SoC and the Quicc Engine
> maintainers (i.e. drivers/soc/fsl/qe/ to which the QMC and TSA drivers
> belong) blocks the entire full feature series.
> These patches are fixes and improvements to TSA and QMC drivers.
> These drivers were previously acked by Li Yang but without any feedback
> from Li Yang nor Qiang Zhao the series cannot move forward.
>
> In order to ease the review/merge, the full feature series has been
> split and this series contains patches related to the PowerQUICC SoC
> part (QMC and TSA).
>  - Perform some fixes (patches 1 to 5)
>  - Add support for child devices (patch 6)
>  - Add QMC dynamic timeslot support (patches 7 to 17)
>
> From the original full feature series, a patches extraction without any
> modification was done.

I took a rough look at the entire series and only have a few
minor comments to one patch, otherwise it looks fine to me.

I would still prefer for Li Yang to merge the patches and
send the pull request to soc@kernel.org, but if this also
gets stalled because of lack of feedback and there are no
objections to the content, you can send a PR there yourself.

     Arnd
