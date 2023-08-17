Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA077F56B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350369AbjHQLjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350406AbjHQLi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:38:59 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A0C30D5;
        Thu, 17 Aug 2023 04:38:43 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so966416a12.0;
        Thu, 17 Aug 2023 04:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692272322; x=1692877122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKUcXNoV+psmlkhL6B5yGLe16dQ4YiFg1gnD+sJ/ZDY=;
        b=RPfCfWwCPmIY84qVYwJ5DkDYlKEzDkNqbRcdMINgJn1pUgdVe5Cn//4tiFNwzep4ys
         9rAlS+mvyHIfPXyvZwKj0cKFqnz9eGPs+GJWtU5/iWE4umyNlOSlbEdANGGQqQO1jBdN
         Pekx8MsumJOMR7VoI9Dyj3yJtEXRlpE6uZRNF3ym2pJ0hEOskroLMOp+WS6IJV/Mb5Wh
         FlfkyA19w7UCnPSjuPSx37fyn96IZvm/2qSQVSsvJbkFIguRB6Qfsnwy5CcbT8SYlvFW
         1crIJ8c+ISPS4kGldBnHEWOl+E4aSYzqTlRFGLckyWn6vwXTNRnIuiofoIrB50ZYfszC
         n1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692272322; x=1692877122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKUcXNoV+psmlkhL6B5yGLe16dQ4YiFg1gnD+sJ/ZDY=;
        b=YH6IIp2rbkeFcfSe9Uoa/aFNp1Dp7dAQMHFYmfa6SUEcF4vEOaoJhczZAHbQiPR7cr
         e9va3OkqnvTAce9lolvf4h6hwHfu+r9HEMMV2I7/AeTyw73RusXCjeGu39e5dZ72Afp9
         Gfn9XrfXKRUIztu9xTi1BAvDyu7NiAZ+2F0RwQEVFU9to6gnmiHNKuVtkSC0jaEfi70v
         QGEhJxZQGObD6tZz/tyDzP9Eqf+CjwFCoT7SDShn0oBHWHAIAFbmnGdBJ1o/x6AGbd60
         g0Y21wVgP9Xp/Ssa85SlM2c5GfnhQ4GD7re/RfXYFSH0quynF/R7AlOfCx1fEdtHBNtH
         ncsQ==
X-Gm-Message-State: AOJu0Yx5ubNaG5CSTdUP8n0LAZxTe25T4fCh/NxbEq+eQzMqUVdFuvvL
        ErWUYCoG6DjFeRIKLY+AqqPwf89UzWJys3btsGg=
X-Google-Smtp-Source: AGHT+IEbMqQhv2q+86S8lMWLcYZBaBBDZh+MyntudnJwphyIoq3nhvHypIxWCWP4njxFM3CmSKz09BPRNLmWrqmehec=
X-Received: by 2002:a17:90a:17c1:b0:269:5bf7:d79c with SMTP id
 q59-20020a17090a17c100b002695bf7d79cmr3908538pja.1.1692272322408; Thu, 17 Aug
 2023 04:38:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230815231117.15169-1-aford173@gmail.com> <CAOMZO5Cw5bFD3U6KXkuobUCmZbjYsL_=gZobeKFXGQo55aA+Vg@mail.gmail.com>
 <CAHCN7xL2BA0+Z5GhrvuS0j+s6WOLVScaC9DQ1+AxHYjY6DwAAA@mail.gmail.com>
In-Reply-To: <CAHCN7xL2BA0+Z5GhrvuS0j+s6WOLVScaC9DQ1+AxHYjY6DwAAA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 17 Aug 2023 08:38:29 -0300
Message-ID: <CAOMZO5AxmSEF2=G_jNnFkvA4SbAr28W78UtpaOmWQ-fn86P9Fw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] arm64: dts: imx8mp: Fix SDMA2/3 clocks
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Lucas Stach <l.stach@pengutronix.de>,
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Wed, Aug 16, 2023 at 12:34=E2=80=AFAM Adam Ford <aford173@gmail.com> wro=
te:

> I tried to do that with the fixes tag below.  Do you want me to
> re-submit the patches with this changed?  I was hoping to avoid
> referencing the same patch and hash twice in the same commit message.

IMHO there is no problem at all by referencing the same commit hash twice.

In fact, it makes it clearer as to what exactly you are referencing.

Please re-submit it, thanks.
