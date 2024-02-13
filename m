Return-Path: <linux-kernel+bounces-63870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDA88535B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB63B1F23E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA3B5F564;
	Tue, 13 Feb 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTbYHWT9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007015F467;
	Tue, 13 Feb 2024 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840742; cv=none; b=R7a190tar0wamaHn15VhuFZwmB2Y9yLQ5dWcQazeQich+Dhl4cWJTK6hTI5/9UUhrQ+5HfoslLGgAta7j/KZc4lkDEh/OnHYWJrJk2FwbCvYYFaDKFwuvvynCzP+1Ms4qkKdXFxqITcJFBf/FxfFZEDf81Amf+PpF/FgKLAeWjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840742; c=relaxed/simple;
	bh=l9QqS29DqRYDm0qQfNCFLgO3rb42T1OTnJCo6+CfEWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsVJaiDEfphUu3LEbIRJhvH/iKLR3sxuybagresrrfjazkBvWI6n272/921USNEWBZI2R+r2mL9D5IWCEywbD6TssdhjMbmgxJnjoVvxWaJSp4sZ5Yx1JzrVyni0+G42ZOfbcxNB8u92GKn5wAaDC6/Taq02M8bxaKs829GEB34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTbYHWT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DDEC433F1;
	Tue, 13 Feb 2024 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707840741;
	bh=l9QqS29DqRYDm0qQfNCFLgO3rb42T1OTnJCo6+CfEWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OTbYHWT9uHvaWMckwR8HQ7CCx2h0+rmXywvv5X7PhJLHR0p9KY+clpXXonapMYIJW
	 Mh548qQzpxJx1JfUOY87SYf8532MfkppZDlAI8dpZ7nan7XaDebgERSHarFLBJImUu
	 s6+c/fcnEgUijmk6USZs7JCiy1iw1/wrMWJJA74XJleac9HaEgcnoQRcIVjWKyLUBs
	 IVNVpnqWcBAfBX77AExRCuLee+Xrkj17A3Nfwu4zTfWZiEpcslX8tJk2UWSA2QdMl9
	 cmRjLnlgUytxRcpDXCh7ieZggPnFSqjMrvB4uqQtBuwJuuYssNMXeshnn3kyn+3pUc
	 7t60zyl5RWJbQ==
Date: Tue, 13 Feb 2024 10:12:19 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	devicetree@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Benjamin Bara <benjamin.bara@skidata.com>,
	linux-usb@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH] dt-bindings: use capital "OR" for multiple licenses in
 SPDX
Message-ID: <170784073862.1459522.15100332753986878275.robh@kernel.org>
References: <20240208105327.129159-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208105327.129159-1-krzysztof.kozlowski@linaro.org>


On Thu, 08 Feb 2024 11:53:27 +0100, Krzysztof Kozlowski wrote:
> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/display/panel/visionox,r66451.yaml      | 2 +-
>  Documentation/devicetree/bindings/usb/cypress,hx3.yaml          | 2 +-
>  include/dt-bindings/power/amlogic,c3-pwrc.h                     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks!


