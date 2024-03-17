Return-Path: <linux-kernel+bounces-105559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BE887E02E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74155B213AB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2784208B0;
	Sun, 17 Mar 2024 21:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC1CMNaM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB6C210E4;
	Sun, 17 Mar 2024 21:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710709981; cv=none; b=IZS6B1WeZCpJuO5K8y5DxXW0ZM2kqXVfnA0MeQAlbebThA98DRK/4yRnIlGg1dt0mHMnSIydkPcCkFgEB0Kra6pvHIyE4y14vuDmTwwxDjmMV3oI5D5RJhv0XSz1AWRGq59LzlFMm9K1v/2GANG9mWnE9MMZdl1T3nk9B1zDi5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710709981; c=relaxed/simple;
	bh=PmiuLK52hkrWz7/HAWcs7jLAFh7vCyOGueeN7Ihy9Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTE1FaIahz/ASZjMp+Gd/uEerv2shwOgi0l5X7Is3tAFMtmu7hED5lKxbHaSFXoMr2eGnOVcC33vPpO1SjafUE/DFPROjftbhLAYp+5QyKA6GQtZEKTZ3SfGjqFRzRKJt5cVhuu7pPAiMqIxnsCQaxVqreaK3kcGuQLt8OTwOSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC1CMNaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E28C433F1;
	Sun, 17 Mar 2024 21:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710709981;
	bh=PmiuLK52hkrWz7/HAWcs7jLAFh7vCyOGueeN7Ihy9Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PC1CMNaM+18KSODnFSThZHmgW19sWb0XICnEQfIYWTy4KG3KnHWa66y7V7l5NhsM+
	 uIxMQXqFPC+MYzQLamCJhKMgAizKJxSnDuIw8jRDUVTVf0gthwrsYdRS/dOBXczi/U
	 x1GnJ4n8a1B6L15CM4S02TcspajTQzeixPSTvZsCxv/KH5S7jeEqKVWpOk5OXQifnG
	 iv/VUJrwJunvA5krHAGYrGXXomAkyYjk2x1vhI6NxWIjVAf0Y9YtKpdKP4yYuFsZ8b
	 EbxOXWhvCNQb8JWM1mKy/q9Gbo2Wok9xcDTawrPPQcgeyu2sWSNkaoMajycvJuzSu4
	 g6HDsWqthgabQ==
Date: Sun, 17 Mar 2024 16:12:57 -0500
From: Rob Herring <robh@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Richard Alpe <richard@bit42.se>, linux-kernel@vger.kernel.org,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
	Michael Walle <michael@walle.cc>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: Remove fsl,t1023-sfp in favor of
 fsl,layerscape-sfp
Message-ID: <20240317211257.GA2317294-robh@kernel.org>
References: <20240316002026.1808336-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240316002026.1808336-1-sean.anderson@linux.dev>

On Fri, Mar 15, 2024 at 08:20:25PM -0400, Sean Anderson wrote:
> These bindings document the same hardware (just different minor
> revisions). Remove the newer fsl,t1023-sfp.
> 
> Fixes: aa1ed6047107 ("dt-bindings: nvmem: Add t1023-sfp efuse support")

I don't think Fixes is appropriate here. What was broken?

> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>  .../bindings/nvmem/fsl,layerscape-sfp.yaml    | 21 ++++++++++-
>  .../bindings/nvmem/fsl,t1023-sfp.yaml         | 37 -------------------
>  2 files changed, 19 insertions(+), 39 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/fsl,t1023-sfp.yaml

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

