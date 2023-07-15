Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD13754851
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 12:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjGOK4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 06:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGOK43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 06:56:29 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A78A35AA
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 03:56:27 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso1813474b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 03:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689418587; x=1692010587;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZERGPzw5TZLiZLEYlC5ABDoHNPFEd4U3QPZl/a2G3cU=;
        b=aiu0XVxZD6ByP16P8lg4JKH7/qKR+UkZBlpoXGfmezQ7plwJyCZXb2OgYwF4SprvGy
         wCyYi0VdzubWp2PDhl6cE4i3if1SmsOGjWqC1jTioEtu/NR6dvNpYmsgXEkGhm9CKDYn
         fwed1zjwHcxpzJoagUXDN7x+4YcdHf5sycQjdMkgn/PMy/2IVLOBWQWLQvVPMU9II7Lf
         AHZ4zjU7on6HuQ3WqP7w4xzQBSucZJdnHok8Bzr+axCGubh7PaY3NvFIfCtuscXUGMRv
         9wRavQd5wFBVP6E7ezEYVldbdbepV+s5MOFNtGBYXH3ozfRVf9Oqa6xgTreka5vt0wXF
         YUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689418587; x=1692010587;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZERGPzw5TZLiZLEYlC5ABDoHNPFEd4U3QPZl/a2G3cU=;
        b=iNKQm4gdeB7Ng46WdJuHiSAVY4gRJG5cTdvJuKye6h/v33RlwM0uHPOGd0SqJ6kDhI
         9AGnQVxT5v4EZiXAj9i9VUDUcLChhFzI7bmqmyWCHXB/k0vOER5d81Iz/3oohUnFXhA3
         j1Zw4LxpkMiCuQ77P6Vib7lS5glsUU/aAZvxt+WwDlwO7Hb+wrxnDeNnOZ8KkRstso89
         CDU5k4dIOarkDAkuHqeuPE0whR7tErPRXbEY2XEirjTDMSvxpzmnl9C/VAmVXSSnaWaj
         Duc51mvjuXvkZ1Azi9JSs1yeK6zIsb3zTPnebjH8GgyGG2fzN+cre9zM7ODU+8rUC4HG
         fCww==
X-Gm-Message-State: ABy/qLZjgR12T/7gQRnhj64I/z7NJ9Xdoq2zK85RqhYYzhVY3udCpCKA
        KUUyMe9j0xeUcUEr4CdnvLwVkC+MHeNqJmAc
X-Google-Smtp-Source: APBJJlGOj8jl6PdCasGb35nlcC959eyVAjJa1/5upVEezCQMd7k/PX89IwG7inbwwmhtZGyUjoKl9Q==
X-Received: by 2002:a05:6a20:3d5:b0:128:fce6:dd8b with SMTP id 21-20020a056a2003d500b00128fce6dd8bmr4130662pzu.39.1689418586644;
        Sat, 15 Jul 2023 03:56:26 -0700 (PDT)
Received: from [192.168.0.104] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902da8a00b001b895336435sm9264398plx.21.2023.07.15.03.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 03:56:26 -0700 (PDT)
Message-ID: <3ee79b53-5c1b-1542-ceea-e51141e3ab74@gmail.com>
Date:   Sat, 15 Jul 2023 17:56:19 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Iyer <cydiaimpactor2003@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux ALSA Development <alsa-devel@alsa-project.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: 6.4 and higher causes audio distortion
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> I have a Lenovo ThinkPad X1 Yoga Gen 7 running Arch Linux. Linux 6.4 and higher, cause audio distortion. Sometimes, this occurs to the point that nearly nothing is discernible. This carries over to wired headphones. The issue occurs on the entire mainline 6.4.x kernel series and also the 6.4.3 stable and 6.5 RC1 kernel, which are the latest at the time of writing. The issue occurs on both the Arch distributed kernels, and the mainline kernels.
> 
> Linux kernels 6.3.x are not affected and neither is the 6.1 LTS kernel series which is what I am temporarily using. On Windows 10/11 too, the audio works as it should. This indicates that my hardware is not at fault. Bluetooth audio is not impacted from my testing, either.
> 
> The distortion doesn't start immediately. It either occurs automatically after a random amount of time, or when I increase/decrease the volume, or when I skip forward/backward to a section. In order to stop the distortion, I have to either increase/decrease the volume until it stops, or skip forward/backward until it stops, or restart Pipewire via systemd, however it starts again due to one of the aforementioned reasons.
> 
> At the time of this report, I am running Pipewire 0.3.74 and Wireplumber 0.4.14. This also doesn't seem like a Pipewire/Wireplumber issue, since these same versions work fine on the 6.1 LTS kernels without causing any audio distortion.
> 
> I wrote about this on the Arch Linux forums, too, and seems like at least two other people are facing this issue. Here's the forum post: https://bbs.archlinux.org/viewtopic.php?id=287068
> 
> Furthermore, I filed a bug report on the Arch Linux Bug Reporter, where they suggested that the issue is a kernel regression and should be reported upstream, here. Here's the bug report that I filed on the Arch Linux Bug Reporter for anyone interested: https://bugs.archlinux.org/task/79081?project=1&pagenum=10
> 
> I have attached the dmesg outputs of the mainline 6.5 RC1 kernel.
> 
> Here's some audio related hardware information from my device:
> 
> inxi -A
> 
> Audio:
> Device-1: Intel Alder Lake PCH-P High Definition Audio
> driver: sof-audio-pci-intel-tgl
> API: ALSA v: k6.5.0-rc1-1-mainline status: kernel-api
> 
> 
> pactl info
> 
> Server String: /run/user/1000/pulse/native
> Library Protocol Version: 35
> Server Protocol Version: 35
> Is Local: yes
> Client Index: 138
> Tile Size: 65472
> User Name: tux
> Host Name: NSA-Terminal-4
> Server Name: PulseAudio (on PipeWire 0.3.74)
> Server Version: 15.0.0
> Default Sample Specification: float32le 2ch 48000Hz
> Default Channel Map: front-left,front-right
> Default Sink: alsa_output.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp__sink
> Default Source: alsa_input.pci-0000_00_1f.3-platform-skl_hda_dsp_generic.HiFi__hw_sofhdadsp_6__source
> Cookie: f9dc:5e7a
> 
> 
> I can't figure out why this is happening. Kindly ask for any more information that is necessary. Thank you.

See Bugzilla for the full thread and attached dmesg.

Anyway, I'm adding it to regzbot so that it doesn't fall through
cracks unnoticed:

#regzbot introduced: v6.3..v6.4 https://bugzilla.kernel.org/show_bug.cgi?id=217673
#regzbot title: PipeWire + Wireplumber audio distortion on Lenovo ThinkPad X1 Yoga Gen 7
#regzbot link: https://bbs.archlinux.org/viewtopic.php?id=287068
#regzbot link: https://bugs.archlinux.org/task/79081?project=1&pagenum=10

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217673

-- 
An old man doll... just what I always wanted! - Clara
