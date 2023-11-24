Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870E27F7159
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345297AbjKXKY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjKXKYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:24:54 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C371A5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:25:00 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5cbcfdeaff3so17698707b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700821500; x=1701426300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSRwymbbTF0gzuOjYP7v4xf2W/UwQLRj17AdLnzK6Yk=;
        b=QT+0vckLDYvueES5sSJ8YP6iUDGcN9n4s0VhJfqMRhtrSXW5n7sOLHP6pQNq2VyC5G
         Ovp8omDt1WQCiuLLEWs7g1l+c7JTGJUDvKiHNMMhT2OOCsLdmTYE7jhnMvDtCqbyC5lL
         Em8MFWP5+CqXsCGfOxlNTa8z3UmBODF9Bcp6BrnXCIrncjhGc4trtd2DceyNrGuKNyhn
         hquH5eF+OKCXVyvTHWGS+K6zDmCYc61HFCESCKyEMT0O2HGquD4iMzqytELmCXZCBUo6
         aWqSBt6ClSxag7kVXs8tO3CFVrzT0wasABesU3lWAkURJUuj9vYM1k+rLkdcqfdfnz/W
         vn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700821500; x=1701426300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSRwymbbTF0gzuOjYP7v4xf2W/UwQLRj17AdLnzK6Yk=;
        b=EgyOAIIR6Etv7WQuKXiE+Kw93tT0fmJAmXxfcL9S1AIlj5JcGVttZLVgggnSmlEZvX
         +pZugYPK+Qd+V3nGH7Z87r9WI8rYgtteoYcJ24KzdQm7JwqT3hzRyupjmSNUKvwHcYZ8
         XiIR2ODyZh9ctD8LuuBBiE+Jsd9yWj3R/Y1tGX/6OHIRrnIc0rHAX4vn3sHGyGcDiLFE
         xAEV/21x0f9QHIf7ZFhHpuwZWPSYbG7hdJzeIJLr2s1E6p0lzVkt6ZBUfK8GYP7wfuxq
         5z5Pzs+B07XtswJqJsP4DJ0qcI1bj/9jw3e9+HvTkKom6KlG69o6tFinwGXSYoI1bF8e
         hvCg==
X-Gm-Message-State: AOJu0Yxwqiu0dYy3khJjCCt8ijOPsAaLfA0Gd3CVp0g9VS+LkHpE9MK3
        NZjtxIIzBfocEhI0oyJLURioDHOw/vOq9G88g9254g==
X-Google-Smtp-Source: AGHT+IHna5orXZBaFh71s5HEqAg5V2fQBcSodGOiIyRvx+fRsKxIrd8IvGfSuHAdM0CGYXYpGN0cGWpVu58CnfTDUts=
X-Received: by 2002:a81:49c1:0:b0:5a9:27c8:edbc with SMTP id
 w184-20020a8149c1000000b005a927c8edbcmr2136208ywa.28.1700821499637; Fri, 24
 Nov 2023 02:24:59 -0800 (PST)
MIME-Version: 1.0
References: <20231124094905.58425-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231124094905.58425-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 Nov 2023 11:24:48 +0100
Message-ID: <CACRpkdaE-Gejf3YXxAEGV9aJakqK77ZvYYFAtUHmVFMxaPDE1Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: st: minor whitespace cleanup around '='
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 10:49=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The DTS code coding style expects exactly one space before and after '=3D=
'
> sign.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This shows a problem with how the ST-Ericsson platforms were grouped
together with the ST platforms, leading people to believe they are maintain=
ed
together by the same maintainers, while they are not.

I might have to split out the STE platforms so we don't get this kind of
problems.

Can you split the ste-* prefixed files changes into a separate patch that
I can apply?

Yours,
Linus Walleij
