Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB2F80B5DC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 19:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjLISVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 13:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLISV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 13:21:29 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0385DE1;
        Sat,  9 Dec 2023 10:21:35 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso4479176a12.3;
        Sat, 09 Dec 2023 10:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702146093; x=1702750893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gLNpODQhsbffwfVK0H46y0Kl5VvUcYrmGC1lnrr3gSM=;
        b=l7xk7dfaeSs2MCYC6dea/WCxFoXPof2sTaZYhvMlZdFNTIIR47kA869QBfzu6fWRkO
         hkKd1QtMWcdLDdj88cz194FZ3RJI3lQsXGfDod2T4bJS5j3ayFcHWKbSpvuz3NtXqqEj
         sGojKgj0EkajvhidcXxhUMjhmXRTr4XGeW110Vmc9uuFlGWSvcFPfiSOkcPsqUYt9Ozr
         g1Ar8nAekt8JiAaCFd4OKb43ZyPa5eLM4Y+H1t1HnXI7ZCyeEwzqvMhMUVzJq5FkqB1S
         FFWwENmZgu0thnWhhntfyN2mBnHiqe2k7zUICIuzTd79yxLPyHwf4TKmv21KSfzrX49r
         iG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702146093; x=1702750893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLNpODQhsbffwfVK0H46y0Kl5VvUcYrmGC1lnrr3gSM=;
        b=pT+80KZAOHxTvQnPusSYMn3co1+tYk4Ajahc6eMX6ic7+WUhgxVX1xQJ67HiaKWTlc
         zYajvp8B68n+8zYQYfHR+HjmZEuIIYvp5wTaLbhJTDpF2VkdVQR6o5Je1/GaR3nhKqBq
         6doGUnWMTVA9+lNBRVMB102QkJai+UZmcalGOZd2puGqWz6GK+/EKq0jzYhFc+5p9eZ5
         wRthRr386xBADCNutGQSzgQPXsEcPxMI1XLUB1kygcMAOkEzcZqdEEf81MEuK/OekL67
         72PSx7KfjLHRaJpLmgpbkeHLhxgLEZoWrDlU6+uJi64VAzzgreNBBQcXfeN6pKHKL2rD
         yglg==
X-Gm-Message-State: AOJu0YxC5GuFwsde24oZFrkMB3ccdxuU6IA3XZC30zB7NOgnheur9uqT
        W4JlLi0S+ZNpXoDafIGZZChsLRoEDJw=
X-Google-Smtp-Source: AGHT+IH+bySArn2Haq5pFCbq0Za/Y6yj1x90D80RuBMXSS477lqJcuD8dYdWUZ+SMHXQrAGtvPnOZw==
X-Received: by 2002:a17:907:350e:b0:a1f:705b:3de7 with SMTP id zz14-20020a170907350e00b00a1f705b3de7mr787354ejb.140.1702146093147;
        Sat, 09 Dec 2023 10:21:33 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id sf22-20020a1709078a9600b00a1ca020cdfasm2463383ejc.161.2023.12.09.10.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 10:21:32 -0800 (PST)
Date:   Sat, 9 Dec 2023 20:21:32 +0200
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Mikhail Khvainitski <me@khvoinitsky.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        ValdikSS <iam@valdikss.org.ru>
Subject: Re: [PATCH] HID: lenovo: Detect quirk-free fw on cptkbd and stop
 applying workaround
Message-ID: <20231209182132.i3saw7kcjyykhizu@jekhomev>
References: <20230918145042.37368-1-me@khvoinitsky.org>
 <20230923231522.94060-1-me@khvoinitsky.org>
 <20230923231522.94060-2-me@khvoinitsky.org>
 <ZXRiiPsBKNasioqH@jekhomev>
 <20231209165648.4rfe4gxubaajrl2z@jekhomev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209165648.4rfe4gxubaajrl2z@jekhomev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 06:56:48PM +0200, Yauhen Kharuzhy wrote:
> On Sat, Dec 09, 2023 at 02:50:16PM +0200, Yauhen Kharuzhy wrote:
> > On Sun, Sep 24, 2023 at 01:58:30AM +0300, Mikhail Khvainitski wrote:
> > > Built-in firmware of cptkbd handles scrolling by itself (when middle
> > > button is pressed) but with issues: it does not support horizontal and
> > > hi-res scrolling and upon middle button release it sends middle button
> > > click even if there was a scrolling event. Commit 3cb5ff0220e3 ("HID:
> > > lenovo: Hide middle-button press until release") workarounds last
> > > issue but it's impossible to workaround scrolling-related issues
> > > without firmware modification.
> > > 
> > > Likely, Dennis Schneider has reverse engineered the firmware and
> > > provided an instruction on how to patch it [1]. However,
> > > aforementioned workaround prevents userspace (libinput) from knowing
> > > exact moment when middle button has been pressed down and performing
> > > "On-Button scrolling". This commit detects correctly-behaving patched
> > > firmware if cursor movement events has been received during middle
> > > button being pressed and stops applying workaround for this device.
> > > 
> > > Link: https://hohlerde.org/rauch/en/elektronik/projekte/tpkbd-fix/ [1]
> > 
> > This patch breaks a scrolling at my ThinkPad TrackPoint Keyboard II: it
> > starts to report middle-button push/release events with scrolling events
> > between. A support for this keyboard was added in
> > 24401f291dcc4f2c18b9e2f65763cbaadc7a1528 "HID: lenovo: Add support for
> > ThinkPad TrackPoint Keyboard II" commit.
> 
> I figured this out.
> 
> This keyboard can emit REL_Y/REL_X events between of middle-button
> events (if user was moving a cursor and press middle button without of
> stopping this), so this algorithm does a false-positive detection and switches
> the workaround off like for patched firmware:
> 
> Event: time 1702140625.854777, type 2 (EV_REL), code 1 (REL_Y), value 2
> Event: time 1702140625.854777, -------------- SYN_REPORT ------------
> Event: time 1702140625.870769, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 1
> Event: time 1702140625.870769, -------------- SYN_REPORT ------------
> Event: time 1702140625.870771, type 2 (EV_REL), code 1 (REL_Y), value 2
> Event: time 1702140625.870771, -------------- SYN_REPORT ------------
> Event: time 1702140625.970780, type 2 (EV_REL), code 8 (REL_WHEEL), value -1
> Event: time 1702140625.970780, -------------- SYN_REPORT ------------
> Event: time 1702140626.058800, type 2 (EV_REL), code 8 (REL_WHEEL), value -1
> Event: time 1702140626.058800, -------------- SYN_REPORT ------------
> Event: time 1702140630.462974, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
> Event: time 1702140630.462974, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 0
> Event: time 1702140630.462974, -------------- SYN_REPORT ------------

Maybe we should map the wheel HID reports to REL_Y/REL_X in
lenovo_input_mapping_tpIIkbd() to allow libinput to do its wheel emulation job?
I tried this but I am not familiar with HID drivers and had no success.


> 
> 
> > 
> > There is an evtest output below:
> > 
> > Without of commit:
> > 
> > Middle-button click:
> > Event: time 1702122290.593300, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 1
> > Event: time 1702122290.593300, -------------- SYN_REPORT ------------
> > Event: time 1702122290.593312, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 0
> > Event: time 1702122290.593312, -------------- SYN_REPORT ------------
> > 
> > Vertical scrolling:
> > Event: time 1702122300.441627, type 2 (EV_REL), code 8 (REL_WHEEL), value -1
> > Event: time 1702122300.441627, -------------- SYN_REPORT ------------
> > Event: time 1702122300.565663, type 2 (EV_REL), code 8 (REL_WHEEL), value -1
> > Event: time 1702122300.565663, -------------- SYN_REPORT ------------
> > 
> > Horizontal scrolling:
> > Event: time 1702122307.845969, type 2 (EV_REL), code 6 (REL_HWHEEL), value -1
> > Event: time 1702122307.845969, -------------- SYN_REPORT ------------
> > Event: time 1702122307.981954, type 2 (EV_REL), code 6 (REL_HWHEEL), value -1
> > Event: time 1702122307.981954, -------------- SYN_REPORT ------------
> > 
> > 
> > 
> > After commit:
> > 
> > Middle-button click:
> > Event: time 1702125091.290045, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
> > Event: time 1702125091.290045, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 1
> > Event: time 1702125091.290045, -------------- SYN_REPORT ------------
> > Event: time 1702125092.626118, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
> > Event: time 1702125092.626118, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 0
> > Event: time 1702125092.626118, -------------- SYN_REPORT ------------
> > 
> > 
> > Vscroll:
> > Event: time 1702125286.653639, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
> > Event: time 1702125286.653639, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 1
> > Event: time 1702125286.653639, -------------- SYN_REPORT ------------
> > Event: time 1702125287.929689, type 2 (EV_REL), code 8 (REL_WHEEL), value -1
> > Event: time 1702125287.929689, -------------- SYN_REPORT ------------
> > Event: time 1702125288.037688, type 2 (EV_REL), code 8 (REL_WHEEL), value -1
> > Event: time 1702125288.037688, -------------- SYN_REPORT ------------
> > Event: time 1702125290.481787, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
> > Event: time 1702125290.481787, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 0
> > Event: time 1702125290.481787, -------------- SYN_REPORT ------------
> > 
> > Hscroll:
> > Event: time 1702125293.841920, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
> > Event: time 1702125293.841920, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 1
> > Event: time 1702125293.841920, -------------- SYN_REPORT ------------
> > Event: time 1702125294.761952, type 2 (EV_REL), code 6 (REL_HWHEEL), value -1
> > Event: time 1702125294.761952, -------------- SYN_REPORT ------------
> > Event: time 1702125294.893967, type 2 (EV_REL), code 6 (REL_HWHEEL), value -1
> > Event: time 1702125294.893967, -------------- SYN_REPORT ------------
> > Event: time 1702125296.134006, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
> > Event: time 1702125296.134006, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 0
> > Event: time 1702125296.134006, -------------- SYN_REPORT ------------
> 
> -- 
> Yauhen Kharuzhy

-- 
Yauhen Kharuzhy
