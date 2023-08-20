Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C995781F9D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 21:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjHTTr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 15:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjHTTrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 15:47:52 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE28A1BFA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 12:44:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-986d8332f50so352989366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 12:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692560653; x=1693165453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P7dGaXlT3kYAWACn1EboW4hz6S4rbKvBdHHKYPakxOg=;
        b=EYZebZjJjoy60BCZapuzP0YogD1OCsY9ROMLjHDDbzEhLMOpQ+Jd8vI3VVawtfJSuy
         WALET6b5TjwnikMDix9UAA3T0jGAo4QmzMa6dhZAUp7G/V2SM6tC/vgp/8BWXagJFTIH
         reX6LCYuR6ncGz9ndo1s6Z7TAR7KhH05SN01E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692560653; x=1693165453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7dGaXlT3kYAWACn1EboW4hz6S4rbKvBdHHKYPakxOg=;
        b=WEVyoL5K0/Ja3U07Ieqh+MuxM0CfFGGvQuFNLSWn0OyMQA+jHsqpuXg6p6CVqlOP/M
         P4HCw8Bb/zMSxcg98l3VPNPCVww97Q+vpyY3eCak2YQgK/klBqQAcgJwAuhNsF+pKg+p
         Qj/2qDA2YrLZ/tJh7lYNtKKxXlkRlTbV+JLngbwIUlkestv/LwgvkR5y++ovZayRZbJz
         f5FBknvEzPUO5LN5XRcYzWsxgAZWViD2XA0d4HNfwbMqiSLK+tjRPcJ9JbXc2TkG2/DU
         9hcW1FKoNiZ3h6KtwX2dF5XTIWMfyD9+R4BIhL0o3Ij4gF8l16MzswT59w2e9zJs0cPr
         gp8w==
X-Gm-Message-State: AOJu0YwV6F211ds1ftj3I+h3hjwlWuSfuJvR4uQnLV6fzwDMbnksq4xh
        Rz/J5u4ZRFJWqUT3h7jdx1eQwil+inMZthXepolgJB4a
X-Google-Smtp-Source: AGHT+IFdnRcUYnKTJvnlDARMTyQNXL2DXJv5U6bitIT5uvx4hwTgLYxADU4kzeDldoRa7Jyrvix5ow==
X-Received: by 2002:aa7:c702:0:b0:51d:87c6:bf28 with SMTP id i2-20020aa7c702000000b0051d87c6bf28mr3414055edq.3.1692560652770;
        Sun, 20 Aug 2023 12:44:12 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id m4-20020aa7c484000000b0052328d4268asm4674111edq.81.2023.08.20.12.44.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 12:44:11 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-986d8332f50so352986966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 12:44:11 -0700 (PDT)
X-Received: by 2002:a17:906:150:b0:99b:8c6e:ec18 with SMTP id
 16-20020a170906015000b0099b8c6eec18mr3546447ejh.48.1692560651347; Sun, 20 Aug
 2023 12:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whD0w46GUTwp_tyzjZRg8Nk-U2e3ucM7EntKPfn+iOSAw@mail.gmail.com>
 <2695589.mvXUDI8C0e@natalenko.name>
In-Reply-To: <2695589.mvXUDI8C0e@natalenko.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Aug 2023 21:43:40 +0200
X-Gmail-Original-Message-ID: <CAHk-=whzXdojk7ZXZfW5-d+1394HWD47pscZQ8qpug-FJ0zRLA@mail.gmail.com>
Message-ID: <CAHk-=whzXdojk7ZXZfW5-d+1394HWD47pscZQ8qpug-FJ0zRLA@mail.gmail.com>
Subject: Re: Linux 6.5-rc7
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Aug 2023 at 17:06, Oleksandr Natalenko
<oleksandr@natalenko.name> wrote:
>
> v6.5-rc7 tag is missing in the git repo.

Bah. Silly me. Fixed.

              Linus
