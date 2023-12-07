Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD04808607
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbjLGKEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbjLGKEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:04:10 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37FC122
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:04:15 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5d6b9143782so4709287b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 02:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701943455; x=1702548255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/P/LnDCLJCGUZSUj0E5k/5JKqu7ZeMJ9LgG+CDwpC/I=;
        b=P3plNxo41ciD1SjXqWEaKhLJt5aKvZ8LldNR0AUNN5PmIzYkQFPpHx63YJGukdRDSx
         ZMNmKFHX01rwYBsyQrd3JPEt8oFgd5KfQsSBOQOURLWkTr3tThphj6i+uSynjlrFbTGe
         MbasiIFy2DpQdWDneds7LEuPt2TzU6CLxPZIMpCrr10fS0JLMayxwH/Y+zMJwuPsbbn0
         6q0eYR8OdC+R4tBqg4pll6q2tSgzdE224onJdkLW/vVkiv3Nvd24/sRIkVsB6+AO9V9q
         UtQYdtQgZ4TAUeE6uZiZbn9abduihpmz+SEG3uL99G887PWX0K6DQN9LWC7jE7jtyXq6
         ZCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701943455; x=1702548255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/P/LnDCLJCGUZSUj0E5k/5JKqu7ZeMJ9LgG+CDwpC/I=;
        b=PFmnYGY6E9ac9lY40PR9M0+g0oMUX93DfpCrtdRmf79LOgih7N9zTA5yRWv39wGDPW
         qltJe1I5esgPh318g19eEvYL0pDFAw4rkkyfVN1+Zmdnj95rYcQDc5hWzYyTLOeajThd
         N7qaOPtaaNSve3ejC5xU64mVPY6RGKxAxP4dn2B1+ilSpDPiN4IgthSdyDDzrWhC9gA0
         UtbW9H83rOcDZhU7xKn+AFIRgM/tQJ8GwbPxLhQsEqLezXO8Bj3NE2+DF05GGs3VegsG
         98IOfXGqkKoKJUWJOFvL3YDwnUQPRPbJl5R/Ju2CmrIBpXHUrh50MevJSq0oNq0099Cz
         jSWQ==
X-Gm-Message-State: AOJu0Yzrrt5Oqw2AJSFtCXiGO5AJSjd4Yd8j2HgjDUQfM99cR83QHKbr
        FLQ8jbZxd3vFfff/dtJrm9SPVRHcOTLHDSSkZjO/rw==
X-Google-Smtp-Source: AGHT+IGXHER31GZ5DBXl+dF2Z1Tp8RH+vUF4osbPZJbtpjBkpIg84PoV3m06c+i0TgyMrha1nkDE716Qd6LpK/ZJzUc=
X-Received: by 2002:a81:af61:0:b0:5d8:96c:690d with SMTP id
 x33-20020a81af61000000b005d8096c690dmr1961759ywj.7.1701943455151; Thu, 07 Dec
 2023 02:04:15 -0800 (PST)
MIME-Version: 1.0
References: <20231206181335.27540-1-rdunlap@infradead.org>
In-Reply-To: <20231206181335.27540-1-rdunlap@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Dec 2023 11:04:26 +0100
Message-ID: <CACRpkdZBuYtgsS_W9kRuvVXVdORvbA5AGDVr0SkWaR_h8AN9Hg@mail.gmail.com>
Subject: Re: [PATCH] usb: fotg210-udc: fix function kernel-doc comments
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 7:13=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:

> Correct kernel-doc comments to prevent warnings from
> scripts/kernel-doc.
>
> fotg210-udc.c:1103: warning: Function parameter or member 'g' not describ=
ed in 'fotg210_vbus_session'
> fotg210-udc.c:1103: warning: Excess function parameter '_gadget' descript=
ion in 'fotg210_vbus_session'
> fotg210-udc.c:1103: warning: No description found for return value of 'fo=
tg210_vbus_session'
> fotg210-udc.c:1129: warning: No description found for return value of 'fo=
tg210_phy_event'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for fixing this Randy!

Yours,
Linus Walleij
