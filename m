Return-Path: <linux-kernel+bounces-53244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5244D84A295
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE3AB26BE9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F4C481A7;
	Mon,  5 Feb 2024 18:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URq61BOb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C3741A92;
	Mon,  5 Feb 2024 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158547; cv=none; b=X0lNRvDDK5Qh/Nm72bY0sRKV2KWBowLexMo7sFs1hqllp9a81JwdH2TAacPza2r5KWujsfiKBPmtNJn13E5S8MMCREQNIQechratZSZ/pVoHg/4Fv/sJn9apwqnkrVrpGU7Iu7BtS8Gg3TbR0nEfXszJsWDgWl9XiPOq6PVbAuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158547; c=relaxed/simple;
	bh=pkwZXFSQYKYcHP79/ddz2BocuYhgK3Flx0MS53nuNjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMSpB9GZKH7afJtMsBzoE/8UHTJBeJHIJ04XM2U70w380jQBtBojGMmJME7DDN/Qq++3t3eqAs6ypkYdwxdeteWL1Prbi7GNuBaHsrgnUxLZMV+0f5GvxCsZfbHucJM7JaWptMcJv9tsE/2pHGmMmLwg/7bIQQRjVOApeo/Dkw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URq61BOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15D3C433C7;
	Mon,  5 Feb 2024 18:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707158547;
	bh=pkwZXFSQYKYcHP79/ddz2BocuYhgK3Flx0MS53nuNjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=URq61BOb4/CM45btppqwqL+yzXBalFPoyLss1QE/9sloBLQKnRUBgXh44QTVJfVz0
	 IdHlAaMLwITaLMkt49hh+dGMM8pU7v18UIbfywV/HxQ3PpgNUmyMxRF8YIBtm7nAsH
	 EYXn+icd+3WhRSc917GjWsJBJm7ZErscIbxnKPZBJKZY/lx1Ao4v6N+wPGxpf+IS9L
	 mX72okws9IB8w2xj5Qhjss7i9llbBbS6inT+vvVRGk7FNJ5OANR3Ez/br3HMFSLc85
	 aHujcahxj97exdQUROY3e+Jnf+drukrQfpu28nAsdTFckFejd+K0w5mAsaniraL+hD
	 YWHK1nM+oLQhQ==
Date: Mon, 5 Feb 2024 18:42:23 +0000
From: Rob Herring <robh@kernel.org>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: neil.armstrong@linaro.org, airlied@gmail.com, conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, quic_bjorande@quicinc.com,
	jernej.skrabec@gmail.com, dianders@chromium.org,
	tzimmermann@suse.de, Laurent.pinchart@ideasonboard.com,
	mripard@kernel.org, andrzej.hajda@intel.com, daniel@ffwll.ch,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	jonas@kwiboo.se, maarten.lankhorst@linux.intel.com,
	rfoss@kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: drm/bridge: ti-sn65dsi86: Fix bouncing
 @codeaurora address
Message-ID: <170715854321.3992852.17300060603696641162.robh@kernel.org>
References: <20240202202329.4172917-1-quic_jhugo@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202202329.4172917-1-quic_jhugo@quicinc.com>


On Fri, 02 Feb 2024 13:23:29 -0700, Jeffrey Hugo wrote:
> The servers for the @codeaurora domain are long retired and any messages
> sent there bounce.  Sandeep Panda's email address is no longer valid and
> should be repleaced.  However Sandeep has left the company and has not
> been active sice, therefore it looks like this binding is orphaned.
> 
> Doug is listed as the reviewer for this file in MAINTAINERS and has
> volunteered to be listed within the file as the binding maintainer.
> Therefore replace Sandeep with Doug to make the documentation current.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  .../devicetree/bindings/display/bridge/ti,sn65dsi86.yaml        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


