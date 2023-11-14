Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E299B7EB105
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjKNNkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjKNNky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:40:54 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C2A1B9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:40:51 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-daf7ed42ea6so2631686276.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699969250; x=1700574050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssTnGdMjDlSuWjtdW1FG5qA/Hn/8Id4nt/RLgAUbXbI=;
        b=YMW/whL8+Unj0sS8JftOLrxAk5aQb5IqboExeMvG5d7M39oE+NHuM1a7wcvFWTLq8p
         X9CcfBSnGdkDKgtp6V4NnbXhyJaOvNGRX6/GgCj9jqLgXx7DjIzZxi5FQaI5OQrHNZc6
         rApd/Eyz/EBLXcmg2K6HonHVlgwWNY6sN1k5I6dBC7F3+VF6GhBjVfitTk4D//esXKmc
         wpS/DP0TK9qYjb0xZTeYoueRhOl5y3Iudk1IB1cdvkeUR76TF1e7q6VPjcdpQDq38YQQ
         4nvmtDBJqO1bCuo2jplVjA6xgPm2C6IktRGsvOq6ir/56vE82R2EQv2agUrHn78NVaLo
         R1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699969250; x=1700574050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssTnGdMjDlSuWjtdW1FG5qA/Hn/8Id4nt/RLgAUbXbI=;
        b=oo6Ij8uN60Oomm+xyKYkKsaS8skKm1YBddxA6kmFeseBMCTJMQR17AVF0+/9kyeLEi
         x2PrlME/tZdINSxc0RhhwL6OpGsoBjyVHM8nZgT0bZFeBgxNS83/76D8b/drjZYNuR1h
         c7JxbyJwefUxU79kHRj/+QFzwDRPKRCgrGRYx6BUOoN0vXkrPKLi2GMpZy9gZe1vmcC+
         OA0OREXCkCHfxgV52qPRPOkAjwWL/V5DJFHSbIVeloqtTZ/ufSX2k0STNFGIBq/pjrxQ
         i5bXngCjM5FKWK+AotQBwqkvwVFg6/FUtdwqfashfxoUqK5IHnymWF6W4svd30zOY0BS
         pW4w==
X-Gm-Message-State: AOJu0YyPWNPkPlix18PaAG8FQ6CEcCpjqigA+V4Qfsg9l9s9UWSBRxmC
        vOtCewiqngDlEuyOcD6OuwitDCzkh6x2RtGuolVk0ae4YALhT0aF
X-Google-Smtp-Source: AGHT+IHL0KgmEJbs3rigo+bGKBU/l3zT4GfvCabdd5xvfsNbuuq4Q14SpFfXzLMlBPMNAIKJCSsYGnRfZXbrBtDH8rc=
X-Received: by 2002:a25:50c1:0:b0:da1:5a1a:e79c with SMTP id
 e184-20020a2550c1000000b00da15a1ae79cmr8441022ybb.50.1699969250317; Tue, 14
 Nov 2023 05:40:50 -0800 (PST)
MIME-Version: 1.0
References: <202311071303.JJMAOjy4-lkp@intel.com>
In-Reply-To: <202311071303.JJMAOjy4-lkp@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 14:40:38 +0100
Message-ID: <CACRpkdb4d9pfstqDTZoBSqOSS4d4vLOUCnS6AKcMjLZ8TTQ2Wg@mail.gmail.com>
Subject: Re: drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:53: error: pasting
 "LOCHNAGAR1_" and "(" does not give a valid preprocessing token
To:     kernel test robot <lkp@intel.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 6:19=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:

> >> drivers/pinctrl/cirrus/pinctrl-lochnagar.c:52:53: error: pasting "LOCH=
NAGAR1_" and "(" does not give a valid preprocessing token
>       52 |         .name =3D NAME, .type =3D LN_PTYPE_GPIO, .reg =3D LOCH=
NAGAR##REV##_##REG, \
>          |                                                     ^~~~~~~~~
>    drivers/pinctrl/cirrus/pinctrl-lochnagar.c:67:9: note: in expansion of=
 macro 'LN_PIN_GPIO'
>       67 |         LN_PIN_GPIO(1, ID, NAME, REG, SHIFT, INVERT)
>          |         ^~~~~~~~~~~

I looked a bit at this, can this be due to the fact that the macros use def=
ines
from include/dt-bindings/...* and that MIPS does not use these includes
somehow, such as not using the same dtc compiler?

Rob, do you know the story of how MIPS interoperates with <dt-bindings/*>?

Yours,
Linus Walleij
