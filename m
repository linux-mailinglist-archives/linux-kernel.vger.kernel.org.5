Return-Path: <linux-kernel+bounces-95773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4048875257
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972491F23E5E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9954D12D775;
	Thu,  7 Mar 2024 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTe6xz+t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D080E127B7C;
	Thu,  7 Mar 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823133; cv=none; b=MrMuWbN6N3vpNuh+XMd1dMdL5jtF0QorlBk6njtABGEeLQp1lRj6rQsN16906ad6zzqM9wMapXsnXWK8lMtCm7aS0iP7QKoPhKi82FvV+2IMLvzzPDBHFoq5UwMBxFqjFu1Kfxn3SXFLHeJ5Mnosmqk4IGB6J97q0+bM3wLoIPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823133; c=relaxed/simple;
	bh=ZscmK6I0AMsgAV0JKmQuVIW/MQy3oRvjWEQXFP9oIUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSla3/csaHaPYAeU6awLK0vhVqm1t8pNPFv03dPCqCknJrfhue8Etu1kSF6Kcq6Ra1ajJhmR4qrhkesaHXL62mWb9mkwHp4YAYJeBWxq06N96vWn9tOjIuGF9UH0UrHOqPI0zoBg4cWDoxILkdW65I3Ni2wbsNWrL+TGTIfb1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTe6xz+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23950C433F1;
	Thu,  7 Mar 2024 14:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709823133;
	bh=ZscmK6I0AMsgAV0JKmQuVIW/MQy3oRvjWEQXFP9oIUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTe6xz+t+b2O26zPADjx3LZmWIu3i+nxHPt85N4EBUtDbxfwdqf1ETZvBvOyn2pr7
	 jONiLY9WKMslE0wlk53Le/GCidLCftZmarVvmDwgjtHQnL+VYjEyhcFkA31ToVI7QM
	 L6Ms/EldTngBZCHml0oxrbDJN3ABZ+ekxGD6b1xacxx8d3BjLodjmsASDcu1uCboAI
	 8ZNc9IfCSRED1vgkyox83iP144hbG9FRy4uEmmv7npCLlN8nXvErWI/HJErx5Za0kt
	 Ir5c185bpz4VCmBBmQHBA0JICOjRlA6ud+Y8xcoDDPRKzedx1M6QcOcsdB8t02cYjA
	 SP9IiTKeOdKFA==
Date: Thu, 7 Mar 2024 08:52:11 -0600
From: Rob Herring <robh@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: linux-kernel@vger.kernel.org, sebastian.hesselbarth@gmail.com,
	devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org, andy@kernel.org,
	gregory.clement@bootlin.com, linux-leds@vger.kernel.org,
	andrew@lunn.ch, geert@linux-m68k.org, conor+dt@kernel.org,
	robh+dt@kernel.org, lee@kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: auxdisplay: Add bindings for generic
 7-segment LED
Message-ID: <170982313063.2579205.11281655136132729632.robh@kernel.org>
References: <20240306235021.976083-1-chris.packham@alliedtelesis.co.nz>
 <20240306235021.976083-3-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306235021.976083-3-chris.packham@alliedtelesis.co.nz>


On Thu, 07 Mar 2024 12:50:20 +1300, Chris Packham wrote:
> Add bindings for a generic 7-segment LED display using GPIOs.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v5:
>     - Preserve formatting, maxItems set to 8, group GPIO specifiers
>       as suggested by Geert
>     Changes in v4:
>     - Add ASCII art diagram showing arrangement of segments
>     Changes in v3:
>     - Set maxItems: 7
>     - Expand description of segment-gpios property.
>     - Use compatible = "gpio-7-segment" as suggested by Rob
>     Changes in v2:
>     - Use compatible = "generic-gpio-7seg" to keep checkpatch.pl happy
> 
>  .../bindings/auxdisplay/gpio-7-segment.yaml   | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/gpio-7-segment.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


