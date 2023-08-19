Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA338781A2D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 16:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjHSOgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 10:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjHSOgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 10:36:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B95721D5A;
        Sat, 19 Aug 2023 07:36:16 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf0b24d925so12888285ad.3;
        Sat, 19 Aug 2023 07:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692455776; x=1693060576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3eyhWYxowBeZ550XCHaK2XJ5PZyECo2MtKsWHHL3rU=;
        b=obkbU6gs/EuufRL1SbRTlTNpqPglfRTGOLS3bXz79NuI9pVc9Y53+uRMdrWLuvFI3q
         DGOif0BUmQcuSmCLw2Ea7Rq7fcQXeTGYfivHDhjXUoy1+uKGWGNLuZfepCWPKThNG047
         OaM3FmHR00KYYvHXCtxkgQbgNTHxaIMQnIwyXphsD2Cr9MFzR4BiDHdeWHtPrkLS/xdi
         X//r47yv9JWpUZD+bjewWPm1geeN9PlxnJ9S2bG5S0tH7DKCpF5Cbn493aRfg2bIgLzU
         N9rynyP/aqUv3gEXcp6HgP6TFBxYiiBrhJnbOVurN88dt85QsNTJqf0HVDzSvwzUR5Um
         TZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692455776; x=1693060576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3eyhWYxowBeZ550XCHaK2XJ5PZyECo2MtKsWHHL3rU=;
        b=alqDSuuFrPyD2nwvpMaEQEgmQmRjcPVUTpSqHZPJqvFrmQaNxrDydxfKg1oF1uetmt
         CVrkIHRxMVZCdf3AMOhMdqNLreIreFsxLyr7lhlx/Ardr3ci7BIRNXEfIHYUGGB4eCL4
         QbYGAcYJ0chyjYtimzy8Chac2MlyOZIKKDKYNImC+KiSaRU9rigN2scB0PfxJhV4Keyw
         jPj8MO36Gcl9ENuFnKa8Ub1E5Ooph+Mm/EEcvG1Ibes4572qLK3mq8h2zwWT91qx3Adk
         5g48194dZ1Xtoh98K246qM/29PCyHC7Wpq0IOoKP3gohAmbSw80GbnMExCChsMm8Embm
         vMcQ==
X-Gm-Message-State: AOJu0Yw5KiRqrP9ljCMUo/yCqmbgLSmf+ir+zC6vs5c/T2Flh+tU4Gvx
        20b1Qwet7aTv8hRER1wcjAg=
X-Google-Smtp-Source: AGHT+IFutKzo7Y89mFdefbjAUoyhptfe0oMw9nzC5zNJ9WY11Kj/8GbKdMTFwq6gE96Thh8ITFhEzg==
X-Received: by 2002:a17:903:1c4:b0:1bf:205f:c02c with SMTP id e4-20020a17090301c400b001bf205fc02cmr1868523plh.58.1692455775657;
        Sat, 19 Aug 2023 07:36:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902d90500b001a80ad9c599sm2027378plz.294.2023.08.19.07.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 07:36:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 19 Aug 2023 07:36:13 -0700
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
Message-ID: <7f537cef-d5cd-4816-a07b-9df27954ef93@roeck-us.net>
References: <20230818154341.20553-1-henryshi2018@gmail.com>
 <8b8b0503-8f8f-4615-97ab-11d2c0e1a960@roeck-us.net>
 <PA4PR04MB9222910BAC2754A073A70E609A18A@PA4PR04MB9222.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9222910BAC2754A073A70E609A18A@PA4PR04MB9222.eurprd04.prod.outlook.com>
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

On Sat, Aug 19, 2023 at 02:20:32PM +0000, Huibin Shi wrote:
> Hi Guenter,
> 
> Thanks for your comments. Probably, I should not resubmit patch too rushed. I will add version number to subject and change log in cover letter for next resubmission.
> 
> See my comments below. Please let me know whether you accept my explanation.
> 
> Henry
> -----Original Message-----
[ ... ]

> > +
> > +static u32 temp_get(void)
> > +{
> > +     u32 reg;
> > +
> > +     mutex_lock(&mec_io_mutex);
> > +     /* Select memory region */
> > +     outb(IO_REG_BANK, EC_ADDR_MSB);
> > +     outb(0xc, EC_ADDR_LSB);
> > +     /* Get current data from the address */
> > +     reg = inl(MEC_DATA(DEFAULT_CHAN_LO));
> > +     mutex_unlock(&mec_io_mutex);
> > +
> > +     return (reg >> 16) / 10;
> 
> The hwmon ABI expects temperatures to be reported in milli-degrees C.
> The above sets the maximum temperature to 65,535 / 10 = 6,553 milli-degrees or 6.553 degrees C. It is very unlikely that this is correct.
> 
> Again, I commented on this before.
> 
> Henry: this is due to an internal implementation of MIcor-controller firmware, instead of putting real temperature to the register, it put (real temperature * 10 ) to the register. So, in order to report correct temperature to user space application, the read value is divided by 10, then report to user space. 
> 
> Please let me know if you accept this. If not, I can change the code, but let user space application to do adjustment. 

No, I do not accept this. I do not believe that the maximum temperature
reported by the microcontroller is 6.553 degrees C. I suspect it reports
10th of degrees C. In that case, the number reported should be multiplied
by 100 to make it milli-degrees C as expected by the ABI.

[ ... ]

> > +static int silicom_fan_control_read_labels(struct device *dev, enum hwmon_sensor_types type,
> > +                                        u32 attr, int channel, const 
> > +char **str) {
> > +     switch (type) {
> > +     case hwmon_fan:
> > +             *str = "Fan Speed";
> > +             return 0;
> > +     case hwmon_temp:
> > +             *str = "Thermostat Sensor";
> > +             return 0;
> 
> Those labels have no practical value.
> 
> Henry: Those labels will be used by user space code to identify Silicom_platform driver. 
> 

The driver is identified by the driver name, not by the name of
a temperature sensor or fan speed attribute. Any other driver
could return "Fan Speed" or "Thermostat Sensor" here. Userspace
relying on such values to identify the driver are simply broken.

> > +     default:
> > +             return -EOPNOTSUPP;
> > +     }
> > +}
> > +
> > +static const struct hwmon_ops silicom_fan_control_hwmon_ops = {
> > +     .is_visible = silicom_fan_control_is_visible,
> > +     .read = silicom_fan_control_read,
> > +     .write = NULL,
> 
> Unnecessary.
> 
> Henry: OK, will be removed silicom_fan_control_is_visible.

The NULL pointer assignment is unnecessary. I have no idea
what that has to do with silicom_fan_control_is_visible(),
or why you would want to remove that function.

Guenter
