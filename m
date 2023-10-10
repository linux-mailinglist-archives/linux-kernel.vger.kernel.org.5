Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4CD7BF6BA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjJJJEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJJJEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:04:46 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA439E;
        Tue, 10 Oct 2023 02:04:44 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690bf8fdd1aso3912830b3a.2;
        Tue, 10 Oct 2023 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696928683; x=1697533483; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2RXE7fyLfD3qzF7sApsWnRY+f5dq9bXtB3kEGmnfPA=;
        b=jDOIwObNqjweS6R1vH0WkQg1MiXb3EEn/g4HzapqA8RVl0Qbm7Ar2uC+wRId0HPq/m
         jno+oNOKxhDpmtnzCCD9fJKn3f31AkPEIYRNqC3EVGpkj33ZV/qOYb+LYdraBL80Gbkq
         uhCjR2D+6qarcdVBZJFXu/7dm8W6j1AJk3J8EXUTSQx/cWLxrP4MI/d0muOsJngJG6sa
         4pLWLvwFraO2Fn91qglH3Ow9neB5RnvA87YnoAhaXtqhBpGGy+Q1Y2zO/uystQIaKSGx
         YzXZ6JAA9DHxFQDBVO88Fgf/984TPJ5D4c34661zYwLLRsC9A1tUnritSrEW6h7RM9fP
         WHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696928683; x=1697533483;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J2RXE7fyLfD3qzF7sApsWnRY+f5dq9bXtB3kEGmnfPA=;
        b=manAia/Xg6CSNm/98MGFqZZx8loMrZFdu5mnlOZFNuVDntRMkvVW9Ph4GSh9DrrCc3
         /4Y2LbWv/dTF/kfMkpUpgW+GyFKtoW50r9mvJhcsZ8HXPMOnln0ZadyjVbMwEKDsxGAO
         mU/ekbuVCyHJReckivT22Ey3hOOjNffEWuCwjUU0+VO95GExmYGk2F1OqthX2QOXAbRn
         +kLTbMefDN3E9BiPJBcPCtoCUMDuwplQH0KokkCxAZsFAtz4MDzfEUHRu/BJzrGdy6KB
         yeX0QTlsmkbjX2EqizgU1J5MsK8bEChl+LeAbbtmTvPp9jRv74W5RC58k49x4jgMktXQ
         5oyA==
X-Gm-Message-State: AOJu0YyYHfsM6OrNlyLlZQSgtP7bp7dP75t3D7Q1InghhBZsJJZwkP84
        zSSn4eu720rcPoMHwAJ6jzkx1yCHKws=
X-Google-Smtp-Source: AGHT+IEhcp8R/FIAFbq7UdZjUFdRU8O5IedvU7V229puFGOvbTBRQjqRn9NJ5K7zxFYXulEXk+KUhQ==
X-Received: by 2002:a05:6a00:369a:b0:69f:b6c4:51e0 with SMTP id dw26-20020a056a00369a00b0069fb6c451e0mr5180154pfb.1.1696928683511;
        Tue, 10 Oct 2023 02:04:43 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id u13-20020a63470d000000b0056b27af8715sm9323866pga.43.2023.10.10.02.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 02:04:43 -0700 (PDT)
Message-ID: <83b5114c-1ff8-4251-a4ef-8c0e7614f74b@gmail.com>
Date:   Tue, 10 Oct 2023 16:04:38 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        Victor <victormingueza@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: rtw89_8852be wifi disconnects and needs to be restarted
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Hi,
> 
>   I got a new laptop HP 445 G9 that comes with the Realtek RTL8852BE. The wifi is able to connect to internet briefly and then it disconnects from the network, the device is not available any longer until I restart the laptop.
> 
>  I'm using Arch and cloned the linux 6.2 and installed this version, although not maintained anymore, it works fine and is stable, wifi never disconnects, but newer versions of the kernel seem to have the issue mentioned above. Below are some logs from the kernel 6.5
> 
> Oct 03 21:29:14 ryzen14 kernel: rtw89_8852be 0000:02:00.0: loaded firmware rtw89/rtw8852b_fw-1.bin
> Oct 03 21:29:14 ryzen14 kernel: rtw89_8852be 0000:02:00.0: enabling device (0000 -> 0003)
> Oct 03 21:29:14 ryzen14 kernel: rtw89_8852be 0000:02:00.0: Firmware version 0.29.29.1, cmd version 0, type 5
> Oct 03 21:29:14 ryzen14 kernel: rtw89_8852be 0000:02:00.0: Firmware version 0.29.29.1, cmd version 0, type 3
> Oct 03 21:29:14 ryzen14 kernel: rtw89_8852be 0000:02:00.0: chip rfe_type is 1
> Oct 03 21:29:14 ryzen14 NetworkManager[823]: <info>  [1696321754.6290] rfkill0: found Wi-Fi radio killswitch (at /sys/devices/pci0000:00/0000:00:01.3/0000:02:00.0/ieee80211/phy0/rfkill0) (driver rtw89_8852be)
> Oct 03 21:30:41 ryzen14 kernel: rtw89_8852be 0000:02:00.0: failed to pre-release fwcmd
> Oct 03 21:30:41 ryzen14 kernel: rtw89_8852be 0000:02:00.0: read rf busy swsi
> Oct 03 21:30:41 ryzen14 kernel: rtw89_8852be 0000:02:00.0: read rf busy swsi
> Oct 03 21:30:41 ryzen14 kernel: rtw89_8852be 0000:02:00.0: timed out to flush pci txch: 0
> Oct 03 21:30:41 ryzen14 kernel: rtw89_8852be 0000:02:00.0: timed out to flush pci txch: 1
> Oct 03 21:30:41 ryzen14 kernel: rtw89_8852be 0000:02:00.0: timed out to flush pci txch: 2
> Oct 03 21:30:41 ryzen14 kernel: rtw89_8852be 0000:02:00.0: timed out to flush pci txch: 3
> Oct 03 21:30:41 ryzen14 kernel: rtw89_8852be 0000:02:00.0: timed out to flush pci txch: 8
> Oct 03 21:30:41 ryzen14 kernel: rtw89_8852be 0000:02:00.0: timed out to flush pci txch: 9
> Oct 03 21:30:41 ryzen14 kernel: rtw89_8852be 0000:02:00.0: timed out to flush pci txch: 0
> Oct 03 21:30:41 ryzen14 kernel: rtw89_8852be 0000:02:00.0: timed out to flush pci txch: 1
> Oct 03 21:30:41 ryzen14 kernel: rtw89_8852be 0000:02:00.0: timed out to flush pci txch: 2
> Oct 03 21:30:41 ryzen14 kernel: rtw89_8852be 0000:02:00.0: timed out to flush pci txch: 3
> Oct 03 21:30:41 ryzen14 kernel: rtw89_8852be 0000:02:00.0: timed out to flush pci txch: 8
> Oct 03 21:30:41 ryzen14 kernel: rtw89_8852be 0000:02:00.0: timed out to flush pci txch: 9
> Oct 03 21:30:42 ryzen14 kernel: rtw89_8852be 0000:02:00.0: FW does not process h2c registers
> Oct 03 21:30:42 ryzen14 kernel: rtw89_8852be 0000:02:00.0: read rf busy swsi
> Oct 03 21:30:42 ryzen14 kernel: rtw89_8852be 0000:02:00.0: read rf busy swsi
> Oct 03 21:30:42 ryzen14 kernel: rtw89_8852be 0000:02:00.0: write rf busy swsi
> Oct 03 21:30:42 ryzen14 kernel: rtw89_8852be 0000:02:00.0: write rf busy swsi
> Oct 03 21:30:42 ryzen14 kernel: rtw89_8852be 0000:02:00.0: read rf busy swsi
> ....
> Oct 03 21:30:56 ryzen14 kernel: rtw89_8852be 0000:02:00.0: write rf busy swsi
> Oct 03 21:30:56 ryzen14 kernel: rtw89_8852be 0000:02:00.0: FW does not process h2c registers
> Oct 03 21:30:56 ryzen14 kernel: rtw89_8852be 0000:02:00.0: HW scan failed with status: -110
> Oct 03 21:30:57 ryzen14 kernel: rtw89_8852be 0000:02:00.0: Update probe request failed
> Oct 03 21:30:58 ryzen14 kernel: rtw89_8852be 0000:02:00.0: FW does not process h2c registers
> Oct 03 21:30:58 ryzen14 kernel: rtw89_8852be 0000:02:00.0: read rf busy swsi
> Oct 03 21:30:58 ryzen14 kernel: rtw89_8852be 0000:02:00.0: read rf busy swsi
> ...
> Oct 03 21:30:58 ryzen14 kernel: rtw89_8852be 0000:02:00.0: read rf busy swsi
> Oct 03 21:30:58 ryzen14 kernel: rtw89_8852be 0000:02:00.0: write rf busy swsi
> Oct 03 21:30:58 ryzen14 kernel: rtw89_8852be 0000:02:00.0: FW does not process h2c registers
> Oct 03 21:30:58 ryzen14 kernel: rtw89_8852be 0000:02:00.0: HW scan failed with status: -110
> Oct 03 21:30:58 ryzen14 kernel: rtw89_8852be 0000:02:00.0: xtal si not ready(W): offset=90 val=10 mask=10
> Oct 03 21:30:58 ryzen14 kernel: rtw89_8852be 0000:02:00.0: xtal si not ready(W): offset=90 val=10 mask=10
> Oct 03 21:30:58 ryzen14 kernel: rtw89_8852be 0000:02:00.0: mac init fail, ret:-110
> Oct 03 21:30:58 ryzen14 kernel: rtw89_8852be 0000:02:00.0: xtal si not ready(W): offset=90 val=10 mask=10
> Oct 03 21:30:59 ryzen14 kernel: rtw89_8852be 0000:02:00.0: xtal si not ready(W): offset=90 val=10 mask=10
> Oct 03 21:30:59 ryzen14 kernel: rtw89_8852be 0000:02:00.0: mac init fail, ret:-110
> 
> More details about the wireless device based on HP specification:
> 
> Realtek RTL8852BE 802.11ax (2x2) Wi-Fi and Bluetooth 5.2 combo
> Qualcomm Fast Connect 6900 Wi-Fi 6E 802.11ax (2x2) and Bluetooth 5.2 combo
> 
> Hopefully those details are useful, let me know if I can provide any further information.

Then the reporter (Cc'ed) had found the workaround:

> Hi all,
> 
>   After some more testing I found a workaround for now to run any modern kernel (> 6.2). I disabled some of the features for low power mode on the pci device and it seems stable now while running 6.5.
> 
>   I created a file in modprobe.d to disable the power saving settings:
> 
> /etc/modprobe.d/20-wifi.conf
> options rtw89_pci disable_aspm_l1ss=y disable_aspm_l1=y
> options rtw89_core disable_ps_mode=y
> 
>   Probably there are some issues with the driver when in power saving mode, which is the default behavior. Hopefully the new info brings some light for fixing the drivers.
> 
> Thanks,

See Bugzilla for the full thread.

Anyway, I'm adding this regression to regzbot:

#regzbot introduced: v6.2..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=217978
#regzbot title: rtw89_8852be wifi disconnects in power saving mode

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217978

-- 
An old man doll... just what I always wanted! - Clara
