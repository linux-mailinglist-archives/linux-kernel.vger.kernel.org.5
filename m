Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48007B847C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243220AbjJDQGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243224AbjJDQGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:06:16 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA113D7
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:06:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so3953908a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696435571; x=1697040371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pen+iO+M2gIPTh3d/Qy4b5+52uIYKXLIWWiVeTqgDBs=;
        b=V4QEzJKkHMowKbRadA6vVB7ur+02TtY1ajkJZJzNRXgHJR+XmeASc4kWBxHaguBVDb
         Si6fq8v3y3FyTdSRN85F+3e2yTzmfkFO1TX7b9w1I6KnN6sjDdEC2g3sk8mFSsovD2Sp
         iQQtVgrixWXeSEtK79ZwzNYnY4tx1YSd+KGoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696435571; x=1697040371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pen+iO+M2gIPTh3d/Qy4b5+52uIYKXLIWWiVeTqgDBs=;
        b=PC9MVFzLOqYSqSrgly9WLu5xcAqdio+fyH8GBAO9AG3oPjKHUEGzWf9TDssp2edpUK
         X6LHzvaGCr5ZrdRJS8sHplj2iEbnitprHiJMR5iFrMLrdlP8/hdj3poswyA/HtErG0L/
         BId13l2gMU+6MczPUG7eDdO24h7hTn1yOGQVAfF6sdqD53CLWltLAPhwwVy9vmGk0XU8
         y4mfmJ0c8W/dGpt8MdZO5Ew3koNpiBwsb9kEZTL6712uaJdVMsnVdeIvIJuzCNMk50Zj
         po4RR22UXlwMbWEw/qTsN3OMe6RIwgrR9/XksabpUq2I6tqCbxKxWCTWpvK4ojAJF2yQ
         Km4g==
X-Gm-Message-State: AOJu0Yxk+L4I6K7EbmPaUWeivcYkwenMk6isj8g03p+QOeEJsYcArzx+
        R6DbefWfsJL61K9erIR7KG+UBMHWh02AE83A6Dfz0w==
X-Google-Smtp-Source: AGHT+IGC+HjXrGlVggpLaITJAvjTLO3ivScXGdLTl7cSIhhUny2iwKVgBzqzdOgwmGmUkk091aGpHrbJD3kXd8yip/Q=
X-Received: by 2002:a17:907:7613:b0:9ae:55ae:587f with SMTP id
 jx19-20020a170907761300b009ae55ae587fmr2416199ejc.37.1696435570826; Wed, 04
 Oct 2023 09:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231004093620.2b1d6917@xps-13> <20231004113458.531124-1-mwalle@kernel.org>
In-Reply-To: <20231004113458.531124-1-mwalle@kernel.org>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 4 Oct 2023 10:05:59 -0600
Message-ID: <CAPnjgZ2hWE6Sc=rg55W=-r-TnoWP7Y5gSpn41kwoyja-AMVw+w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: fixed-partitions: Add binman compatible
To:     Michael Walle <mwalle@kernel.org>
Cc:     miquel.raynal@bootlin.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        ptyadav@amazon.de, rafal@milecki.pl, richard@nod.at,
        robh+dt@kernel.org, robh@kernel.org, trini@konsulko.com,
        u-boot@lists.denx.de, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Wed, 4 Oct 2023 at 05:35, Michael Walle <mwalle@kernel.org> wrote:
>
> Hi,
>
> >> Add a compatible string for binman, so we can extend fixed-partitions
> >> in various ways.
> >
> > I've been thinking at the proper way to describe the binman partitions.
> > I am wondering if we should really extend the fixed-partitions
> > schema. This description is really basic and kind of supposed to remain
> > like that. Instead, I wonder if we should not just keep the binman
> > compatible alone, like many others already. This way it would be very clear
> > what is expected and allowed in both cases. I am thinking about
> > something like that:
> >
> >       Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
> >
> > this file is also referenced there (but this patch does the same, which
> > is what I'd expect):
> >
> >       Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> >
> > I'll let the binding maintainers judge whether they think it's
> > relevant, it's not a strong opposition.
>
> What is the overall goal here? To replace the current binman node which is
> usually contained in the -u-boot.dtsi files? If one is using binman to
> create an image, is it expected that one needs to adapt the DT in linux?
> Or will it still be a seperate -u-boot.dtsi? > Because in the latter case
> I see that there will be conflicts because you have to overwrite the
> flash node. Or will it be a seperate node with all the information
> duplicated?

The goal is simply to have a full binding for firmware layout, such
that firmware images can be created, examined and updated. The
-u-boot.dtsi files are a stopgap while we sort out a real binding.
They should eventually go away.

>
> Maybe (a more complete) example would be helpful.

Can you please be a bit more specific? What is missing from the example?

Regards,
Simon
