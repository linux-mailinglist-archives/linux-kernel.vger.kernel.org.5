Return-Path: <linux-kernel+bounces-143678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 682FE8A3C3E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3DE4B2185D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 10:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31036208B6;
	Sat, 13 Apr 2024 10:34:53 +0000 (UTC)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1329E1865;
	Sat, 13 Apr 2024 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713004492; cv=none; b=hAudXMwf4jwcj7CsSTWd00l6AmN8Sx5yYNh4gj+4UmX1mE+t0C/DMO9UnDNut8WbK5kf7iSYAGiOcRPyxSCEsFD9Vn2A7aQusZgKxStYzij0SidOM+VEbCTjFHKX1EwtLfFL4IcLY95H+9DsMJ+n+dNt9KWVvzWJMYOGp89wY2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713004492; c=relaxed/simple;
	bh=GgoGL2xBNyIzinXiTS9nqnjjz5JkJhr64vtoDo3KiwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2krzIxKHWzUaxeBktJOBTbQRRR7NtQv759AJATUTbFP2cWVm4YeY4ce//aA5uRCarC4t1HR28sKe8Xxb/ql6z/SVNsAwIkpb03h0d5+BntLzAoqSGYwBzN5/DrraYEnlcCww9DY/2aryykdN0m9QTbwWo663pVnwqbMgCGV8xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id E1025280253E0;
	Sat, 13 Apr 2024 12:34:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CC14B2482; Sat, 13 Apr 2024 12:34:41 +0200 (CEST)
Date: Sat, 13 Apr 2024 12:34:41 +0200
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
Message-ID: <ZhpfwaIUc0HpfZP1@wunner.de>
References: <20240413071621.12509-1-michael.haener@siemens.com>
 <20240413071621.12509-3-michael.haener@siemens.com>
 <8c13a349-a721-44d3-9e23-2e01f4c2ca4d@linaro.org>
 <Zhpb2URMxuoilKAZ@wunner.de>
 <3d08cf54-f58f-446f-977e-21ba65986924@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d08cf54-f58f-446f-977e-21ba65986924@linaro.org>

On Sat, Apr 13, 2024 at 12:23:47PM +0200, Krzysztof Kozlowski wrote:
> On 13/04/2024 12:18, Lukas Wunner wrote:
> > On Sat, Apr 13, 2024 at 10:10:49AM +0200, Krzysztof Kozlowski wrote:
> > > I got only one patch, but if these are compatible, why do you need
> > > second patch? Plus binding come before users.
> > 
> > Right, the order of the patches needs to be reversed it seems.
> 
> What is the second patch? Device is or is not compatible?

The other patch just adds an entry to of_tis_i2c_match[] in the driver,
pretty unspectacular:

https://lore.kernel.org/all/20240413071621.12509-2-michael.haener@siemens.com/

Unfortunately it was only cc'ed to TPM driver maintainers.

