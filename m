Return-Path: <linux-kernel+bounces-37209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2F283AC90
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81741F25830
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF49C33982;
	Wed, 24 Jan 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFLygRVd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3543F2F26;
	Wed, 24 Jan 2024 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108194; cv=none; b=cLhnIV2lgcsCRjZB4tPBKcu60BWRD+dcmlqOZFWegBn1g8VZMBP+2FZrS0bZE4HYVhcMk78v4XmDkfjyennALWNJd4wVQMgtU43QfWxPEVrT3p0Z29/xb+7EM5+pBTLL6mReAfs+DtBVE6/1OJkZlkRTqUq7HWYwwV4HKcHWe64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108194; c=relaxed/simple;
	bh=7/wklZ6oD0ECwz1vKnU18BgeWzOozsvAiODYnadkp4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaBuKgd4XADzmMlrs/R5kNKrlFjufMB5ysKjwI6L+fbSxEM8OChEcylT6+3enN1NPU3l9AWNQC8oZQBkPVLYCqLIbVmO4ZMYtG2/XJrCpdonjxQBg2KzrKKeATA70RvU7MPmDR1lfdmATn8RGhv2OX/m81rIZv2cGokXkqsiDnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFLygRVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B0EC433F1;
	Wed, 24 Jan 2024 14:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706108193;
	bh=7/wklZ6oD0ECwz1vKnU18BgeWzOozsvAiODYnadkp4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFLygRVdAi67WUWHRp4/WulZPT9untGPgaFZV/lYT18DrtkTQBhFtoUp91sZuVJyx
	 0iUV4qnU6xBkADvpEtDb9X1XfomDS78VK7xZILwkZSCzvk2fFRL+DZpbh5Avu741mv
	 mzgWrQax+cp0brWgly+g993OvOEcVjJ4pMzCs+9CVdDn9wyOJ1Z/0XIHejv9s7lFj2
	 xTGlXAz1XrejcNZTnegODD9oXkWQRx/2qpmUxcXj60ZRuM0zKspabgcYsgxvzdLeeP
	 9eZXD4hAbHFj6hjepm9qSpV3XXJEUtwPVYXetz7SfJvcBbk1xNDQusnlFJ0lvuUL55
	 QxobEzuPn3zQQ==
Date: Wed, 24 Jan 2024 08:56:31 -0600
From: Rob Herring <robh@kernel.org>
To: Amrit Anand <quic_amrianan@quicinc.com>
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH 0/2] Add board-id support for multiple DT selection
Message-ID: <20240124145631.GA873781-robh@kernel.org>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>

On Sat, Jan 20, 2024 at 04:50:47PM +0530, Amrit Anand wrote:
> Device manufacturers frequently ship multiple boards or SKUs under a
> single software package. These software packages will ship multiple
> devicetree blobs and require some mechanism to pick the correct DTB for
> the board the software package was deployed. Introduce a common
> definition for adding board identifiers to device trees. board-id
> provides a mechanism for bootloaders to select the appropriate DTB which
> is vendor/OEM-agnostic.

Show me a 2nd user. Or does vendor/OEM-agnostic just mean vendors of 
QCom devices? Multiple SoC families using this would help your case. I'm 
not inclined to take it into the DTSpec without that.

> 
> Isn't that what the compatible property is for?
> -----------------------------------------------
> The compatible property can be used for board matching, but requires
> bootloaders and/or firmware to maintain a database of possible strings
> to match against or have complex compatible string matching. Compatible
> string matching becomes complicated when there are multiple versions of
> board: the device tree selector should recognize a DTB that cares to
> distinguish between v1/v2 and a DTB that doesn't make the distinction.
> An eeprom either needs to store the compatible strings that could match
> against the board or the bootloader needs to have vendor-specific
> decoding logic for the compatible string. Neither increasing eeprom
> storage nor adding vendor-specific decoding logic is desirable.

You could hash the compatible strings if it was just a size issue.

> The solution proposed here is simpler to implement and doesn't require
> updating firmware or bootloader for every new board.
> 
> How is this better than Qualcomm's qcom,msm-id/qcom,board-id?
> -------------------------------------------------------------
> The selection process for devicetrees was Qualcomm-specific and not
> useful for other devices and bootloaders that were not developed by
> Qualcomm because a complex algorithm was used to implement. Board-ids
> provide a matching solution that can be implemented by bootloaders
> without introducing vendor-specific code. Qualcomm uses three
> devicetree properties: msm-id (interchangeably: soc-id), board-id, and
> pmic-id.  This does not scale well for use casese which use identifiers,
> for example, to distinguish between a display panel. For a display
> panel, an approach could be to add a new property: display-id, but now
> bootloaders need to be updated to also read this property. We want to
> avoid requiring to update bootloaders with new hardware identifiers: a
> bootloader need only recognize the identifiers it can handle.

So the id list will be always expanding list for every last component 
that is 2nd sourced? The ChromeOS folks are also trying to solve that 
problem.

There's a similar issue for EFI boot with how to select an OS installed 
DTB[1]. You might not care now, but users may later on (like we have 
already with QCom devices with fixed bootloaders). If you do this 
board-id route, then no doubt that compatible values won't be specific 
enough or have suitable fallbacks to be used. Then EFI boot can't use 
compatible either and needs to use this QCom specific logic. It may be a 
common property name, but all the types you defined are QCom specific 
and the matching logic is pretty much undocumented. I'm not saying we 
have to use compatible. There wasn't even agreement to use it for EFI 
boot case. This does need to work for multiple vendors and multiple boot 
scenarios.

Rob

[1] https://lore.kernel.org/u-boot/20231114232012.GD6601@bill-the-cat/#r

