Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E32A75711B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 02:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjGRAvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 20:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGRAvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 20:51:52 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5EA172C;
        Mon, 17 Jul 2023 17:51:37 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a425ef874dso3636102b6e.0;
        Mon, 17 Jul 2023 17:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689641497; x=1692233497;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lz+8CarDNbfuh8OfKKezu1WG0K0jECzwZysn86ImSis=;
        b=EZApaMs4gPJVrUIaeSPlMHa2Ubxx+ljVSgRceCanZxrxGNNKcrHVRdwxqf+J/i93eS
         bCVCmkZGoBTZIrpNuD7CYzc3Vd6qp+GujdSJoHFaZnudn11SQ22BfE3l/Rgd9in/Dlgq
         OxKFNtL93tIqLR/181oyic7HVL4EIEmsi6FsT2n1n8790US2gL6QHJke2g5bj7niI1YT
         47JlDZF/+b7YI7ApdN9OgTGyXQvEfGFHlRZ79pUoaS5fSUOdlnYK3KZN6KlM4PNB5G4D
         pZHZKTjVpoljidyzHjHOC6/wblYRuPi6qW6/WvfnrnEAP5HeSi57xsmv8NeKpRv+0OqW
         WVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689641497; x=1692233497;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lz+8CarDNbfuh8OfKKezu1WG0K0jECzwZysn86ImSis=;
        b=boOZ5Zaq/DsoYpT/nXnUf/QM9rXdnCxuGdYQp+R+1fsJQkPzmEGbu9jmTOdLt2afib
         V3APiPwj7WLMR8JsMkYE0Lj/vR4A2IJ0EgNOfbLk1UJdVZVd6ccNhUAEnYcMo7cFCJg2
         AivQQ+KsuZuqeSQJtynxN+JBV7yyXrfcQwsp3T5ZxbRhkBJNrj3UNl/Y+QwTkSV3h/wf
         GYIHWKH8+rG1n9czv0Av2D+G/N8WD12gnBMwqi22BUiihRJgi0An4u5jFsbUjZU3CsuH
         KfN2XdHdSpaCPpSVpO0E0N+I15C3ZT8cj6qiQeAsApspquv1gmW4qrFhHzn89GzG6GIo
         g/MA==
X-Gm-Message-State: ABy/qLYSILTP3Dp7FXQpp2nBqG5Em5JWciT/4zjDK76VcEp3DLQjuvCv
        4B4qjs9Ba0y+mmw21h4qloo=
X-Google-Smtp-Source: APBJJlGeBHqkRxL+zWXusQBpUdihf6v3b11hnUADferAFcbDtzk1JOfTMdtHdDSOktc+ANmDRfwJnQ==
X-Received: by 2002:a05:6358:6f97:b0:133:a8e:6feb with SMTP id s23-20020a0563586f9700b001330a8e6febmr9453004rwn.12.1689641496991;
        Mon, 17 Jul 2023 17:51:36 -0700 (PDT)
Received: from [192.168.0.104] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id j7-20020a62e907000000b00673e652985esm53912pfh.44.2023.07.17.17.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 17:51:36 -0700 (PDT)
Message-ID: <e79edb0f-de89-5041-186f-987d30e0187c@gmail.com>
Date:   Tue, 18 Jul 2023 07:51:24 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
        Krystian Pradzynski <krystian.pradzynski@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, hq.dev+kernel@msdfc.xyz
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Intel Ethernet Drivers 
        <intel-wired-lan@lists.osuosl.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Unexplainable packet drop starting at v6.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Hi,
> 
> After I updated to 6.4 through Archlinux kernel update, suddenly I noticed random packet losses on my routers like nodes. I have these networking relevant config on my nodes
> 
> 1. Using archlinux
> 2. Network config through systemd-networkd
> 3. Using bird2 for BGP routing, but not relevant to this bug.
> 4. Using nftables for traffic control, but seems not relevant to this bug. 
> 5. Not using fail2ban like dymanic filtering tools, at least at L3/L4 level
> 
> After I ruled out systemd-networkd, nftables related issues. I tracked down issues to kernel.
> 
> Here's the tcpdump I'm seeing on one side of my node ""
> 
> ```
> sudo tcpdump -i fios_wan port 38851
> tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
> listening on fios_wan, link-type EN10MB (Ethernet), snapshot length 262144 bytes
> 10:33:06.073236 IP [BOS1_NODE].38851 > [REDACTED_PUBLIC_IPv4_1].38851: UDP, length 148
> 10:33:11.406607 IP [BOS1_NODE].38851 > [REDACTED_PUBLIC_IPv4_1].38851: UDP, length 148
> 10:33:16.739969 IP [BOS1_NODE].38851 > [REDACTED_PUBLIC_IPv4_1].38851: UDP, length 148
> 10:33:21.859856 IP [BOS1_NODE].38851 > [REDACTED_PUBLIC_IPv4_1].38851: UDP, length 148
> 10:33:27.193176 IP [BOS1_NODE].38851 > [REDACTED_PUBLIC_IPv4_1].38851: UDP, length 148
> 5 packets captured
> 5 packets received by filter
> 0 packets dropped by kernel
> ```
> 
> But on the other side "[REDACTED_PUBLIC_IPv4_1]", tcpdump is replying packets in this wireguard stream. So packet is lost somewhere in the link.
> 
> From the otherside, I can do "mtr" to "[BOS1_NODE]"'s public IP and found the moment the link got lost is right at "[BOS1_NODE]", that means "[BOS1_NODE]"'s networking stack completely drop the inbound packets from specific ip addresses.
> 
> Some more digging
> 
> 1. This situation began after booting in different delays. Sometimes can trigger after 30 seconds after booting, and sometimes will be after 18 hours or more.
> 2. It can envolve into worse case that when I do "ip neigh show", the ipv4 ARP table and ipv6 neighbor discovery start to appear as "invalid", meaning the internet is completely loss.
> 3. When this happened to wan facing interface, it seems OK with lan facing interfaces. WAN interface was using Intel X710-T4L using i40e and lan side was using virtio
> 4. I tried to bisect in between 6.3 and 6.4, and the first bad commit it reports was "a3efabee5878b8d7b1863debb78cb7129d07a346". But this is not relevant to networking at all, maybe it's the wrong commit to look at. At the meantime, because I haven't found a reproducible way of 100% trigger the issue, it may be the case during bisect some "good" commits are actually bad. 
> 5. I also tried to look at "dmesg", nothing interesting pop up. But I'll make it available upon request.
> 
> This is my first bug reports. Sorry for any confusion it may lead to and thanks for reading.

See Bugzilla for the full thread.

Thorsten: The reporter had a bad bisect (some bad commits were marked as good
instead), hence SoB chain for culprit (unrelated) ipvu commit is in To:
list. I also asked the reporter (also in To:) to provide dmesg and request
rerunning bisection, but he doesn't currently have a reliable reproducer.
Is it the best I can do?

Anyway, I'm adding this regression to be tracked in regzbot:

#regzbot introduced: a3efabee5878b8 https://bugzilla.kernel.org/show_bug.cgi?id=217678
#regzbot title: packet drop on Intel X710-T4L due to ipvu boot fix

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217678

-- 
An old man doll... just what I always wanted! - Clara
