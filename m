Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CADC7700A5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 14:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjHDM7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHDM7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 08:59:24 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1229213D;
        Fri,  4 Aug 2023 05:59:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68336d06620so1888631b3a.1;
        Fri, 04 Aug 2023 05:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691153962; x=1691758762;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsm2MM76R5zAcZpaPZQU2c86WW7cTBjgkoqL1ZytlAE=;
        b=SIE7hE4Q3/p18KRyc8lNS1jz+KzyC/2CRzoM+jF/ckbvUk1S4v/1XsN6i8K+VpoCcw
         quAEX6ukESTXq/HDd+GWjrlHSv9AromJFMzpbR1qS7ZJ/pclCAEWT6HukvnOzlTLIghk
         BSkZgTDVHMctLvcOX9HLrp5w3b3f/rhAZGRAfo+oex15hs44+ZFk0HO9W3EvBrO2PpUp
         WzwRWhaLjLwUz7Fk5ZwdyQRdRcbEli3eYSfb0JqFTwOkhuJ+02Nk1Pimck/TQGosUOxz
         hSIKqdX//6on3W7+5oZ179cC+vOXnFeqLvAGJKCJYMYT5lqd1+Vas/tr7ykVmVv3zSww
         fYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691153962; x=1691758762;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bsm2MM76R5zAcZpaPZQU2c86WW7cTBjgkoqL1ZytlAE=;
        b=KyqzLG0uvUUgzTfuKCZDoJweK845Z9fkvbCHO/Ml7LWjB6l5j12bcXNx4gNaS3jgVl
         yO4zcjoS56fmruJiuHtMRAJTfzSKGBBO+gNxHfVET7CvHoigAG19/lmWQvz+srmYEVdv
         n6VW+ybxYlrTI0wS89cu9s9bA1xerQYDw7WMc8ag84uFDm/mEzsCCl+W97j6tmc+5KgS
         shKMGn2yFarNVQuvNQSLXGdEFPaf3dr8jQ+wSjMuL38P1ocMgXWwHctGwcOtbT0oKo8q
         90rET1/kkxAzKWRHoLP9Twg/BbHrT8LcUiAAlGeLl+Upf1BO4mDCnLhiN9IYbEJiDlpe
         XU5w==
X-Gm-Message-State: AOJu0Ywcx2NXuoW2BeL04qNYQSllzMODILN4Qyy3VF8McvdA8osYvO6w
        rD+1sFaVDSvj/yLksX4TaNg9sgtMe5s=
X-Google-Smtp-Source: AGHT+IG5twdRgjzqJbPoCBqdqLHyi7hInUNoREUNFr+v1+O8u5Ihj0o1i32aWr9FkDfywEm99nSv3A==
X-Received: by 2002:a05:6a21:4843:b0:13f:bc16:c360 with SMTP id au3-20020a056a21484300b0013fbc16c360mr1701155pzc.32.1691153962423;
        Fri, 04 Aug 2023 05:59:22 -0700 (PDT)
Received: from [192.168.0.105] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p27-20020a63951b000000b00563590be25esm1158428pgd.29.2023.08.04.05.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 05:59:22 -0700 (PDT)
Message-ID: <9a9f9bfe-d532-5814-e3cd-b53bfc4f7480@gmail.com>
Date:   Fri, 4 Aug 2023 19:59:16 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Raul E Rangel <rrangel@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        bishal <neupanebishal2001@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Input Devices <linux-input@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: DELL0A78:00 27C6:0D42 Touchpad (gestures) doesn't work properly
 after resuming from suspend.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> Description:
> ------------
> The touchpad doesn't function normally after resuming from suspend. Touch works most of the time so does the hardware click buttons. The things which don't work are touchpad multitouch gestures (2 fingers and 3 fingers) and cursor movement is also somewhat laggy.
> 
> Workaround:
> -----------
> removing the module i2c_hid_acpi just before suspend and adding it after resume seems to solve the problem. 
> 
> Script: (output of `cat /usr/lib/systemd/system-sleep/make-touchpad-work.sleep`)
> -----------------------------------------------------------------------------
> 
> #!/bin/sh
> 
> case $1/$2 in
>   pre/*)
>     echo "Going to $2..."
>     # Place your pre suspend commands here, or `exit 0` if no pre suspend action required
>     echo "Removing i2c_hid_acpi module before suspend."
>     modprobe -r i2c_hid_acpi
>     ;;
>   post/*)
>     echo "Waking up from $2..."
>     # Place your post suspend (resume) commands here, or `exit 0` if no post suspend action required
>     sleep 2
>     echo "Adding i2c_hid_acpi module after suspend (before resuming)."
>     modprobe i2c_hid_acpi
>     ;;
> esac
> -----------------------------------------------------------------------------
> 
> When was it discovered?
> -------------------------
> I had prior hardware issues with the touchpad so I didn't notice 
> it for a very long time, each time such an issue appeared I thought it was a hardware issue. But the issue is still there even after fixing the hardware (loose ribbon cable). Before the hardware issue, there was an issue with resuming from suspend on my laptop (because of laptop begin particularly new AMD variant). So, if I remember correctly, the touchpad worked fine for particular duration between suspend issue being fixed and hardware issue appearing. 
> 
> GNU/Linux version:
> ------------------
> Linux localhost.localdomain 6.5.0-rc4-1-default+ 
> #1 SMP PREEMPT_DYNAMIC Thu Aug 3 20:15:04 +0545 2023 x86_64 x86_64 x86_64 GNU/Linux
> 
> Touchpad information:
> ------------------------
> PS/2 00.0: 10500 PS/2 Mouse
>   [Created at input.249]
>   Unique ID: AH6Q.rKa1+aijZtE
>   Hardware Class: mouse
>   Model: "DELL0A78:00 27C6:0D42 Touchpad"
>   Vendor: 0x27c6 
>   Device: 0x0d42 "DELL0A78:00 27C6:0D42 Touchpad"
>   Compatible to: int 0x0210 0x0001
>   Device File: /dev/input/mice (/dev/input/mouse2)
>   Device Files: /dev/input/mice, /dev/input/mouse2, /dev/input/event3, /dev/input/by-path/platform-AMDI0010:03-event-mouse, /dev/input/by-path/platform-AMDI0010:03-mouse
>   Device Number: char 13:63 (char 13:34)
>   Driver Info #0:
>     Buttons: 1
>     Wheels: 0
>     XFree86 Protocol: explorerps/2
>     GPM Protocol: exps2
>   Config Status: cfg=no, avail=yes, need=no, active=unknown
> 
> 
> Prior to testing on mainline kernel, it was tested on opensuse tumbleweed and reported here: https://bugzilla.suse.com/show_bug.cgi?id=1212779

See Bugzilla for the full thread.

FYI, I forward the BZ report because it was assigned to generic `Kernel`
component instead, which missed linux-input list. I also add the reporter's
address to To: list so that you can reach him without having to go to
Bugzilla.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217761

-- 
An old man doll... just what I always wanted! - Clara
