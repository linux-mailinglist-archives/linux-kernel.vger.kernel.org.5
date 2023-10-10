Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CB87BF7B1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjJJJoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjJJJnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:43:55 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122A193
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 02:43:54 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-495c10cec8aso2191535e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 02:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696931033; x=1697535833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2fKuiCMvUcJ4cs8+YpbknatJpCqd+eHlKiOKGntdOwk=;
        b=NxQ7ycteAPIlC7/MO08eip5J0XMU7uup1OKyzM8x+XUZ1amS5a4thUHoGRBB0IwPQf
         GAcPiYTg8U81Jw3NiKIYi5gWCy8zIs4JWk0Tot79J74lUd95aZRdwlaV4NBkNJWYm+20
         83wZ6XUK5mXvFnvWfzO6n5vnQZDpcAZOobgWBa5/QWIZWCIJ65ckqyH08Ml+OPSOvdG2
         t+nT3n6N0wcfpPkjxkrxw9+abna7uVKr+EYnSukYWfJwGm7NqW1gLauYxfs5W2WhGbBA
         Htcdw/nplWgqpmK86+EiWiRury2IQSw8dgyo37r1TxIp/U+WIBh973HwVEUsVif0tSIt
         qYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696931033; x=1697535833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2fKuiCMvUcJ4cs8+YpbknatJpCqd+eHlKiOKGntdOwk=;
        b=BwQZi+KuJ4rxUlB5AVNVyXADULbsgX46XZo+7W7JhsrKaFqRH1P2gK/FgkIEFuUoja
         KzmHVzQVQYF/Gpe5dgQIOfABZh+mRmwiYN9i2SQnpXVnQiii0rnT9fBACuT/Z3HdHVHm
         rEOqkeEQujfnXQSeiHqYrQVLsCtEHum/yXQqMWg2NNso71bzw1EN8MihjaRe6HI5y83j
         YElMPPplQDt5IzI5nncqyEAvHQpBeQqmRWVO1WyWik254IVk01a9m560IeN4Li++7wNt
         UtcVEwuUBMLxJexkRRS/OkqLngiWclIp28V+IZ7PZdvX3VPmCyL5kZ4bScIZSxU49i/k
         G36Q==
X-Gm-Message-State: AOJu0Yw/+K2MhyEmy6bL9SPsOJbc4z4uauEPu+uEcASBtOL9YyFjO4gP
        QylNm/Ez/T0XVZJS918P72D0IM3mKnZpesjQ7hIooDd6RMIvZLGUpHM=
X-Google-Smtp-Source: AGHT+IGYMhLxkQv1evTDq7jHy8XqcKzcC+M77pvv2RPXiDw1s16aJAZuZc19sQ0ta+C8J/ys/gkEcwdK1nTQAxcMF2s=
X-Received: by 2002:a1f:4c43:0:b0:49a:b9d3:692a with SMTP id
 z64-20020a1f4c43000000b0049ab9d3692amr13902739vka.5.1696931032821; Tue, 10
 Oct 2023 02:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231006134529.2816540-1-glider@google.com> <20231006134529.2816540-2-glider@google.com>
 <ZSAeFfNOUZIrK3Yk@smile.fi.intel.com> <CAG_fn=UxSUEcj9wWexakd-F0-Dh+WjeKEaqwMKfD8AEOnkRTsQ@mail.gmail.com>
In-Reply-To: <CAG_fn=UxSUEcj9wWexakd-F0-Dh+WjeKEaqwMKfD8AEOnkRTsQ@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 10 Oct 2023 11:43:13 +0200
Message-ID: <CAG_fn=WyZAgPmMbat33WtOmtOM7xJ1WjzNZUY2yiOX8zfpcasw@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] lib/bitmap: add bitmap_{read,write}()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > > +     if (space >= nbits)
> > > +             return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> >
> > And don't you want to replace this GENMASK() as well?
>
> See my next reply to Yury, tl;dr this is a stale code version :(

Actually, no, we haven't discussed improvements to bitmap_read(), and
this is the correct version.
I'll fix this one.
