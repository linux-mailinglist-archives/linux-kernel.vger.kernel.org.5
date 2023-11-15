Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D5A7EC38D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 14:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343934AbjKONZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 08:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjKONZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 08:25:37 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF6E120;
        Wed, 15 Nov 2023 05:25:34 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-778925998cbso447128385a.0;
        Wed, 15 Nov 2023 05:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700054733; x=1700659533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vuQNx0saY2ItGRKdBl26Lb/Oz25BKx0ZaIePLBjp78=;
        b=lJTWNsPgkvArhJfx4mLzea66zYOPRDRqShORfizWt7bJwxyfZkIXlZoZpXiNpkYX7b
         Ie9VxfSoTJ8ISvgqoq4CKoF2O7hVN7TGbaw/AV1H8VDXX9Fxyi+hNyFdbfL+WqPFDQjq
         AsBN1/AY9K6AOugiCty/leyHi+zlF1Tax1husrlbiGg6nSG7l4+XjPyDk0XaMGx8HlxR
         C4HqEpQ4WmxM8mR08upTH/Q3Ox5ycJ8673wZ40j4YZFfVbhyrhtFwm7ddZznVH+0B8L8
         Pk0S9cghW+PejIMoLtKLY1HJvLRJde9RQf3NlOkpWOWhqeknqFoP49lMFOtTH7Jsritj
         DTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054733; x=1700659533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vuQNx0saY2ItGRKdBl26Lb/Oz25BKx0ZaIePLBjp78=;
        b=FUCzcEEjeMTfo1FOEnSEEBRA22fJG7nZNf+lKt7h7euSHz8Vrt2FlQuEPm5KHpqNlB
         pW/v44mI9udgtjtREu0IMIGXIMOwUrcoDALcIwr4MdOjo3m+gsL81ndVYa7FBKPnYokU
         T8voOwc9fcJ0W2y4Uu5YszLeMXyEKGAb7HxM6JAud3FzAoXaVUzFMl1fc7PnBZLSPbO4
         /Z+KMGWK5TDgBD40I2Ijsk46++iZH57VF78zzNp2IhdmfzVgUQFbbuV41s5OLG2o1kRS
         2gcV9xoUv61Pfs4P0PTzBXFA4Drh4VydVMmsNmvRqy/hGr5kzt47T6IElDl49M3Y5pox
         kiSQ==
X-Gm-Message-State: AOJu0Ywej8tnD8LOEx2BzpDxGk7FP1zvO92yRQv0/Iu02rCRHOA2yVXr
        58VbYV7zrC03zGpNqXppAI2zzSR3wkY=
X-Google-Smtp-Source: AGHT+IF4gKYfsnPTfy77RCqBJS3PI8cTib/dwl7HH/3rcJTzhH91a7+Qu0a6cI2q5Hc8xdw7+fnmIA==
X-Received: by 2002:a05:620a:4627:b0:767:923:48e7 with SMTP id br39-20020a05620a462700b00767092348e7mr6223765qkb.5.1700054733626;
        Wed, 15 Nov 2023 05:25:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id dp12-20020a05620a2b4c00b0076f0744ff50sm3433522qkb.136.2023.11.15.05.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:25:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 15 Nov 2023 05:25:31 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/4] hwmon: (core) Add support for humidity min/max
 alarm
Message-ID: <1ef7a10c-d9cf-4042-a198-f72dbdf9d05a@roeck-us.net>
References: <20231020-topic-chipcap2-v2-0-f5c325966fdb@gmail.com>
 <20231020-topic-chipcap2-v2-2-f5c325966fdb@gmail.com>
 <44f1eaa3-a90d-42cf-9808-4f39aacbf270@roeck-us.net>
 <25059951-ca50-4b19-8f74-5631b34c719b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25059951-ca50-4b19-8f74-5631b34c719b@gmail.com>
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

On Thu, Nov 09, 2023 at 07:24:00AM +0100, Javier Carrasco wrote:
> Hello,
> 
> On 09.11.23 01:02, Guenter Roeck wrote:
> > On 11/8/23 07:37, Javier Carrasco wrote:
> >> Add min_alarm and max_alarm attributes for humidityX to support devices
> >> that can generate these alarms.
> >> Such attributes already exist for other magnitudes such as tempX.
> >>
> >> Tested with a ChipCap 2 temperature-humidity sensor.
> >>
> > 
> > No objection, but the new attributes also need to be added to the ABI
> > documentation at
> > Documentation/ABI/testing/sysfs-class-hwmon and
> > Documentation/hwmon/sysfs-interface.rst
> > 
> > Which made me notice that humidityX_alarm isn't documented either.
> > Please document that attribute as well while you are at it.
> > 
> > Thanks,
> > Guenter
> > 
> Actually there are several attributes without ABI documentation or at
> least the attributes enum is much larger than the objects in the ABI
> documentation (in testing/sysfs-class-hwmon).
> For humidity there is only input, enable, rated_min and rated_max. Are
> some attributes not described for a good reason or should all be
> documented? the current humidity_attributes contains:
> 
> hwmon_humidity_enable -> documented in sysfs-class-hwmon
> hwmon_humidity_input -> documented in sysfs-class-hwmon
> hwmon_humidity_label
> hwmon_humidity_min
> hwmon_humidity_min_hyst
> hwmon_humidity_max
> hwmon_humidity_max_hyst
> hwmon_humidity_alarm
> hwmon_humidity_fault
> hwmon_humidity_rated_min -> documented in sysfs-class-hwmon
> hwmon_humidity_rated_max -> documented in sysfs-class-hwmon
> 
> I could not find the temperature counterparts of my new additions
> (temp_min_alarm and temp_max_alarm).
> 
> Should all be added to sysfs-class-hwmon or am I missing some other
> document? I am alright adding the ones I mentioned.
> 

They should all be documented. It would be great if you volunteer
to add the missing ones, but that won't be a mandate. I just don't want
the situation to get worse.

Thanks,
Guenter
