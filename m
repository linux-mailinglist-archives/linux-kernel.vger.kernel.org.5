Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6AE790E08
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 22:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348029AbjICU6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 16:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbjICU6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 16:58:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533C7102
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 13:58:19 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99df431d4bfso124483966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 13:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693774697; x=1694379497; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ES+nP5YI4ojciRGg08Ds7F16RLNJw7ES3Qm1BqAAXxs=;
        b=DB6OohYVquYWQWYYwRDSVd+D3iZaeok/pOQvrNjQst5gFB2fQvcjIoBBWhMrO4ZSXi
         FJriqVB3BqYEXAAPneYY2d92xmCMKC3JvhyojtHQeZ4yVDQKboCKBW+cwCbk/JRCz/D+
         nhGwnqBlpe9Z/EqwBz4js0QOqVLwUoRRrOy2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693774697; x=1694379497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ES+nP5YI4ojciRGg08Ds7F16RLNJw7ES3Qm1BqAAXxs=;
        b=gQirIdU5ldB72Jn9GalSgADee5206h/3Xz/WS2+RnNSt1youIQbGmKiC4cqD7haVCG
         4Xb8MFUbe6M4ZPIWqxKsR+PkRRzvCnAYXhS82s7vzo83ym93PBPxma1ee26Tz8uGZK4c
         M2QurjKWlbFMCEwUI7VSqudkBKhi8TZ21cKHKmjgduG/yjQKEYWOvBBXtwNcZ2OrQlJR
         NHoKgrqZGYLCzxL7uF/NJ6losJ1sGPGBEKkzjQfGlwp8Yx8IBlBQm0Y57/wYamTYjP8i
         SpT1ENHqYEBODax3KAfktafOvf1+F3c80bH0Bm6JeW0CFAP7RbpPdlvUqV6Yt/UrNtVR
         CfBQ==
X-Gm-Message-State: AOJu0Yx2yvTa+WdM5dnbL1Ox9niwLgVfICqt2Ey4o/8xdY3Je4PDW61Q
        DcRKsIVNHRW+0DcgjdEK3qI+VMnxprUuH/NOCknEitlU
X-Google-Smtp-Source: AGHT+IHPSRAzU0+55oYBIpXpZtOIje2vonnrx79DO6+0Fv+o4SNje0nZZulmoJSe2mchmIb/vLDx5Q==
X-Received: by 2002:a17:906:5c3:b0:9a1:c812:cbb9 with SMTP id t3-20020a17090605c300b009a1c812cbb9mr5323646ejt.31.1693774697657;
        Sun, 03 Sep 2023 13:58:17 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id q6-20020a170906940600b0098e78ff1a87sm5178259ejx.120.2023.09.03.13.58.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 13:58:17 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-31f4a286ae1so41658f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 13:58:16 -0700 (PDT)
X-Received: by 2002:a05:6000:10f:b0:31d:d48f:12a3 with SMTP id
 o15-20020a056000010f00b0031dd48f12a3mr6091707wrx.43.1693774696650; Sun, 03
 Sep 2023 13:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com> <20230903204858.lv7i3kqvw6eamhgz@f>
In-Reply-To: <20230903204858.lv7i3kqvw6eamhgz@f>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Sep 2023 13:57:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHZ1KJGVKTaBOSr7KwYAqvrjD9bcoz-SKrsW3DdS9Eug@mail.gmail.com>
Message-ID: <CAHk-=whHZ1KJGVKTaBOSr7KwYAqvrjD9bcoz-SKrsW3DdS9Eug@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
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

On Sun, 3 Sept 2023 at 13:49, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> It dodges lockref et al, but it does not dodge SMAP which accounts for
> the difference.

Yeah, just doing that "check if the name is empty" is not free. The
CLAC/STAC overhead is real.

I see no way of avoiding that cost, though - the only true fix is to
fix the glibc braindamage.

In fact, I suspect that my stupid patch is unacceptable exactly
because it actually makes a *real* fstatat() with a real path much
worse due to the "check if the path is empty".

We could possibly move that check into the getname() path, and at
least avoid the extra overhead.

           Linus
