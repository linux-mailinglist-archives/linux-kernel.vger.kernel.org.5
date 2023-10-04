Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E77C7B87CA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243870AbjJDSJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243869AbjJDSJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:09:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1546E5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:09:05 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52fe27898e9so132864a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696442944; x=1697047744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w5W+DRsl6OjglAC7XyeJBSxFDq32iO4B/LzeqS+l/1s=;
        b=aa9wCVS2i5XUdXgaQDFA6kDjW/L00W/8n1tNM9VBP4BHS/p7IuhrwERB/HLZ75Babt
         emhPvL0eFVI+XaPfT8gR7VHkOOUO6Bv157gumpDmFngXYzHanZrFVUUG0pJhwwGM31H4
         fsNOmLS/9YfuyWR99zt5bNwvuW1MNEm4SMrHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696442944; x=1697047744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5W+DRsl6OjglAC7XyeJBSxFDq32iO4B/LzeqS+l/1s=;
        b=E/3Hr2DcHDyc5llSHCVt8pQFFv1mp8D/YuigMF+kagLHcTOA4xWxs3HZU6U3xGLOCJ
         hckmWN2UvNdSOYnGIGNK9WQsOkZw9V93JjtDcQiyOnfIl2I5ju/2lSFUiT+/HhZBy5s6
         xgYoFWsrktDgC+vZeuArhwGfrO2Oa5NouRBP2W9bgCHQHQTRujWeKtkfoA1wL3Lpv7t1
         1yKqkfRv3CuwMONvlKPTSPdpS/ZnfWUgGwz8HaiVDCPLsUzbZ3c+QfQOpP9KeKTNz8Ia
         5JA4ER8Ul5RJ469yBzGV2wfQWwcNUNszITGBKGDxwAnMbbROI9QsGmKs7rOE3Bps0CJU
         YqGQ==
X-Gm-Message-State: AOJu0YySsA0TnTHVozUqMoHp5XNQ/wJ6JVzwqczEYvcXVogU2oDUDmVK
        OZFWc3r4yEPRGgBpwbGFBcEYjgrpkxi40Pr+Dj0/qQ==
X-Google-Smtp-Source: AGHT+IHJlWNCUprSTsy/mi7E27yDL7LOdfmyTuqtZ+hKQqyfalMc4s2i7/u3zX2OuEnZBbKnARbShh/CVYkbdMcM8rE=
X-Received: by 2002:a17:907:7f26:b0:99d:ddae:f5d4 with SMTP id
 qf38-20020a1709077f2600b0099dddaef5d4mr3289336ejc.44.1696442943851; Wed, 04
 Oct 2023 11:09:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231004093620.2b1d6917@xps-13> <20231004113458.531124-1-mwalle@kernel.org>
 <CAPnjgZ2hWE6Sc=rg55W=-r-TnoWP7Y5gSpn41kwoyja-AMVw+w@mail.gmail.com> <9e588e3ec8c0c321a2861723d0d42b9a@kernel.org>
In-Reply-To: <9e588e3ec8c0c321a2861723d0d42b9a@kernel.org>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 4 Oct 2023 12:08:52 -0600
Message-ID: <CAPnjgZ20ezipPWAj6bUM9_oCTcX1XzuLqQ7b7-nKjXf1t4p9-Q@mail.gmail.com>
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

On Wed, 4 Oct 2023 at 11:17, Michael Walle <mwalle@kernel.org> wrote:
>
> Hi,
>
> >> >> Add a compatible string for binman, so we can extend fixed-partitions
> >> >> in various ways.
> >> >
> >> > I've been thinking at the proper way to describe the binman partitions.
> >> > I am wondering if we should really extend the fixed-partitions
> >> > schema. This description is really basic and kind of supposed to remain
> >> > like that. Instead, I wonder if we should not just keep the binman
> >> > compatible alone, like many others already. This way it would be very clear
> >> > what is expected and allowed in both cases. I am thinking about
> >> > something like that:
> >> >
> >> >       Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
> >> >
> >> > this file is also referenced there (but this patch does the same, which
> >> > is what I'd expect):
> >> >
> >> >       Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> >> >
> >> > I'll let the binding maintainers judge whether they think it's
> >> > relevant, it's not a strong opposition.
> >>
> >> What is the overall goal here? To replace the current binman node
> >> which is
> >> usually contained in the -u-boot.dtsi files? If one is using binman to
> >> create an image, is it expected that one needs to adapt the DT in
> >> linux?
> >> Or will it still be a seperate -u-boot.dtsi? > Because in the latter
> >> case
> >> I see that there will be conflicts because you have to overwrite the
> >> flash node. Or will it be a seperate node with all the information
> >> duplicated?
> >
> > The goal is simply to have a full binding for firmware layout, such
> > that firmware images can be created, examined and updated. The
> > -u-boot.dtsi files are a stopgap while we sort out a real binding.
> > They should eventually go away.
>
> You haven't answered whether this node should be a seperate binman
> node - or if you'll reuse the existing flash (partitions) node(s) and
> add any missing property there. If it's the latter, I don't think
> compatible = "binman", "fixed-partitions"; is correct.

My intent is to make it compatible, so wouldn't it make sense to have
binman as the first compatible, then falling back to fixed-partitions
as the second?

>
> >> Maybe (a more complete) example would be helpful.
> >
> > Can you please be a bit more specific? What is missing from the
> > example?
>
> Like a complete (stripped) DTS. Right now I just see how the individual
> node looks like. But with a complete example DTS, my question from above
> would have been answered.
>
> What if a board uses eMMC to store the firmware binaries? Will that then
> be a subnode to the eMMC device?

I thought there was a way to link the partition nodes and the device
using a property, without having the partition info as a subnode of
the device. But I may have imagined it as I cannot find it now. So
yes, it will be a subnode of the eMMC device.

Regards,
Simon
