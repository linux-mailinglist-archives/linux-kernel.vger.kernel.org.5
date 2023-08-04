Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE39770358
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjHDOkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjHDOkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:40:13 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200504EC1;
        Fri,  4 Aug 2023 07:39:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe45481edfso10922045e9.1;
        Fri, 04 Aug 2023 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691159983; x=1691764783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/keJTTgc2oKYX00bfWRy8iHTbGm3dqXm1dsaxhchcPc=;
        b=KvfYSC7CEGPj1YKXYXG8g17C2CnIly55fHMe4Bh/zvSSV8wQcCvIDANJDAg7EFYs4k
         Rgxq2Sa7zYSYpyWedo5/COPTTpFMxQYLDBQI7zXnifk11g5RpHYI/SSkODB7BPR1kNpu
         RH7IzSbez5tb7/fYj4Hgo4DtniyoeeUIIFaHyRMwuZrj7tw3vyB9o/43BIuP0FLOgz58
         9JAc9SwqVHqix78jPoFsov0VCFE2WP8aO4cJsRZj8iN8yy74PjUZeWOM2cdpy/zy6HP9
         dK7t/LUbhrN2i4Rd2ji/MrW/GO4Vl88dDHD+/PEvM3S7rmZO5ja3j96DAqugQMhrowPi
         hbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691159983; x=1691764783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/keJTTgc2oKYX00bfWRy8iHTbGm3dqXm1dsaxhchcPc=;
        b=gURXDY6vijfg9UfYGm2CXHeM96KWfZj8ohUUB/yG2abALX6LwJTAYd4Hcvl1fGwO5y
         CIGBvb+m/XWrkTUC7ZxWK8LXugDget9IUaezQYFM872+Ja6bTQNCd6tC3bYkEIlhFShl
         TOBHy+3d368njVyT/t+LF8DG6die7AiNU6nxKYzjMANvLKfoAfckgqM7P8lU8as5tIqd
         TzhB/XD0Yi0gwctZ0BRuYFi2Ea4XlbqUBDKS0Gh8n+jytRrGddT7XeTIKrx0EeoeGx/b
         Kak4xEWaAQ2BCTYw2Mncifdh+3pK6ZD5yyOhMVuY96ruGowDJW3aD1Uo9wesRbbClUuu
         uBGw==
X-Gm-Message-State: AOJu0YxMunS+/siTiu9TH2kBhpGYvg7035hR5ZSkr/HESaNfudbecjaA
        sdvfwOfd0XEqCk04w95F6uk=
X-Google-Smtp-Source: AGHT+IF3frUwbfH0b36TWheEdo2zyf2bWjXefALR0x/pFUcE5xwHRR11pBKFVe1FSUbK1lZJev7c/w==
X-Received: by 2002:a7b:cc95:0:b0:3fc:3f31:4233 with SMTP id p21-20020a7bcc95000000b003fc3f314233mr1884635wma.38.1691159983036;
        Fri, 04 Aug 2023 07:39:43 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b003fbc9d178a8sm6834019wmb.4.2023.08.04.07.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 07:39:42 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     John Watts <contact@jookia.org>
Cc:     linux-sunxi@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mkl@pengutronix.de
Subject: Re: [PATCH] riscv: dts: allwinner: d1: Specify default CAN pins
Date:   Fri, 04 Aug 2023 16:39:41 +0200
Message-ID: <5696365.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <ZMyZ5kZSiiJHtdeS@titan>
References: <20230731023701.2581713-1-contact@jookia.org>
 <3248110.44csPzL39Z@jernej-laptop> <ZMyZ5kZSiiJHtdeS@titan>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 04. avgust 2023 ob 08:25:42 CEST je John Watts napisal(a):
> On Thu, Aug 03, 2023 at 10:59:30PM +0200, Jernej =C5=A0krabec wrote:
> > pinctrl-names and pinctrl-0 are usually at the top. However, since there
> > is no hard rule (I've seen it mixed), I'm fine with it.
>=20
> Happy to change if needed.

If you don't mind, please do.

>=20
> > Since original DT node entry goes through netdev tree, this should be
> > picked there or it can be dropped there and I pick both patches or I can
> > pick patch for later kernel version.
>=20
> Do I have to do something based on this, like resend my patch?

Nothing on your side.

Marc, since you took original patch through netdev tree, what is your decis=
ion=20
here?

Best regards,
Jernej

>=20
> > Best regards,
> > Jernej
>=20
> John




