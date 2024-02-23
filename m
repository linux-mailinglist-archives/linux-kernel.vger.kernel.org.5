Return-Path: <linux-kernel+bounces-77816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E5D860A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FBE91F2503B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824C112B66;
	Fri, 23 Feb 2024 06:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qRkXg/2G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70C8125A8;
	Fri, 23 Feb 2024 06:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708668005; cv=none; b=GH9FgmCEp594q1zdeCSXF5UJ4QcTL1d27zQn+TSPZHU/BqvWOmLr5BUpnCD/cFb830k7ipNrH3RyPcQ0J79ilYze5Tez3KYpKrGDGo3VW0xs+2H1f3dZaB0np/BjBu3sW5FEsr2HUQM6AJ9l9iDBzYSfl5r3rJUfpbhS598QT/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708668005; c=relaxed/simple;
	bh=sHUvsRjDQ6XZxQcJVWrcNMqRKCZ3kcvH9jVZL6N749I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pec/Mns0RJdzKnMGB4jcrZJ+RoENqwIuDOYKiWBe1R/MaO08MQgqKFGBZNSa8mZkR3XNs/qUzBVLmOdoQ16YqMjGZmN+7S3foNvv7mfEtQvJNyUiCADcKyEGyIqCi+AOxMEvL8SNOubJ91Rvz+huz75cMijJUiVkGvL5SDjqsEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qRkXg/2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD44CC433F1;
	Fri, 23 Feb 2024 06:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708668005;
	bh=sHUvsRjDQ6XZxQcJVWrcNMqRKCZ3kcvH9jVZL6N749I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qRkXg/2GMFnYIQ59Evo+IDsjPX8UZU/R8CP0DRLZnTGLO34rxQbVglPLqCpX0G9N7
	 +/FXhRkCExqqwBuWcx/RPE7UzdT5uB7SzBsHdYAg68Svpk/eJeb+l/M0eszo0hk8a2
	 LN236zyscT4isoBB4ixdHgwGToJdnsBGqSq3l+h8=
Date: Fri, 23 Feb 2024 07:00:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-usb@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH usb next] ASoC: Revert "ASoC: dt-bindings: Update example
 for enabling USB offload on SM8250"
Message-ID: <2024022346-hardware-shank-519c@gregkh>
References: <20240222163204.65468-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222163204.65468-1-krzysztof.kozlowski@linaro.org>

On Thu, Feb 22, 2024 at 05:32:04PM +0100, Krzysztof Kozlowski wrote:
> This reverts commit a9c83252bff616cf3a38d55b7c6a6ad63667f2dd from USB
> tree, because it depends on other DT bindings changes which were not
> applied.  This commit alone causes dt_binding_check failures:
> 
>   Documentation/devicetree/bindings/sound/qcom,sm8250.example.dts:97.44-45 syntax error
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Greg,
> 
> Please take this revert. Original commit should go via Mark's ASoC.

Ah, now I see this, yes, I'll go queue this up right now, thanks!

greg k-h

