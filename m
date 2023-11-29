Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0865F7FD3C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbjK2KNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjK2KNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:13:14 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6961BCF;
        Wed, 29 Nov 2023 02:13:19 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bc8a9503fso74775e87.3;
        Wed, 29 Nov 2023 02:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701252797; x=1701857597; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCZTkTf5gNqH/rsoLk7etD6DwWJwR710k5LJwshNSuI=;
        b=GKlf5lT5LfTn+FOIKdk4+B/fsnJPS5/dZaR06MKOv57OcUU11MD9L/FVkI2tSsJpOW
         17Z34nxsL7V7w49178dmUlbgWCtUIxQCGTGXGFZNSM8tmet1Xm3nvJYTJ4pB3I8ncCXx
         JFljOhwkeriSwVBgPGEVCLGyC1i4o54dArHOPssOmTq3Y1+cV7nbMQWwSGuLmk7EvZ6h
         4w0EVo5MZfE/zt3qU1C+rkGy8ogu4pxx6ye/1W6X9yK+aHHxyBx+MT9iYboTuTk0hw5T
         WzGoz5hvq5ofm1F/d1WNBbb5FCZ9+tYMiBUDEYEDI8voEHzd0pEeGszidbRcc2/OUhQW
         yzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701252797; x=1701857597;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCZTkTf5gNqH/rsoLk7etD6DwWJwR710k5LJwshNSuI=;
        b=p9dtK1arQeX5CrM7b1F+lJ6jg30D+7RIfUaxkyHKSB/KMUZINPwCpbB4SGq16UiOZZ
         wJoTrjdPFyV2c4jMZ+Mgtht009NSDV70R4Trv+HdjdGdHA+ylpt82hggsuPOpGToHzsa
         rnS7AFQUb5WljNSRXih7Tp0lyTWC8bdTs7+U8NuNU8RMyt5xyE06H/LQpwhBSFMxfYFv
         Ptnqqmw0jUHx1Xp48XR5PpQYb0GoH5jzJqqUgiom0mQY4OjZXkESYfW8AF27mHX+qV7m
         lH/NWi5HidUjCyvhThE3PenXOkSGH6gUG6f20rwTW+7blDwk3/OgDZa2NPq62SwSNUHF
         3Ghw==
X-Gm-Message-State: AOJu0YxjUosEhzCYnYuRberXMNI0QsimDNpOeSnGBmtzRAKC/sqdRwOD
        AuA+QFN2nHG/v6T5pQ08yFg=
X-Google-Smtp-Source: AGHT+IEqoByK4nUUfepBkFUQYGj/+qIG7mkFMGeDo/wE/qhqodU6sLdPk1cmUua5FNVdwpoUj02mkQ==
X-Received: by 2002:a19:f60e:0:b0:507:cfbc:bf8d with SMTP id x14-20020a19f60e000000b00507cfbcbf8dmr11730596lfe.16.1701252797196;
        Wed, 29 Nov 2023 02:13:17 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id q9-20020a0565123a8900b0050abbda2c52sm2140292lfu.157.2023.11.29.02.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 02:13:16 -0800 (PST)
Date:   Wed, 29 Nov 2023 12:12:59 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>,
        Sandy Huang <hjc@rock-chips.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-doc@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 05/45] drm/connector: Check drm_connector_init
 pointers arguments
Message-ID: <20231129121259.47746996@eldfell>
In-Reply-To: <ZWXv1Oi_sH0BRWao@intel.com>
References: <20231128-kms-hdmi-connector-state-v4-0-c7602158306e@kernel.org>
        <20231128-kms-hdmi-connector-state-v4-5-c7602158306e@kernel.org>
        <87h6l66nth.fsf@intel.com>
        <v3hplco5fdedv6bnc6mwx2zhhw4xxdiekha26ykhc5cmy7ol77@2irk3w4hmabw>
        <ZWXv1Oi_sH0BRWao@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qS7Sjt2IF0HAAZwDWVWm5Tz";
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

--Sig_/qS7Sjt2IF0HAAZwDWVWm5Tz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Nov 2023 15:49:08 +0200
Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com> wrote:

> Should we perhaps start to use the (arguably hideous)
>  - void f(struct foo *bar)
>  + void f(struct foo bar[static 1])
> syntax to tell the compiler we don't accept NULL pointers?
>=20
> Hmm. Apparently that has the same problem as using any
> other kind of array syntax in the prototype. That is,
> the compiler demands to know the definition of 'struct foo'
> even though we're passing in effectively a pointer. Sigh.


__attribute__((nonnull)) ?


Thanks,
pq

--Sig_/qS7Sjt2IF0HAAZwDWVWm5Tz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmVnDqsACgkQI1/ltBGq
qqde7A/+LfG5e8v6ABH2JqANkfijej4EDU9sSC3ZWBaUspi3UJEY1U0ZrDHgQd27
lLSoxs0tguK5Dtehhk/Mn4S1XmyDtRrKNB/2L/rNqilREqQa5ciQG9OFjpqnepS2
3kONuuooZchgnujkUjmgCg+L1X05peA166I3R9MkD4N3eqBH++XmohBaeUJDpUnN
n1OATmnWyX2df7p/qBpOhVaNT+zu8HCgsIZq//PDNTxQxmHP5CPqbxbxuBjcwFHt
bX1coZ602jx16CsrwaVYgVsHehXW0ru901OSPJ4flgpx/EyAjA4hHuVg+lJIZKqs
wQRR4p/QdyBRULqGl/+4VML92ccuHFCedEtbLyH+RXSTlM547Q9nwtUPw1lB7tYQ
Zx0BchNXyqKGnYvQUx5rTpJlTjwwq/IqkGkXnzpc3tIuj7hNTXEE1+3voPqNlnlU
J16Lt49s2r4J2ufAykGzgqC19HM5baSykl006GFCpzLrH6iETMejOymRxAFlnE8m
NdVHVD2YMPW9c21sJ+UjfbGrvF3H6E6MYZLDQLRnL44aHuYkCK6uSBfpgF1ugEqP
Tzqd5wGEhEeH6OmzYEiwWHBkNJdiGnA4yo1dzpLdgdGaEKHRfdcGePGcNlLdtNcI
AQZwl9NR+mk0zozfoa9HsXTUv+Su0TXpgD/prZ7PyqzSeM/SmkE=
=Sfat
-----END PGP SIGNATURE-----

--Sig_/qS7Sjt2IF0HAAZwDWVWm5Tz--
