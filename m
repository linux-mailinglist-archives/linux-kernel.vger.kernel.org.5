Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0B379E7A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240311AbjIMMKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240313AbjIMMKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:10:53 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847D719B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:10:48 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d815a5eee40so463525276.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694607047; x=1695211847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gMQz/Ct5OJ+eHqkyRd2/3gAjJ4z22O7rVhyX1ZMa3k=;
        b=IHJ33dizyrPXezQSMx9O6wh34PqdKoMb7pRyYhm+5JcWRHPjL4nzrHI5CjzkfJd+yQ
         uWDsFlvyf0LsooNAqBUhWSwBRiP1QLGCQT2jCgoXXmeTdHGGbqxjV9YDq81dmiWiReS+
         RKmKupX67APydcp2aMuvMdiJcyxe4aoHB676SgcsFqfWf2qJIySR2vg6gsDrrZluHd5q
         Xr0W2hkgcgxXwj0hd2a+Kgdtaah3oTuvpH8d+J9z8Dri3C/H9pe6ThWIKUcXYdgyFtin
         kGq9CAZd+apUYQukZE4Vq6YoxInuQB4FrTIprmcI7FrgFox0EFCXjkc8F9rLx6zv9Xz0
         crvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694607047; x=1695211847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gMQz/Ct5OJ+eHqkyRd2/3gAjJ4z22O7rVhyX1ZMa3k=;
        b=GWaiK4hKfPxXph9MkEcC4Xb0WbocNkLWBHSMhdr7VKdf07fjXaxYM0MLaGsOKINo+x
         nY3z/Qk3VpSLbbsHmdIyVinZfYM6iVaQFTNf+Q/yrb6/3JfZMne6uqjKW+v4P6enZYDY
         VjfPpelvXgxEYsmuXuDcN96PnNfhvy87AcSyjjn8ZOOduWyUEywj+gVgqdgxPEOGy6uW
         TB1hwAQ+6cGXxqVG+9t3++Dicb6ax4F5PbdQsKSlWTeb9rGw7wiDgbYyKyi2lnp9C4bg
         0WD8ipkzL15S/4BefSS3qKNCeZN2N/XIF3+nucegFW+XjJA2oBoXGG5z/Okr/QrTewAm
         GZyg==
X-Gm-Message-State: AOJu0YwFlFC/ZCopk29CMkVX/XOrAnLi+3mfv4JetQfjEG5XrOE6rCVy
        wHVL6BdxOCctTiI84ycAppEFBiEhm0in/e2GxJ0unw==
X-Google-Smtp-Source: AGHT+IHuaTSZC+cXZLXIx4qC4ZS1DKZ6FlvuQrXEnBGMjL8xO2rDp71bSIBppbt6DT8NNsG3eyqzNpSS/QE3Bg6Y+lI=
X-Received: by 2002:a25:2044:0:b0:d7b:9d44:7574 with SMTP id
 g65-20020a252044000000b00d7b9d447574mr2084005ybg.64.1694607047733; Wed, 13
 Sep 2023 05:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220615090517.3961621-1-windhl@126.com>
In-Reply-To: <20220615090517.3961621-1-windhl@126.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 13 Sep 2023 14:10:36 +0200
Message-ID: <CACRpkdbXs8dOFNWLpjPoTKzYbw3JQuM6yVdJtqHrvRP_HZyWsw@mail.gmail.com>
Subject: Re: [PATCH] arch: arm: mach-versatile: Add missing of_node_put in integrator.c
To:     heliang <windhl@126.com>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 11:05=E2=80=AFAM heliang <windhl@126.com> wrote:

> In cm_init(), of_find_matching_node() will return a node pointer with
> refcount incremented. We should use of_node_put() when the pointer is
> not used anymore.
>
> Signed-off-by: heliang <windhl@126.com>

Patch applied.

Yours,
Linus Walleij
