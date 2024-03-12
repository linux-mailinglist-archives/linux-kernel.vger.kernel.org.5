Return-Path: <linux-kernel+bounces-99921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2AD878F3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0EE2B208B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E527769979;
	Tue, 12 Mar 2024 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAuh0qAl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4FE6995B;
	Tue, 12 Mar 2024 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710229796; cv=none; b=X32BGCZOJKtWF9H9fXnJYPKzuBq2YRNT/u/Y74mRDKqcDCCfYRM3EXLejcAstJi0CB/E3aYFMtMACHs/H1q/vDFOyLYXIbqn9HvSfkTUxW58MNE1GQZsO31n5wmKiS811DRI0oJxcZwzt0b61Edz6cUgESS+EPM0fxoDDirXwzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710229796; c=relaxed/simple;
	bh=KzsirukdSTe8fOrCswNhfKEgbN1Y1uITjfKe3osVnQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4bpcEBpp8PMwdOV6GzzKyZ47NP7/2IbFdMdpwVt+oJZiKI5N6GUmv7dN0X8/5GE227HhC9ScwhZvGCdQimyQx2XMDFOPbET0VfGE5vsa5XRpUFWwbO7j1FEQJc+9E6rE+sJnZibnp1FBo+atRjXNWwYVcjVGvbvbtAHYOHpzwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAuh0qAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80676C433C7;
	Tue, 12 Mar 2024 07:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710229795;
	bh=KzsirukdSTe8fOrCswNhfKEgbN1Y1uITjfKe3osVnQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAuh0qAlmRM3Kbs/1vPzGB4iAeRuq6Gps4iX9PbZzHs7LmeYb7gTQjdA78YnFt6LQ
	 kvJgFDxy6VnM6nRMX0iKBanBvA8FOGD54H+43YCM4MybQuQ/0LRvFuyjMozvVjYM/n
	 pgcN3FLGkZ8S3mmJ3iRBd8IC7tIdWQxAMdd4WApEVSZZ3yljKTYjQ0Iqu981bhljjx
	 mL5jcOehg5bLaF07nRChVz8keNRceCe171O4QAAgwhZjn0vhP0DYyP8tDJ+wpYBJ1N
	 3G3sJeIi/07kafXLmemRviaFWJZMVhh2CfXTfczDXhHV0s2ZsW31W5XJMk0B30Dhr/
	 UucLsp8wilxMA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rjwtd-0000000075p-1sK9;
	Tue, 12 Mar 2024 08:50:01 +0100
Date: Tue, 12 Mar 2024 08:50:01 +0100
From: Johan Hovold <johan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>, andy.gross@linaro.org,
	david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 05/14] arm64: dts: qcom: sc8280xp-crd: limit
 pcie4 link speed
Message-ID: <ZfAJKTvQFtoZ8SSN@hovoldconsulting.com>
References: <20240311183618.327694-1-sashal@kernel.org>
 <20240311183618.327694-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311183618.327694-5-sashal@kernel.org>

On Mon, Mar 11, 2024 at 02:36:08PM -0400, Sasha Levin wrote:
> From: Johan Hovold <johan+linaro@kernel.org>
> 
> [ Upstream commit db8138845cebcdd0c709570b8217bd052757b8df ]
> 
> Limit the WiFi PCIe link speed to Gen2 speed (500 MB/s), which is the
> speed that Windows uses.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Link: https://lore.kernel.org/r/20240223152124.20042-7-johan+linaro@kernel.org
> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This one was not marked for stable and does not need to be backported.
Please drop from all queues.

Johan

