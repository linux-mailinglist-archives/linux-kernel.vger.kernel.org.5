Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F4D789B02
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 04:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjH0Chg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 22:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjH0Chb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 22:37:31 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9248C18E;
        Sat, 26 Aug 2023 19:37:27 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57355a16941so944084eaf.2;
        Sat, 26 Aug 2023 19:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693103847; x=1693708647;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZGOqorazSp+I1MKjY1gVz7xYjbzwYMSJxTzcyCljzo=;
        b=OPBaC6TiPZ50X9Puq1TDuSWAMR9dhpAx1Jd9KmmBXToJBmzhB0F/i4qOQtOVSA7VI8
         CMoT/MpVFa83wr0JQAwnB0wd3yz0gB+1iJIBOq00TULCQlx4SdPrnmEj88Fts4+48jt5
         qrTlydjGQeXamK3TD1xNdJKoAq690hZnY0oRsCcNcAvgC2wCCd2dX9OfwxlYb3PxzTJx
         Yqbkbab5fH4pj1qO4gszaH28eNgUpPk1QiLZ/DA2T7jz2yiUgaj5BTWPYzjft97643po
         PPX2/b3058RdlpwALuhoU1mMByGccPCCKVJgbVOe9O9OMJhiIH1PZJHKvnpqH4lIdfGQ
         240Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693103847; x=1693708647;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VZGOqorazSp+I1MKjY1gVz7xYjbzwYMSJxTzcyCljzo=;
        b=jePAtAqEyajjAHWi/AearJge6PEWqDdZo0ISwYlPurNI3QB9tHWG39QTNGxB0RXTI0
         0ERcVLo2dgfitcA3vR7U1rnwHiFfpPVdYpR+CE+dOSKL/T2E7DT3/vHAcptfJ1Be8kvT
         fcsZtF1YcwgIYcKyx+fB0s/fbsJyMr9cXzwoi5hNV7QFDLBjIZ/m7oKqv+EJyrqCh5hz
         kA08zh87VMMqXUx/en4rzm4I6oAjg8kwPGpSx8/IaxuSuokY3U5dIRJkZfD9p2KAucdU
         3vOWwYDkf1gOGmu9ypjFqCNhqzvvzNx0x5l2666b24p4ty+wgTllhHdEHxXITfp6+tfJ
         UOqw==
X-Gm-Message-State: AOJu0Yx2gRiJ0ZOfnOZJP9PbTZhgsbZ13lxjpg9t7xLLUrcftmjG2NZo
        bOi4rLes+RtrfmYdu3w2LzIWQVCUSDc=
X-Google-Smtp-Source: AGHT+IGeYO4GsiwQZbi7GrBe/9XKREJ4gAcr0G77cOje1bpL7RoMtD7mVFJvF/YYCfNxLS9ldun1bw==
X-Received: by 2002:a05:6358:949f:b0:134:c4dc:9e28 with SMTP id i31-20020a056358949f00b00134c4dc9e28mr25951691rwb.17.1693103846781;
        Sat, 26 Aug 2023 19:37:26 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001b5656b0bf9sm4421249plg.286.2023.08.26.19.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 19:37:26 -0700 (PDT)
Message-ID: <5a7f2a6e-46a4-a5c8-fe6a-c2581496b5cd@gmail.com>
Date:   Sun, 27 Aug 2023 09:37:21 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        Brett Hassall <brett.hassall@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: 5c8a79e8e12b ("wifi: rtw88: correct PS calculation for
 SUPPORTS_DYNAMIC_PS", 2023-05-27) increases CPU usage usage for irq
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

> This commit improves power saving - it enables the kernel to achieve package C8. To achieve package C8, 3 Ubuntu VMD commits must be applied as well. The combined patch for the 3 Ubuntu VMD commits is attached (just in case). Package C8 lowers power usage on the laptop from 5.6W to 2.6W.
> 
> However, a side-effect of this commit is that CPU usage for irq/155-rtw88_pci has increased noticeably. This commit was introduced in 6.4-rc6. To confirm this commit is the cause, a branch was created from 6.4-rc5. This commit and the 3 Ubuntu VMD commits were applied. The resulting kernel was built and tested - it can achieve package C8 and exhibits the increased CPU usage on irq/155-rtw88_pci.
> 
> Booting and running top for 30 min with the system otherwise idle, gives these results for CPU on irq/155-rtw88_pci:
> 6.4-rc5     - 00:02.9, mostly   0% and 0.3% displayed
> patched rc5 - 00:13.4, mostly 0.7% and 1.0% displayed
> By comparison, an 8th Gen Dell with an Intel WIFI has CPU usage of 00:01.7 under the same conditions.
> 
> Laptop is a HP 15s-fq4011TU 11th Gen (Tiger Lake) Intel with (from lspci) Realtek Semiconductor Co., Ltd. RTL8822CE 802.11ac PCIe Wireless Network Adapter and Intel Corporation Volume Management Device NVMe RAID Controller.
> 
> Ubuntu bug https://bugs.launchpad.net/ubuntu/+source/linux-hwe-6.2/+bug/2025040 provides further background.
> 
> Please advise if I can assist with further testing.

See Bugzilla for the full thread and attached proposed patch(es) that fix
this regression.

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: 26a125f550a3bf https://bugzilla.kernel.org/show_bug.cgi?id=217828
#regzbot title: correcting SUPPORTS_DYNAMIC_PS calculation for rtw88 increases CPU utilization
#regzbot link: https://bugs.launchpad.net/ubuntu/+source/linux-hwe-6.2/+bug/2025040

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217828

-- 
An old man doll... just what I always wanted! - Clara
