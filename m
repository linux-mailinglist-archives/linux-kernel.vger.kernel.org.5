Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8AC7A44AF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbjIRI33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238824AbjIRI2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:28:55 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C7A91;
        Mon, 18 Sep 2023 01:28:49 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3aca5c85a34so2935377b6e.3;
        Mon, 18 Sep 2023 01:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695025729; x=1695630529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFuELjL9wHU3/r3v6NC6dkdDKAH/Ysa2Z6sZ78BU0lw=;
        b=iuqkaCu1rA0B97aWG6e9nxZA59nkX+kOIPA8Rnp/4e8JNWZY8D+5e6R3tkVffS5ApH
         g4iPR+c1bJWTUDJNO+ghIjUg2NqXj/nAQtQHt5L5b5nsPgPf2bfIiyohn1r5uQPAglfO
         VOsGzK/0nT7i0PIhilkxLs3gHzrDxuZdafnpfsxuHlsGV8jnHRtEfVy7WuKgMA29RTIv
         0jhJuH7yl2yw0GaFxCJ70m+gVKn9qHjl8h2vixNCCC5ZOcwbts1LoqI8LNbw+ttNl+ou
         hQSvbeUXasG8Ed848oYqDOHzhfARBjpNaDt91IDOzjxcDSjDg8rF6kCgjNLyo3OK+97x
         ukXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695025729; x=1695630529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFuELjL9wHU3/r3v6NC6dkdDKAH/Ysa2Z6sZ78BU0lw=;
        b=FO23C17TN62mWajeLagWAp9KyDoWT9XMqc9Srz4ph4zd79cZBOi5wfiFY4CHM14yRx
         pp7JVISkoRUI0bpAqqieny1xzhGTBZm6ZWz14JhU/bXEmA23fxgNWaPi/1vygLWz68Jl
         tL0zlcwNzwS0B5M+3Dw3hb4UdyDmxsrCFtRtgD22smnHDlX7kByMf2sskoH5TsGuInLi
         yJE1jslek9dfyoBOcXtMCi/m6h9CAnBFuXgtnb8dpdR4N6tcQ8+l5kLAibloq4gPeIk9
         GSPx4XOcahnoH/MGOJ5/3UyXN0p5HTWb9+sKHv6m1FlnJqrRNwZp/RWNGLSLc38/nq1/
         rMJw==
X-Gm-Message-State: AOJu0YwuLZYRtWXNYnM6xRqHnvhHAdGRwORGd4n513hGbmH8ZX86bxcY
        0HMYn43uu1XhignTVqPWy8hooco+LvaanE1VqOE=
X-Google-Smtp-Source: AGHT+IG4kn+qWd1PhAyH+rl4WMfKjGa4HXKlnZITVifNV3eU5cCeivDBadKLeEFA6nPd9OZgAYGvv8f66qRINkj3Zxc=
X-Received: by 2002:a05:6870:c08a:b0:1bf:2ad9:8dae with SMTP id
 c10-20020a056870c08a00b001bf2ad98daemr11496221oad.45.1695025728955; Mon, 18
 Sep 2023 01:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230918075915.87029-1-arinc.unal@arinc9.com>
In-Reply-To: <20230918075915.87029-1-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 18 Sep 2023 10:28:37 +0200
Message-ID: <CAMhs-H-mDrPDOVvxsQnUZPLqC5YVOO9O9FhBcbAZ7vb7c-V=Yw@mail.gmail.com>
Subject: Re: [PATCH] mips: dts: ralink: mt7621: rename to GnuBee GB-PC1 and
 GnuBee GB-PC2
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 9:59=E2=80=AFAM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.un=
al@arinc9.com> wrote:
>
> Rename GB-PC1 to GnuBee GB-PC1, and GB-PC2 to GnuBee GB-PC2 to include
> brand and model name.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
> ---
>  arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts | 2 +-
>  arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
