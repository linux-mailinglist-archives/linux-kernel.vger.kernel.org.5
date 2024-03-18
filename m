Return-Path: <linux-kernel+bounces-106529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB14587EFF3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B263B223D6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E49B5577A;
	Mon, 18 Mar 2024 18:48:51 +0000 (UTC)
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB62381C8;
	Mon, 18 Mar 2024 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787731; cv=none; b=pHt6HLKMgVpPSUjeuE8sf33yvuBegNL6u4KWCBqqZ1pdLtRwE70NR21P2Pbhw8tQaWoxEIvQxh4L8TfZELKunOagk+F+ZyTIuKcSvXwVznMgOeqs4wbxrecmQgXapo5+xGDvyjX7Q+vlW7WMLEuu9NOo/n3nOIzbTi50ky5xfsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787731; c=relaxed/simple;
	bh=YvE0ewogGQMDscZoUFNPK7tTHkCAhSEbbEBc87utS8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkrftAmg8c+nuNno9myu1ipI22gHkM2JCq4IkEhdzU5zQKnJurl9mnQZeXOyvEFaQUHZxoL2usFMUPTyX0V3DHgZfiW/kgv/jAZ6t98uNXwVsqH4mHE2idMtb/4Fxflz8XSyzVa89BxznPqYpSOADR9yM31BMC9DJIqGs5YYarw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C54C530000867;
	Mon, 18 Mar 2024 19:48:38 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9F018593181; Mon, 18 Mar 2024 19:48:38 +0100 (CET)
Date: Mon, 18 Mar 2024 19:48:38 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
	bbhushan2@marvell.com, jarkko@kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v6 00/13] Add support for NIST P521 to ecdsa
Message-ID: <ZfiMhi9D2Rhh89BI@wunner.de>
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>

On Tue, Mar 12, 2024 at 02:36:05PM -0400, Stefan Berger wrote:
> This series adds support for the NIST P521 curve to the ecdsa module
> to enable signature verification with it.

v6 of this series is still

Tested-by: Lukas Wunner <lukas@wunner.de>

as it successfully authenticates PCI devices with the
"TPM_ALG_ECDSA_ECC_NIST_P521" SPDM asymmetric algorithm
using my development branch:

https://github.com/l1k/linux/commits/doe

Thanks,

Lukas

