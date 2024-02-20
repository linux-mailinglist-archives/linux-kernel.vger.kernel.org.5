Return-Path: <linux-kernel+bounces-73075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2472C85BD2C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55AF71C21ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CF96A335;
	Tue, 20 Feb 2024 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XToTX1ep"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6803169E05;
	Tue, 20 Feb 2024 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708435850; cv=none; b=epSSoGrTzVf8ryFUI3+hJ89RdU6eB5RWY+GbKec4RNSVReTLZS/ssRAZDOAKTLsX8XKYD4OJ+81d25+0oYZj2sOYANXorJZSjx2w6QRCw/OsgDa2MO3HQlavcA5wdB9OWf1bICmQXn/2YoScKXapb+k8O1K3dz5lnPG4rsJVTyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708435850; c=relaxed/simple;
	bh=bbj3y4eCKYu8edd6s/J1h95MOajslQplxsNHJioQ1vU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gmHiB+wBBo/2tKddl8186HEFZfne59d8KkqUMgckoATZJ5Tguftqe4oD+XSr3bhgcJvPlqNr/Y9kHHp4b7xLUfRKvJI0LnSBizqbF3zY2hHNjK9/4dCm2yZVBjD9WPfJJkweurzDG3jT5HiGngavq1ry1TFHDZIH0+O2FTlQmQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XToTX1ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BB3C433C7;
	Tue, 20 Feb 2024 13:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708435850;
	bh=bbj3y4eCKYu8edd6s/J1h95MOajslQplxsNHJioQ1vU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XToTX1eptrMh9lpJtc2USXtSKsvQujFLqzzEhMdpwRr7eUFM5itRkHD06hj7xu4ti
	 RPxSSa4/xepD/sb7FAZ0x+UVyFrX0qCqgdqGXwSJ03OWvNzKc1EULIiYIegV9jtRfw
	 llJxjPtKdRhIyw41ZPYZh/Ye6ash7u+UcF1s/zS3erOZUrmk9dLc92v5LjuUt0SarU
	 zBOyTipEXpWFAJn1ejP52l9secKfeM1OWrniTFl5THR39w29gqI4dED1lZOA8Rdse3
	 YVsXT5w+dNQjcxJtHiSbyRhFxBzMi8tG/PYO9izPVej4RQeqcyn2mCUx/HvJHz0x+I
	 Me60PVRFCgc9A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Michael Walle <mwalle@kernel.org>,  Miquel
 Raynal <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Rob Herring <robh+dt@kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>,  linux-mtd@lists.infradead.org,  Yazan Shhady
 <yazan.shhady@solid-run.com>,  Rob Herring <robh@kernel.org>,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] dt-bindings: mtd: spi-nor: add optional interrupts
 property
In-Reply-To: <741c19b8-55f5-4f3f-8391-10fc2758e687@solid-run.com> (Josua
	Mayer's message of "Tue, 20 Feb 2024 13:31:14 +0100")
References: <20240219-mtd-flash-interrupt-binding-v7-1-206e30a656fa@solid-run.com>
	<mafs08r3f8h16.fsf@kernel.org>
	<741c19b8-55f5-4f3f-8391-10fc2758e687@solid-run.com>
Date: Tue, 20 Feb 2024 14:30:46 +0100
Message-ID: <mafs034tn8dq1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 20 2024, Josua Mayer wrote:

> Am 20.02.24 um 13:19 schrieb Pratyush Yadav:
>> On Mon, Feb 19 2024, Josua Mayer wrote:
>>
>>> Some spi flash memories have an interrupt signal which can be used for
>>> signalling on-chip events such as busy status or ecc errors to the host.
>>>
>>> Add binding for "interrupts" property so that boards wiring this signal
>>> may describe the connection.
>>>
>>> Signed-off-by: Josua Mayer <josua@solid-run.com>
>>> Acked-by: Rob Herring <robh@kernel.org>
>> Acked-by: Pratyush Yadav <pratyush@kernel.org>
>>
>> BTW, I don't see any support in SPI NOR for handling these interrupts.
>> Do you plan to add them in a later patchset?
> No current plans, I have little knowledge how spi-nor works in the kernel.
>> If not, what do you get by
>> describing them?
> Foremost I get to submit a correct device-tree (describes hardware)
> to the kernel, without maintainers getting all over me for introducing
> new dtbs_check errors.
>
> And I really do prefer submitting a complete device-tree so that all
> knowledge I have gained reading private schematics is readily
> available the next time someone works on it.

Fair enough. I guessed as much but thanks for the confirmation!

[...]

-- 
Regards,
Pratyush Yadav

