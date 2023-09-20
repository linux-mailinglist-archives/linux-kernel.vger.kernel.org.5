Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D307A74A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbjITHqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbjITHqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:46:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ECF10CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 00:45:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304ADC433C8;
        Wed, 20 Sep 2023 07:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695195928;
        bh=Cqn1BSH5uJ9UFmfiz+lI3Z6Y8WlRKov8M6GvwnSusx8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZH5TvVq4GRWBYtF8gqzpoEdrkMp88bh0+loNhly1YEpHTYnIc2tISMjgtjYjhWZDK
         gmC4cFCro2rfi4LorOE7NEPba7vqn/T98CKUjjDFEweCspCw4fygzpvH8DzUPA1cpn
         YOIUI6ddd4yWoIrp+vtb7pgBI9KUqxh7mBd+Pohn7Fz82AlG3mr50qg5YH/q0KCGg5
         LBFdo+bd6S9ETqCMMpb2Z0NBFR8/N6TazJyO2F8udi20Ugkl87f57majNZCyN248WE
         go5vlCA09Iz4rcoOU1Nn5yqVVOu4jmtcBiCHN6aFoL3I7QNcFBCIM37tYK+IOULUYW
         Fvms0uJpXz4UA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2c02e232c48so22567881fa.1;
        Wed, 20 Sep 2023 00:45:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YzC/QzaKuuwNiupSNK3XIllXtfuJZkszNO6Bz1R5vt4JJ3/TW5s
        fukx6m55kgkfnXl5BkyXy2ksZW+ckEVWhlU71WY=
X-Google-Smtp-Source: AGHT+IG6JH2f6GWH6UGZkLRmIfvUibe13MybdU9vWJevg2yLIo+A04ZzyShmljbSBOMPLRaIuGsPu24IY0wrnqr/JEs=
X-Received: by 2002:a05:651c:102c:b0:2bb:9847:d96e with SMTP id
 w12-20020a05651c102c00b002bb9847d96emr1350699ljm.9.1695195926393; Wed, 20 Sep
 2023 00:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1695189879.git.wangchen20@iscas.ac.cn> <11eca9395bf730f41f142be2f8d26f527e36517b.1695189879.git.wangchen20@iscas.ac.cn>
In-Reply-To: <11eca9395bf730f41f142be2f8d26f527e36517b.1695189879.git.wangchen20@iscas.ac.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 20 Sep 2023 15:45:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQaXqWObZ+TQ=49WodHr0R9qEuuW_r5Tt65OTVDTdipZw@mail.gmail.com>
Message-ID: <CAJF2gTQaXqWObZ+TQ=49WodHr0R9qEuuW_r5Tt65OTVDTdipZw@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] dt-bindings: interrupt-controller: Add SOPHGO's
 SG2042 PLIC
To:     Chen Wang <unicornxw@gmail.com>
Cc:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 2:39=E2=80=AFPM Chen Wang <unicornxw@gmail.com> wro=
te:
>
> Add compatible string for SOPHGO SG2042 plic.
>
> Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifiv=
e,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
sifive,plic-1.0.0.yaml
> index dc1f28e55266..16f9c4760c0f 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-=
1.0.0.yaml
> @@ -65,6 +65,7 @@ properties:
>        - items:
>            - enum:
>                - allwinner,sun20i-d1-plic
> +              - sophgo,sg2042-plic
>                - thead,th1520-plic
>            - const: thead,c900-plic
>        - items:
> --
> 2.25.1
>
Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
