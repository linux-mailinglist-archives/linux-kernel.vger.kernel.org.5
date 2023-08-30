Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFB878D1C5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 03:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241595AbjH3BhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 21:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241581AbjH3BhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 21:37:05 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E7DCC5;
        Tue, 29 Aug 2023 18:37:00 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-76c64da0e46so173831639f.0;
        Tue, 29 Aug 2023 18:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693359420; x=1693964220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YcVzJ1hbhq9Ov/W8Ofp/tN+KBi3VQ+ExZZ65FircAyo=;
        b=G9571n01fbFDw1loYE6OJdVeeX0G7mqKNuwX+KdUfb447I3RxTdJURh5QEWRqTJ92q
         tf8NejmUmgnKgyGC9nlp9VCfgSm9s8wDq11KrUC8PGnT76JhtZEsbF+hg2Yn++TvNtjK
         pXXVu7jEYrSnph6IPqaqn2S36diKIat5kJm98pBMFdKJ+5nz/lzsCGYEKftTnET++rN8
         44XY4cjN8pzQZeY0agWxvQUqvs1K/HxD4oVbdzEagTeY1JpiUVAPcWdyOrC0F1sn3ESx
         8dLzwGTxoTbfryaIfAd6creENWYnOSZErWS3zZkcDnwzoMukkW+wcXrDxGJbkqtRhPSP
         zGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693359420; x=1693964220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcVzJ1hbhq9Ov/W8Ofp/tN+KBi3VQ+ExZZ65FircAyo=;
        b=AAw66sVdTPm0wcFKPpFW5v0EYA8RDyVS7PiJBrgNU5Vxpgx4whrG0V7fxo3F82j7RT
         GqyvqfzxMZScDAH/yjDyQmThpc6Xaky/a1ZiUjksAPaibIaFIUXAAEWCCkJxtfPYfIXA
         at31M6swYGPI94hGGv/TMufKAtMfav46M/RMluHEhE3WFp0wY8xPbUBOWw80kx2DHMeB
         KOvLC0Li/3GQyfQRLZaVaoPsQzK2rn3cEq76+dVXgladIJaShxQHWGjjw/KW4IPNH7wt
         odOera0qCvx+iB+QWuOjhkiYNQuQI2rwZ3GZ45bRP4op8qJ/WBflJ/oR/Tee5MO0dzpD
         lOMw==
X-Gm-Message-State: AOJu0YzgI9Pk0fVbVb7dvlmlw8gS92JxFS8Yzgld/B/bhCmuuQU151HU
        SZMyEMnjoHdebv8WrlqiZpY=
X-Google-Smtp-Source: AGHT+IFnKU9/P7PLg9OvuUJYiT+ycpH/CeV4Mv42jUxWMGaUeno1rEjvBEcEwsnP1QGLNTKQLXm95A==
X-Received: by 2002:a6b:d213:0:b0:792:70c2:9db1 with SMTP id q19-20020a6bd213000000b0079270c29db1mr889185iob.1.1693359419893;
        Tue, 29 Aug 2023 18:36:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z21-20020a6b0a15000000b0079187c8524asm3556839ioi.3.2023.08.29.18.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 18:36:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 29 Aug 2023 18:36:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Huibin Shi <henrys@silicom-usa.com>
Cc:     Henry Shi <henryshi2018@gmail.com>,
        "hbshi69@hotmail.com" <hbshi69@hotmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "hb_shi2003@yahoo.com" <hb_shi2003@yahoo.com>,
        Wen Wang <wenw@silicom-usa.com>
Subject: Re: [PATCH v5] Add Silicom Platform Driver
Message-ID: <b47b79c7-1ddc-4336-8bbc-f524872198ca@roeck-us.net>
References: <20230828212622.32485-1-henryshi2018@gmail.com>
 <15039461-6099-40a1-952f-fc31d65a0d3f@roeck-us.net>
 <PA4PR04MB92225C42CC763DCBA622C6579AE7A@PA4PR04MB9222.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB92225C42CC763DCBA622C6579AE7A@PA4PR04MB9222.eurprd04.prod.outlook.com>
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

On Tue, Aug 29, 2023 at 10:17:47PM +0000, Huibin Shi wrote:
> Hi Guenter,
> 
> Appreciate your feedback. Please see my comments below.
> 
> Thanks
> Henry
> 
> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Monday, August 28, 2023 8:41 PM
> To: Henry Shi <henryshi2018@gmail.com>
> Cc: hbshi69@hotmail.com; tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com; hdegoede@redhat.com; markgross@kernel.org; jdelvare@suse.com; linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-hwmon@vger.kernel.org; hb_shi2003@yahoo.com; Huibin Shi <henrys@silicom-usa.com>; Wen Wang <wenw@silicom-usa.com>
> Subject: Re: [PATCH v5] Add Silicom Platform Driver
> 
> Caution: This is an external email. Please take care when clicking links or opening attachments.
> 
> 
> On Mon, Aug 28, 2023 at 05:26:22PM -0400, Henry Shi wrote:
> > The Silicom platform (silicom-platform) Linux driver for Swisscom 
> > Business Box (Swisscom BB) as well as Cordoba family products is a 
> > software solution designed to facilitate the efficient management and 
> > control of devices through the integration of various Linux 
> > frameworks. This platform driver provides seamless support for device 
> > management via the Linux LED framework, GPIO framework, Hardware 
> > Monitoring (HWMON), and device attributes. The Silicom platform 
> > driver's compatibility with these Linux frameworks allows applications 
> > to access and control Cordoba family devices using existing software 
> > that is compatible with these frameworks. This compatibility 
> > simplifies the development process, reduces dependencies on 
> > proprietary solutions, and promotes interoperability with other 
> > Linux-based systems and software.
> >
> > Signed-off-by: Henry Shi <henryshi2018@gmail.com>
> 
> Again, my feedback is only for hwmon code.
> 
> [ ... ]
> 
> > +
> > +static int silicom_fan_control_read(struct device *dev,
> > +                                                                     enum hwmon_sensor_types type,
> > +                                                                     u32 attr, int channel,
> > +                                                                     
> > +long *val)
> 
> Excessively long continuation lines.
> That seeme to be the case for almost all continuation lines, except where it is too short. I'd suggest to run the patch through checkpatch --strict and fix what it reports.
> 
> total: 0 errors, 9 warnings, 18 checks, 1077 lines checked
> 
> is really a bit much.
> 
> Henry: OK, I will fix those warnings.
> 
> [ ... ]
> 
> > +
> > +     hwmon_dev = devm_hwmon_device_register_with_info(&device->dev, name, NULL,
> > +                             &silicom_chip_info, NULL);
> 
> Did you try to compile this with CONFIG_HWMON=n or with CONFIG_HWMON=m and SILICOM_PLATFORM=y ?
> 
> Henry: Great question. I did not try that before. When I force "CONFIG_HWMON=m and SILICOM_PLATFORM=y" and compile kernel, the build failed with message "silicom-platform.c:(.init.text+0x8ff5b): undefined reference to `devm_hwmon_device_register_with_info'". I tried following change in drivers/platform/x86/Kconfig:
> 
> config SILICOM_PLATFORM
> 	tristate "Silicom Edge Networking device support"
> 	depends on DMI
> 	select LEDS_CLASS_MULTICOLOR
> 	select GPIOLIB
> 	select HWMON  ----> added 

No, that is wrong. It needs to be "depends on HWMON",
or the hwmon code needs to be conditional and the dependency
must be something like "depends on HWMON || HWMON=n".

Guenter
