Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A49757B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjGRL6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjGRL6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:58:15 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36EA1A6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:58:13 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5774098f16eso59226997b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689681493; x=1690286293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59ojG0gIJMBH787QYkyMNNJwFmMukWGw4ED2w5fU/lw=;
        b=uVHPntbViJbo4FXUJwPfzVmJ/yERr5p349TtlmHMxs3snOTfUAUq4P7O6zQn0tAJMH
         e0J6puyQbNPjrvu2ZalcoW+qRx3WyWbS4h5nvKjkbLqKmthGRBp0ioafrKE3lUIBxPKr
         hu7AQzOPk7e85nbuQEL666+eBjqPghmCIeR9txiR6w0HMuGMF+TCulfUnpnCOh7tsLzE
         9HFd3oHCTCyQ9fUfjMwC7VDQIQR865BA6XbJYY963/YjiedLGqD+Ho2gLjie6K7kDtTc
         1fBYRsHmoEFO/cwKBhmDJwLAqmoQX8mCrPTgFs6JbX2DOTERftyRBv+UHAOXxU1lxrrV
         HfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689681493; x=1690286293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59ojG0gIJMBH787QYkyMNNJwFmMukWGw4ED2w5fU/lw=;
        b=QNUl8lVdm5/JYG2fPaRcwqWUpQqZnmfOp7YEW8GSxeqko3v6A1TrGwkPI3NLdeKUjF
         BZpKb8X6Ayw9N3NDufIlOSOv2rFt+bBpn0R/AqASHks4/n8xFrBabJS6gLYsCvsFMGxu
         srqsA53DqlSGSwkT+ERMxmXzcd7soDBhMhbNxGA9ydWzG1siU2jJaoLHvaAwtB8zAub9
         bZu/plm01pDzuOztR8/Lor8nftPEUjgnkLhlioiDbQd8NEeM995a1+ClpQ2WR2nEt10e
         q8HbvZjgCU9dL/xfnaW0kryCqdgl27F+1fGNMhC/CTd5WwQo33tDPFh/0bDi0SKcCW4N
         Wp1A==
X-Gm-Message-State: ABy/qLbj8oPBeulVRlsGKfh4Wh9BpASiYX4UZYidumf355C806q2gSgD
        G7fPbFbVpz1iKI63ZoLYKYBvHH3qO7V3R5kDR/Apfg==
X-Google-Smtp-Source: APBJJlG4qHhUdXHN3k0Odt/kIDusXhPoRU4F4Y7yU9rMcm8SVfcidsaPlWaChO7XfVB9BAR4jvh6BOmTHOxKGY0eKKc=
X-Received: by 2002:a0d:dd45:0:b0:576:98e0:32a6 with SMTP id
 g66-20020a0ddd45000000b0057698e032a6mr15306374ywe.14.1689681493112; Tue, 18
 Jul 2023 04:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230712-spi-nor-winbond-w25q128-v2-1-50c9f1d58d6c@linaro.org>
 <f00fa2ae-6d4a-90cb-3724-2bedb96cb4fb@linaro.org> <0525440a652854a2a575256cd07d3559@walle.cc>
 <d99d87e7-47ba-d6fe-735f-16de2a2ec280@linaro.org> <e642ff27fd0bc0f1f0e293972145f680@walle.cc>
 <2d71326c-023e-69af-9337-62672f50fed9@linaro.org> <62083227d40d7b631c2eeac1e40c6b56@walle.cc>
 <ef557792-144e-12ef-ce14-f98982b608dc@linaro.org>
In-Reply-To: <ef557792-144e-12ef-ce14-f98982b608dc@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Jul 2023 13:58:01 +0200
Message-ID: <CACRpkdY_3Ecw06ECVx3=xB9G1zUBDqmjuhwbaS8k3+RKNErwnA@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spi-nor: Correct flags for Winbond w25q128
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:47=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linar=
o.org> wrote:

> Hi, Linus,
>
> On 7/18/23 09:32, Michael Walle wrote:
> > FWIW, I'm fine with the removed no_sfdp_flags if INFO(, 0, 0, 0).
>
> We'll need a v5 where you test again the flash with mtd_utils,
> as we want to get rid of n_sectors and sectors_size and instead
> determine them from SFDP. We agreed that the flash entry should
> be defined with the following params:
>
>         { "w25q128", INFO(0xef4018, 0, 0, 0)
>                 PARSE_SFDP
>                 FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>         },

Roger that!

I sent a v5 which does this, tested by taking the reported
size in dmesg and divide by reported (correct) eraseblock size and
it results in the same number of sectors as well.

I put the details into the commit message.

Yours,
Linus Walleij
