Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A437C6E97
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 14:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343952AbjJLMzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 08:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbjJLMzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 08:55:46 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C3FB8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:55:44 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66d0760cd20so7375946d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 05:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697115344; x=1697720144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+E3Ac7gLPHOZrtW0r7mt4yd7gbV2vPXiHnS0FnyfupU=;
        b=fe2aFPI9c/bWKykTe1DeD8ZuKL5S9VK1MSBGIQv7NEvGYAhBCgBuWI5+M6OHiTUqUF
         cvd8X48Bp0+KbV0Se3wJlpE7Z5ZnHBiNqcUr5bWJUH8Qy0YhULE4RGJ/svGtxqqH4YYT
         x8lr3FMrtQlEkISrR+XFMK2S+HpievBrIuuNQGDnTupCxgPng49qzyPp1/llzq0Fx3Z5
         9hEXrcNulBOH+gr+nVkfQAoMbqd8pSlmImhqIXL/ro+CPg0B0FGOpfHfvtPKFd50UsJW
         HpWKElfD/zqgNHmxFU8RGOMHsauRFjkH60ZBNWT+slc6q2X8JvwxpnBlVka4z4tPdzZO
         J1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697115344; x=1697720144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+E3Ac7gLPHOZrtW0r7mt4yd7gbV2vPXiHnS0FnyfupU=;
        b=bvVKo5/vfEF1LNATrAELp6EcG+udpLiWlwR/viH35JHHmHTHUYrFCbOefb0ZRdpd2n
         dyB+W5obEvuw4MeEBY19bj1ozFQ0Kv1TQLPLPWkqURdMFpCWBlV3sZJ5BYzT6hX9fcNW
         ejljDXT5z5TIMertLenPBTUw1aTKqNuY4+VLOs0Z6jf/0Za+0s7SxtmmMvRQPNFcXOhW
         gqn7HKa7YNLGVfITlqHPPpQaC7gUPduPMc++pjetzhjuszrhl3UwIMoYtO4w3cwXijuM
         I7tirDlTxqSXGypwWeCYnbkYFJuErUeDtdxQS60Q9gPoxkVxyfN6USTB96TpNMZSexXJ
         euqg==
X-Gm-Message-State: AOJu0Yz8VjdAEPI39jcgqLG2vDNx8jrBGpq0XTiCPIGoX+cXPuV9Ii1C
        Cd4jpaIhVGty1WZVt/YxcayTM+PoTSN225v/ktNYKxw23jrXN36TRBU5Ig==
X-Google-Smtp-Source: AGHT+IGDLoEGS2nnDulrCypMQxnwPRyxTgLF1X+qE8wh368TrzeEQKP7bUffrHNHjk7Le1LGmhPs8KNJm0lOmN27CfQ=
X-Received: by 2002:ad4:5c66:0:b0:66d:1c50:de06 with SMTP id
 i6-20020ad45c66000000b0066d1c50de06mr1136554qvh.2.1697115343972; Thu, 12 Oct
 2023 05:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231011172836.2579017-1-glider@google.com> <20231011172836.2579017-2-glider@google.com>
 <ZSbinxApgdd+aif2@smile.fi.intel.com>
In-Reply-To: <ZSbinxApgdd+aif2@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 12 Oct 2023 14:55:04 +0200
Message-ID: <CAG_fn=XO-RP7-fqnyg=6JeJRh45uGY_p1hnaF17i7R6rZXCuJA@mail.gmail.com>
Subject: Re: [PATCH v7 1/5] lib/bitmap: add bitmap_{read,write}()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I realized that the corner case with these functions is when agnostic user
> wants to read / write > 32 bits at a time without ifdeffery applied.

Shall we change

        if (unlikely(!nbits))
                return;

to

        if (unlikely(!nbits || nbits > BITS_PER_LONG))
                return;

?

> At bare minimum this has to be documented explicitly, that callers
> may have an issue of the above calls on 32-bit platforms.

Given that bitmap_read() returns an unsigned long, and bitmap_write()
writes an unsigned long, passing a 64-bit value would be a bug.
But you are right, documenting this won't hurt.
