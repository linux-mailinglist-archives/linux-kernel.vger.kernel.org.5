Return-Path: <linux-kernel+bounces-45079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BDD842B76
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4721C1F256AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EAC156968;
	Tue, 30 Jan 2024 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqJSrCz6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D70D1552FD;
	Tue, 30 Jan 2024 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638000; cv=none; b=Iayr8lf4OhN1odlyOpkReHRG2xptxZCOG0eZFMiP5Z80wpRKODsf8dmTmUi3F7lBEVWCd7ptZH2qbp6H4AbDYo96o1SzLAUsZYXFRqVDy1p5LW7iR/qrktZgSCGWXhQjMHSsRLQ5HKW7kX1AIOhhBTlsQq5UGcUmMBHjkfcuVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638000; c=relaxed/simple;
	bh=GIdTm6f7d7BmLl8i5lDnE5AWSmgegEYhRm5abCEFR+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKGpOWe/WQYoNsdIpCgPGP7FMInMY7eY17aC9kL9dvNcGhh4+UYYE1R4ug/5t9c+5NpBeTO2+2zdaMEvV9u7GcQ+BqZlUCcfiE0QhNrgxMjwV48PaLKj2hiniFKkrXcWZjB+n+cAXg+5gC+TRqJWkZ+N6UrUubAGlrd87X+ODUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqJSrCz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368EBC433F1;
	Tue, 30 Jan 2024 18:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706637999;
	bh=GIdTm6f7d7BmLl8i5lDnE5AWSmgegEYhRm5abCEFR+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jqJSrCz64YAtJFSXxee1Fyt1jt3M/M/pWSyUGEJu1LgnoO0KZFpI6d1//HflEEQdY
	 zBRgKIHsIlbQ3szATGs6/+QUNE6ANL6LKXpixtI7qlJ58/1K65SbLZfDddSeccCDmb
	 qwn2gQkVgssJa68CmTJ0SW0oUa/hQAfHV/bt8Z7H2Q1wUeDKDqXixMHNF6NUdSpN1P
	 5ui3cVbfp72rB6QoSiN3ULxJ0uP9lC2MuazKdYVuV/jsSLl85ekBKBoZVAHlP9+Lyb
	 F/CTFHHs9DeePuJYawy9iREfOAC/BAeBSLjOI+WBF8qEuKbVWoKHCQID1KBP68cceG
	 s2DgNvDAL2Vlw==
Date: Tue, 30 Jan 2024 12:06:37 -0600
From: Rob Herring <robh@kernel.org>
To: Alexandre Bailon <abailon@baylibre.com>
Cc: conor+dt@kernel.org, linux-pm@vger.kernel.org,
	daniel.lezcano@linaro.org, lukasz.luba@arm.com,
	devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org, rui.zhang@intel.com, rafael@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: thermal: Restore the thermal-sensors
 property
Message-ID: <170663799643.2077654.17583005002545542190.robh@kernel.org>
References: <20240119110842.772606-1-abailon@baylibre.com>
 <20240119110842.772606-2-abailon@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119110842.772606-2-abailon@baylibre.com>


On Fri, 19 Jan 2024 12:08:40 +0100, Alexandre Bailon wrote:
> thermal-sensors was defined in thermal.txt but when the yaml binding
> has been defined, its definition has changed, dropping support of multi
> sensors.
> Since we are adding support of multi sensors, use the original definition
> for thermal-sensors property.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  Documentation/devicetree/bindings/thermal/thermal-zones.yaml | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


