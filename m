Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07247788507
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244418AbjHYKhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjHYKgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:36:51 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A149E;
        Fri, 25 Aug 2023 03:36:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ffa6e25ebbso2187926e87.0;
        Fri, 25 Aug 2023 03:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692959807; x=1693564607;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DloYDrlAPjHBtQ5CqlfZMjNs6m1+SYJwj5cpl36zLwQ=;
        b=ei79SIX8OFfQgxo70NKv/LkglmSZHnEB3gMhdUt8EpFFHExHms0MqZX1ac+SMwZD1U
         jDHoU/7HNadcyAmE/xRRqT42o57CIB6P8qxbP/nHZ4Spxo9h9iuDpqWjsDcufi5POlDP
         OhaqKO0HDbvpCTRvNOR8yp+aSNsKTIySgMwD7FIhwvTummnQ48tXlZu91ZewOX0groNY
         f0M/q0bNwYwj/s8/GXKB6rXlCzu3MUfSer8fy7Syirov81P6OJOw1GFVwMhGkyiPr6jO
         jqfXjlT32ZTTHfYmwrH2MJe6l+UGIpyCBv65TGOqZc0qv78SQSWKeh6mA+VyM5ZY7Iim
         Vaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692959807; x=1693564607;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DloYDrlAPjHBtQ5CqlfZMjNs6m1+SYJwj5cpl36zLwQ=;
        b=U6TKP0pvrrMwr7IdsH5QApc3ciJakoVfvyumUhPEI9dKi7ZeW/gf8hT1ZOSmKSdJwd
         luwaOXcIv08ytjL/+B0NAOcvsi8gqGt72D6ERs2xA1R5hEVbzA5f3rbqNNwIxtWP2mCC
         yDBCgL2xWi7M+5FdvfIHpnmYg2MjgPpwR2tfwaEbwKMNy8w/t2ZOcDw+9p4nBVXcqqBi
         CMHmnXooX45N7mdjoh+0C+LGaZ9KWtJQ51Xlhl9Vn436CEuZWZws9qG+JQiRpC8yOQok
         3DsO49WDRl2CagUX054gOys3GT54MenEX/+6GCXqHyMVMAh/S6IuVq8EJMcSSppwqeXb
         3scA==
X-Gm-Message-State: AOJu0YxJd/JgMBSAAu20aU7aiE44fouIBkqtX8ekmmLFrBvxVR9CvPak
        zq1BM9qYI4gvb2TRF4QNZ38=
X-Google-Smtp-Source: AGHT+IF9n8Ya5LmNToJAo6Vx7+DpINb1nRudSdPR/4QZCaOJMJvdIRV+oUODuETbBxY4P4S0F4qR4w==
X-Received: by 2002:a05:6512:4026:b0:4ff:839b:5355 with SMTP id br38-20020a056512402600b004ff839b5355mr6638684lfb.18.1692959806741;
        Fri, 25 Aug 2023 03:36:46 -0700 (PDT)
Received: from localhost ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
        by smtp.gmail.com with ESMTPSA id w14-20020ac2598e000000b004ff929df69asm236545lfn.271.2023.08.25.03.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 03:36:45 -0700 (PDT)
Date:   Fri, 25 Aug 2023 13:36:44 +0300
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Jarrah Gosbell <kernel@undef.tools>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] arm64: dts: pinephone: Add pstore support for
 PinePhone A64
Message-ID: <ZOiEPBtPpsygxRiM@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Jarrah Gosbell <kernel@undef.tools>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Pavel Machek <pavel@ucw.cz>
References: <20230821160817.GA2227@bug>
 <20230822092358.309835-1-andrej.skvortzov@gmail.com>
 <2235209.iZASKD2KPV@jernej-laptop>
 <20230824144952.5b908649@slackpad.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824144952.5b908649@slackpad.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On 23-08-24 14:50, Andre Przywara wrote:
> On Wed, 23 Aug 2023 21:36:51 +0200
> Jernej Škrabec <jernej.skrabec@gmail.com> wrote:
> 
> 
> Hi Andrey,
> 
> > send new revision as standalone e-mail, not as reply to old discussion.
> > 
> > Dne torek, 22. avgust 2023 ob 11:23:58 CEST je Andrey Skvortsov napisal(a):
> > > This patch reserves some memory in the DTS and sets up a
> > > pstore device tree node to enable pstore support.
> > > 
> > > In general any DRAM address, that isn't overwritten during a boot is
> > > suitable for pstore.
> > > 
> > > Range from 0x40000000 - 0x50000000 is heavily used by u-boot for
> > > internal use and to load kernel, fdt, fdto, scripts, pxefile and ramdisk
> > > later in the boot process. Ramdisk start address is 0x4FF00000,
> > > initramfs for kernel with some hacking features and debug info enabled
> > > can take more than 100Mb and final address will be around 0x58000000.
> > > Address 0x61000000 will most likely not overlap with that.  
> > 
> > There are other bootloaders as U-Boot, especially on PinePhone. Are you sure 
> > it works there too? What about U-Boot configuration, will those addresses still 
> > be used if configuration is changed?
> 
> Also going along with what Pavel said (that's it more a policy
> decision, not a device property), I feel like this node should be added
> by the bootloader then. And indeed U-Boot has support for that already.
> From skimming over the code in cmd/pstore.c: if you enable
> CONFIG_CMD_PSTORE and set CONFIG_CMD_PSTORE_MEM_ADDR to your chosen
> address, then the U-Boot code will insert a reserved memory node on the
> fly. Would that solve your problem?
>

I've tried pstore command in u-boot in the past to make sure it's
working there as well. I didn't know, that it adds reserved-memory
node as well. Thanks, Andre. That is very helpful.

I've tried it again without patching a kernel as you
suggested. Unfortunately it's not working on A64.

If there is no reserved-memory defined, u-boot adds a new one with
following properties:
    
    reserved-memory {
         #address-cells = <2>;
         #size-cells = <2>;
         ranges;
    }
    

But with these default address-cells and size-cells values, pstore
isn't working on A64. Root node for A64 defines 'address-cells' and 'size-cells' as 1.
    
dtc complains if reserved-memory has different address-cells and
size-cells.

```
     Warning (ranges_format): /reserved-memory:ranges: empty "ranges" property but its #address-cells (2) differs from / (1)
```

If empty reserved-memory is added to
arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi in the kernel, then
u-boot adds working pstore subnode.

```
       reserved-memory {
               #address-cells = <1>;
               #size-cells = <1>;
               ranges;

               /* bootloader will add new entries here
                * for example, for pstore.
                */
       };
```

It looks like a bug in u-boot for me. IMHO, it should look at
#address-cells/#size-cells of the root-node for default values. I have
tried that and this way pstore is working without any changes to the
kernel dts. What do you think? Should I submit fix to u-boot instead?

-- 
Best regards,
Andrey Skvortsov
