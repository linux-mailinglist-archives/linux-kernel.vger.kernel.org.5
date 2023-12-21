Return-Path: <linux-kernel+bounces-9073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 406D081BFEB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1051C22BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA2176DB6;
	Thu, 21 Dec 2023 21:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCAtLF24"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4D676DA1;
	Thu, 21 Dec 2023 21:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C37C433C7;
	Thu, 21 Dec 2023 21:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703193118;
	bh=njb5ZTTPXp5fHgYk6dh4ZkqF1BltWHZDNwTEvr8ost4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCAtLF24Ev0GXMsgBkiA6Y4wELClG2bXexq7pvA38R7mMSDxozs8KWCuBM2h7g0cX
	 mPTmrWGVIDB7MNVwysFmwwPrPpDNgvXle8XaacCl4DFNYNGtswHSGlqzWL3VGqs6O5
	 Q+RDH/1KoADirm1BIMKmPa+62LkI20HFhG8QZrhX7pK8bUjXWhzqTdYDoTd1Txg73L
	 KDMznuA5KnbG5/ev40q3dZtU7Qv5dC8r52gkiPNMRG7zdhdc6ERTDZDS73YM2kKZVC
	 hOUHWF9pqPiqDPc4Y1EpzJVdGgSrC5E1mW3kikAzr72EWXCGAsEqr3FPk08SlYYGGJ
	 pqCM0VmW0LSXw==
Received: (nullmailer pid 101568 invoked by uid 1000);
	Thu, 21 Dec 2023 21:11:57 -0000
Date: Thu, 21 Dec 2023 15:11:56 -0600
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, michal.simek@xilinx.com, Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org, monstr@monstr.eu, Rob Herring <robh+dt@kernel.org>, git@xilinx.com, devicetree@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: serial: Describe ARM dcc interface
Message-ID: <170319311633.101509.1532196763061569676.robh@kernel.org>
References: <9d7e85914eb1cdb313b28cb019093a84dd9b4773.1703167505.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d7e85914eb1cdb313b28cb019093a84dd9b4773.1703167505.git.michal.simek@amd.com>


On Thu, 21 Dec 2023 15:05:09 +0100, Michal Simek wrote:
> Debug Communication Channel (DCC) provides the way how to pass data between
> target CPU and host via JTAG interface. Every CPU has own interface for
> communication via dbgdtrtx_el0 and dbgdtrrx_el0 registers.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> This communication interface is used for flash programming on Xilinx
> SOCs from U-Boot.
> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/serial/arm_dcc.c
> 
> ---
>  .../devicetree/bindings/serial/arm,dcc.yaml   | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/arm,dcc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


