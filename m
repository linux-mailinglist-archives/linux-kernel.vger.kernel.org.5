Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99DD7746DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjHHTFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbjHHTEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:04:43 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E413AAFA12
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:48:42 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so9663853e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691516920; x=1692121720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A07tSATk4WyiLzh2AjGN9k9LM0i/q4SHz/ST015SGFQ=;
        b=SGlKoO5r9nAf4C5hJj3RUPzzNTKeA4oZ53vVCq01H8QMjVMbFYOFfkczKzt2Gm1G0F
         zhJq5I0VHXXxz+0ZGoUtFt1G3Nifx46UF3M44ghk8fikFi3a1mfAKmiCP0v8CQODi6nS
         s2AN60ll0J4XikLis90qC+hEYEzKAojXbCfVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516920; x=1692121720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A07tSATk4WyiLzh2AjGN9k9LM0i/q4SHz/ST015SGFQ=;
        b=isPjaY6vFSDwg2hOe8FgBfxwkhAxeP+O9fbrrBewGBCzMXgl1GbAS01/hkv3vPEIQT
         cpU5f+zguIpRUe52D55cvGYIKLJ1RUK62/SbWrpxqXcl/lyEAp3cqbSLZH3EXlE9IcCU
         25sSOn2rpiBMROaPXr8T24aRmhI20OINs9CYSJwAB/zYhTyBoqvILRV94lnyWLXtJam5
         sALeG9/NssYP8wsqTyZ0lhdeOT8Q32M/NhsajLWO8OS30tsKF7hDec1bRLFhz8ls0ADE
         LnQPZle2AoUArwCkZsUS1q3vfFbORE/RrNie5Y04NFmOcLKQdEEtuGfmVvZEgYHyYm7b
         /pFw==
X-Gm-Message-State: AOJu0YwkP5JGZK63XkgEVpAULM/7n49/+GuspwgN+oImLagx8itHrg1x
        uKXky9Qs2g0PYflofa9B4maNeoSJf7/BwZZJR9MZXSEy
X-Google-Smtp-Source: AGHT+IHfmW2Qk/fYGshWWtL/TL+F4xbVYU2qDRoLiT4TQNytrnW7DSvftV17pa0fBHu0pmGMc7qsQg==
X-Received: by 2002:a05:6512:2208:b0:4fd:fabf:b6ee with SMTP id h8-20020a056512220800b004fdfabfb6eemr188751lfu.9.1691516920477;
        Tue, 08 Aug 2023 10:48:40 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id p18-20020a19f012000000b004fe10276bbfsm1929473lfc.296.2023.08.08.10.48.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 10:48:37 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so9663754e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:48:37 -0700 (PDT)
X-Received: by 2002:a05:6512:159c:b0:4fd:f77d:5051 with SMTP id
 bp28-20020a056512159c00b004fdf77d5051mr149456lfb.26.1691516917321; Tue, 08
 Aug 2023 10:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230806230627.1394689-1-mjguzik@gmail.com> <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whk-8Pv5YXH4jNfyAf2xiQCGCUVyBWw71qJEafn4mT6vw@mail.gmail.com>
 <CAGudoHE5UDj0Y7fY=gicOq8Je=e1MX+5VWo04qoDRpHRG03fFg@mail.gmail.com>
 <CAHk-=wj+Uu+=iUZLc+MfOBKgRoyM56c0z0ustZKru0We9os63A@mail.gmail.com>
 <CAGudoHE=jJ+MKduj9-95Nk8_F=fkv2P+akftvFw1fVr46jm8ng@mail.gmail.com> <20230808-divers-verehren-02abcc37fe60@brauner>
In-Reply-To: <20230808-divers-verehren-02abcc37fe60@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Aug 2023 10:48:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKpvn_u_9R72JbBaTw8gQnzhoER3hnR4WQpY8j96Gxcg@mail.gmail.com>
Message-ID: <CAHk-=wgKpvn_u_9R72JbBaTw8gQnzhoER3hnR4WQpY8j96Gxcg@mail.gmail.com>
Subject: Re: [PATCH] fs: use __fput_sync in close(2)
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 at 10:36, Christian Brauner <brauner@kernel.org> wrote:
>
> @Linus, you ok with the appended thing?

Yes.

I do think that the CHECK_DATA_CORRUPTION() case (used to be in
filp_close, now in filp_flush) is now very questionable since we'll
end up doing an "fput()" on it anyway.

But I think that's actually not a new thing - it was always in the
wrong place, and only caught the "filp_close()" cases. Which -
considering that it would only happen with people using 'fput()'
incorrectly - was always quite suspicious.

The actual "CHECK_DATA_CORRUPTION()" part of the check is new, but the
check itself predates not just the git tree, but the BK history too.
Google does find that we had it trigger back in 1998, apparently.

I think we should probably remove it entirely - and just depend on all
our modern use-after-free infrastructure.

Or we could move it into __fput() itself - the ordering wrt any
flushing is immaterial, because it's no different from using read or
write or whatever on a stale file descriptor - and at least get much
better coverage of the situation where it would happen.

But that is, I think, a completely separate issue - this is all just
made more obvious by the reorganization.

              Linus
