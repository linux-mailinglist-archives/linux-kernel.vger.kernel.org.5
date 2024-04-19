Return-Path: <linux-kernel+bounces-151877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D560C8AB522
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73AA51F222FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2C713C3FA;
	Fri, 19 Apr 2024 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaHh+Q6y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C09B1E86C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713551909; cv=none; b=p4hh9gFPtRYF+pB0Id9X57/pov5+zLiXMVRqoDYmwpwlwyEN7ovvog1V9Mu0oCsoARKDsn8RSgAUydvssrCyhc+wU/W/dkAQ1/4haufR8doMyaGF7AEcNInc4Zh/SuVN7c3YjKO3c8YBGIe89pYLeYDN6s/gIz/cnpmN+KrkMac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713551909; c=relaxed/simple;
	bh=ZOS9L6gLwP6b/xeU427rZP/WZ0gaX15ZtL62rJMAeJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o9m+80OkKUS9X6uX/avblfr2mgl+f7CvE9/Kj20FLIohBbfcxjBC+zY7GsZgyJMe3Wtr6GT9rk9euMYR2GQhH6LiolM2vPRFopSfrZWshuj4qbuGe7AX8/d4iftoyGwO4WnxSbxNdSs6Pip0a56UBb31mKBxH8eW8qdyDmX3jBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaHh+Q6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FEAC072AA;
	Fri, 19 Apr 2024 18:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713551908;
	bh=ZOS9L6gLwP6b/xeU427rZP/WZ0gaX15ZtL62rJMAeJc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iaHh+Q6yNq9xvqNAIvxIbUtg0d/8uQ3OD676NsKqlHm8D/MkNk+0n/NqokZrE8uTe
	 oWK+MoJnpjq2PGd4ddvLMNv8KIC5ZV6Vd3H/qwSX+0VXOU6SBQJNmJ4ZM+Oac77Zsi
	 A2kjcFKIibOhNANF0AYafbYk8ECAHcGmDTafERY8+d/V5B9rhH3SRK6yNIpl859c8d
	 ZCVu0InCWfQKscimmy2Q/hQwsyPFIgxpqSJKxcdtZVFGi7CGk0ixZxTBRQgX6i0LFJ
	 GVQ+wuUvCKCbm4RD72099kxbo31IF1ZU/eSozFKJQf2R4Cx1IHdxGEFf2Ldr6Dh7sW
	 EZtpzQgWRAKcA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Ricardo Ribalda <ribalda@kernel.org>,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 6/6] mtd: spi-nor: introduce support for displaying
 deprecation message
In-Reply-To: <20240419141249.609534-7-mwalle@kernel.org> (Michael Walle's
	message of "Fri, 19 Apr 2024 16:12:49 +0200")
References: <20240419141249.609534-1-mwalle@kernel.org>
	<20240419141249.609534-7-mwalle@kernel.org>
Date: Fri, 19 Apr 2024 20:38:26 +0200
Message-ID: <mafs0le595hb1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 19 2024, Michael Walle wrote:

> SPI-NOR will automatically detect the attached flash device most of the
> time. We cannot easily find out if boards are using a given flash.
> Therefore, add a .deprecation_version to the flash_info struct which
> indicates the kernel version after which the driver support will be
> removed.
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

Would also like to get an ACK from Tudor for this patch.

-- 
Regards,
Pratyush Yadav

