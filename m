Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4803F7C04AF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343870AbjJJTea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343758AbjJJTe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:34:28 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B13EAC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:34:27 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a7be88e9ccso13766987b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 12:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696966466; x=1697571266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1TE3iEatip9yvGh+p0fhUs0f5bEQ3oymgVBAkvX0SA=;
        b=uGxAcFal0/R2G26/rraZ1ZV7rqTcMiOaAJY8bFHpKAvZy0zhZk3FGpcBb+rVjLbX3q
         mYCcBCvRiR0Wkj4f55HTJPkXsyzHuHL9gWLi32tXyn6bNQu2knGla2kKvxvZi9yQXEND
         PiZxTh0S07HyU5H7e/Dx5u6aHesHLmHfF4Rzh2yvxaLF9muPy2rehxbMAGbSD05/IrNU
         Key7Kjb4yWJuRxue6PccRCYAN9/YQnHsi8yTofylO9GuuQ1FsvkErcBzp9tzdWnDKNVr
         oFDepRO/tWOm/OuBB5xcxGBGQmGSS+9rrT4sw3F8juYmdn829lvEvirkC6vei0IZciVl
         wlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696966466; x=1697571266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1TE3iEatip9yvGh+p0fhUs0f5bEQ3oymgVBAkvX0SA=;
        b=Z+vMKLVnIwDWKoYoIZTF7klIqDfr7hmoaPS/SJ3WOKztIhhE1nVv19QFOGQD1RW76r
         EznUkNTe2Kw5m1aY0ZjQgiKoP5HEsE8mayh1sbS26VZFkg0n9csZDvzqM8QaT+NewK8K
         nXHvjgUdNvDF2fYA7d6ygrs9vVbmHnKgMiQIWKLn/DU0xiHzq8hBOyLBpr/Y0yubUZwk
         Zf2Sb/ibCK+lYdSSujLZDK5rrBIhOI6Lrf2lztXfGYbuiZXbyWfUHih244x7MeG2R30q
         YWMwkRoExH/zDUcJeNMvKRvfYYcos8WDm6MLZQ7p3nDzDI28VNFAvTUC4dxw0O/xaDrT
         4XNA==
X-Gm-Message-State: AOJu0Yw3sQraaWA/4YpUep/dXLMkONmBXP/G3TGboGXaIaO2/eJRztMI
        i+PNsMwJYVWzb/r4sWRP0xN8XBeqpAjw57Pzj/HXaEYp8Pzki4Q6
X-Google-Smtp-Source: AGHT+IHjtoOZeqWNy9QraZ5B0hCFBSNHH3lfMiDLTPTixmnuMTpakH1+veX98qOZPpjjexaRdBxrzWBrtCKOKmQeTs0=
X-Received: by 2002:a05:690c:fc6:b0:5a7:7be9:542a with SMTP id
 dg6-20020a05690c0fc600b005a77be9542amr11929590ywb.17.1696966466351; Tue, 10
 Oct 2023 12:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <m334yivh1f.fsf@t19.piap.pl> <CAC4N5EN=7xrPZGNqa8UNxg_wshVWxOCVmLAYrHEPXa7u7DNn6w@mail.gmail.com>
In-Reply-To: <CAC4N5EN=7xrPZGNqa8UNxg_wshVWxOCVmLAYrHEPXa7u7DNn6w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Oct 2023 21:34:14 +0200
Message-ID: <CACRpkdYbkqmFKe3Nt5yBt_1Jq2jpb67R=NQMZBgW=j3=USaMfw@mail.gmail.com>
Subject: Re: [RFC] IXP4XX MAINTAINERS entries
To:     Deepak Saxena <dsaxena@plexity.net>
Cc:     =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>,
        lkml <linux-kernel@vger.kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 7:52=E2=80=AFPM Deepak Saxena <dsaxena@plexity.net>=
 wrote:

> Whoa, I can't believe I'm still listed as the maintainer of anything!
>
> Acked-by: Deepak Saxena <dsaxena@plexity.net>

In a way it is nice to keep you around, but I remember you told
me that you got rid of all your IXP4xx reference designs :)

Next time in Portland!

Linus
