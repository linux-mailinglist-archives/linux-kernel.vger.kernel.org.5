Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8617DFD34
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 00:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjKBXL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 19:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjKBXLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 19:11:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450E7181
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 16:11:52 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc5b7057d5so13180145ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 16:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698966712; x=1699571512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YR7cWpbPv3YkHu6Lgq/Qssety+VQHUk9DYioZqwXCUs=;
        b=huN5UaF7dohomfQPL9gQ/UKrTvJM7hQJXMo4hmOmu+W1/vmvxk+DnW701PXEc7q1CE
         WGY07b/M5/SkbnkB771nXjB8QOJUDS20Z86vaqnuDKSMAodza1q2F6+APYptINajofnh
         WuAbVP18GG5LL1t26SXPpY4l5rlKxOhNaB9FcPctZcpZRSYFxfq6Pj3mzyTSP98aPfRE
         tBXfoAfT6LEWfQnozdg7oMSZI/j0sfj6LvEm717t9Kdefs6PhBDiaPWhDuswCSTrkF9u
         LDiJ0HWmOBenyLEgCN4J4OXq/0Djq+0ytFIt/e9B6qliW9BFRS94jCkYkNLIsx2lkrJX
         ZjgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698966712; x=1699571512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YR7cWpbPv3YkHu6Lgq/Qssety+VQHUk9DYioZqwXCUs=;
        b=mvgqQAJGIwtOhT/8aQoQ+SUZ8XhWS8U9Okk7eDHLEJFzxhVkQIm7hLdCVJCQUlXD68
         /ZKutWWmxvh9ZqWolIYnk71hg0+rLIUrzx9Idpkt5X+ENHpjYOBhwCi23LboG2My5+GZ
         VN6hgv8a7UolIR49kEKiTZfpPCh+w2cbKQPrRwxL6flgSJgRgG3epYMkW7Ia6G1oXHYK
         oYq8qLWpYb6dGoWMAmIPg3W35OFALwPJu+sLvLkp891RU7/wClB/4ycKrkf8tAncBIVU
         0s3KpzJ4FiiPjzUWvEYqkbrRox4OapPmmrLpf5lyXuNLLA46yGDsJn9Y03gSKPCGKe+v
         A78w==
X-Gm-Message-State: AOJu0YzRLa9Nx9qpbyJnVxwW6Pxbg7fxen+0BM2HL375/UdeHJK1Uq80
        WH1Vhat+azeFBzPsS7wqzTU=
X-Google-Smtp-Source: AGHT+IFNKID/IaFJ3qpqhJHmYpuAZBU6Wmv4Nxw/q6gbtqVIxJN0VLzqTsIy+patzPT8aTnyy+Dwfg==
X-Received: by 2002:a17:902:f1d2:b0:1cc:2575:db14 with SMTP id e18-20020a170902f1d200b001cc2575db14mr16012795plc.60.1698966711585;
        Thu, 02 Nov 2023 16:11:51 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 4-20020a170902ee4400b001c407fac227sm222666plo.41.2023.11.02.16.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 16:11:50 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 1AC599157AFC; Fri,  3 Nov 2023 06:11:46 +0700 (WIB)
Date:   Fri, 3 Nov 2023 06:11:46 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Marian Postevca <posteuca@mutex.one>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: Regression apparently caused by commit
 088a40980efbc2c449b72f0f2c7ebd82f71d08e2 "ASoC: amd: acp: add pm ops support
 for acp pci driver"
Message-ID: <ZUQssoD2rUHSYQ2v@debian.me>
References: <87a5v8szhc.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="co0Oi2OYqTcTDchu"
Content-Disposition: inline
In-Reply-To: <87a5v8szhc.fsf@mutex.one>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--co0Oi2OYqTcTDchu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 10:22:07PM +0300, Marian Postevca wrote:
> I'm trying to develop a sound machine driver based on the acp legacy driv=
er.
> The first version of the driver was sent for review on the alsa mailing l=
ist this
> spring: https://lore.kernel.org/all/20230320203519.20137-1-posteuca@mutex=
=2Eone
>=20
> I'm trying to fix some of the issues that were brought up during the revi=
ew back then,
> but when I ported the patches to the latest commit on the for-next
> branch, I noticed a regression where I couldn't hear any sound at all.
>=20
> So I started a bisect session and found that the first bad commit is:
> ASoC: amd: acp: add pm ops support for acp pci driver
> commit 088a40980efbc2c449b72f0f2c7ebd82f71d08e2
> https://lore.kernel.org/lkml/20230622152406.3709231-11-Syed.SabaKareem@am=
d.com
>=20
> If I revert this commit sound works as expected. So I started tinkering a=
 little bit
> with it and I believe that what happens is that the acp pci driver
> enters the autosuspend state and never leaves this state at all.
> I noticed this because if I increase the autosuspend delay to a much
> larger value, then the sound works until that delay passes.
> I added traces and I can see that when the delay expires the suspend call=
back snd_acp_suspend()
> gets called, but the resume callback snd_acp_resume() never gets called.
>=20
> I'm no expert in runtime power management (though I did read a bit on it)=
, so I don't understand
> all the things that happen underneath, but one thing that is not clear to=
 me is who's supposed
> to mark activity on this device and keep it from entering autosuspend if =
the user wants to play
> some sound? Shouldn't there be some counterpart that calls pm_runtime_mar=
k_last_busy() ?
> I looked through the code and can't find who's calling pm_runtime_mark_la=
st_busy().
>=20
> Some help here would be welcome. Is there something missing in my machine=
 driver code, or
> is the runtime pm handling in acp pci driver wrong?

Thanks for the regression report. I'm adding it to regzbot:

#regzbot ^introduced: 088a40980efbc2

--=20
An old man doll... just what I always wanted! - Clara

--co0Oi2OYqTcTDchu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUQsrgAKCRD2uYlJVVFO
o679AQCRW7cp+WmNFpWYM+EUDNsuXCHFeqjx5LAQzKMRfXv97gD+MuJIGeWYvJ0F
aDSiN4Lbm1Fo2OmQtJcQmT3DZSQ5CAM=
=uyFI
-----END PGP SIGNATURE-----

--co0Oi2OYqTcTDchu--
