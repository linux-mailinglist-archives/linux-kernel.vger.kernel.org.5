Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027EC7689E3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjGaCMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGaCMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:12:15 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E52A4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:12:14 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a5ac84718dso3182394b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690769533; x=1691374333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qUqbarmxVUs5uz8pdQ/gii0o7HCYWL1wxFQuuCaKQ/w=;
        b=zf/UR75/Sos9flzq1y2gYW1b6U8os9U4LdEh7nNtIdWfTNiBz326h13auel+vEx6Lk
         QpfGspjZ+nOP9eoSDake+456M3kpzO+fpjY+5dcyzfH7NjS65ePyZ1h8PCvgr+brzCPt
         gYfJa1LXf+tHCSxzf3Fo/QY6C8V0SWFsehnEJpSgZz423tuxP6Xm35iS98kMiJcX+/xw
         M1HEhIBL0KjuLxasJIgybJYEBjeWWfDFPQNPh9n3UfZfEG+2QfwhC2kf7n23fE7hYj/3
         pJ59yB1KL8VU0Zt5W0BIah5ZG/kIxQRlPfqNz3NbjeI/V8jBxahnYWFnN4XxinBOEnIv
         6c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690769533; x=1691374333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qUqbarmxVUs5uz8pdQ/gii0o7HCYWL1wxFQuuCaKQ/w=;
        b=U+gVFOQfAD0MwODn/8g6BIKWM2oSpVOtxNL8nDsXYSpMTA1pBe9IHg3Om1BuHoTH26
         HFEmkPHGG9r9LE788qdmDeB0JLqpFARLtQLLgd88sBnPaQJJx5TF45foqK8k0NMr8M6k
         BNkFwjQmEm498NSLiiLsaIvlUtSwHIoC5SMZOMHiukDRESHFdQ1FWCtk3Tsm6xGCzgfB
         ZzYFJ8OBWEQ8LiKPITYACmv/FqC0Zr39pfkLJelnXQ+R1bdj7Q2lBCjVlJ3LjjtpAoAu
         v3sTGBEUH8/qIWHKsQSzOIG0EWhEdeC5SrtoSYejVs06MIKDvDr/wj8lgpAZRtKaJR+7
         Qn4A==
X-Gm-Message-State: ABy/qLZmm850qimz4uOsnRDbDkAxvnv3zLs3HjfQ7dhjjZWeurzZfRc6
        cCmZf6bQNUAvCBnYBA1gm4EC6TSA6cwWoPmWMF1MWA==
X-Google-Smtp-Source: APBJJlHcRx4Uj5BSX26f7uLEPJ4uD9DqycI7poAIFjOFPsn7TaFsyL1q/IIiu88533qH/9RCmb2oUU4PG6Gjgo9TfjI=
X-Received: by 2002:a54:4719:0:b0:3a3:6329:4cb7 with SMTP id
 k25-20020a544719000000b003a363294cb7mr8526437oik.9.1690769533619; Sun, 30 Jul
 2023 19:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230727-synquacer-net-v1-1-4d7f5c4cc8d9@kernel.org>
 <CAMj1kXH_4OEY58Nb9yGHTDvjfouJHKNVhReo0mMdD_aGWW_WGQ@mail.gmail.com>
 <6766e852-dfb9-4057-b578-33e7d6b9e08e@lunn.ch> <46853c47-b698-4d96-ba32-5b2802f2220a@sirena.org.uk>
 <CADQ0-X_pXKvUxLW23vEyH=9aZ6iLA2jOKz8QX6aqwQmxFcPY8Q@mail.gmail.com>
 <7f21c1d3-331d-4bff-8a4c-f6e235a3dd6a@lunn.ch> <8ed87590-4f0e-423a-a326-c4f6bef24596@sirena.org.uk>
In-Reply-To: <8ed87590-4f0e-423a-a326-c4f6bef24596@sirena.org.uk>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Mon, 31 Jul 2023 11:12:02 +0900
Message-ID: <CADQ0-X_Urtks_2udbzjx6u5e88AdiL90T6atNq7-pZAet-1P4Q@mail.gmail.com>
Subject: Re: [PATCH] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>, Ard Biesheuvel <ardb@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jul 2023 at 02:11, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jul 28, 2023 at 07:07:36PM +0200, Andrew Lunn wrote:
> > On Fri, Jul 28, 2023 at 09:35:00PM +0900, Masahisa Kojima wrote:
>
> > > "rgmii-id" is correct, configured by board level.
> > > The latest EDK2 firmware was already modified to use the correct value
> > > for DT(Thank you, Ard).
> > > http://snapshots.linaro.org/components/kernel/leg-96boards-developerbox-edk2/100/
>
> Thanks, that does seem to be working.
>
> > If the firmware has been fixed, i would actually do something like:
>
> >       err = of_get_phy_mode(pdev->dev.of_node, &priv->phy_interface);
> >       if (err)
> >               return err;
>
> >       if (of_machine_is_compatible("socionext,developer-box") &&
> >           priv->phy_interface != PHY_INTERFACE_MODE_RGMII_ID) {
> >               pr_warn(FW_WARN, "Working around broken firmware. Please upgrade your firmware");
> >               priv->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
> >       }
>
> It is not clear to me that the release channels for this firmware are
> sufficiently clear to users for this to be constructive.

It is not a good situation, but a new firmware release is not
officially announced.
Development efforts moved from EDK2 to U-Boot for System Ready-IR for
the last two years.

Thanks,
Masahisa Kojima
