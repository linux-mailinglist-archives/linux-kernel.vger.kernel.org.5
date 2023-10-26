Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D407D7E19
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjJZIKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjJZIKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:10:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CBFB8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:10:21 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc0e78ec92so1700285ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698307821; x=1698912621; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tS0JDvw2Y7iSHdnpDlvBW8JTP6jh8SxazuhN3wAyMC4=;
        b=fiL98r2XVRIliBgEaWNGFCVNa78J+OTVeFBx8rJugl3xadhBq/8cgbMYa4wYT70zJo
         wgBZIBH2t/LjQ5dHp1jQxkSk7sXRVI9MVJCRX/sJVSPC+/yoVFp5Qk6q1oag/a4Lulq7
         lhvbvkgcMrzSVJH+k3giKdO87bXr/FvfZ3GIr52mozH/wnPhxDlM1PEYPiuEBP6+lmNX
         5hpl5bFZqVOIumwWUsujcIv8C+iR4rXn5k1liGqwHJAVcpKm1RlIMUoPj+KiHUuRSj53
         RF+X70R9lPqUFnIuXUKThB4bOKuv63qNrgNL2LAVR65kPwLehujv7hMbdrP/QgCi89vU
         LPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698307821; x=1698912621;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tS0JDvw2Y7iSHdnpDlvBW8JTP6jh8SxazuhN3wAyMC4=;
        b=FBz/OXDJ4Oz6xVLHhzC8OiBk/DWh5fzhbVKB0ZQhZfTLMhdDSBTiRc7rfWTBkniobn
         0TRD0n3Dmgyh0gWfaISDLp4yY1cinNWHdYEnIaAJef82jTFFp4ckM3xJahZQhUHoFlvQ
         jPyStX2QbxXhdTsi5Em2QUkIHIPVwpV3VtsuWAzIHfa80I3GLSTD854eHCUulMK9ND5e
         oq8sxPGxXu3EbIjXacnsXx5pk7p0sqHNAOhzWnPVA9eHUMvWFDkkh9vGbl4QNCsw+fj7
         JKYF3fcQu7nmmvYvaZA3iqThLlizoNHpUUYE4rr7pbshnaA6lRKLs5KEbqhqOu2Ujlcr
         cBkg==
X-Gm-Message-State: AOJu0Yyh+7wCb1ta8NDx4SW7HzmmSdQoXsmoKtLoOkH7cizUhdUZn4D5
        vy2Bo+2kuybeLRWp81BbB6taN1M33Vs=
X-Google-Smtp-Source: AGHT+IFkQdCmx6azCnuYBVfNXe7b1jeF68gbYN099m/fl0+tvRJFjSHIvuyMrHv3CuxWGzlEL+mXeQ==
X-Received: by 2002:a17:902:f542:b0:1ca:8e43:765a with SMTP id h2-20020a170902f54200b001ca8e43765amr18310249plf.9.1698307820770;
        Thu, 26 Oct 2023 01:10:20 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id q9-20020a170902dac900b001b9c960ffeasm10385498plx.47.2023.10.26.01.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 01:10:20 -0700 (PDT)
Message-ID: <d6e886d4-9084-4d56-a544-36d9ba526dcd@gmail.com>
Date:   Thu, 26 Oct 2023 15:10:17 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ALSA Development <alsa-devel@alsa-project.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        aguertin <aguertin+kbz@aguertin.net>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: No sound from monitor speakers unless snd_hda_codec_realtek is
 inserted before snd_hda_intel
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a bug report on Bugzilla [1]. Quoting from it:

> I have an Asus Pro B550M-C/CSM motherboard, which uses a Realtek ALC887-VD, and a monitor (with speakers) plugged in via DisplayPort. On booting normally, I get no sound from the monitor speakers (other sound outputs like USB or bluetooth headphones work fine).
> 
> I have found two workarounds for getting the monitor sound working:
> 1. rmmod snd_hda_intel && modprobe snd_hda_intel
> 2. ensure that snd_hda_codec_realtek is inserted before snd_hda_intel (e.g. by adding `softdep snd_hda_intel pre: snd_hda_codec_realtek` in modprobe.d)
> 
> Notably, timing does not seem to be an issue: even if snd_hda_intel is blacklisted from loading at boot, it will not work when it is loaded unless is is unloaded and loaded again or snd_hda_codec_realtek is loaded first.
> 
> This is not a recent regression - it has been happening as long as I have had the hardware (since at least late 2021).
> 
> Since it's not clear which is more useful, I am attaching two runs of alsa-info.sh - one is from a normal boot with sound not working, and the other is after running rmmod snd_hda_intel && modprobe snd_hda_intel with sound working.

See Bugzilla for the full thread and alsa-input output on both working
and buggy cases.

AFAIK, it looks like module dependency issue.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218027

-- 
An old man doll... just what I always wanted! - Clara
