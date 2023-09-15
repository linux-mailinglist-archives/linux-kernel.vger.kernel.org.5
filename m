Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160207A1928
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjIOIrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbjIOIra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:47:30 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8812718
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:47:20 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59be9a09c23so19527047b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 01:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694767640; x=1695372440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuvVotKpBcP3UXhgRGN47JnMhQ/d+HXg646hFgnvAdk=;
        b=o6TfgoUxHI5cBoegEcsUmulMvQQZW6sSGJR9jTa9rjt1cmKrhCF3bpZdk7Uo+elQQq
         GYSEMlp9RchLNYHV0EBojwWg5w4QT2FsXVL57sKXF866RP1k/YmWvuYeAePT8t26lhOr
         Z2H2i6hIOO5PU6RgWJHetRrcNNCY/n5ThrQ7W30sx9wQKMPKtg68Tug9XviFakr0uhJj
         LC/9rNYN1KMEk7q8OGCntNO+UANYeyREXLCXDTpnTxioAHILAaHbFU2wwtJ4OkPVygT4
         v9sAMpE/Wj6kCbS9yuacl+PpNADXOuOQJ8K8B8ZtemcexTBVl4X6TwcegSIMXj+8LrmZ
         UTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694767640; x=1695372440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuvVotKpBcP3UXhgRGN47JnMhQ/d+HXg646hFgnvAdk=;
        b=m+134dX6jV35JIumcqm9+DfbYVkX6xb/YbVhOwsn3iG6tQRfo/GXW72UGX8uVbevCu
         FcZz7rF9IhmIIfS0jOG3WA/yuZYrEOHYTpBZL86U3VlOPskbIj9d9+rqlznOxY9gKT5x
         aOcpgjUa53OIu/gHpBo9d95WeDgVbBMVfNtQo8SDbFZkT30BVmSXPociNM3ksxTOSD+7
         2RiIFczHcnCEaubw7cMKriXAnMo/ZElgpEMRxueRpxY0kK1jgBGR8NUX3fA/gOQPbBoH
         uZMfrOMLbvTPrpPVp8gKDzRZJdovkhbwbQJDawXpD77Sy0ru99BhpTmioWWVpVrBXzuZ
         2hCA==
X-Gm-Message-State: AOJu0Yz4PybRZ0BJgB/+wvPiJmSOHrYnKolOYZ+8Zn4xBNyX3NiGKwlA
        lD7ptBmiRwH9voqq2gefffGJb/ZqUpQgHHDJ3zmFTQ==
X-Google-Smtp-Source: AGHT+IECDorVo8VjAx+jDFBwvuoWYNY0J/1bRwiUh62Cox0mhsXwvBSj//oORy3ZwY2thNcc8JKGN8rdCLaLcYi0UEQ=
X-Received: by 2002:a25:e010:0:b0:d09:544a:db1b with SMTP id
 x16-20020a25e010000000b00d09544adb1bmr879376ybg.34.1694767639929; Fri, 15 Sep
 2023 01:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me> <20230915-ep93xx-v4-38-a1d779dcec10@maquefel.me>
In-Reply-To: <20230915-ep93xx-v4-38-a1d779dcec10@maquefel.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 Sep 2023 10:47:08 +0200
Message-ID: <CACRpkdaRE5LeAZsFiDmeU3iZvaX3a4BrBOHT51aJV8YVH98RoQ@mail.gmail.com>
Subject: Re: [PATCH v4 38/42] ata: pata_ep93xx: remove legacy pinctrl use
To:     nikita.shubin@maquefel.me
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:12=E2=80=AFAM Nikita Shubin via B4 Relay
<devnull+nikita.shubin.maquefel.me@kernel.org> wrote:

> From: Nikita Shubin <nikita.shubin@maquefel.me>
>
> Drop legacy acquire/release since we are using pinctrl for this now.
>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Acked-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
