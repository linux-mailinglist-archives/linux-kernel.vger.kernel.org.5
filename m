Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E86C782DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbjHUQJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbjHUQJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:09:13 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3760113;
        Mon, 21 Aug 2023 09:09:08 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bf7423ef3eso7520985ad.3;
        Mon, 21 Aug 2023 09:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692634148; x=1693238948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4YPhBhbkeJXRl8/+PVtRKWaqwE1QR1R3FATdc2dNh8=;
        b=WKKevl7mdfLah0BqTHk5rx1sgI6wOssbr5onffid3tM4D3tx/MmDEKSABKw9VKSHjM
         0VZcnREkeHq3yjsk0JkYDPR25I+tE+YNjWGGTAJddHjbzc+2PWUTQss/5I2nh4fq1rm8
         k3HNoolEQ2jQwHnjdJ5r6ElJSsQ6LnH7ls6D8UJy9+Wfe/2gZid4vuP47njpkNGWWrfv
         LFcwAaMRgc2WQkZQaQ92Ki6KqZBZkoNKUOBxidopw/+wn0uBpChVMjLoYdTdyhaZQ2mU
         M2NaJ35tZKazdYzS7mVq5SA89hF2gmLn1jKLzQnEb7EBrKUqzqYg1+y8Z8zK2B5K4MZv
         vaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692634148; x=1693238948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4YPhBhbkeJXRl8/+PVtRKWaqwE1QR1R3FATdc2dNh8=;
        b=F0V2LGCI9k8mKuemhmSKqLhDNcHh2Tcs+ihkT/2FUvJ1BMEl4GQv9ePsRHdGp6vcnC
         rj3E2XqoVCNP0YtDHTq/4qKLHGiqbJDRkjLnkmOVfnjOsQwkAMEW/QZo8HTOrLXdAGw8
         7DL0QTws1ilvZ5VG80149TXwbE2djvv3tfvG1F48BqlbtsUvI2mcuP2naACS6mBbsgR/
         TcStZgtbhx+DWysuIfxDUCElvbZZxq0FmsKOhNy2z8bKCyxOAT0dk0H+1vuXnrugTQ7i
         iBA9Ext0VJMhV2eAOFUjRlcmE7hpD2vC020TcqxllrGPqXrZPbBMQt5FSojyqRsW6lfN
         tL5Q==
X-Gm-Message-State: AOJu0Yy+VcNBz4spz6OpngA8EFDioKjwXPovmXWCAyjbbGAgdQz9Qr9B
        A9kdbpeJl/4zNmNflEEV2RM=
X-Google-Smtp-Source: AGHT+IFMTK9I2PPRletulwnBQa4mvExHRjg43rsaYXCxtErrOeRkkxYP0OejXplpIQ03WnhZadcc6A==
X-Received: by 2002:a17:903:234a:b0:1c0:8a05:f356 with SMTP id c10-20020a170903234a00b001c08a05f356mr713290plh.54.1692634148062;
        Mon, 21 Aug 2023 09:09:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jg5-20020a17090326c500b001bc445e2497sm7286979plb.79.2023.08.21.09.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 09:09:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 21 Aug 2023 09:09:06 -0700
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
Subject: Re: [PATCH] Add Silicom Platform Driver
Message-ID: <b0ad739c-7c96-4603-87aa-94fbce220ec8@roeck-us.net>
References: <20230818154341.20553-1-henryshi2018@gmail.com>
 <8b8b0503-8f8f-4615-97ab-11d2c0e1a960@roeck-us.net>
 <PA4PR04MB9222910BAC2754A073A70E609A18A@PA4PR04MB9222.eurprd04.prod.outlook.com>
 <7f537cef-d5cd-4816-a07b-9df27954ef93@roeck-us.net>
 <PA4PR04MB9222CA6111C291AE1C7D1B3D9A1EA@PA4PR04MB9222.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9222CA6111C291AE1C7D1B3D9A1EA@PA4PR04MB9222.eurprd04.prod.outlook.com>
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

On Mon, Aug 21, 2023 at 03:48:33PM +0000, Huibin Shi wrote:
> Guenter,
> 
> See my comments below.
> 
> Thanks
> Henry
> 
> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Saturday, August 19, 2023 10:36 AM
> To: Huibin Shi <henrys@silicom-usa.com>
> Cc: Henry Shi <henryshi2018@gmail.com>; hbshi69@hotmail.com; tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; dave.hansen@linux.intel.com; x86@kernel.org; hpa@zytor.com; hdegoede@redhat.com; markgross@kernel.org; jdelvare@suse.com; linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; linux-hwmon@vger.kernel.org; hb_shi2003@yahoo.com; Wen Wang <wenw@silicom-usa.com>
> Subject: Re: [PATCH] Add Silicom Platform Driver
> 
> Caution: This is an external email. Please take care when clicking links or opening attachments.
> 
> 
> On Sat, Aug 19, 2023 at 02:20:32PM +0000, Huibin Shi wrote:
> > Hi Guenter,
> >
> > Thanks for your comments. Probably, I should not resubmit patch too rushed. I will add version number to subject and change log in cover letter for next resubmission.
> >
> > See my comments below. Please let me know whether you accept my explanation.
> >
> > Henry
> > -----Original Message-----
> [ ... ]
> 
> > > +
> > > +static u32 temp_get(void)
> > > +{
> > > +     u32 reg;
> > > +
> > > +     mutex_lock(&mec_io_mutex);
> > > +     /* Select memory region */
> > > +     outb(IO_REG_BANK, EC_ADDR_MSB);
> > > +     outb(0xc, EC_ADDR_LSB);
> > > +     /* Get current data from the address */
> > > +     reg = inl(MEC_DATA(DEFAULT_CHAN_LO));
> > > +     mutex_unlock(&mec_io_mutex);
> > > +
> > > +     return (reg >> 16) / 10;
> >
> > The hwmon ABI expects temperatures to be reported in milli-degrees C.
> > The above sets the maximum temperature to 65,535 / 10 = 6,553 milli-degrees or 6.553 degrees C. It is very unlikely that this is correct.
> >
> > Again, I commented on this before.
> >
> > Henry: this is due to an internal implementation of MIcor-controller firmware, instead of putting real temperature to the register, it put (real temperature * 10 ) to the register. So, in order to report correct temperature to user space application, the read value is divided by 10, then report to user space.
> >
> > Please let me know if you accept this. If not, I can change the code, but let user space application to do adjustment.
> 
> No, I do not accept this. I do not believe that the maximum temperature reported by the microcontroller is 6.553 degrees C. I suspect it reports 10th of degrees C. In that case, the number reported should be multiplied by 100 to make it milli-degrees C as expected by the ABI.
> 
> Henry: OK, I will remove "/10" in driver, and let user space application (or script) to the calculation.
> 

Sorry, I completely fail to understand why you refuse to follow the ABI.
The temperature must be reported in milli-degrees C, not in some arbitrary
unit, period.

FWIW, that really deserves a NACK now.

Guenter
