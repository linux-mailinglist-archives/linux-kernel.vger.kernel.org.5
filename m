Return-Path: <linux-kernel+bounces-50525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6E3847A3A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BB8228CECD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECF08063D;
	Fri,  2 Feb 2024 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UX6uNGbB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67583A03;
	Fri,  2 Feb 2024 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706904176; cv=none; b=sn77OdyIv2kYiggLaO+JvQNbPesT17vfyYvObM0wW42J1Wr4u8ab14e7qWjVdZHKw104HwJnNbY/89j9srPoMiRXt75E3k8WpguFU3JcTUbj8zYqetRjFkxooSS685D7652/pspCiHUHgLNv4PBlsNoHkXPlVrv5Drn6OmRLrcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706904176; c=relaxed/simple;
	bh=nIysIOI7opT1HAnMInnR3sU1pkX9Nj0BNAZHI42Pbiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgQgPlkkDhM40vgtObfOqyitLsk18zACpcKq+ybtccMAfXR7adrLiK9aDXaw4+AI9wclHxuCSfIqiM/C3UTlEPLnwYXTXcIH2+9VpmbNmOL9vhIykz+9baC1YfCQ+KUgDDKemw6qOGH0kWsm9UEFh9kS/4k1ZauySgxeGvAm/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UX6uNGbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3087C433F1;
	Fri,  2 Feb 2024 20:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706904176;
	bh=nIysIOI7opT1HAnMInnR3sU1pkX9Nj0BNAZHI42Pbiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UX6uNGbBpq/Rlk9dSp2KQEOEZRPGiBmRvSBSCJrfWpQ+kU4FTLahnJU6n2X9qosOq
	 tlDUBXKXHcRPU9Ovlzh8KY42qrrosNmZFJzcoJo+T5MHXvCRMbmEFF7cyp1lHH66lV
	 jZWLWTsQmPDfAZyNEhhQR5GHApNzia/2kAYWJ+XOXVMS61avTsFjWhQeQNJsT5ebJJ
	 2NKXeNpt46BI7ziowbhnesDbL1dSXwIf6FQYfsC70VUrNmS2fJkYlNKFgPGlmzjGRs
	 IBtSdwKuxWhmLBur63XIlZdDwEv1KIkehfwgHxG0ndvIUruVGse+oJtCL2vZJT5vzD
	 lKnK8J5Ua5V1w==
Date: Fri, 2 Feb 2024 14:02:53 -0600
From: Rob Herring <robh@kernel.org>
To: Dragan Cvetic <dragan.cvetic@amd.com>
Cc: Michal Simek <michal.simek@amd.com>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"Erim, Salih" <salih.erim@amd.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5] dt-bindings: misc: xlnx,sd-fec: convert bindings to
 yaml
Message-ID: <170690417008.874488.5757943525065117413.robh@kernel.org>
References: <20240131170650.530079-1-dragan.cvetic@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131170650.530079-1-dragan.cvetic@amd.com>


On Wed, 31 Jan 2024 17:06:45 +0000, Dragan Cvetic wrote:
> Convert AMD (Xilinx) sd-fec bindings to yaml format, so it can validate
> dt-entries as well as any future additions to yaml.
> Change in clocks is due to IP is itself configurable and
> only the first two clocks are in all combinations. The last
> 6 clocks can be present in some of them. It means order is
> not really fixed and any combination is possible.
> Interrupt may or may not be present.
> The documentation for sd-fec bindings is now YAML, so update the
> MAINTAINERS file.
> Update the link to the new yaml file in xilinx_sdfec.rst.
> 
> Signed-off-by: Dragan Cvetic <dragan.cvetic@amd.com>
> ---
> Changes in v2:
> ---
> Drop clocks description.
> Use "contains:" with enum for optional clock-names and update
> comment explaining diference from the original DT binding file.
> Remove trailing full stops.
> Add more details in sdfec-code description.
> Set sdfec-code to "string" not "string-array"
> ---
> Changes in v3:
> Fix a mistake in example, set interrupt type to 0.
> ---
> Changes in v4:
> Set interrupt type to high level sensitive.
> Remove '|' from descriptions, no need to preserve format.
> Remove not needed empty line.
> ---
> Changes in v5:
> Apply allOf to clock-names and put permanent clock items
> inside enum.
> ---
>  .../devicetree/bindings/misc/xlnx,sd-fec.txt  |  58 --------
>  .../devicetree/bindings/misc/xlnx,sd-fec.yaml | 140 ++++++++++++++++++
>  Documentation/misc-devices/xilinx_sdfec.rst   |   2 +-
>  MAINTAINERS                                   |   2 +-
>  4 files changed, 142 insertions(+), 60 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
> 

Applied, thanks!


