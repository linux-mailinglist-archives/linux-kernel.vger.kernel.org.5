Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89837E13B9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 14:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjKENiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 08:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjKENiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 08:38:16 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C14CC;
        Sun,  5 Nov 2023 05:38:13 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5bd33abbb90so1886197a12.2;
        Sun, 05 Nov 2023 05:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699191493; x=1699796293; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+e1/WOaxhHOYumCJGHxW4yo1K4Axe3NoWi7Y58Yuot4=;
        b=IDYS+8ughgTgTtSLiGREtvyW2/AU/ZCJ/zZYll1K4onq5/WbkPIWjPZBuWyV8hQGuW
         G5+0eFaSXcLaN4p4Payni0QIRpV2qLobto7xVjVi98fRF+AKlzG0mzLR10VvcmmzUJ/b
         hXkTsNY4asTDWVkovhcpdrNm8YBdkW7ybKzbKjBI0tUwakyLVQ6BDtzy67FIZcUH5zyD
         iWGTNJ/8LKQV7iMAcBmKB5Dg27tLX0pYsQL6RhgLUDOKOVtsK0WNCmcLg3oB3VGjfM/j
         7EsmPvqWfD9zAyWlLOnIZH4oWDZeKEaVLfhIT9UcmzzTN3T9EHqNU0IroxC3lXnwEP2C
         BjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699191493; x=1699796293;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+e1/WOaxhHOYumCJGHxW4yo1K4Axe3NoWi7Y58Yuot4=;
        b=hj/JEgCH/Ha3Gj/Pe1N/s0u+3opQoc38tyKOXlB5TqdC0cX82yNqk9gQ/1xvXYz7CE
         Fq5N0P2BUfnEt5j3OmVCnbPVyAAo9injzPtaisCNGXzfaiGUvI4dzQySbVdp0RDjzj4H
         +VbIAVpHuvbF6Sl2m0A8fwI6jU0QLVomfBKPSq71Vi6mpEyXrvp9AQF6ODxlNSd0SSki
         5kZtSXCEcUr2xY1gcFu/S9N1dwGzzcJHM5RlCKLtSbIgO7Tjn1vAYuxfy9ehw8j9JsvF
         pxLT7InEOHquZdnBTi2EoXJnQMD6r3Xgc2S6U59WkF/lFtkHxuIy+xhfqWWYwdQJTOZv
         U04w==
X-Gm-Message-State: AOJu0YyJjzdb38RwFT81WGS5LlVJ2JjzbDgv7GZmnZSLMDm8+0Rt17im
        nlTYr9yvQd+U5jYkSJNzTUCRbpYs28I=
X-Google-Smtp-Source: AGHT+IGnOY6SoMqJljQH1E5l1ttLw6XBsY2utpcSB80AvJ/n5Hb02ZhuAlejb948Pgt1LIqsyv0Xkg==
X-Received: by 2002:a17:903:244b:b0:1cc:60ca:8f24 with SMTP id l11-20020a170903244b00b001cc60ca8f24mr19126894pls.45.1699191493169;
        Sun, 05 Nov 2023 05:38:13 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id j13-20020a170902c3cd00b001c9cc44eb60sm4216389plj.201.2023.11.05.05.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Nov 2023 05:38:12 -0800 (PST)
Message-ID: <14e3c405-5f80-4b73-b291-e84bdd6b240f@gmail.com>
Date:   Sun, 5 Nov 2023 20:38:07 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Input Devices <linux-input@vger.kernel.org>
Cc:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Mauricio Collares <mauricio@collares.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: [amd-sfh] Interrupt disabling (b300667b) disables working HP
 ProBook x360 435 G7 accelerometer
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> I have a HP ProBook x360 435 G7 (Ryzen 4700U). On GNOME Wayland with
> the Screen Autorotate extension
> (https://extensions.gnome.org/extension/4191/screen-autorotate/), I
> confirmed by bisection that b300667b33b2b5a2c8e5f8f22826befb3d7f4f2b
> caused autorotation to stop working.
> 
> More specifically, before this commit (on aa0b724a2bf041036e56cbb3b4b3afde7c5e7c9e):
> 
> * `sudo iio-sensor-proxy -v -r` stays running (doesn't exit immediately) and prints nothing
> * `monitor-sensor` starts up by saying "=== Has accelerometer (orientation: normal)" and prints "    Accelerometer orientation changed: bottom-up" when I physically rotate the screen.
> * `udevadm info --export-db` contains the accelerometer/gyroscope sensor info I've pasted in the attachment.
> 
> After b300667b33b2b5a2c8e5f8f22826befb3d7f4f2b:
> 
> * `sudo iio-sensor-proxy -v -r` exits immediately.
> * `monitor-sensor` prints "    Waiting for iio-sensor-proxy to appear" on startup and does nothing when I rotate the screen.
> * The sensors in the attachment are no longer listed in `udevadm info --export-db`.
> * The `hid_sensor_gyro_3d` and `hid_sensor_accel_3d` kernel modules are no longer loaded automatically, and loading them does nothing.
> 
> Reverting b300667b33b2b5a2c8e5f8f22826befb3d7f4f2b on top of 6.6 also makes screen autorotation work again. Whenever screen autorotation works, `iio_generic_buffer --device-num 2 -A -c 100` reports good accelerometer values.
> 
> (The following is essentially the contents of bug #212625 comment #46)
> 
>> If you revert that commit on top of 6.6 does it start working?  Also; can
>> you still get into the deepest s2idle sleep state in 6.6 with it reverted? 
>> You can check with /sys/power/suspend_stats/last_hw_sleep.
> 
> I don't have a /sys/power/suspend_stats/last_hw_sleep file (tested on stock 6.6, as well as on 6.6 + revert of b300667b33b2b5a2c8e5f8f22826befb3d7f4f2b), but if I leave my computer idle for a while it enters standby and I see
> 
> Nov 03 08:47:29 hp kernel: PM: suspend entry (deep)
> 
> in journalctl, and the computer enters deep sleep (need to press power button to wake it up). Also, the content of /sys/power/mem_sleep is "s2idle [deep]". In bug ug #212615 I also attached the report produced by amd_s2idle.py run on stock 6.6 in case it is relevant (I can also attach it for 6.6 + revert if desired).
> 

See Bugzilla for the full thread and attached udevadm output.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: b300667b33b2b5 https://bugzilla.kernel.org/show_bug.cgi?id=218104

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218104

-- 
An old man doll... just what I always wanted! - Clara
