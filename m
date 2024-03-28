Return-Path: <linux-kernel+bounces-122596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6451388FA3C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD3329541E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84EB50279;
	Thu, 28 Mar 2024 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hSBAOKSm"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C238396
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615605; cv=none; b=VdeRv8ACUOEAY7bxFPApzeeAuTu7KeAA+JGgNHdy9SJOV/DNcOUIoTzrfjuAZBJdi7e89FAhuRE+Bsx1NStUsE+kynbY8Oj7+IAtZY8vV4e+CKabMJYqLkGVU6e7UDVXk1Agj2e0TA8V7t4wbOWduHInuF72OySdi+PfkUQ+ZuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615605; c=relaxed/simple;
	bh=TYFqbUHOJ3/hT9xWTRUIGd5P6PahnEHSypeL9bbT9Fk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pGFxi6hl+iaJM7E9Ipq7VOWKgexMp7eTMpjZODgDcwK/uVE/wskL1ZeHlT7PCN6c9aW0AuQUmSFaFpeEYyJPXtqdNuXHs1B0uuejpo+szd40vwOsF5DEqiePuQwjMF8v4JySq/y8g/QjA0upShRX2dR5L9Fbbxfp7CA3UiS0fCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hSBAOKSm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TYFqbUHOJ3/hT9xWTRUIGd5P6PahnEHSypeL9bbT9Fk=;
	t=1711615603; x=1712825203; b=hSBAOKSmmjauuyTNEVWKak+hnMgmYT6Y54+Ldg/PqcyNW9m
	I5YBfCpmJBWJ1Yo5xrsi3afGO5QMKqjGweRxZSuQg9MKDUvP3drP+frY2Gf+0JYjh8lH/VjoAnoCD
	kyn1Z/ACMoC00OvnnuhH2xgXchyzZDOXuthL94jVEqVU8CvNhmq9g+F3QEfuOo7cFPQLEy/Q23cbm
	BVxgnfZzdauHp7tIZ0tJDC60Kf55Nk7nI3I4M+zDi3JqgWv9JjLF/oFArak7ZMaRzw07Ik2Dv7mbe
	Sfx+ZfQW+fG0hURizjmgc3P5VN9TVVJQ4bG2VqQlRJC+gCZ586its2CA/uKlu18A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rplPC-00000000nLU-0aP3;
	Thu, 28 Mar 2024 09:46:38 +0100
Message-ID: <9577110df4512a82dd27af0f831b569b502fe528.camel@sipsolutions.net>
Subject: Re: [PATCH v3 0/9] um: Minor fixes and cleanups
From: Johannes Berg <johannes@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com
Cc: jani.nikula@intel.com, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Date: Thu, 28 Mar 2024 09:46:36 +0100
In-Reply-To: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
References: <20240306101925.1088870-1-tiwei.btw@antgroup.com>
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

On Wed, 2024-03-06 at 18:19 +0800, Tiwei Bie wrote:
> A series of minor fixes and cleanups for UML.
>=20
> Most changes in this series are very straightforward. Please consider
> picking this series for v6.9.
>=20
> There are still some remaining -Wmissing-prototypes warnings. I plan to
> send a followup RFC series first to fix those warnings.
>=20
> Feedbacks on this series would be appreciated. Thanks!

LGTM, thanks.

For the series, including 8 and 9 that were discussed before
(but Richard, feel free not to add that individually):

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

I also did build-testing for this, on 64-bit only though right now.

johannes

