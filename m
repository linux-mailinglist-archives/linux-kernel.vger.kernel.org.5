Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F297D1501
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 19:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377915AbjJTRkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 13:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377702AbjJTRkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 13:40:32 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361F1FA
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:40:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507962561adso1518187e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697823625; x=1698428425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mF0w62trqYcHCfLDfzhxkaTZFMEm0P6zCkg1/3Jkv8s=;
        b=U6HVdGERQBUwTjwgHPHRCTgtRZk6v0bM6gVi76tzanFxli2DE+r7O3vvMgSx7UO4N/
         SNeJgQner9QeEZHZBIGseSlcf5r8bFdP+QHL1xhckgb+R0vVmdoJsuYokOvWl5eERsrL
         0R/IXc+oXnA/XLtjPk5M3uo4xAn8wdBi+uZDpokfi4A4Tsw+QBDn5hU9L5zKsBrQL7Kt
         mztkXAZ4JaWSqwYbjG9B3NZZCwYA9rGJchDuf3/LUHyOzsiA+yXwahrb02LWxZyxrpr3
         a64hkVDoFRugBqRvzdepROzc1LEs7jjvaLoF9UhhG1kgbZfSNKF/xz23qGnTre0V9DtK
         0u4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697823625; x=1698428425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mF0w62trqYcHCfLDfzhxkaTZFMEm0P6zCkg1/3Jkv8s=;
        b=PyiiZCqBMVndYhH/3xZS2RhX3Q3MdWMOFCzGs8UR3J/O3B99TzxESICDLJUajxkqFI
         58ykfCDYdAbTYCCz2NqbEVAmdyNzPK6LVoD009f3cKO4hk65W6i2D52eTobcItgpnZey
         H8L5is0x4UeiUWoHTEKIDw19HooIygP9y18S5s0qea8Y1lWUeq4D0PxNIfU8PvuHVADI
         ioqEfwjLfjFgkgQh+rs4W3Z0q+t0cQul4QuaZ0tfg27Z6voE2UZCXAG2o4sSRZcrmK6D
         duORisxMwgKlWaxlObX3a7qUDNNMc5uT3ew0Oikj5umiKO5WXa3w+jvvQRFTXqgBSFUo
         +4Cw==
X-Gm-Message-State: AOJu0YwX6/VptbPsR70xprU4Gn41l0FNSdOKpaH0VSjkcHk/70MvEIQq
        QWVOyaKmtwHuH2igaDTx6KXQV+0RRD4l9WanATFFZA==
X-Google-Smtp-Source: AGHT+IGa8/lJXmLSId1P+cwpoUCl//EotM3rxi6/MgjhAIod6PDU4OLCGZng6oGIb1YJJRHEDd4b0KgzHntGWUqAxb8=
X-Received: by 2002:ac2:4573:0:b0:504:3807:22a4 with SMTP id
 k19-20020ac24573000000b00504380722a4mr1925746lfm.23.1697823625262; Fri, 20
 Oct 2023 10:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook> <20231020044645.GC11984@lst.de>
In-Reply-To: <20231020044645.GC11984@lst.de>
From:   Justin Stitt <justinstitt@google.com>
Date:   Fri, 20 Oct 2023 10:40:12 -0700
Message-ID: <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
Subject: Re: the nul-terminated string helper desk chair rearrangement
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
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

On Thu, Oct 19, 2023 at 9:46=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Oct 18, 2023 at 11:01:54PM -0700, Kees Cook wrote:
> > Almost all of the remaining strncpy() usage is just string to string
> > copying, but the corner cases that are being spun out that aren't
> > strscpy() or strscpy_pad() are covered by strtomem(), kmemdup_nul(),
> > and memcpy(). Each of these are a clear improvement since they remove
> > the ambiguity of the intended behavior. Using seq_buf ends up being way
> > more overhead than is needed.
>
> I'm really not sure strscpy is much of an improvement.  In this particula=
r
> case in most other places we simply use a snprintf for nqns, which seems
> useful here to if we don't want the full buf.
>
> But switching to a completely undocumented helper like strscpy seems not
> useful at all.

There's some docs at [1]. Perhaps there could be more?

[1]: https://elixir.bootlin.com/linux/v6.6-rc6/source/include/linux/fortify=
-string.h#L292
