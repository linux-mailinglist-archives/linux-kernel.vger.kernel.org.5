Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3277E7CFFC1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344979AbjJSQjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjJSQjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:39:39 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B157124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:39:36 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c50906f941so98798101fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697733574; x=1698338374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4YhLduK0yhp1pFpU5JcX7yKUnA0pQoHHCTqO4z0oJ4w=;
        b=AEG9vFVDqfsctBkFVwMTY5fzqj6ij08+gx4M03d5fd2pA0o3UziknZA+9xPvkNVKIa
         ewdEuo0sto3CKkXgh3nAU7EOgYsGFEdvlBkeh7HNG6cuvn7BtmrlUbnrZxBka0gLIBsQ
         JAJr/seRTE97DJBZYfICBcwpytrOCrujaR46ClP6C02839A8pB9g5yzB+1+SI3SlGb6e
         rSl3Bp1v4N3SmdZ8tA9Om7UInV0CC/2wJh7z3fFdFXXseTI3D0IgQKq/pvuQp97nmSmg
         RlJn2g5gQVh2ZkoRJO3tTpIKnFyVbO0NKvONJrLIffMql5AhVozF+PGti9W4p6IcQLpM
         2qMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697733574; x=1698338374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YhLduK0yhp1pFpU5JcX7yKUnA0pQoHHCTqO4z0oJ4w=;
        b=oFI+Hf8PvRa8Pn2Ort2A8jWjGed4WJ7Cm60BxBKHtMPSTbaFWrSChiIi7ZZheXBdfY
         FsFVrRtZI0t0oQG3HZzFHU7xr43MxerzwcjFIfxGSTnfKKqyfmpA1jzQ6cHAibFnW8v6
         hAYCOZ00KCKBtxAA2dPD1TfVKtImghoB1qfwCm5mwvShH9ixOuXptjuP1Xu0cJOGladz
         4erycaMbdQUA5TphoUGWVdMqpYjlu6oWuiWGsEJXYHayvba1CUxEyPmFlDfHX1sqjMXD
         XffYoQhYon3g2qA/aQTcQ+A20WD5UJYv58C0hQmTM6xi64ByAMZf37pLWJb6k50wM+JI
         MPww==
X-Gm-Message-State: AOJu0Yw0fAPN0o0cR/E23ruObQ+svEtHDMulX3gI/KpsdWhSNvwSq3Jn
        J0HekdBOs7t80l9bNq8jG84=
X-Google-Smtp-Source: AGHT+IFhX1ejSOP4RoHUmqnCAncA2fYu2iqR48uuBkVtYK2asxYzCcdlV7qull1tJSbkzyYsQ0uSzQ==
X-Received: by 2002:a2e:a98a:0:b0:2c5:40a:5d92 with SMTP id x10-20020a2ea98a000000b002c5040a5d92mr1968156ljq.28.1697733574039;
        Thu, 19 Oct 2023 09:39:34 -0700 (PDT)
Received: from localhost ([2001:171b:c9bb:4130:c056:27ff:fec4:81cb])
        by smtp.gmail.com with ESMTPSA id i18-20020a05600c481200b00407b93d8085sm4753875wmo.27.2023.10.19.09.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 09:39:33 -0700 (PDT)
Received: from localhost (localhost [local])
        by localhost (OpenSMTPD) with ESMTPA id 998b6a53;
        Thu, 19 Oct 2023 16:39:32 +0000 (UTC)
Date:   Thu, 19 Oct 2023 18:39:32 +0200
From:   David =?utf-8?B?TGF6xINy?= <dlazar@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>, kys@microsoft.com,
        hpa@linux.intel.com, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: PIC probing code from e179f6914152 failing
Message-ID: <ZTFbxAS3mKPkEzHP@localhost>
References: <c8d43894-7e66-4a01-88fc-10708dc53b6b@amd.com>
 <878r7z4kb4.ffs@tglx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MCdo3BrMYb1JOR2q"
Content-Disposition: inline
In-Reply-To: <878r7z4kb4.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MCdo3BrMYb1JOR2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--- On Thu, 19 Oct 2023, Thomas Gleixner wrote:
> Can I please get the following information from an affected machine:
>=20
>   1) dmesg with 'apic=3Dverbose' on the command line
>   2) /proc/interrupts
>   3) /sys/kernel/debug/irq/irqs/{0..15}
>=20
>   #3 requires CONFIG_GENERIC_IRQ_DEBUGFS to be set.
>=20
> Two versions of that please:
>=20
>   1) Unpatched kernel
>   2) Patched kernel

Since they're a lot of files, I've uploaded them in a .tar.gz[0]
attached to the bug[1].

[0] https://bugzilla.kernel.org/attachment.cgi?id=3D305266&action=3Dedit
[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D218003

Hope this helps.

Cheers,
-=3D[david]=3D-

--MCdo3BrMYb1JOR2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEpHbgpJsdP0daUC+MREXGZf+tmuAFAmUxW7wACgkQREXGZf+t
muAWYBAAnaDCjG7X9xZAdJyo9FjWdrxMlpU7WhpfuIzo+ou4svjdYjoi7H0UO6pb
UA/L5MHHs/iQ6UI8SK+U8HU0PE1wB+NslKRbNeX6636t0i67vi88B6+/++9ctb8q
5Hd0Y3mhy4gRpjfTiQ+dGNkba+B/HCGKj2sA1Qm4+Okx8v/mVIDlheAPf3w5OpDA
RZQd9e91+ZRA55jKMjChJPPjoI4R1us16UI+fPGcawC8dsYa2bWPx1tWQCY22Lcz
iC0AdmjHxfZI8YgFX+u6JF/AK9riwKjkvkb62NvbQWLUOtk2HS4ETqvfghczhb6h
fPqDSvagSKgIRBgh37pFQtvR1NTL9S0lhz5x/verpuWD4EplfQDxX/2QB9aH+Si1
6VL+KWi9/gtTb88vp7yVSKovOby5MFFooKJVtEAeGgP3cGnPsGGfmFxd8BSAwdx4
qWaMOSW35yQ8aCzFiUreMKy3giAbo8ZIH0lohiIfCkZKMH1Li692L8fmgSt4ry7X
gIsDbm5TA5Z4An35tIpGa3RrQmzs1don2Maf0WdEE+pxEayYak9HWwIAau3hvfzW
z8eYMRMz5HThG6XG5vJiO6YJa/9sHZkTStt8H9ADlOfizEAMADpJepPEPGINweze
7DExbci9m/jA/r09BRooq99eWBdfB5O/NlvKkhOhaFpUrGxNBO0=
=Jh0K
-----END PGP SIGNATURE-----

--MCdo3BrMYb1JOR2q--
