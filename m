Return-Path: <linux-kernel+bounces-5523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 213F7818BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7362865A9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3861A1D130;
	Tue, 19 Dec 2023 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQYT0AiF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6EA1CF8D;
	Tue, 19 Dec 2023 15:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE22C433C7;
	Tue, 19 Dec 2023 15:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703001343;
	bh=Q13RYne6oAAu2A1c6nbVonpf8SXJBoK4LC2Jg1dY1JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQYT0AiFYlah4357+s7DMp7/GIamAB2XrDiN5AY/+fUXgyclLK7RPLvGP9JuP1olx
	 4KHd6HvJA+3db9IvULtMZsSladsYOk5yeI5pys/iFC++yAs76z68wGFKLRjwRBGsoK
	 X7da6Urz0XO7inBFtdFI156FrvRlzKWAO4faKKwnKl/3Kc/Sq47sersNEX+1FxH2U5
	 1OLSb2dDSQq+M2/qQd/NaJPdbzvmFAuyLPhFBLFC3k+cRok6IXdplYMvokohV/6bYR
	 MSJy8heVnRlMyBN6QJ+RcCT6YCOsptMKUr7SkZs77mag9V+OyY2DIV1n/4JVMhg/XX
	 244ztYAUjPX1A==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rFcRZ-0008Iq-0I;
	Tue, 19 Dec 2023 16:55:41 +0100
Date: Tue, 19 Dec 2023 16:55:41 +0100
From: Johan Hovold <johan@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: reset: qcom-pon: fix inconsistent
 example
Message-ID: <ZYG88VLLx1nEPOua@hovoldconsulting.com>
References: <20231130173017.12723-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130173017.12723-1-johan+linaro@kernel.org>

Hi Sebastian,

On Thu, Nov 30, 2023 at 06:30:17PM +0100, Johan Hovold wrote:
> The current PON example is a bit of a mess after converting the binding
> document to yaml and in the process updating parts of the example to
> match the pmk8350 binding while leaving parts from the older pm8998
> example in place.
> 
> Clean up the example and make it consistent by adding some newline
> separators; dropping labels; removing stray spaces; fixing the PON node
> name; and fixing the unit address so that it matches the interrupt
> specifiers (which re-encodes the PON base address, 0x800 => 0x8).
> 
> Fixes: 76ba1900cb67 ("dt-bindings: power: reset: qcom-pon: Convert qcom PON binding to yaml")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

I noticed that this on is not yet in linux-next so sending a reminder.

Johan

