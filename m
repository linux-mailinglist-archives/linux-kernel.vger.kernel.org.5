Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFD77B98F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 01:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244057AbjJDXzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 19:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240836AbjJDXzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 19:55:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216F69E;
        Wed,  4 Oct 2023 16:55:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2739c8862d2so74518a91.1;
        Wed, 04 Oct 2023 16:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696463707; x=1697068507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQMZEo5ns/KrAyCF1kp+yySfbVppx0dOyApxEiGWCbE=;
        b=YtUv8MOqS4nBb57ZwwL3mU85S6VcOFNGeFjuHt6pXXMorKkUtbv9QHQuqni1ULW+RQ
         EBuyB7Z20T2E/QsSccVZp6+fko5DqCDgomY+Bn9Fa5RRC4udgMYgv9UFgJeKT/wSVa6R
         tRtoVjLPRNzJg1+0ZQUeZ7YB2Y4sk9+aNzAOzQ9/oL3KvS7CC4IpmeQRnHV9M1/Mdqtz
         gf9HNKi3TIiJvu5Lco2q9KAg6C2osr/6+/IZaYZ3I4rwUb32cexE3dfI9gTM2EOkOaq6
         Bxa5w+yMF9qpLAV66lHGDNTx4eqyiQWHCkR1sVL2yKLapRQmYcHs22h2oAm1Lr1EwDLZ
         I5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696463707; x=1697068507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQMZEo5ns/KrAyCF1kp+yySfbVppx0dOyApxEiGWCbE=;
        b=l7juGgtGfWoqBZpq2W+1jM7tTZOTn0tTCchBOumVGpa/1D1jOEMvVuVJDbaJgq6/CB
         0UimXpXAoA7GgGhAdfUC+nrrsXCr36ZQJ4X7WatB9AhJisXOs/v6U/FIS3r3oB+KRqeI
         YA87W+o7qy4+67DFiIoo/jbaCJ2dhPbeonPGuzLcBMjtxz9fdYYJc83h2nuXpZXXpOLX
         I0dUc941G3oBzTwQucVTuBrKuGsLkzY8R40AYhO1c8m9oJ9zx74C7GVL/VRxSJrKk04K
         uBVRVGlI4oEfqB4WQy20RFMEOwO+Ntmq04aRo7+ttRFVDX8JrCiJqBk8IPeAvJSjVaYQ
         6/fA==
X-Gm-Message-State: AOJu0YzRyRf5w4jALx+Jrz1jIOwIxFkUBNL1OlX/i0izgvmIXPXAbQ7I
        3S07K9WLIKHWGQn3c3iLXidWNh+xN0meb+Pimbo=
X-Google-Smtp-Source: AGHT+IGZjulBYw4C4UDntwo3p4bYn3DZqLz0s0HOe6X1EHASkwvbQSj0Mc11e4ob62ejPsZpKk5xH4Vktr0W4iQjHqA=
X-Received: by 2002:a17:90a:3da1:b0:274:60c7:e15a with SMTP id
 i30-20020a17090a3da100b0027460c7e15amr3307906pjc.4.1696463707437; Wed, 04 Oct
 2023 16:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231004230159.33527-1-aford173@gmail.com>
In-Reply-To: <20231004230159.33527-1-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 4 Oct 2023 20:54:56 -0300
Message-ID: <CAOMZO5A+kCT4rwOq6h89s4eHe4Gm0T769qVQ_VW_hdX53rrb7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm: Add sound-dai-cells to micfil node
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Oct 4, 2023 at 8:02=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> Per the DT bindings, the micfil node should have a sound-dai-cells
> entry.
>
> Fixes: 3bd0788c43d9 ("arm64: dts: imx8mm: Add support for micfil")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
