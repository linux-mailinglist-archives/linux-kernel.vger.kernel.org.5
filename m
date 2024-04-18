Return-Path: <linux-kernel+bounces-149785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2862B8A95D9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD0D1F21E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F9415AD93;
	Thu, 18 Apr 2024 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="ReK9lGQd"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D8F15AAC9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432015; cv=none; b=F6/UnCD9bhfMtH+WpeaTPahUX8jdJQNiTQ+Eh48triXphsL0vthcLC/ROPGV8P+J+3oB8vzWG5bdSauSFDgRTK1+obk1qxNpzT5zGNCUdcH4WekRExtHtoeaHsnv8Zdx8NeaZoxwc//YGNU1VY67eaxn9OUf9FZLSqNTuD1/rdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432015; c=relaxed/simple;
	bh=gfpbvJ7La8EXjl6RKoYMPgYZytNXvgyc+bueamjXyCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QD35zFvldoWhkNEbN70vmBvwpPunNnKZJjSa/bRrdGaBQO4bXMH7FehHGkYim4jfB/uImuExe+LnkrASbMSlIKdT20glrTquqmKftSIWcTk6ylw7BOzBn059D4xOQxYN2BXzKscl1lw1mhKUshtxKKVIc2zVCTc+CE8ePLGzLkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=ReK9lGQd; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1713432010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OgDQ00mUpxy3+2dq2TcrdALIdNhTcXrsqRSYdfRVb6Q=;
	b=ReK9lGQduw+pn4a4IvkuUbIB2GRIVJ1ww7GWvcLG8CsRLsZajZzxpPHo9bfGYmuNmFR2aS
	y/sLNTbOo6ijQy4bMGv6X/JmXGbAjULg5GYRDp3HumT5gfiDHgXp3vNWhMTUnuZ1PP0+w9
	8Pc8VXXHUQanEtLYN0TK16UtWaujF6tssCaFQ1HJl+2a3Ftq4rHLa9aAaW6nacoUiMvS3T
	XJ3yB06CmbUPnIDf1dmRdEF1WMUGczHML9iH91nYATDBw0gkdtcHmjeWNeu5WJ3xT3MCC8
	4KteMe8chIxEq8blw8cIImy0cFdSYS6HCiaDDvbn8UHUd017Zg6iGdiNkhWS3g==
From: Diederik de Haas <didi.debian@cknow.org>
To: liujianfeng1994@gmail.com
Cc: krzk@kernel.org, linux-rockchip@lists.infradead.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, ezequiel@vanguardiasur.com.ar, heiko@sntech.de,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, mchehab@kernel.org,
 p.zabel@pengutronix.de, robh@kernel.org, sfr@canb.auug.org.au,
 Conor Dooley <conor.dooley@microchip.com>,
 Jianfeng Liu <liujianfeng1994@gmail.com>
Subject:
 Re: [PATCH v5 2/2] dt-bindings: media: rockchip-vpu: Add rk3588 vdpu121
 compatible string
Date: Thu, 18 Apr 2024 11:19:56 +0200
Message-ID: <1774986.o0yEF5yP89@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20240413155709.802362-1-liujianfeng1994@gmail.com>
References:
 <2a516484-ea87-444e-a89d-9fe33d08148f@kernel.org>
 <20240413155709.802362-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart27639082.gtX0PHzvVj";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart27639082.gtX0PHzvVj
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: liujianfeng1994@gmail.com
Date: Thu, 18 Apr 2024 11:19:56 +0200
Message-ID: <1774986.o0yEF5yP89@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20240413155709.802362-1-liujianfeng1994@gmail.com>
MIME-Version: 1.0

On Saturday, 13 April 2024 17:57:09 CEST Jianfeng Liu wrote:
> I'm sorry for my unkonwing about the kernel patching process. And I'm
> sorry to let maintainers do extra work. Thank you for teaching me this.
> I will do this right in future patches.
> 
> I did received a Acked-by tag from Conor in v4:
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> I note it here in case someone forgets this tag.

I think it's beneficial to send a v6 with the following changes:
1) Make this dt-bindings patch the first in the series
2) Make sure you've collected all the tags you've received to all the patches
3) Specify the base commit

ad 1) I don't know if it's a hard rule, but I've seen a consistent pattern 
where the dt-binding changes come before those changes being applied to 
DeviceTree files. It also makes sense as when the dt-binding change hasn't been 
applied, then the DT file is technically invalid.

ad 2) You shouldn't make maintainers do extra work to get your patch(es) 
merged; you want to make their work as easy as possible. Thus you do the 
(extra) work and provide a new version of the patch(es).
Sending multiple versions in a single day is generally not recommended as you 
should give reviewers some time to do the review. But it should be fine now as 
several days have past without new reviews.

ad 3) The `git format-patch` command has a `--base=<commit>` parameter with 
which you can make explicit upon which commit the patch is based.
That works a lot better/easier then a textual description.

HTH
--nextPart27639082.gtX0PHzvVj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZiDlvAAKCRDXblvOeH7b
bmEdAP9OLqzxTgUxfIC4NVwn89ZMipgZ02R2mr8wczdNorVfxgEAwMVlJgDzsjlr
2lkalQpvcr6qdfULVlBbAY1pfncDyAY=
=4ic4
-----END PGP SIGNATURE-----

--nextPart27639082.gtX0PHzvVj--




