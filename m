Return-Path: <linux-kernel+bounces-110873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CAC886512
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3BA285EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0494D3FEF;
	Fri, 22 Mar 2024 02:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afLtE0T0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3538810FA;
	Fri, 22 Mar 2024 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073521; cv=none; b=NomlHRKQJ+vecwMCycIEecH5rX2Fv6UD3Zo45WsIUys+VXHUcNiN0+SIfPdGa5TK1reyJG3Wf/CMGCj2gTBWo0uI4ONRXHsUylozQ6QfdW4nITc6gNJZJlha0v78Xf+XMTRpRD4f8ZKdaUI4aVIHffjs3TRklR0ssMlopT/9Sm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073521; c=relaxed/simple;
	bh=83nutzeefgsOE5CnvYG798Q0O8Wla+1+5aZYf7V8tL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpRaqtkt6LnuwM8wlPoPEEoNe1eWvT3dik+d/8Qmr3yWtNGJq3vEfGyPs4E3D72zx3fM4X0YYNbcz5GqulAMMqN1iIVf10xQaOLerbcetp8OpmIa8D21m7ByvUd3r3P7PBad9KxFEIdMXiboIgMtGKwMcAtXWzoGmFtJSZWqMmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afLtE0T0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB13FC433F1;
	Fri, 22 Mar 2024 02:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711073521;
	bh=83nutzeefgsOE5CnvYG798Q0O8Wla+1+5aZYf7V8tL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=afLtE0T0j/XfJkMMdDNkeaRrj1xuQ87Gs3WgccYlaqcIIS36e3KPftIhmnSmw3Gwp
	 Kv6f8YAwUAyl9s88Ibwkmr/0irZ8roqDT1pfe1uYSKf0balWVFcTQEG/9l5ObOZ+L0
	 olwWgDVlPrHFNPSHh/wt1MeZ61F7Nx71rk0DsT8y3CAm5hr4WMAgA11wBc09rMdV3q
	 DFTDOZd2FWtSn1bEbvyOSzHYv1alOdfx7Gflbh5PbXbpicpunXf00OA3e5J/UCtKsF
	 hQwUK3uILtiNHP8B4ml2RgOOoihF3KXmfI0d/GPLHDwaY/sK5yTOF+lQ/2FYC4izH3
	 HUxuIm6p4m0xA==
Date: Thu, 21 Mar 2024 21:11:58 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Conor Dooley <conor+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH 5/5] dt-bindings: hwmon: ibm,p8-occ-hwmon: move to
 trivial devices
Message-ID: <171107351631.3413678.6212026381128408904.robh@kernel.org>
References: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
 <20240321-hwmon_dtschema-v1-5-96c3810c3930@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321-hwmon_dtschema-v1-5-96c3810c3930@gmail.com>


On Thu, 21 Mar 2024 19:43:46 +0100, Javier Carrasco wrote:
> This binding meets the requirements to be converted to dtschema
> via trivial-devices.yaml.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt | 25 ----------------------
>  .../devicetree/bindings/trivial-devices.yaml       |  2 ++
>  2 files changed, 2 insertions(+), 25 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


