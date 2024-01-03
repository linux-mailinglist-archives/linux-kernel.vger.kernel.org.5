Return-Path: <linux-kernel+bounces-16129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AC6823964
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70C2AB2355C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086BB1F95D;
	Wed,  3 Jan 2024 23:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvTQ1CIZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E781F926;
	Wed,  3 Jan 2024 23:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D093C433C7;
	Wed,  3 Jan 2024 23:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704326309;
	bh=iA9WYfGY5Z4oYdMSbRGnFplo2MhKh0V9KxXo9sQm5Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvTQ1CIZJ3c3bkAHjb38KAjylqYtdc8OhUUlTB7ZU0IsHEYDYPWrErA1dcymNAIME
	 7v06xr59dNgxWQNp6/RGwGHtEGPOD2ExIrSJgRRVYmf3SKoKvUYOS/IRkTj8gmcFrG
	 sDIJqQrJ1oJj39puhnIzsvZ3Hxas6Fz4kQWNLsdmuTjTynu4Ij3reRGCDq3hcAjLOe
	 iSSAu7ut2lfbPaP02Ug5BB1sgqo0NyoOOWNMwx6NInkjO85zhLB/A4kWp68+18en8u
	 I6/exVME/cc79Suz+bOFCnTVUYPhmidOkUzDuH4kT4T9IdolOY/U+5iLxtFRSS3lfA
	 CmquNDbEAvzkQ==
Received: (nullmailer pid 2042297 invoked by uid 1000);
	Wed, 03 Jan 2024 23:58:27 -0000
Date: Wed, 3 Jan 2024 16:58:27 -0700
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: ignore paths outside kernel for
 DT_SCHEMA_FILES
Message-ID: <170432630603.2042234.10993333941885772911.robh@kernel.org>
References: <20231220145537.2163811-1-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231220145537.2163811-1-andre.draszik@linaro.org>


On Wed, 20 Dec 2023 14:55:37 +0000, André Draszik wrote:
> If the location of the kernel sources contains the string that we're
> filtering for using DT_SCHEMA_FILES, then all schemas will currently be
> matched, returned and checked, not just the ones we actually expected.
> As an example, if the kernel sources happen to be below a directory
> 'google', and DT_SCHEMA_FILES=google, everything is checked. More
> common examples might be having the sources below people's home
> directories that contain the string st or arm and then searching for
> those. The list is endless.
> 
> Fix this by only matching for schemas below the kernel source's
> bindings directory.
> 
> Note that I opted for the implementation here so as to not having to
> deal with escaping DT_SCHEMA_FILES, which would have been the
> alternative if the grep match itself had been updated.
> 
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> ---
>  Documentation/devicetree/bindings/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!


