Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F76A758326
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjGRRAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGRRAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:00:15 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8984E3AA9;
        Tue, 18 Jul 2023 09:59:00 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b700e85950so87808401fa.3;
        Tue, 18 Jul 2023 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689699489; x=1692291489;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=piv6yKOZr5H8L6Z/MbrhVqXE/T2un3gN3bixhhcUgIQ=;
        b=sLfjoWtxXgfmoCM5uzN+QiAV7s5rvyuzl0uF1pmtgPoTK3sCb2Lg4bDEZBGyqBlmpE
         arbksOOJ6sSphZBdsJqH9NBXCDYADqXDtveYunhtiv2SYLJ5dAZINEEco98eiY3kqqLU
         11PLXOgsJwCPx2/Bn4Q2molGMAH1Z2YdiLXWUyNfAP+MFKRXp5oopBaboPTFTLuryl7z
         9kAjnHQww6CHF/rP5Wte/mtC9466XO7FoJlg6qzgt5GLrE4wlwQsSmRqUBCljeL/dzoq
         q4gP7MITlAp84eNr8F/ZzvO3iciZhmTSFJqaVEaZVDZv3/qCJwb+B3vdhU4bVTir96Mh
         WvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689699489; x=1692291489;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piv6yKOZr5H8L6Z/MbrhVqXE/T2un3gN3bixhhcUgIQ=;
        b=b53J3fpbpUx80ngCbZifNrpBlNCG1kDsAr9kftNcEwtJ9vDuI6/3tjKNqCTn4p8vDN
         2iH2HOGljNQesqZvPkWp8FkIEAVEN04P9sWQNkcF6cnTzjfyi+3754KqcMaPS1jqOAXP
         pBahdtm70ner/VkkOMJ6xGB1Wkp+iz3FmzUkHog4w3+XKC+5QXp6aywbeiwXPmkv1WdK
         q1rvmaF6inPkabi611jHpglAA7S81y/E7F0kokfNLFhSxvxkEnQx4UFYyyJNbiEqgWjL
         /xGM3UGFLIdcKWNoM7JgtHQ1ZHoh+4qSMwkn4fSBnNS03twRUncjHZhwxk8J0PC30+5j
         q7kA==
X-Gm-Message-State: ABy/qLaT1PdxeEkppnqwwoKO89ubZ90QRa62pcE6PzrtQ/gTE+coFbVR
        vTO10y4PYyO7WXBArXdHQ3c=
X-Google-Smtp-Source: APBJJlG5yyD8I8l6zeLQe93Zg8PVfJF/JTKVcMdHGj6BJR9ybouT9eDKpFSOEWA1LVLrxTx7lbfEdA==
X-Received: by 2002:a2e:9643:0:b0:2b6:bb08:91c4 with SMTP id z3-20020a2e9643000000b002b6bb0891c4mr2392746ljh.42.1689699488508;
        Tue, 18 Jul 2023 09:58:08 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id rp25-20020a170906d97900b009786ae9ed50sm1224355ejb.194.2023.07.18.09.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 09:58:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0F75427C0054;
        Tue, 18 Jul 2023 12:58:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 18 Jul 2023 12:58:06 -0400
X-ME-Sender: <xms:ncS2ZOoddD4MhECzZzMmALo3k_mSuMVLeqj8Iw6m9j9ofRCLZVDQ-g>
    <xme:ncS2ZMoU_7FqoUBAZNS_Wa2ZBOItFbr7PmJYvyZmpoVQqJRCVcG_RQCZEgXmndIbS
    Ph_cRRLjHjUkemqvg>
X-ME-Received: <xmr:ncS2ZDOu4UPtZkmTvGLPwQd-2pY4aVidryZbJeIY1a2xxMwxlwJjNo9zGuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeortddttddunecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvdekueeuleeigfejffeiieefudejjeekkeejjefgfedvtdekfffgvdfh
    uefghfetnecuffhomhgrihhnpehruhhsthdqfhhorhdqlhhinhhugidrtghomhdplhhptg
    drvghvvghnthhspdihohhuthhusggvrdgtohhmpdhkrghnghhrvghjohhsrdgtohhmpdhk
    vghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:ncS2ZN5pgL-baAFhBQB5R8_BurpKGxSLmCpsqOUmx8kEkKIfIU14RA>
    <xmx:ncS2ZN5LtkFr5RKnMGhGo7COHTaJO288OW1pDa-DF3rGYBdAYFe4pQ>
    <xmx:ncS2ZNhdVrgVyU4fat3nOrD9zint1eAcL4fuFfqI9QRWfbRg5ch58w>
    <xmx:nsS2ZKyR30zW5LJwXpSeJKWjkwySGO7ZRewaiemCvjrXrkAUTIbqgw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jul 2023 12:58:04 -0400 (EDT)
Date:   Tue, 18 Jul 2023 09:58:01 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: add Andreas Hindborg as Rust reviewer
Message-ID: <ZLbEmdMcAjQUmOFF@boqun-archlinux>
References: <20230718054426.1048583-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230718054426.1048583-1-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 07:44:25AM +0200, Miguel Ojeda wrote:
> Andreas has been involved with the Rust for Linux project for more than
> a year now. He has been primarily working on the Rust NVMe driver [1],
> presenting it in several places (such as LPC [2][3] and Kangrejos [4]).
> 
> In addition, he recently submitted the Rust null block driver [5] and
> has been reviewing patches in the mailing list for some months.
> 
> Thus add him to the `RUST` entry as reviewer.
> 
> Link: https://rust-for-linux.com/nvme-driver [1]
> Link: https://lpc.events/event/16/contributions/1180/attachments/1017/1961/deck.pdf [2]
> Link: https://www.youtube.com/watch?v=BwywU1MqW38 [3]
> Link: https://kangrejos.com/A%20Linux%20(PCI)%20NVMe%20Driver%20in%20Rust.pdf [4]
> Link: https://lore.kernel.org/rust-for-linux/20230503090708.2524310-1-nmi@metaspace.dk/ [5]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Welcome!

Regards,
Boqun

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3be1bdfe8ecc..f2f0426258f3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18542,6 +18542,7 @@ R:	Boqun Feng <boqun.feng@gmail.com>
>  R:	Gary Guo <gary@garyguo.net>
>  R:	Björn Roy Baron <bjorn3_gh@protonmail.com>
>  R:	Benno Lossin <benno.lossin@proton.me>
> +R:	Andreas Hindborg <a.hindborg@samsung.com>
>  L:	rust-for-linux@vger.kernel.org
>  S:	Supported
>  W:	https://github.com/Rust-for-Linux/linux
> 
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> -- 
> 2.41.0
> 
