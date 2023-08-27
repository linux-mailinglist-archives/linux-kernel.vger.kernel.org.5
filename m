Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FA8789B8A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 08:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjH0Gcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 02:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjH0Gcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 02:32:36 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1104183
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 23:32:34 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34cabf65ee8so175545ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 23:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693117954; x=1693722754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46Kz9XaOZhRSt2LZiFIcGLkpeJb4xlrXSqwcC76fZA0=;
        b=wrVPueddG0tJ7UHU63wsaau+h7mvneuNEN7Tr3guksM6Ow3+fSyCj5fPmehbb4heER
         tentrE7bVzsovXZecdnOeLSyOGPTxFlUfFY/qJaz6ZLqda2yV6jPAwT72nxtTJ+5xoMJ
         y+VBJ6eDZVQSX4jYuDeKc/HVHBnmR0qkyRO36K5orj5uegwNPcpqRZ1deUfXJQr3ulmt
         QAiunXR9EWNnEk9TOPWrCdfYBsRpm38jTHbYdvj5AFcf1rkShw2YEyj3+xmOUTxqX/Hg
         ZuD3P6bm2dghOQOH28+Ke2nIUZG+dNWwJAntTX9ZpW0hpSNRAezi7uQNXWUy3Ad3D9dJ
         eIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693117954; x=1693722754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46Kz9XaOZhRSt2LZiFIcGLkpeJb4xlrXSqwcC76fZA0=;
        b=P+LILGR08VmR3/m2joToJy5ACWz0VxID0qYR+kVk9mTM9BUgELq6nMA7WEkMDDssrc
         Bs6sOVsJ02jFH9TkgssO/bAtQAAelTbytUDyX1bTO1hhY43tQg/ZAWZaVZLH1emKu10T
         82ljFIrftMcii03nptawod2QiPPF3Uaq/z+wJK0ETMIzMAz/XUp653zsv6ob+jIRhR+9
         HSMM1MB45nk1mZ5TM4/aUrXzvZbqSYYTkTe7BtNoTy6nAjhzuR9me6FeA5rFdPW1EiVf
         RlfSjH2n3kVdp5vfBkBJ0gyqyuuF8WMicOx1DtZIkqsFJW07bTw5QhuzQm6kU2xR7Bcm
         nIbA==
X-Gm-Message-State: AOJu0YyFYrFW24iyL6AUA126Js4CpbkvDJpoT9YlOXtA9IBL1DIFfvj9
        AtP7yKkzyD9tys57e+pQ4iypK6vZkQiEyehuHKjeGJkYqfBme7BBxas=
X-Google-Smtp-Source: AGHT+IHuFkZUKA0NDt5ZDd/zxd9o6xzOXTyJO/MvnZU0xaxOfo7L4jSLFEcbGeenaDqScgAoHY9aco8aOLNYLyz9eeg=
X-Received: by 2002:a05:6e02:1569:b0:348:f9a8:19d4 with SMTP id
 k9-20020a056e02156900b00348f9a819d4mr188820ilu.29.1693117953852; Sat, 26 Aug
 2023 23:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230823170556.2281747-1-mjguzik@gmail.com>
In-Reply-To: <20230823170556.2281747-1-mjguzik@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 26 Aug 2023 23:32:21 -0700
Message-ID: <CALvZod5-k7fD6ESGOrXx1-2mp_c2ifmH9ex8n0GG6L+LA9EbHw@mail.gmail.com>
Subject: Re: [PATCH] mm: remove remnants of SPLIT_RSS_COUNTING
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Aug 23, 2023 at 10:06=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> The feature got retired in f1a7941243c1 ("mm: convert mm's rss stats
> into percpu_counter"), but the patch failed to fully clean it up.
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
