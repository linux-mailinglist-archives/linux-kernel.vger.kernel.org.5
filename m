Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20884759522
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjGSMbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGSMbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:31:01 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 660EB186;
        Wed, 19 Jul 2023 05:30:59 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3489cd4e3d3so6469555ab.3;
        Wed, 19 Jul 2023 05:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689769858; x=1692361858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nyelAFhBqC7a6h8KFfAv2WQuGfH7nEdJ9cZtx3ZPD3w=;
        b=VE7iNtpws7j28phGM9tm3pz1NUfmwVl2IllYO7nmxLTE1LTAnZYvR8lfo+6QeFbnc1
         Wg/Ot6iaw/8lS5AylTLNd818zyyDsQXk178XLYrRAS4FXB+fG3PduHE+8rdCfLyAbKOR
         gLFAQeKv7Qvo2u6+2/aEsu4FhZ4u3ROPSFYmNXi1UsVYgviHfKb/ehXra0xET61tuTdC
         Ob8vZhpQVnSqud6YGJKSt/fQXVlwQg4suNwwTQruBSlxeujuSdAb2oB0WNIiGamikdHK
         PneVoOCo22TaTlJ8bOK+SPd5zNFnFNxj2ginv4HSDuOmlrr6l8wwkdV2G3f6dgXR7Cce
         xAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689769858; x=1692361858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nyelAFhBqC7a6h8KFfAv2WQuGfH7nEdJ9cZtx3ZPD3w=;
        b=JrFnImcVJQ2NZ5B/AD8M3r0kBJLxEY8oYt9NyIIhPfphpDawPPOp+c3wEvkpF8hpG3
         irFT5OaSbqxI/qbNc0cUPLQOhSe0LpVh5BTIffHFt4uEJYXh7heNzSebdBi9WyJXYxIj
         AvYHQMgVGcSsvncAeoDDsxOLPjc/5TA7l1RWyPZLFLVV9sD+zBs/ct2gLGbzGlRS9932
         g/rNQeqtSPK+qq8I//Wdwt1OuFTAIRly0UPVPF+p9LVB9E9DB/0D9x6aDT8yDkI9DHRM
         QJLPifZnXIeHc5Csvm27cq0U0M61wNJbZ1ms5Mfe4TJvk4NqyOD8RrluGz7DXswIwEg9
         tQ7w==
X-Gm-Message-State: ABy/qLYKMBYm8IWGKgpEMBitlOHEt+Kv6329dS09BSRkTcaT6dJ6adJ5
        8T/ak2nTKRsnUoSz9M4Oh5I=
X-Google-Smtp-Source: APBJJlEMyFO+3pdtjDtXrJi07Y2AVy0m52kCGiLm+w9lvt8THgUVqbEF3FDdma3ZuPO9yaElS6E6hw==
X-Received: by 2002:a05:6e02:1bc8:b0:348:90e2:750a with SMTP id x8-20020a056e021bc800b0034890e2750amr2650304ilv.8.1689769857778;
        Wed, 19 Jul 2023 05:30:57 -0700 (PDT)
Received: from [192.168.0.104] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id mr1-20020a17090b238100b002676e973274sm1211434pjb.0.2023.07.19.05.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 05:30:56 -0700 (PDT)
Message-ID: <4759e7d4-5a8c-8acb-1775-e049b9b06cc1@gmail.com>
Date:   Wed, 19 Jul 2023 19:30:46 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fwd: Unexplainable packet drop starting at v6.4
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
        Krystian Pradzynski <krystian.pradzynski@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, hq.dev+kernel@msdfc.xyz
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Intel Ethernet Drivers 
        <intel-wired-lan@lists.osuosl.org>
References: <e79edb0f-de89-5041-186f-987d30e0187c@gmail.com>
 <444d8158-cc58-761d-a878-91e5d4d28b71@leemhuis.info>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <444d8158-cc58-761d-a878-91e5d4d28b71@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 18:49, Thorsten Leemhuis wrote:
> On 18.07.23 02:51, Bagas Sanjaya wrote:
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>
>>> After I updated to 6.4 through Archlinux kernel update, suddenly I noticed random packet losses on my routers like nodes. I have these networking relevant config on my nodes
>>>
>>> 1. Using archlinux
>>> 2. Network config through systemd-networkd
>>> 3. Using bird2 for BGP routing, but not relevant to this bug.
>>> 4. Using nftables for traffic control, but seems not relevant to this bug. 
>>> 5. Not using fail2ban like dymanic filtering tools, at least at L3/L4 level
>>>
>>> After I ruled out systemd-networkd, nftables related issues. I tracked down issues to kernel.
>> [...]
>> See Bugzilla for the full thread.
>>
>> Thorsten: The reporter had a bad bisect (some bad commits were marked as good
>> instead), hence SoB chain for culprit (unrelated) ipvu commit is in To:
>> list. I also asked the reporter (also in To:) to provide dmesg and request
>> rerunning bisection, but he doesn't currently have a reliable reproducer.
>> Is it the best I can do?
> 
> When a bisection apparently went sideways it's best to not bother the
> culprit's developers with it, they most likely will just be annoyed by
> it (and then they might become annoyed by regression tracking, which we
> need to avoid).
> 

I mean don't Cc: the culprit author in that case?

> I'd have forwarded this to the network folks, but in a style along the
> lines of "FYI, in case somebody has a idea or has heard about something
> similar and thus can help; if not, no worries, reporter is repeating the
> bisection".
> 

Aha! I missed that point. I already have networking folks in To: list.

Thanks!

-- 
An old man doll... just what I always wanted! - Clara

