Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7059F7973CD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245733AbjIGPaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241462AbjIGP27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:28:59 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFAB1FF9;
        Thu,  7 Sep 2023 08:28:30 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77058512c18so63496885a.1;
        Thu, 07 Sep 2023 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694100455; x=1694705255; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xAG8vAki6OKzGSmwZKwpc8XIZTasbZNRXeMNLWYhYg=;
        b=FthdpiOuGVKFl9W1bCgm4BkLjLtGl7JI7tf0hq2I763cBf5ThKzy+eR82yvcwXoTTZ
         xRUCeEQPJqiExU1o8zwHdBT7MmUzEf5WcTiDqKIPAzc7FGyk2Jvhr4PkgyeaqkroCVii
         WqaPwtMus0cAXnFZQUlBddKRggVc/A7n+MjEz27lXd9Xc7M0lfGWc7EIpaMo7w8B6paj
         UHVLdmTAv7XYFuSMxx0pEgYGdzSg0EHWyhpViRL4lRhiXPZWPB77aJp6tlIMt5gpKjM2
         jmRvyVnUBt0txLnGPWOkbIx+r9eFrbKXOEDdbd0DwdJoSzW71TxyzdEYZRJ0nRx/oPAo
         rWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100455; x=1694705255;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5xAG8vAki6OKzGSmwZKwpc8XIZTasbZNRXeMNLWYhYg=;
        b=Uw3S+RnQhNHoZoJUsOINNBgc6fcs3HEgPhDhbChev5hNfImk1ZJkvN2mIqhSP6f8kE
         SQcZ5OASP2PkbH98Gz6zrQY0LjdeSFcPeKTY7o/PSYlq1+m1suRfChjB/k6OAT+ioG07
         nQRHneIgLtXAjMACRyur/OFeaiapGOTjpFT1nXL7rrqAb6FBY49ToJ85OGmjNtuxg5Pz
         T1loE90094e8tCKKxbQ5U7XQo59746JpsHw6UpCZXpZDbVO+gbKlmxLvsmZ+dZs+IQTn
         VZiRBQ4gemoSYnvXQETXWm/Rbbq/vEv/h8Z4S3Mth+7hrP3nun1Kxg0w5kXEOpaDNvpP
         eezA==
X-Gm-Message-State: AOJu0YwbIXmbqP8hzxO7slh43LMYOLAqW8hkxvbs3telQZQ/qsEBCW19
        6TuTT3wKqRjrqbPNNv6WfQRbz/a0Vk0=
X-Google-Smtp-Source: AGHT+IH0oluWC/uZc5YWidmp8znrZ8ZfkiAQICtKAN+RZbG6DRdaEMFt4bVn9WEICH5+t1I9GRJ9dA==
X-Received: by 2002:a17:902:ecc8:b0:1bc:7001:6e5e with SMTP id a8-20020a170902ecc800b001bc70016e5emr23293177plh.32.1694093109112;
        Thu, 07 Sep 2023 06:25:09 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id jl1-20020a170903134100b001c32fd9e412sm8148306plb.58.2023.09.07.06.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 06:25:08 -0700 (PDT)
Message-ID: <5011708f-b0ae-2853-0f87-a3b59845a2cc@gmail.com>
Date:   Thu, 7 Sep 2023 20:25:04 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Integrity <linux-integrity@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Slow boot and shutdown/reboot problems with 6.5.0+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> I've observed a slow boot and shutdown/reboot problems that have been verified on the stock Arch 6.5.1, CachyOS 6.5.0-2 and a custom-compiled 6.5.1 Kernel. I originally had seen a RCU-related trace which I thought to be the cause for these problems as well and reported it in https://bugzilla.kernel.org/show_bug.cgi?id=217864. However that specific trace turned out to be caused by an old patch that I carried around with me since 2022.
> 
> systemd-analyze with my custom compiled 6.5.1 shows a suspiciously long firmware time:
> Startup finished in 2min 42.000s (firmware) + 4.201s (loader) + 6.895s (kernel) + 1.541s (userspace) = 2min 54.640s  
> graphical.target reached after 1.539s in userspace.
> 
> For comparison, 6.4.14 starts in 16 seconds and doesn't even show a firmware section.
> 
> System:
>   Host: klx99 Kernel: 6.5.1-3.1-cachyos-lto arch: x86_64 bits: 64
>     Desktop: KDE Plasma v: 5.27.7 Distro: CachyOS
> Machine:
>   Mobo: Lenovo model: X99-TF Gaming v: G368J V1.1, NALEX
>     serial: <superuser required> UEFI: American Megatrends v: CX99DE26
>     date: 10/10/2020
> CPU:
>   Info: 18-core model: Intel Xeon E5-2696 v3 bits: 64 type: MT MCP cache:
>     L2: 4.5 MiB
> Graphics:
>   Device-1: AMD Navi 21 [Radeon RX 6950 XT] driver: amdgpu v: kernel
>   Display: x11 server: X.Org v: 21.1.99 with: Xwayland v: 23.2.0 driver: X:
>     loaded: amdgpu unloaded: modesetting dri: radeonsi gpu: amdgpu
>     resolution: 2560x1440~165Hz
>   API: OpenGL v: 4.6 Mesa 23.3.0-devel (git-8a32614a18) renderer: AMD
>     Radeon RX 6950 XT (navi21 LLVM 16.0.6 DRM 3.54 6.5.1-3.1-cachyos-lto)

See Bugzilla for the full thread.

FYI, it seems like this regression is related to systemd boot loop
reported earlier [2].

To Marcus: On Bugzilla, Artem had asked you to bisect. Do you have
any conclusion on it?

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=217874
#regzbot title: slow boot possibly due to firmware (TPM?) issues

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217874
[2]: https://lore.kernel.org/all/028a21df-4397-80aa-c2a5-7c754560f595@gmail.com/

-- 
An old man doll... just what I always wanted! - Clara
