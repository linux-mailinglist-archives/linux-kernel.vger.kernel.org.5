Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95667DED09
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjKBHDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKBHDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:03:17 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC56123
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 00:03:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso88292766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 00:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698908590; x=1699513390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V3nhXdUPcKAOv9+XK9xkbhx4vVS0XEkJFjF8wpYBYas=;
        b=PZvkTZLSCjzskNRrUu77F7RNNcqYyUyt7u0oST7Mq66TkkW0RP+vwQ2X3PcwIJPDpR
         MZnHXo23TgwSmDJ/eEx8gssiH70/OrDUC34xXCxn4KZhgRLeyUvopPQeh6UsTbBGjzfe
         MQuTHWVMF6/xGwIoRbPXyJJypr5iwP+hJ3Q3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698908590; x=1699513390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3nhXdUPcKAOv9+XK9xkbhx4vVS0XEkJFjF8wpYBYas=;
        b=MsPKpPH4viXOWpZbkddOjXl69ejRyX5b4eqmouUpy2jJCOt6uWxLJEwQIPyVM2C5IZ
         n0wm4q+BgZS5Zd2rqiFgJ8q8qi4v0GPEMHy2QKH7E00CAmVbMgVp9R/r8kjqZv5SJB8s
         e54oiGa+DBLiJO78hAoYZyOC56+E8r2jauvqO1W0jvrE9i5dHC+2aMLn2HA5k2DKdZM1
         k1NnnRsgeQLAWSwQbcgigLITdbcs6aO2rel2kX4VRvSnIYz5DIbf3X933q+qLAA45PHm
         UvNiWhggLYTdeFjYOWYj1vXxsXpKGCFaycdlrFxj5hkSO4WGk1Adz4sh1dkE96sG9Gyn
         BcCg==
X-Gm-Message-State: AOJu0YxXiTNmeigoiBEEaMK8Us5h02wqJpYIad1Gwpr5I3Z0gUn98DdZ
        gfdSV74ZFMy+NIeTJMw2hh2517T3v5oDDgZ3oyTpyDbg
X-Google-Smtp-Source: AGHT+IF73AjvodyKnC6I/9xdsxqiMFsa4x2vHeW1KhN15ZvlOSjqLqLoJzicDLZVIeek6UYcZ07FHQ==
X-Received: by 2002:a17:907:7da6:b0:9a9:ef41:e5c7 with SMTP id oz38-20020a1709077da600b009a9ef41e5c7mr4385878ejc.8.1698908590200;
        Thu, 02 Nov 2023 00:03:10 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id p26-20020a1709060dda00b0099ce025f8ccsm761626eji.186.2023.11.02.00.03.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 00:03:08 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-54366784377so866595a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 00:03:08 -0700 (PDT)
X-Received: by 2002:a17:906:4fc8:b0:9bd:ac0f:83dc with SMTP id
 i8-20020a1709064fc800b009bdac0f83dcmr3363405ejw.54.1698908588450; Thu, 02 Nov
 2023 00:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <ZUKxT1CL9/0Dn6NE@bombadil.infradead.org>
In-Reply-To: <ZUKxT1CL9/0Dn6NE@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Nov 2023 21:02:51 -1000
X-Gmail-Original-Message-ID: <CAHk-=whFXNYXG2ES8HdoaMC=O4bakMXGZezmoqA3SXwn4xJUPQ@mail.gmail.com>
Message-ID: <CAHk-=whFXNYXG2ES8HdoaMC=O4bakMXGZezmoqA3SXwn4xJUPQ@mail.gmail.com>
Subject: Re: [GIT PULL] Modules changes for v6.7-rc1
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, andrea.righi@canonical.com,
        keescook@chromium.org, zhumao001@208suo.com,
        yangtiezhu@loongson.cn, ojeda@kernel.org
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

On Wed, 1 Nov 2023 at 10:13, Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> The only thing worth highligthing is that gzip moves to use vmalloc() instead of
> kmalloc just as we had a fix for this for zstd on v6.6-rc1.

Actually, that's almost certainly entirely the wrong thing to do.

Unless you *know* that the allocation is large, you shouldn't use
vmalloc(). And since kmalloc() has worked fine, you most definitely
don't know that.

So we have 'kvmalloc()' *exactly* for this reason, which is a "use
kmalloc, unless that is too small, then use vmalloc".

kmalloc() isn't just about "use physically contiguous allocations".
It's also more memory-efficient, and a *lot* faster than vmalloc(),
which has to play VM tricks.

So this "just switch to vmalloc()" is entirely wrong.

              Linus
