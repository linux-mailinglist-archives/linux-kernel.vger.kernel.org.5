Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74808123CD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442863AbjLNATN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbjLNATL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:19:11 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F36210E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:19:17 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5e36848f6c6so3131277b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702513156; x=1703117956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrLd2F+/MsaeKRGUaAfFVP8pa0yNcQOUMwc1iB1Wr8I=;
        b=H69dHvKH0e5m7hgm0/xCZ4a38VG0f7AHmgm6zCdfFrhWTBXYoy+hZAmyBJGjwJG2yv
         l56vfVk983Y3EiszCzlxLUrkLsGT34Q5lzh0rbeT2NhWR58BJlLnzrox5/A02r9Hfchc
         Lz7JqLQG5675qOQqYWQgtfpyobvKuABRUMi319KHSMteOGYK0kK+70BjTQ+eb4KdIRDA
         yVUKSyxhp0Ud8i4vr3ax6JvzCC2G/EKlPliqF4WpTGshHrny9UPV71LSkpoHqF3gjexB
         6nnAsu9+W9CrG24N/NnYAFor2jpViSnPLJl9ipY8nAHTenLVoLJownZ3roFt7bGDgFt4
         O7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702513156; x=1703117956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GrLd2F+/MsaeKRGUaAfFVP8pa0yNcQOUMwc1iB1Wr8I=;
        b=gYPkE9Zb8Vul16a34J8DIkryIQJ6wEOceHckqjjjIZ2OHL6xscmfqmVwaKQ0elBDr9
         DvL3AwBzf/mhuuW114ekZlD1zDfDoQ8Hr6UQ+/sTRI6Beu/yb0ZKf31fgShHYdG/dgLm
         M71TqwKPjnkFbDD8SpC3F2Rnj0IXsIAU7RJDTb/Sj/mQvoYbHVX4xOuzTEciDNxWatB6
         rYFD2NcrRHslYJkrIqdhsSssHeBgDVA532VGwVHoKS04ZxKGdGrQL4UhfYvxu2ZKnII6
         fRLNPO2jKgAswN4lG6IByjuNN1ljy53ZbN2slY1hW/TvIsijoYUJoiGzOAGuEgykFmhk
         4K8w==
X-Gm-Message-State: AOJu0YzkQRqdEp7fHmlnfjHrzweaGOz6zSGV5DAowXeUbeNDvXX4MqI+
        sGn0Zt/dsm2B8BS3uF63pEY9OJZDY8mwv+CjIjMVtQ==
X-Google-Smtp-Source: AGHT+IHkBrOOm0OxhUGeHAnruxTJYyZUsskOzy4MDxQRuSPBZVQt33fsHoa11qnb0EEJGixFevSwFLVx5w/B6bJjHUE=
X-Received: by 2002:a0d:dc81:0:b0:5d1:430e:4b6f with SMTP id
 f123-20020a0ddc81000000b005d1430e4b6fmr6592283ywe.9.1702513156546; Wed, 13
 Dec 2023 16:19:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701274975.git.namcao@linutronix.de> <ae1940abd6ff6a9e77b4373cff60007c641a0c6c.1701274975.git.namcao@linutronix.de>
In-Reply-To: <ae1940abd6ff6a9e77b4373cff60007c641a0c6c.1701274975.git.namcao@linutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Dec 2023 01:19:04 +0100
Message-ID: <CACRpkdZfuKmg8gY1J+prF0L0=S7PSW+0ZuqM3HhNrB1sXcNG5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] spi: spl022: switch to use default spi_transfer_one_message()
To:     Nam Cao <namcao@linutronix.de>
Cc:     broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 5:32=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrot=
e:

> Except for polling mode, this driver's transfer_one_message() makes use
> of interrupt handler and tasklet. This is problematic because
> spi_transfer_delay_exec(), who may sleep, is called in interrupt handler
> and tasklet. This causes the following warning:
> BUG: sleeping function called from invalid context at drivers/spi/spi.c:1=
428
>
> Switch to use the default spi_transfer_one_message() instead, which
> calls spi_transfer_delay_exec() appropriately.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Tested with polling mode and interrupt mode, NOT with DMA mode.
> Support with testing very appreciated!

FWIW I tested this now on a device using DMA for the transfers
and everything works fine like before.

Yours,
Linus Walleij
