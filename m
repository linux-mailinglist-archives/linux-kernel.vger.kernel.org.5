Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80247AC7DD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 14:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjIXMC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 08:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjIXMCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 08:02:25 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60B7103;
        Sun, 24 Sep 2023 05:02:17 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3512f905f6cso4468335ab.3;
        Sun, 24 Sep 2023 05:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695556937; x=1696161737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AozxdM/eQ8ffY41x90FSUIOrIa5FeaNEfJtd13a8iWY=;
        b=fg0I7SGN6xY/VdxlIc9TPNHV5+Q5eLbx485qv7FVbKKJ9PKyjEVJ54sFq2iUXoHO4y
         DmlkywcR/zV0zkSI3j4PH4hVop+c4JETEKpGHvYei0LKNUMyhq3Oa1VjTQFoufJNFlkW
         SCYunG7HHAxUOdooX5nfv5fYorOJZMssrpql6fsMcZnZBfKkoU4r5x7uLUHjI+nP7AvQ
         SshsApzOfVhBcfGRyHwIcHbOg6dSxVzcz4chktThG3NAHRqejjpoxvq3ehdsYvGQONBf
         lrz2/LYMBu/De4ZLvhDgPwunQXSSKIqFlrItqKB7tu7e+un15N6yW8st2ohl9tBXNspq
         h1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695556937; x=1696161737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AozxdM/eQ8ffY41x90FSUIOrIa5FeaNEfJtd13a8iWY=;
        b=udnfuNuq0ARdHQ/DnwwH9E99f6Rh8Ylco0avaKobMRN4nZdgA3dQ9NbNoYfU6Djqea
         vb++80GtACF3z2tsZPaPziXWJ1S1l5/Z3X5ebdKnzf+6LItkrhq8WLBSdovesGOKT+i9
         YtIeIMcWzBXdlu0UdpHd2L7LKYGwhI/iePOXoDLNHDXVwIhmEBAhpy1NfEHHYWy36lDf
         Yb0kKnd7SF1sDHzSwKGlUUs5sEzn52igpfuBUIOLIFi76TeLoLHgXTj33Edl5X7rSNvb
         sJt5tf4941rPVltxeyZSpo32IKTgtso+PiD/gF0sNtgc32md1DLxS4oJ+I5Olcb0aZip
         QtMw==
X-Gm-Message-State: AOJu0Yzn7E0Pqlh+EjDnneLsGVuVWM5wshLpgWKdHyF6nwCwyIxvd5jC
        WNQyh6h0srlR5zw56Gb44cw=
X-Google-Smtp-Source: AGHT+IGa0R7AGF43U53WRQyGs/AJuGDJ0Ykql9xq/cyo/pYAMMMFcvu4wYGUvUyqRGoX46ZA1WwDlQ==
X-Received: by 2002:a05:6e02:ec5:b0:34f:1028:ff9f with SMTP id i5-20020a056e020ec500b0034f1028ff9fmr4699339ilk.18.1695556937102;
        Sun, 24 Sep 2023 05:02:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t21-20020a63b255000000b00578e9751b88sm6143014pgo.1.2023.09.24.05.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 05:02:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 24 Sep 2023 05:02:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc:     Rob Herring <robh@kernel.org>,
        "Matyas, Daniel" <Daniel.Matyas@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: max31827: use supply pin name
Message-ID: <0cb70677-6dfd-43e0-a3c5-cae3b861a7d1@roeck-us.net>
References: <20230921142005.102263-1-antoniu.miclaus@analog.com>
 <20230922211201.GA3600661-robh@kernel.org>
 <CY4PR03MB3399B818487F87D7297EC33F9BFEA@CY4PR03MB3399.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR03MB3399B818487F87D7297EC33F9BFEA@CY4PR03MB3399.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 02:19:45PM +0000, Miclaus, Antoniu wrote:
> 
> 
> > On Thu, Sep 21, 2023 at 05:20:03PM +0300, Antoniu Miclaus wrote:
> > > The actual hardware pin name for the supply of max31827 is vdd.
> > > Update the dt-binding to reflect the hardware properties accordingly.
> > 
> > Changing this breaks the ABI. I see the old one wasn't used by the
> > driver, but that's just one driver potentially. You need some
> > justification here why it's okay to break the ABI.
> > 
> As I mentioned also in the commit description, the supply should match the
> actual hardware pin name. Otherwise it might create confusion. Usually vref
> refers to an external voltage reference pin used for ADC/DACs which is not
> exactly the case for this part, taking into account that there is no "reference"
> word mentioned in the datasheet at all. VREF and VDD are usually separate
> hardware pins. There is a hint indeed in the dts example that the vref-supply 
> might be referenced to a vdd regulator node, but from my point of view
> that is not enough. Moreover the current vref-supply is not handled at all in
> the driver, it is only mentioned in the dt-binding (That's why I added a second
> patch in the series handling the supply).
> 
> If the justification is not enough to apply this change, then I can keep only the
> second patch, which handles the regulator in the driver and use the  old `vref`
> naming which currently appears only in the dt-binding.
> 

That would have been a good argument when the property was introduced, but if
there are any systems with existing bindings out there they will use the old
name and fail after this change is applied.

I don't thnk it is mandated that every system in the world would publish their
devicetree bindings in the kernel. That would not scale. So any argument along
the line of "this binding is not used" is not really a valid argument.

Guenter
