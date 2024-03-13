Return-Path: <linux-kernel+bounces-101233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 381ED87A45C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6021C21AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A331B976;
	Wed, 13 Mar 2024 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ab3VxTqE"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0488E1AAD4;
	Wed, 13 Mar 2024 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320236; cv=none; b=FdKTjixzT4uQtnzwzaZFzePfb/kFoXpI5aOaIyPABAtyjT93SHnvm9UZO4h8PICsTlXQt8x/QiBjfiA1sM4glkjim+ICEBC9a7JhfTRXL65wps7MunBVvzVjP7Gl+t+DzrlX9WJJjA05PCrPq9ewTDtohnC47huvJsMTBMpmlRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320236; c=relaxed/simple;
	bh=qMFjOw5oWXHTNwfAIdt5NPZlOtPArHhvm1xObO8VH44=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VpA+nCygPwfzXAVsONPwYhfuI6A5xuUxxMlIal/EriqTked0hPgYP9zF4qMVZMREL6k1Omz2WmMwmCqEGYV/s/hmZ+o0EarfxaX5pf1KG+rtPY6AZH+PF+2Ze+vBRobItYlj3Gnk6QgEQC/BUeKKzaYXSDhDiTv6FOFCxILcQEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ab3VxTqE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=7Z3xpgxMC3SabrhTXAHSyPXqOmddBGRm2jLKIlBKce0=;
	t=1710320234; x=1711529834; b=Ab3VxTqE9GZ/mGpgNWdO20gXFpnG8sqFCd4Dfl1/7f8lbDF
	IevLjr0RN7NoCLrp8O7XfRLjtbLQ6F54xkWZd51cIvoQGdPLjR4P1Z1fhdf4AxOzWLm3J2OCdZLPm
	tMOlP10dZt3Bmfwy2gnLtHHUO4+vI+sRrTegBw8rpcQSA7LCT/BVRzySJynIKnuRavwXJ0XOVE1v/
	rJuBY3nVDIVURI0HntM5cr74WFg4Cm1wTuO5MqMdY1BC44CYOPU4RnM19fsb/mQtl59/jgbFuwcI8
	BBiJapuJt54Jpdq1hihdCAd5WYpKdG1aRhAl2UoPbxFzguk9N5ZBMifA4g42F8+w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rkKPv-0000000F7E9-0rbB;
	Wed, 13 Mar 2024 09:56:55 +0100
Message-ID: <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net>
Subject: Re: [REGRESSION] Re: [PATCH] crypto: pkcs7: remove sha1 support
From: Johannes Berg <johannes@sipsolutions.net>
To: Karel Balej <balejk@matfyz.cz>, dimitri.ledkov@canonical.com
Cc: alexandre.torgue@foss.st.com, davem@davemloft.net, dhowells@redhat.com, 
	herbert@gondor.apana.org.au, keyrings@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, mcgrof@kernel.org, 
	mcoquelin.stm32@gmail.com, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, iwd@lists.linux.dev
Date: Wed, 13 Mar 2024 09:56:53 +0100
In-Reply-To: <CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz>
References: <CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Not sure why you're CC'ing the world, but I guess adding a few more
doesn't hurt ...

On Wed, 2024-03-13 at 09:50 +0100, Karel Balej wrote:
>=20
>  and I use iwd

This is your problem, the wireless stack in the kernel doesn't use any
kernel crypto code for 802.1X.

I suppose iwd wants to use the kernel infrastructure but has no
fallbacks to other implementations.

johannes

