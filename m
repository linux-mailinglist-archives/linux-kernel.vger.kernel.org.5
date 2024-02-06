Return-Path: <linux-kernel+bounces-54705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B74EB84B2A4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1F91F25B7B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A970153387;
	Tue,  6 Feb 2024 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bqx/HFnG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DdqX2+OR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dMNap4FK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ITzOJ/hM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5031EA7D;
	Tue,  6 Feb 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216220; cv=none; b=LyeckqmWV5yd7GXNXCh353UjzWfUoKE+OCV38g7E7YfrpBVAWy3durIk+AK4gY8ezRhWv80PFJJQuGZSDS9A5Hp+uBjat5PTlR91Rql4zOV+3WfIVWd07/ou7ctdKUeaWh5GAOONYEi4C0ZWempJLFQ/9QEEyagGydUUQLRljKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216220; c=relaxed/simple;
	bh=eLDBoAWHndMbGf27s8TgD2Jw68rJIJDhNz9sDl9B2dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9Gu6aBGIfpMwoLxX0Af7yDvzeD3JPZCZg2Q6Iucv3GAJY0A3tHBysixfOQveh/r78AHPK2p+MfW7lPGxyElmB7XMyCBH/SLcJut2CJcBjdZTpZJy1DMm/fZ2d0MuCBedJyzGWG7oq+BAVtWz6D/L7b4mxl3Kl5jqgo8b9ZBUsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bqx/HFnG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DdqX2+OR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dMNap4FK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ITzOJ/hM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E009A220EC;
	Tue,  6 Feb 2024 10:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707216217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e29oyO37i95pTLMkje0Wsv+5pthrbUWw/AkjX6REjE4=;
	b=bqx/HFnGa6rFB+PJh/7nh88ao1vE8d2/4JQbltclyvqL1JVzOeiuoWz7r2JJb4NK9XGYPq
	ADXe6qA+gj33RudVy1C+3PbbWajtItxY3DJPnjd+RZSKpItAAm5BfKA892ChLc+JhvvV2l
	CZs5Nmkqb4MooGGB44+bSI2AGM+QH5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707216217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e29oyO37i95pTLMkje0Wsv+5pthrbUWw/AkjX6REjE4=;
	b=DdqX2+ORP3cG6Wgm8M7yiImK3L28QrCZcuzObqHfThMsvUPcCeLICFTyFdCAhGrpeze5WG
	uBYtS3P5neXt5fDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707216216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e29oyO37i95pTLMkje0Wsv+5pthrbUWw/AkjX6REjE4=;
	b=dMNap4FKk/3n47Zg49pbHUVQTGj88ZGC3b6fbWkvwJnmDAyLhm/aNbw/e9rypNAZ27u1kg
	ft726zjNqRzVjRkAJQv6KSJCAuPsamOrW4YcpTYYBjciRwhyy0Gk4mZHgDOAIJoj1WMdLr
	cDcou/LeOTYjbWd/1eIHuLq48VsQTuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707216216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e29oyO37i95pTLMkje0Wsv+5pthrbUWw/AkjX6REjE4=;
	b=ITzOJ/hMNM9ANK132FE87xw5jJujEq96OXlg7Av//nN6JH+JmeNW7ygoQ3n7ochGRJAYCn
	tprx7S7MbvpPk2CA==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id CAD0820147; Tue,  6 Feb 2024 11:43:36 +0100 (CET)
Date: Tue, 6 Feb 2024 11:43:36 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, andrea.mattiazzo@suse.com
Subject: Re: [PATCH net] netfilter: nf_tables: fix pointer math issue in
 nft_byteorder_eval()
Message-ID: <20240206104336.ctigqpkunom2ufmn@lion.mk-sys.cz>
References: <15fdceb5-2de5-4453-98b3-cfa9d486e8da@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vuphuwffpatba3uh"
Content-Disposition: inline
In-Reply-To: <15fdceb5-2de5-4453-98b3-cfa9d486e8da@moroto.mountain>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.90 / 50.00];
	 ARC_NA(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.20)[multipart/signed,text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 SIGNED_PGP(-2.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~]
X-Spam-Level: **
X-Spam-Score: 2.90
X-Spam-Flag: NO


--vuphuwffpatba3uh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 03, 2023 at 09:42:51AM +0300, Dan Carpenter wrote:
> The problem is in nft_byteorder_eval() where we are iterating through a
> loop and writing to dst[0], dst[1], dst[2] and so on...  On each
> iteration we are writing 8 bytes.  But dst[] is an array of u32 so each
> element only has space for 4 bytes.  That means that every iteration
> overwrites part of the previous element.
>=20
> I spotted this bug while reviewing commit caf3ef7468f7 ("netfilter:
> nf_tables: prevent OOB access in nft_byteorder_eval") which is a related
> issue.  I think that the reason we have not detected this bug in testing
> is that most of time we only write one element.
>=20
> Fixes: ce1e7989d989 ("netfilter: nft_byteorder: provide 64bit le/be conve=
rsion")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  include/net/netfilter/nf_tables.h | 4 ++--
>  net/netfilter/nft_byteorder.c     | 5 +++--
>  net/netfilter/nft_meta.c          | 2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf=
_tables.h
> index 3bbd13ab1ecf..b157c5cafd14 100644
> --- a/include/net/netfilter/nf_tables.h
> +++ b/include/net/netfilter/nf_tables.h
> @@ -178,9 +178,9 @@ static inline __be32 nft_reg_load_be32(const u32 *sre=
g)
>  	return *(__force __be32 *)sreg;
>  }
> =20
> -static inline void nft_reg_store64(u32 *dreg, u64 val)
> +static inline void nft_reg_store64(u64 *dreg, u64 val)
>  {
> -	put_unaligned(val, (u64 *)dreg);
> +	put_unaligned(val, dreg);
>  }
> =20
>  static inline u64 nft_reg_load64(const u32 *sreg)
> diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
> index e596d1a842f7..f6e791a68101 100644
> --- a/net/netfilter/nft_byteorder.c
> +++ b/net/netfilter/nft_byteorder.c
> @@ -38,13 +38,14 @@ void nft_byteorder_eval(const struct nft_expr *expr,
> =20
>  	switch (priv->size) {
>  	case 8: {
> +		u64 *dst64 =3D (void *)dst;
>  		u64 src64;
> =20
>  		switch (priv->op) {
>  		case NFT_BYTEORDER_NTOH:
>  			for (i =3D 0; i < priv->len / 8; i++) {
>  				src64 =3D nft_reg_load64(&src[i]);
> -				nft_reg_store64(&dst[i],
> +				nft_reg_store64(&dst64[i],
>  						be64_to_cpu((__force __be64)src64));
>  			}
>  			break;
> @@ -52,7 +53,7 @@ void nft_byteorder_eval(const struct nft_expr *expr,
>  			for (i =3D 0; i < priv->len / 8; i++) {
>  				src64 =3D (__force __u64)
>  					cpu_to_be64(nft_reg_load64(&src[i]));
> -				nft_reg_store64(&dst[i], src64);
> +				nft_reg_store64(&dst64[i], src64);
>  			}
>  			break;
>  		}

I stumbled upon this when the issue got a CVE id (sigh) and I share
Andrea's (Cc-ed) concern that the fix is incomplete. While the fix,
commit c301f0981fdd ("netfilter: nf_tables: fix pointer math issue in
nft_byteorder_eval()") now, fixes the destination side, src is still
a pointer to u32, i.e. we are reading 64-bit values with relative
offsets which are multiples of 32 bits.

Shouldn't we fix this as well, e.g. like indicated below?

Michal

---------------------------------------------------------------------------=
---
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_t=
ables.h
index 001226c34621..bb4b83ea2908 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -183,9 +183,9 @@ static inline void nft_reg_store64(u64 *dreg, u64 val)
 	put_unaligned(val, dreg);
 }
=20
-static inline u64 nft_reg_load64(const u32 *sreg)
+static inline u64 nft_reg_load64(const u64 *sreg)
 {
-	return get_unaligned((u64 *)sreg);
+	return get_unaligned(sreg);
 }
=20
 static inline void nft_data_copy(u32 *dst, const struct nft_data *src,
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index f6e791a68101..2a64c69ed507 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -39,21 +39,22 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 	switch (priv->size) {
 	case 8: {
 		u64 *dst64 =3D (void *)dst;
-		u64 src64;
+		u64 *src64 =3D (void *)src;
+		u64 val64;
=20
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
 			for (i =3D 0; i < priv->len / 8; i++) {
-				src64 =3D nft_reg_load64(&src[i]);
+				val64 =3D nft_reg_load64(&src64[i]);
 				nft_reg_store64(&dst64[i],
-						be64_to_cpu((__force __be64)src64));
+						be64_to_cpu((__force __be64)val64));
 			}
 			break;
 		case NFT_BYTEORDER_HTON:
 			for (i =3D 0; i < priv->len / 8; i++) {
-				src64 =3D (__force __u64)
-					cpu_to_be64(nft_reg_load64(&src[i]));
-				nft_reg_store64(&dst64[i], src64);
+				val64 =3D (__force __u64)
+					cpu_to_be64(nft_reg_load64(&src64[i]));
+				nft_reg_store64(&dst64[i], val64);
 			}
 			break;
 		}
---------------------------------------------------------------------------=
---

--vuphuwffpatba3uh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmXCDVMACgkQ538sG/LR
dpVLYwf/SKJnMxraCQMxRMfJwRCMRFwIdmxy7ROUbMnL2jE+tTYbGSuezhnRDq5v
nws0SeWQtoztU+s9Uq15xeaBf25S0bAVcJluXL+8rz2cka4Rr/T9C+ZkyoqDg3va
Nd4f5l6GGSP3HhnQpD5XBH/H1UUyj+I3o1sFsyo7FSTEBD4BvjkMy4qGExuTVNgy
En42gfsDykiLAQJ+Sopw8uk1A4e6FWSg6mkP9qn+gN328MFTQya/VossxCE9w5fn
L80MUqY54jsgiNGOtDMGxWOdxk44WYa4CYGmGuRslrAMS476Bu0+Ulsq+d15uGvh
XTCUggn8Bi7DttIMf2jUoC7y8TsqKw==
=YriJ
-----END PGP SIGNATURE-----

--vuphuwffpatba3uh--

