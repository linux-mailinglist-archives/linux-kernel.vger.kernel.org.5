Return-Path: <linux-kernel+bounces-167348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162988BA84D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478BC1C216C6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116CD1494AC;
	Fri,  3 May 2024 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="eov5fYZN"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE01219EB;
	Fri,  3 May 2024 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723621; cv=none; b=e9noQ2/cVfBmIyJRrh6E7Z/aG5GKo+nVW3UfvLEGB/XNuQkhqmeSX27kZdtGiDVi3vgY5xUUV9J1WqmzJWQ75+/tvBga26u0Kh0xjYrP1wSgPwq+qPUnbpn5g46Jsv6e7/DN0cIg5ZFcHLwwBbcyBb6ggj4S+xcMmEPgTvw2fc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723621; c=relaxed/simple;
	bh=GGQX2wHQOVm/+zK1zQIO87019NNPBzj63uLs97gm6x8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uWIPCXwH2453+F94W4PIgHuSC5pkuJp05rMcHGGli0QWM5E7lB1hlL24fyi6h2TBS1G/4ILovlxTw42r+go9hdk5vvrJw6i785jb4GcnZqImqaauyAEVMBURQrVdOjDUTnWbntzJQO1j32hR0U9z38jgkBPpOr10H349krar8ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=eov5fYZN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GGQX2wHQOVm/+zK1zQIO87019NNPBzj63uLs97gm6x8=;
	t=1714723617; x=1715933217; b=eov5fYZNHw27GvCfaGFuQekWwOVkBH+qbDd85o7VZ7N8aDE
	9xwP8B6pRQW6jvMcB0o//64rDWZdblINrqjUAFF0Qd6+Eg1W2I9tcKvCByCcSnhBPiHCb12asqjqA
	VKDLbjHsxxgttMPlrtUzxGiz67asP4oMk2FTTg2WkII9hR48fmnKwbKqc15/bNFT8onmV27kegV4P
	ECi3M6DSYQ3KX68EgJYfFiZrtg0owOvHL/1+nVCYN1i7yn+2mUKZOJd6t0jnx0h5E83PbsSC7/T6I
	xZjYzQgqxlfnwqOcA04dOAPk3MwnXO0xo0BxHYElWyS+B3ALdzkY9j3kHlKoUFyg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s2nwU-00000001eVj-2U0U;
	Fri, 03 May 2024 10:06:54 +0200
Message-ID: <1a1f727b5ad30fd967605b1b1dc86da0d3b6824c.camel@sipsolutions.net>
Subject: Re: [PATCH] wireless: Fix typo descibing to describing
From: Johannes Berg <johannes@sipsolutions.net>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 03 May 2024 10:06:52 +0200
In-Reply-To: <20240426132911.16255-1-richard120310@gmail.com>
References: <20240426132911.16255-1-richard120310@gmail.com>
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

Please don't send two patches to effectively the same line of code that
conflict ...

Also really no need to send each individual typo separately.

(I also don't really care much about that file, but if you wish to fix
typos in that file, please do all in that file together.)

johannes

