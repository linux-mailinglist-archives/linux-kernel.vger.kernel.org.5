Return-Path: <linux-kernel+bounces-96323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B35875A3E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4761C21EF8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC0614198B;
	Thu,  7 Mar 2024 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqQ3acLK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986BD13F45B;
	Thu,  7 Mar 2024 22:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850349; cv=none; b=pIptcz49oyCwLMXNMyxEvYeGIm/Xfyp+it1AUycOcmQKbZh0iaMIrhqVoj6ApXaSZmNtatlzEJZu7xQKt5zZocOnDjSpE9xush3A/v/jMPqq+nxADzqpGti3OBU553rUV1VkNGbxMWB18MD/jJcyvlEyLzxRNR8OynEL/HULMl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850349; c=relaxed/simple;
	bh=dSgHDY1mQRS5iEB2K6FDPBYRM8N29qnYSxvjweoJFBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRMUd0BEt3wbjJcq01C06HM6zFJ5U/8YaYu2JjfeO+WVhiv35FaLxw4/s8dCoqp+eXeywk9+hQ50kJ/i//96n4gozeXe9J1DZpnkocJ3nAEIqVE2nXQbB82C5or2+ycZ9IOVrDaj4z8xeqwKMqVnBD2kx0UXJtAA3zNS0lSBhnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqQ3acLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2F3C43609;
	Thu,  7 Mar 2024 22:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709850349;
	bh=dSgHDY1mQRS5iEB2K6FDPBYRM8N29qnYSxvjweoJFBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GqQ3acLKuuwV178JSKE3yoTRLPdKoHN2k3b5kvkOGrfDazt4FhNSCglNUv+9X8cyM
	 bP77qFySsA+Wrf/dgDSjoEeo8nCafiABMPGPbCO+3/7uHdCHhTfVqdovNeXZi7Q4ok
	 Sr5GU71NNQd4AxPvndP204IVEDqrO/X/k9ukuWsUn5n8Cj+HczQLR/NR30G5A1wGns
	 IH6S9/3kXyUgttrd/utZFVTXKJ9raNQ36at2E2j2UKBR9H8pTSAC+znvhyh05JJKt/
	 4PwFMFCSnhDUnUkgxISEF0vmd/vBwr/HuNqyM49NZxumETrM+mnqONzdjs6esb57cO
	 2j8g8Ue2I8Gag==
Date: Thu, 7 Mar 2024 16:25:41 -0600
From: Rob Herring <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: Add compatible for SC8280XP
Message-ID: <20240307222541.GA3268932-robh@kernel.org>
References: <20240307-topic-8280_nodes-v1-0-4eba20e08902@linaro.org>
 <20240307-topic-8280_nodes-v1-1-4eba20e08902@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307-topic-8280_nodes-v1-1-4eba20e08902@linaro.org>

On Thu, Mar 07, 2024 at 09:25:54PM +0100, Konrad Dybcio wrote:
> Document the QFPROM block found on SC8280XP.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>

