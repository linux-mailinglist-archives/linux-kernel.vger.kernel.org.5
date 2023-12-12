Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A2980F565
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjLLSUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376617AbjLLSUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:20:44 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36016ED;
        Tue, 12 Dec 2023 10:20:50 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1fb04b2251bso4349155fac.0;
        Tue, 12 Dec 2023 10:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702405249; x=1703010049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDE81kuOGXddlPQChxv8quZusCqlbynJ9UhLrlhz+O8=;
        b=e+Jeyx9W7qzaLJtHd/wZHGEMW4dXcE7/dQ2i710FPpn+HAlKXUy1kjbmblMG8/agfx
         ejM/emvS2R2UCv/0sZBryyQpXidPmvHZB3fOcsU8gNu/QWHZ8k/tQUNyOINYETYcUY6y
         Oe+WjeQMUIwfB1nHjnCl+ZXmGlcE+88/4lWehG1f/HH1CtpNnM5gCapxIhgodIk65Bui
         1FqYsjToDAfGFAdXOfkT59dq7srh6jsp+rgnC7UHrXccnMaBulGvqyUqmUsyZSOfvIIP
         QAnjPUMPADgRQV222ovpAVEJ8cJ0WyDcChk0IgvBHl23w3FlPRYZSIkXh6lRzd3U3A9J
         hOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702405249; x=1703010049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDE81kuOGXddlPQChxv8quZusCqlbynJ9UhLrlhz+O8=;
        b=jhXuFll95DclO0ZZ3xc7s9/VXijzQuWNhnWOwSEHtBg1FXtR+SzKi8WEKLICfNlJJr
         U/BN4Yvihh3F1IJ9UINIL6SgkwBPBUaTVYKH7ZcDQdrmyP8ODYfFeCAr0OhPMXl5btLw
         Hhkh3lsmdAE0PsJ2vGgfXAbd6TaWd6lBRhUHo0sDd4pTZTlZJ0w3DcvXBzlDAEkV2guh
         XNBEY5DJWlIKyrdVggsAW+0BvJ0s23lT8vyB6bRTBzriNI0YfOiDLxwmMAIHy2CtakZq
         dV/RL7JBmZxTFwsxSecyG8EoejCDtVRx/GFyT7aYNwgZum88iW2CUMcuAo4Ia36BzxTO
         FyrA==
X-Gm-Message-State: AOJu0YyyVdgnr1oeccREBRFVZmsTMhGtTP6GhWSGkV3DJtgUYgF30Wmt
        L5leppOP6THKfcwWYuAj0ys=
X-Google-Smtp-Source: AGHT+IGXLWFXupo/tm4tBeTHuC5qUcoL4NqHg6JPGuiyBNYPVPEE1uHva1Z0E6nslMmzhakP+HwG5Q==
X-Received: by 2002:a05:6871:798a:b0:1fb:dc3:782d with SMTP id pb10-20020a056871798a00b001fb0dc3782dmr7720211oac.55.1702405249374;
        Tue, 12 Dec 2023 10:20:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id wd15-20020a056871a58f00b001fb21cee425sm3338823oab.40.2023.12.12.10.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 10:20:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 12 Dec 2023 10:20:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Conor Dooley <conor@kernel.org>
Cc:     Ninad Palsule <ninad@linux.ibm.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com,
        johannes.holland@infineon.com, broonie@kernel.org,
        patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
        bhelgaas@google.com, naresh.solanki@9elements.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geissonator@yahoo.com
Subject: Re: [PATCH v1 2/8] dt-bindings: tpm: Add schema for TIS I2C devices
Message-ID: <874d4416-86e5-48cc-9c84-97357e4caefe@roeck-us.net>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-3-ninad@linux.ibm.com>
 <20231212-amusement-elevation-28e42bcccc35@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-amusement-elevation-28e42bcccc35@spud>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 05:14:26PM +0000, Conor Dooley wrote:
> Hey,
> 
> On Tue, Dec 12, 2023 at 10:39:58AM -0600, Ninad Palsule wrote:
> > From: Johannes Holland <johannes.holland@infineon.com>
> > 
> > Add a dt schema to support device tree bindings
> 
> "Add bindings for..."
> 
> > for the generic I2C
> > physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
> > Specification for TPM 2.0 v1.04 Revision 14.
> > 
> > This includes descriptions for the Nuvoton and Infineon devices.
> > 
> 
> > OpenBMC-Staging-Count: 3
> 
> I have no idea what this is, but it needs to be removed from the patch.
> 
> > Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> > ---
> >  .../bindings/security/tpm/tpm-tis-i2c.yaml    | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> > new file mode 100644
> > index 000000000000..de1e34065748
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: I2C PTP based TPM Devices
> > +
> > +maintainers:
> > +  - Johannes Holland <johannes.holland@infineon.com>
> > +
> > +description:
> > +  Device Tree Bindings for I2C based Trusted Platform Module (TPM).
> 
> s/Device Tree Bindings for //. Doesn't dt_binding_check now complain if
> you have this in a title or description?
> 
> > +properties:
> > +  $nodename:
> > +    pattern: "^tpm(@[0-9a-f]+)?$"
> > +
> > +  compatible:
> > +    oneOf:
> > +      - description: Infineon's Trusted Platform Module (TPM) (SLB9673).
> > +        items:
> > +          - const: infineon,slb9673
> > +          - const: tcg,tpm-tis-i2c
> > +      - description: Nuvoton's Trusted Platform Module (TPM) (NPCT75x).
> > +        items:
> > +          - const: nuvoton,npct75x
> > +          - const: tcg,tpm-tis-i2c
> 
> > +      - const: tcg,tpm-tis-i2c
> 
> IMO this should be removed and this fallback should only be used in
> combination with device specific compatibles, like you have here for the
> infineon and nuvoton devices.

As mentioned in my response to the other patch, "only" isn't sufficient
since the tacoma devicetree file only references the generic entry.
It would also make support for chips from other vendors unnecessarily
complex.

Question should in my opinion be if the non-fallback entries are really
needed.

Thanks,
Guenter
