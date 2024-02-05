Return-Path: <linux-kernel+bounces-53240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D0284A27E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972521C22C5C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384E445034;
	Mon,  5 Feb 2024 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGewp0Mh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D313482C4;
	Mon,  5 Feb 2024 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158261; cv=none; b=FLaXhHsAHMrmC3RfFBa4VTeG4ULJ5+GBl7RboymxxNkKYF1TP+C1GWTF1S6FtcqKI7RzAGi3jo70pWuwwBMPHnloSmlJ8hhZcQLXGqKKBbIJ+Dm89gTY6H/sfJR5cgKfeb9fQ36v3JSRk62rcbwZ0hemRpKdYnK6OJsF+tN/st0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158261; c=relaxed/simple;
	bh=mONJaCocgFll7dK2bAjGsN0zGIKBuFLQytcR0mc/a/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrpRXjY5LoyrlSMg+uLqB3pK3ALIqeTybu4JqtDmUuAab2Z76rsBxLbDtV8geC2Pz1mlJBIRn2GFHzQSs72S60O+cRXxu9rKRpy5kJ3Y4NpR05WScNNnhoS4+Vf5O9HO5kVfhZ25C5d+fttR25XUQN7N6oB3kAm/2eAargXqpmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGewp0Mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C44C433C7;
	Mon,  5 Feb 2024 18:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707158260;
	bh=mONJaCocgFll7dK2bAjGsN0zGIKBuFLQytcR0mc/a/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGewp0MhWFG/66z3xwB+S/34Qq9S2MiJi1BkS37FJbm85iC60HIXRRnuSjqc9ZMwo
	 kRWe6qo7m7RnMI1csdjifIdVZuT+b7H3L22TC/aUPhKrUde18ww4umrUtf3u9s351q
	 xFZiVXBFxFdIfsPe3+hN0NX0YMDQecU0OIB2SMyvSfGXgYHXro8dSDsU3z25XI0pV8
	 2awgBnQ43Xio9v3oMATOquzvu4jCWpGalSTSV6DVdsGe6Yani8mrqUDr4FXPbVIZ3R
	 bLBseD7JvclrJ4xU+3i5ZlKUAdcPNs5XIQQfCYkVIDw64YlXhwh0FfpzW6b4YXYvR+
	 UF6mV/VS/NFGw==
Date: Mon, 5 Feb 2024 18:37:10 +0000
From: Rob Herring <robh@kernel.org>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: quic_kgunda@quicinc.com, conor+dt@kernel.org, pavel@ucw.cz,
	linux-kernel@vger.kernel.org, lee@kernel.org, jingoohan1@gmail.com,
	andersson@kernel.org, dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	daniel.thompson@linaro.org, devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: backlight: qcom-wled: Fix bouncing email
 addresses
Message-ID: <170715822956.3957218.3028147322546724367.robh@kernel.org>
References: <20240202180151.4116329-1-quic_jhugo@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202180151.4116329-1-quic_jhugo@quicinc.com>


On Fri, 02 Feb 2024 11:01:51 -0700, Jeffrey Hugo wrote:
> Bjorn is no longer at Linaro.  Update his email address to @kernel to
> match the .mailmap entry.
> 
> The servers for @codeaurora are long retired and messages sent there
> will bounce.  Update Kiran's email address to match the .mailmap entry.
> 
> This will help anyone that is looking to reach out about this binding
> and is not using .mailmap to pre-process their message.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  .../devicetree/bindings/leds/backlight/qcom-wled.yaml         | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


