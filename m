Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8B0788FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 22:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjHYU0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 16:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjHYUZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:25:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F7E1BF1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:25:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bdcade7fbso161467366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692995138; x=1693599938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t/I6k8XQEM7hjaOOfSAn58fagKJ85ckJj5+q/KrB8ss=;
        b=Zxlq/xZ6uUuAV9R+mWWwy0xTB2Xe99iHpn5Y8KwZvdpo4dpoyVyrtGCsmsCP7ZZwjK
         O+KioXSvh3TNjsyKBoLqhDEXz6meQMYv5+nILRPZvxkTDON8rUMYO/h3l0BYBsS7xnaH
         xBhQByyks52TgMDJnEUcimNg41x2CI+ACrKX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692995138; x=1693599938;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/I6k8XQEM7hjaOOfSAn58fagKJ85ckJj5+q/KrB8ss=;
        b=c9BcjuOwT/uoWBHnkDiQxPugwHV9swK2RNvLrp7LTyKyCNpFL96k/jOTTPL28wb0FP
         m9uVOx/5iw1Wu6SOsUb1yCR7OeVjDW1gEgCtiN1efjMbtX8coMfQqXME5lkcKood2stu
         5vZn/2gOvCwlE4A4RweYb1ycFVEwK6l/dQk9bmm+P6JcpH/ZV7C1kz4pHZpDvUAPa+zZ
         VBep2yvIFFlRkCSxnRW/7BP/Ki2Cg2soJnRtDL7e4iGKxLytflk7de6vRnDmKgQMz7XH
         ysOlHy0zdOAlzCzPrRHrWaUhz6gsa6TTRPEipplAcZAdNF1HdiPYFWY/I0rDl35PaRlV
         xNWQ==
X-Gm-Message-State: AOJu0Yxg+lVhsTU1/I9ETv0mYNlChlM0yTRADqQIyQykd1mXIOj987q+
        sOYKzkb3g/Ea/shKxyRsQTVTsDC8UkAro/hWQ80cnw==
X-Google-Smtp-Source: AGHT+IHHonbRGEIblnPxroGDJtAyNPP/LjdfNTprczFLjRsoR3rUuBSEkiZKpLlVFrxYDDRWYmJLXQ==
X-Received: by 2002:a17:907:1dc9:b0:9a1:c221:465a with SMTP id og9-20020a1709071dc900b009a1c221465amr8427424ejc.9.1692995138535;
        Fri, 25 Aug 2023 13:25:38 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id i27-20020a1709063c5b00b009a1c05bd672sm1306575ejg.127.2023.08.25.13.25.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 13:25:36 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-52a06f5f556so1908361a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:25:36 -0700 (PDT)
X-Received: by 2002:a17:906:1ba9:b0:9a1:680e:8c54 with SMTP id
 r9-20020a1709061ba900b009a1680e8c54mr14678934ejg.71.1692995136227; Fri, 25
 Aug 2023 13:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <ZOkGCSNr0VN2VIJJ@p100>
In-Reply-To: <ZOkGCSNr0VN2VIJJ@p100>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Aug 2023 13:25:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjZwSymfuGvf7TX3UQLU1OMN1FZMnEA-Hja0ruqyhMK4A@mail.gmail.com>
Message-ID: <CAHk-=wjZwSymfuGvf7TX3UQLU1OMN1FZMnEA-Hja0ruqyhMK4A@mail.gmail.com>
Subject: Re: [PATCH] lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels
To:     Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Chanho Min <chanho.min@lge.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2023 at 12:50, Helge Deller <deller@gmx.de> wrote:
>
> This patch fixes the in-kernel functions __clzdi2() and __ctzdi2() [..]

Applied,

               Linus
