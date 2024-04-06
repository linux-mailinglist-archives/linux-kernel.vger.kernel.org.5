Return-Path: <linux-kernel+bounces-134034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8294F89AC59
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990691C20CAE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8718740851;
	Sat,  6 Apr 2024 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDSyDmJd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDB6405FF;
	Sat,  6 Apr 2024 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712422324; cv=none; b=b5hho00ZX+bOnG2HM1z8B72M1skyN4yK8F9O3BwaZhya1HOXdNbPGkCC1P/gQSjSNo5o8ToVoOId75SumKdfFE+maxIYTIIBRht6rjeG95SBOu/UtuGrL+9VtGoTve8VDQu6TlLYR8EEbt+l49zKssGFsrJahuTXafg9fPPKUs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712422324; c=relaxed/simple;
	bh=I54NXFbkQcPOBxp/oFLSaWT2pCoL0Ch2SA3oANFNikQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHsOqj5Bzh+V2Qll9P0OjIcuE0bSv1U1bbKFuXMRSA8mFhd3gmysdrv45xsjCxEZHmJZg2cuQ7pVcWcm5EQ3BCriPr6O2sW8RKFRPEjHUvHG9hKwXEM8W06yotugjWxTiEVe7z4aqvuxJRTWhRE+e0FwMkooZKEQ7rveGVENmlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDSyDmJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8207BC433F1;
	Sat,  6 Apr 2024 16:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712422324;
	bh=I54NXFbkQcPOBxp/oFLSaWT2pCoL0Ch2SA3oANFNikQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iDSyDmJdaYfvS00zLTR6FC4DwoR5ia7875ndItH4MKQhCFiSUcV+Dvm5XC1GJff1C
	 AyPyYuCE5mtGcp1dmIeOMS6qfJP+E59IEJMpJceFdQtU6lfSL8WJWh4jUUZYIF8BJZ
	 PSClN27EkGTX0hgJCT1R9IiuDB1medx2QIPeS8JX/GR5K3BfkOFBV3vtfpIGN8stmN
	 CDhEwkMsI+Uek5gHxygbDtqbP3NqIciFKas1l64y0CeOeTsmoeRqeJwCIZlD8dm312
	 Y1uc0VRAlVKDBMcSBjy0ttS0GaTqwEwtr5RorJTyI8ijWjqJ7RQ8+ndaSBJL1FJY60
	 Pxsm844oRp1Bg==
Date: Sat, 6 Apr 2024 17:51:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] of: Use scope based kfree() cleanups
Message-ID: <20240406175151.2067c01e@jic23-huawei>
In-Reply-To: <20240404-dt-cleanup-free-v1-2-c60e6cba8da9@kernel.org>
References: <20240404-dt-cleanup-free-v1-0-c60e6cba8da9@kernel.org>
	<20240404-dt-cleanup-free-v1-2-c60e6cba8da9@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 04 Apr 2024 09:15:11 -0500
Rob Herring <robh@kernel.org> wrote:

> Use the relatively new scope based kfree() cleanup to simplify error
> handling. Doing so reduces the chances of memory leaks and simplifies
> error paths by avoiding the need for goto statements.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



