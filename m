Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F337B4BE1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 08:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbjJBG4J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Oct 2023 02:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbjJBG4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 02:56:03 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97541B9;
        Sun,  1 Oct 2023 23:55:59 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59f7f46b326so130935027b3.0;
        Sun, 01 Oct 2023 23:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696229758; x=1696834558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mroo4u9dUunFLXQiBkd+nT/yozwsDeLEUlSVenP9iqQ=;
        b=Nt6cAIkdSSZLrAoGW7ZwcLfrrRYmQ/zP5eZbhUZHHBvoTS/2WOqyF6ZllVp6mBGTuL
         +XHPT4CKSsqGnpHYLStpBbbNzltc7aCIke6lVactw2lsqAHNETCbWLOcefmE7LjTaUvo
         GRZ+qUOf0qSahgIPvEV0p3U1+336I0Ih3oN3qSGj/+FZ/ivGP7OL9zDdvPCqIMG3jNIw
         Ub9j6fKQsgqlr248W0LfaFBztPL8tMx5MEUvkld0RKLjd5jlSevudndtf4hzF74BuH+T
         SitNaJdAZglDXmsqLt1812lobJOv8nSfKMt1zoa4EHV9pDplqxoDa76SpZPYCTmoRtJ/
         CTMg==
X-Gm-Message-State: AOJu0YyBHW6FRysv87oXgfdelr3UhRICOc4OFv8ls4hfvrjYf1BOGZwu
        aXz4oWKDWhEPH6kvAVdL9SZZY9XeR0QZ2g==
X-Google-Smtp-Source: AGHT+IFkUA8MULCP6p5AlPlp5OBGD8Ruh+QZ8PTrlDVOwDCtPOfVx7QWfkQXrhRA/FBaCZ0kTbExSA==
X-Received: by 2002:a81:4783:0:b0:592:2a17:9d88 with SMTP id u125-20020a814783000000b005922a179d88mr10115307ywa.47.1696229758542;
        Sun, 01 Oct 2023 23:55:58 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id x2-20020a818702000000b005869ca8da8esm7510300ywf.146.2023.10.01.23.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 23:55:58 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-59f4f80d084so156442127b3.1;
        Sun, 01 Oct 2023 23:55:58 -0700 (PDT)
X-Received: by 2002:a81:9250:0:b0:583:d1fa:1fc4 with SMTP id
 j77-20020a819250000000b00583d1fa1fc4mr10160161ywg.26.1696229758085; Sun, 01
 Oct 2023 23:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230927130734.9921-1-changhuang.liang@starfivetech.com> <20230927130734.9921-2-changhuang.liang@starfivetech.com>
In-Reply-To: <20230927130734.9921-2-changhuang.liang@starfivetech.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Oct 2023 08:55:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWOyxnFSjG3Sg2mBUJRdoMFYdUu9H_iZmCSX_0-jd1vnA@mail.gmail.com>
Message-ID: <CAMuHMdWOyxnFSjG3Sg2mBUJRdoMFYdUu9H_iZmCSX_0-jd1vnA@mail.gmail.com>
Subject: Re: [-next v1 1/2] dt-bindings: power: Update prefixes for AON power domain
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Changhuang,

Thanks for your patch!

On Wed, Sep 27, 2023 at 3:07 PM Changhuang Liang
<changhuang.liang@starfivetech.com> wrote:
> Use "JH7110_AON_PD_" prefix for AON power doamin for JH7110 SoC.

domain

>
> Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
