Return-Path: <linux-kernel+bounces-7020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A6981A094
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C9028AE24
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D04438F8C;
	Wed, 20 Dec 2023 14:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g48xcfpT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6654538DFB;
	Wed, 20 Dec 2023 14:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5329DC433C8;
	Wed, 20 Dec 2023 14:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703080855;
	bh=bNV5JM7xKsAUYcwprUbMnZFixPmrpPJW8BKQqEz7XZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g48xcfpTXR7nGcmBdsnnxLUiNeKnnH9QLO3KFWfI/bEgIKwmXeLjBq6KRZbAwUf6C
	 9loCfgsGpF0O/FmcW0KEmg1vxRYz02Uru7UBoCdDnm3d6N6La0oSNAsHq8M3HJNaoy
	 fUYozPI3zqu6Oc0lNwYbsRCglILuGnPu5K/4V+j3Hp7w/brbaU1E91IVVgl4QNectR
	 wO18JAqX2wxINn2TurBjufFG+DyZrXY2AnTP+8eGM3SZLXNmLBRrO66/Sh9TJ8eVDB
	 TpBb0n1zEN6CNMm621lUSwDJIcmpy2zVV0EVF/JAK5syO4SfkiY0zRFq20PM0z58Vs
	 YkSy6RI44sFcw==
Date: Wed, 20 Dec 2023 14:00:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ti-ads1298: Add driver
Message-ID: <20231220140039.7b50f874@jic23-huawei>
In-Reply-To: <02cbc31e-ec6e-4b3b-940d-da51567c197b@topic.nl>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.618139b3-8cb2-4e4c-9283-9e3787c70105@emailsignatures365.codetwo.com>
	<20231213094722.31547-1-mike.looijmans@topic.nl>
	<20231214111107.00002fd8@Huawei.com>
	<02cbc31e-ec6e-4b3b-940d-da51567c197b@topic.nl>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> > 
> > Should probably also document the gpios as the binding should attempt to be as complete
> > as possible independent of what the driver currently supports.
> > 
> > Lots of complex options for this device and the use of those pins, so maybe something
> > that can be left for now - but the patch description should then mention that is intentional.  
> 
> The device has so many options for connecting stuff... It's indeed possible to 
> (also) use it as a GPIO expander and as a clock source and more...
> 
> I'll put it in the patch description that the definition is incomplete by design.
> 
> The main reason I'm submitting is that this is about the third time I've 
> written a driver for this chip, and I'm sure that other companies are writing 
> their own as well. I'm hoping this will result in some joint effort to 
> properly support it...
> 

Fair enough. Incomplete bindings aren't ideal, but definitely better than no bindings
in my view.

Jonathan

