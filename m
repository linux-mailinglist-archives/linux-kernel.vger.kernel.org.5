Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44391754680
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 05:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGODTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 23:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGODTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 23:19:22 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3D31BEB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 20:19:21 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e5da802afso3135010a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 20:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689391159; x=1691983159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bH4YNFQ85GLtLQVvtYry9jNegNVh6BuHBSS+rjBmUNk=;
        b=OJq8ZudGCI5Xr+dsQCSNVCTOjLcYwJ82eRtCM6/LTQ0lFWpf3l3ac0GF3SwEdSvlqG
         v4vsx9ZAtZkDQc4GzCpZ3y4k/L8c8Gq6FSumVGRxFjpU/ef5AbWM0pC9xpH3wPtIwCbj
         w3P3HhMHbgug0PR99rdirxzz3bEWzU4wdiAS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689391159; x=1691983159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bH4YNFQ85GLtLQVvtYry9jNegNVh6BuHBSS+rjBmUNk=;
        b=WKv34bbH1uc9TIgngGcNQApNYQZHfTNh74R75hYAo6hkESQj3XkHDmROCVMmA+oXdk
         VcHqTQL0SNOQO98UOzLxdSeeCFa1LIr5mfCTlChsrgHJSzu9OvtT2e/qkt5UCghhgVyI
         xAQonNpnSd4FVzloKy9JOdd09cz/d4chXfLU8IEUs/qCyiMp6M2LHzZgrkOX5xi9fr4l
         2EGAYln7otnXUEG4YGSLImqsm1eIAi4jfN6gzWqpDWXp1Xm3SnI3tllh5cAky7msERQ8
         UxRysAQX+672FnNbzeUAN4dawQyfJxPKSvMcMQaykVOWDzzcLALY9tf73Jx67w1Uuw3h
         pFFA==
X-Gm-Message-State: ABy/qLa3D2v/oBa308YHDJ8DjGCuKXLusqojPem0xcmEfvxWoPAjyucJ
        /FcDAwXRGaZyss/L9cXkV3TcLVTT0S1AFWLumgphcw==
X-Google-Smtp-Source: APBJJlGwOd9YsRTHVaNmbxgCP9hDpHQmbT+HOjmYzKmjB6rUAucopekUL1e8rHqkCHWvmi8D8SpSYg==
X-Received: by 2002:a17:906:5185:b0:994:572d:397c with SMTP id y5-20020a170906518500b00994572d397cmr1620656ejk.35.1689391159456;
        Fri, 14 Jul 2023 20:19:19 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709060e9700b00992e4d8cc89sm6182848ejf.57.2023.07.14.20.19.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 20:19:18 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-992b2249d82so349413166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 20:19:17 -0700 (PDT)
X-Received: by 2002:a17:906:2201:b0:98d:fc51:b3dd with SMTP id
 s1-20020a170906220100b0098dfc51b3ddmr5283965ejs.41.1689391157559; Fri, 14 Jul
 2023 20:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <ZLGwoGoJNAG6Db4v@8bytes.org>
In-Reply-To: <ZLGwoGoJNAG6Db4v@8bytes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Jul 2023 20:19:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgppEZ9SswgkQEMVA5UW8Epnc4PgKjKSo=6MEK=X70MEg@mail.gmail.com>
Message-ID: <CAHk-=wgppEZ9SswgkQEMVA5UW8Epnc4PgKjKSo=6MEK=X70MEg@mail.gmail.com>
Subject: Re: [git pull] IOMMU Fixes for Linux v6.5-rc1
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 at 13:31, Joerg Roedel <joro@8bytes.org> wrote:
>
> The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
>
>   Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git iommu-fixes-v6.5-rc1

Nope. Nothing there.

Guys, 'git request-pull' should be *warning* you if what you claim is
there isn't actually there.

Why don't people look at what they do?

                 Linus
