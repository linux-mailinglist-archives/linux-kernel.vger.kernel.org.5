Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DCB80B460
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjLIMuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIMuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:50:13 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D796210D0;
        Sat,  9 Dec 2023 04:50:19 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54c1cd8d239so4124153a12.0;
        Sat, 09 Dec 2023 04:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702126218; x=1702731018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OtHFtnbtWJeZSrfGhByyO6irsFCj2VH4M4OLNb3uFzE=;
        b=HqRb5VOgX6/GMJHBE2b4kp6dcidgcX8CWS32tdZMA/7rEBgW7jaA4K5t+HKY2jGQa0
         6OFwWmLm7bUt1jFxqs3nzVC68CPV8HhWz7AYVheTuc2EagRjUwxWe1UE5yMWylT2ToGd
         HWMn5rg8lB+Ato4+ZEHoLChtuqyIrSaDBPHrQ034hlIZWN6R9Z006C8x9lFjwnmESMqx
         RXgMhs4uLj4W0UjgvpHeDemIjhO6DbXckJxwplC31J6aFGvgT/gi797LFci9XfJUvhxU
         4fxLGb2SlZrCoU2Pb8kP5oJIaRrQ1V9mq/lYqfZQXNvaPLWK9Ctm/IKcwwsSwniuhRAj
         nWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702126218; x=1702731018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtHFtnbtWJeZSrfGhByyO6irsFCj2VH4M4OLNb3uFzE=;
        b=grN9HU1Cjp63kUjz5Wf1oM+MyWvfHyg17Ht95WnWbouE0Gut97bD5fXrs6ZdHGBZkN
         pKCTylkMHqgCFIt/F6RtzE69MNUnPdwCRJ+oWQVc25uEbSTeNvxiJekViN9i5Z6t0k5s
         Zs2J53c2MU+oWu1npWkjW9jZe4ADQWGeplTvJDZzCV2/Lcl6Fw6hIE9q8QSIGDeVQBVB
         9ue4+Y/qu+mZLpT5Yfd6gqQX/EtzS682eEyB0YlEivgEBIvzAyk5ymTEKjmvAJ6uCTUH
         MGgm1TWhGD2dtpXScY3O56hr2eHFHPjgOqh3hTyn5LN/t/ENaUxAqYi6Ni20Keoa4887
         ABgg==
X-Gm-Message-State: AOJu0YwSQNc9ec7zBBCQ1/djicyplo+7B/j8KCvzy1XqN+fL3Piqz9QB
        UdtY//eppvqfm7pcZTsxf7E=
X-Google-Smtp-Source: AGHT+IHFAx3T5unQnVwrSO4TOBfFs42jwXMxxvFtKoOP1ERshpTEc1PItY3WEvtWlz6vmUHVAG6OsA==
X-Received: by 2002:a50:ee06:0:b0:54f:5842:4537 with SMTP id g6-20020a50ee06000000b0054f58424537mr642887eds.166.1702126218210;
        Sat, 09 Dec 2023 04:50:18 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id dj10-20020a05640231aa00b0054b25e865f6sm1626852edb.18.2023.12.09.04.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 04:50:17 -0800 (PST)
Date:   Sat, 9 Dec 2023 14:50:16 +0200
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Mikhail Khvainitski <me@khvoinitsky.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        ValdikSS <iam@valdikss.org.ru>
Subject: Re: [PATCH] HID: lenovo: Detect quirk-free fw on cptkbd and stop
 applying workaround
Message-ID: <ZXRiiPsBKNasioqH@jekhomev>
References: <20230918145042.37368-1-me@khvoinitsky.org>
 <20230923231522.94060-1-me@khvoinitsky.org>
 <20230923231522.94060-2-me@khvoinitsky.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923231522.94060-2-me@khvoinitsky.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2023 at 01:58:30AM +0300, Mikhail Khvainitski wrote:
> Built-in firmware of cptkbd handles scrolling by itself (when middle
> button is pressed) but with issues: it does not support horizontal and
> hi-res scrolling and upon middle button release it sends middle button
> click even if there was a scrolling event. Commit 3cb5ff0220e3 ("HID:
> lenovo: Hide middle-button press until release") workarounds last
> issue but it's impossible to workaround scrolling-related issues
> without firmware modification.
> 
> Likely, Dennis Schneider has reverse engineered the firmware and
> provided an instruction on how to patch it [1]. However,
> aforementioned workaround prevents userspace (libinput) from knowing
> exact moment when middle button has been pressed down and performing
> "On-Button scrolling". This commit detects correctly-behaving patched
> firmware if cursor movement events has been received during middle
> button being pressed and stops applying workaround for this device.
> 
> Link: https://hohlerde.org/rauch/en/elektronik/projekte/tpkbd-fix/ [1]

This patch breaks a scrolling at my ThinkPad TrackPoint Keyboard II: it
starts to report middle-button push/release events with scrolling events
between. A support for this keyboard was added in
24401f291dcc4f2c18b9e2f65763cbaadc7a1528 "HID: lenovo: Add support for
ThinkPad TrackPoint Keyboard II" commit.

There is an evtest output below:

Without of commit:

Middle-button click:
Event: time 1702122290.593300, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 1
Event: time 1702122290.593300, -------------- SYN_REPORT ------------
Event: time 1702122290.593312, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 0
Event: time 1702122290.593312, -------------- SYN_REPORT ------------

Vertical scrolling:
Event: time 1702122300.441627, type 2 (EV_REL), code 8 (REL_WHEEL), value -1
Event: time 1702122300.441627, -------------- SYN_REPORT ------------
Event: time 1702122300.565663, type 2 (EV_REL), code 8 (REL_WHEEL), value -1
Event: time 1702122300.565663, -------------- SYN_REPORT ------------

Horizontal scrolling:
Event: time 1702122307.845969, type 2 (EV_REL), code 6 (REL_HWHEEL), value -1
Event: time 1702122307.845969, -------------- SYN_REPORT ------------
Event: time 1702122307.981954, type 2 (EV_REL), code 6 (REL_HWHEEL), value -1
Event: time 1702122307.981954, -------------- SYN_REPORT ------------



After commit:

Middle-button click:
Event: time 1702125091.290045, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
Event: time 1702125091.290045, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 1
Event: time 1702125091.290045, -------------- SYN_REPORT ------------
Event: time 1702125092.626118, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
Event: time 1702125092.626118, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 0
Event: time 1702125092.626118, -------------- SYN_REPORT ------------


Vscroll:
Event: time 1702125286.653639, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
Event: time 1702125286.653639, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 1
Event: time 1702125286.653639, -------------- SYN_REPORT ------------
Event: time 1702125287.929689, type 2 (EV_REL), code 8 (REL_WHEEL), value -1
Event: time 1702125287.929689, -------------- SYN_REPORT ------------
Event: time 1702125288.037688, type 2 (EV_REL), code 8 (REL_WHEEL), value -1
Event: time 1702125288.037688, -------------- SYN_REPORT ------------
Event: time 1702125290.481787, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
Event: time 1702125290.481787, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 0
Event: time 1702125290.481787, -------------- SYN_REPORT ------------

Hscroll:
Event: time 1702125293.841920, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
Event: time 1702125293.841920, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 1
Event: time 1702125293.841920, -------------- SYN_REPORT ------------
Event: time 1702125294.761952, type 2 (EV_REL), code 6 (REL_HWHEEL), value -1
Event: time 1702125294.761952, -------------- SYN_REPORT ------------
Event: time 1702125294.893967, type 2 (EV_REL), code 6 (REL_HWHEEL), value -1
Event: time 1702125294.893967, -------------- SYN_REPORT ------------
Event: time 1702125296.134006, type 4 (EV_MSC), code 4 (MSC_SCAN), value ffa000fb
Event: time 1702125296.134006, type 1 (EV_KEY), code 274 (BTN_MIDDLE), value 0
Event: time 1702125296.134006, -------------- SYN_REPORT ------------

-- 
Yauhen Kharuzhy
