Return-Path: <linux-kernel+bounces-126738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B75F0893C21
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C37B2826D3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E02141232;
	Mon,  1 Apr 2024 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGcuh4kC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B673FB87;
	Mon,  1 Apr 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711981214; cv=none; b=L1XPhNIFFd6LZqgTaOPZsosB8gyefGR+xDpLaIKdDe/GA/QxdOEXVmmDP72A4eFKg7H8/J66pAV+k8iQd1MwooGUNtvOghAC1azxG07bPMJYPVdFzlYGTVmeTZGRgP+TfMAx6o15/ABA1eGPV1s0FwC/EknQg0yIxC9k7XDL158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711981214; c=relaxed/simple;
	bh=fEhdWcLpquHd+lbmBESf9t4uPQfxYP1y6lxADCWgg04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shiA54M9DZwltDG+jblnfrLJUtjrll3/Gt9qh1XJnhnzzHFAURI4h7Wq/mcpMlVIv5pyYQcey4UG2oMwGdW4ZtsX2u2vwixyAfa5LxNE9dIQ5q8EP6EAknnG1Nqp6bhIqaIQ0wuTqL+A7CjY5UAZDP7sy7AC4g1Sr6bPxD2hj14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGcuh4kC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB911C433C7;
	Mon,  1 Apr 2024 14:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711981213;
	bh=fEhdWcLpquHd+lbmBESf9t4uPQfxYP1y6lxADCWgg04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FGcuh4kC3FqMSu3Uq5v5fPwJyGgS6OvrLis/rIIVu/1mjzDpwX0t1XVAN/PQmsJJ5
	 Bhe9RVKJ5TYugmplYfdT10kCa3bJ6hjWBHKQyZizuBTw5LHQtuVhpUFvuqTlvYT2wR
	 DLeUGWcWswLaBKPL4dZUh/ow7DsrVSLhDjgwLYE9igY41Vt8S3CfTKafIOazJriDtW
	 rehTntabbpsome92Qrs2Lnu1j8VFbrJMor+BrwdwzdQqAzp13MsL4EsMgDgpq3ijgS
	 kZmvJ5fkpMiwMhPFEF3wpzJFdElvwqJ55Fuz7ySHfyyQwRPC78Pyx5aUJjVBL/2Aht
	 0xae6bcv3LKmg==
Date: Mon, 1 Apr 2024 09:20:11 -0500
From: Rob Herring <robh@kernel.org>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: neil.armstrong@linaro.org, jbrunet@baylibre.com,
	mturquette@baylibre.com, sboyd@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
	martin.blumenstingl@googlemail.com, kernel@salutedevices.com,
	rockosov@gmail.com, linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/6] dt-bindings: clock: meson: a1: pll: introduce new
 syspll bindings
Message-ID: <20240401142011.GA537763-robh@kernel.org>
References: <20240329205904.25002-1-ddrokosov@salutedevices.com>
 <20240329205904.25002-2-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329205904.25002-2-ddrokosov@salutedevices.com>

On Fri, Mar 29, 2024 at 11:58:41PM +0300, Dmitry Rokosov wrote:
> The 'syspll' PLL is a general-purpose PLL designed specifically for the
> CPU clock. It is capable of producing output frequencies within the
> range of 768MHz to 1536MHz.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  .../devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml     | 7 +++++--
>  include/dt-bindings/clock/amlogic,a1-pll-clkc.h            | 2 ++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> index a59b188a8bf5..fbba57031278 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> @@ -26,11 +26,13 @@ properties:
>      items:
>        - description: input fixpll_in
>        - description: input hifipll_in
> +      - description: input syspll_in
>  
>    clock-names:
>      items:
>        - const: fixpll_in
>        - const: hifipll_in
> +      - const: syspll_in

A new required entry is an ABI break. Please state why that's ok or make 
it optional (minItems: 2).

