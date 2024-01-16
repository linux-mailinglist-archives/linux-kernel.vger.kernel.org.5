Return-Path: <linux-kernel+bounces-28305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B33A82FCC4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3EE31F2D43C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D065F859;
	Tue, 16 Jan 2024 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vO2rxY+b"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5CD321A1;
	Tue, 16 Jan 2024 21:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705440672; cv=none; b=mXxW5nXdTvfE+1I8FMer/U/4uByOP/qAt++6dPGxUsnlxu4WV+Ri2Wi+eoJdaMC5ulj0sGGHHrSS+acQwHEgk+MfC47igSZKTgHCG+PDGCzxtPv8Qcnt3lZnzeS5N3SCyQ3UWM3+kORrBVlLOHeBuEANqnW530avkLW+Gu2mwNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705440672; c=relaxed/simple;
	bh=hHPKadB+cxGf+RWYJqcFbbEZwSR0CmuDiJSds3CMh4w=;
	h=DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-malware-bazaar; b=LL1psvRj7zdzzfkqXjF8WwpX084ifHTa+TtuD6BZQSk9mnivz+Hde6GNnhunx85fiQmxxnm4STo5OPYIITHAyR9sHnzArMVmCtU0CNo8uTiNBFgaD3K6/lyulKaPD3ClcxNwI/Iasy5uSI9XAblSIeA7+kM6nK6jIXFFQrzHxfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vO2rxY+b; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=hHPKadB+cxGf+RWYJqcFbbEZwSR0CmuDiJSds3CMh4w=;
	t=1705440670; x=1706650270; b=vO2rxY+bfI6lw5xOkXUi3qxqxmGRq/eOK4awugXKqwG8ax2
	oq+Vq+s3A2y0qJX/tekS7mjpgyVdDOoi9utoeisOKqObpjNlsLhwP8UUm30be2co/0V2pUQbL+PIJ
	wxINu6FSKWmIfvtVtlptux4/aI+Ual5hy5REfQ262eVH6JNRzID4OsE8FgLMXWEoWlFSoZL4r7oat
	IzkDai0ARHLtsLl4PPFqjRjv+ys3kz52GdNGlpV7NKcv3a6hM/K2+1AZpulstSz0KZNRb/e3dlve6
	BuWazURd0elYGfAireFCx9dPcj/CH4olYjFgzHoHdC2Xj9bb435EaKjQvNzG5q7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rPr1W-00000005JF3-2LnA;
	Tue, 16 Jan 2024 22:31:06 +0100
Message-ID: <63299fa2af7ae5610d270851a772fcca4ba39c48.camel@sipsolutions.net>
Subject: Re: [PATCH AUTOSEL 5.10 07/44] wifi: ieee80211: fix PV1 frame
 control field name
From: Johannes Berg <johannes@sipsolutions.net>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Cc: Liam Kearney <liam.kearney@morsemicro.com>, Jeff Johnson
	 <quic_jjohnson@quicinc.com>, linux-wireless@vger.kernel.org
Date: Tue, 16 Jan 2024 22:31:05 +0100
In-Reply-To: <20240116200044.258335-7-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
	 <20240116200044.258335-7-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-01-16 at 14:59 -0500, Sasha Levin wrote:
> From: Liam Kearney <liam.kearney@morsemicro.com>
>=20
> [ Upstream commit d3ca4ab4f16eb81dc3e7721251adcba49b229d54 ]
>=20
> Update PV1 frame control field TODS to FROMDS to match 802.11 standard
>=20

Not sure what the point would be in backporting ... this define is
completely unused :)

johannes

