Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32DF78748D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbjHXPsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242317AbjHXPsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:48:07 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E52198D;
        Thu, 24 Aug 2023 08:48:06 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4ff88239785so10702912e87.0;
        Thu, 24 Aug 2023 08:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692892084; x=1693496884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+1fMi2e4G9gTfcYnlr83FuXHyFkwE440pHt3C7CjJrg=;
        b=AtRMEjqP0oOimPYD3Cu3GWo3Gi5lcZXeYIG2Ib+/MirND8WZgzkFDVhTeAzPKnKhsM
         Xvdqg3JX+Xdx4ROg6Of0cK7CPb3CcPy7p0PrSeeMHuoMK0L1VKcAsnSwxXjAEl0xjB2O
         VSsOE3rWQvH5MJiFor4mq+HtrRm0gnNIwiLixW2JNjcFzQlaCi63qtu5LERQxXMEaBHb
         OAwMBEP2xnwbsxUvCyfON6v9ut/+LjkqfeHOw48szAUmpIzf3NPtVtSU9bEpxGwRNBy5
         m+J8Z88uue+h0sa9x6F6kfenCG88ShL1VcKHG4CD9r15Y1I2+HpxQj7rG9jQcT4eXbyr
         jjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692892084; x=1693496884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1fMi2e4G9gTfcYnlr83FuXHyFkwE440pHt3C7CjJrg=;
        b=cgIws7sBVKhOcEX5RNgMpAueTIETW+lWhZ7D/smxeRFA5Ynf9YXx1Y+kvg5QUR9+AC
         y18nwfU6z0uJyvMdc9Ku/NnV5eabMG8gFZkwENtxljNd0zLhloY4pwi2NceofQaNYD28
         ueKctRv6bQjfnT0E8qSf9qGmqe92zQlFxOgAHJrqr8LCSSiu0wzrMDtlXC8zQSfx6TcZ
         /DoBgs5FV1RBN/avM+rMGsUixgOP/uY8Hlg/aGgY4eaCFqvAQAaUQOrfGcPYTDfNtNcP
         rlHBJnm5+GonuZ/TD8bE3dBStIbJzrj0p7IgIi390PpQeQIhnb3rre6Kre+1opS7NfS8
         L87Q==
X-Gm-Message-State: AOJu0YyzlIVkxGMykc7RrIHbjxXYKuWaJvmR4Xy2n+8J5LTVaaH2LwYn
        QomI/QZ8NV/arh2yEv/9eKk=
X-Google-Smtp-Source: AGHT+IHnjayWdKFs8JaMC8+yrrpioUy10Jdu1+V9ar/iwgMkiAQsXHTlvjsVRaIaA+QxzNCdQNvHqQ==
X-Received: by 2002:a05:6512:3241:b0:4fe:25bc:71f5 with SMTP id c1-20020a056512324100b004fe25bc71f5mr9751746lfr.11.1692892084032;
        Thu, 24 Aug 2023 08:48:04 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id j30-20020ac2551e000000b004fe1900e934sm3238449lfk.147.2023.08.24.08.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 08:48:02 -0700 (PDT)
Date:   Thu, 24 Aug 2023 17:50:33 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: docs: pxrc: remove reference to phoenix-sim
Message-ID: <ZOd8Sb6CAiDOyjq1@gmail.com>
References: <20230824-pxrc-doc-v1-1-038b75a2ef05@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BMz4C62m2NawlKXS"
Content-Disposition: inline
In-Reply-To: <20230824-pxrc-doc-v1-1-038b75a2ef05@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BMz4C62m2NawlKXS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 03:55:50PM +0200, Marcus Folkesson wrote:
> The reference undeniably points to something unrelated nowadays.
> Remove it.
>=20

Sorry, I forgot:

Suggested-by: Mark Olsson <mark@markolsson.se>

> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---

--BMz4C62m2NawlKXS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmTnfEQACgkQiIBOb1ld
UjJm2A/9GZ6E43rlokhTt4IorvtNkkRA0YN5pFCGBJV3tfmz9Z7xrD3AR+G4tZBN
ThrKlu9S4LfhQLzS+3ApBiiLMfU85ovdSL76oql7P/N9q1+8hFjw7PLD/j0eR9ts
eHB67G1edvWGZXScXxD0lYT/HabzLMQc0AY5hLp1OCwWIJywA5cqEhDUXtXPXBzI
Gkth0B1T+aXncJnXebV4GuohHWcJFM8119nv9UeShw0G6rLozL4oPMuINdjlPimi
kHARgmFSbcQW4JzZfcjMFrxD4Ogf9PE21yotoUGjNAxymtecnlihgLhdfCfI4ilB
7Oj3XDif9LsP98mnQfYZRGu+cAg8YfsBby09ANL2MeTnZLiehzGFFjaBxEX1sqCF
IZVT6dKA+F6Eq2FSf7G/44B8vRj35iEZD+7/ffYIHOjbN0cGWjZfEntIEmm/5/pQ
yyxNnbNvY08f2FbMUL2YpTS+xqxefpVnXqXVtfxyhxBHpsZkAJtBTWh+r0sgLLxu
hXrAV8askCKZBd1+XkZq4AJ3Ju8S3yp2JpLIMxG5CF43Ca08Z6sK9qNbFi1VKVtb
cjr2wM7l6ZZ753utz3+gNy6dq5ubMhQCk3Lmwg606Q8kJUA+lz31Cyp9yT/jW6fu
+k/Vh6iahutlhoSugPWY2HDIcnSbstotxiL1FdBcIe26gxDq06w=
=9UIU
-----END PGP SIGNATURE-----

--BMz4C62m2NawlKXS--
