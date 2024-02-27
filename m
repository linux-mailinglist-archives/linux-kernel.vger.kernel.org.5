Return-Path: <linux-kernel+bounces-82668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB34868802
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D041C21B03
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3314EB3A;
	Tue, 27 Feb 2024 03:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLqozHql"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD894CDEB;
	Tue, 27 Feb 2024 03:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709005661; cv=none; b=XVJ7+zc4FYewocpR/UMo3wqIinAhyLnqi3jrYiDcGOlCmllrBVTvZ/Rz50QTA9KXxBpDr0LTpPqolYeQY0ZYMhbBsBpbVWvQpjYpo4wG0tYTUedAm4JuOKTIPisauPfl+mXsz76V9/4mW5Sf8Cz+CuhmlTCvBVtOd4+mPF++Ya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709005661; c=relaxed/simple;
	bh=lMkDH/u6LPonNd2Xz1tMO6hML8JBSHp7TfgzWaxnwxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQ7tK0Ci6Z4zWh50WxAm6+eTLCvfyQ++ufhzLwWJ7Vddk/3JbdChwxCMQ6FvGlllffHJS7BBbIVV0rtQd0yS3jEt1XLMxLwXdmZkYpODVB6tm7+S+xdb2Kj9QNdKi9IkHsPc6gTRCV6LvaJLESfwyLaLtCN8ocZdQmXZ9ueWAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLqozHql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266AEC433C7;
	Tue, 27 Feb 2024 03:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709005661;
	bh=lMkDH/u6LPonNd2Xz1tMO6hML8JBSHp7TfgzWaxnwxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XLqozHqlO14ogT9ZsdW2H5xwdJPbcvHEkewe62lYoxhVcGY7IpEjE7F2aI6iDVzQ5
	 9c2iiKQhPX3G7CBS3a+0tmd7NbS6galMmjOvAPD+3EYdU8pDLz30IcefcLA//HhBjK
	 QerAeBsveANA8JKStGzLzMCp3WK6CsvEi9U3ok+U2jo+8DqwRS/YSaMnZDcqe/IDyr
	 6eTwpxx1eYrfdt6KU5CktDgRX3gYTHRk368h6eOxjQIb+KT1QYVs4zvUR2oK8FpYnD
	 ToPgkI4uvmbHG3ZeqvthMR9I3x1z1z/d2NitRUJuDZES7X9blU8wKDv+g/1I4lbekl
	 46UDNT0vjdLcA==
Date: Mon, 26 Feb 2024 21:47:39 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: leds: qcom-lpg: Narrow nvmem for other
 variants
Message-ID: <170900565812.2662245.9075467543291495046.robh@kernel.org>
References: <20240226073713.19045-1-krzysztof.kozlowski@linaro.org>
 <20240226073713.19045-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226073713.19045-2-krzysztof.kozlowski@linaro.org>


On Mon, 26 Feb 2024 08:37:13 +0100, Krzysztof Kozlowski wrote:
> Only few variants support PPG and store LPG per-channel data and pattern
> in SDAM modules.  Disallow the nvmem for other variants to make the
> binding precise.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/leds/leds-qcom-lpg.yaml          | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


