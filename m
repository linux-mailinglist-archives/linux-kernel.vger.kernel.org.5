Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F7580B54E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 17:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjLIQ4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 11:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIQ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 11:56:45 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C440F10D0;
        Sat,  9 Dec 2023 08:56:51 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54bf9a54fe3so4362939a12.3;
        Sat, 09 Dec 2023 08:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702141010; x=1702745810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RrZeShfQsr5Zblcz+ciNubf9EBG3Vd49YeN/6rA6zLY=;
        b=VpjUaaAYRghqn8ShxCWUQF2A4sIYUUtctF5nZI1PQq3w1v5dkm1pU1pCCXZDxys5ix
         93BOQO0umotoUzP0/pgGblUtcQKshCJGkrCkv/kJwJU5InqAkhhch7rQt4lSz5Wps75c
         4jpmHK/qEs+5U44uNasRUIJQOQZ4W2Rgx9eqbHa8bY5UNVCJS2NCvxtNlPJ9P/DGRPNT
         N6UaPyDlCOE4bt0PWE7SlksPiSrzqY1txVbSN2wVd2K5+g43b3izroUFcnRunNa1X2yT
         cSflZ2jR749ZRmAFNS1MNUWb8Uv8KewUvdynoX4O/lmrASSTNKvxnG+9ziWTMyUTMLlo
         EpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702141010; x=1702745810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrZeShfQsr5Zblcz+ciNubf9EBG3Vd49YeN/6rA6zLY=;
        b=kzy/lI0skUbm57+P3paqiFpObT71ZucQXuqHeOe8X1Oa56wl3Ts4/wfzoRhtDYyxub
         9s63HwZw3eoaLyB0f0sv/M7dEaXJkyg8Xh0DTYs6UpyRsviPRAwKAuf0aKomot/Xln9E
         uQCqG6WNuvOivEmG8XHAVCFQuHXZwek45i8+A3FaXqWcqFzQgpYxcYh1+V+cr3XaB8EM
         q99JDSNKSClMsIj/P4IRG+uSV/IWDb2SRYKUe5AGK8v6/7mK3MSQaKVS/39aeKaL8eMe
         8gA3TKYY9eKaLfM5VDT3BxC8g/5LiETGeDWv6p+1GYjQ4TNcS0wZe3YA9l8FUublJZ73
         Srng==
X-Gm-Message-State: AOJu0YwJoXItk/YlW2tG20q5FuHcls0O+0fFGZkUH/6QxIkM8VzKgcob
        MFgeXMqGpqQ2pWEdrpDxTyvLt45iNeM=
X-Google-Smtp-Source: AGHT+IGBVbX2g8Tflx252g725MkQPcMQS3na6cE7fBauNq3+oB4zb8pQn9MDqWdldsolY5tXbvb0Dw==
X-Received: by 2002:a17:907:c715:b0:a1d:551f:a197 with SMTP id ty21-20020a170907c71500b00a1d551fa197mr1030668ejc.82.1702141009970;
        Sat, 09 Dec 2023 08:56:49 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id tx18-20020a1709078e9200b00a1b618766cbsm2428271ejc.136.2023.12.09.08.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 08:56:49 -0800 (PST)
Date:   Sat, 9 Dec 2023 18:56:48 +0200
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Mikhail Khvainitski <me@khvoinitsky.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        ValdikSS <iam@valdikss.org.ru>
Subject: Re: [PATCH] HID: lenovo: Detect quirk-free fw on cptkbd and stop
 applying workaround
Message-ID: <20231209165648.4rfe4gxubaajrl2z@jekhomev>
References: <20230918145042.37368-1-me@khvoinitsky.org>
 <20230923231522.94060-1-me@khvoinitsky.org>
 <20230923231522.94060-2-me@khvoinitsky.org>
 <ZXRiiPsBKNasioqH@jekhomev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXRiiPsBKNasioqH@jekhomev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 02:50:16PM +0200, Yauhen Kharuzhy wrote:
> On Sun, Sep 24, 2023 at 01:58:30AM +0300, Mikhail Khvainitski wrote:
> > Built-in firmware of cptkbd handles scrolling by itself (when middle
> > button is pressed) but with issues: it does not support horizontal and
> > hi-res scrolling and upon middle button release it sends middle button
> > click even if there was a scrolling event. Commit 3cb5ff0220e3 ("HID:
> > lenovo: Hide middle-button press until release") workarounds last
> > issue but it's impossible to workaround scrolling-related issues
> > without firmware modification.
> > 
> > Likely, Dennis Schneider has reverse engineered the firmware and
> > provided an instruction on how to patch it [1]. However,
> > aforementioned workaround prevents userspace (libinput) from knowing
> > exact moment when middle button has been pressed down and performing
> > "On-Button scrolling". This commit detects correctly-behaving patched
> > firmware if cursor movement events has been received during middle
> > button being pressed and stops applying workaround for this device.
> > 
> > Link: https://hohlerde.org/rauch/en/elektronik/projekte/tpkbd-fix/ [1]
> 
> This patch breaks a scrolling at my ThinkPad TrackPoint Keyboard II: it
> starts to report middle-button push/release events with scrolling events
> between. A support for this keyboard was added in
> 24401f291dcc4f2c18b9e2f65763cbaadc7a1528 "HID: lenovo: Add support for
> ThinkPad TrackPoint Keyboard II" commit.

I figured this out.

This keyboard can emit REL_Y/REL_X events between of middle-button
events (if user was moving a cursor and press middle button without of
stopping this), so this algorithm does a false-positive detection and switches
the workaround off like for patched firmware:

Event: time 1702140625.854777, type 2 (EV_REL), code 1 (REL_Y), value 2
Event: time 1702140625.854777, -------------- SYN_REPORT ------------
Event: time 1702140625.870769, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 1
Event: time 1702140625.870769, -------------- SYN_REPORT ------------
Event: time 1702140625.870771, type 2 (EV_REL), code 1 (REL_Y), value 2
Event: time 1702140625.870771, -------------- SYN_REPORT ------------
Event: time 1702140625.970780, type 2 (EV_REL), code 8 (REL_WHEEL), value -1
Event: time 1702140625.970780, -------------- SYN_REPORT ------------
Event: time 1702140626.058800, type 2 (EV_REL), code 8 (REL_WHEEL), value -1
Event: time 1702140626.058800, -------------- SYN_REPORT ------------
Event: time 1702140630.462974, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
Event: time 1702140630.462974, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 0
Event: time 1702140630.462974, -------------- SYN_REPORT ------------


> 
> There is an evtest output below:
> 
> Without of commit:
> 
> Middle-button click:
> Event: time 1702122290.593300, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 1
> Event: time 1702122290.593300, -------------- SYN_REPORT ------------
> Event: time 1702122290.593312, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 0
> Event: time 1702122290.593312, -------------- SYN_REPORT ------------
> 
> Vertical scrolling:
> Event: time 1702122300.441627, type 2 (EV_REL), code 8 (REL_WHEEL), value -1
> Event: time 1702122300.441627, -------------- SYN_REPORT ------------
> Event: time 1702122300.565663, type 2 (EV_REL), code 8 (REL_WHEEL), value -1
> Event: time 1702122300.565663, -------------- SYN_REPORT ------------
> 
> Horizontal scrolling:
> Event: time 1702122307.845969, type 2 (EV_REL), code 6 (REL_HWHEEL), value -1
> Event: time 1702122307.845969, -------------- SYN_REPORT ------------
> Event: time 1702122307.981954, type 2 (EV_REL), code 6 (REL_HWHEEL), value -1
> Event: time 1702122307.981954, -------------- SYN_REPORT ------------
> 
> 
> 
> After commit:
> 
> Middle-button click:
> Event: time 1702125091.290045, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
> Event: time 1702125091.290045, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 1
> Event: time 1702125091.290045, -------------- SYN_REPORT ------------
> Event: time 1702125092.626118, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
> Event: time 1702125092.626118, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 0
> Event: time 1702125092.626118, -------------- SYN_REPORT ------------
> 
> 
> Vscroll:
> Event: time 1702125286.653639, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
> Event: time 1702125286.653639, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 1
> Event: time 1702125286.653639, -------------- SYN_REPORT ------------
> Event: time 1702125287.929689, type 2 (EV_REL), code 8 (REL_WHEEL), value -1
> Event: time 1702125287.929689, -------------- SYN_REPORT ------------
> Event: time 1702125288.037688, type 2 (EV_REL), code 8 (REL_WHEEL), value -1
> Event: time 1702125288.037688, -------------- SYN_REPORT ------------
> Event: time 1702125290.481787, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
> Event: time 1702125290.481787, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 0
> Event: time 1702125290.481787, -------------- SYN_REPORT ------------
> 
> Hscroll:
> Event: time 1702125293.841920, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
> Event: time 1702125293.841920, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 1
> Event: time 1702125293.841920, -------------- SYN_REPORT ------------
> Event: time 1702125294.761952, type 2 (EV_REL), code 6 (REL_HWHEEL), value -1
> Event: time 1702125294.761952, -------------- SYN_REPORT ------------
> Event: time 1702125294.893967, type 2 (EV_REL), code 6 (REL_HWHEEL), value -1
> Event: time 1702125294.893967, -------------- SYN_REPORT ------------
> Event: time 1702125296.134006, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
> Event: time 1702125296.134006, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 0
> Event: time 1702125296.134006, -------------- SYN_REPORT ------------

-- 
Yauhen Kharuzhy
