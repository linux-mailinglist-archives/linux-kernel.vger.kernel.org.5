Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CCC7BFD9E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjJJNgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjJJNf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:35:57 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96000DA
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:35:53 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7c7262d5eso5154027b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696944953; x=1697549753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwaODl/6SngYIesq4fd26Zf7cKEGOc6/vuChneskjdc=;
        b=TK7X8dOdEsESKx8042hUKWzOw0x5zA3eiw59WcPmrCoaEDsT7MmpVGSK2kQ7B6+/jF
         Vw/bLol6Dtv0H5dBDfOCOvtcuvCgwid6pokEFJQWFIZngrUQ9Sd1FzCSBmL74ocmh17P
         F0utXAIHCZhi5mR1frIktCqs50HhHpYS5hiYYfBAugU85FSRGcvdUGF32XtBjw0KTWhC
         eGF5uN+3E7BsTf++aDvo5kywIm74fIVGk1M+7yYMphNaLTgvCnPmzvAf0nEOQL85lvLL
         cooEvDiLgGHVfyt3CJQv1CZHcfMTxSeeq+uhEgVhztDiBtz7pr8opCuXv5fyL/CpwMQ6
         jr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696944953; x=1697549753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwaODl/6SngYIesq4fd26Zf7cKEGOc6/vuChneskjdc=;
        b=AOs6Nolwt2UZ4GwuCS2WaLd8W9QSvCd+MFiLwQxAx3pyWhYZiKtXj93XoDaPiK7Sxs
         9sz/W9Hkynr0kSq44a+Q2lRRMJSfR2qI+ioeRn/nC9RB2PvxzDw9StkhXHLo86h2mYnc
         0xNYpebtQDG1YDHaMnwefdmpQ3pIPcAMbd6gFCk1HPIFkRHDvw0hBfKVNOmmnuJxTDgg
         TzX2xY6VW0reu+jnGoVgNGZrWb1u6tKDD68l6JuQ1ZrzIJaMQEhu//9utOgvyb8ligD8
         DCybTb3Ma2djZmkSewJcnFS2vRxIzWuGNtx1eZN2pkzF2NvMAUMCIILg2d2BQbTMgzlO
         kYkQ==
X-Gm-Message-State: AOJu0Yzi4hxWxbrYQp8uJCx3moImRZIm6xyBrLe1JUemjaLX48ucB7QV
        LxXQaqkjpng45ZpDZEAYRu1minokxNieIM0RYNw1cg==
X-Google-Smtp-Source: AGHT+IGG3gi8s+Fcz5VP7yTY/DRWNo6Zujz9HnOJaU190QxNyFwVrfyV42NA8H4la4b2WLErva3zQYndcUdDa01huh4=
X-Received: by 2002:a81:5cd5:0:b0:595:2094:f87 with SMTP id
 q204-20020a815cd5000000b0059520940f87mr19266136ywb.47.1696944952747; Tue, 10
 Oct 2023 06:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de> <20231009083856.222030-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231009083856.222030-2-u.kleine-koenig@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Oct 2023 15:35:41 +0200
Message-ID: <CACRpkdYoqxP89nC=e8Yrt+Jxs1je4jnBBGtaUQfkKpjcR5vQ6Q@mail.gmail.com>
Subject: Re: [PATCH 01/20] pinctrl: stmfx: Improve error message in
 .remove()'s error path
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 11:22=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:


> The driver core has no handling for errors returned by the .remove()
> callback. The only action on error is a dev_warn() with generic error
> message that the returned value is returned.
>
> Replace it by a more specific and useful message. Then returning zero is
> the right thing to do, the only effect is to suppress the core's
> warning.
>
> This prepares the driver for the conversion to .remove_new().
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Patch applied.

Yours,
Linus Walleij
