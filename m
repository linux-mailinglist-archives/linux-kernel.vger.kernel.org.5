Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C1E7FACDA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 22:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjK0Vzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 16:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbjK0Vz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 16:55:28 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C4CC1;
        Mon, 27 Nov 2023 13:55:35 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1fa1bcf1d01so1662305fac.0;
        Mon, 27 Nov 2023 13:55:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701122134; x=1701726934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+Cbf4Z4xMq9dOhY2lkOSlIg0Yv9C+GaGVRwFcKdaa4=;
        b=mrXfHhXWE/HlW2oFiNizk/4cY7MlU1odoM361EH5rtfmSMORp9a7f5V4lxp8RhJKOG
         RtiNb4XcSSukoq7dWX47nS31m3RPr/AOlH/cLj1xYR3xvLsiC8hZlcPkr66cchGj8a1P
         G9YBcRlvEWNcvVTVkzK37yyjIbOkS9RkAGy7nOMY5JdE0fAN+x1y1fXwzoUFgNShccKr
         vAzgQAdN9Pen4VpF7x8keE/HTjvUSftSllOlBfqEidZynaEDnllI9SeEVVuVUk6pBOj1
         nHIVZA6CJWX2zS/lpo5elch+xJsO65OpC3RN+AAxZugOK09QyAt7dgIDRWaSpdk3WOmN
         6CKw==
X-Gm-Message-State: AOJu0YxdpstD7o/e9IpkjZVtXCniis3oekydzZjW6JjpIdFjUF6EsK3i
        Vseh7+bJV2+xp2XRvIsEnatSwb+Fpg==
X-Google-Smtp-Source: AGHT+IHE/25NEUwlRx2TOFVPP+SptbOdKM4BzwgEQJDXuam12+MKf64pu6FFsol8jZ2RdnKGcptx6g==
X-Received: by 2002:a05:6870:5d93:b0:1f0:656b:5b99 with SMTP id fu19-20020a0568705d9300b001f0656b5b99mr19942781oab.11.1701122134393;
        Mon, 27 Nov 2023 13:55:34 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id lu4-20020a056871314400b001fa54ae35e0sm681401oac.12.2023.11.27.13.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 13:55:33 -0800 (PST)
Received: (nullmailer pid 3942464 invoked by uid 1000);
        Mon, 27 Nov 2023 21:55:32 -0000
Date:   Mon, 27 Nov 2023 15:55:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Andrew Davis <afd@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nishanth Menon <nm@ti.com>, Olof Johansson <olof@lixom.net>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] docs: dt-bindings: add DTS Coding Style document
Message-ID: <20231127215532.GA3822595-robh@kernel.org>
References: <20231125184422.12315-1-krzysztof.kozlowski@linaro.org>
 <20231125193737.GD7486@pendragon.ideasonboard.com>
 <26f095ab-c47d-4bcb-9830-4493b1c0cc75@linaro.org>
 <20231126145340.GA19999@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126145340.GA19999@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 04:53:40PM +0200, Laurent Pinchart wrote:
> Hi Krzysztof,
> 
> On Sun, Nov 26, 2023 at 11:32:17AM +0100, Krzysztof Kozlowski wrote:
> > On 25/11/2023 20:37, Laurent Pinchart wrote:
> > > On Sat, Nov 25, 2023 at 07:44:22PM +0100, Krzysztof Kozlowski wrote:
> > >> Document preferred coding style for Devicetree sources (DTS and DTSI),
> > >> to bring consistency among all (sub)architectures and ease in reviews.


> > >> +
> > >> +Naming and Valid Characters
> > >> +---------------------------
> > >> +
> > >> +Devicetree specification allows broader range of characters in node and
> > > 
> > > s/Devicetree specification/The Devicetree specification/
> > > s/broader range/a broad range/
> > 
> > Ack, but I really expect people finish with grammar and style fixes at
> > v3. Please point the language things now or just let it go.
> 
> v3 is the first version that ended up in my inbox. I haven't noticed any
> other spelling or grammar error in this patch, but I can't guarantee I
> won't see any in new text that gets introduced in a future version :-)
> 
> > >> +property names, but for code readability the choice shall be narrowed.
> > >> +
> > >> +1. Node and property names are allowed to use only:
> > >> +
> > >> +   * lowercase characters: [a-z]
> > >> +   * digits: [0-9]
> > >> +   * dash: -
> > >> +
> > >> +2. Labels are allowed to use only:
> > >> +
> > >> +   * lowercase characters: [a-z]
> > >> +   * digits: [0-9]
> > >> +   * underscore: _
> > >> +
> > >> +3. Unit addresses shall use lowercase hex, without leading zeros (padding).

Unless a bus defines differently, unit addresses shall ...

> > > 
> > > I'm curious, what's the reason for this ? I think it makes the sources
> > > less readable. If the rule is "just" because that's how DT sources are
> > > written today and it would be too complicated to change that, that's
> > > fine with me.
> > 
> > Warning (unit_address_format): /cpus/cpu@0100: unit name should not have
> > leading 0s
> > 
> > And we fixed all or most of DTS some time ago.
> 
> It's the current practice in DT sources and I understand it won't get
> changed, but I was more curious about the rationale behind that.

I put the dtc check in, but the rational predates me. The OF PCI bus 
supplement from the 1990s defines that. My only rationale to check it 
was to be consistent. We don't check "the unit-address is lowercase hex"
because technically the bus defines the format. Leading 0s was as much 
as I could get David G to agree to check without regard to bus type.

Rob
