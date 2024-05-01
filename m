Return-Path: <linux-kernel+bounces-164836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36A18B83C8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2754BB225B5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 00:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D794A442C;
	Wed,  1 May 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="HyrK8Lv0"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92B42F56;
	Wed,  1 May 2024 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714524032; cv=none; b=BI/i8jqyL4Cy9G0r1+Mjd3u+pXiroftoX50K7XWVSmNduf1DdwB2Q7CqEhaDrdjk6ANc5hHG3uO5FNQXJja0AFNkxRD4eSv5KnErwWZtA9YlgDVG56qQMzhpsb2EbfPeGJRAyo4tcZ5jn4mKN5kszQpz9Biz3L3HRUXpe9U2e7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714524032; c=relaxed/simple;
	bh=zJQzXU9x1sjXKAGpnk6eIjFw7BY17yTk/9bUubCsTik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IldyqrwExevhH0PWZCxqbebXsOwy0/Slk/8tB3fKzsxnfNkEGdP/W6ybsfSo7a+VIROTvP4zW2ftlLlmWyho9FTzQJ3v82gc/tVnKWe6AMGwi3whI4LDse+xJjpcCy3A00uYc2HnjyjizYW9bUTfk02uFwKmRZy/d4nxgjP9CzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=HyrK8Lv0; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-127-66.adl-apt-pir-bras32.tpg.internode.on.net [14.2.127.66])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id ED9612019F;
	Wed,  1 May 2024 08:40:19 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1714524021;
	bh=zJQzXU9x1sjXKAGpnk6eIjFw7BY17yTk/9bUubCsTik=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HyrK8Lv0ghgtTtEIOZHMO/90+vGKuDV9vztOw6uCkQ/eDojtTkPWP4lAr+IFS2TvG
	 +T6Hyj5GQSkxkLejts2s3gOJKWNJP/j0E7qOqW70G7HdwhTCfb7IvQO4csBAgLDCsm
	 k9hjiEz3sENbg8Z8GzkTxdmGlyRCafEcqWce5jzUKzn0ptzWMBQk2DqT2FGHtSc/k3
	 Mt3jMgi4OZi5R4pFWOt+IjCkuGYCg01gDJmNB4bgDKkITtG61ZvJniPBuaNkGvFoFs
	 6IdLF2aR1hH9k2pF2XNOlb24VVhmzoCEubuMLXygYEM83HGHqdkJvB1rNtXOAyt4nh
	 hO+BFeDAquOxQ==
Message-ID: <4f3ce3439e3d996471085e906902e508528308d3.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: mfd: aspeed: Drop 'oneOf' for pinctrl node
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 01 May 2024 10:10:18 +0930
In-Reply-To: <20240430172520.535179-1-robh@kernel.org>
References: <20240430172520.535179-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-30 at 12:25 -0500, Rob Herring (Arm) wrote:
> The use of 'oneOf' to include 1 of 3 possible child node schemas results
> in error messages containing the actual error message(s) for the correct
> SoC buried in the tons of error messages from the 2 schemas that don't
> apply. It also causes the pinctrl schema to be applied twice as it will
> be applied when the compatible matches.
>=20
> All that's really needed in the parent schema is to ensure one of the
> possible compatible strings is present in the pinctrl node so that its
> schema will be applied separately.

Thanks, I think it improves the readability of intent in the binding as
well.

To understand the impact better I grabbed the patch and diffed the
output of `make CHECK_DTBS=3Dy aspeed/aspeed-ast2600-evb.dtb` before and
after applying it, but there was no significant difference in output.
Should that not demonstrate the errors being cleaned up? If not, what
should?

Andrew

