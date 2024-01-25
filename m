Return-Path: <linux-kernel+bounces-39136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337DF83CB4A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09682916CC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3701339B5;
	Thu, 25 Jan 2024 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hfPIS3KF"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453F11BDD6;
	Thu, 25 Jan 2024 18:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208012; cv=none; b=fdohhGciMGH/iFwPkFA+NUIf7erkVjLhTn6OMnOdxD0Mo8+R6iEil7NbEGt5oSG/lWjeP4lEiYkusegYGE5qUpSKEMZvRi1kQpAzK+hA4Qc4bMUdoxvJNtAGQeZxF+u0/kCxWyZBQLgBe6ojN4zyyjmMPJ6RHe2gp76nVFaLiw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208012; c=relaxed/simple;
	bh=gPo85dRXsQng8Kc2yz5uMF26Tfq8l5cUAj+CcLKGQZM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QCnBBxoHI6wTyCHRsUsLNeIUcL9t8s3f4wW1ygskiLpks78Au9oR8icUptf2zyyuuU1FO/T2CjYoRPTqgPpHLMM5zc/HtcxCkMVhBCnJBMAk5tKm3H6plEGVf9QH9E+x1kE4HN8qPIUU+aARJPJjBcBHUSwHLsdHDG/vHW7/Tpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hfPIS3KF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gPo85dRXsQng8Kc2yz5uMF26Tfq8l5cUAj+CcLKGQZM=;
	t=1706208010; x=1707417610; b=hfPIS3KFkiZUT6fwHEAiuWt+vuojHboyy34m3+TCnngS5qF
	NqjFxky9pnTXnj1XLt2QYhr7akZZEKhsY/PPgqLHZiIj4C6ijqt4WgQmA+voWsww4fNUc8/ajkUvH
	QOHdfKGeHyUntUHTKiCuIuKIqGdeUhsEWWccErN5gcn2azkUgxeh9wHjQFue/7x5J1sTD3037cBBm
	idCU8VUuhT9Mb4lAePC1yc9Ogx/gXW3FTZ+Jb6E8Bo/BrcVlBD2QhwaZKCzXSCAlTilVyn1nARude
	uZQEvFEap7Ul3XmhZ32fLV/UNUMcF7GiRQSo8QmrBL2iu04uGf1kQJPwxN6i9uVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rT4dr-0000000028p-3cQ3;
	Thu, 25 Jan 2024 19:40:00 +0100
Message-ID: <008b0c43d963276453f4913da0fb95fb29e5d4ff.camel@sipsolutions.net>
Subject: Re: [PATCH wireless v2] nl80211/cfg80211: add nla_policy for S1G
 band
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Lin Ma <linma@zju.edu.cn>, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org, kvalo@kernel.org
Date: Thu, 25 Jan 2024 19:39:58 +0100
In-Reply-To: <d49f69f4-7f5c-498f-bb17-a636256d3245@quicinc.com>
References: <20240119151201.8670-1-linma@zju.edu.cn>
	 <9e1db7f3-fd18-4b3b-a912-3cf6efd96fed@quicinc.com>
	 <590fe2823d934af997c515640733eb8889b0560f.camel@sipsolutions.net>
	 <d80ae6ae-e1f2-48ef-b18a-29b5ca62e64c@quicinc.com>
	 <d49f69f4-7f5c-498f-bb17-a636256d3245@quicinc.com>
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

On Thu, 2024-01-25 at 10:32 -0800, Jeff Johnson wrote:
>=20
> OK, I have investigated this and based upon the investigation this can
> be removed (except for keeping the now obsolete uapi bits). This was
> done in preparation for supporting a new Android interface in the
> out-of-tree Android driver, but that interface was subsequently
> withdrawn by Google.
>=20
> Johannes, do you want to handle this? Or should I?

Would be great if you could send a patch, thanks!

johannes

