Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514F37BD421
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345385AbjJIHQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344984AbjJIHQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:16:01 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15DC94;
        Mon,  9 Oct 2023 00:15:59 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3af609c5736so2384585b6e.3;
        Mon, 09 Oct 2023 00:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696835759; x=1697440559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=981xbSeR8TpIYzWGYl0PB1lUEIKuWhMy2DNMbMSYphU=;
        b=JUV3qAv4HxWRShJZALWiXh2N9YAhMnt7x4uFYTYRjP5RdZzz7AjRtxYtVCNXNMi5/B
         TPq8Uw7SRBz5ZS0W9vhy2d7FfYeo1Kv2xX2E57XsIe9LoEFqRpYwdHxULcOTPu6W2CSR
         dQ/kqzdHPzFRYONBRT60SEty8JQEA1Rym6797Cl1D4CCS9yWlEjbKppdcLbOS3r/oZZf
         7+CAjO8j2p3mbKF9yGda97NzTO5u3/mH2i76bJ7ONNqNKmAOW9jq08Xppzx+ZmSnTDGZ
         l28Fiy4emfYo2fsi42Fl34WqJj/XGWUDGepCfCqG8jeIrWVujlKqo9Kd3dsXYnzNjUPs
         YWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696835759; x=1697440559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=981xbSeR8TpIYzWGYl0PB1lUEIKuWhMy2DNMbMSYphU=;
        b=h/2UZMewPsU08fY7p6+dpPlmXdYQlUHW5UgqxYKslpAuDzLj0gQX7uy1zmGLPjCP7F
         HplvovQ3miw0IXP4NNl9rSn5LXsT9n5j3xQHgwyEp28zdwrU8nCmkUrAFGqNfyphogJ+
         phfH2cRQ4lHVdLzcng9KrAE6WgQ1zmrNXoihemfF53DZvXWLTorl85Xngm0L1RbtIhCp
         67yLMW5h7KSgga3fAg3VaJRoIT5F6PKJYfYpmuhahKUHHy3l8pgghs1U0wfpdXhf8ai0
         btNURsBgSZ7//8a2JbiroUNhOYp5p7VVaMRDrpmQhqk0Irvfce+T/YdtPKhXb6T3Njhz
         cv3g==
X-Gm-Message-State: AOJu0Yza+vFeq6+/7DB7Ac0/yhomYPUgYwDyzP+ROWq6EZ8wwqtCEcs2
        2VauUkmN0ZzyBtHrBbkVr7E=
X-Google-Smtp-Source: AGHT+IFQQiXVS4QtEJTFMoOjdBDLxVAa0Dh8puoiqXJ+JyVL07j+ifb8NSMtZpJyEPNhZcmNBpCgpw==
X-Received: by 2002:a05:6808:1311:b0:3ae:84b6:1f6c with SMTP id y17-20020a056808131100b003ae84b61f6cmr17793738oiv.52.1696835759220;
        Mon, 09 Oct 2023 00:15:59 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id m29-20020a638c1d000000b0057406c4306fsm7468831pgd.12.2023.10.09.00.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 00:15:58 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5F9A38050991; Mon,  9 Oct 2023 14:15:55 +0700 (WIB)
Date:   Mon, 9 Oct 2023 14:15:54 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Bruce Perens <bruce@perens.com>,
        "chaosesqueteam@yahoo.com" <chaosesqueteam@yahoo.com>
Cc:     Linux Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: I can't get contributors for my C project. Can you help?
Message-ID: <ZSOoqgsDsOoPENN-@debian.me>
References: <875007189.3298572.1696619900247.ref@mail.yahoo.com>
 <875007189.3298572.1696619900247@mail.yahoo.com>
 <ZSEdS8a5imvsAE8F@debian.me>
 <457035954.3503192.1696688953071@mail.yahoo.com>
 <CAK2MWOsK=pTKADr1kUuj=fvmRB=X2Z0+SkWQ9PTSxCqOVCq39A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uUsmC1c0/dRqtCqI"
Content-Disposition: inline
In-Reply-To: <CAK2MWOsK=pTKADr1kUuj=fvmRB=X2Z0+SkWQ9PTSxCqOVCq39A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uUsmC1c0/dRqtCqI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 08, 2023 at 05:25:27PM -0700, Bruce Perens wrote:
> Mikey,
>=20
> This is *why* nobody wants to help you.
>=20

Ah! The original sender didn't do his own homework attempt then.

Thanks anyway.

--=20
An old man doll... just what I always wanted! - Clara

--uUsmC1c0/dRqtCqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZSOolwAKCRD2uYlJVVFO
oxRRAPwLtCpRPWlN683ACdJWpPvx31Wm93hjuUKec7ZoVo0dYwD/Ug9n8Vq76FcM
f5S9IgE7INpLZHKFmrNDP1WpHOPzDQk=
=r4Ju
-----END PGP SIGNATURE-----

--uUsmC1c0/dRqtCqI--
