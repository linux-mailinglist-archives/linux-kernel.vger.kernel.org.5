Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509DE756922
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjGQQ3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjGQQ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:29:23 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B45A10CC;
        Mon, 17 Jul 2023 09:29:22 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-cae0ad435b6so4976752276.0;
        Mon, 17 Jul 2023 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689611361; x=1692203361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcmyLdl4Ow+L6bBQB/pcmUUoBJf5ws2D2mBZxyE15nc=;
        b=scdh5BkgyyPSzX16exQ83vP1epiQ42gXUCms3PVBKk742Ufg71UhDVWHXlNenCS7V4
         f+X7DlGztkTcDf2kZZhkH/S7DKRV0zp/JJBivMp466Tkbyw48CpyDzjJMRMHZ2TaNdKm
         TE5uPJ7/f2hZk39zL/pv4TtIZJ6GBosHkUXAKHBIinDInEpemIxDLJllsTcaedxGE76r
         6Bfzmjr3vHpbM2tspoYRSkX6R6CvPr/Gkr9KP6miMukjQ49q3grkQ/jnRiGvbFak+XKf
         MEdxb14d2LQU5d8AZ6ujI0oylYccrFDeDi7aHiiDa7X4i7zqPxNqLVcoUCr0CKiZd9Ab
         V6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689611361; x=1692203361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcmyLdl4Ow+L6bBQB/pcmUUoBJf5ws2D2mBZxyE15nc=;
        b=lbvrgc2QzeJMXa7syIqMlOKgR5QQtQtI2n0CHs9vbarFUYAWUpUTxXc+E64c8YXQrO
         235xgAPV54hi17OKP1pxqGLsRy6WlHrDrE9LFf75cZ9q+dkAmkisGz4h1abVonI+waEu
         kewCRHZexhuIeIlm04Y06SgDuKfDrIVwtMspIv+i6eCC4pzHSqOu5OFoI0gtaMN6gdoL
         atsdULapl3N3wptgUSMrzoNwdJe+zLyp2UMo+7f1OhgkEiH5FAINSXnBQVtpxC/H3sXa
         um700Q7Q1Z7pgqumjYZIP1MzcYa4HPI+w7Y22lxxK+osnsgAR8jU0eOWE6UFJXT1Wk0S
         bOmQ==
X-Gm-Message-State: ABy/qLYPJ/RkehGVaVT8ScgePejesgI3wEYE7VRxczIif2x29Fc620/s
        Th2I2OBCzwfc9yqgQq0xk0PyIdIEsUHta8qeXpan9IzN
X-Google-Smtp-Source: APBJJlEov+clBur4A1ye7VipequueyeI3L7Q8xxNTDYSps3y7uE+GM8p65/xlmEA4piAJSYpofxQ9ksPX2a5p2hjF7E=
X-Received: by 2002:a25:aa24:0:b0:c5f:3df2:d26f with SMTP id
 s33-20020a25aa24000000b00c5f3df2d26fmr12081127ybi.43.1689611361216; Mon, 17
 Jul 2023 09:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230717124013.38796-2-samsagax@gmail.com> <20230717124013.38796-3-samsagax@gmail.com>
 <2023071726-zap-sesame-c8ff@gregkh>
In-Reply-To: <2023071726-zap-sesame-c8ff@gregkh>
From:   Joaquin Aramendia <samsagax@gmail.com>
Date:   Mon, 17 Jul 2023 13:29:09 -0300
Message-ID: <CABgtM3haYQAn28eYiwD9OyHeotyvd-qHD9r4G9WUg=+iMeaOhg@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (oxp-sensors) Move tt_toggle attribute to dev_groups
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Nice, but you forgot a signed-off-by: line :(

Note to self: don't submit without morning coffee

Will add it and submit. Thanks for your review.
--=20
Joaqu=C3=ADn I. Aramend=C3=ADa
