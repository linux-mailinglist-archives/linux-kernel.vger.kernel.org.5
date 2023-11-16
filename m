Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7877EE22F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345365AbjKPOCb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Nov 2023 09:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345336AbjKPOCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:02:16 -0500
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C32D5D;
        Thu, 16 Nov 2023 06:02:12 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5afabb23900so9349287b3.2;
        Thu, 16 Nov 2023 06:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700143331; x=1700748131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ab9TuKeTeOe6Tu419AbiqmgHmcWN5UW8aVt812inTFM=;
        b=hKcXApGjRam3UpWHZsqmk3Xh6lg+8DCNFhNEKqwpFAPutwM6kECfINzKs/JBKp01oO
         G9/thaIVyrq9u9P3fJlsaknovvL5/hpk4O0Ckvmq44DeSfRWvpZR7k4LtmbXHWnRQNpU
         s+BmCLWhN9gbDSgEzZ6Wcj5FE7m2KJSkesavQlz1fsaD4RrjdGibdZaSpHOnHXl2dx4y
         nscpuyJ0BsiKIchZGyCLiPLgEsdODF1stgPuKI714UdPW/1xUQRE9w9vQbfJ+t/gNMBc
         dzRQie09GwhioKMIooWH/pd08j0nihepuMSmT/eFm/RlW931y2qQUosLfF86GkDHWynJ
         Re7A==
X-Gm-Message-State: AOJu0Yz6tD+FgskDtCLDzfTuW/J5x5obPl0OHrDxah6Y9IV+NAzhkeIk
        S9n563rGvsOcTvq+xsj5ZNGSMvOCKuygEQ==
X-Google-Smtp-Source: AGHT+IGXitV1/KEj9/oj/owEHj+5Er3SQ5zz/Mbf3W4OUN8GJJ6vy/a65gwm+mJIeXhlqd6eBNHWUg==
X-Received: by 2002:a0d:ed06:0:b0:59f:5361:d18c with SMTP id w6-20020a0ded06000000b0059f5361d18cmr17263354ywe.41.1700143325529;
        Thu, 16 Nov 2023 06:02:05 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id f125-20020a0ddc83000000b005a7bbd713ddsm990344ywe.108.2023.11.16.06.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:02:05 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5afabb23900so9347237b3.2;
        Thu, 16 Nov 2023 06:02:05 -0800 (PST)
X-Received: by 2002:a05:690c:2c08:b0:5c1:25f:5674 with SMTP id
 eo8-20020a05690c2c0800b005c1025f5674mr14330375ywb.32.1700143324843; Thu, 16
 Nov 2023 06:02:04 -0800 (PST)
MIME-Version: 1.0
References: <20231115211407.32067-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231115211407.32067-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 16 Nov 2023 15:01:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXrepNfzdjpsQnKMB9XZa_AgfuTD2hbSq23HD6v9w8jXw@mail.gmail.com>
Message-ID: <CAMuHMdXrepNfzdjpsQnKMB9XZa_AgfuTD2hbSq23HD6v9w8jXw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: renesas,usbhs: Document RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 10:14 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The USBHS IP block on the RZ/Five SoC is identical to one found on the
> RZ/G2UL SoC. "renesas,usbhs-r9a07g043" compatible string will be used on
> the RZ/Five SoC so to make this clear and to keep this file consistent,
> update the comment to include RZ/Five SoC.
>
> No driver changes are required as generic compatible string
> "renesas,rza2-usbhs" will be used as a fallback on RZ/Five SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
