Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7467A4942
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241900AbjIRMIi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 08:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241768AbjIRMIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:08:05 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5516A9;
        Mon, 18 Sep 2023 05:07:59 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59c0b5f984aso31684307b3.2;
        Mon, 18 Sep 2023 05:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695038878; x=1695643678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVLFaUZxjITE8rsgw+msJqGq4oa1CVCEEZAwZaJky7Y=;
        b=Sd51PttW5gIDKNCE/2gQSnJa+93uju8mGp7tF8VNScoozQnI9Ro1VF0PzFprXM40c/
         Xjja1uXQxdkpFJiUCNada+qRWnVh6208LT1oftwdp12mXJ+eLECLu0Yq1rPvTZVsjgsX
         DOUzRppZtbfXJAulnCNCO9xHx/16h6/vOk4uZPMttGNiNpFZeBwZEgWB97f4qdZaSu4+
         eyNbTzYyuS81dkOYem5dgOsXAW0WMBWhi492lLegGTdxES/oFAz/LyuEkcNA1bOry29r
         SsG/Fd1lcnkBILrL0nw55w1FTu1YbQSNLDH/gR+/DswUeH/2e0zleHlz2Ap5KZEl+lP3
         pgkw==
X-Gm-Message-State: AOJu0YxXF2wsszg15NslO2SnBOwFmdxHEkLlBgruqkCFmydlmLQdmdvN
        K0Drv7ifRhnclsIr5B05tBJS82M25JVX2w==
X-Google-Smtp-Source: AGHT+IFek3kqpUOJnGFMwvatm/fLTMWJsD34hLXKaBKav8ilU/6R+d5yvUQStlnEpVmpXIjn9nE4Yw==
X-Received: by 2002:a81:ee0e:0:b0:59b:4bb2:fc2c with SMTP id l14-20020a81ee0e000000b0059b4bb2fc2cmr160497ywm.48.1695038878327;
        Mon, 18 Sep 2023 05:07:58 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id d194-20020a814fcb000000b0058fb9863fe7sm2485229ywb.103.2023.09.18.05.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:07:58 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-59be6605e1dso47396927b3.3;
        Mon, 18 Sep 2023 05:07:58 -0700 (PDT)
X-Received: by 2002:a81:8287:0:b0:59c:7d0:ab06 with SMTP id
 s129-20020a818287000000b0059c07d0ab06mr9944623ywf.45.1695038877926; Mon, 18
 Sep 2023 05:07:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230911214623.2201324-1-robh@kernel.org>
In-Reply-To: <20230911214623.2201324-1-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 14:07:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXAW6MNEdo+vuTPkpGPXa0ebfG3Ec_=i0UhEtt6YfSQeQ@mail.gmail.com>
Message-ID: <CAMuHMdXAW6MNEdo+vuTPkpGPXa0ebfG3Ec_=i0UhEtt6YfSQeQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: Apply overlays to base dtbs
To:     Rob Herring <robh@kernel.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Sep 11, 2023 at 11:47 PM Rob Herring <robh@kernel.org> wrote:
> DT overlays in tree need to be applied to a base DTB to validate they
> apply, to run schema checks on them, and to catch any errors at compile
> time.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

> Looks like some of these apply to multiple base DTs. I've only added them
> to 1 base.

Indeed:
  - draak-ebisu-panel-aa104xd12.dtbo applies to r8a77990-ebisu.dtb, too,
  - salvator-panel-aa104xd12.dtbo applies to all salvator-x(s) variants.

So should they be added to all bases they apply to?

Or, if you intend none of the composite DTBs to be consumed as-is, but
only intend them to be created for validation, perhaps the additional
rules should be grouped together at the bottom of the Makefile?

> --- a/arch/arm64/boot/dts/renesas/Makefile
> +++ b/arch/arm64/boot/dts/renesas/Makefile
> @@ -64,6 +65,8 @@ dtb-$(CONFIG_ARCH_R8A779F0) += r8a779f0-spider.dtb
>
>  dtb-$(CONFIG_ARCH_R8A779G0) += r8a779g0-white-hawk.dtb
>  dtb-$(CONFIG_ARCH_R8A779G0) += r8a779g0-white-hawk-ard-audio-da7212.dtbo

Do you still need the individual *.dtbo rules? Perhaps you are
afraid that make will auto-delete them as they are only used as
intermediaries?

> +r8a779g0-white-hawk-ard-audio-da7212-dtbs := r8a779g0-white-hawk.dtb r8a779g0-white-hawk-ard-audio-da7212.dtbo
> +dtb-$(CONFIG_ARCH_R8A779G0) += r8a779g0-white-hawk-ard-audio-da7212.dtb


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
