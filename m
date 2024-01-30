Return-Path: <linux-kernel+bounces-45337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72988842EB5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F961F26EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5BE78B71;
	Tue, 30 Jan 2024 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax/4Kc9n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7021762C7;
	Tue, 30 Jan 2024 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706650769; cv=none; b=hIUltUOPEy9lMe0U6JRNteFIVtj+ary4IlG1dA1I42KwOaLRX7XNYUJymZSesuM10q31eC230Dtc3sIOg/Q9v4epx1Jj4I6pCCDAfgAC+hfLUtadz1VKgZPob9d7aU/mRPUKLwx3A9KfF93S8Hpsa19Qrvu9ZT40H/mKgAAPW20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706650769; c=relaxed/simple;
	bh=QnJojmWW+VDlaE6OIIGRQSTpYr1wBDNCTR++LHwSjp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQcPNKhYBIp7jeWXauwX1UeSw4AiKgS7AJ44Xxvx9QDXX4BIJnBYhoxlptw44RGLk31W5u2oK05gORumfn9dsu6ArYktvBXbRdYQeGa11SZcClVw4KCSUraSkk/SE8z3Veq9SvOM66FX5NecubTPugtan2DxXZpIL6eDUAQftZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax/4Kc9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D55BC433C7;
	Tue, 30 Jan 2024 21:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706650769;
	bh=QnJojmWW+VDlaE6OIIGRQSTpYr1wBDNCTR++LHwSjp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ax/4Kc9nR6ZDT55/zyLOGSSvM4+kKwvgYoGqxGx9Dq5uvnLcgW2f7q26M7Ad85RJ8
	 O/HDC4JpsO9p5uB0gSsYk3eS0L5zuYeeiGYfs8Pa23hbNq1lM7hrUnW45/f5JArl+Y
	 yQg7ur6TRlZLHNThuvaISqKDen/vjZJ6Q3uvxytJg4iuRPCyv6Z5jlTr8pV6AL48qe
	 8aFsvwhsfvp1zgdwdMrgm1kqmNnDvVqmAMtTRYFbqoQ2s1az9fYFFVh/7lW3cCyxJk
	 NwnVsr9QeiDAxy78djw3GhB6iE85Dx8VXXcxcUaDkET7zhaJzAXxI/Ew3zF6cWUFzq
	 EZ7fsI9vdf6qg==
Date: Tue, 30 Jan 2024 15:39:26 -0600
From: Rob Herring <robh@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: devicetree@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: net: snps,dwmac: Add
 time-based-scheduling property
Message-ID: <20240130213926.GA2342546-robh@kernel.org>
References: <b365dc6f756a3fad4dfaa2675c98f4078aba8a55.1706105494.git.esben@geanix.com>
 <30ce8f45b8752c603acc861ebb2f18d74d2f8a07.1706105494.git.esben@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ce8f45b8752c603acc861ebb2f18d74d2f8a07.1706105494.git.esben@geanix.com>

On Wed, Jan 24, 2024 at 03:33:06PM +0100, Esben Haabendal wrote:
> Time Based Scheduling can be enabled per TX queue, if supported by the
> controller.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

This is not v1 which you are aware. Where's the justification or do I 
need to ask the same questions again? Here's the last discussion[1].

I'm still not clear on why this is needed. Seems like the combination of 
TBS and TSO capabilities provides enough information. If TSO is enabled 
for a queue, then don't enable TBS.

This binding is already such a mess of properties, I'm inclined to say 
"what's one more", but it's death by 1000 cuts. Part of the problem is 
this binding is for not 1 IP block, but something that's evolved over 
at least 15 years. 

The question on configuration properties really comes down to who would 
configure things and when. If it's one time for the life of given h/w, 
then DT makes sense. If every user wants/needs to tweak the setting, 
then definitely shouldn't be in DT. Somewhere in the middle? Judgement 
call.

> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 5c2769dc689a..301e9150ecc3 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -399,6 +399,12 @@ properties:
>              type: boolean
>              description: TX checksum offload is unsupported by the TX queue.
>  
> +          snps,time-based-scheduling:
> +            type: boolean
> +            description:
> +              Time Based Scheduling will be enabled for TX queue.
> +              This is typically not supported for TX queue 0.

Make the property name clear it is an enable, not a capability.

> +

[1] https://lore.kernel.org/all/20230929051758.21492-1-rohan.g.thomas@intel.com/

