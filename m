Return-Path: <linux-kernel+bounces-63575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E73068531A3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC592869D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0142155C01;
	Tue, 13 Feb 2024 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJT6OEDq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4143455760;
	Tue, 13 Feb 2024 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830398; cv=none; b=HUxLRm0lo52m39JVWXG6jYtIv1+nwGm9zTgfYA0Omij0rdy9mdfG/uceNqGeTCn66QgR6xvC6vGeDHt4RUfzaFyldis25RyXV5HqFe/+z0UQobMlyka3oIKH+O880zeyVw7QCMXrEwU6oD+SCbSlIHu8devSPYeiE16s/etvMbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830398; c=relaxed/simple;
	bh=2jm6cvRsD9MqO/2C5y1bPrUZKUrWefhJVqIriw/qqGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KPyHkFBBivSbkWfQjPKu4WBwTjeM5BAXectWVWXQTLQvSjscdGZ/ReHkW4xGn0XXhns3G5gkgioOtGnOy63wOrJl4xdYTtKI7UYC7TX+PRt/VKCvLip/uUt47dBMiWKnUXaoFHHX2r7J94aLjXqVKKrppdTgwdu1eQsM3UjhLPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJT6OEDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E770C433F1;
	Tue, 13 Feb 2024 13:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707830397;
	bh=2jm6cvRsD9MqO/2C5y1bPrUZKUrWefhJVqIriw/qqGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OJT6OEDqQIVbbmMIsi2xbmJY3Xcypz6eBeHZtd2JomM+uI2LfS4WwpD8OaINXEWTv
	 N/jiZ8XYiyQSO9dglOTxsVn7nbJiBG3yn8egZELWh6m7tim3473XVpvfXGvlLEzg/l
	 Ehep6NKbh3h276/7XvCLJdlJsUdWxtuWVxksQyOq4LvHlcHxAroc1epRQigkjYBHgH
	 oEV/ZwaQhrpJNPDmwnYRhTsI9eQ9aQrY9mHIBp+Lp7DKf4j+Pzr66ryLRVWBuOrLVs
	 qBr1sN0XvqKXIdS24ngyImANSJXwIfO1E8GQlMqpJZXXEbjs6piE4SwsqcWunAAWtS
	 X2FMCOCIQxiGg==
Date: Tue, 13 Feb 2024 13:19:52 +0000
From: Will Deacon <will@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Add X1E80100 MDSS compatible
Message-ID: <20240213131952.GB28926@willie-the-truck>
References: <20240131-x1e80100-iommu-arm-smmu-qcom-v1-1-c1240419c718@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131-x1e80100-iommu-arm-smmu-qcom-v1-1-c1240419c718@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 31, 2024 at 02:35:16PM +0200, Abel Vesa wrote:
> Add the X1E80100 MDSS compatible to clients compatible list, as it also
> needs the workarounds.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 8b04ece00420..5c7cfc51b57c 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -260,6 +260,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>  	{ .compatible = "qcom,sm6375-mdss" },
>  	{ .compatible = "qcom,sm8150-mdss" },
>  	{ .compatible = "qcom,sm8250-mdss" },
> +	{ .compatible = "qcom,x1e80100-mdss" },

I think this needs adding to the bindings Documentation first.

Will

