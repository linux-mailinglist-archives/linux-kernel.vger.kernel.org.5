Return-Path: <linux-kernel+bounces-160597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 280C88B3FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D0BB23210
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA34011CA1;
	Fri, 26 Apr 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNh9Wzv7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DFD224D2;
	Fri, 26 Apr 2024 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714158439; cv=none; b=Gx6ouxwSPxYlXNb580haSBxv5IXWEmoI/IhA9fTWrECThzavGlyQHiGFAMclSX9R0gT4QK30QOEcT5OHsaHev4xJh7HY15rAbiAbQKEAorD/iBzT/zEzXTajbpuUyNAO46BSX2J/osy5rFDMvS+tNRFi+gJJoYel+Fm483Mc4VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714158439; c=relaxed/simple;
	bh=kFCVen7MFJA35K6YKbUhEnZic7BvetDT54NLAcixGoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcZeC1oIAAG00Ux/lcrWor84xZvkjvDNQDaEQKEcRup6sAGNCycbzUxajVHLFOn5kucuYbaTCS2bUFfI0eOZB7rtmQNflZsc2jQ2wGFHFt8akpCjDH5VMHMbvinShztjBzNAKGNnZVWnWUO52qw8YPzxg20p0bjKz+Zaaqp3IP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNh9Wzv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ADEC113CD;
	Fri, 26 Apr 2024 19:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714158438;
	bh=kFCVen7MFJA35K6YKbUhEnZic7BvetDT54NLAcixGoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNh9Wzv7VhK0UWWL8MC54sUtMJQxDX4Z5f6ODx4LUzvChFe1rTrN35R+xL55naEcN
	 UIC6TzNBzUoRBibjPlUSze1hsgsVorsm/2PPZtc/iKmjfGaOSsTwap2u09sQths32N
	 93+cpMnDGCoRFkccMqdizOwlNSF5yIWnuvgijC5W3TeyN81W0hXaGEwXv6KfYYD2WR
	 xDWLZnD9cgZVNZpwQ9NjB4zE931+bTplMvkPsYw5e+MaGR/cJBZvL7nsmmmWJWTbkg
	 vPTj0l7RXD9NTeipLhKPFpaHqWj+pZKwxBwbGKYtR/ry8qKB5cLauUWy/aOpLaHRh0
	 p2Et9ljsKgPiw==
Date: Fri, 26 Apr 2024 14:07:15 -0500
From: Rob Herring <robh@kernel.org>
To: Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc: andersson@kernel.org, jassisinghbrar@gmail.com,
	devicetree@vger.kernel.org, lee@kernel.org,
	konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
	conor+dt@kernel.org, kernel@quicinc.com,
	linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	krzk+dt@kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: mailbox: qcom-ipcc: Document the SDX75
 IPCC
Message-ID: <171415842070.2640773.96854760213793283.robh@kernel.org>
References: <20240426055326.3141727-1-quic_rohiagar@quicinc.com>
 <20240426055326.3141727-2-quic_rohiagar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426055326.3141727-2-quic_rohiagar@quicinc.com>


On Fri, 26 Apr 2024 11:23:21 +0530, Rohit Agarwal wrote:
> Document the Inter-Processor Communication Controller on the SDX75 Platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


