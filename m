Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4171F807F03
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 04:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443150AbjLGDAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 22:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjLGDA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 22:00:28 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EED137;
        Wed,  6 Dec 2023 19:00:34 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6d8d28e4bbeso318559a34.3;
        Wed, 06 Dec 2023 19:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701918034; x=1702522834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhSz+48D5Rt4U23Tg+4vmyl42dn2RcUMbGtIBTvQxYI=;
        b=BMcTTPaod/BN+Urm/9ApJxmjfk5GaoVwvhVJ6Df0wFWe5xHPGcKLu+yGjUGfgyKao6
         q80fOjJqhpKWER94jMrsRSFJY2jimODImfiAGaPf9qOkNsxSca5a5SUHNh1lIIaLMrC5
         YRT4MOmHCNhamkRkJECGi70JkCKQP7W2XTmpHhN4p4jklnPP3Gl8MvRLh3aif4T0aG3M
         I2bfLyMdsBRYCibbJ6Ybu49Cttuk++LZoTKEF8YLJewg6B7a7LZq70ch3yadPArOIlpZ
         W2eFEBQN2b6GXvJI7y9QR/zyBoe2auI6UUB2QA3L6udWpeBECeViNXqu6m6bNHzeX6FB
         TGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701918034; x=1702522834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhSz+48D5Rt4U23Tg+4vmyl42dn2RcUMbGtIBTvQxYI=;
        b=musEAFM0FUha7lYkyy7wNGCAVhKfBV1tsK0ujTo02DjBs8RxwlbbTpNn9cTMvxxLaD
         H9hdcBmcoGFDOBQWxQvYsfQ3gc/AeTyIdVGnXFUXwTK1Vj69ruVRrQ+dLmmhIvjSKaGn
         Ecy2YqMGssm4DYKO2odlwctaHYG5T1Q+esWGcgXK0ASUxdOybahihO5ynM7o/FqsAglV
         7rAHZjjl/pC6mNAeqGuGPVh0VslcoiUzRsZsMaN7O7JQkr2Q9d4hi8rwIJpVTIuZX+aU
         Ix1RGaFfCL/n3dI4n9LXZILdC885nYNPuAFiqTl2VUlajqRL9Cv67mRQ0jJ+XqEnm7Lv
         ZDxQ==
X-Gm-Message-State: AOJu0YxyMxf5SvGUMjhK+1MR8RMu5BbvL/Y4GWkdFtYgXmiO0NcAazrQ
        oHTPbpAC0oUif6/qhGLS8jjCj4u7KKOXWrXpfsI=
X-Google-Smtp-Source: AGHT+IHUpb1GnaA/CMOhx1o6Kl2ufAYV1QErXdu0v0VhY9k1KyIeNaAQMTyBECQwibQwAeE5EkGiE9xYBrVBuWfDHRg=
X-Received: by 2002:a05:6871:6114:b0:1fa:ded0:d8e6 with SMTP id
 ra20-20020a056871611400b001faded0d8e6mr2094531oab.5.1701918033974; Wed, 06
 Dec 2023 19:00:33 -0800 (PST)
MIME-Version: 1.0
References: <20231206181317.27515-1-rdunlap@infradead.org>
In-Reply-To: <20231206181317.27515-1-rdunlap@infradead.org>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Thu, 7 Dec 2023 11:00:22 +0800
Message-ID: <CAL411-rcnuJtNJnvpkq4KWMib7xP08SEH8c5F1eT2mgZi4H6ng@mail.gmail.com>
Subject: Re: [PATCH] usb: cdns3: starfive: don't misuse /** comment
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Minda Chen <minda.chen@starfivetech.com>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 2:13=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> Use a common C comment "/*" instead of "/**" to prevent a warning
> from scripts/kernel-doc.
>
> cdns3-starfive.c:23: warning: expecting prototype for cdns3(). Prototype =
was for USB_STRAP_HOST() instead
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Minda Chen <minda.chen@starfivetech.com>
> Cc: Peter Chen <peter.chen@kernel.org>
> Cc: Pawel Laszczak <pawell@cadence.com>
> Cc: Roger Quadros <rogerq@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> ---

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter


>  drivers/usb/cdns3/cdns3-starfive.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -- a/drivers/usb/cdns3/cdns3-starfive.c b/drivers/usb/cdns3/cdns3-st=
arfive.c
> --- a/drivers/usb/cdns3/cdns3-starfive.c
> +++ b/drivers/usb/cdns3/cdns3-starfive.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> +/*
>   * cdns3-starfive.c - StarFive specific Glue layer for Cadence USB Contr=
oller
>   *
>   * Copyright (C) 2023 StarFive Technology Co., Ltd.
