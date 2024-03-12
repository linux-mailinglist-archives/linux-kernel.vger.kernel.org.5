Return-Path: <linux-kernel+bounces-100377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B41879684
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1483284526
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8346E7AE7D;
	Tue, 12 Mar 2024 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk15nKWb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA9978286;
	Tue, 12 Mar 2024 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254343; cv=none; b=fuF8PQXmiVEhylsSB+J1wWCZIf780eVqJszUPSIu+aYwOQR5G+Cdx0b2644CGEktnXvmthu306BuUyksORWQxuHQviV2tIOTkZP/vmntqM2L29/K+lO8P/ojEf81RFjY9IDXl3usDVrtCJgVQ+TSq9NpKyjaxwc/PY6ZrYO9zYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254343; c=relaxed/simple;
	bh=/Z2dRN0q7F8MZHucPON6tOK3BRflqMmKjUqtKpm71Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIYlwDwwae/J7ocqdQRzqtZTa31YkDqajjwVThPgxDohMm+JCUUqpgxwEDdk6uu40nhPss728PLuj63ogPLWP24h6ouh1PUDkzw2pKlK+8WRCCs9tvB7HaaeTXn81CFjEtBc23wMGBz/5cUgN4xpNv9xXxHDZDy/IyD8tGCkaPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk15nKWb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190C4C433C7;
	Tue, 12 Mar 2024 14:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710254343;
	bh=/Z2dRN0q7F8MZHucPON6tOK3BRflqMmKjUqtKpm71Cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qk15nKWb3ry5gpfvIhUYFSccnXh7w+au8jty/cGGtdFxbeKX2wfSQ+eQyuVr0R6HL
	 gr7/1js5B8SXU33710L8N/dyCsdFhEKLUuUZYg2X4fRUJ2Dz/knhfpOb/Dutqu4Ium
	 woC5M8i2dvluKwB+CSLI5wEo6Zt0bTKqciigmraKSeCoGAE/B78MMXhWuTSHbLx7Xn
	 CReD7Wn2yP8tsFrnslqVsOerUQ8plcqtYsKyHRVB4qDQdoKG1ZzHNetXRGNrZOZLHQ
	 7Te4Zg8BVez1mpvMvf14R3Nf+ybC9n4Puz6OVCiKkfLECTAI5dPqouVV95dy+OcpSa
	 yYeCoNqEMyO+w==
Date: Tue, 12 Mar 2024 08:39:00 -0600
From: Rob Herring <robh@kernel.org>
To: Nikita Travkin <nikita@trvn.ru>
Cc: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andy Gross <agross@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: platform: Add Acer Aspire 1 EC
Message-ID: <171025431615.2202401.13229596237294661341.robh@kernel.org>
References: <20240312-aspire1-ec-v4-0-bd8e3eea212f@trvn.ru>
 <20240312-aspire1-ec-v4-1-bd8e3eea212f@trvn.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-aspire1-ec-v4-1-bd8e3eea212f@trvn.ru>


On Tue, 12 Mar 2024 13:42:07 +0500, Nikita Travkin wrote:
> Add binding for the EC found in the Acer Aspire 1 laptop.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  .../bindings/platform/acer,aspire1-ec.yaml         | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


