Return-Path: <linux-kernel+bounces-160601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4A28B3FED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E657B1C237FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CDE125AE;
	Fri, 26 Apr 2024 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDQUvocg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7411F250EC;
	Fri, 26 Apr 2024 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714158506; cv=none; b=NJLRXXCLyKB2LNRlTwguPO/zunA+sOSKZDo61Y1mNGf5rAFHPU99BAu3W0YxRdH3DvOPcddcixTF2u0/kdsZi1hYXS3Qq8rs0aU7jiPw/pm0JqFnNf0diRm+xrhsx8p8m/kDm+7uofpni6QCzYtV9j/EK6S5he25yLtLmTc7kVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714158506; c=relaxed/simple;
	bh=9YHk0355NYXdRvhSFPZ4S5QsQLIsrRxWXcwe/WTOTvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGLCdE/Meu6KhCLcyDwe9EMc68yqnOBHJDcbAZTP65pxZlx1J/tMqzm0b3STrAdukBSC/Z647eGFPIKFVeyZYGXwvlp5wuuoyZIIetygP210MDrVRvQsjxTRPleo40/a7NF9BDQHgDHPCNFn4cSbv7Vr/MHGxLbFTuhUFh7BpMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDQUvocg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921D8C113CD;
	Fri, 26 Apr 2024 19:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714158506;
	bh=9YHk0355NYXdRvhSFPZ4S5QsQLIsrRxWXcwe/WTOTvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CDQUvocgrMJsx2MvTmVwKs4rbHYX3eRldpcD4rxeY6xicoCSBtGZjqM66L/VF/UbA
	 tJmUZWVbU2RrPifUalZBBeEN9hOGQkSdYJWZWY8mxRFULjWevqisVzrJtApq+HBYMF
	 isCta7485uHdb5bmiAWgI2FalnWuT1jQHSLAZHCFA5Cpz5kMR2+4ErFx5yQHyaKZC2
	 rt//d+HExSWLbKTqvn1NirhLTVtsV0YssTZ7IzxHCWG7+5R6eV6GoKBW4e+OmCj+Lf
	 AT2Rs9OBXeRjYJ7H9SubS9KmvZdNrckJ4hRl0ibupXKQvq6pcGhXWxfhdjI2LhoE7h
	 3eulffaqVmgaA==
Date: Fri, 26 Apr 2024 14:08:21 -0500
From: Rob Herring <robh@kernel.org>
To: Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc: devicetree@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	jassisinghbrar@gmail.com, konrad.dybcio@linaro.org, lee@kernel.org,
	linux-kernel@vger.kernel.org, kernel@quicinc.com,
	linux-arm-msm@vger.kernel.org, andersson@kernel.org,
	conor+dt@kernel.org, krzk+dt@kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: mfd: qcom,tcsr: Add compatible for SDX75
Message-ID: <171415845056.2645479.9661044779641052540.robh@kernel.org>
References: <20240426055326.3141727-1-quic_rohiagar@quicinc.com>
 <20240426055326.3141727-3-quic_rohiagar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426055326.3141727-3-quic_rohiagar@quicinc.com>


On Fri, 26 Apr 2024 11:23:22 +0530, Rohit Agarwal wrote:
> Document the qcom,sdx75-tcsr compatible.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


