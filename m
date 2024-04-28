Return-Path: <linux-kernel+bounces-161350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5778B4B08
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 11:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3CD1C20ACE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12A355776;
	Sun, 28 Apr 2024 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io13Aaod"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8B8AD52
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714297657; cv=none; b=sIN+LEvLY9r29Dg4qNF3Lb3uBqlTV3l8OiGhYBmYR4irWSrE/ZbXnqqv3XX7CAxAr95kY5peOEH7I1GTATj9OfLxCE4ap5TGX242O40I0DyN5egKuZ8Ql7fz9ffb4dnkOXloMD5LSH/p2tUw3A2MNQw7NQiHcJYgHsv0rQOdkGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714297657; c=relaxed/simple;
	bh=fBR+X0ZuoYudejnJhNPe0F13DsJXHpLmoaeO4zLaVIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sqtMrtAuuaxEnLerJea4Ri41EGCGLOd+/VpiVYuxG6VZo089IHAcGQtMMN1WQGQCE1+bbvHBkyHWh3rAz371Nsuk1yy/w5WQRR1CLF72bwkgcwB5/hyBSpK3esL/E7Bdp8D6VcTVbaPN5Y6R/RvrcPhHHiMWutTe01mybY7EZAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Io13Aaod; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e3ca546d40so29554555ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 02:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714297655; x=1714902455; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fBR+X0ZuoYudejnJhNPe0F13DsJXHpLmoaeO4zLaVIQ=;
        b=Io13AaodiVQ+9BehlgcXi4gs7jWKPbwrnwPAPMvj7mAXzLOYmDT+caWW+MFyRRPfZT
         vCHQ3bPnkXppTFkNe46LHI++4OyJm+It/DpzsvcYdUMArQZ5AEcChL+NNSnJiROr5Wmb
         bipi+tnItySdJ3OjHfG/wivxkM7TZUCKgYCtnDcLvWVdrA42gLJMFlDQY3rego4kaVrA
         RvN8BjARkg/IhSvleqiWF7HH4gfhh9s/fBABqDOqJeh+7FO9ZAsq50ciNuIzesVO+aNk
         XofNiRjGZGu8a6AN3oXq+gzwdIuKoiKz7MdlViPUlMaYhT8No3bpl71aUGspGe0pQN2s
         4CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714297655; x=1714902455;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBR+X0ZuoYudejnJhNPe0F13DsJXHpLmoaeO4zLaVIQ=;
        b=bHWWAwC3Ppr5clOQ/Vhj+yWow0Rtud4bqLcg5Wh0gthRBLFwK4IXzDiikJ/4Zt7O+7
         meB/UAsQvG3A9kePYdjaIY6nfRBflDdHVwWaH3ct05ykkc+1w/s4pens/BJvOJEutC0J
         WUNKuO3X792SKr9QZWFqAbAaoFUj8zrPFqT9ZIEWgrtFIdMkC60ajUcnabOpCt75e7cP
         J9zDNDkurrvps/YW7gh2kUEwiCd/ir0h/kOQ6IBcJkOwT/rnhXfpPi9wRIAd/dKoZrFj
         xz/yTRSSKD5onIllBd+O/B4ApmjEsHbCNlwJCu9OaFUmSrZU2myn/VHRR6cInvSNuBBx
         80Hg==
X-Gm-Message-State: AOJu0Yx4q0DnEw3BGwpP2nJ65FOHbvv7jbvrh38P0LQdjg8sJCXBcmqc
	6Ymv1GqQici8tUvICqtzRMobZ99RRxsLvesMvrBdvpd6RoO0oywaZsjvLg==
X-Google-Smtp-Source: AGHT+IHDSPaQguUm+pSvWiNq6Q7JSo/A5gmUC0Bc51qBeRDwhGlP0PGHoagJEv6jJeg6y+re4lMfAA==
X-Received: by 2002:a17:90b:370c:b0:2a0:3dc3:8a8b with SMTP id mg12-20020a17090b370c00b002a03dc38a8bmr6834495pjb.47.1714297655137;
        Sun, 28 Apr 2024 02:47:35 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090b068f00b0029b59bf77b4sm18839576pjz.42.2024.04.28.02.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 02:47:34 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 07C1C184692DC; Sun, 28 Apr 2024 16:47:31 +0700 (WIB)
Date: Sun, 28 Apr 2024 16:47:31 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Sending patches as eml message attachment?
Message-ID: <Zi4bMx2FKuviJi0M@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d/1vvkNs4WDaLotI"
Content-Disposition: inline


--d/1vvkNs4WDaLotI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Sometimes I'm tempted to send patches as .eml attachments (just like in
error messages sent by mail servers to me). Is patch submission by
aforementioned way accepted? If not, why?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--d/1vvkNs4WDaLotI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZi4bMwAKCRD2uYlJVVFO
ow0JAP49JJ73V9xjX7lULH5XCUv80s56+OFWDwyS1weirDNSxgD9GgnaqM+TQQX9
crKHbOnMjn10GplFB9Uq0kKLJ3uyhA8=
=3cD1
-----END PGP SIGNATURE-----

--d/1vvkNs4WDaLotI--

