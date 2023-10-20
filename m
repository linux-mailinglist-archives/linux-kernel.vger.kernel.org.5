Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F927D0FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377210AbjJTM43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376956AbjJTM41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:56:27 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF06D5B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:56:26 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7ab31fb8bso8164177b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697806585; x=1698411385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yrcL+xKT1Haqzn96R/mZhFMvTo6rkNolacJ4Cmk/A44=;
        b=Tg2pYOHdpZsN+CW46JWHwJhGGFR7os++Mbd3U0w6RYUE/+L1Rk3kGdhei0ing/Yoao
         4wmwnaH6gn/Znz+Ij3K8mv5cfF6tf70oMVTMy9F8uzsLA4B2CAv7yzyg1qpP2J3EdRQn
         mjhluWsrQqFy7XhMO7rGRuRxQQn29xDALIgtK83ThCvwUCtdCoal1DTMDfd3UEKkDGGC
         g/+R0BrM0x6tWIslOSzzp+zHnaATRnGE82mZeV0WWMmIKOeRsReFKZKBjR/pjIA+MjTT
         uJ5vBaP34rQ+OQ6zjD1s2os1zslKxc9VjBe6TDYm93qhCpV6SW2boud55joMHT5iTG92
         o76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697806585; x=1698411385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yrcL+xKT1Haqzn96R/mZhFMvTo6rkNolacJ4Cmk/A44=;
        b=duo59VHFu3KbuV7k/x9yA73qdPV8medneuhrfA7LCcG99h80dCCOnRTShNEW/FG6Iq
         yR82Vr311t/QhBWv6fh23cBfwvsPEtfv4xorRFhau9NgfgwbAXEztrr2uPxwAeenSlXp
         G7/Q4lxj+Q/Q/I5Fh2CQ5nsZKFYA2o1iWFFrVgdugN8IZfA+dbijJMUxc9uWEnazA+Q9
         0+KTFL3Ck2UPLyy2o3XbNq3Q0ICutKZzj051LEhdNCl5NLmdR1F7MQCuxyDOSLt73gOp
         tv5WrrxNC2S9CT8vveIwES+qw5e4IkKo5W98HQCODtdMNGcfIUnx1YU4S+nJXfs6TCNf
         Tqww==
X-Gm-Message-State: AOJu0Yw1Jo8ckRq3E0HlHVGZM962EZGFUv2zzsgfROdtREbsbcyluqda
        EByBLW0GYm/MkLTtZ8pXFRdaSRpFGPsziQa5my4WzQ==
X-Google-Smtp-Source: AGHT+IGrmN5jknlgIsjAyhgTDyk0Jj0AJJ69byvTmw81BZ3lafG/4P93aegl+ccQttzXcDL8T8XrYIIK66wdeeleL1c=
X-Received: by 2002:a0d:d488:0:b0:594:e97b:f6fa with SMTP id
 w130-20020a0dd488000000b00594e97bf6famr2050189ywd.30.1697806585447; Fri, 20
 Oct 2023 05:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-1-3ee0c67383be@linaro.org>
 <169762516670.391804.7528295251386913602.robh@kernel.org> <CACRpkdZ4hkiD6jwENqjZRX8ZHH9+3MSMMLcJe6tJa=6Yhn1w=g@mail.gmail.com>
 <cfc0375e-50eb-4772-9104-3b1a95b7ca4a@linaro.org> <CACRpkdbKxmMk+-OcB6zgH7Nf_jL-AV7H_S4eEcjjjywK0xCJ4Q@mail.gmail.com>
 <20231020122725.2fotbdwmmu575ndd@skbuf>
In-Reply-To: <20231020122725.2fotbdwmmu575ndd@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 20 Oct 2023 14:56:13 +0200
Message-ID: <CACRpkdZGT=iWGjc+ROpd=Ofa6EMY761pudxcRsUKLvHZ3Ke5zg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: dsa: Require ports or ethernet-ports
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 2:27=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
> On Fri, Oct 20, 2023 at 01:41:22PM +0200, Linus Walleij wrote:
> > I can't reproduce this, make dt_bindings_check in the mainline kernel
> > does not yield this warning
>
> You used the actual command that the bot posted, right? aka "make DT_CHEC=
KER_FLAGS=3D-m dt_binding_check"?
> I am also seeing the yamllint warning.

Yep I added that.

(But I think the kernels dt_binding_check should ultimately add
the same flag, otherwise the world gets super confusing.)

Yours,
Linus Walleij
