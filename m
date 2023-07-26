Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD4E762A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjGZE1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjGZE10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:27:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37454C2B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 21:24:49 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-563d3e4f73cso653379a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 21:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690345489; x=1690950289;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JBsjn7IAtl65JYqpeQVuvsYTITezpT1qqhywYt9S/60=;
        b=kUQEPnEgRJLn1PsR3vugPwzGEqb8mvyRjBS4M6xXzsRiq0LX+cGJafkNoJ8dd02sgq
         72Qfng/ibA8gwswwblc9Iau9mXO+rHJH2vmFOLGbbvKI1033RhLCaj8o8qRkEqIlacyX
         0OiVB9FPsb7JXN55/nvgTfVuVcou1ESOQjzxU7kvPuNoVfdhhPbrb4f03aZDJswUqLp3
         2XQP1De8xs6gpazqfzqC7kV+6Ai6QgjS6ZE5bGHn5KlMx6zgyEYaNghOprzeF/S+AkR9
         H091odPrWNQiOOhXHTy9o0ssqIKMsLruXbvM2dKgKLEhG0A3QyGz2YkCGKuwZJ3j2ao5
         wN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690345489; x=1690950289;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBsjn7IAtl65JYqpeQVuvsYTITezpT1qqhywYt9S/60=;
        b=ixOjTdyGghZ/4izDppIJoqcBEY9DdyOyRQGWIXMtjEIsv9h0hunhFFD/u8nk8JuBjN
         P8RGewJHVkJea0+cpYctHlKGnSlQ1Jo/pJ0710QcbLzPJQYvS0mS1LT3JcIydQHpQF92
         5u/eoU2ykwbhs+GklbiRme9ItCcNuRfKyo4/YjSgZHC6Xfdabvwyaq9F8yRn8ZvjvXQu
         hMQm7k9KD6Wy11aKFEEgnso7wDhpDxQK3mc0Hi2jbBTKSxrupY0utDdhoXWArBSlFiBJ
         pvmhdQFbCaioZrwvHrWOF0Pi52eJ0cThwe+kt9U+B8blo0a3SFxLdzhAvJG5YPDLEsJY
         RyeA==
X-Gm-Message-State: ABy/qLZ2TvRXlsnsFS3QHA0WA3R08vPmg1RLKdQbizkfRnFNADGlMw51
        OfEfLvQRG/40mS5/1b9sR2k=
X-Google-Smtp-Source: APBJJlF54y+sCDnuj7XpR57EhQ6gNuZgEcH0a/IyX0jSETVLecPgw++iE7IKR8P+++/hd8w/8VEl1w==
X-Received: by 2002:a05:6a20:9144:b0:122:ff52:7331 with SMTP id x4-20020a056a20914400b00122ff527331mr730046pzc.52.1690345489021;
        Tue, 25 Jul 2023 21:24:49 -0700 (PDT)
Received: from [192.168.0.11] (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id y10-20020a170902700a00b001bbb598b8bbsm3203294plk.41.2023.07.25.21.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 21:24:48 -0700 (PDT)
Message-ID: <a73b2f3e-bdad-1c88-c06f-101ec5db3092@gmail.com>
Date:   Wed, 26 Jul 2023 13:24:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Takahiro Kuwano <tkuw584924@gmail.com>
Subject: Re: [RESEND PATCH v3 00/11] mtd: spi-nor: spansion: Add support for
 Infineon S28HS02GT
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        takahiro.kuwano@infineon.com, michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, bacem.daassi@infineon.com,
        miquel.raynal@bootlin.com, richard@nod.at
References: <20230724081247.4779-1-tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20230724081247.4779-1-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

I tested all SEMPER flash devices below.
  S25FS256T
  S25HS512T, S25HL512T, S25HS01GT, S25HL01GT
  S25HS02GT, S25HL02GT
  S28HS512T, S28HL512T, S28HS01GT, S28HL01GT
  S28HS02GT

As I sent another email, S25FS256T failed due to SCCR map.
All other devices are OK.


Now we can remove these macros as we use vreg_offset.

#define SPINOR_REG_CYPRESS_CFR1V					\
	(SPINOR_REG_CYPRESS_VREG + SPINOR_REG_CYPRESS_CFR1)

#define SPINOR_REG_CYPRESS_CFR3V					\
	(SPINOR_REG_CYPRESS_VREG + SPINOR_REG_CYPRESS_CFR3)

#define SPINOR_REG_CYPRESS_CFR5V					\
	(SPINOR_REG_CYPRESS_VREG + SPINOR_REG_CYPRESS_CFR5)

Thanks,
Takahiro


On 7/24/2023 5:12 PM, Tudor Ambarus wrote:
> Resending as patch 10/11 and 11/11 were not sent.
> 
> Takahiro, since you already have to test all these flashes, I took the
> liberty and added some other changes that would be good to have. The
> first one lets SFDP determine the flash size and sector size. Michael is
> in the process of changing how INFO is handled, we'd like to get rid of
> these params when SFDP tables are defined. The other 2 patches
> consolidates a bit the spansion code with the idea that we should use
> the same code paths for both single (SCP) and multi chip package (MCP)
> flashes were possible. We avoid this way code duplication and have
> better test coverage on the code. On your patches I modified how/where
> "if (!params->n_dice || !params->vreg_offset)" is handled. Please review
> all and if you agree with the changes, retest on all flashes. Everything
> looks good to me, if the tests pass, I'll queue all.
> 
> Cheers,
> ta
> 
> 
> Takahiro Kuwano (8):
>   mtd: spi-nor: spansion: use CLPEF as an alternative to CLSR
>   mtd: spi-nor: spansion: preserve CFR2V[7] when writing MEMLAT
>   mtd: spi-nor: spansion: prepare octal dtr methods for multi chip
>     support
>   mtd: spi-nor: spansion: switch set_octal_dtr method to use vreg_offset
>   mtd: spi-nor: spansion: switch h28hx's ready() to use vreg_offset
>   mtd: spi-nor: spansion: add MCP support in set_octal_dtr()
>   mtd: spi-nor: spansion: add octal DTR support in RD_ANY_REG_OP
>   mtd: spi-nor: spansion: add support for S28HS02GT
> 
> Tudor Ambarus (3):
>   mtd: spi-nor: spansion: let SFDP determine the flash and sector size
>   mtd: spi-nor: spansion: switch s25hx_t to use vreg_offset for
>     quad_enable()
>   mtd: spi-nor: spansion: switch cypress_nor_get_page_size() to use
>     vreg_offset
> 
>  drivers/mtd/spi-nor/atmel.c     |   8 +-
>  drivers/mtd/spi-nor/core.c      |  23 ++-
>  drivers/mtd/spi-nor/core.h      |   4 +-
>  drivers/mtd/spi-nor/issi.c      |   4 +-
>  drivers/mtd/spi-nor/macronix.c  |   4 +-
>  drivers/mtd/spi-nor/micron-st.c |   4 +-
>  drivers/mtd/spi-nor/spansion.c  | 294 +++++++++++++++++++++-----------
>  drivers/mtd/spi-nor/sst.c       |   8 +-
>  drivers/mtd/spi-nor/winbond.c   |   4 +-
>  drivers/mtd/spi-nor/xilinx.c    |   4 +-
>  10 files changed, 239 insertions(+), 118 deletions(-)
> 
