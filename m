Return-Path: <linux-kernel+bounces-99319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823CA878685
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0718BB2119C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F90535D5;
	Mon, 11 Mar 2024 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+cimJKq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394D64CE05;
	Mon, 11 Mar 2024 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179019; cv=none; b=UYPN1eyKULcMVpvXNxjEBY9dzl1sNiaAKq+LqE+m1PrUhqx2ZorutPKVS/IHnXxMXu+rtjNZLesv32zNHixvgnesAsU99TmbwfaToJ5dkOvDQpVSZsT9KUjikhXZr7v6kazbtUEoluKdKVB8J/mA2ObckYxJUrj5TTJY1yOCb0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179019; c=relaxed/simple;
	bh=1O6KqSX/9qgFYIjlCHevAQ4XV7SOdYdHdydqzRGVpsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VANcKTw8ydCEtxCZr8PfWaq/dG+9x9OmeOYvgBQsljyHuB9V4ZAZ6Totc4NTm32gceWV+4HcAzVywK1jQDVmdrwZrlv8QSrXjFc51LyjwWqKqhbnBGHonSqXi0N3z4y0YtsFPYumYGeTc1R0205yTgesb0HGysJ8hfZSiKNO3Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+cimJKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58B0C433C7;
	Mon, 11 Mar 2024 17:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710179019;
	bh=1O6KqSX/9qgFYIjlCHevAQ4XV7SOdYdHdydqzRGVpsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+cimJKqatMYQCrt0xa9WeHsSzhSs1Sgq7H1On+IwjglcbkbeyxkjkLRTbIiqOM5z
	 VoQpn6zg44YJ3qBx0gkveX7E2gnz01cFUtXK1Pf14eAkmpIcKFTKcypwpkrOvCAijP
	 YpWA93aY3YLurG3rLwBOzd8ohJyGburpWFmx87pZktw9YkDZf/jnG0MBliGAiUwq/2
	 AEvZtVQKbpKaDDkBG+Be/X0H0fUVVYWj2f4wx/VCzUyY7UUTIdGXi114ruvn4k/jhr
	 Ry8xc1UuWk3NfN5usf9ijl6Bn9Q6c4mmwLETJQu2i3oX2vCBERSIq0nJoP5bhsIVk0
	 mUTWEYTY/hPFg==
Date: Mon, 11 Mar 2024 11:43:36 -0600
From: Rob Herring <robh@kernel.org>
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	linux-phy@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: usb: dwc3: Add QDU1000 compatible
Message-ID: <171017901624.1476439.10740898419588500267.robh@kernel.org>
References: <20240311120215.16845-1-quic_kbajaj@quicinc.com>
 <20240311120215.16845-4-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311120215.16845-4-quic_kbajaj@quicinc.com>


On Mon, 11 Mar 2024 17:32:14 +0530, Komal Bajaj wrote:
> Document the QDU1000 dwc3 compatible.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


