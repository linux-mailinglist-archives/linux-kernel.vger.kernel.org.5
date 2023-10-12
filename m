Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BED17C6219
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 03:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjJLBPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 21:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjJLBPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 21:15:08 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2382A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 18:15:06 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-57c0775d4fcso54782eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 18:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697073306; x=1697678106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgOKZxofitClM+o1lLshkyVp5VF97o2K5OR3XWz9MEg=;
        b=YkJEqLkyoOzm6YBPOnGXJ38ZL07TGjyNcaJbVzZyLfJgXmCp9+u29Ywfp2K5omsJJQ
         NeKfgelklnAgF1mbYkIEiY/wUahN0yIvKRAswGco8zRXlgb8nw4VzmE4qzGYmbl/wINv
         oZxUoxtEVy/IdOvA7ztSW+S6eCAGqxtlt5/ag24LWLo71yxeX8e8/UQIYh14ldOJK2Qp
         QF+i1XWCCevezGlmWjG7b5VykUd3lav48BwmjTdG3fu/zw7bDJ47zH73kYaMFZRH7q9X
         ucsGyxH9BZLZzDEHbvhFKqZu/H6WRI21qRTsXiVaqWEs+bStln3uqXHxSibzscdsLHBx
         pOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697073306; x=1697678106;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgOKZxofitClM+o1lLshkyVp5VF97o2K5OR3XWz9MEg=;
        b=OSeifYtqHreVEih/p8UVq3aQ33aSMThcKxf2HpwEwrY3w6sHj9VTSo+ZGqzSZB0zRX
         PA0KJS6uT4XOCEj+ZVAC0bzDcKPRZqXlXWStG8SRurwVMMdv+LMieufjqK5zNqLau5H8
         kfDJrfl43Lg4VV0LhGbmsccKDvNy6ew459ZJzVUedRGXuII913v4hFVvDu9uyZoSdQcp
         yXXkczZWo1DQu0Oo94GzufHkCfVrK3qSseUoKvgSGPx/Xp2nd/OdRB8YZmaEE+MvIGVq
         hAGObFvJG+eKGex7qSPpOVGSyVwbDvt15FfL9EFpYbH5+Z8LOnVuKMsa2hkfCbKablHx
         sRyA==
X-Gm-Message-State: AOJu0YyBo3a8Mg1WAX3e6xu8gpxdS9k6SNVnqYnjg7HLUwQvldwsOTjb
        cOm3D9fTFAI9Mxe6a5msHDFatg==
X-Google-Smtp-Source: AGHT+IE3yeeBoXFf4sEvkSsuyliBNq7zk3TnWf86xikV3WfID6a2o3LkesKNFo/NtOJRUJpc2tbduw==
X-Received: by 2002:a05:6359:6418:b0:166:8ba6:d36d with SMTP id sh24-20020a056359641800b001668ba6d36dmr714395rwb.0.1697073306042;
        Wed, 11 Oct 2023 18:15:06 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:f7a8:3d44:f8cb:28e])
        by smtp.gmail.com with ESMTPSA id t17-20020aa79391000000b00694fee1011asm10706296pfe.208.2023.10.11.18.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 18:15:05 -0700 (PDT)
Date:   Thu, 12 Oct 2023 10:15:01 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [RFC v2 5/5] dt-bindings: gpio: Add bindings for pinctrl based
 generic gpio driver
Message-ID: <ZSdIlaom+QO8IlKW@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20231005025843.508689-1-takahiro.akashi@linaro.org>
 <20231005025843.508689-6-takahiro.akashi@linaro.org>
 <a8d31c42-1248-4738-b01a-3abeedfd49eb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8d31c42-1248-4738-b01a-3abeedfd49eb@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 09:48:09PM +0200, Krzysztof Kozlowski wrote:
> On 05/10/2023 04:58, AKASHI Takahiro wrote:
> > A dt binding for pin controller based generic gpio driver is defined in
> > this commit. One usable device is Arm's SCMI.
> > 
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> > +
> > +required:
> > +  - compatible
> > +  - gpio-controller
> > +  - "#gpio-cells"
> > +  - gpio-ranges
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    gpio0: gpio@0 {
> 
> No reg, so no unit address.

My intention was to allow for multiple nodes (instances) of
pinctrl based gpio devices. But I don't care the naming.

> Drop also unused label.

Okay, I already dropped an example consumer device and have no need
for the label any longer.

-Takahiro Akashi

> 
> > +        compatible = "pin-control-gpio";
> > +        gpio-controller;
> 
> Best regards,
> Krzysztof
> 
