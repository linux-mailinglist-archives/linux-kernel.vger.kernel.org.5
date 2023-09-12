Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D5C79C9CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjILIYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjILIYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:24:09 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF8510EA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:24:05 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d78328bc2abso5014912276.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694507044; x=1695111844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTDlvFYbsx79XjnXV/v1eS2oK868sA5+g3OCAFf6938=;
        b=FBhB4z6HcF6EizL+/lwxRnvBPsnUBCZNCJdmUZqMhF2t8tNtnTGFF+JCUzlHUG9Exo
         EggToZqBJppvlFyjEBigx34yWBARuEWqMz4yka52D9EM9UM1QrISxBRPtWDZ29WUYe9q
         d2krkdkVjxK27mY+IVp4h5OuRfx8EOC24+q01oOZ9zVKap5Gn+pmjs1tgIAXdxIMWl2s
         hlUypNi+ZXFlGreD6ZHACbQH+jnwcETJOh0eM2WKZkO86QxIoS8ndf9uFvCult8qmb5z
         WmJNShM2s+Z914AefMurd58mLEBMQpCYyRNyQgzLfOJXMC6Jyztx8eDTmu+++2h4nbhP
         glxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694507044; x=1695111844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTDlvFYbsx79XjnXV/v1eS2oK868sA5+g3OCAFf6938=;
        b=McsTlyFQir9QXvVLja7mWz32ggium/TH8TI6c1lBfa1tUq+67rtegEj18uL7Gp7Lmc
         /xoxag6R3iynhBCdygNd9KVnzNSVDqxGOHbjAON2+46Ii7GUk1m4oSlAqxUSe07wbZVa
         GiXtl4aZc3HMRH+FJ0t18hbgI2XOjQp2REiySHBbBlPXzbDe+MauQB3awpnX/psJsPZ4
         uxJf5EQPhmrF6Ymw3+KmQ6jdA0EjK9FvOL9K1FCHlz2x0YWrGQO1QMwD45kpEkXMlH9R
         0RuOQdnv5kZyXS0nRzsmaayTHd1Wv7WutIkuujJkOOFfyZun21YqQITV0uH4HXz7jh45
         HfyQ==
X-Gm-Message-State: AOJu0YzVlkrMxcWVQb1MU3l4sdVbiHNe4ISpTLitAgoFPnx6Zl43Mp2Y
        r+/7HToZlAQrk0hn0p18wZx7y7fkCNOq9zR/XByEvQ==
X-Google-Smtp-Source: AGHT+IFd+7FzVpzIXwF6eF0XM98eCqwGR8vQyKfh9Y2GKm2qYYnTSN7eR9A+5PvS2Qu/0xw3IHJQEnNJumvhS4CTpxY=
X-Received: by 2002:a25:d4c6:0:b0:d7b:95ff:14f with SMTP id
 m189-20020a25d4c6000000b00d7b95ff014fmr13092370ybf.61.1694507044304; Tue, 12
 Sep 2023 01:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <1694429639-21484-1-git-send-email-quic_mojha@quicinc.com> <1694429639-21484-15-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1694429639-21484-15-git-send-email-quic_mojha@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 10:23:53 +0200
Message-ID: <CACRpkdYBH09emydQPaRUgEJuHdV0tk3=xeMXxD9UVP0GH2XZEw@mail.gmail.com>
Subject: Re: [REBASE PATCH v5 14/17] pinctrl: qcom: Use qcom_scm_io_update_field()
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     corbet@lwn.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, andy.shevchenko@gmail.com, vigneshr@ti.com,
        nm@ti.com, matthias.bgg@gmail.com, kgene@kernel.org,
        alim.akhtar@samsung.com, bmasney@redhat.com,
        quic_tsoni@quicinc.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 12:56=E2=80=AFPM Mukesh Ojha <quic_mojha@quicinc.co=
m> wrote:

> Use qcom_scm_io_update_field() exported function in
> pinctrl-msm driver.
>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>

As long as the qcom maintainers agree on the rest of the patches:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
