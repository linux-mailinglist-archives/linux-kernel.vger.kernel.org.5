Return-Path: <linux-kernel+bounces-111954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F725887330
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82DFB24843
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A05E67C74;
	Fri, 22 Mar 2024 18:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ak3fgWxG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4E273FA;
	Fri, 22 Mar 2024 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711132305; cv=none; b=gPF+eQFE1CjqJ4VqCTGcu0FTimzZDL6V3tHmsupjkjmKkYR0aLBf9CcG/NsjOtNchhufdXSlLvbb9Y1szEZUOuZmFx4q9NOWdXHrMfgFxZDBkBPeXshkJ5RIugQzmm9K8y8zBl8TwDUBscKLQKIlvM2oZizDSxe2BVSwZVh0KVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711132305; c=relaxed/simple;
	bh=PCEKU0j/1uuzByPx7NDN6kCcAnr8R4L0d9r62J7fHM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRm0NyeFWl5ToxWHVnH/F5vuK9I7apv/cXMEnxogNjq/MCpHMuSZVT+AfQb7ghsTrN+xviYHFY78+nLu8BQaaB5w+NrYI2GhzcUMpjWHrxY7HrX/jfOK/nn99WPfkUMxlN5yLy6Q00mgTOjXekdlX8zElbi1BwDu3WHKkAJ51uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ak3fgWxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15723C433C7;
	Fri, 22 Mar 2024 18:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711132305;
	bh=PCEKU0j/1uuzByPx7NDN6kCcAnr8R4L0d9r62J7fHM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ak3fgWxGQTL7X1zyYERrle4zsNWr1NrLIrvxsYGd8l6ioC3oBf5EyoVjwAy4ripqK
	 ZEdt1EyfDTGV2m4WBh4LGvzznxcxJNLa3Qd2lNH2rJdIG/EV/qycaYxaUVde2yWq4L
	 D+Ca74YTQu5JJdTsYu6vk6at/+hewaon6WPSWa+mslChXiQ60F/Ztna11wH2WHAaqu
	 dbo7T0mK2rirooD1HWKn8vsJCIZyjacqQkXDLwqubwJk6El6ZoMCtg7QrJYyAzg4mH
	 r570DiM9QKDC+47TR+dGCM/gX8pf6KIpde1xlrO5/qrZ/7jykv+bHip0RcYSod5wBA
	 04swlDJqgk6lw==
Date: Fri, 22 Mar 2024 13:31:42 -0500
From: Rob Herring <robh@kernel.org>
To: Allen_Lin <allencl_lin@hotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	benjamin.tissoires@redhat.com, conor+dt@kernel.org,
	jikos@kernel.org, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v1 1/4] dt-bindings: input: Add Himax HX83102J touchscreen
Message-ID: <171113229955.1232809.11460737113264520604.robh@kernel.org>
References: <20240322085606.993896-1-allencl_lin@hotmail.com>
 <TY0PR06MB56116F0902017225C78EDDDD9E312@TY0PR06MB5611.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY0PR06MB56116F0902017225C78EDDDD9E312@TY0PR06MB5611.apcprd06.prod.outlook.com>


On Fri, 22 Mar 2024 16:56:03 +0800, Allen_Lin wrote:
> Add the HX83102j touchscreen device tree bindings documents.
> HX83102j is a Himax TDDI touchscreen controller.
> It's power sequence should be bound with a lcm driver, thus it
> needs to be a panel follower. Others are the same as normal SPI
> touchscreen controller.
> 
> Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
> ---
>  .../input/touchscreen/himax,hx83102j.yaml     | 73 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83102j.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


