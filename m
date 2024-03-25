Return-Path: <linux-kernel+bounces-117529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D5988AC3C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3512E75DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71EA6CDBE;
	Mon, 25 Mar 2024 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rREXc2X4"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DDE6BB45
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386039; cv=none; b=Dr0CvfG2bypTszAiyupV15D4j9xqoh+YT1waeeFPKmXQv5ABwj6w+jEd4/EvIA7p/IZD/f4F3V6l3Z/iqip6i0jS9WfJrMxrueI8fWyq6+SKCcnTxiOVcZ/aAC8p51jXYJkTdgu+TRT6A/183iHobHtAx3TPIL+8V9TWy1BiG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386039; c=relaxed/simple;
	bh=7zx8nMq8KGqHj7jDtWixIxCbZWOIEZBEwuQCfPP3n30=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s6Yo9JvDXTdxHYTsZ64nWKNXItdOaSdy+yKdc8knxEILwarHW9BD39FHyaX3dD1PwwksI3WdzZ7IrWRk27pXC2RW4LDFyo59dgyZEPhYLycomsFWIqfaKVJiXHQ0+SBzhW7vhccnyQ3Ixyw9naDpw1XJct6ayqtsIX869w7h4Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rREXc2X4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OmH/+e2Fjmgqpw97wDc7uUt4UReDSV3J7Dkv6kUBSXM=;
	t=1711386037; x=1712595637; b=rREXc2X4l+vWTMd0xUXBhNSly5LuUTXec7JPC2ZX1znBfw+
	w8AAm73k1iwC1h6HIcj7CNt/SnvbzyKUhNYGNMvpHY83+XnramRhvxWksnlf3cKCFbdCDPou2DGYs
	9XsIyzHFK+fwy5hi08Qbncfdiv8M4v5IHhWQV13lmYv0LrXT8MoENooEoqaNFdfnzk0zLMIMoFB+0
	bfdPQfVMx2a4pn5Fof84//S+l/7GCgjneuu+gL2DSDwdBwKR4vFLOvgK4eqLqU0iGaX3owa9v5cri
	lH0sCQRlIrXdHsb3lm1y8TMSGuf1FFaFfcWJXL59yRoljSrCYpa3pK9vF3OAEtkw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rongX-0000000Dy0B-3sYf;
	Mon, 25 Mar 2024 18:00:34 +0100
Message-ID: <50c40ce746f1497cbc36ad82d6d0d3ca3ac28547.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/4] devcoredump: Add dev_coredumpm_timeout()
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, Mukesh Ojha
 <quic_mojha@quicinc.com>,  Jonathan Cavitt <jonathan.cavitt@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>
Date: Mon, 25 Mar 2024 18:00:32 +0100
In-Reply-To: <20240304143905.52740-2-jose.souza@intel.com>
References: <20240304143905.52740-1-jose.souza@intel.com>
	 <20240304143905.52740-2-jose.souza@intel.com>
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

On Mon, 2024-03-04 at 06:39 -0800, Jos=C3=A9 Roberto de Souza wrote:
> Add function to set a custom coredump timeout.
>=20
> Current 5-minute timeout may be too short for users to search and
> understand what needs to be done to capture coredump to report bugs.

> + */
> +static inline void dev_coredumpm(struct device *dev, struct module *owne=
r,
> +				 void *data, size_t datalen, gfp_t gfp,
> +				 ssize_t (*read)(char *buffer, loff_t offset, size_t count,
> +						 void *data, size_t datalen),
> +				void (*free)(void *data))

nit: looks like you missed a space on the 'free' line

I don't think we'll actually _solve_ the discussion of whether or not
this makes sense.

I still think it's a bad idea to hang on to the dumps in core kernel
memory since they can be big (I would've said ath12k is big with 55MB,
but Rodrigo said graphics could be up to 2GB!), without being able to
page it out, etc. That's just a waste of memory, for what I don't think
is even a good reason.

So dunno.

However, I also don't like to exercise any power that I might randomly
hold just because I happened to write the code in the first place... And
if you want to shoot yourselves in the foot with any of this, should I
really disagree? I feel I've voiced my objections enough, and Lucas has
also tried to find ways of making a userspace implementation work for
you.

I'd perhaps argue that the documentation for the functions should be
more opinionated and actually recommend against using a large timeout
(like you want) for all these reasons, but other than that, the code
looks fine to me.

johannes

