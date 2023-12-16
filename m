Return-Path: <linux-kernel+bounces-2147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3E9815894
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 10:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A061F25A49
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 09:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A1D14A97;
	Sat, 16 Dec 2023 09:56:48 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB42134D9;
	Sat, 16 Dec 2023 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 53E1530000867;
	Sat, 16 Dec 2023 10:47:15 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 18E274EA64; Sat, 16 Dec 2023 10:47:15 +0100 (CET)
Date: Sat, 16 Dec 2023 10:47:15 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] tpm: nuvoton: Use i2c_get_match_data()
Message-ID: <20231216094715.GA7030@wunner.de>
References: <20231115210215.3743873-1-robh@kernel.org>
 <CWZPKU58PWLS.1B1N297O1D9CY@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CWZPKU58PWLS.1B1N297O1D9CY@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Nov 15, 2023 at 11:37:55PM +0200, Jarkko Sakkinen wrote:
> On Wed Nov 15, 2023 at 11:02 PM EET, Rob Herring wrote:
> > Use preferred i2c_get_match_data() instead of of_match_device() to
> > get the driver match data. With this, adjust the includes to explicitly
> > include the correct headers.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/char/tpm/tpm_i2c_nuvoton.c | 15 ++++-----------
[...]
> 
> OK, apologies for having to do a resend. I'll pick this, thanks!

This is now duplicated as commit ebf2d4e8e582 in Jarkko's tree and
commit 319e31686b9f in Rob's tree:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?h=next&id=ebf2d4e8e582a444e12eff7d4a59d87f22fb3481

https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=for-next&id=319e31686b9f2bd669fd5c3a63b8ccf2efd9186f

