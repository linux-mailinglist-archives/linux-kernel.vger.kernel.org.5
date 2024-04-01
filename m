Return-Path: <linux-kernel+bounces-126665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A3A893B34
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA57281EDC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E373EA7A;
	Mon,  1 Apr 2024 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuXsPS+O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33003E47B;
	Mon,  1 Apr 2024 13:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711976702; cv=none; b=PqEaJoNNiKkEekUyqwfVR4RhAuIVZHnk5+48nZ8BSD8UYMD1kdlC/uLnQdnIiQUiYA/uraOw1O5z2auQiUyeU9FnK3uVvxR3j+KEMxJHkbOCjLXoZHXP0V0v28L7SERJ5Px5lhGo6m9zULkoUJN805kxNgFxVpcBgORAJmx2Rjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711976702; c=relaxed/simple;
	bh=/om3O2ArRQUfyz8QVchaYcKwUeJkzk6N4jIEnVO3eHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/hzkpts+5ZQovaEyCcTyg4Zyo9DUPw65KkqA64GvpU3LBVd40LvVwSp961cnMEIA2RvGF7gIUvdJa6321M6bm/mXRXtVnKF3vyZV4caAYslJKJ27PNdgZU0a1ViL8GCffN+hEHIQpE7RgiaeARdPBwC/+EV/Xlf7L96WoevMWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuXsPS+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F515C433F1;
	Mon,  1 Apr 2024 13:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711976702;
	bh=/om3O2ArRQUfyz8QVchaYcKwUeJkzk6N4jIEnVO3eHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RuXsPS+O8XzAjnlWu2+gwrG3G9448lzEye+RjZo2hDCp/hLoQefUoYMgL8Iq4An8x
	 4diHGRYigiclOsbp/Sn1Y/9HLVgZEaluh+Mji0KaEQMRS+9XGiER4/yGAO8YvJ3Rlu
	 x/7cBBvU7VVcBvy0V0NVj4Bi8dGXJ7dqRxngg8rgj8pvZQmBxuBP1swbgbcw1/YHH+
	 zoJi3ggSM7nAKVf5KWfdtz3nsTVOkPDv559fqIbTLSho6ZV2nvtES9UN7etGtr4f2Z
	 XExRSEsp473rQsE8Z0Zo011fIA7onsl06vvu0s+rRKZBH1ocz6Ip/9yZ1VBJqQV/T2
	 ublNhwxpJftdw==
Date: Mon, 1 Apr 2024 08:05:00 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: qcom: Document the Samsung
 Galaxy Z Fold5
Message-ID: <171197669724.279571.2288668471464628597.robh@kernel.org>
References: <20240331-samsung-galaxy-zfold5-q5q-v3-0-17ae8d0a9fba@yahoo.com>
 <20240331-samsung-galaxy-zfold5-q5q-v3-1-17ae8d0a9fba@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240331-samsung-galaxy-zfold5-q5q-v3-1-17ae8d0a9fba@yahoo.com>


On Sun, 31 Mar 2024 12:56:39 +0200, Alexandru Marc Serdeliuc wrote:
> This documents Samsung Galaxy Z Fold5 (samsung,q5q)
> which is a foldable phone by Samsung based on the sm8550 SoC.
> 
> Signed-off-by: Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


