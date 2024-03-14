Return-Path: <linux-kernel+bounces-102910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A1B87B848
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B5D1C20CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7ACD27E;
	Thu, 14 Mar 2024 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GU9UNOaW"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B2810940;
	Thu, 14 Mar 2024 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710400068; cv=none; b=czla5nqsmCPNkHLSnZZ5AaVVzVGSMJIj+3pHK+dHugMrgDPgHYZhY5+IfXyditamrYY0hi82JS3gOL5F/s/mApXfV7kh+I63rC8U2q/FzjNHO0mEmRV2URKcLphuyxrU/MoFSP941Wy1dET6KfUUMWIGgrFzr964hal+GTk1qGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710400068; c=relaxed/simple;
	bh=GhZ4JGryEcBc3CgKPGPXBJTWzLIzMYIYCJ6K0FhnlV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rG3Nit/M7hM5EGf4EiDynY3ShAHPtAiJe/asEE/zhOrYvfL2lo08vJPpo1BYUqmTQ+8Yi0ptukIsgLY62y0L294FerOBOxyb+wDUrll/Rs4SrVWLgKw216XSWBgNRk/6a6YTU8Q0eu5bGRiosLUVEoWMFA773SNxws7Q8Kg++BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GU9UNOaW; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C62F240004;
	Thu, 14 Mar 2024 07:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710400057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rEneWH/7DzaC3oT0COEpJUbF2WmAIFv5/EWar3lyv94=;
	b=GU9UNOaWkEqPxYo+/L3HhEZjNqQWXp8ibG1PjS1pmSEF/K067MuCXuiB2YG/ekL+89DMCN
	1mpOPonyCkMnvOEXotQOhyFyQLPuiYZ9jkqRRQlg327pPIZBg5owwqsa2XESZ4Fhccq/cE
	hz+8XtxtQjy7XyD5Q3ELqcZvZ0jhH3GvkDH+y3Hh/NXqVGTwSHueDMJPn30iaZVCJhYYzC
	9GUwPaJD5nD29InB4tE4oM+O4bXcx9KV3H0WwS611CNMnC2Xas6LAxvsNvkD74WuVgaNCL
	kFla+kdTxcDlrz6Z0Sz5MdpmuB+AvVwcHq3lIA+MYfOV/vQR/nWZIaDF3J7Liw==
Date: Thu, 14 Mar 2024 08:07:35 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-spi@vger.kernel.org, Michael Walle <mwalle@kernel.org>, Pratyush
 Yadav <pratyush@kernel.org>, Mark Brown <broonie@kernel.org>, Michael Walle
 <michael@walle.cc>, "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] spi: Fix error code checking in spi_mem_exec_op()
Message-ID: <20240314080735.5fe5b405@xps-13>
In-Reply-To: <20240313194530.3150446-1-florian.fainelli@broadcom.com>
References: <20240313194530.3150446-1-florian.fainelli@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Florian,

florian.fainelli@broadcom.com wrote on Wed, 13 Mar 2024 12:45:30 -0700:

> After commit cff49d58f57e ("spi: Unify error codes by replacing -ENOTSUPP with
> -EOPNOTSUPP"), our SPI NOR flashes would stop probing with the following
> visible in the kernel log:
> 
> [    2.196300] brcmstb_qspi f0440920.qspi: using bspi-mspi mode
> [    2.210295] spi-nor: probe of spi1.0 failed with error -95
> 
> It turns out that the check in spi_mem_exec_op() was changed to check
> for -ENOTSUPP (old error code) or -EOPNOTSUPP (new error code), but this
> means that for drivers that were converted, the second condition is now
> true, and we stop falling through like we used to. Fix the error to
> check for neither error being neither -ENOTSUPP *nor* -EOPNOTSUPP.
> 
> Fixes: cff49d58f57e ("spi: Unify error codes by replacing -ENOTSUPP with -EOPNOTSUPP")
> Reviewed-by: Michael Walle <mwalle@kernel.org>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks for the fix!

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


