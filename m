Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272CA765B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjG0SlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjG0Sk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:40:58 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E7FE78
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:40:57 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so9773211fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690483255; x=1691088055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z7jzwMX75OBZa1i7S4s2/HIM8ADUnhblxgK4MJrr7eA=;
        b=IP+OPeSoLZsl9bUrnqCJgZpMU7J6inijbFd1f1FHsVZIfQ6T5UDg9ndLJ8BXaIFWc0
         aklpGbj8uCl0Z9jINNHwoNwsb4SG5G6tuDzxGBZA3wLL39CNv9MJtkX/X9XASa9NLNIq
         bJBqFSTth9b8ddrdGJtUYanjlOLuykk9L/Kcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690483255; x=1691088055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7jzwMX75OBZa1i7S4s2/HIM8ADUnhblxgK4MJrr7eA=;
        b=V68+nRHQ885voqvJCI679CobRVO/qKOF2QHR8hm9idYP7zEAo5bdt0I2ZkAVKLMVSt
         mLOdL9REfQqvMoQWfIdXb7QVdaylr4YiPXqKXq2PLIBTIbmYnEtOEVd6QnR8pUJf6mLg
         pRRViOkLQUcxO0ljgJn6q7zbhYSXuXd9JUABWovM8tJ3omiFJz4BmYk7TKmH/rTG3Z/5
         4ndg32ilyQjK23fD3CAdDPQe4PVgATcKzudBpu8RoOplZ/b8gvoo7mSBcUNzP3fjFduS
         Lb+Gf2pIaMG2G7+p8emthBsJB5xJF+SGeV0aEBMo0VZZGZEveIpK/m3Stx3PGZc1Cchq
         cCDw==
X-Gm-Message-State: ABy/qLZq5ywQ+RyBVQiXg7a9+p5z6iMPdFu59xAqDTLajab1Q39wAca2
        niKalv8NEpPec1qiZ4naXTD3CAJpPAVpCwZViebZKDrK
X-Google-Smtp-Source: APBJJlGjfRfP2emQD63gCHOiNp+Rew5XdIJ7J0B70PqAG2AIo/3rrl+NMi7vTt7+wcOx/1CFcgGhJw==
X-Received: by 2002:a2e:a0d6:0:b0:2b9:35ae:c9ac with SMTP id f22-20020a2ea0d6000000b002b935aec9acmr2721617ljm.2.1690483255268;
        Thu, 27 Jul 2023 11:40:55 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id d16-20020a2e96d0000000b002b724063010sm490476ljj.47.2023.07.27.11.40.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 11:40:54 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4fdfefdf5abso2271453e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:40:54 -0700 (PDT)
X-Received: by 2002:ac2:4f0c:0:b0:4fe:db6:cb41 with SMTP id
 k12-20020ac24f0c000000b004fe0db6cb41mr5663lfr.39.1690483254208; Thu, 27 Jul
 2023 11:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230727045831.GB1901145@kernel.org>
In-Reply-To: <20230727045831.GB1901145@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Jul 2023 11:40:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibj_bK801fb8i=sceNQSymOxqvM=nT2esjxG-fHOyimg@mail.gmail.com>
Message-ID: <CAHk-=wibj_bK801fb8i=sceNQSymOxqvM=nT2esjxG-fHOyimg@mail.gmail.com>
Subject: Re: [GIT PULL] memblock fixes for v6.5-rc4
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 at 21:59, Mike Rapoport <rppt@kernel.org> wrote:
>
> memblock: reset memblock.reserved to system init state to prevent UAF
> [..]

The merge message shouldn't just be a repeat of the commit message.

I ended up cutting it down a bit, but would prefer to just get a
concise summary rather than the repeat of the message for the fix.

              Linus
