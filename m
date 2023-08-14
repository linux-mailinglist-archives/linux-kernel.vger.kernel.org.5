Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB1777B0C0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 07:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjHNF3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 01:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjHNF3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 01:29:02 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F01E6A;
        Sun, 13 Aug 2023 22:29:01 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9db1de50cso58613251fa.3;
        Sun, 13 Aug 2023 22:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691990940; x=1692595740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGZyPbP3dzjwp/wLly5dZJJDO3ZcjmUG+xoEOUDLDuc=;
        b=e0Gac0Da6KXLEGNtelm3EFOPtEeK91Qj1q2koIajDnLcIdoz2ZGrwZPExkEhh9yN3c
         t33ZJydXNb3bqU0aPWTkOMrw8O4NmM+30WFc7Vd2aQ05PzujPzogB0y1fvWSQ/1k4AMG
         vU6899pM8mw/geFRvQzUdlRQiYJ+eHtBHco+yQyJK2pnJ8XNg+ODZKSJX8N+LH/MiLF1
         XdhZGd0znDXp5h3oUqTVxGdb4WHt2awrj0UkXKyaOaiNrDIMyrrvBAh3M1nue1IEvD6s
         QcCZYBcCFZIc0viznwHfdX5h5brxzZmmeStKpPx8TlxktdWTJIwtQFl4U5qMY735tEM2
         PLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691990940; x=1692595740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGZyPbP3dzjwp/wLly5dZJJDO3ZcjmUG+xoEOUDLDuc=;
        b=ldBNOpYxCbigN/GnqlvbDXY50H6TT6UqAr1zSS7Qv3RUlxLuIbhfgkZ7Ph3jkhbBHw
         RjdP1gXc/J5NcYL9JTzEMSJNyGUwJU0Ob9rIVBoeEvAsuMVDd8x/C5qU40yqGQHJy64d
         m9ShOE6RMpPsaVkaz/oVZ48qSTE5D05HbFgwl+OY68G7tG/azmnZB/wDESkS41iqA7J5
         gheO1oLyMICaBnh8B8dlXhGeYEkWctfhwKCEWSv2pYZcr47OhYh7ocnOqbXquQTFGcAV
         aDzBnnPn7+m1hYPOOgejRP7gZAjZOzlHYyO5wPIiMn64uuZdFQtYdaDXX0KupDDVuq6N
         TwSA==
X-Gm-Message-State: AOJu0Yz1O7y3XHQUXy4XUwSD2jb4B9yZM+BKUH3+MovZn9zbxi8iu6qd
        eRU0HQeR0DmrJ+akYl+VT1DCG/4j+LKd/mHaC2E=
X-Google-Smtp-Source: AGHT+IHA+eWMvhISyFBVAeBZGt8uccSi2b3i7SypwBjC9lu/LcdShKA+dMXotAZUkAb6evmv915C0Q26Jc0ucn5hMQM=
X-Received: by 2002:a2e:8897:0:b0:2b7:117:e54 with SMTP id k23-20020a2e8897000000b002b701170e54mr6247163lji.4.1691990939564;
 Sun, 13 Aug 2023 22:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230806-xiaomi-star-v1-0-0c384e8b5737@gmail.com>
 <20230806-xiaomi-star-v1-1-0c384e8b5737@gmail.com> <244d165a-1e53-401e-be36-6bb3f4f260ae@linaro.org>
 <CAA8EJpqiaEamZ6u9D_Sn-bgn8qdpqsQ2EMt7Tb9hKr5kNO2JFg@mail.gmail.com>
In-Reply-To: <CAA8EJpqiaEamZ6u9D_Sn-bgn8qdpqsQ2EMt7Tb9hKr5kNO2JFg@mail.gmail.com>
From:   Sophon Wu <wuxilin123@gmail.com>
Date:   Mon, 14 Aug 2023 13:28:46 +0800
Message-ID: <CAEPPPKthfyZnD9z9Q5c7YnPMAJhGfyxJdfpzZmhoxK6xxv603g@mail.gmail.com>
Subject: Re: [PATCH 1/3] soc: qcom: pmic_glink: enable UCSI for SM8350
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Baryshkov <dmitry.baryshkov@linaro.org> =E4=BA=8E2023=E5=B9=B48=E6=
=9C=8813=E6=97=A5=E5=91=A8=E6=97=A5 18:56=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, 12 Aug 2023 at 14:12, Konrad Dybcio <konrad.dybcio@linaro.org> wr=
ote:
> >
> > On 5.08.2023 19:03, Xilin Wu via B4 Relay wrote:
> > > From: Xilin Wu <wuxilin123@gmail.com>
> > >
> > > UCSI is supported on SM8350. Allow it to enable USB role switch and
> > > altmode notifications on SM8350.
> > >
> > > Signed-off-by: Xilin Wu <wuxilin123@gmail.com>
> > > ---
> > I can confirm this is also required for my SM8350 Xperia 1 III.
>
> Last time I checked it, UCSI was broken on the SM8350 HDK. Trying to
> enable it caused pmic_glink to stop working after some port
> operations.

I guess it could be firmware related issues? It works fine on my
device with latest firmware.
