Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514CF7AD8B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjIYNPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjIYNPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:15:41 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E2DFE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:15:35 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59bc956b029so76741777b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695647734; x=1696252534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcC37wQSlviDQDGelF47pyhsR+4+hM7dLjLOaaG5IJ4=;
        b=EUhE/s81IoIPg2TR2lWYyyI5w8Ojtk1otKRoqmEkBz4PqL0qzpndxZjBd2ogi18+vX
         GBgTpUIzej92wvYhWx5abPeSSzbZwsOWwSnCWD4KPGvL/NI2cqSxK34tZbhWMLUGvZQn
         bZhQEOgS7jKpVzqHJpKF5bV9hOFIhwiSoeDFMJmiEAzGEgNTBmwffBIhXMYbumT2SGqa
         RILjM2JNPpmTTayHs/5zKCgh2T1JXegnbp0TpMEUqy74GbBrYyqy5MbO5hTrUnnOwvD9
         U0YXBuU4rYwf7jp6U86p+1vAaeHOdaLUEcfEiWcyJ0Zy9GnWyK3veyyfTSqR/RpTct/2
         6faw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647734; x=1696252534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lcC37wQSlviDQDGelF47pyhsR+4+hM7dLjLOaaG5IJ4=;
        b=esE4WnWXBB6FWsja+W6yeJakpPSqMDMWTZlvuWpNapVai4sSoiARZWud2iJDF2ZibG
         jvYRge3VDwoTKrHosuAIvThSYGQRSxyNvdo4pfHr53kA0N6oriX6OGnnRgrJjVqkwQSS
         +WpD/BbmaYKUQkyuUe/gfXfGHUkm7g+o0TdkYK65Bm8tTunMCGXT4Xz9hAL1lnX2JhaS
         c+2YArzjkKYTzjhl0s0bIYdAMevMVxkntykw6srUqE05qm2XpCnplB6TtIa+Q2zjT9Td
         ovsRK0bvYwz95M+wSG2ullqpBmnhM489DdHimQxTSFUPZf0+yIuA9OXf8gXnTm9xV7g8
         ZRoA==
X-Gm-Message-State: AOJu0YzaaLtYS6Jab727raeyNU/+pRUcOFoN0m9kwN7qv055cZyyfnlq
        TPZqvyWV+rZtFU6pW+1eEf/gGeEsNnplMpd/ozUB8w==
X-Google-Smtp-Source: AGHT+IGItYvswC2u29u8Avn3i2K5RB+tU2XzlzVbCIQUyAgfXNs59SBMHMovhmBPOhzKl7FIGgTIlg3vauP/2uAKAhU=
X-Received: by 2002:a05:690c:23c1:b0:59f:4c75:1314 with SMTP id
 do1-20020a05690c23c100b0059f4c751314mr5692718ywb.4.1695647734133; Mon, 25 Sep
 2023 06:15:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230920103332.274151-1-joe_wang@aspeedtech.com>
In-Reply-To: <20230920103332.274151-1-joe_wang@aspeedtech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Sep 2023 15:15:22 +0200
Message-ID: <CACRpkdaZb+V-Zx_Uw9MCqRqE+N-0gd__xEFV3BTpkG7icU9W+A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pinctrl-aspeed-g6: Add more settings for USB2AHP function
To:     Joe Wang <joe_wang@aspeedtech.com>
Cc:     andrew@aj.id.au, joel@jms.id.au, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 12:33=E2=80=AFPM Joe Wang <joe_wang@aspeedtech.com>=
 wrote:

> AST2600 USB2AHP (USB PortA: PCIe EHCI to PHY) function needs to set the
> register SCUC20[16]. Set it to enable the PCIe EHCI device on PCIe bus.
> Besides, also add USB2AHP signal expressions into pin declarations.
>
> Signed-off-by: Joe Wang <joe_wang@aspeedtech.com>

Patch applied!

Yours,
Linus Walleij
