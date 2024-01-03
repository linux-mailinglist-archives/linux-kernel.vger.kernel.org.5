Return-Path: <linux-kernel+bounces-16128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FE482395E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81BF31F25E74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C827C1F95A;
	Wed,  3 Jan 2024 23:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhn/j3Vr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190F11F934;
	Wed,  3 Jan 2024 23:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C985CC433C8;
	Wed,  3 Jan 2024 23:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704326109;
	bh=PEthdAp+3zWMookKhUQxsGQkJ6hYoxY/CYvsN3+eEok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhn/j3Vr0qwnAJsaM07EcKB2P+tUDFOCTg1OdGXntUxmCEZI1jphVWPcEYpp4CzfQ
	 2fJ+/UudEUk1wvIXxuDORReUfR2m2RdhRbg1ORHe90FhlzeS4LjTWUUtjDELB3WyTE
	 d1A9wserDdXU8xHiruo1RtNLGyXPVCVlkRtRwhf18Kj+LOs3xAA2010ow/3AfC34AO
	 pWf5wtGwHHStZnkHMXhD9VeOAMFP0Lis43es5at7YuYdyzbQyp0z9tOqMGiXcatiCM
	 rcP+0NHPY6onc7GCOr6nHtMukjQ0dHyjiUl6DUa5lUAmCFKZcOQlRDk1qECQ8UHKlq
	 82Gr305HTg1kQ==
Received: (nullmailer pid 2038538 invoked by uid 1000);
	Wed, 03 Jan 2024 23:55:07 -0000
Date: Wed, 3 Jan 2024 16:55:07 -0700
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, Bastian Hecht <hechtb@gmail.com>, Michael Riesch <michael.riesch@wolfvision.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/4] dt-bindings: input: touchscreen: st1232: add
 touch-overlay example
Message-ID: <20240103235507.GB2036885-robh@kernel.org>
References: <20230510-feature-ts_virtobj_patch-v6-0-d8a605975153@wolfvision.net>
 <20230510-feature-ts_virtobj_patch-v6-3-d8a605975153@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510-feature-ts_virtobj_patch-v6-3-d8a605975153@wolfvision.net>

On Wed, Dec 20, 2023 at 09:39:45AM +0100, Javier Carrasco wrote:
> The touch-overaly feature adds support for segments (touch areas) on the
> touchscreen surface that represent overlays with clipped touchscreen
> areas and printed buttons.
> 
> Add nodes for a clipped touchscreen and overlay buttons to the existing
> example.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  .../input/touchscreen/sitronix,st1232.yaml         | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>

