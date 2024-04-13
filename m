Return-Path: <linux-kernel+bounces-143672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EDE8A3C34
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B4B8B214C1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C000F3D544;
	Sat, 13 Apr 2024 10:18:14 +0000 (UTC)
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EEB366;
	Sat, 13 Apr 2024 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713003494; cv=none; b=JC0BXLqsFs7kwRzHqmeqQNQgHfydCihYHzARLeuuPKzqzpEiq9d7wtY4yj/y66X/bea3bcW47FdKWHQ9zmj35d6+MscYxBCH1SXDwRXiAsq3N3pkGaqB3XOmoUmIXspkAcMPOKB/ObTTy3D4FgBxrFSUZspM+7l/0evvwgsA9wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713003494; c=relaxed/simple;
	bh=8n8Eie6eulIaD90R6Wujwp9lc64DiR88OsppJS6AirY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeE+BaIb+EFKcrVoOIJzDQJgGt8BbBAArSuwfz+CDV3lxUtkcs6FYGssoqdSudEBEaBYqtg5Sb95iH+OWfDzre42DVhNSVXzP6ux/eK6w92mL1bK4HGnRGkM8S7IeO8DQvvCXQRrIDX6iDDu/d6W8/P5LjU5gVjwxhCfOEJ7va4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 96A8E100DCEF8;
	Sat, 13 Apr 2024 12:18:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 5ECA52483; Sat, 13 Apr 2024 12:18:01 +0200 (CEST)
Date: Sat, 13 Apr 2024 12:18:01 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "M. Haener" <michael.haener@siemens.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH 2/2] dt-bindings: tpm: Add st,st33ktpm2xi2c to TCG TIS
 binding
Message-ID: <Zhpb2URMxuoilKAZ@wunner.de>
References: <20240413071621.12509-1-michael.haener@siemens.com>
 <20240413071621.12509-3-michael.haener@siemens.com>
 <8c13a349-a721-44d3-9e23-2e01f4c2ca4d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c13a349-a721-44d3-9e23-2e01f4c2ca4d@linaro.org>

On Sat, Apr 13, 2024 at 10:10:49AM +0200, Krzysztof Kozlowski wrote:
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching.

To be fair, "dt-bindings: tpm: " is actually the only prefix used
so far for the file that's touched here:

$ git log --oneline Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml 
26c9d15 dt-bindings: tpm: Consolidate TCG TIS bindings

Personally I don't think we need to differentiate between spi/i2c/mmio
bindings in the prefix, so the prefix used by Michael seems fine.


> A nit, subject: drop second/last, redundant "binding". The "dt-bindings"
> prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Right, so maybe just:

dt-bindings: tpm: Add st,st33ktpm2xi2c

?


> I got only one patch, but if these are compatible, why do you need
> second patch? Plus binding come before users.

Right, the order of the patches needs to be reversed it seems.

Thanks,

Lukas

