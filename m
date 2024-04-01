Return-Path: <linux-kernel+bounces-126784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF9C893CAD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB971F228ED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B307B4778B;
	Mon,  1 Apr 2024 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyzAwaz5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD044597F;
	Mon,  1 Apr 2024 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711984325; cv=none; b=rLvfJBO5lpH8GW3tLcDJAm6KG6blbWoldMQY3Q94EWg7gjLzaW6mNzBY8n3Db5rrSQhXfC0I8lBtXFn2lNB/aXHU1O7ouuVjC2gIFLWOpmJjt3luuphjQxIya107vx//QlSzLvFLPStLjRs1+cFgopy1Thilz5Ve4uYRs31TkVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711984325; c=relaxed/simple;
	bh=3EAO1J65Wl7XzU3Ij5uOQDQQ0Ix7O8zlrSVRpexM9Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdaol83JqPg2p2EEWjzQMqc1qV3ESEZSGPy67+GcbnvnUBZpJ24HbDOEb24Lqe8eEcb8uaK6Ud8QsMevQHVvndPMo0kJxtJ7GUN+tWQoFBYwFxfHM6TCPdvhIk3v5jqVNLhbkB1OyshPmVhoRHx0jexEfG3HsHZymNexVBE7xVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyzAwaz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923DBC433C7;
	Mon,  1 Apr 2024 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711984324;
	bh=3EAO1J65Wl7XzU3Ij5uOQDQQ0Ix7O8zlrSVRpexM9Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AyzAwaz52gGHI7ImRb7JkTloJ+3B9Jnxr9WZOLqKJ7kKVNt4thbjQTt+yvyaUe5DF
	 jp3/oALGuO1vsLT7/8YUFq4X1WWPSAVB53jplzL54FVglqqfgghzdV9FlnONZmQgBX
	 V4Wlkk26dSqfAofP11GM3IABlLWc1D8GR8XGAHQAE2v1IaeSiWx7ki2BcoO5M9ZVo3
	 QrtjiSfMe+OwDpxJ7jXO8eZx/ci2IcbU50Jbh7mX6I1NofFzhBcm6bJo5fImysEKxK
	 PpsmPPqCr+JufQKqOhpfsA6F0/ZJlhzPiaRccFy9MAcO7U0Q7ROYFVJnK6JGDIVkJT
	 XNQV0gRqkEPHg==
Date: Mon, 1 Apr 2024 10:12:02 -0500
From: Rob Herring <robh@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: remoteproc: qcom,msm8996-mss-pil: allow
 glink-edge on msm8996
Message-ID: <171198431941.704045.10589765467149815176.robh@kernel.org>
References: <20240401-msm8996-remoteproc-v1-0-f02ab47fc728@linaro.org>
 <20240401-msm8996-remoteproc-v1-1-f02ab47fc728@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-msm8996-remoteproc-v1-1-f02ab47fc728@linaro.org>


On Mon, 01 Apr 2024 00:10:42 +0300, Dmitry Baryshkov wrote:
> MSM8996 has limited glink support, allow glink-edge node on MSM8996
> platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


