Return-Path: <linux-kernel+bounces-158727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91728B243C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3131F234B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3240D14A4F7;
	Thu, 25 Apr 2024 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOAaRv2w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752AB1494BA;
	Thu, 25 Apr 2024 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714056127; cv=none; b=Ziry5HUc4yE+nLaTLwz/1QwQtc55CgCyAzTHuiwfVGRLxYaGbVUhEEncrquIiUAW5TrWefU85DrPCHXrA/6c4kc9sUU1W8e0ntvQ17wEXrewVu+JgnYkWw0mtjD6vtnThl1v9EthfdpsQf4JBge22gNsHbnNd1Co3//R+PbBuPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714056127; c=relaxed/simple;
	bh=mTFoGyws6kpRq4o32kSDr7jpMe6moKYzAN96ttfnxA8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l52oSqZeM2zwXd0cm2veDfh57jyr9djjERmIg5qeyWDs8DguoRgHoq7WN1N4EuH1rUUA00mtS+GDCu6AATL0GyUdwSMBBdUST1Dw7lSgivePQC6XXnzVUZ62lzYMSb60mrszxdRrB9G37EtxstZVBFu4pcLSXRS74974vKtlWr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOAaRv2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773F9C2BD11;
	Thu, 25 Apr 2024 14:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714056127;
	bh=mTFoGyws6kpRq4o32kSDr7jpMe6moKYzAN96ttfnxA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tOAaRv2wU36NV0wM7C55Y3ZO9KzXigzhxS97uKbvXLOKL/RzkTbAf5Y7fFfSfKaF0
	 ipFWywEpRI0ocsxmHGonNk0RwwP/80qdwA8U6MnYJns9qPKW16+oPNanRJzzWoMnFn
	 ikcUl7PYL0FjgTapi93BtGP0nZsu+Cv59IWnsy4V4Kcz38qztAiSPjagvt39W3mFZ4
	 m0ymFBK5aPIlQOT5Hf8BYtx+5CSrYDcn8vaWZocSApeBr9k8rpWOTYqEZpOjPe6l5z
	 lA7/VUDh0dApLGAG9ntXkbODsBx/c+lgSpm1TUWNO9qQlLdJ38MwKsCtsXgaMigNcf
	 d5ajRFjwpGz1Q==
Date: Thu, 25 Apr 2024 07:42:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v3 0/3] net: pse-pd: Fixes for few small issues
Message-ID: <20240425074205.28677540@kernel.org>
In-Reply-To: <20240425163002.5894c5e5@kmaincent-XPS-13-7390>
References: <20240423-fix_poe-v3-0-e50f32f5fa59@bootlin.com>
	<ZiebQLdu9dOh1v-T@nanopsycho>
	<20240425103110.33c02857@kmaincent-XPS-13-7390>
	<20240425070619.601d5e40@kernel.org>
	<20240425163002.5894c5e5@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Apr 2024 16:30:02 +0200 Kory Maincent wrote:
> > Could you experiment with tweaking the posting?
> > Maybe we can "bisect" the problem. =20
>=20
> Do you want me to like post a v5 with the "pw-bot: cr" tag? But if I put =
the
> tag only on the cover letter it won't work then.
> Maybe on all patches?

Probably not worth posting for a test. I'll try to be more careful when
applying in the future, we can experiment with real postings.

> Was it the same for the PoE support patch series?

Yeah, I had to apply that one manually.

> If so, we could look at it with my future patch series that will bring new
> features to PoE.

=F0=9F=91=8D=EF=B8=8F

