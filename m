Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F9981234A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442687AbjLMXkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbjLMXkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:40:05 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7C31706
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:39:04 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1f6433bc1eso11417966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702510711; x=1703115511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khBmMizas9gxTRli+QPr2dO7hNeCzSMKNFFwhsbIguQ=;
        b=X4dfQZ2AJdj3WsTroyJAt7UQihZJJk0GuJNDMHrQ/FqRjoNROQce4AkdlcdxxjufxH
         9NBbJKe05XPtTzpb8Ak18Ar6vdB5ijDo4O1HZePt+yi6eDrPnn0mt1+iUyoMSAQnX0pm
         dIxs56wtxYcBHUjK+dsir9DDa+eL9Ax1AGHmgFtSSqpzXX9W5TyAJDsg1cKhgrBTqzS1
         c3xNyjTpFV38SzxkpJ+AcuNKff2NPR868ej6Uh28yx3wYhSmTTW6A/zQxSR9ppuDa3zK
         sXJMCgNh/9hBH1e95pgGC/iBltU3cXZfNT7yuSo2t20f/zPeNJrpoc3sjykDJ8NXmi8g
         nTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702510711; x=1703115511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khBmMizas9gxTRli+QPr2dO7hNeCzSMKNFFwhsbIguQ=;
        b=mQ/uAcBAHsIaRkdug0LWamiNUqYLjbxozFBTDkZjQfIbFGea6mEylGsEuxRwU+1e3m
         lZxF+cqIyXtJ+TFpAckkvHszFnSuvfUI6xqDh9O+Jc1sHkDsSA6Xh6Fs1L8RucnIwnwt
         mFIuD0N3Mf9teYNWW+FPF3/oz1qwVa1nLBrvAzBPymkGY1+3/1Q5ZjumCBae7NC8S6wq
         qFvpWc6fKkGbdJr7mOWdezGkUFFb7mUArMfMSN4C/1PZKLtNpR5PHHRtoBNwfK0NIjuT
         iTM5A09BnVTCJHxpjgk1JDcLVboPm4Hsn3ovBdtypnTONw9OUmViA6yMe9719UDA6rpi
         pcpQ==
X-Gm-Message-State: AOJu0YyzTPNWJXt/Zc7iioa/mXdTSjhU0wEBee/kJ1hKoNI5hydZlW7Z
        25i+bZRdRmboXtN5MQs7lPUr1PQkMMuGBC0MnQGL7A==
X-Google-Smtp-Source: AGHT+IHyfcctpaOGCbgl20TU191uLxWgu6dKSBEraZPkN8kPrLIJZsuGFaf9QjriDYu1iEALgMD30ywF0wx6UgxW+Dw=
X-Received: by 2002:a17:907:831d:b0:a1e:11ea:ee15 with SMTP id
 mq29-20020a170907831d00b00a1e11eaee15mr5701389ejc.77.1702510710830; Wed, 13
 Dec 2023 15:38:30 -0800 (PST)
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com> <20231213-zswap-dstmem-v1-3-896763369d04@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v1-3-896763369d04@bytedance.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 13 Dec 2023 15:37:54 -0800
Message-ID: <CAJD7tkap6qRarSr=7+9NYCEjXKt1umdaqK6QsnPrE-y3qU0PSA@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm/zswap: refactor out __zswap_load()
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>, Chris Li <chriscli@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 8:18=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> The zswap_load() and zswap_writeback_entry() have the same part that
> decompress the data from zswap_entry to page, so refactor out the
> common part as __zswap_load(entry, page).
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Great cleanup,
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
