Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A567C7A2F8E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 13:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbjIPLMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbjIPLMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:12:14 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60E91A3;
        Sat, 16 Sep 2023 04:11:53 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-570e005c480so1681543eaf.0;
        Sat, 16 Sep 2023 04:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694862713; x=1695467513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=raj3TFvnsTRGxNUO3J84IQFAMSMyIEU1QWAtfpvgdzg=;
        b=GR/KI80mTh9BU1MiBXycv3GG6jjJ02aNLdkSp/llq9q8MHUBCT7DXEqzplPQXhJnJ3
         +Te6LyANJ7AH3Ewf2/mENyE70gAjpL1je0KvJ+ogBlF7ff1U8t2QV97OjoKH/ibewCuB
         DVFni/77EHGNycBtuNhs1gZVqkmcdmpq4vxOIWigMVyTABNfsicsoJ2YEO6Fn/EhyX2V
         CCdcASgIPWHLO8w6q7+oQbTN2+Sl3YkR2Y5Q1sFBToULLHEhpI/sDI5tdNMy4z8sc7bT
         iT2xVP7rrtcGP2NWIUCaxJL+ceiLmlvsC+QytloyBPtdEU4zB9oif8Xey6IVdGr6hHbO
         Vaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694862713; x=1695467513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raj3TFvnsTRGxNUO3J84IQFAMSMyIEU1QWAtfpvgdzg=;
        b=kT3D7gljkSdRfslRRudMFUw8Y0KT4AF3nC7PC8qHJwzKyMHqHETcBE4xMJkFoN6ZBk
         bW3ZW7g7NOSPHaHXtIfOqxf/amERPm2H2prGxaAQ/lC9nm+KSemx7eKd9/Qkp72xi4i5
         wsLZljp/jO/pO5nHOrEjVPUxJTCl2ZiqgE93bJl5J559Vo56pX9PwaiL5lnCvcJIeLgu
         BxfGFf9NPB811Ub3ZJH3tavgEDY7jW6jZctQQ9pEF5Evdj5jU9YRkkIqf0PqZv2Z99Ln
         kOHCK6LOoD6jdmhA3hoa8GzGNBbhUtCduIwGZ3ymjk+3J3XKrSum+QgLKzt4K2p8TLG7
         R3Yw==
X-Gm-Message-State: AOJu0YwVIcErM3BkLMtEJnP+qGBUTpC6/VAcWiVU7WUn8yph+O5Qg1Uv
        WBJmTlvd1RN4o6TxdRrb3El9e4crmlc+t93T83w=
X-Google-Smtp-Source: AGHT+IEh5zot1C9twPgQH0TCMIzvmtoPp+rkBGKw6bJ/ouiLnnc1kXxpxnamnt+ba+Oaao2HpUSukyQRjS4AH/MtIGE=
X-Received: by 2002:a05:6870:eaaa:b0:1d5:8d8b:dcc with SMTP id
 s42-20020a056870eaaa00b001d58d8b0dccmr5278739oap.18.1694862712665; Sat, 16
 Sep 2023 04:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230916091125.3221-1-wsa@kernel.org>
In-Reply-To: <20230916091125.3221-1-wsa@kernel.org>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Sat, 16 Sep 2023 13:11:41 +0200
Message-ID: <CAOiHx=kLQzTTzuGM0tyuv=e9J3Oi7EbWWYFRK5mEfqNrVj05NQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] vlynq: remove bus support
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sept 2023 at 11:18, Wolfram Sang <wsa@kernel.org> wrote:
>
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> I'd like to clean up the 'drivers' directory and Kconfig menu, at least
> a little. One major thing I noticed is that VLYNQ can actually be
> removed. From patch 2:
>
> ---
> There are no users with a vlynq_driver in the Kernel tree. So, remove
> the bus driver which hardly has seen any activity since 2009. It was
> even marked EXPERIMENTAL as long as that symbol existed. OpenWRT had
> some out-of-tree drivers which they probably intended to upport, but AR7
> devices are not supported anymore because they are "stuck with Kernel
> 3.18" [1]. So, this code can go nowadays.
>
> [1] https://openwrt.org/docs/techref/targets/ar7
> ---
>
> Patch 1 removes MIPS specific bus initialization code which is the only
> user of the VLYNQ bus currently.
>
> Sending out as RFC to gather comments. Patches are based on 6.6-rc1 and
> created with "--irreversible-delete" to save some space. They are
> compile tested only, buildbots were happy.
>
> I think this mainly goes to Florian Fainelli. Florian, what do you
> think?

I'm not Florian, but I worked a bit with AR7 as well, and going
through the (previously) supported/known devices they topped out at 8
MiB Flash and 32 MiB RAM, which isn't enough to run any reasonably
modern OpenWrt even if one would be willing to re-add support for it.

So from my perspective I suggest even dropping the AR7 code entirely.
I seriously doubt anyone is running a modern kernel on that.

Best Regards,
Jonas
