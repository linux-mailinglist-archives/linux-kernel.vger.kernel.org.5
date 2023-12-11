Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B0280DC0A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344832AbjLKUtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344409AbjLKUtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:49:21 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC529F;
        Mon, 11 Dec 2023 12:49:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-33334480eb4so5566780f8f.0;
        Mon, 11 Dec 2023 12:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702327766; x=1702932566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FNt1leGWwF6iMNgl8vh4qT6p47tEM1r7xJkmF3rIPw0=;
        b=lfAdm+YZKUmrhoa0+b7TXXu4yEaexLEknsBKbF89xi5NJTQZZBWcyqGYd74ivxcV3N
         GSuiFYZgRe1TvwEzHTjzmkf5KV4VRaipmH+vfSaRZYsRgaYVf8IkIQGjyngRp4yjwbu0
         6xcLJBI5nxAzqT6R3liS5H5lw0mriiqtm+Zus+Q/U93V3fC9KvBCRwrLR+QIPlzLU5dy
         0paZK/BzmKUV3VdnjYFWINbPGkC7mIq/PzHVMVRy4EKlVqE5dKRUnjQQGO/YJaPYIwmC
         zJeglbS2DeHjDQpaCaO3KSO72dgLnit6sL06QyhfF5oJ2DNATFFoLHnW/qIB0Ko1j54c
         Ih+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702327766; x=1702932566;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNt1leGWwF6iMNgl8vh4qT6p47tEM1r7xJkmF3rIPw0=;
        b=VFr+AZ2nI8Lnb2MrzJy2v2HF9CWFbhQd9L1tvWY6yo7QQRhdfhY6URk4U03FRL0tH3
         ABubsiK5w3dDThoIUe8DWhwipOiaYgTAxVlJ4IPP9uHRJJlXW7NdVSpx3irdjgmToXx/
         vkGkkP2Vz5bdX3/vGqkneq6kOyfq7piVYSa4fExvaR4LZA7VXzYnoT61KkZ3xW85DeWH
         nTls4AH5ZQyO/acUPViXxYpVep2EgGe1JS14lhiXOgtrNVwcgJv9GxvBNlFyfkYX062r
         9Bus3DmQtnqzpVBwcjqv+U8SCYdV+BX/sHGQi/JUfK90WdYG4tnXuXxbqk7MOx/ibGEF
         yOmg==
X-Gm-Message-State: AOJu0Ywwd7LAS/42a/YrHXq3sZTTSi8FTGBBJpZ4Y9Kih7xM+5zlDZQP
        t9PtRyeF2Y277mJjakW3BFg=
X-Google-Smtp-Source: AGHT+IH2XFdFabW6X217F3scHBOkH/lG9jnSJEwVmN7ZeT+/bl8+IDli3a7laaNgA/b33aOEYwS0ZA==
X-Received: by 2002:a5d:61d1:0:b0:333:2fd2:2eda with SMTP id q17-20020a5d61d1000000b003332fd22edamr2434593wrv.83.1702327766165;
        Mon, 11 Dec 2023 12:49:26 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id o10-20020a5d58ca000000b0033338c3ba42sm9375414wrf.111.2023.12.11.12.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 12:49:25 -0800 (PST)
Message-ID: <657775d5.5d0a0220.20552.2a2d@mx.google.com>
X-Google-Original-Message-ID: <ZXd10iNX_S5S0vib@Ansuel-xps.>
Date:   Mon, 11 Dec 2023 21:49:22 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [net-next RFC PATCH v2 3/4] dt-bindings: net: Document QCA808x
 PHYs
References: <20231211192318.16450-1-ansuelsmth@gmail.com>
 <20231211192318.16450-3-ansuelsmth@gmail.com>
 <170232732808.2870894.17994101779465776370.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170232732808.2870894.17994101779465776370.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 02:42:08PM -0600, Rob Herring wrote:
> 
> On Mon, 11 Dec 2023 20:23:17 +0100, Christian Marangi wrote:
> > Add Documentation for QCA808x PHYs for the additional LED configuration
> > for this PHY.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > Changes v2:
> > - Fix License warning from checkpatch
> > - Drop redundant Description phrase
> > - Improve commit tile
> > - Drop special property (generalized)
> > 
> >  .../devicetree/bindings/net/qca,qca808x.yaml  | 58 +++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/qca,qca808x.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/qca,qca808x.yaml: 'anyOf' conditional failed, one must be fixed:
> 	'properties' is a required property
> 	'patternProperties' is a required property
> 	hint: Metaschema for devicetree binding documentation
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231211192318.16450-3-ansuelsmth@gmail.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>

Erm sorry for the bot error... But How to handle this? 

-- 
	Ansuel
