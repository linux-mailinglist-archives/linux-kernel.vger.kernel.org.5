Return-Path: <linux-kernel+bounces-14729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1999A822149
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49BDB1C229DC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305CD15AFF;
	Tue,  2 Jan 2024 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjQVUlMq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1E315ACB;
	Tue,  2 Jan 2024 18:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0090AC433C7;
	Tue,  2 Jan 2024 18:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704221126;
	bh=bQI+DoJdsXFB4m5zQE85kj5grJW5PX4xlcWP8bfjp9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EjQVUlMqtAK6ZTYPHbl+QxMW4MOW9tmBgaGNDCsAKIruYwsdST7DmGMD3elIj2K/P
	 3q+od4je/xBZWztmr+W5/14TykPDdGhHpwS0eGuFuFX57ZxH6qjDMo/ZbWRVCh8/UP
	 dqTNI3QwUpCk9nGlTvMjtZMV4tRmJ/Gr+yCVZe6hhwEmzkVu0NON+aSnMRVV4v+WH0
	 rHQcu5Q5ncvZI224L7OTvPXUh3VjOoxGI7OicbX/IkCWpj1XQkqu7hsc1CkDZTLJc/
	 Z8lmEGCa7vDFzEd9e3xDzoLsUiIyUUFw2M5Tp9DGPEo/Eq8gL9uItFjwSEyi2i08p1
	 60YR4pw4u/wng==
Received: (nullmailer pid 3362798 invoked by uid 1000);
	Tue, 02 Jan 2024 18:45:23 -0000
Date: Tue, 2 Jan 2024 11:45:23 -0700
From: Rob Herring <robh@kernel.org>
To: Mao Jinlong <quic_jinlmao@quicinc.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Tingwei Zhang <quic_tingweiz@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, Yuanfang Zhang <quic_yuanfang@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, devicetree@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Tao Zhang <quic_taozha@quicinc.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: arm: Add remote etm dt-binding
Message-ID: <170422101475.3360198.5669406333146629491.robh@kernel.org>
References: <20231210072633.4243-1-quic_jinlmao@quicinc.com>
 <20231210072633.4243-2-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210072633.4243-2-quic_jinlmao@quicinc.com>


On Sat, 09 Dec 2023 23:26:28 -0800, Mao Jinlong wrote:
> Remote ETM(Embedded Trace Macrocell) is to capture information of
> the executed processor instructions of remote processors like modem.
> Add new coresight-remote-etm.yaml file describing the bindings
> required to define coresight remote etm in the device trees.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../arm/qcom,coresight-remote-etm.yaml        | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-remote-etm.yaml
> 

Applied, thanks!

Bjorn, Really either you or the coresight maintainers should have taken 
this, but they weren't Cc'ed.

Rob

