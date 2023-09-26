Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BDA7AE457
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 05:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjIZD7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 23:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjIZD7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 23:59:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BE5BF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 20:58:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50307759b65so12850472e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 20:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695700735; x=1696305535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lV5ugLr1Y+ECdRI+pDpUWEKUXpx2iu59FhqsHyyCDrw=;
        b=TTCkOnXVfogWOXzpGEwjPLwPVfMaGm6hVtAdaFqXIGQ7PTiEZ1wr65Y2sg+250HNvb
         CJhD88bkZ5rugm0Gy98EsfuJmLPsjUJJgBJicobmrGGYxIXouVN3NPMYuZih0T16FeRw
         d+quLWEbPW3ddf8K+r2qlOmr8FGWT3AmbQoS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695700735; x=1696305535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lV5ugLr1Y+ECdRI+pDpUWEKUXpx2iu59FhqsHyyCDrw=;
        b=JX/K7pWvYgwgQdQkGiNg84QreKS67eKSHr1HgrTXoBKkuDuKHp4e3Re1ZrgVQeobZJ
         tzSm+O/xChfI2126dXyRxL0nZlrzdUB4ODu5ly6KTA0l2MongIEKpWqZARe0z3Fkucps
         EAuba9IRkQ0fAUwaKC8jqyPv1sp32hr+buY3PhOZ3xmaFlTBxbNQ6MVchhpOOE9Q8KC7
         2WwaYCN+4EugqSUseqA4k08H8RWvXv6qV9vnHzH2p7oGMijxxXV0cMif98iwyVJ1Ns2w
         5RqW6xmHUO382gRwDkJ6T7BDtisbPMhAOPLO21B+A75gl63/yK/rNAxdeq0VORF2zFNt
         v8JA==
X-Gm-Message-State: AOJu0YwnHxyWKyWn+YslEqpB+/6fXSGhhALSEk+3XPIlNXSfOsxRWcuU
        p9iwLLPlkBpnSzvj8nRzQ3Apj88e0xZVc/Eu720bug==
X-Google-Smtp-Source: AGHT+IED84e7Z9ZvMCy6KD0tN48KamDFAPmMnsxp6Rme983CevnefjHgV4b4TUXf2SI7ZugBa8QooYdCYqDrJ5Jp4ts=
X-Received: by 2002:ac2:5e2c:0:b0:503:442:5957 with SMTP id
 o12-20020ac25e2c000000b0050304425957mr6838573lfg.41.1695700734958; Mon, 25
 Sep 2023 20:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230919104357.3971512-1-wenst@chromium.org> <20230919104357.3971512-8-wenst@chromium.org>
 <ZRF6mbpswWoxdJsl@finisterre.sirena.org.uk>
In-Reply-To: <ZRF6mbpswWoxdJsl@finisterre.sirena.org.uk>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 26 Sep 2023 11:58:43 +0800
Message-ID: <CAGXv+5EeQupoWc880sCSOuGsdc24y6qPBaaypdV749oHi-XjSA@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] regulator: mt6358: Add supply names for MT6358 regulators
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 8:18=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Tue, Sep 19, 2023 at 06:43:50PM +0800, Chen-Yu Tsai wrote:
> > The DT bindings for MT6358 regulator now defines the supply names for t=
he
> > PMIC.
> >
> > Add support for them by adding .supply_name field settings for each
> > regulator.
>
> This doesn't apply against current code, please check and resend (I was
> using -rc3).

Which parts were you planning to merge? I believe we're still blocked on
the DT bindings. And I need to update the patches to fix a warning reported
by Rob's bot.

ChenYu
