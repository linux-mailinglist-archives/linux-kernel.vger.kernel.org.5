Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E0C7D382C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjJWNea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjJWNeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:34:25 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A447310A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:34:21 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40806e40fccso24269545e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 06:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698068060; x=1698672860; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ufOU/q/Ep1kAY17X99uhm7aprCNDlkkpHRrj3TivtTs=;
        b=sDrgsBPE4bZH4M/PKfy4fQVZVgIVp8rCzYqRM+ZnS7bqcF40tY2FyVgTLRDmGICji+
         gnXeF5b3difY7SUw0rJoX/AfumLTEYKR8uhgw6vWHVtWYliETIT25l6qf3O4b+oy3PKZ
         YNKVFnxYFVVpY3R80WZP6nKHg/5gOKOlYv1kUojlwVdRTBKwR0el+6GKUlUXIp+dzxUT
         wcigzZPhsroIZHW2ZgNwxsjNiVODQ+TyMwqp6eE3KM7vxG1WD7EwkXexfpjlKS8EVIpU
         f1qv4zivizP49ofivbaVDeBo0HCaF/xpIOB6llezMy+4D+OtzpgUgtyJF/FLPNWjY6yi
         LsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698068060; x=1698672860;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufOU/q/Ep1kAY17X99uhm7aprCNDlkkpHRrj3TivtTs=;
        b=ShGyNk/DRCFNPvC3UE7Fuk9HjHZgYCcVRw9gE940d0oepnNHcAiaerT3RSsz/dY3zE
         CHVC3lxbR5krbrUk8VLbd43+tgtSnrny0v5p0V8665LiU0QxcUxnRkD/WOMxniEoPtjT
         ZiuxEMZf1+Yw6NjXn4xuHjTAqsSMz5bm/CdeSvWHrJiA0IeZ055vPWL0JWeDuB4MPU8w
         K3mQ30Z6J2Z9VFo39/Uhz9j9ZFvCPH1XSfM8loxtbWbFG2HZWd/CqvEaqohcu0ZU5Ssr
         PHSCTQ7SDDWDx7jxuVT+vAjmHdh/JkDEbBtf/p331DnD8SKX7B8hevvFlkc5LyIi5m0H
         Adpw==
X-Gm-Message-State: AOJu0Yy5DgjQCy3sv7zJxQ5xb7p9bajYk8ZeWx11AwFXAF4d7Abu4eIA
        dRc/xjbe0DJSgDv0xjXDH5VMAQ==
X-Google-Smtp-Source: AGHT+IHwl+E4YFajmY7IWxRpWgtSmDl22RT8PM7nnOAmIYDUhgS2AbK4FuptOkLbmHVvg59kegsf/Q==
X-Received: by 2002:a05:600c:35c5:b0:405:4002:825a with SMTP id r5-20020a05600c35c500b004054002825amr7494266wmq.13.1698068059941;
        Mon, 23 Oct 2023 06:34:19 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c028100b004077219aed5sm14125564wmk.6.2023.10.23.06.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 06:34:19 -0700 (PDT)
Date:   Mon, 23 Oct 2023 14:34:17 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sean Young <sean@mess.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Support Opensource <support.opensource@diasemi.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 1/3] pwm: make it possible to apply pwm changes in
 atomic context
Message-ID: <20231023133417.GE49511@aspen.lan>
References: <cover.1697534024.git.sean@mess.org>
 <a7fcd19938d5422abc59c968ff7b3d5c275577ed.1697534024.git.sean@mess.org>
 <90728c06-4c6c-b3d2-4723-c24711be2fa5@redhat.com>
 <20231019105118.64gdzzixwqrztjir@pengutronix.de>
 <01a505ac-320f-3819-a58d-2b82c1bf2a86@redhat.com>
 <ZTT9fvEF+lqfzGJ/@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTT9fvEF+lqfzGJ/@gofer.mess.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 11:46:22AM +0100, Sean Young wrote:
> Hi Hans,
>
> On Sat, Oct 21, 2023 at 11:08:22AM +0200, Hans de Goede wrote:
> > On 10/19/23 12:51, Uwe Kleine-König wrote:
> > > On Wed, Oct 18, 2023 at 03:57:48PM +0200, Hans de Goede wrote:
> > >> On 10/17/23 11:17, Sean Young wrote:
> > > I think it's very subjective if you consider this
> > > churn or not.
> >
> > I consider it churn because I don't think adding a postfix
> > for what is the default/expected behavior is a good idea
> > (with GPIOs not sleeping is the expected behavior).
> >
> > I agree that this is very subjective and very much goes
> > into the territory of bikeshedding. So please consider
> > the above my 2 cents on this and lets leave it at that.
>
> You have a valid point. Let's focus on having descriptive function names.

For a couple of days I've been trying to resist the bikeshedding (esp.
given the changes to backlight are tiny) so I'll try to keep it as
brief as I can:

1. I dislike the do_it() and do_it_cansleep() pairing. It is
   difficult to detect when a client driver calls do_it() by mistake.
   In fact a latent bug of this nature can only be detected by runtime
   testing with the small number of PWMs that do not support
   configuration from an atomic context.

   In contrast do_it() and do_it_atomic()[*] means that although
   incorrectly calling do_it() from an atomic context can be pretty
   catastrophic it is also trivially detected (with any PWM driver)
   simply by running with CONFIG_DEBUG_ATOMIC_SLEEP.

   No objections (beyond churn) to fully spelt out pairings such as
   do_it_cansleep() and do_it_atomic()[*]!


2. If there is an API rename can we make sure the patch contains no
   other changes (e.g. don't introduce any new API in the same patch).
   Seperating renames makes the patches easier to review!
   It makes each one smaller and easier to review!


Daniel.


[*] or do_it_nosleep()... etc.
