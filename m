Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBDE7B1632
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjI1Ikv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjI1Ikt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:40:49 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D67AC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:40:44 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso9693427b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695890444; x=1696495244; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBf/n8oQr3zotF0kuExdKxVGO0tvQwtR7Cs+ipQs5qY=;
        b=biOgeE1QnOHp5ALBE/vgK75C3huo1FypyiD3ssXaYvpYp3oahjV3DUfT9bjK2GFC+6
         ppki+6S0JGC9M4C5BiQlm7xEr5w/rM9gMoeCFxVOWs8IcOPr/2ldbBfXLhmCjiwC5Jvu
         xsTrbGUgtuIS69D2LZe6kE+HwG7605aYf1G+7JoWoWN+EVE/OAzPKfv+Wt6iNqtm/fSk
         9Es5CU1RJA6tHjraJ8YcF8iIkJtjoFa6/IdpsZFRvM7sD1gfixx96eMSOjwK3FUpzU8H
         EjiR9hre4VRunFof+aN0DpqJ8s+sc4spRzurS5S9SYeB7uqLY5sLyX6VtqOqsupxI9Wl
         a8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695890444; x=1696495244;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XBf/n8oQr3zotF0kuExdKxVGO0tvQwtR7Cs+ipQs5qY=;
        b=fCP2u6/O4HwoaYxd0isszCcOJZAau+cVuGl5WTD9aDJn/LxyRZ/vQbWAhLEOf3d2Li
         TrXDEWfQloVk172r6IDYWbOjMnEg6E41Dwlx7lxKvYLP6dCnj8bl37RXXmdOakA3JI6Y
         qObpmwS4Dz0UHbt4QW6aBwmfSAolGtAynwlfdNUp4XJZyjJoYnP0EWQfvQhfnHwYb57g
         q2er4Gl5iCOGp4pFjRIB/aw3OC/L66Kn3jv1DVXSmV63PjsuT9yTiMZxBgt9NpPE6+ou
         pz3gQRsT4xV69saEF+TWBxbEhD9Vhve7Bg8PuyokvPDB/KCO8rG5O+nPis6tIsqyy01U
         nE0A==
X-Gm-Message-State: AOJu0Yz6UtgKw1ayMUOTMAIpdErcOukm/J39DnsNfS8tVanEdWoqLXwE
        EVoZTdPAmRchs4Rs1uUI7skeihuOfMhnxA==
X-Google-Smtp-Source: AGHT+IGjFz36JCOcZVg+0sU6TURqLI/8MmfIg+s73OOjJ6Rx9mZPPYZZgOGqj9IoUQDXt4W80p9wPw==
X-Received: by 2002:a05:6a00:849:b0:68c:44ed:fb6 with SMTP id q9-20020a056a00084900b0068c44ed0fb6mr1019514pfk.16.1695890443798;
        Thu, 28 Sep 2023 01:40:43 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id o28-20020a637e5c000000b0057cb5a780ebsm10756666pgn.76.2023.09.28.01.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 01:40:43 -0700 (PDT)
Message-ID: <4f01f302-9d59-4146-b7ff-0478c4bd94b1@gmail.com>
Date:   Thu, 28 Sep 2023 15:40:31 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, freeze0985@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: kmalloc memory leak over time.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Since 1st weak of Sept I have been observing memory leak in my system, so after doing a little big of digging I found out that the leak is caused by kmalloc. In Linux 6.5.3 memory leak would increase  to nearly 50% of my ram over a period of 6-9 hours. In the Newer Linux 6.5.4 I am yet to observe that much memory leak(Haven't used my laptop for that long till now) but over a period of 3 hours I see 2.2GB reserved and it is not used by any program at all. this is just after 3 hours of usage on Linux 6.5.4.

Later, the reporter (Cc'ed) narrowed down the version range, with
memory statistics:

> 6.4 works fine I down graded to it before linux 6.5.4 was released. no memory leak.
> 
> today i ran my laptop for 6 hours and 40 mins and this memory leak is still happening at same rate.
> 
>               total        used        free      shared  buff/cache   available
> Mem:            15Gi       7.2Gi       2.8Gi       797Mi       6.4Gi       8.1Gi
> Swap:             0B          0B          0B
> Total:          15Gi       7.2Gi       2.8Gi

See Bugzilla for the full thread.

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=217943

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217943

-- 
An old man doll... just what I always wanted! - Clara
