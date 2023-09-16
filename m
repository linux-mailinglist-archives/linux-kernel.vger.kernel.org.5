Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB057A2FB5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 13:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbjIPLcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 07:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjIPLbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 07:31:49 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE89CC9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 04:31:43 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-565334377d0so2366522a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694863903; x=1695468703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpLzCpp4ouGz/OEm3hygeNnaRFyXfqnZwX2nHo6Wzok=;
        b=OjNgV7bMNn4HoFkkvlfZq/RvVIayLAh1NEf51Qk+EKU8G6d/3XkUxM3wrjJt6/34zf
         GM7PkBv3U0Ag31+nZTs19QJde7kqlYZHh5Jlp6MvC2gXNG99PX+LXG3l3xXwKJgGENag
         Z3boM/etG+hi9+uoe0L5MhVKzm3IJ+7rYC1vWborGrjuEaC7wHtCdIAdG7LF1dYnOf97
         7TTJff1Wstd6O56BYMDfwpfwWPClM91B2lNnoCpHNG5/1aoVXXRMCGw0ZG9dKd4HNM5o
         X7zxu0MXrtuWEDIGYqc6s5O1SSmOYNCiw5+3hIpgzWbCiZ3UUHHL+a8XxB8yJtAElY43
         CQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694863903; x=1695468703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpLzCpp4ouGz/OEm3hygeNnaRFyXfqnZwX2nHo6Wzok=;
        b=KmXQQIBuBZQPgZSGRq7TfJ3nsA7jaDfhSOersvF2TT+UqbszdZK27xhcODy3djPyLL
         BcUmJ+0ngn9hwoBAYS0q8jBIHnNtrrlsE7tJZqQuE6LtFyJsb6CMU6AOlOa+GyKJMGPM
         o5TUpQoPhjDKYkSdxu2IjN+Niy9q8sY5NIqmKwki7kkUPovJYUmt9Fm0riM79z/862LB
         5mMJLyPq6kcuqPrl3p0HCQ8VAfcfpsf71t96hW5szPbPfQcQjR3GZv9D6TvLVO9KoD5u
         pnG/1z3UwosHYY/Am7+06ZxyH4iXIuZd/D9b/isFpgGfnqiClDswmjufqPPK1J7/rnBG
         crCw==
X-Gm-Message-State: AOJu0YzGqdgEWqZDzVrJcFtJAK+iCB9BuyYmVlE6tKHSn78xw5NF+Gav
        brGYAcj+aLNHVO74wy4f+RQ=
X-Google-Smtp-Source: AGHT+IHDxN5uOoCGgHPaH8q22KkvGNEbjL2HT742QPMNqY91zkWwoVYJ2tFXAtM7jdsgjHTPrU6UOQ==
X-Received: by 2002:a05:6a20:a127:b0:15a:56b9:43f6 with SMTP id q39-20020a056a20a12700b0015a56b943f6mr5367048pzk.37.1694863903045;
        Sat, 16 Sep 2023 04:31:43 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id v3-20020a62a503000000b00682bec0b680sm4354978pfm.89.2023.09.16.04.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 04:31:42 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id EA6A182F4CC2; Sat, 16 Sep 2023 18:31:37 +0700 (WIB)
Date:   Sat, 16 Sep 2023 18:31:34 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     xiaohui li <buhuiyuanyuan1984@gmail.com>
Cc:     Linux NVMe <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Christoph Hellwig <hch@lst.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: =?utf-8?B?44CQQnVn44CRdXNlLWFmdGVyLWZy?= =?utf-8?Q?ee?= in NVMe
 request double completion detected by kasan
Message-ID: <ZQWSFgDrkLgw0tO2@debian.me>
References: <CAEVrx8CEFY21BBpbpq5CmshyzgDY_WYg7VGh6Br1bZac7kBiTA@mail.gmail.com>
 <ZQQRaj6WFizrDZHM@debian.me>
 <CAEVrx8APjinyO043+DOcciqDo_iygnB8x91g8XgeMFkCueiQ9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6zWCu6giBt3n2KWK"
Content-Disposition: inline
In-Reply-To: <CAEVrx8APjinyO043+DOcciqDo_iygnB8x91g8XgeMFkCueiQ9A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6zWCu6giBt3n2KWK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 16, 2023 at 02:23:21PM +0800, xiaohui li wrote:
> This bug only appears during concurrent stress testing, It has nothing
> to do with what kinds of nvme disk to use.
> Especially when conducting DDR stress testing, the consumption of DDR
> bandwidth is high. Once the NVME driver is under pressure, the NVME IO
> request times out=EF=BC=8C
> and then this use-after-free bug appears with high probability.
>=20
> and i find other pepole have also encountered this bug. such as below:
> https://access.redhat.com/solutions/6993136   (System crash due to
> use-after-free in NVMe request double completion)
>=20
> i have no v6.6-rc1 kernel,
> shall some one can give a bug-fix patch on 5.10.x linux kernel ?   many t=
hanks.
Please don't top-post; reply inline with appropriate context instead. Reply=
ing
inline allows readers to follow the conversation flow.

Again, as I repeat, please test mainline kernel first. Since you're about
to compile your own kernel, there is a kernel documentation on it [1]. Or
you can follow Rocky Linux's guide ([2]) (as it is based on RedHat).

Thanks.

[1]: https://docs.kernel.org/admin-guide/quickly-build-trimmed-linux.html
[2]: https://docs.rockylinux.org/guides/custom-linux-kernel/

--=20
An old man doll... just what I always wanted! - Clara

--6zWCu6giBt3n2KWK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZQWSCwAKCRD2uYlJVVFO
o6ZLAP44nW9Uh09dS3YJqOWwZbUWii6MnJMKuHqStNANLwD9vgEAqoDn8nNZXNcc
ynVJXTo4j5E5ibBS4KIps59eIfcXPA4=
=qnVn
-----END PGP SIGNATURE-----

--6zWCu6giBt3n2KWK--
