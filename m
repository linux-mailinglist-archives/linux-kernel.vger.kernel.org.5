Return-Path: <linux-kernel+bounces-59145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0FD84F1FA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D87286E99
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345AB664CC;
	Fri,  9 Feb 2024 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLSM+ZLV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A8165BB8;
	Fri,  9 Feb 2024 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707469857; cv=none; b=k6FFAXV+jb7x0j1PkPqKjQN8w+0hJely3kd9/c+ve1TUHdyhO3o2S7h4gTT9R0TNmRNBUbjvAOKlMkkkGNshxuOpdRfxdlqfAY3DVlEcT8eQxjLDNSHmowfWIbXiOf4sgp7CEbJuHa4AnQFQhJYOPGRCOC/xt+Rv+m6j0IrhKD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707469857; c=relaxed/simple;
	bh=2tfCumvAfLhiJke71zLdarIyZlLzb2v67s1JNdNfYE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWp7T5iKORndx2kfyzk+Ux57aKmSxnD+azmEw6ILOaqL+jTrD8DFSwho0yo0EyQ4BC4/E30ZHY+ktNJNHoAuk0lEUSHbDZcptiws7dwz250Gj0dtFbZnrqRMP6rJqqGw++0PfiPlmHvbGo7sgr7jpt+hfzKchBuIZJl/lbz/D/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLSM+ZLV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83956C433F1;
	Fri,  9 Feb 2024 09:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707469857;
	bh=2tfCumvAfLhiJke71zLdarIyZlLzb2v67s1JNdNfYE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PLSM+ZLVyO9cMRYFDiAXMkTAvP6/CL+7LzNxqAN0LmSar3WdPn7Rth/JKcWdnPZY1
	 T4bLq5EQEqo9Iaa4V4poyneLudYfaZ5ljHUqDo14YP3ydLBrglPBd7L1cwWLgWUDiR
	 OzRTdVZklEw02xm3NxQtWI4nKxXzgKE6UJTv0TpRNs/x4vAD4RD7UfpI5aqBkioL1E
	 gsY6WJlsfxwl5X/gejxswxihXzamvLlwGavAO2ycJzw2oFy1vfrGCS2jaLNEGP4PjF
	 3OEBg0tfglEKEXX/Qt9RCE1bWeLt1YvMGv3PV8I2JXTJBjeAUWDLiKsHd/lRPqtaiL
	 zgJ9Mpx71oNnw==
Date: Fri, 9 Feb 2024 09:10:54 +0000
From: Rob Herring <robh@kernel.org>
To: Dharma.B@microchip.com
Cc: conor@kernel.org, alexandre.belloni@bootlin.com, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Nicolas.Ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
	claudiu.beznea@tuxon.dev, devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert Atmel AIC to
 json-schema
Message-ID: <20240209091054.GA3291998-robh@kernel.org>
References: <20240208092015.263210-1-dharma.b@microchip.com>
 <170740748922.3230402.17318224112819715619.robh@kernel.org>
 <20240208-acuteness-visible-b60cd37c2b32@spud>
 <8dcae60c-1aba-4e76-99cd-de78c2c4ba6a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dcae60c-1aba-4e76-99cd-de78c2c4ba6a@microchip.com>

On Fri, Feb 09, 2024 at 06:31:15AM +0000, Dharma.B@microchip.com wrote:
> Hi Conor,
> 
> On 09/02/24 12:19 am, Conor Dooley wrote:
> > Hey Dharma,
> > 
> > On Thu, Feb 08, 2024 at 03:51:31PM +0000, Rob Herring wrote:
> >> On Thu, 08 Feb 2024 14:50:15 +0530, Dharma Balasubiramani wrote:
> >>> Convert the Atmel AIC binding document to DT schema format using
> >>> json-schema.
> >>>
> >>> Signed-off-by: Dharma Balasubiramani<dharma.b@microchip.com>
> >>> ---
> >>> Note: I get the following warnings on latest kernel but not in 6.7.
> >>> Should I be worried?
> >>> usage: yamllint [-h] [-] [-c CONFIG_FILE | -d CONFIG_DATA] [--list-files] [-f {parsable,standard,colored,github,auto}] [-s] [--no-warnings] [-v] [FILE_OR_DIR [FILE_OR_DIR ...]]
> >>> yamllint: error: one of the arguments FILE_OR_DIR - is required
> > Hard to say, how were you envoking the command? There were some issues
> > recently with dt_binding_check, but I thought those had been fixed.
> 
> I use this command to validate
> 
> make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- dt_binding_check 
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/interrupt-controller/atmel,aic.yaml

Humm, not sure. Will have to investigate.


> and also dtbs_check.
> 
> version = yamllint 1.32.0
> > 
> >> dtschema/dtc warnings/errors:
> >> Documentation/devicetree/bindings/interrupt-controller/atmel,aic.example.dtb: /example-1/dma-controller@ffffec00: failed to match any schema with compatible: ['atmel,at91sam9g45-dma']
> > But you didn't see this warning?
> 
> No I didn't see this warning when applied on tag:6.7. Don't know why.

That's because it just got enabled by default.

> 
> > I think you can resolve it by just dropping the "user" example from the
> > binding entirely. I don't think it adds anything at all.
> 
> I intentionally checked the generated example dts file and found that 
> both the examples look correct.

Maybe so, but how do we know with no schema? Your choices are drop from 
the example or add a schema for the DMA controller.

Rob

