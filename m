Return-Path: <linux-kernel+bounces-155283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2A58AE82D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC374286617
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D32136E22;
	Tue, 23 Apr 2024 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5sk8Nfj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54AB1369AA;
	Tue, 23 Apr 2024 13:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878986; cv=none; b=L2587U2wstsCe/CpNQyDt+DtJ6nZrb3BhmuHndBYQZFa4zbkTt2BwTWSONiZIc6DzWCQE6zPx5/x2xA/ck8NUg33matZNGPmOlzy4d+D2KwVczkb+IjR3VEhA07O2/FgAKD7iHrIYu63vqwTaDrEuFLU5I3eW4JfSnaQ5k9dKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878986; c=relaxed/simple;
	bh=Fyu4b9RZe8mgVZwzTIzwaINuohtH8Odr5WusUgjVeuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqM7aAT2Di0Nfu+dEHHJmTXB0/kUTqORg2V9/qYhEacCA04R2ZbW2A7VNlmvNumY8201NA3VpLpYkcOuKTLn6ThIEDYOzjbgpnNg6/FCwQ9LEB5vtQIHQdHmxSyXDhqOdLlcnB9vG0lMSJ23v41CZ7/fPRxrLQZ6PaejhusUgG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5sk8Nfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2896EC2BD11;
	Tue, 23 Apr 2024 13:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713878986;
	bh=Fyu4b9RZe8mgVZwzTIzwaINuohtH8Odr5WusUgjVeuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5sk8Nfj4L38+yWRrVpPVa/e/cD8jqo8d5KlnLblop/Ttc+Dym/arRxQvTrrjKzWc
	 q3/BXk1UjeiuzfQ7CkA8T8/uZFKzHzLr5uJF+BaFChbVCdtDuV9Ni3t0+zf79IZr7T
	 y6r/mM5GnyxETqt3hNOBfDAvS9mfK1G5yaD9dLzLG58xpHHUEti9C8RqKUIfpOTJ03
	 cubC1vvx+kKkPXvhnO4SiK3FzV8/rjPKWbqxHRQdEZ0cRH+IdoGmni8CuXze1Xgywh
	 0Xclk25rdRt3Jxa6N49QxSFowljnf0kQenH1K2MkRSKoP5qQXFDA/mN8v6EHV3JIE4
	 eVmCIom28ZBAA==
Date: Tue, 23 Apr 2024 08:29:44 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: renesas,irqc: Add
 r8a779g0 support
Message-ID: <171387894066.77572.6530621023538799384.robh@kernel.org>
References: <264cffccfbb1f92657420f5f869236b06a97d958.1713280616.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <264cffccfbb1f92657420f5f869236b06a97d958.1713280616.git.geert+renesas@glider.be>


On Tue, 16 Apr 2024 17:18:59 +0200, Geert Uytterhoeven wrote:
> Document support for the Interrupt Controller for External Devices
> (INT-EX) in the Renesas R-Car V4M (R8A779H0) SoC.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/interrupt-controller/renesas,irqc.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!


