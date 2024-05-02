Return-Path: <linux-kernel+bounces-166697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D80C8B9E48
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5521C20506
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1351115D5D6;
	Thu,  2 May 2024 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kaAaIGbU"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9215359A;
	Thu,  2 May 2024 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666391; cv=none; b=bt7XuG5yohVYeRH/o7Ty4sI657roZ2oZx02C1h9tFCOZfDM5fzC6zxfC7BcrJ0zcyb1OEAAJOEhoeZ3pqY/yk7vsqsvw/0YkUYnkWZ7y9ntLe9CsOtlGVUCmLTYYJsYeB9ZFLqR70qWVvWO5r4r+GgS2JL4eDW/oneoB61mHlko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666391; c=relaxed/simple;
	bh=3ftJAFzteXGUrfe+KMXY35rqWKZoRTdjLJlVvybiFH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sLJtkghzRaaNsUXZIiWwE0nFk8ZXzntVow3OtWa+MPkcBNc20GPjNrwXKRBgogThx1cPHeYR0Pt1DG7UtYEtoNdUlSv6m8F+NFepRClm5RvxtjYEycXwW2TWDajQG7LpQVOaoZeaFsBlnzSNOidO6cpntojNuit9DTqOmvopdoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kaAaIGbU; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5C7F247C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1714666389; bh=3ftJAFzteXGUrfe+KMXY35rqWKZoRTdjLJlVvybiFH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kaAaIGbUKdWbTUuTDlsr4IdH4JxM8p8ceGS2+/5tPCabcecisXJUCTNeg16WuPYtN
	 CSnbMKnoc6WwU+WCxpHQPbYM5rPV8fKWf+n/aM24icKhqC2dH5TyrqLqa9YkFo0fPw
	 7b10BXa+Yw3Zty59Y1tSup/KN1HZSkISMejiVSjBAC355it6HngZUiASHuoL/R1/Jy
	 TMhxyu4JbobQ0PloddCM5asvKLXEo5oyg+Ept3fJl8cn90wfu/zUZxgcMWErI86Bsw
	 OAImw71TfOzeL5278AKJe5c73e7JViCHUMG4XQi83SJWZJizSvzCs1VhCRi4gwGrSc
	 dJN8z3KSSXGSA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5C7F247C39;
	Thu,  2 May 2024 16:13:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] docs: stable-kernel-rules: fine-tuning and 'no
 stable backport' tag
In-Reply-To: <cover.1714367921.git.linux@leemhuis.info>
References: <cover.1714367921.git.linux@leemhuis.info>
Date: Thu, 02 May 2024 10:13:08 -0600
Message-ID: <87jzkc6vl7.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> After a recent discussion regarding "do we need a 'nobackport' tag" I
> set out to create one change for stable-kernel-rules.rst. This is now
> the last patch in the series, which links to that discussion with
> all the details; the other stuff is fine-tuning that happened along the
> way.

I've applied the set, thanks.

jon

