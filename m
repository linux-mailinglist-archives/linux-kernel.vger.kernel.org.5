Return-Path: <linux-kernel+bounces-28731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F28830255
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBEE3B2220E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D939414015;
	Wed, 17 Jan 2024 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="p5xUY96l"
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370BD13FEB;
	Wed, 17 Jan 2024 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483863; cv=none; b=q2I2Mg8286TV76vKp3hDZvFesdw+ma1co2vmZm4pm+m/ov1XhZxtA4vrEmXJ963fDNX2SnyVPUk5zxdNBigb6iKyiRtkL8vaQv8Zd4yJJAND9gTyBqloxXYUHAmBYVVV4rEw4tDts03FUWJ3tUF1wP0kjHRoGcp9+DUgePzQFnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483863; c=relaxed/simple;
	bh=/NmyKlfJ6650BeNPMAL+O91r4ewLVwM+eDR87dQnzac=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type; b=grdBvKR3AR62T1phSdJHbB9dzdLvY1pOL60SDme9+PrJv9paXREV6ymdHuf9K+hnXAKpqE2K9jIcr7FKROlV/hKCtCTH8ODDzjfwN8n5VpVw1cOkTg8YnBKc+C8iZlj+k8rsxsFSvCmCf0x43zSBcGkJZzl61TGnroDONJNDZ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=p5xUY96l; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1705483857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tk4LN5O9pnCWEgZ+hxmp9V07AVwi66XGTPjDMnz4TZI=;
	b=p5xUY96lfFeFeJhxsbwHcRYD+mU0iiTWWayJr9+pflXvgduJMa0MUabV9ucUhctV0tnxyb
	G/J88rnnDt+mJy6D4JcoB1fCb1Ylw/QqdCO+vd5NSlCRYzk6QrTGdqYMCc/pW4ORw7+Zn5
	ypeyCcmwW36MTBpTR3Zu5AIR5LTx3To=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 syzbot <syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [btrfs?] memory leak in corrupted
Date: Wed, 17 Jan 2024 10:30:55 +0100
Message-ID: <5746181.DvuYhMxLoT@ripper>
In-Reply-To: <000000000000beadc4060f0cbc23@google.com>
References: <000000000000beadc4060f0cbc23@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6009036.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart6009036.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [syzbot] [btrfs?] memory leak in corrupted
Date: Wed, 17 Jan 2024 10:30:55 +0100
Message-ID: <5746181.DvuYhMxLoT@ripper>
In-Reply-To: <000000000000beadc4060f0cbc23@google.com>
References: <000000000000beadc4060f0cbc23@google.com>
MIME-Version: 1.0

On Tuesday, 16 January 2024 10:27:20 CET syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14620debe80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a7031f9e71583b4a
> dashboard link: https://syzkaller.appspot.com/bug?extid=ebe64cc5950868e77358
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a344c1e80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/82a7201eef4c/disk-052d5343.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/ca12b4c31826/vmlinux-052d5343.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3f07360ba5a8/bzImage-052d5343.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ebe64cc5950868e77358@syzkaller.appspotmail.com


#syz test git://git.open-mesh.org/linux-merge.git a67d6793286ffab46b72b1afff5fb1f0ca55f2e1

Kind regards,
	Sven
--nextPart6009036.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmWnnk8ACgkQXYcKB8Em
e0bcbBAAr5gtssx/V1po0W1ajwPIxK80mbSHo+Ch0/ZBvbJGsOcFGc83+vFBoEj8
2UE42Cqv/1PUM73gCOeyOItIBJ4Nr0FW7YmddfWORjvNpnG8s5v0Q5DAOpkTjGBq
RewEg1uWVerXh9RS5k/V6W0ZRDnnZnqT6EqOm/zd04XRnihgTME1xF6zPwctkIrM
2cudZhgkGDWKYI5GSPR5/hfkxXB/DK9tpS3LtJ73bSb+QJyd5WR/WPcPTY3+hpU+
IW+cwtCYCxR0GzCAtBvFQDQ+XeKu78A26QbWTXCJ4tQn1KwRKh+VZIHS5oyAEKgc
tdA6fmQioEpm4NZkpsRl1x09iR4xYeSn5oMR56XNrsxWhg7IhXL+HnHxMKP6oGOS
GlG54yTgfIvUz3jzlJqTRP8s/OhDnYdhacRSSOFZ53lRlNIlL8SNROPiie5gLqKW
gjkZagplFhLNf139twREGp5h8HE3VNuPb/2TFYClcSj/HTbVOKbyKD37JWuqlCi0
eVO269tCpIYdUOwA/4kAwnQMeAXu1/rIO8GkCfgbYok94wuGqbNzslHUUC7JrEf+
DkIeLCtnuvdo1AHt65r75hF+lQ7TSd4r4HD2j/Z2ssVvCVBiFJkCvvExh0Nz4FHr
3kq4Q1cnTb+4evLeqpWyjvSKwp1+wmgrgwbYP/5B81aT0d3KMeE=
=UkN8
-----END PGP SIGNATURE-----

--nextPart6009036.lOV4Wx5bFT--




