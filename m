Return-Path: <linux-kernel+bounces-91199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998E5870B1C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7081F22D52
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B65D7A706;
	Mon,  4 Mar 2024 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="J3MzlEp0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="etKXsc+F"
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C656A6166B;
	Mon,  4 Mar 2024 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709582537; cv=none; b=khfjl2ZkaMhS+3CFh+pxuCDIutxmTBwRvnB0KQDZJvG/+tubXXOj25g7rEaLKGyN9tcaJoB3qAynOOda7omkAekZcolww2eammfEKzHUTVW+XjknxMj+5qN2PkB90v3Nxnhdlbj/czDS+ObuKee7Orqyq/gGbEaP0uChDXWsjzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709582537; c=relaxed/simple;
	bh=W/uRvTZAsWCNOm/39QHPuHOMNmZlMmdJH0RBqn5B/bg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m1wF3HvnW2jAqueh+XjvG0cDHXKAGR1idhspNKuZ4ZkvL6BPrU/27gmS1GC/+1zsx1TUIgyxDOuybvyH6B0YauhnBzrH3PGh7jBuQufKvcOVYgpvSJlsJpbqvmcqthvY0+cnW5NjFfigu1DTyVfkg0oCKdbj5N+45XV0piHTbXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com; spf=none smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=J3MzlEp0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=etKXsc+F; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=invisiblethingslab.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id B08C013800CA;
	Mon,  4 Mar 2024 15:02:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 04 Mar 2024 15:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1709582534; x=1709668934; bh=9o
	Pusn5+rCN4IKmwCH88m/ny24uGHTvOdf6B86ocg1I=; b=J3MzlEp0ldkck3bxq0
	NxZoaeC8NZAhGP9aMtqXLV7dexLnFRrgF5rjzSohUAzFJ4xaU1HYgzebj5CwQkLo
	rUVTz6rZ9MV9PXWarrVV0a7JgwWApcYCcfTLCNjkCK0PMRYjURdodkxFJTITaPwr
	pFoCHicGxQtFmciijuG6zLFCJSmnGI9L+CGg4vwoTtTY3H6dimSDkYYmf4RZ3Vf4
	phT4y+UYO3l4d4yFon+ZFFxVQh28WbjmLX5sEVK6SIL/5THjMtxFyB1vVIYxgH5K
	8SBqG0+PAP6spLN5ZmkZmMyf33CsKFCTGiuIx53kvCulq8Etc2qaXUElHEK2OFHn
	4m0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1709582534; x=1709668934; bh=9oPusn5+rCN4IKmwCH88m/ny24uGHTvOdf6
	B86ocg1I=; b=etKXsc+FIZ2XNc61BGudXU9/lZCyjO7zqK3RKpbMM2+VeaHWYy+
	x+3TyIpKhinNdAUlvFWNsLT/uA1+DzVSsxGW95Ha4uq8p5hxYlUjNZnnDf+RTY9e
	B1mimozVd04VPR3MrjFFRHPYtr2UXmDvNVBq+C+jLeh1mcdmzTZyLy+M5FkPnFNU
	j3C34PYsq6VxWcPDmlh9dLFpqjWiIi0LphsVovU4xhcCOzT2OL54P9wMHTFtiJ3u
	fa8sB4pZ5WCX3oPcJMumQo1JdR05dRpPriHNPJX12NK6MxlaQ3A0Fe8SvxKQRYjW
	/Ijs4XaXxLx+Hh+anat+SR5WUtfc7/8hWEw==
X-ME-Sender: <xms:xijmZQEzCmd0uL1KZkXvfamv4uZ_TX4Nawv1qJeWv2s2RVkrqmhrdw>
    <xme:xijmZZW5DDTkGgxy0z_SjayvnVc0BJRxW1ZBS5iXU4M9FOXBY_qXaa4tXlVYIhiy4
    u564cY1OFvFzco>
X-ME-Received: <xmr:xijmZaI649rxjgSTjtYthJ4foVrBAwBg8Bp38mDEROL1tDsyEFLnRVZdpxHcpdGB6deFTZByaRKlpAjXVWMmiZECvTBVU1Ul_cK5la2iwIcNd_s8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddufedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesghdtreertddtvdenucfhrhhomhepffgvmhhiucfo
    rghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhnghhslh
    grsgdrtghomheqnecuggftrfgrthhtvghrnhepteekvefggeeivdffleehudejveevfeeg
    vdeghfeigfdvgffgudeuueefveeuveefnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeguvghm
    ihesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:xijmZSHvqCcw29Fs9XFS31b59iJFgy1EqwJgFqqjuvec4VV5Vm09eQ>
    <xmx:xijmZWU7dfbpVD25yXL2LRAOpO7N6RBIZKZgj_1OkWo8PU8MIAw2og>
    <xmx:xijmZVOkSRsW988witsGGJu5DJ2UU1V8dS8yrP0ojkEp8NppL7FxuA>
    <xmx:xijmZThwZKIxTwfCBFY0DekA_wwFcVNvXsqVXlwivG7I5d6I0wNI3g>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 15:02:14 -0500 (EST)
Date: Mon, 4 Mar 2024 15:01:51 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: linux-usb@vger.kernel.org
Cc: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: usbip doesn't work with userspace code that accesses USB devices
Message-ID: <ZeYov0k8njwcZzGX@itl-email>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="omYEQKG3r4GVCydy"
Content-Disposition: inline


--omYEQKG3r4GVCydy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 4 Mar 2024 15:01:51 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: linux-usb@vger.kernel.org
Cc: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: usbip doesn't work with userspace code that accesses USB devices

Qubes OS users are reporting that MTP doesn't work with USB passthrough.
Fastboot (used for flashing a custom OS to an Android device) also
doesn't work.  Kernel-mode drivers, such as Bluetooth and USB storage,
seem to usually work as expected.  Since MTP and fastboot are both
implemented in userspace, it appears that there is some problem with the
interaction of usbip, our USB proxy (which is based on USBIP), and
userspace programs that interact with USB devices directly.

The bug report can be found at [1] and the source code for the USB proxy
can be found at [2].  The script used on the sending side (the one with
the physical USB controller) is at [3] and the script used by the
receiving side (the one the device is attached to) is at [4].  All of
these links are for the current version as of this email being sent, so
that anyone looking at this email in the future doesn't get confused.

Is this a bug in usbip, or is this due to usbip being used incorrectly?
I'm happy to provide additional information needed to debug the problem,
but I don't have access to the reporter's system.

[1]: https://github.com/QubesOS/qubes-issues/issues/6330
[2]: https://github.com/QubesOS/qubes-app-linux-usb-proxy/tree/57ab3940d450=
b18e570da57886d65cb5707aa60f
[3]: https://github.com/QubesOS/qubes-app-linux-usb-proxy/blob/57ab3940d450=
b18e570da57886d65cb5707aa60f/src/usb-export
[4]: https://github.com/QubesOS/qubes-app-linux-usb-proxy/blob/57ab3940d450=
b18e570da57886d65cb5707aa60f/src/usb-import
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--omYEQKG3r4GVCydy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmXmKL8ACgkQsoi1X/+c
IsEUCBAAvrO9zUYjf7lBdCcGpwQTWcfj1mmsdh5NKJF1RmfpmpuiZSoroJSfPtlF
19ZDl6srLOxQC7Mu0k3JQaJIBSiYY6C3kLEafYG40ftCemosKBrK7z/hYcmNz2ZW
wrrCO8ofcejvClFDjE89OP8KYD7/8SZpoB5rEr9mTxTFJyuwywUzT7dhCvQwNdu2
oE9YUh2q43ENzcVgEydceRBZa8ELas+gqQ8oK0PSPR8cmhic9TjhkfHXvzgqzvR1
t6pvs66quWK/BtaEMoW4gZN2+a2YZtimkaRIrngLYGDh+7zTPbyMp1rFVebgamAG
qeFTtRTyFqkb4NUlDr+pDk8BbbpYJOS/HPiYWXHvx3zl/1m+FJkrF9pA1dg5Z1Jn
eLzOJhHRcWeONu/m9Ic3Aunim4tggTCFktqtAj0P9RmuRiGhSs298SArhGbm3rHB
8NpJKlzpz9C2rberQsxwvtuzWmS1tOyMmjhfb+REzI4BEaRWG57eamfztD6TzYbD
TgmK4lP5rNlZjge4T1mUF4rcOPEMbCX7b0jbuqBseBBB7vSxhMCGhIlm2pIij+5g
/+6krJDBVQieNpyOBCmXhZDqcaf4717Bre+BiVUm6p9cl2VRRPwieTiWe9JMLwYr
40TbnuwS2nEox9AadwUQRzwhr/kt9dG7/4LCpHdhPrDQeTiiZk8=
=OKcn
-----END PGP SIGNATURE-----

--omYEQKG3r4GVCydy--

