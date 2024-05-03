Return-Path: <linux-kernel+bounces-167400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 826978BA906
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390D91F2193F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F4A14A097;
	Fri,  3 May 2024 08:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MX6LMJWO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEFF14F9DC;
	Fri,  3 May 2024 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725705; cv=none; b=YqtcDoMI6jVJtushMcSAJDYYVA3xNBh2Lio3FIMXoIrMOdK8u696JoawMZRVlBa/mFpGlAGi5lQ/ZN14SlUkaxiDSHE+nDbcrhrHx7RrenOCnJQ+QLd5gfAmutnf3ImmcnHm5o8fw1O/GHTDSGqnuWZazcz0tqBPMjX2fuNYlUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725705; c=relaxed/simple;
	bh=W69xgXC3xL1qD328FsH2Bn3aVb/I3Y7DWq/sG4PLpOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UunBcqTD9weuw5i1vGEOrvf7oX9B2sY5MEtz44cJbQFGT6GbqHBYnz8XEykaNLFxqb7pAWRpXJxBl52efGlz+3PVKpCQVDO4dB/6Tg44XHSbm5VFatFbok5FgcWojB646pNlK9f3F42t3C00CyG3dnn+Z2g2zXFN/GAUEgaQY9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MX6LMJWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131ABC4AF19;
	Fri,  3 May 2024 08:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714725705;
	bh=W69xgXC3xL1qD328FsH2Bn3aVb/I3Y7DWq/sG4PLpOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MX6LMJWOsj2HpakEDhG6oQQlRQNVnt4sTrZXlgZMUHSPA5BP21dzndYWkV2jSZE5C
	 JpvZirb8+T33lBn1eM61891V3/LxhM4vVQgj51kQoph+TegI0zaiDADJbhZzIMT+ec
	 brpiL9QXnyYv+UJZXd4l7vm1Jcwy61HZ5C1oPX94+j5kj/CXUOIm3j1pGkch8fUpK1
	 pHfv69TYCvZuhVQORz0MtqiBT3bc3AOykKi+5NCA2PgEySUWsyacYUxtZs6ETskytx
	 8Gq4s3BywSQvei9ruOy5ZLE4llo+gDSnjL8mccGOLxbaOhvNZSnVLGj25gPKwM/sWy
	 GbizqQv8cEb/w==
Date: Fri, 3 May 2024 09:41:39 +0100
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] dt-bindings: mfd: Use full path to other schemas
Message-ID: <20240503084139.GK1227636@google.com>
References: <20240503072116.12430-1-krzysztof.kozlowski@linaro.org>
 <a2886f72-210e-41a1-aae0-c079a4d11396@linaro.org>
 <0af10387-ddfb-47b0-b59e-eeba1644be1c@kernel.org>
 <20240503082444.GJ1227636@google.com>
 <72f94454-867f-4a6c-90c8-134db2ce150e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72f94454-867f-4a6c-90c8-134db2ce150e@kernel.org>

On Fri, 03 May 2024, Krzysztof Kozlowski wrote:

> On 03/05/2024 10:24, Lee Jones wrote:
> > On Fri, 03 May 2024, Krzysztof Kozlowski wrote:
> > 
> >> On 03/05/2024 10:08, Tudor Ambarus wrote:
> >>>
> >>>
> >>> On 5/3/24 08:21, Krzysztof Kozlowski wrote:
> >>>>  .../bindings/mfd/samsung,s2mpa01.yaml         |  2 +-
> >>>>  .../bindings/mfd/samsung,s2mps11.yaml         | 12 ++---
> >>>>  .../bindings/mfd/samsung,s5m8767.yaml         |  4 +-
> >>>
> >>> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> >>
> >> So this should be Ack. You cannot review part of the patch ("I have
> >> carried out a technical review of this patch...").
> >> https://elixir.bootlin.com/linux/v6.8-rc5/source/Documentation/process/submitting-patches.rst
> > 
> > Reviewed-by is totally appropriate here.
> 
> Submitting patches is clear on that:
> "A Reviewed-by tag is a statement of opinion that the patch is an"
> Not "the patch or part of patch"
> 
> And ack:
> " It is a record that the acker has at least reviewed the patch ....
> Acked-by: does not necessarily indicate acknowledgement of the entire
> patch."
> 
> So no, reviewing part of the patch means you Ack it. Especially that in
> git log the Rb tag will suggest entire patch was reviewed, while it was
> not true. Review of 80% of patch did not happen.

I read this differently.

I don't see any reason why only a relevant part of a patch can't be
covered by a Reviewed-by.  It doesn't explicitly say that you can't do
that.  If the statement meant that, it would have used more inclusive
language like "whole patch" or "all of the patch", but it refrains from
doing so.

My interpretation is that the explicitness of the Acked-by statement is
to provide extra protection to Maintainers that only review and provide
Acks for chunks that they are responsible for.

Whatever the case, this is a pretty nitpicky point.

-- 
Lee Jones [李琼斯]

