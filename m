Return-Path: <linux-kernel+bounces-148082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 496E88A7D74
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E5D286409
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461676F071;
	Wed, 17 Apr 2024 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ra+VbcNo"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CBEE572;
	Wed, 17 Apr 2024 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340423; cv=none; b=VQy2LmMTEyNLB5cSvS/41NEOKiRJ6i7U49QqkB5FJZBzwFn6pnbnxxiWGCQQbJ0pP3vKG5PtuAqPxKXuJCVMK9sz3dw/VloHmumaBm1vp5lMgqPxs5tnTQF4EVnKU4zLtnPP0CsNbKrTGbecpDksjrhKyyrvLkW4AXjRR7LNucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340423; c=relaxed/simple;
	bh=zxQwkjqyRweBxgoFE3rDOnnMsDuJWVTiZBoGw+2McUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWUMSf6JJjy1txVwS+5OK8nAtVFdT9zS7LofxZMpedbEDoaTFYxj7VYCHirTOMi0EnqAD7Y+A4LnO/nbdpbqMYuVKUDWwXrmXaLPPYvwzpl7WlYJ/kCOJ1aOk1WEHIHoPYgFMr+hwel7MpfyObiHM5TRgDZiljgVkFAthHf0Ols=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ra+VbcNo; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 9FDA61F9D0;
	Wed, 17 Apr 2024 09:53:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1713340417;
	bh=T8LyzfeyBql0P3ceDzj4gRJtW4wteayDdb4INRsfL5w=; h=From:To:Subject;
	b=ra+VbcNotEwkaIbxhfvzpphxJY5o1PImKIUApw6uLozpWT/bv+BTjumdRwqQmCK2G
	 K8utf4L31w+7Vs0cO2dZod4j/yuSdi0WOPF1Bjv2c+vxaiGg8qxIjboDO3lXl1qOWe
	 FlpPLYyNn/97JvzaxjT94gB8rS1kvsYGB7G7kdo6cwjOlRRrF6kfjF188KPvqenMJo
	 mHWPYAaEIAXV5oXwQYRpFRCHZCB4eAnbxd3pARO2UFlIrbdHJHL0REy7HzgTGCpxX7
	 5WwZWPzmkwO2FHtev8P/V0inPqHVl3TrCxq5XuOCmG6BNiItdMvdgTjCiRqdPond6u
	 yF5E5xhwvWC/w==
Date: Wed, 17 Apr 2024 09:53:32 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: nm@ti.com, Stefan Eichenberger <eichest@gmail.com>
Cc: vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 0/2] arm64: dts: ti: k3-am62-verdin: add sleep-moci
 support
Message-ID: <20240417075332.GA7036@francesco-nb>
References: <20240301084901.16656-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301084901.16656-1-eichest@gmail.com>

Hello Nishanth,

On Fri, Mar 01, 2024 at 09:48:59AM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> This patch series adds support for sleep-moci to the Verdin AM62 in
> combination with the Dahlia carrier board. sleep-moci is a GPIO that
> allows the system on module to turn off regulators that are not needed
> in suspend mode on the carrier board.
> 
> Commit ba9d3cd71f15 ("dt-bindings: usb: microchip,usb5744: Remove
> peer-hub as requirement") from linux-next is needed to make DTB_CHECK
> pass without peer-hub set for the hub on the usb1 interface.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Is this series on your queue? Any concern? I noticed you applied more
recent patches but not this one, therefore asking.

(I know you are travelling, I just want to be sure this is not getting
 lost)

Francesco


