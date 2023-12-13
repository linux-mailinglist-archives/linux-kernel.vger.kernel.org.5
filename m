Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76011810CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 10:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjLMJFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjLMJFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:05:24 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07033F3;
        Wed, 13 Dec 2023 01:05:30 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ca0715f0faso92367461fa.0;
        Wed, 13 Dec 2023 01:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702458329; x=1703063129; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uPVstSGHW2mJYYKDhOcbHVvFc6FCpsaEprPwYoO2QrU=;
        b=MGi+uK8fNUmM0nhxy/iOse+UgOChkXpP3nyVErQc/+LI5+qhOuntIIHrgrEzY7EjIh
         7RfkbwccMukM43/8rRjOIlmo8EPwzazbrK+ylS3Cwkjl8cva0qhM6JUgdUOtReByzEe1
         cAhIPHLJ9MUpFThviTFoAzJJ8MXVJ0uGkQQRNgAhItdfJJZTkikyhX+kJXJPeHol95SI
         /15h/nP244D+ak5DxfpZyJpTxrw+iwOUMMqY4m0HK4eqwQ0xLbwP7R2ztcxoujGiSPZh
         H25CHVogBLxLF7Ph76klLrOViQuC7J4bQfYd8szgeN7mfGELRR7i3FZGqm2fJdJ43Tvc
         BuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702458329; x=1703063129;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPVstSGHW2mJYYKDhOcbHVvFc6FCpsaEprPwYoO2QrU=;
        b=jNnCZTpJ5NStUFu+h/rdsydrP3b72bNeeWvnoL/HhTVIikNpe0m8VftCZUYXpaBlXf
         x3Y2oBGl6u8sdcoEuT38x/2I8dFAjBGuLepqzwABtDDpxoq+CnhoPJAI8r6EUnSSZ4tZ
         A8i7Xu0Fo0W9+2LyGELCobRQSA8xDRKUxayCAEWiNuFjF+fuIol9hEOrQegCzfarcaWA
         SJkwCDVTfXflg8PKm1Ps2u+5tBYndnu5dBUMDKmgLCKs+tHW9/g2gwcCBHdj3oJJVAPM
         YSb8hjPZZ5I6hjyLtExGQEhCrRexRRCG2xHz5CGEw4xLQaXCmCFdjwysMCOZwou10HwE
         bpkA==
X-Gm-Message-State: AOJu0YxrDsfm8vD+6M6ALUnQF2R7OmymhSatT+q8Lfqd1m9GmJEdsJwz
        IywiUnS0iIA0jAeWLjjnhR4=
X-Google-Smtp-Source: AGHT+IGWpeNIT+ctXpc3/nJZFateSOhCrGMOM+zwxTvVL6e43wnzc3r3OJ2tC/PYR81yyP2zfmy63A==
X-Received: by 2002:a05:6512:38cf:b0:50c:5aa:83b4 with SMTP id p15-20020a05651238cf00b0050c05aa83b4mr2890212lft.114.1702458328719;
        Wed, 13 Dec 2023 01:05:28 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id y18-20020a199152000000b0050be6326f2asm1597596lfj.64.2023.12.13.01.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 01:05:28 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:05:17 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Simon Ser <contact@emersion.fr>
Cc:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        christian.koenig@amd.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, John Stultz <jstultz@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Vijayanand Jitta <quic_vjitta@quicinc.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        jianjiao.zeng@mediatek.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        ckoenig.leichtzumerken@gmail.com, linaro-mm-sig@lists.linaro.org,
        linux-mediatek@lists.infradead.org,
        Joakim Bech <joakim.bech@linaro.org>, tjmercier@google.com,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        kuohong.wang@mediatek.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] dma-buf: heaps: Add secure heap
Message-ID: <20231213110517.6ce36aca@eldfell>
In-Reply-To: <DPBmATfmfvSP8Cwjz99kj_JvCEiAqRfuMFJZEBF2aIgl8NZqWFR66eyPTX1E8bHyOlimBihEE3E80p9bfOJ-0SNu8pwoIzL9gD2Xae6r97g=@emersion.fr>
References: <20231212024607.3681-1-yong.wu@mediatek.com>
        <DPBmATfmfvSP8Cwjz99kj_JvCEiAqRfuMFJZEBF2aIgl8NZqWFR66eyPTX1E8bHyOlimBihEE3E80p9bfOJ-0SNu8pwoIzL9gD2Xae6r97g=@emersion.fr>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DaWmOigQ7D9ggi2.WnkRpp3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DaWmOigQ7D9ggi2.WnkRpp3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Dec 2023 16:36:35 +0000
Simon Ser <contact@emersion.fr> wrote:

> Is there a chance to pick a better name than "secure" here?
>=20
> "Secure" is super overloaded, it's not clear at all what it means from
> just the name. Something like "restricted" would be an improvement.
>=20

My thoughts exactly. Every time I see "secure" used for something that
either gives you garbage, refuses to work, or crashes your whole machine
*intentionally* when you try to do normal usual things to it in
userspace (like use it for GL texturing, or try to use KMS writeback), I
get an unscratchable itch.

There is nothing "secure" from security perspective there for end users
and developers. It's just inaccessible buffers.

I've been biting my lip until now, thinking it's too late.


Thanks,
pq

--Sig_/DaWmOigQ7D9ggi2.WnkRpp3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmV5c80ACgkQI1/ltBGq
qqdqdg/8DMTwQfWf/EfE0E0FOjM0IPMnzZreMPcRlHBqMJqgQA5miVL9CVE+novh
ohRbfFYLwut7eqtK6Dzn+6hOIVFRMpGPkWe8qHfT+CJ8Wr3hD8Q23PKEveH/FENO
G+XUbPzsnlDTDs5MB2Bb1TAiWQLS8Y1/nstMZ49l8mmW6Iim0Z+/xhyqUyLaHfpm
zB7JRM7CSN8gyPhoqoAAITy+ZL4+yD7D28izgQA4YZD4JzkE1fYOUFzNb4QRA/T7
GxPSExZlU7+CdIL5zAJvhqpHh9nxMdOUvaP3aQBzShcTKDVoet/TZ+0QuEOuD1QJ
gHG05Hcp5gREsbjn9oytS2km0LcL7ZmR98NOrf9idl4jZDjVTEMQvV/FrSSwiyGv
5whtFHkkDVy1nXjyYmgiGO7dvIptO+dNGgRtACt3xe0tdvu5ndP2+hG21ADVWebc
fd2T4mnUoANro1gOjWATV5+0fzlOK5hFff70pvE9U2ATvqXo7i2I+kzW/EJFPilA
4EqR7cIyLCaVRb7q/dC4CdWUu0NIxCp7+u22Z/B8pHFw2MnQZa0twIKV3GJokfrR
A4PfZLAvpbSkfr7SalrN6eYFHhJOpcCJPHXCiQSnRT7DU5u6NhUr35IZgq/YuANC
YrU/v7fiWv2v6I0I2FN8fBaH1baL6/SWpA5q43OECPVewbA/Uwg=
=DQfN
-----END PGP SIGNATURE-----

--Sig_/DaWmOigQ7D9ggi2.WnkRpp3--
