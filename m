Return-Path: <linux-kernel+bounces-101148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D0087A31F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6A41C20DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC079171A6;
	Wed, 13 Mar 2024 06:58:13 +0000 (UTC)
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C5168A4;
	Wed, 13 Mar 2024 06:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.190.117.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710313093; cv=none; b=nU/6wWHYsTq7LNeRKwk0ZmTTY375/es7HF7SEraYiyuod738PRnC+/my7q/aReFyGwECJ60yRqk53+nGUSN6PU1xkYkPt0r/Gi2UKZF4r6L27DrwSNT22YbCW9YFXuW33lzUrc+OSlt4fCe8B1TOdr+L+xJ/JhQTp0gZUmfKTbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710313093; c=relaxed/simple;
	bh=PmvW/ZHZb2jfjmyR2iBa0omnwRUCkpZVR3fy4IPhgMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FQ1bcXJntRNDDJoZtD/KZeK3hlhFzcjgxb+vO0Bn9/b25XXl9AKTHcyvOW3NQ5/X//2KoQb0lO1W4shu4YVZP1mUYfVeACpZf9feDk0wu64HMlM+CWWTiizh3B1Y9+gFvSuss6kLy7pmRyjagAJg8uFBjvGlQmp/GjhNEZ4it58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; arc=none smtp.client-ip=80.190.117.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1rkIYi-000FRd-1l;
	Wed, 13 Mar 2024 07:57:51 +0100
Date: Wed, 13 Mar 2024 07:57:09 +0100
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>, Johannes
 Berg <johannes@sipsolutions.net>, llvm@lists.linux.dev
Subject: Re: [PATCH] ssb: use "break" on default case to prevent warning
Message-ID: <20240313075709.482211d3@barney>
In-Reply-To: <20240313001305.18820-1-rdunlap@infradead.org>
References: <20240313001305.18820-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lAmWD3L.FvhZsA1hfsd.+nj";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/lAmWD3L.FvhZsA1hfsd.+nj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Mar 2024 17:13:03 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:
> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -1144,6 +1144,7 @@ u32 ssb_dma_translation(struct ssb_devic
>  				return SSB_PCI_DMA;
>  		}
>  	default:
> +		break;
>  	}
>  	return 0;
>  }
>=20

Acked-by: Michael B=C3=BCsch <m@bues.ch>


--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/lAmWD3L.FvhZsA1hfsd.+nj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmXxTkUACgkQ9TK+HZCN
iw7XbhAAhZBrIaJW+jJWzeReGnwkM2jo+nR5Z0ZS2ksYzu5VBUurKhS3IeS+u9p+
Gyoo1DyumX51X55/o/ebjrr9nlC5jCjGMesahGDeX1RVk8PFYp7MMparQTW9sPCc
8tcNr+GmuONVw0D7aE0uABpTsvjykeD2XQ59XELeqT5B1aC39wxtEfR58hbYmZ93
uBaB78g9vJDe53a/0yA82bfJa4JwWyDX/0PGANKg2vpXV5fJ1wYsXoO96Za2TZwb
qi7AJdSod8k5C2RiAqR6NH1fSP3kVtwRKQq39J9ihl74MjKx1G1DtRN+Xqm12HYZ
caRXhW/oh+untqS3+ubrHxMa4hyBKAR6giVguE0Nm0fcoNxAdwUA9C96RT02T62Z
Uk8CLTX7uvf/HNxwr9Z3VRnV+p4ojdlw9qWDmd+nT9NU9DK6lYcFfTD5CZUK4A2m
hX4Z1ugA84zkyRp2otO+oeo2HI4qLGrZ11sn0qhPtq8gQZdn+ivjkSMAk7neGdsi
RutcYGnquzZ0Zk2t8RsSV5MrJXSwBJFakAVIgh/PqHX7u0x4/ZLyhCfPgcba1jxo
7KG7uHC8J58qtWQ+fVBp67WmkHvRy5ePuxqOaFSLKZBAqHLpa9NIo9egNDGw5SK9
j1BpUn3BFoEYnMb8z8eaxaAWhtu1wb1q7+ZpjxW2e8+CQnGCm0o=
=p4Wg
-----END PGP SIGNATURE-----

--Sig_/lAmWD3L.FvhZsA1hfsd.+nj--

