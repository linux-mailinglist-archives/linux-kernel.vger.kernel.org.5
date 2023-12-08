Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DE580B0A1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 00:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbjLHXiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 18:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLHXiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 18:38:07 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EB6171E;
        Fri,  8 Dec 2023 15:38:14 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-4b314f78326so748666e0c.3;
        Fri, 08 Dec 2023 15:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702078693; x=1702683493; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aa6XX3Pqe4FOIY2+l8f727rXZuXDdaFGtGV099fvry8=;
        b=DvSBzWei1+woCDmO4i35JAxRnbVIIBCTQlB5fOohtwYpOQ+i2AuwMvujUcsDkGYqHk
         Jd7slqy8iymOclrjFcAswIq8wFBggNmlCFY3xQpxFMcR1vpT5D/mMnbcPmqdYTDwDdQa
         6tYPWMwIairEPgNcF7e+VOKXbau9gqmKAT29pxFTvEya11DTliUFrafxOEYKg/uZ7Jhy
         Dtl16x80NIUfpXrOLqmKc1sZRtR2tnVD4PXQtHX9Hnet78iLULefVE1yY7qBR+o7llOS
         +d0Xp50nyJK+Qe0sYPOOinW14h8afpOqArNEytdTPDyjrzXNz3FVKLZQESrULgW3fTOz
         9VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702078693; x=1702683493;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aa6XX3Pqe4FOIY2+l8f727rXZuXDdaFGtGV099fvry8=;
        b=NFE5zeqDyLoJGIfACo302CejYradaSPDJOjIfdMsJE0ke7vhH6RKozUT9mKPHqVDto
         K8hjMfDXpNuwGE2nNyG1LNKGPtPJfjJYVKOX5prQAMR8X/er1kuT6PDCh01LnP7KlvJz
         iSIMN6CfMnrv8NiZ5/+bX4LvIA6m58LXfjHcqOTcPsCnFv4bXwO1g6ehVk7B7VhNcG2X
         ny/97PtRJAyzg9ZWt1zJeJc178JhyoGXBTM+pLIGVthfwpxjZURTPG8jihHMmJMhvEC6
         dGn7veOexQC9mA6NZn5v6yiF5lt3aJi52DhO9AScxFP3NUAxgqjBs8gtXqblL1lQe61Q
         +7Eg==
X-Gm-Message-State: AOJu0YxYdiEmPzkPo3u25Ij/YTBCDK7lQ5PYQ5wd/2uuiwj8mN2F44E4
        m42kBsnoiPUCDQ/7vQwJhUg=
X-Google-Smtp-Source: AGHT+IFkBIYirOVsuJZ+xKdfgU+tNmKrr/wwRQ+zfxVVmiBF4DC8/teo4dabz706/JZwpt6hg+Y2UQ==
X-Received: by 2002:a05:6122:3a0a:b0:4b2:c555:15a0 with SMTP id fp10-20020a0561223a0a00b004b2c55515a0mr1079285vkb.27.1702078693275;
        Fri, 08 Dec 2023 15:38:13 -0800 (PST)
Received: from google.com ([205.220.129.31])
        by smtp.gmail.com with ESMTPSA id kh10-20020a056214514a00b0067a1c7d8e98sm1167263qvb.41.2023.12.08.15.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 15:38:12 -0800 (PST)
Date:   Fri, 8 Dec 2023 23:37:47 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stefan Eichenberger <eichest@gmail.com>, nick@shmanahar.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: input: atmel,maxtouch: add
 poweroff-in-suspend property
Message-ID: <ZXOoy8mFdhUQsZAu@google.com>
References: <20231207111300.80581-1-eichest@gmail.com>
 <20231207111300.80581-2-eichest@gmail.com>
 <CACRpkdbSs-vebvchxx-Tg+O5CUF5M3vZf-iytuW=ZECnHb2anA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbSs-vebvchxx-Tg+O5CUF5M3vZf-iytuW=ZECnHb2anA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Krzysztof,

On Fri, Dec 08, 2023 at 01:54:21PM +0100, Linus Walleij wrote:
> On Thu, Dec 7, 2023 at 12:13 PM Stefan Eichenberger <eichest@gmail.com> wrote:
> 
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> >
> > Add a new property to indicate that the device should be powered off in
> > suspend mode.
> >
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> (...)
> > +  atmel,poweroff-in-suspend:
> > +    description: |
> > +      When this property is set, all supplies are turned off when the system is
> > +      going to suspend.
> > +    type: boolean
>    wakeup-source:
>      type: boolean
> 
> As Krzysztof says it seems you are describing an operating system feature.

It appears to be an OS feature, but I would argue that it is also a
property of a board. It is tempting to say that if DTS defines supplies
for the controller we should use them to power off the controller in
suspend, otherwise we should use the deep sleep functionality of the
controller. But a mere presence of regulators does not indicate if they
can actually be powered off in suspend (i.e. if controllers shares power
rails with another device that can be a wakeup source), so we need to
have additional hints on how OS should behave on a given device.

On top of that we have regulator framework supplying dummy regulators...

Thanks.

-- 
Dmitry
