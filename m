Return-Path: <linux-kernel+bounces-92547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDF68721F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D181C218F6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67228126F0D;
	Tue,  5 Mar 2024 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aroaaLoX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ADB86ACB;
	Tue,  5 Mar 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650238; cv=none; b=Ym0HVoDo73he6keRDVfZLYGfx8RuMxepDC7HZbyvEVxdD/p0yJrDhhwKGv58PJZ/DwqrJ0MR1zaIZe8KUxKO06i4NTC+d4k1KuBUG0asYCNeiwc5WtDefu7yzbi4MerrpWb+3KNYXt35NYw2IYw/tfEJuetN//ePbpP+FJxkSMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650238; c=relaxed/simple;
	bh=VXWAauPjX6FDLOS5GEMcjByztQdG+D2U02KicMz1li0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnRMB61nUmdpKo+BM6rdfS6M4elWFfQYzOXai7inDSDUMLONNyTHtEGlCVE2sxmRNh26RBYAMGSsRBihP4dCfzZUAPNTw2hzcEeFA8uCQ2FRpiBufuruNWETQSXH4qHVQ4ixMgdTArEZZi7D4spQuoHoAY8hkC1oLJRVewrGC4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aroaaLoX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC40C433F1;
	Tue,  5 Mar 2024 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709650238;
	bh=VXWAauPjX6FDLOS5GEMcjByztQdG+D2U02KicMz1li0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aroaaLoXlsoirx9FFY8ogRP7Q7XTLn/uH+JxdK6t/5yhLYKoRFZg8/J1VqSyDN9Ap
	 3ZtVk+2EufojdutiFWwBzH5etqr05XbkzKTkSX/DbRHW4VwFEvOCLSjVp0ziZv/hyL
	 Zw8Xhd+RnK1lTj8hrd6ZGYCbq5D5iQTLdkqLJo0P+bMh68p8knppuXSZaK0uyp4Dxm
	 m5ptUVVJYmVZinsZiODsWmN4YT2qVCkBnnSkpBXiBp/EXJE+M7n6lexqKrmdwoHszS
	 rZExK6O8qtNvqh++NWqFI5pw6WD7k2JHeKT2BdghRVFHP3Ku/psAsrqsU1EQrpq0zj
	 QGhdxX8eMIyvg==
Date: Tue, 5 Mar 2024 08:50:36 -0600
From: Rob Herring <robh@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
	linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] dt-bindings: opp: drop maxItems from inner items
Message-ID: <170965023541.3333583.1849336475733290366.robh@kernel.org>
References: <20240304234328.382467-1-david@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304234328.382467-1-david@ixit.cz>


On Tue, 05 Mar 2024 00:43:06 +0100, David Heidelberg wrote:
> With recent changes within matrix dimensions calculation,
> dropping maxItems: 1 provides a warning-free run.
> 
> Fixes warning such as:
> arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb: opp-table: opp-200000000:opp-hz:0: [200000000, 0, 0, 150000000, 0, 0, 0, 0, 300000000] is too long
> 
> Fixes: 3cb16ad69bef ("dt-bindings: opp: accept array of frequencies")
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  follow-up of https://lore.kernel.org/lkml/20231229191038.247258-1-david@ixit.cz/T/
> 
>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


