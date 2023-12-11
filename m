Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3816980C95B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbjLKMSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjLKMSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:18:16 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108078E;
        Mon, 11 Dec 2023 04:18:22 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c0fc1cf3dso46256905e9.0;
        Mon, 11 Dec 2023 04:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702297100; x=1702901900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QiV4Bcxzf25dJHNqzSbQoSLWzyN0MNcOZek8LpkVKp8=;
        b=CKE3WHOfp5JHMH3wQiwlKMtmgOyh3UmLdClzIG4DNSMGuuVDKLAHXJ/UJx3XkbQ7bo
         WeTck7iVJ8luuXg6o9GmVCRaKgg7iVdi1E73wyk82jGTKHaff3PhNnYurPf9NEJCyiC6
         PFHwYSnPH+j/hzL5Z5mwc3HjJyfdmVDEYREy2aaRw4/yTmsUakyAaDwqDA9Ghe8Wag6q
         d3wLCwcpJ5N4u0BSj98u/oPOq8ePZr81SnmN/1F0P3DHt0dLYbI71t3Z6nWNyHq+PvbQ
         a74BcdpuPm2MRRGd9eo7qjk4T4bwJkp8b5t+Nb7pMJFnj8x8gEztFyN5MFTy/5WHLW11
         bMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702297100; x=1702901900;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiV4Bcxzf25dJHNqzSbQoSLWzyN0MNcOZek8LpkVKp8=;
        b=bcePS31RzEcIoW0aLcsWH7oq4FmID9XsZtYyL2JOZYpqqC4rlbmBzC1OQecFXxKZ+o
         YC6bQ+OaBiYN+AnJJHMc8T2jM5AHTBk6FlBwjGNmRZl911MKFHaC1UW/WaIf6RUK0rtp
         tc/Oi3r1amQc5ZDIWCeGG0g5nJ3xi+vUzdqTsCA7nQtK3l2Ma/nAvn1rrQkBzjOpJM1B
         sQqlQjo4t8zMZzbgY/efTDyGbYMhTQv0eW3YP41kXNEFPttQbGIzfUb6BfF8/iBWvv9A
         JTr1UEa5ld3ieasgWKrFiDLNQH4CCv6GLluYB+PUBD2rS46VkZIj2d2tVFZ8JzsGXRk5
         dZKw==
X-Gm-Message-State: AOJu0Yy5hOEhg7n82f4+2BhY9nEMEH7PG91NG/Hcutrx73PfMtqJ1j4U
        nTw7EcDBPjNiqa++8kt9acs=
X-Google-Smtp-Source: AGHT+IE6K37AePv5EZZBztKb3nE9ejxdrzxZNJcnN083N38EoiRyMtue+Eo9A0d+n4EwUgjzIx50KQ==
X-Received: by 2002:a05:600c:81b:b0:40b:5e59:c590 with SMTP id k27-20020a05600c081b00b0040b5e59c590mr2083036wmp.186.1702297100030;
        Mon, 11 Dec 2023 04:18:20 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600c4e0100b00405959469afsm12923793wmq.3.2023.12.11.04.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:18:19 -0800 (PST)
Message-ID: <6576fe0b.050a0220.e99f3.b2b5@mx.google.com>
X-Google-Original-Message-ID: <ZXb-CAFPxqA5v4Ff@Ansuel-xps.>
Date:   Mon, 11 Dec 2023 13:18:16 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] dt-bindings: Document QCA808x PHYs
References: <20231209014828.28194-1-ansuelsmth@gmail.com>
 <b855eceb-05f4-4376-be62-2301d42575e7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b855eceb-05f4-4376-be62-2301d42575e7@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 11:19:50AM +0100, Krzysztof Kozlowski wrote:
> On 09/12/2023 02:48, Christian Marangi wrote:
> > Add Documentation for QCA808x PHYs for the additional property for the
> > active high LED setting and also document the LED configuration for this
> > PHY.
> > 
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.
>

Yes sorry.

> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  .../devicetree/bindings/net/qca,qca808x.yaml  | 66 +++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/qca,qca808x.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/net/qca,qca808x.yaml b/Documentation/devicetree/bindings/net/qca,qca808x.yaml
> > new file mode 100644
> > index 000000000000..73cfff357311
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/qca,qca808x.yaml
> > @@ -0,0 +1,66 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> 
> Dual license as checkpath and writing-bindings ask.
> 

Oh didn't notice the warning.

> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/qca,qca808x.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Atheros QCA808X PHY
> > +
> > +maintainers:
> > +  - Christian Marangi <ansuelsmth@gmail.com>
> > +
> > +description:
> > +  Bindings for Qualcomm Atheros QCA808X PHYs
> 
> Drop "Bindings for" and then entire sentence seems not useful.
> 

Was following the pattern used for other qcom PHY. Ok will drop!

> > +
> > +  QCA808X PHYs can have up to 3 LEDs attached.
> > +  All 3 LEDs are disabled by default.
> > +  2 LEDs have dedicated pins with the 3rd LED having the
> > +  double function of Interrupt LEDs/GPIO or additional LED.
> > +
> > +  By default this special PIN is set to LED function.
> > +
> > +allOf:
> > +  - $ref: ethernet-phy.yaml#
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - ethernet-phy-id004d.d101
> 
> I have impression that this is continuation of some other patchset...
> Anyway, id004d.d101 is specific to QCA808x?
> 

I used enum assuming eventually more qca808x PHY will come... Yes that
ID is specific and it's the id of QCA8081. Better to use const?

> > +  required:
> > +    - compatible
> > +
> > +properties:
> > +  qca,led-active-high:
> > +    description: Set all the LEDs to active high to be turned on.
> > +    type: boolean
> 
> 
> Best regards,
> Krzysztof
> 

-- 
	Ansuel
