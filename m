Return-Path: <linux-kernel+bounces-47046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DEC84486F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 444901C23790
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2DC3FB17;
	Wed, 31 Jan 2024 20:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmQOhVug"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371493EA76;
	Wed, 31 Jan 2024 20:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706731758; cv=none; b=cW5gcQPunCrm2NEeDTZO7YPjCw1ugqhT0Bq+9uxR09Keqns+T/k4gzkWIT3iDjrak4vEEl2AFA66pwM5CIOxppdfK06NfxhIWfmxFS6g05ABKkCEvQw0PXEJmARiS9ccMwOooRer54NAWhFGNfncYpXeR26Gk5fSF8DdvksnjqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706731758; c=relaxed/simple;
	bh=iwCzJJpR5ei5UHsd7esL/VrKFPOdfTAP5MDzAArWRNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpBaXTIyTyxvvp/d3RGaanWEJBUY2DkuCopjFLm7CjJQMEWaXbvW2L/66+dW7DrRwmPf/A9NusJdXItkc23tc/yrxRQ79v6CJblKc4Y1XcIU0eHfUUgPvOtSwV4kQgTy6OzTsgD1DCkKED915Hz4IRUE0itewuLYdSo5H/hn0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmQOhVug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C893C433F1;
	Wed, 31 Jan 2024 20:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706731757;
	bh=iwCzJJpR5ei5UHsd7esL/VrKFPOdfTAP5MDzAArWRNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kmQOhVugMUw9TR2k2kay4pVZfPaf1Ocn7V9d3OZzHBriRaUvREKZHclk0j1oYrXVC
	 kQABLihhuPnqItT2NLn4b/a4CopARHyt9EqyuCicY3fDuPfxq9cGp9x4sl3uHOv938
	 bRC3QkQPd/cWfuyURMQI8+y3jjaNrFtd98qQeAuaxFpN9Esp8p5eqBg+12AiEy1CeN
	 F3RQYz2va/J6vxfgNag6ahMJWnO020EQxLnlq+FSsdr31U8xMgECghO+qTc7Tn96uP
	 71zVGHsavZGcXFBKdvVWREogJjtyF1S0nnP7mJg0bySkbJDpH+lEUup/SjPLjivfsY
	 H51I2JRNMd67g==
Date: Wed, 31 Jan 2024 14:09:15 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	git@xilinx.com, Moritz Fischer <mdf@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, monstr@monstr.eu,
	Xu Yilun <yilun.xu@intel.com>,
	"open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4] dt-bindings: fpga: Convert fpga-region binding to yaml
Message-ID: <170673175226.2219463.1221634595095812617.robh@kernel.org>
References: <37b107d86b39ef4bc9c482b57b27de8b92c3fa43.1706530726.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37b107d86b39ef4bc9c482b57b27de8b92c3fa43.1706530726.git.michal.simek@amd.com>


On Mon, 29 Jan 2024 13:18:53 +0100, Michal Simek wrote:
> Convert the generic fpga region DT binding to json-schema.
> There are some differences compare to txt version.
> 1. DT overlay can't be described in example that's why directly include
> information from overlay to node which was referenced. It is visible in
> example with /* DT Overlay contains: &... */
> 
> 2. All example have been rewritten to be simpler and describe only full
> reconfiguration and partial reconfiguration with one bridge.
> Completely drop the case where fpga region can inside partial
> reconfiguration region which is already described in description
> 
> 3. Fixed some typos in descriptions compare to txt version but most of it
> is just c&p from txt file.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v4:
> - permit only object type as additionalProperties
> - describe also optional reg/ranges properties and remove required
>   #address/size-cells properties
> 
> Changes in v3:
> - drop fpga bridge and mgr descriptions in example
> - use additionalProperties: true
> - use fixed-factor-clock instead
> - fixed matching pattern
> 
> Changes in v2:
> - Fix typo in subject
> - Fix comment in bridge example
> - Change license back to gpl-2.0 only
> - Do not define firware-name type and add maxItems 1
> - Make fpga-bridge phandle-array
> - Drop ranges property because of missing reg property of fpga-region
> - Also describe case with fixed clock node and axi bus
> - Fix fpga-region names in example
> 
> Please let me know if there is a way to describe overlays to dt root to be
> able to reference fpga region back.
> 
> fpga-region without MMIO access is also permitted that's why there is no
> need to describe reg/ranges and #.*cells properties for these cases.
> 
> ---
>  .../devicetree/bindings/fpga/fpga-region.txt  | 479 ------------------
>  .../devicetree/bindings/fpga/fpga-region.yaml | 358 +++++++++++++
>  2 files changed, 358 insertions(+), 479 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/fpga/fpga-region.txt
>  create mode 100644 Documentation/devicetree/bindings/fpga/fpga-region.yaml
> 

Applied, thanks!


