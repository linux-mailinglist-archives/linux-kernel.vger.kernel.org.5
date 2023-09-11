Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADF779BD43
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbjIKWjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbjIKNx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:53:56 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199BFE4B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:53:52 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-ccc462deca6so3987179276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694440431; x=1695045231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLvWZ52i+dyCSAmh4Y03SqBKrmy28LwkDvJNO6anitE=;
        b=MvHG5vX14o4i5NGt/nQqLnCm1YkFABsbQAx/8kX+mZjyKehzpB1ENwYPKw0tQ9sKbA
         O9deuTjEwYtO8kqzzHGN+fAnGtytiJmIzZkVOqEEqV/AuIdijqul0pr4swVu6UehNIn7
         mxrvC8ShDIjp9lQk4sH09Ygf5zz++yEv3OKWhSnsJ6LIOYjCbzqoGRUdfXnJWh/Ehct/
         OsgEiFtrQlpAYyRh4yWcRVcY2kq4Ln4l9WpPP2YVABsmcKHZ6W88UxaLbdos6ZDRIMsO
         ey+dUOMcx2MpY0oWkJJA8e4bYE4pU9JTSc9Ys6U1tKCr0o9Hi0FaOVnv3X+g9CxW4jf+
         Zl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694440431; x=1695045231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLvWZ52i+dyCSAmh4Y03SqBKrmy28LwkDvJNO6anitE=;
        b=vP347Tw1HWb5Nabxyin1nCfZsJJPHMWr12n+EKhR8rmDO7DV60My/Eq4JGLmewE7Om
         5Wkl1eMHxn440LwsoYEUUdN+xR3s7qon1QpREaqKwX2w7UPo4hfIHuf1I47ILYLKs9kY
         ZTXsyIHW0n4+LXdWuLRaf7K8eOGcdz5ZCqmwM1YOX026nEffo3hw8nR118psHy1vPNQT
         HyJ7/qHe5xEs7xzyXMw274x4Ihd1591+kyrqQOQHIbSZAUeMJ6ZnWwDo3Zg55bdgS69V
         9UCyHAhVcrlAyS5AWG/0nZXnNDBMnEVmhti7f/ftxZxCa4bulzzvmzQgZtIgcIPCwvPN
         H32g==
X-Gm-Message-State: AOJu0YzwB8rwm42+/tExz7+vhtfdM67zv4JQ0UPn/cWpz1uhUKJl3LAU
        wFISk4YC8iNOw5yn3YWpXoYs1bPFvWN/N8AuiyY1nA==
X-Google-Smtp-Source: AGHT+IHp45MYsPkvvvVaXHQ4k98NIkrWPaOBthFZdZy9COqTKpRoYFrEK1u6n2IGbrTU5QDj2PG6u+wrSp/eBuXoh44=
X-Received: by 2002:a25:502:0:b0:d12:ab1:d88a with SMTP id 2-20020a250502000000b00d120ab1d88amr9001432ybf.40.1694440431348;
 Mon, 11 Sep 2023 06:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230828140849.21724-1-tmaimon77@gmail.com>
In-Reply-To: <20230828140849.21724-1-tmaimon77@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Sep 2023 15:53:40 +0200
Message-ID: <CACRpkdY0C7S_VjZ8CKxj9MOv401jUPesvwKwHyCfHM+p8jRSOg@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] pinctrl: nuvoton: add pinmux and GPIO driver for NPCM8XX
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, avifishman70@gmail.com, tali.perry1@gmail.com,
        joel@jms.id.au, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, j.neuschaefer@gmx.net,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 4:08=E2=80=AFPM Tomer Maimon <tmaimon77@gmail.com> =
wrote:

> This patch set adds pinmux and GPIO controller for the Arbel NPCM8XX
> Baseboard Management Controller (BMC).

Patches applied. I can send some more nitpicky comments about
patch 2/2 but they are not serious enough to warrant a resend of the
patches, it is better to touch it up in-tree, if at all.

Good work with this driver, and also good patience since you
iterated 7 versions and polished everything up so it's really nice
and shiny now!

Yours,
Linus Walleij
