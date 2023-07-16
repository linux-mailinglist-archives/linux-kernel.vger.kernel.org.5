Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7762754E7B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 13:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjGPLpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 07:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGPLpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 07:45:00 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D897EEE;
        Sun, 16 Jul 2023 04:44:58 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666eba6f3d6so2279617b3a.3;
        Sun, 16 Jul 2023 04:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689507898; x=1692099898;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UW0Gb0fhe8KUAoH9z0fOHvs5nZuEEb7L+CPOMHFXQWA=;
        b=irD1uJ3MFytLmjvRmq8Yl9WjAlyqjv1PYh9U2Jga5+2zclCqDvzEU4EV7397PzfnJd
         AwQggkMPsYHhRdhK/uhDy6Y7Cloweegu34afTCFBtS1fWsTnZBTnSFuU/qDAaf6xERBm
         Pc0joGj8Pj9guWnSGFCB7QUM1TsN5iy6himHOcsGIm2IZ2kMOd4GLVrw7WhXYzC6MaPB
         16Vqyv5R3Y2aUq9PiCg1tynvKpgCGbbEzyYBUCE/glqQkejAQB/Jau845OjWbLbYxQc+
         TmRHm8ZJNN+YqQntBpdPsDf541E8suumaahIZ6xC2hS5sttdRzKsbzPRGsoYOoU7qs95
         S77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689507898; x=1692099898;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UW0Gb0fhe8KUAoH9z0fOHvs5nZuEEb7L+CPOMHFXQWA=;
        b=dubVMPtmxLIwpm3qV3q311xVsmcKoyfPJHqXHl2xEFxkhQFSMrwHGQvlYj/VeirfL7
         HhVq+10UpFjSnsS1CtajlTc1CGN6L1eFew8VYypVLe02jBsZxgx+4kVp2+usnLw4M6eZ
         n2FB77bgDElolH9AL73PRcbcdb7F9r0hdHgDe/HQbuw2Q162rSo+s5jyZTMAjx+OeOG1
         dLkmAttTTvzV/XOInAa3aRASKknDHluKMrK4emUYtenvnM9yxJ/0Tz4DxVBNtzfgL+Bx
         jjCWm2x48Tv4dOdGItoA6HHitNlZpaCEoVq4/+IDBFjHHWpTaQUvoKe+B139YTRS18kM
         Xbtw==
X-Gm-Message-State: ABy/qLb9t2WkBXJb7eEU3ZK6HYj8axcOC+XZRZPXL2sMPlZpkqE6nzjy
        vZMsC8It59Nh4INLBaoLOSiB/NQOO+Sd9Nm7
X-Google-Smtp-Source: APBJJlENaURlprzIJM/AWxrCdrM0RnZHU+VlpQ7Ay5WfVSfljEoACMDN/5bW6NiEKcB2hFoQgwU8Sw==
X-Received: by 2002:a05:6a00:23c2:b0:680:fa5f:4ed6 with SMTP id g2-20020a056a0023c200b00680fa5f4ed6mr11156582pfc.27.1689507898117;
        Sun, 16 Jul 2023 04:44:58 -0700 (PDT)
Received: from [192.168.0.104] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 2-20020aa79242000000b0067777e960d9sm9988284pfp.155.2023.07.16.04.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 04:44:57 -0700 (PDT)
Message-ID: <12caddea-9432-6285-f46b-2ba0ae426c38@gmail.com>
Date:   Sun, 16 Jul 2023 18:44:43 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maik Broemme <mbroemme@libmpq.org>,
        Johannes <johannesnitschke@yahoo.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Intel GPU <intel-gfx@lists.freedesktop.org>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Framebuffer <linux-fbdev@vger.kernel.org>,
        Linux Stable <stable@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: =?UTF-8?Q?Fwd=3a_Framebuffer-Display_issue=2e_=28Intel=c2=ae_Iris?=
 =?UTF-8?B?wq4gWGUp?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Hello I have been having problems for some time now with displaying any linux distribution with the new kernal. The only thing that can fix it are older kernals.
> 
> I can't describe it very well, so I'm attaching some pictures, but it's like whenever anything happens on the screen, it pushes the upper left half up from the bottom. But it only goes to a certain extent, after that it just shakes around and jumps back a bit. Also, for example, the firefox icon is not where it is displayed, but where it should be (I tried it with touch).
> 
> I think it has something to do with the framebuffer, because an usb stick with just the arch iso show the same issue in the tty.
> 
> The hardware is a Huawei Matebook E 2022.
> Cpu: Intel® Core™ i5-1130G7
> Graphics: Intel® Iris® Xe
> 
> Example under Manjaro that worked was with the 
> linux-lqx-6.1.0.lqx2-1-x86_64.pkg.tar.zst kernal
> 22-Dec-2022 14:44           154507169
> from https://repo.blacksky3.com/x86_64/linux-lqx/old/
> 
> Kernals above that Version dosent work, Example with 6.1.1-lqx1-linux-lqx:
> `
> $inxi -F
> System:
> Host: Johannes Kernel: 6.1.1-lqx1-linux-lqx arch: x86_64 bits: 64
> Desktop: GNOME v: 43.5 Distro: Manjaro Linux
> Machine:
> Type: Detachable System: HUAWEI product: DRC-WXX v: M1010
> serial:
> Mobo: HUAWEI model: DRC-WXX-PCB v: M1010 serial:
> UEFI: HUAWEI v: 1.30 date: 06/29/2022
> Battery:
> ID-1: BAT1 charge: 27.8 Wh (66.0%) condition: 42.1/42.1 Wh (100.0%)
> volts: 11.9 min: 11.5
> CPU:
> Info: quad core model: 11th Gen Intel Core i5-1130G7 bits: 64 type: MT MCP
> cache: L2: 5 MiB
> Speed (MHz): avg: 1395 min/max: 400/1801 cores: 1: 897 2: 1046 3: 962
> 4: 1801 5: 1801 6: 1801 7: 1801 8: 1052
> Graphics:
> Device-1: Intel Tiger Lake-UP4 GT2 [Iris Xe Graphics] driver: i915 v: kernel
> Display: wayland server: X.org v: 1.21.1.8 with: Xwayland v: 23.1.1
> compositor: gnome-shell driver: gpu: i915 resolution: 2560x1600~60Hz
> API: OpenGL v: 4.6 Mesa 23.0.3 renderer: Mesa Intel Xe Graphics (TGL GT2)
> Audio:
> Device-1: Intel driver: N/A
> Device-2: Intel Tiger Lake-LP Smart Sound Audio
> driver: sof-audio-pci-intel-tgl
> API: ALSA v: k6.1.1-lqx1-linux-lqx status: kernel-api
> Server-1: PulseAudio v: 16.1 status: active
> Network:
> Device-1: Intel Wi-Fi 6 AX201 driver: iwlwifi
> IF: wlp0s20f3 state: up mac: f4:b3:01:b7:c6:6d
> Bluetooth:
> Device-1: Intel AX201 Bluetooth driver: btusb type: USB
> Report: rfkill ID: hci0 state: up address: see --recommends
> Drives:
> Local Storage: total: 476.94 GiB used: 9.65 GiB (2.0%)
> ID-1: /dev/nvme0n1 model: PCIe-8 SSD 512GB size: 476.94 GiB
> Partition:
> ID-1: / size: 468.09 GiB used: 9.65 GiB (2.1%) fs: ext4 dev: /dev/nvme0n1p2
> ID-2: /boot/efi size: 299.4 MiB used: 288 KiB (0.1%) fs: vfat
> dev: /dev/nvme0n1p1
> Swap:
> Alert: No swap data was found.
> Sensors:
> System Temperatures: cpu: 35.0 C mobo: N/A
> Fan Speeds (RPM): N/A
> Info:
> Processes: 241 Uptime: 0m Memory: available: 15.42 GiB used: 1.18 GiB (7.6%)
> Shell: Zsh inxi: 3.3.27
> 
> `
> 
> Distros I testet:
> Ubuntu 20.04.2 results in Blackscreen/poweroff
> Fedora 38 (Bug as I mentiond)
> Manjaro (Bug as I mentiond)
> It all works fine when you start from grub2 in Rescue mode.
> 
> That all is very new to me, so I am sorry if I did something wrong. 
> I mean, I reported that bug first at the wrong place.. Anyway
> 
> Best regreds Johannes

See Bugzilla for the full thread and attached pictures that demonstrate
this regression.

Anyway, I'm adding it to regzbot:

#regzbot introduced: v6.1..v6.4 https://bugzilla.kernel.org/show_bug.cgi?id=217666
#regzbot title: screen shakes on Intel® Iris® Xe

(also Cc'ing stable list because it also occurs on v6.1.y, but not in
v6.1 mainline).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
