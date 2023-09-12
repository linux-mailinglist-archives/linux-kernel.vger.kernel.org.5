Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5793D79C8DA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjILH6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjILH6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:58:07 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95D710D8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:57:55 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58e6c05f529so53118737b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694505475; x=1695110275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/x62Yf/b2lTNFGVnKtwIfJ+Tr4eCzomfebj2BdADTlM=;
        b=qrTt5QVxtr4RgIIKN9YInndFXWOEijtZmSR+A7EP3aqBXRJDLjzJDUL147VWuAk6uE
         9o2vMax/beqEKQ2VPd1z2RYVfM0EG5nhh3xhF4A9kO/ncnyUi6PAoDUd6aJ/CclejSgG
         X0vY6HKsl63r2i+MLlHTgdh0qt4GZPvIMrQbs7rUbW7sbFCNCEJTFw4nU3svAQSobPv9
         1G1jcgWsZIX3mrlFKybLFKO9XRs1mUbeepAUX++zlcecFWBhzyfQYOIIV1Yj6m/ckYSQ
         Badd5ONXtgZJ+xCM0PGg1TPYXFeRwYJFYn0vHrXOgwrRfMUQMswVD1QjpSp8hUvaVnNo
         4NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694505475; x=1695110275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/x62Yf/b2lTNFGVnKtwIfJ+Tr4eCzomfebj2BdADTlM=;
        b=D7Qd1ZCea0gYWXxS6Y9L10sM8fow8SXumk+aX/2oMwR8xezewhYWQ9YOklTEUJdnJF
         hxoPMDVdxhDT8GRicVIIofI2f45cpL2r6FQp2r1GoiCvyVKu4q7Dbr3DyTYuaj7hZ1VF
         KAqvv+qeMSxLjthzf8JXgDWsP+zjI6uOpGd2SU1NlSPIrcRiPd1CRNy6zBhT7RophGLd
         vYxeyt00opXrqg2dNcI4jWR9bq8QTx6wcoY+eyjKWaJU67sZaG9MR62Gkvne8Bziu0bZ
         sz9UdreLUBikQm7rkBlzkILhY8+h4Ts2guIBzZsBzQJlgFRuBfzXnpkcTnp1WhtMArjM
         xWDQ==
X-Gm-Message-State: AOJu0YxB5BQFDvJIVHvW9aeoj+5DXQrdxYFmv5Wto6p/YETHtu0abRbi
        iqcfzSRgIHTTXbhtzCiPBysIsYu1okgjYE+dpih1+/fS17kIM53q
X-Google-Smtp-Source: AGHT+IHlEbdZt3fCOWUCFDFrDpV6dKHhuLYf95jAXOMIgCbDIYpDroZioJNmZUpW/Dgx0kdvEz0kMpUF47SqKPIvBHE=
X-Received: by 2002:a25:3a87:0:b0:d3c:ccb:2c8 with SMTP id h129-20020a253a87000000b00d3c0ccb02c8mr11062909yba.29.1694505475127;
 Tue, 12 Sep 2023 00:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230902082225.8777-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230902082225.8777-1-biju.das.jz@bp.renesas.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 09:57:44 +0200
Message-ID: <CACRpkdZWHy4VmB+tGTdu5pTrnsGDJPULuLnp6aFnffB9N9cqEg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: cy8c95x0: Simplify probe()
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 2, 2023 at 10:22=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:

> Simpilfy probe() by replacing device_get_match_data() and id lookup for
> retrieving match data by i2c_get_match_data().
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Patch applied with the small spelling fix suggested by Andy.

Yours,
Linus Walleij
