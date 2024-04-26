Return-Path: <linux-kernel+bounces-160600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4578B3FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 236B5B237C2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F819219E1;
	Fri, 26 Apr 2024 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIdRoWWR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4520DD3;
	Fri, 26 Apr 2024 19:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714158487; cv=none; b=Qbw+LhkZGOM/jmu+x7oWwziFk2DgsArwDPH+JfCz/bw5AzjvMFzij/wOUNEd8oS4n0y5n5psDgFh+AUiL0QKKykLWXsKoNp5tDoKLAAhJmHr12IlWk1BXp6oZqqk6nWDBymo5HnR6McRQkRVvy+HmurTZETdBOza4vYiMq5ohig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714158487; c=relaxed/simple;
	bh=J0bm1XiiM+tKHo9Zy6ObIpyPXXSSYQFpIVKVA8D2znE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tt/vGeMbCycc3vg+cILRbzKXlwBQ0yEl+hce4dL3P9QJBRItN17cRA7n48380D1/m9e3KF1nIMX17WnnmisBNFz/lvRkhHmiLM46HudhzfZtn3YdWk7hX5GGS5SbtUAbIEEN/lT/r5I9f9bzDl0aqhiNY6XuIt7valfhnNOn8pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIdRoWWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1603EC113CD;
	Fri, 26 Apr 2024 19:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714158487;
	bh=J0bm1XiiM+tKHo9Zy6ObIpyPXXSSYQFpIVKVA8D2znE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIdRoWWRaAKveDW96bra4dLZXF2z/txwTGcg0L5F/OmAfXGheRui0URjn3gu+BaSb
	 EVwAWIr5lGglm64jloclMCJpUN5kL7QOX62WH2bOcIJHRSjYPp6DILWryYwDgkSdnu
	 waOkZHOqfJpFkAzaJGkFe69T8ZoewrD4WeZXM58GKo/bccBZOlyKCs23lOYv9LGlXl
	 OXgOXOkgaB/ngTsk6fBb3lhb49hPsAFfmGb8B9ZV4ujEv7oLVP2sGP0R1CIgat2mQG
	 vJ1dmTy3TXEULIWhBmncoDZN3wOrMQx+ILY0byo2/aVfQ3uCIpK7vDSaB6IHBWBKhx
	 OKr7TGknMJTLA==
Date: Fri, 26 Apr 2024 14:08:04 -0500
From: Rob Herring <robh@kernel.org>
To: Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc: andersson@kernel.org, lee@kernel.org, kernel@quicinc.com,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
	conor+dt@kernel.org, krzk+dt@kernel.org,
	manivannan.sadhasivam@linaro.org, konrad.dybcio@linaro.org
Subject: Re: [PATCH 3/6] dt-bindings: soc: qcom,aoss-qmp: Document the SDX75
 AOSS channel
Message-ID: <171415845909.2646970.9861178013586174124.robh@kernel.org>
References: <20240426055326.3141727-1-quic_rohiagar@quicinc.com>
 <20240426055326.3141727-4-quic_rohiagar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426055326.3141727-4-quic_rohiagar@quicinc.com>


On Fri, 26 Apr 2024 11:23:23 +0530, Rohit Agarwal wrote:
> Document the Always-On Subsystem side channel on the SDX75 Platform.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


