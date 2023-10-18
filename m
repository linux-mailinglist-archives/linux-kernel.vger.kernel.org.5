Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0300D7CE467
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjJRR1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJRR1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:27:14 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05102448D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:27:12 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c5210a1515so56689961fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697650030; x=1698254830; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+Kj7LOopyrO9EbtedWl87IOzpgEdsrSg3mf/n9/RII=;
        b=23BVLdIzqR6bI4D1ozZsMCKXQpAIK45Sbf9jMpNSCiYy8nWHZEg0GgAQzttgeoJSP0
         91i4sZ6jeqyswQcpTyVHiU6//M3B1zE9WqupBHmA5oDLYizxIGV0ViAS5+GfTXZhg5h6
         QAUlKxTXrxlqjC1tvlf9zPsYLbCDF3dLGUx6NnCZoOTzV016qVkWP0qZ4UzgVhBdu9cD
         7BjoKZEpFhhJUtyu2e+jDTjRmP20VyP+TkXMk+QP3gpHYLRSTJPhXGljrVmRgtg8hjpL
         I1AEZBxLyqZ7xZiFtPU1giFieM1+pXPBuCt0slkEs7397q4KT+preYsnLf5Vha7epSKK
         HOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697650030; x=1698254830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+Kj7LOopyrO9EbtedWl87IOzpgEdsrSg3mf/n9/RII=;
        b=rehpXmA4W78Rh52HTO/akcS5wKYJlZqhl7zAiA5dXxV/ETbS4J5k+I3zPaNBXid+nF
         8CrUZb8WTmLQuKQ6xuH1O98cNHZ4JWHB0g0SYRil59mLPTlV3fZWydgFwEZeIT00abEc
         +9CGJRoffnb+3MWurtUjbpEK3eC8QKUnNnAe/sK5Pg/eLS1CP5QQYT22Vm3AltvpYNd+
         k6Fesz9kzCCRGhcqIjhltyX+0KHfmXU2G6PSCsW2MmX1Cx4IW1NxeUH0hq9YS3L9ziyB
         q2pkVZhjGcdn4CP1diDeVwtGpy0hkbrHVBEdcBv0A9fhEeVc785LsjyEG3EWOYcAG13N
         XrRA==
X-Gm-Message-State: AOJu0YwPcaAsRz2yXpkZAxEyG0BU2TbkniBE7I7S6QcOaaMvgXfsDook
        moSlVRNXUxLeIui2IUP9EebMv2WyNqPm7TiGNiKVvw==
X-Google-Smtp-Source: AGHT+IFZJhAw5mzgscPKCkGfLuEObjAjse1oj45qbH86RhgIjYIEdeLlJt2zA/fa9rmaEbB5fXJsbYZYUW7bovjuTmQ=
X-Received: by 2002:ac2:4a82:0:b0:506:9c0a:17d9 with SMTP id
 l2-20020ac24a82000000b005069c0a17d9mr4831537lfp.40.1697650030177; Wed, 18 Oct
 2023 10:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231017131456.2053396-1-cleger@rivosinc.com> <20231017131456.2053396-6-cleger@rivosinc.com>
 <DA8B4610-D514-4733-B875-C247FFCCC7AA@sifive.com> <af785f0f-9de7-4548-9cdb-f392cde1cc2b@rivosinc.com>
In-Reply-To: <af785f0f-9de7-4548-9cdb-f392cde1cc2b@rivosinc.com>
From:   Evan Green <evan@rivosinc.com>
Date:   Wed, 18 Oct 2023 10:26:34 -0700
Message-ID: <CALs-HstEBt-ntCcETa9YwS6On3nGyoEc2p7R-gaBLG9+aFJL5w@mail.gmail.com>
Subject: Re: [PATCH v2 05/19] riscv: add ISA extension parsing for vector
 crypto extensions
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Jerry Shih <jerry.shih@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 5:53=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
>
>
> On 18/10/2023 03:45, Jerry Shih wrote:
> > On Oct 17, 2023, at 21:14, Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com=
> wrote:
> >> @@ -221,6 +261,22 @@ const struct riscv_isa_ext_data riscv_isa_ext[] =
=3D {
> >>      __RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
> >>      __RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
> >>      __RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
> >> +    __RISCV_ISA_EXT_DATA(zvbb, RISCV_ISA_EXT_ZVBB),
> >> +    __RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
> >> +    __RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
> >
> > The `Zvkb` is the subset of `Zvbb`[1]. So, the `Zvkb` should be bundled=
 with `Zvbb`.
>
> Hi Jerry,
>
> Thanks for catching this, I think some other extensions will fall in
> this category as well then (Zvknha/Zvknhb). I will verify that.

The bundling mechanism works well when an extension is a pure lasso
around other extensions. We'd have to tweak that code if we wanted to
support cases like this, where the extension is a superset of others,
but also contains loose change not present anywhere else (and
therefore also needs to stand as a separate bit).

IMO, decomposing "pure" bundles makes sense since otherwise usermode
would have to query multiple distinct bitmaps that meant the same
thing (eg check the Zk bit, or maybe check the Zkn/Zkr/Zkt bits, or
maybe check the Zbkb/Zbkc... bits, and they're all equivalent). But
when an extension is a superset that also contains loose change, there
really aren't two equivalent bitmasks, each bit adds something new.

There's an argument to be made for still turning on the containing
extensions to cover for silly ISA strings (eg ISA strings that
advertise the superset but fail to advertise the containing
extensions). We can decide if we want to work that hard to cover
hypothetical broken ISA strings now, or wait until they show up.
Personally I would wait until something broken shows up. But others
may feel differently.

-Evan
