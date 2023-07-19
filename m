Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CE9758E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjGSHBb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jul 2023 03:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjGSHBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:01:20 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B51A1FE6;
        Wed, 19 Jul 2023 00:01:19 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6b9c5362a51so3164649a34.0;
        Wed, 19 Jul 2023 00:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689750078; x=1692342078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XfvTxWqrssmy3dy7P0UA783KTXrdwpHemZ850a0qhdU=;
        b=QN2MTd0AJvdj4NcqRcnYCJJ2pptMIEAWi2090jRQmwcEo4WV5bsvwbm2ABsT+rtM3M
         AxjDu7KviU1oJ9AvAbl5F7SWh3BCRv4MwXGg1JUKX1kYUsa6JizC0AqP38r5B9nJJbcP
         wnSZvBGA3dhxOj1p2JowBYO1nVbDimYgFI6TggXyQDQrff8Y/QAilC8J+IC3HsvoP+Fk
         tgtjeyMtb799+e+EF/1BE1ACf4AEUEQgKpJBQzRBIVve3t5RxyQqI7oFPVGsMZRmsGff
         HfZIxK9CYMDsAqblhnalZZbacKHpfPAQg/TiBfacbgAIAZqQxW2uJXbeC0y7M37fmVOX
         09Fw==
X-Gm-Message-State: ABy/qLaFux3thraebRqrFF9ZBdz6kzs4MOiLmuHMGalRVfkn4iFVVMp1
        oTUL8wXevKYLfa9I/hvTC+xqXc+4vrJq8Q==
X-Google-Smtp-Source: APBJJlF1d8ahwySPAkEfVQ08ZZ5TUdYAtJjnH/lrb83bBWzFY052lQecN3XEBSeSNsYe3ltGXqsXbg==
X-Received: by 2002:a05:6830:1103:b0:6b8:7166:ea5a with SMTP id w3-20020a056830110300b006b87166ea5amr2024637otq.13.1689750078093;
        Wed, 19 Jul 2023 00:01:18 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id w15-20020a056830060f00b006b9ad7d0046sm1497637oti.57.2023.07.19.00.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 00:01:17 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3a44cccbd96so2465041b6e.3;
        Wed, 19 Jul 2023 00:01:17 -0700 (PDT)
X-Received: by 2002:a05:6808:1a25:b0:3a3:8e77:ddfd with SMTP id
 bk37-20020a0568081a2500b003a38e77ddfdmr2079679oib.8.1689750077750; Wed, 19
 Jul 2023 00:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230718192453.543549-1-fabrizio.castro.jz@renesas.com> <20230718192453.543549-3-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230718192453.543549-3-fabrizio.castro.jz@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Jul 2023 09:01:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVNfqNpOdokK7r=6y0Ub-0hy8dXSs5pGiCz=ZGPszmjZg@mail.gmail.com>
Message-ID: <CAMuHMdVNfqNpOdokK7r=6y0Ub-0hy8dXSs5pGiCz=ZGPszmjZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] spi: rzv2m-csi: Improve data types, casting and alignment
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 9:25 PM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
> "unsigned int" is more appropriate than "int" for the members
> of "struct rzv2m_csi_priv".
> Using void* rather than u8* for txbuf and rxbuf allows for
> the removal of some type casting.
> Remove the unnecessary casting of "data" to "struct rzv2m_csi_priv*"
> in function "rzv2m_csi_irq_handler".
> Also, members "bytes_per_word" and "errors" introduce gaps
> in the structure.
> Adjust "struct rzv2m_csi_priv" and its members usage accordingly.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>
> v2: This is basically v1 with the addition of changes to the data
>     types of txbuf and rxbuf and related touches.
>     Also, both the title of this patch and its changelog have been
>     changed to reflect the new additions.
>     Although both Geert and Andy kindly allowed for their Reviewed-by
>     tags to used for this patch, I have dropped them in case they want
>     to jump in.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
