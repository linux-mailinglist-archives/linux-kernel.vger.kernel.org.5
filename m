Return-Path: <linux-kernel+bounces-131822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AFF898C2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66711282C6C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40F21C69C;
	Thu,  4 Apr 2024 16:33:46 +0000 (UTC)
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC47917BA0;
	Thu,  4 Apr 2024 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248426; cv=none; b=kRkyyjFtaqM0v+xU5fRiUXuheOVvwEYAO5i1EOZmEx/DNB+BG0MI3mxXB9BMvoH4uwEEMx18n+GhY1HvXgVj1bByZ4ow3ShAlBL8AmWsMOlFVB+zuw+hkERvTqngR22q5F3il3VLrs3axUx4xVRECmjvdoeCWzwv3rP1zj6iwH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248426; c=relaxed/simple;
	bh=QhmcHxvryoTgrRJoPDu0HVhIBeQGtmg6eKV8u8fcduE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XShk9ybHTQLQzmsQB6BwVqcXr+dob2NBfULIQMaqgWqOoPECj/j2jgwAnpEdWpvWBiKdaX1/UpupcaUrMva4QrsbJaiKFjDuTZy7BTgNzyAcazxnV+9csTV7vhJQi8Fu33Tl/sfS2SAYdq1rXkxfKL4f2w3oeF0mEiZ6zdJxvxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 39E162800B483;
	Thu,  4 Apr 2024 18:33:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1AAEA65FBCF; Thu,  4 Apr 2024 18:33:38 +0200 (CEST)
Date: Thu, 4 Apr 2024 18:33:38 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
	bbhushan2@marvell.com, jarkko@kernel.org
Subject: Re: [PATCH v8 00/13] Add support for NIST P521 to ecdsa
Message-ID: <Zg7WYnot4votk1FT@wunner.de>
References: <20240404141856.2399142-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404141856.2399142-1-stefanb@linux.ibm.com>

On Thu, Apr 04, 2024 at 10:18:43AM -0400, Stefan Berger wrote:
> This series adds support for the NIST P521 curve to the ecdsa module
> to enable signature verification with it.

Tested-by: Lukas Wunner <lukas@wunner.de>

PCI device authentication with P521 is still working fine with v8.

