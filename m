Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5A778DDAF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244398AbjH3SxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343608AbjH3QO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:14:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D6A1A1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:14:23 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52a1132b685so7913001a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693412062; x=1694016862; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J+IbjS4hQ1xrZMoTCi3gEShIbmawdzOCZjpHyuEsjwE=;
        b=Gnl7aNzYPtrmKPd2soG+AnuedyHsV2D6aANBFj+BUNr8B2CVnLSa/KzP4KnFrXWXbf
         Z+EvRqCVV8h5nV0fAfnHXwovd3gIxFK5nzgV8k4/DTh+HBtLMR7xYpbO1MsjfoqYT4EX
         ooJGRfidtAMiAXmB9L5UaRJBhTFbI7ttviMCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693412062; x=1694016862;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+IbjS4hQ1xrZMoTCi3gEShIbmawdzOCZjpHyuEsjwE=;
        b=QYz0bjBS/pGaReHABp/fKRXkaqPRx4dX/YwGw01/i+jw5Rc+dlna+SMnfX9Je6D9x6
         ErzM4o+zSEZYeGJiJV0XbVZfjUs3q4s3c8r840yBHE41KpRAQx260/2pxrM/IJwGeFg2
         lDSDMrjimNCsu5SFkBsXAyvqmqJbFxkP+euT4IZmsxLgseD1zzrX5u6OG5BJB3DsUlQB
         cRFTJi9TcFqY+CtLb0fuaR8oPLvJePxfk6aHA7L/9M9XPJEIVsVK8lrtI4jp+5FdBX5O
         1r3cBQSqzJIJGRzx/SWUNTIjySonvG+c+wNOGVZcwHxmpQDMKMbeQGsm1CID0agsuo1v
         a1MQ==
X-Gm-Message-State: AOJu0Ywh/TcVuugorzt7wXIGNNAf5r4QLx3HXSIwSNpDooYdnutzEGqT
        Xgb8F7VO1OIZoP2wsWrU1vPhGRwax9bvmPcF3wY5qpU8
X-Google-Smtp-Source: AGHT+IGveq16x6/uiYztit4L7O3HjpgfrHZDkhtKafzHvP5+gQmBN4O6GT+aNCyU9gkNRcqriCfWaA==
X-Received: by 2002:a17:906:113:b0:9a5:9f8d:764 with SMTP id 19-20020a170906011300b009a59f8d0764mr2095589eje.77.1693412061661;
        Wed, 30 Aug 2023 09:14:21 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id rk17-20020a170907215100b00988c0c175c6sm7320790ejb.189.2023.08.30.09.14.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 09:14:21 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-99c4923195dso727853566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:14:21 -0700 (PDT)
X-Received: by 2002:a17:906:518e:b0:99e:1201:48bc with SMTP id
 y14-20020a170906518e00b0099e120148bcmr2002148ejk.64.1693412060814; Wed, 30
 Aug 2023 09:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQQqQCdcSdb7G8v1ZHU8zn0XJZ6hS0rbGufAuZyPSCDCA@mail.gmail.com>
In-Reply-To: <CAHC9VhQQqQCdcSdb7G8v1ZHU8zn0XJZ6hS0rbGufAuZyPSCDCA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Aug 2023 09:14:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgvT9yJT+QwWHArnO7c64_g3kXzMi5xr7j-a55kZAdGhg@mail.gmail.com>
Message-ID: <CAHk-=wgvT9yJT+QwWHArnO7c64_g3kXzMi5xr7j-a55kZAdGhg@mail.gmail.com>
Subject: Re: [GIT PULL] LSM patches for v6.6
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 16:37, Paul Moore <paul@paul-moore.com> wrote:
>
> Ten LSM patches for the Linux v6.6 merge window, and while most of
> them are fairly minor, there is at least one merge conflict involving
> security_sk_classify_flow() in security/security.c; it looks like a
> netdev constification patch collided with a LSM documentation patch,
> thankfully the solution is relatively simple but if for some odd
> reason you need a respin let me know.

Oh, no, trivial things like these are truly not a problem at all.

The only time I may ask people to help with the resolution (or, more
commonly, ask them to just double-check what I did) is when there is
an actual and subtle code conflict where the code in question has been
re-organized a lot, and both sides did something fairly involved, and
the end result isn't really obvious.

For something like this, I do ask for it to be noted in the pull
request - exactly like  you did - but even that is mainly so that

 (a) I don't get surprised when I do the pull and see that I need to
resolve something, and

 (b) to give me the warm and fuzzies that the maintainers in question
have actually noticed and followed up on the reports from linux-next.

So absolutely no need for any re-spin, and you did the right thing. Thanks,

                      Linus
