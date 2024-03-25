Return-Path: <linux-kernel+bounces-117260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB13F88B524
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40ED0B61107
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F561149DE5;
	Mon, 25 Mar 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFUoVDmr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECD88664A;
	Mon, 25 Mar 2024 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377208; cv=none; b=klTgR1RAOKqXLKqTJoosOQ/eykPzejYZbO5oXf7gXa0PihPkkxfoYoD73RECDkWeZOk1pcc/l5fu4WjxZBvi+ovVzG8sBjBS9nbfmKpK3juzF/mlanTPtxSyFu84h3GtcgxOy5RVeGPXz5420J6TW1DUA65q34k83a2kaNxHahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377208; c=relaxed/simple;
	bh=QxiBmosJiAlkkJIjPXuxNfLHIgYXfAiySTVvVlXw9mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfM6aADcXWK9q6mtN4odfUMkawC7cQ7nwEO8SdyLSNtuuClHCVYoRa4T/uNuSddk9w1SS0NhygYvt4TJ3kWLHsF1YUlt/e3YGQ6vWBSbdUyf9z4zdu3Lyu7NL3JVuy//sFVtfwmLrQgzI5ryLrW9O+it2xvbQJ9/BIq+QsZLUaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFUoVDmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF80C433C7;
	Mon, 25 Mar 2024 14:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711377208;
	bh=QxiBmosJiAlkkJIjPXuxNfLHIgYXfAiySTVvVlXw9mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFUoVDmrRB6lHJTifMM9A42KkJ73wQLUmnHb23TFfdlKcrWQJ4HH1biNzNSWElWuP
	 RhFmsvzxJs5Yrh/srG0FJOu1RTH6yb45xgsfXIZt2pFdg8kxYGBu88mNcZOj91GyMi
	 dy3ZdWfwejINfoIQU+xut0hoUbEOdPceLNHyjy4MyPfugtKiYtGxzl/0136s3jfFoY
	 kdFS4Uovn5Ah1LkqYdydnW+XpsMxxAp2USyBa5Uxl8vUG9jbmUYuuRhamzZd7+7ioa
	 kuccry2y95VT90//zNLLOML40RSmdeggmRuMHhzjTf5/8ah4vuCtHfcCHOaVvoMDrw
	 G14CPuAK9S7hQ==
Date: Mon, 25 Mar 2024 09:33:24 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	devicetree@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [RESEND PATCH] dt-bindings: display: sony,td4353-jdi: allow
 width-mm and height-mm
Message-ID: <171137719526.3318300.16563684034350324718.robh@kernel.org>
References: <20240325103227.27474-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325103227.27474-1-krzysztof.kozlowski@linaro.org>

On Mon, 25 Mar 2024 11:32:27 +0100, Krzysztof Kozlowski wrote:
> Allow width and height properties from panel-common.yaml, already used
> on some boards:
> 
>   sdm845-sony-xperia-tama-apollo.dtb: panel@0: 'height-mm', 'width-mm' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Rob, could you pick up this one? Was on the list for almost a year.
> 
> 
>  .../devicetree/bindings/display/panel/sony,td4353-jdi.yaml      | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!


