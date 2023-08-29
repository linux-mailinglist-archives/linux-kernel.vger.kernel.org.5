Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA0378BC55
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 03:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjH2BFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 21:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbjH2BFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 21:05:36 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0FA124;
        Mon, 28 Aug 2023 18:05:30 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-64cca551ae2so23605136d6.0;
        Mon, 28 Aug 2023 18:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693271129; x=1693875929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ebMk15Wy2Hcknjq8/rCjthr9YeXRWQepOOBN5+AmSXo=;
        b=TIMCIcAjVwg+Rf0mBT4JphIN2rVLNKa/5xWsAX/hepy5pkVIDSwBM0w8JdBd2m4dha
         BlegNlyivPMbmk4qrIhT3LPcmj5DyTnAcbT+x8kjPepO2wtGptd48DzuERvAP47yxKJP
         E/ZhQKG9rM4k9fYVI/HmbrceZvaHhVvD0MiDfkMzYbrx6sFWikYoyPBCgdP8wCFvrNh/
         U9hgyhzxMtrMFHiXwtg7xTOS2+8ed8RQAJAGm/JUe4j6e226aUNWfqchzzlK+lCQe/w4
         G1K44lJ+EWRjG/Pyhsk5Jf5CV0aMenkMFB2ZuGY3ynP3EV2BhvpRI57aiJFwySlxb7yo
         9L+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693271129; x=1693875929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebMk15Wy2Hcknjq8/rCjthr9YeXRWQepOOBN5+AmSXo=;
        b=etulLQUELPv+ih/ILuOyMkInqXxQML1hgq4S1LHOlapbqrBItgR7U/yN9oIAC7pw9p
         rX4RwCKhmw/JDe/OpOXFpvBH1IKcplSFKvQcv+z5+zvqDgNZp89Sf9Ya9IdtMidtt4vN
         1oleIkpJ7cqq+Xrj2Utn6+Amp3VIi9MmWel3SPDG1YM+7FoV0Uhuowrp7NyOfL1XdNJT
         S5sv/Oy8K2tSnt3LItQA5aqjWPZNBSmvYYjsipayIeHpwPdgkSroxPIhViZlqLQp4WrS
         nCBv2BXLUqCte+lcQNlx0ohv2t69ymRYiJQK/YnBeqGK0fd1EZGZ4PZeM7Rci9yEfoVC
         SpyQ==
X-Gm-Message-State: AOJu0YwHffmOT6GggmqkTky+lMIk6ntEQVlq4niNdecFpTbCGjryvfKr
        Wp90mhluB65Xr13nETlTLHu7g5VXGD7n0w==
X-Google-Smtp-Source: AGHT+IG5OrgDTjIrdtZ+2GwtL0kzj+0nPDaq9zVjJF0YFxh9K4+ZgY/soDOQdbaOR4/pGkayRvYjug==
X-Received: by 2002:ac8:5712:0:b0:410:487:27f3 with SMTP id 18-20020ac85712000000b00410048727f3mr34678412qtw.27.1693271129380;
        Mon, 28 Aug 2023 18:05:29 -0700 (PDT)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id kf6-20020a05622a2a8600b0040ff234b9c4sm2678678qtb.25.2023.08.28.18.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 18:05:28 -0700 (PDT)
Date:   Mon, 28 Aug 2023 21:05:18 -0400
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        abdelalkuor@geotab.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        ryanmacdonald@geotab.com
Subject: Re: [PATCH v4 0/2] Add support for TPS25750
Message-ID: <ZO1ETjtuKr3wImn1@abdel>
References: <cover.1692559293.git.alkuor@gmail.com>
 <ZOWvG1MQw37IOHcM@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOWvG1MQw37IOHcM@kuha.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 10:02:51AM +0300, Heikki Krogerus wrote:
> On Sun, Aug 20, 2023 at 03:32:25PM -0400, Abdel Alkuor wrote:
> > TPS25750 is USB Type-C and PD controller. The device is
> > highly configurable using App Customization online Tool 
> > developed by TI to generate loadable binary.
> > 
> > TPS25750 supports three modes; PTCH, APP, and BOOT. A configuration
> > can only be applied when the controller is on PTCH mode.
> > 
> > The controller attempts to load a configuration from EEPROM on
> > I2Cm bus. If no EEPROM is detected, then the driver tries to load
> > a configuration on I2Cs bus using a firmware file defined
> > in DT.
> > 
> > The driver implements the binary loading sequence which 
> > can be found on pg.53 in TPS25750 Host Interface Technical
> > Reference Manual (Rev. A) https://tinyurl.com/y9rkhu8a
> > 
> > The driver only supports resume pm callback as power management is
> > automatically controlled by the device. See pg.47 in TPS25750
> > datasheet https://tinyurl.com/3vfd2k43
> > 
> > v4:
> >  - PATCH 1: No change
> >  - PATCH 2: Fix comments style and drop of_match_ptr
> > v3:
> >  - PATCH 1: Fix node name
> >  - PATCH 2: Upload tps25750 driver patch
> > v2:
> >  - PATCH 1: General properties clean up
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > Abdel Alkuor (2):
> >   dt-bindings: usb: Add ti,tps25750
> >   USB: typec: Add TI TPS25750 USB Type-C controller
> > 
> >  .../devicetree/bindings/usb/ti,tps25750.yaml  |   81 ++
> >  drivers/usb/typec/Kconfig                     |   13 +
> >  drivers/usb/typec/Makefile                    |    1 +
> >  drivers/usb/typec/tps25750.c                  | 1077 +++++++++++++++++
> >  drivers/usb/typec/tps25750.h                  |  162 +++
> >  5 files changed, 1334 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/ti,tps25750.yaml
> >  create mode 100644 drivers/usb/typec/tps25750.c
> >  create mode 100644 drivers/usb/typec/tps25750.h
Hi Heikki,
> 
> TPS25750 has the same host interface as TI TPS65xxx controllers, no?
> The register offsets at least are exactly the same.
Correct, the register offsets are the same. That being said, TPS25750 is a 
subset of TPS6598x where some registers are structured differently, and even some
registers are not supported. Hence, Each has its own host interface manual.
> 
> You need to first try to incorporate support for TI25750 support into
> the existing tipd driver (drivers/usb/typec/tipd/).
>
Incorporating TPS25750 into TPS6598x driver is doable which requires the
following changes:

- Only Check VID register (0x00) for TPS6598x and cd321x, as TPS25750 doesn't
  have VID register.

- TypeC port registration will be registered differently for each PD
  controller. TPS6598x uses system configuration register (0x28) to get
  pr/dr capabilities. On the other hand, TPS25750 will use data role property
  and PD status register (0x40) to get pr/dr capabilities as TPS25750 doesn't
  have register 0x28 supported.

- TPS25750 requires writing a binary configuration to switch PD
  controller from PTCH mode to APP mode which needs the following changes: 
  - Add PTCH mode to the modes list.
  - Add an argument to tps6598x_check_mode to return the current mode.
  - Currently, tps6598x_exec_cmd has cmd timeout hardcoded to 1 second,
    and doesn't wait before checking DATA_OUT response. In TPS25750, patch 4CCs
    take longer than 1 second to execute and some requires a delay before
    checking DATA_OUT. To accommodate that, cmd_timeout and response_delay will
    be added as arguments to tps6598x_exec_cmd.
  - Implement applying patch sequence for TPS25750.

- In pm suspend callback, patch mode needs to be checked and the binary 
  configuration should be applied if needed.

- For interrupt, TPS25750 has only one event register (0x14) and one mask
  register (0x16) of 11 bytes each, where TPS6598x has two event
  and two mask registers of 8 bytes each. Both TPS25750 and TPS65986x
  shares the same bit field offsets for events/masks/clear but many of
  there fields are reserved in TPS25750, the followings need to be done in 
  tps6598x_interrupt:
  - Read EVENT1 register as a block of 11 bytes when tps25750 is present
  - Write CLEAR1 register as a block of 11 bytes when tps25750 is present
  - Add trace_tps25750_irq
  - During testing, I noticed that when a cable is plugged into the PD
    controller and before PD controller switches to APP mode, there is a
    lag between dr/pr updates and PlugInsertOrRemoval Event, so a check
    for dr/pr change needs to be added along TPS_REG_INT_PLUG_EVENT check

- Add TPS25750 traces for status and power status registers. Trace for
  data register won't be added as it doesn't exist in the device.

- Configure sleep mode for TPS25750.

Before writing the binary configuration, PBMs command is used to set
up the patch bundle which consists of binary length, timeout, and
slave address. The slave address is not the device I2C address, the
bundle slave address can be any value except the ones that are listed
for possible device addresses which are 0x20, 0x21, 0x22, and 0x23 based
on pg.44 in https://www.ti.com/lit/ds/symlink/tps25750.pdf.
Currently, I'm using 0x0F for the bundle slave address which I think
is not the right way of assigning such address as a conflict may arise
when there is another device with 0x0F address is present on the same
I2C bus. 

Should the bundle address be set as property in the device node? Or
should we use i2c_probe_func_quick_read to scan the bus and find an
available address that is not used?

Thanks,
Abdel
