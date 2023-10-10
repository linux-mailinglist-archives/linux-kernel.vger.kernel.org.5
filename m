Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2886E7BFAC3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjJJMGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjJJMGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:06:13 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FE3BA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:06:12 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7af52ee31so15081137b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696939571; x=1697544371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+emiS3FobGYMfsvMtLsinNF+jfBFa+dN92hmrKe7R8=;
        b=DdCUofSWh2jhY+/KbfJJKI5l+KY8sL49LL4TSFidQk17Hu1nXvI6VQ5Vtfl/J+BsEL
         pbgeTA+y1pIalIosbojRDuoJJY8gofNEYBSQl2b58pn/vPEUacyOeRDd05kiAfdko2LS
         /uNLMkapy8Sf8DAIs7Aztfa7FOIMTReNJ4fBU/dVIKicMqpJyTd7diyrEZRbmOamsdGO
         HmACokbIEcwi2s4wSq2ufp+3rHxwIgg9/+Lo9GLXWCrtW1qB4NY3w7esB9Nvj2qjwn70
         6IlupiygAdyDDUk8323NLty2q2DZc50To6na4OrDCuXUH5Onxen7/xoKJkOtvuEG5cCS
         HXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696939571; x=1697544371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+emiS3FobGYMfsvMtLsinNF+jfBFa+dN92hmrKe7R8=;
        b=Z4jxc+DokY1KPbZbi8FBaoyjFR8cfpTMqebJj+lUJ/AjrBIqDp5iIeSjFF62Y+97ca
         /TxqK0qzNvpIWPU1ZsTWZ8P9YIbzDbbMRUPZgU15dwhuhPUzYlAy9xAINK1qj5a4UfZU
         TCNXLqm1pkrkBo9wtQKtRkX2h2rXp/s3rkhqcdhyHPBR8a1LxMnK4JMMfT1ETw8C7ZGL
         8HhWEobuKBCzsq74a6xeMx+1JUQKJTWsLJsl+X1qky/n02SJIxfdgJkUKamG3iPQuoJa
         xJhGPSjpdgDEF1QDx3e+6syYtt62t9foeldmF0UqXOkuqx2Nwfy1rnIcOVgZvEb884kO
         s20Q==
X-Gm-Message-State: AOJu0Yz4iuumQyol6H5PMX7JJ64zEsz8hfB9RfVKOXdrrJLLoQeg/tAN
        Cj/Kq/zGLo0bOZALsYwdtfji1RBy1FctfftZ6kyG6SBmg6sOhKve
X-Google-Smtp-Source: AGHT+IFGYJ5KguZWMbWcf7Fu7QiLPusFLe1oLIe9ZIHU9hn8kyONuZwR4EuT1YT90s3DBcqkbepLog7T0zaskA6hgL8=
X-Received: by 2002:a81:9c02:0:b0:585:ef4e:6d93 with SMTP id
 m2-20020a819c02000000b00585ef4e6d93mr18904963ywa.47.1696939571479; Tue, 10
 Oct 2023 05:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231003120648.2838047-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231003120648.2838047-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Oct 2023 14:05:59 +0200
Message-ID: <CACRpkdY0_BJqM=kv_5rpBDMZwGRi50j3CZxHAN0a6bHMmC-hmg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: core: Remove unneeded {} around one line
 conditional body
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 2:06=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:


> The one line conditional body doesn't require {} surrounding it.
> Remove unneeded {}.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied!

Yours,
Linus Walleij
