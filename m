Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEFF76A4F0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjGaXmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGaXmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:42:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A611B7;
        Mon, 31 Jul 2023 16:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59D0F61354;
        Mon, 31 Jul 2023 23:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59844C433C7;
        Mon, 31 Jul 2023 23:42:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="UUrvBJWV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1690846924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oDEj4ZMYPsnrtNMqlaK/E+PhnjwtZns9yVoBNmMRSI8=;
        b=UUrvBJWVIAa+EHbo792+e/LI6MmJx6qxbjHNMvSdgq81CMC7xS/VJWqOI3of694mjMbVZu
        /3DyKt++clnMxhndYNbcumMgC8Cqu8u/W7YWR9hUhUrutoXg3e/gkduX68FABXNtC7gl36
        2mmLYgHV++etBzFrBDA2WexCPblz3yg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3f1342d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 31 Jul 2023 23:42:04 +0000 (UTC)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-791c27bb91dso3266476241.0;
        Mon, 31 Jul 2023 16:42:03 -0700 (PDT)
X-Gm-Message-State: ABy/qLZWzMSJ8syVuVBgGfktchOfRf4d5fbEk8UdpwQ50DPrkwHtKmir
        kHdEMQMWKAdWEZ4eu2xy1Gf0nXYPGF5DmKQ+PMo=
X-Google-Smtp-Source: APBJJlGbhCA8s2VcukJuQ5St8I0zEYtxNOkB1Fd8EnU9UWazy1iffHbyDDhFCNDueE9Npr1BmbDTaz/2/fTWgc3Y0KI=
X-Received: by 2002:a05:6102:508a:b0:439:3e26:990e with SMTP id
 bl10-20020a056102508a00b004393e26990emr699937vsb.6.1690846922998; Mon, 31 Jul
 2023 16:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230727183805.69c36d6e@g14> <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
 <20230727193949.55c18805@g14> <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14> <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
 <20230727200527.4080c595@g14> <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki> <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
 <105b9d13-cedd-7d3c-1f29-2c65199f1de7@amd.com> <CAHk-=why64j-K4e1VxKwx7o6FiGjcXEnu1Pz+1QnNTBCv9AGyA@mail.gmail.com>
 <fd3cc87a-97ec-00ea-e480-f6597664c13a@amd.com> <CAHk-=whPvSJH=H9eHZbJQ+sxC-AVDvrgJ+M14fD3K5A+5s=zVA@mail.gmail.com>
In-Reply-To: <CAHk-=whPvSJH=H9eHZbJQ+sxC-AVDvrgJ+M14fD3K5A+5s=zVA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 1 Aug 2023 01:40:59 +0200
X-Gmail-Original-Message-ID: <CAHmME9r9DC+EMfxQy+HQAkf4AkAQnXNeBmOfCWnBUyiFQh2t6Q@mail.gmail.com>
Message-ID: <CAHmME9r9DC+EMfxQy+HQAkf4AkAQnXNeBmOfCWnBUyiFQh2t6Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        linux@dominikbrodowski.net, Jarkko Sakkinen <jarkko@kernel.org>,
        Daniil Stas <daniil.stas@posteo.net>,
        James.Bottomley@hansenpartnership.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've been tracking this issue with Mario on various threads and
bugzilla for a while now. My suggestion over at bugzilla was to just
disable all current AMD fTPMs by bumping the check for a major version
number, so that the hardware people can reenable it i it's ever fixed,
but only if this is something that the hardware people would actually
respect. As I understand it, Mario was going to check into it and see.
Failing that, yea, just disabling hwrng on fTPM seems like a fine
enough thing to do.

The reason I'm not too concerned about that is twofold:
- Systems with fTPM all have RDRAND anyway, so there's no entropy problem.
- fTPM *probably* uses the same random source as RDRAND -- the
TRNG_OUT MMIO register -- so it's not really doing much more than what
we already have available.

So this all seems fine. And Jarkko's patch seems more or less the
straight forward way of disabling it. But with that said, in order of
priority, maybe we should first try these:

1) Adjust the version check to a major-place fTPM version that AMD's
hardware team pinky swears will have this bug fixed. (Though, I can
already imagine somebody on the list shouting, "we don't trust
hardware teams to do anything with unreleased stuff!", which could be
valid.)
2) Remove the version check, but add some other query to detect AMD
fTPM vs realTPM, and ban fTPM.
- Remove the version check, and just check for AMD; this is Jarrko's patch.

Mario will know best the feasibility of (1) and (2).

Jason
