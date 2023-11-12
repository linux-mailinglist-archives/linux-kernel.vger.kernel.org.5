Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3113B7E8DE0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 02:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjKLBY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 20:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKLBYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 20:24:24 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FCE30F7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 17:24:21 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9d267605ceeso509727966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 17:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699752259; x=1700357059; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5W04PQlZqv3bCKdRWWAr7QM/mGSWd/xIDdryxJpTT1o=;
        b=RcDPHGJHHOOgJZH/wHy6xVxdE2Wmqqk3yma9riLo17z/yv0Lb1uJuXkpImxDPr2hrp
         /18vySr5I6h0DiUMsXlrAuSF0THo/xYorncYJ4Cuftk+nZgMXSWuml0r9X5pU77THFA3
         mFTEkuh7w+nuxLswj8TKIUm+e2wsv4xac0qqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699752259; x=1700357059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5W04PQlZqv3bCKdRWWAr7QM/mGSWd/xIDdryxJpTT1o=;
        b=nx9HIWJ93nYl7GkWQfBZ4x5o1r3vSrXdFXrvrTtj7qjHPirGgugIZv5VfA2ljja5UR
         Ry3xd9m49Lhu1jQ+eehJJfWv4ihIUEqfM4cgGUkOXwJ1/LIpT7S04omfBYZIoETiZuXH
         5p4E+BjZFNIaY987aDFmdOq46s9jMeJ+r2x4lHQBQ1KScBcXFBzr8SA6UtH7NoVxABfC
         Xf1k0vWZ8Xh1fO/8kOJPcQxgMaDzBzjfojk4zpRVJROdhzvZw/Nd58FSko+it0BnkD1/
         cATxsff2Zo6QWXoE6aF0QJcXygjTLTn+ZJeOtKgnNPi3MncSAgIZ6ANF+/T7AsKPxVw3
         cgHw==
X-Gm-Message-State: AOJu0YxNBY4cYnBb6NZmEwDqSoCOz/SGhVKSVbDYAHaOlkNnGcnhW4H6
        GqrdNXXxNfGrYlYJ8c9yWepm9c+PclM0HQpdqL2Z9A==
X-Google-Smtp-Source: AGHT+IFcvJxwhAV9AgrkO+tS0KSlO0tqmuKux7ugpMsHWqIamtaCENzRCWeRyjXs96nV+W0YwhTayg==
X-Received: by 2002:a17:906:e0cc:b0:9da:e922:12f1 with SMTP id gl12-20020a170906e0cc00b009dae92212f1mr2231415ejb.18.1699752258946;
        Sat, 11 Nov 2023 17:24:18 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id m13-20020a1709060d8d00b009ddc90505desm1847925eji.141.2023.11.11.17.24.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Nov 2023 17:24:17 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso5056938a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 17:24:17 -0800 (PST)
X-Received: by 2002:a05:6402:138f:b0:53e:78ed:924d with SMTP id
 b15-20020a056402138f00b0053e78ed924dmr2051608edv.5.1699752257302; Sat, 11 Nov
 2023 17:24:17 -0800 (PST)
MIME-Version: 1.0
References: <20231111125126.11665-1-yjnworkstation@gmail.com> <20231111132431.GA3717@1wt.eu>
In-Reply-To: <20231111132431.GA3717@1wt.eu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Nov 2023 17:24:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTZDjeH2FJqBozjAF44sh4XVNQrt2xdQn_Ujt=Be6=dw@mail.gmail.com>
Message-ID: <CAHk-=whTZDjeH2FJqBozjAF44sh4XVNQrt2xdQn_Ujt=Be6=dw@mail.gmail.com>
Subject: Re: [PATCH] exitz syscall
To:     Willy Tarreau <w@1wt.eu>
Cc:     York Jasper Niebuhr <yjnworkstation@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Nov 2023 at 05:24, Willy Tarreau <w@1wt.eu> wrote:
>
> IMHO it does not make sense to add a syscall for this, please have a
> look at prctl(2) instead, which is already used for similar settings.

Honestly, I don't think it makes any sense at all.

If the key manager people can't be bothered to keep track of their
keys, the kernel certainly shouldn't be bothered with this kind of
huge hammer.

It looks like an active DoS attack to me, by anybody who just creates
a huge process and then sits there giggling as the machine comes to a
complete halt, with the kernel busy zeroing pointless crap.

Do it in user space. And if your user space randomly crashes, you have
other problems - but you can try to use ptrace to catch even that case
if you care.

          Linus
