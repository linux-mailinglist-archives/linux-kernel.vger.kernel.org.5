Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15967BA7D4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjJERV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJERVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:21:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E353E3267
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:15:45 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50325ce89e9so1656502e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 10:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696526144; x=1697130944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnzOVAYxsodjctC05aqml+twu9UDVsuakS0jGmFKSgg=;
        b=GKCx8x4lu2N3xZo9hMM/st0BpEttdovAusaled4eDXXWM69rqukJW17Dh5g4xJJE8a
         sXoXofmKjsow8pzHbMRDKti7Bqp/24DuUiNJ2hE4Ui446V/sa1PRWP+CuafudtbAEJrv
         LgrTYTptyXPFcK9W1hh+NaRYOhIEQc3NCSBS00d4sfVWx6Si5g2oMuJWBkpaWXuUFMj0
         CeRUpZvrBaSqnI/IvH63RsPG4VNj2N86f73SnY3favt2XJmXxmU6uweFupvHig8XixEw
         PBTc6OyxeHYTLHYJlumImKrxA6Y4VhC5iUrUOuagyzSxozwIvz5U+r6dU47Oqjc48U6m
         rjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696526144; x=1697130944;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CnzOVAYxsodjctC05aqml+twu9UDVsuakS0jGmFKSgg=;
        b=EjXwB3+qtuWNJ24CQnu6fZte0re5uKrWBNe1uL9B50vvpNg3zeOcB7VeaKZRW0O5vn
         kOUfEPqpbSNQcOVK8ZASPyH9rQoZlBuG1zcU41C74OOS5Qb4UdWRHCcSeuidZzJGSN3t
         zGiLc/IpAhGfGfv0VXNs41Z3VnBljj1SAFJAf6dOqpSLA1RZVFIPDzgESur6U76rYobu
         WOaShv884enB30kT+1l0t1Kf1Ys/+eNN2zY9YSTj4rGpBhTc1HehCX3TLT0kVbn0+cY4
         FILNFwfjtoLY7WnDMbV0Qnyf5hHEfYzAqi1PzQyKlHiHijb5ULuTyNxYiR9dWyKv5OpO
         ds9A==
X-Gm-Message-State: AOJu0Yy0OhwCn+GXz8Zu0pVhFiulE9qukx/N2UOcLz0A4xZtE4hHfOsU
        7xtKRePrwWAq/wBsmWSK/bkcSKEw1z3Jgw==
X-Google-Smtp-Source: AGHT+IGWIZN6tRvq2iK5UJGyhn5SyW7cCbcnJve+ssV6Vm3nSGmoNM3mEIzInHl7x7+t6TvnVVh3nA==
X-Received: by 2002:a05:6512:114d:b0:500:79f7:1738 with SMTP id m13-20020a056512114d00b0050079f71738mr5822724lfg.17.1696526144024;
        Thu, 05 Oct 2023 10:15:44 -0700 (PDT)
Received: from [192.168.0.9] (88-114-1-11.elisa-laajakaista.fi. [88.114.1.11])
        by smtp.gmail.com with ESMTPSA id n15-20020ac2490f000000b004fe2de20d88sm365031lfi.232.2023.10.05.10.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 10:15:43 -0700 (PDT)
Message-ID: <f1b8d8f5-2079-537e-9d0f-d58da166fe50@gmail.com>
Date:   Thu, 5 Oct 2023 20:15:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   =?UTF-8?Q?Tatu_Heikkil=c3=a4?= <tatu.heikkila@gmail.com>
Subject: (Bisected) Accessing opened Bitlocker partition leads to memory fault
 and kernel panic on Imac8,1
To:     herbert@gondor.apana.org.au
Cc:     linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        snitzer@kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I think you and the lists are right recipients, forgive me if not, I've 
never reported kernel bugs before. Naively this seems a crypto issue and 
Herbert Xu from crypto maintainers made the buggy commit, but it edits 
drivers/md/dm_crypt.c maintained by dm-devel people per MAINTAINERS, so 
I'm going by that.

At the center of the issue is my Imac8,1 and an external 2TB SSD with 5 
partitions: an EFI+MBR portable Arch Linux install with LUKS encrypted 
ext4 /home, and a 1.7TB exFAT encrypted with Bitlocker.

Mounting the LUKS partition works fine on all my 4 computers (Imac8,1, 
Imac12,2, two generic Intels; Fedora's GNOME gvfs volume monitor often 
crashes on mount using this drive), and mounting the Bitlocker partition 
works on all other computers, but my Imac8,1. On my other computers, I 
can boot into the portable install which automounts the Bitlocker 
partition fine. However, on my Imac8,1, regardless if I boot into the 
external drive's portable Arch Linux install, or use the Imac's own 
internal Debian testing install, any post-6.4 kernel reliably panics 
(50+ times so far, 100% of the time) when accessing the unlocked 
Bitlocker volume:

# cryptsetup open /dev/sdb5 --type bitlk crucial
Enter passphrase for /dev/sdb5:
# mount /dev/mapper/crucial temp [kernel immediately panics if I try to 
tab-complete the mount point, making the shell also access the decrypted 
device I assume, or try to run the command]

I originally ran into this when mounting using XFCE's Thunar 
implementation. Using it, the mount fails with "Operation was cancelled" 
and the system crashes within a minute.

Git bisect lead me to:
# first bad commit: [e3023094dffb41540330fb0c74cd3a019cd525c2] dm crypt: 
Avoid using MAX_CIPHER_BLOCKSIZE

If I git revert e3023094dffb41540330fb0c74cd3a019cd525c2 on current 
Linus' git master, the issue goes away. So I'm personally not all that 
affected anymore (if I'm ready to compile my kernels from now on), and I 
understand that you have no clear way to reproduce this as it seems 
strongly bound to hardware, but seems like this could point to a 
potentially serious security issue since it involves both crypto and 
undefined behaviour.

Kdump dmesg logs (the error output is not completely consistent between 
panics) & .config can be found in a dummy Bugzilla report 
https://bugzilla.kernel.org/show_bug.cgi?id=217982

Please let me know if I can help you in any way. I don't mind using this 
as a gateway to learn more about kernel debugging etc.

Best regards,
Tatu Heikkilä

