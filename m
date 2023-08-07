Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADAF771781
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 02:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjHGAgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 20:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjHGAgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 20:36:12 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA6F101
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 17:36:11 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686b879f605so2632415b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 17:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691368570; x=1691973370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HJaYuD0/DwZjvYuP3suP4sHB39g0WGFkx7q7Sdv5RQQ=;
        b=EnQzFWwX9nM6C3d5iwgIneyMG/4yxkanOp5peQkRR+ZX8bDha5YaI8ZutNOxwjyrNR
         OZtLJTVS5vfbR+ZJz/XTHaApcQ+irK7cxMr0BEPSwiJnWG3LSZ5QKrbx2I0/RFUXpHLk
         4t+NubGEOaYG83+APkBV4+AvZpRTa8nwOy9xEyE5JBUrJLAAXmj5NIkXy3ZrnxCtna6a
         3k71RSW6bT5vUkDwGjN5ZsBPrZNL0Uw0XNM7Ae/Sa3QuYhjmhmrIohvUnhM1ONS9HTm3
         YZ5b+eTHfbwYcnj56O+h86Jd2WEgkWA7n/tMeUWBMY2Mkv7KEXx8giNbdKKvEsBLGrLo
         ZHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691368570; x=1691973370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJaYuD0/DwZjvYuP3suP4sHB39g0WGFkx7q7Sdv5RQQ=;
        b=OJNYIX0S0vuHqbhNRapZgQaDUXZTSsO3k0M7d0hZp29GVsU2ZMUrf18KSv6ioq5mEr
         vMMdbX9DWFLlEXoxxAKixGN3klpNR+ylxOlblXVjMfEzLVkrjAR9eI6uVRqoTLzM0NaU
         Ip48iiLXowipCVH1wX4dDkgEFlVJuZi3rJkZXGiZBa4V7BhyjlMB35N4b7xnqEFbdD2/
         91PTpDzmT3gcFJJmU9Gi7tLmnUW6UXQHMP8rb8nfMljyBL1KDr3WMp0pvkPHrxPYXH3A
         Drp5Kpabxe7GfT1262iOC3DluserlKf/oMX4L+AvOaS/M66rlT0CE0ON2eh9/69iEAmy
         +nYg==
X-Gm-Message-State: AOJu0YyBwKuKjW+UwrOISoFWsSHMHGAvReFh9+h2rlntqwvuWWBeXFyc
        kw3vbI6UpNYYDL05TJJLm9YD3WrM2u8=
X-Google-Smtp-Source: AGHT+IHagfq5vsNZXxqrY4jF86em4T+b14dTXq6wlETvHRnwmzcH31qVuGscwWIxfd0bCJVXfKLw1Q==
X-Received: by 2002:a05:6a21:6d93:b0:13f:13cb:bc51 with SMTP id wl19-20020a056a216d9300b0013f13cbbc51mr8476682pzb.25.1691368570309;
        Sun, 06 Aug 2023 17:36:10 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id iz2-20020a170902ef8200b001bbb22652a4sm5413429plb.226.2023.08.06.17.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 17:36:09 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 20A8E81C1EBE; Mon,  7 Aug 2023 07:36:03 +0700 (WIB)
Date:   Mon, 7 Aug 2023 07:36:03 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "zhangyongle001@208suo.com" <zhangyongle001@208suo.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] floppy: ERROR: that open brace { should be on the
 previous line
Message-ID: <ZNA8c4HlbbJ4XE30@debian.me>
References: <058c3448e220ee16bcb5e588271b685c@208suo.com>
 <72a156e7-d15d-629e-9166-461622ad0f21@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SErABh50vbaitwzM"
Content-Disposition: inline
In-Reply-To: <72a156e7-d15d-629e-9166-461622ad0f21@csgroup.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SErABh50vbaitwzM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2023 at 04:05:09PM +0000, Christophe Leroy wrote:
> Hello,
>=20
> Le 20/07/2023 =C3=A0 12:17, zhangyongle001@208suo.com a =C3=A9crit=C2=A0:
> > [Vous ne recevez pas souvent de courriers de zhangyongle001@208suo.com.=
=20
> > D?couvrez pourquoi ceci est important ?=20
> > https://aka.ms/LearnAboutSenderIdentification ]
> >=20
> > Fix twoce occurrences of the checkpatch.pl error:
> > ERROR: that open brace { should be on the previous line
>=20
>=20
> Can you please explain the purpose of those changes ? Do you use some=20
> tools that get disturbed by such cosmetic errors ? Otherwise what is=20
> your reason ?

Hi,

208suo.com people do checkpatch fixes (that is, they run
scripts/checkpatch.pl -f <random source file> then try to make the script
happy). Steven warned them to not submitting such patches again [1] but
they keep spamming maintainers with checkpatch patches (ignoring the review
warning). I voiced this concern when reviewing one of their patches and
Jani replied that such one-way interaction with kernel communty is
detrimental [2].

The exact same situation happened last year involving developers from
cdjrlc.com domain. They also did trivial patches, including mostly
(and notoriously known for) redundant word stripping. While some of these
patches were accepted, others were not with reviews requesting changes in
v2, yet they also ignored reviews. In fact, in the early waves of 208suo.com
patches, they used the same email infra as 208suo.com people and they sent
patches as HTML emails (which were rejected by mailing lists obviously)
so that the latter people have to send their patches on their behalf
(but corrupted since 208suo.com people used Roundcube instead of
git-send-email(1)).

Regarding 208suo.com's mail infra, after I pointed out this [3], they
changed the infra so that patches sent didn't get corrupted. Thus, they did
listen in regard of tooling and infra changes, but they deliberately
doesn't answer code reviews.

Thanks.

[1]: https://lore.kernel.org/lkml/20230720134501.01f9f1de@gandalf.local.hom=
e/
[2]: https://lore.kernel.org/lkml/87cz07vvwu.fsf@intel.com/
[3]: https://lore.kernel.org/lkml/ZJK7sC4i+MK98k%2F+@debian.me/

>=20
> We don't accept such standelone minor cosmetic changes at the first=20
> place because it looks like a waste of time.

PS: And in fact, complicating stable backports...

--=20
An old man doll... just what I always wanted! - Clara

--SErABh50vbaitwzM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZNA8aQAKCRD2uYlJVVFO
o1acAQDW60nBwSLxR3hsP5HX++ukVRwWzC4LuylPdMo2w/GNcAEA9uw09JR+PKcp
Jg6+XPElt+x2FfUaAd0pHuRAiVBaKgc=
=J/zU
-----END PGP SIGNATURE-----

--SErABh50vbaitwzM--
