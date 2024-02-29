Return-Path: <linux-kernel+bounces-86129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 749C086C00D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF307B233B5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D306E39ADF;
	Thu, 29 Feb 2024 04:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jyc+f1P+"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927092E415;
	Thu, 29 Feb 2024 04:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709182766; cv=none; b=aMpW+xiMQxGZhAxZwgugo/1EfFGUgD9bTTAgQrtxpSGBkZAcXM+OrHpKtGjQUeb1tkEe8QzSQF6SghSzcaX8SzjzDjoCWgoqgBazmb9+m/MkEx9uoy9cOXkQBuLHtonwbr8bsq6hK1jTecZF3J+vv3nHCMC2aO5n5vSmRnNNV3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709182766; c=relaxed/simple;
	bh=LEJMaC1gxEsmiBbx7I2iVFrPGxeJ2sGR0TCSwaXBt48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kld92mB3c5KVpswq44hGaxl5/1cR3pfRtnc6/Q3wBDQstvvK/EOWV3wn3kvFqVq2Drx9P692h758VCE9Yr9XhXCkbBf//00AFAF0VaBHyCN5ioJ1K54vT/IktMzbgtZgcAz4mzIr52y3QDvWtQKbZ66MVLTNJi7XtC7BWjM119k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jyc+f1P+; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-787b5c68253so26100685a.2;
        Wed, 28 Feb 2024 20:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709182763; x=1709787563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ln8ih9ys+HkjNsKguuawbY2jpQF93RZW6fsCYu3AHtU=;
        b=Jyc+f1P+JeeFUt62sDk21FQwGJiqEKkuEsgo+WUd/RBkbz7qSp+KvyksuRxsH+k3mc
         Wzq1Ej8Wyg0gPXXGqVm1/x7fIpWRYSI3L8A1JPPr5U0wJ/BLXUlHqmOVg8SMPg4Z7ZEx
         3J8NsDp/ElcHDRogRzQjjrF+e9ikZERLhd6evQHd5ib6srHxdBoA1yqZetj15YeUBU+T
         3kVnqEH39l9PzqE57vSczo0O39+NalPHVf0/UKhWP9VqAK1T5zjmOEJxn53TtzrFu1dZ
         4s1u/0XQNvJZWsedaTRoNXcMNRLlTEoVva9daq9ViVDDJXTMrffgkMnDGOxKZsFezTFm
         z75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709182763; x=1709787563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ln8ih9ys+HkjNsKguuawbY2jpQF93RZW6fsCYu3AHtU=;
        b=DkRKaxRIUSrfkwlzR27vZ6C0gy8RMUrKYkhTAVSJgfRk49HeqMzN7OjQC5JRHvW0XU
         vAUhOSQtAPFQU9DvyijavYWb41v412cDEBIs1WHHxfrA7zbtq7StEltEK1kFfwlgUq4D
         Db3u2FcOohGHrd98AtiwWHFSH8gnfihk1/h6mQGMM2soa4MdbHjgYA/xefAujcVlEJui
         3Gj40//wwUCnnQvX1GOFSt/5ZNq+a1YbPQLALnW12mH6dcxpABejRdUi0fQt6I5aRC8L
         wOxll7DV56f25PI6lgXjIdZYRpt4CmIAw0JwYg5kWXbTBFdF3utX3bLOz0xFOSdCH0CV
         SgOg==
X-Forwarded-Encrypted: i=1; AJvYcCX9d7kj1ze5HOR/b4RSviUa+7u/lUrRzpZ5yig5lgM9CKM1AbK7EHIcRpggwOzh+POHAjt1LEPXAlVoNtyCHp01+z4tLuGANvp52diLMipJ3T8IMycyGZ6g5wxm92BX6tCJYRVj9fUBjg==
X-Gm-Message-State: AOJu0Yyk25neWJ4yxQ0BITNX+wQ8e/fYeo2EdZpF0AFsFoCAOhjw5i2C
	ahU6u8kLQPHR1TbBZEvTijTT1IeiS57Jx6SV15El0TNMc5H90PEF
X-Google-Smtp-Source: AGHT+IH5EGqQke3S+1CI+MmbUruz8ZZK+JzIbyyCIsFQO2rwOg3IMuvm4r2pxdlAbncmy9S0OBtTXA==
X-Received: by 2002:ac8:7f8d:0:b0:42e:a06b:415c with SMTP id z13-20020ac87f8d000000b0042ea06b415cmr1265815qtj.15.1709182763448;
        Wed, 28 Feb 2024 20:59:23 -0800 (PST)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id f14-20020a05622a1a0e00b0042e1950d591sm349502qtb.70.2024.02.28.20.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 20:59:22 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 0C27C1200043;
	Wed, 28 Feb 2024 23:59:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 28 Feb 2024 23:59:22 -0500
X-ME-Sender: <xms:KQ_gZbANjRN3IoJ575Vf-WHNiuRqMGCWiA1Pu_DpyGdWLica66Upcw>
    <xme:KQ_gZRgQkZNQa1cXWIELHO-qBgsdDyFyKn0Rsrm27OgvZIfFARJib4OHL0MRHYnUq
    fAWz1fuh_voxWUABA>
X-ME-Received: <xmr:KQ_gZWnCucaO-27ZIJuQWKYEcRM-kqCJ-D-hEqkiNdm89mBMCAqnlTHPug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeekgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepgfeivdeugeeujeduuedvueeuvdeuieekudejieehgfejvedtgefhleejtddu
    vdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:KQ_gZdyIcQ2afB0rNU3V90wNC2mPWN2rX1ReH2tp6CQVq3jMvCdBxw>
    <xmx:KQ_gZQSyYOkZxYmejKR6uDccwoLdO7cKjllytjTxdqMChmAvLZ36SQ>
    <xmx:KQ_gZQYAslJ6ng6RO2cZBlOgFiJrFkZmSHT8w3jY_fyQjWCRZ1t8yw>
    <xmx:Kg_gZfE-GfDOkB-QzjasOHSkz-anfg1T6af3BOycb8L2HTJ_KFEhnz7BPJw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Feb 2024 23:59:21 -0500 (EST)
Date: Wed, 28 Feb 2024 20:59:17 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Nikhil V <quic_nprakash@quicinc.com>
Subject: Re: linux-next: manual merge of the rcu tree with the pm tree
Message-ID: <ZeAPJYPfgc6q2tpu@tardis>
References: <20240226135745.12ac854d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XJyYbvL4ZSs4ZkVx"
Content-Disposition: inline
In-Reply-To: <20240226135745.12ac854d@canb.auug.org.au>


--XJyYbvL4ZSs4ZkVx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 01:57:45PM +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the rcu tree got a conflict in:
>=20
>   Documentation/admin-guide/kernel-parameters.txt
>=20
> between commit:
>=20
>   3fec6e5961b7 ("PM: hibernate: Support to select compression algorithm")
>=20
> from the pm tree and commit:
>=20
>   600716592a3a ("doc: Add EARLY flag to early-parsed kernel boot paramete=
rs")
>=20
> from the rcu tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20

Thanks! The below looks good to me ;-)

Regards,
Boqun


> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc Documentation/admin-guide/kernel-parameters.txt
> index c503770e8f0b,3f894fbb4916..000000000000
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@@ -1753,18 -1749,7 +1754,18 @@@
>   				(that will set all pages holding image data
>   				during restoration read-only).
>  =20
>  +	hibernate.compressor=3D 	[HIBERNATION] Compression algorithm to be
>  +				used with hibernation.
>  +				Format: { lzo | lz4 }
>  +				Default: lzo
>  +
>  +				lzo: Select LZO compression algorithm to
>  +				compress/decompress hibernation image.
>  +
>  +				lz4: Select LZ4 compression algorithm to
>  +				compress/decompress hibernation image.
>  +
> - 	highmem=3Dnn[KMG]	[KNL,BOOT] forces the highmem zone to have an exact
> + 	highmem=3Dnn[KMG]	[KNL,BOOT,EARLY] forces the highmem zone to have an =
exact
>   			size of <nn>. This works even on boxes that have no
>   			highmem otherwise. This also works to reduce highmem
>   			size on bigger boxes.



--XJyYbvL4ZSs4ZkVx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAmXgDx8ACgkQSXnow7UH
+rh7sggApIMmADJfpEBuhu4yI0YxPVeG9zTgQbfWM+QuWH9fr6SnGyqsHumxER8D
kdKD7h8xK3ZzFc4Fl/MjRu+/GrBLDKbH16kayjiCkiOkVVjFbpHw5nlZdFlXL3Ps
h0WzOHY5URZuyXsy/eB4F5QElWNNHoCfQdS+c2JyWMagkRMwVGmhM2ZcyR4crzdK
R93WLv5lJE3xY2auuUqMEqKQUyeg+rsH/dCXv2crDeMTcM4OVbshcD7OBPQka7VM
lxkgDe7h6tp3+FioA5oVvp0YlNmXHMy85Mk2nPg7fJ9lZM4//NS4YJFFG2Gnwil4
dYvQQMIyuqLqtYSowH6GsdK8k++GBw==
=vVL1
-----END PGP SIGNATURE-----

--XJyYbvL4ZSs4ZkVx--

