Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDEA7C8CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjJMSOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMSOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:14:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BC9BE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:14:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so4169919a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 11:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697220854; x=1697825654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcKr/CZetWXeaiAMnijTZoyqZxIstUr2Yy9KcLmxk00=;
        b=FSbj0/YIy7dtP70FXrcGCypq32D2Ps1K+M8jb4R7s14dQVCUvPwCQVzReljnfXHkGE
         ubJ0IM+Z6j0BFbLxUfvEfD511/VmdoqfFykJ0Zxppu58q9j8rGnYv9G/wYq6pXAEmTlP
         7cbfV/fg1nAy55H1oN9cWGNf44tWBgJ32YM70Mf9zZUqK77jqh+u460vREa/+wDwv25T
         YztdGafB8AnKUqYODJ4Wl0tHNA613OuwEYjp36bnNikm8ZOGD2Tg65GhvybBAQ/IuYom
         SVgNU26IlV338LBH41hw3UAAiOffJrMLWmm7LzwedTkPMJgPwZBc0zpACjdGFXnLGlAt
         Udcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697220854; x=1697825654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcKr/CZetWXeaiAMnijTZoyqZxIstUr2Yy9KcLmxk00=;
        b=EvxvsWfbwlS4Ee1m29YO2OMrzmiLm+09hnw8FWeZpWgaDkzPCVT3NDNpyr31ZXDEwQ
         lssJQpCzzXx612mgA+7r081qUYSopc9eB79c2HxBphigfpTQP5tLoyYhGAboClicOOWg
         UCbtYD8GyXwGTHqC1eUg4i5zyq0AtLZaLgjD9v5J40EvOfEHRgy6hsETpo2e4iXS30Yw
         d1J7mhiodUn+y0AWU6g6iHcNeSodsQo0opVeUvuFwq7l5C/sdKkxdSHwxSaRlEdObA9n
         rAqu14XCEBMRzUfau01XQcSFEc0TD//AD8+tiAF6ZwT4RZiMvZl2G4Z5zmnf99+J5KVw
         xfWw==
X-Gm-Message-State: AOJu0YzWEmrsuNs/u83AXsObG4xsBRX4JZCb2uOOdDddCnUqazQRGFks
        Xr9NPUqPrp5kQwk+hMgBwSp8s7v+MRaWcYfA5ws=
X-Google-Smtp-Source: AGHT+IEtJ5x+F9mrNzc9avM60w7274IkSanoEYkFNsZVZpimqjl8luZlhJSocnsp0jQBDKCWgiF2t/gD7rtoBeBCgsA=
X-Received: by 2002:a05:6402:50c7:b0:53d:ed7a:11f2 with SMTP id
 h7-20020a05640250c700b0053ded7a11f2mr7624692edb.38.1697220853805; Fri, 13 Oct
 2023 11:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231006173205.371205-1-robdclark@gmail.com> <CAPj87rNT7rhL_GiSA6GtgcnByKwTmWUsFVMWTRSECz2QydjtMg@mail.gmail.com>
In-Reply-To: <CAPj87rNT7rhL_GiSA6GtgcnByKwTmWUsFVMWTRSECz2QydjtMg@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 13 Oct 2023 11:14:02 -0700
Message-ID: <CAF6AEGtS8ZTiDs=6P4fkq9WjxAHbi6Nzr2vNVqiF-JaMqGYqgQ@mail.gmail.com>
Subject: Re: [PATCH] drm/ci: Default to UART for logging
To:     Daniel Stone <daniel@fooishbar.org>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Emma Anholt <emma@anholt.net>,
        open list <linux-kernel@vger.kernel.org>,
        Helen Koike <helen.koike@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 9:28=E2=80=AFAM Daniel Stone <daniel@fooishbar.org>=
 wrote:
>
> On Fri, 6 Oct 2023 at 18:32, Rob Clark <robdclark@gmail.com> wrote:
> > ssh logging is the default for mesa, as it is generally more reliable.
> > But if there are kernel issues, especially at boot, UART logging is
> > infinitely more useful.
>
> Hmm, we should still be capturing the UART boot logs regardless. Those
> go into a collapsed 'LAVA boot' section but they don't just disappear
> ... ?

Hmm, I wasn't seeing anything in the raw log, which doesn't collapse sectio=
ns..

That said, I still think uart is preferable to ssh for kernel CI.. we
aren't running jobs at the scale of mesa CI jobs so even if we get
UART flakes 1/1000 (or even 1/100) times, that is an acceptable
trade-off for the fact that uart can still work when things are too
fubar for ssh.

BR,
-R
