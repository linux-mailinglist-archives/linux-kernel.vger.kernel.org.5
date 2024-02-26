Return-Path: <linux-kernel+bounces-82225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E7D8680C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764711C2A356
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954FC12F5A6;
	Mon, 26 Feb 2024 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvIeiBdB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D279C1DFEB;
	Mon, 26 Feb 2024 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975055; cv=none; b=sbhKAGFy2CTDQBFM+8vvIaWXmoi+TgoFC5cekNzSoOcHHG2LVcqjwBuwslJRxXVkX9lnh6u/Z+whDVsGE4lXfzsJCdXTMwpXI0COFN+DQF5AF5jOVBolzjETZM61mWGg9Ois5gLEnoos9Gt2/VDW3uF8WUmtfFaJ8eCyc6ClCQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975055; c=relaxed/simple;
	bh=DP31nAN/2HkVuqHcBfba7Y0esCPw3TOSJ/xdggcbxyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqPchkX51DchEawrAewCBd3djRxKs0QfM2ltM0X2/a8sBG4l5q2apfFnn+e8V1uTepeafj4gRAFU0CBPduhR+FMkoJDwhf0iwI5cpr2z55Ql2BTEdg7+yH5ZoppgBNlQ0hg7VYtNx5tvFr77/AiG7hOuA3uRTSGP+9RHU712cKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvIeiBdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB38C433C7;
	Mon, 26 Feb 2024 19:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708975055;
	bh=DP31nAN/2HkVuqHcBfba7Y0esCPw3TOSJ/xdggcbxyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CvIeiBdB3CvQqUcS7yQYTbMZuEVpabjfwJePC78V9la5z7QNoWVCeAm5nSpvGbGOj
	 Dg8jbI2+wjKPnnyBtJMrb4T1oXFkVHpLSLn6du4N8uoSlDcfVwWS+rB/Av3gYyOzzt
	 8kYHFMYw29e+5NG/wx127UQzPHeCKU4lYoXDHCOdDUlto0UqJx9Px8PWer+wgreQwo
	 ygZz4kVBU2ohNcK/V5niYUhQSOXDCCouiw8nmxgIittfiH0VNSAzlPfdVwKXTknbSh
	 ZXBqpqWyYeHdkuqZjWByTq306AnUzJeivty5xrfhuhxMtCkwrxeQCmfHlJVDHqKN53
	 2rXEXpnCD6/4A==
Date: Mon, 26 Feb 2024 19:17:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marco Felsch <m.felsch@pengutronix.de>, puranjay12@gmail.com,
 lars@metafoo.de, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, kernel@pengutronix.de, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: ti,tmp117: add optional label
 property
Message-ID: <20240226191710.37e10e32@jic23-huawei>
In-Reply-To: <97b06041-38cf-4ae9-8317-79f040abe9bb@linaro.org>
References: <20240226121234.545662-1-m.felsch@pengutronix.de>
	<97b06041-38cf-4ae9-8317-79f040abe9bb@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 13:37:41 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 26/02/2024 13:12, Marco Felsch wrote:
> > Add the support to provide an optional label like we do for ADC
> > channels to identify the device more easily.
> > 
> > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > ---
> > Hi,  
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 

Applied

