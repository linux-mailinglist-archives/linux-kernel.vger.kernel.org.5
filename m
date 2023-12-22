Return-Path: <linux-kernel+bounces-9335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F8181C448
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534761C24E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F735B645;
	Fri, 22 Dec 2023 04:42:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D279475;
	Fri, 22 Dec 2023 04:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rGXMB-00DhZz-PV; Fri, 22 Dec 2023 12:41:56 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Dec 2023 12:42:06 +0800
Date: Fri, 22 Dec 2023 12:42:06 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Dan Carpenter <error27@gmail.com>, linux-crypto@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] crypto: stm32/crc32 - fix parsing list of devices
Message-ID: <ZYUTnm83NdBC0+Rb@gondor.apana.org.au>
References: <20231215111724.864051-1-thomas.bourgoin@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215111724.864051-1-thomas.bourgoin@foss.st.com>

On Fri, Dec 15, 2023 at 12:17:24PM +0100, Thomas Bourgoin wrote:
> smatch warnings:
> drivers/crypto/stm32/stm32-crc32.c:108 stm32_crc_get_next_crc() warn:
> can 'crc' even be NULL?
> 
> Use list_first_entry_or_null instead of list_first_entry to retrieve
> the first device registered.
> The function list_first_entry always return a non NULL pointer even if
> the list is empty. Hence checking if the pointer returned is NULL does
> not tell if the list is empty or not.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202311281111.ou2oUL2i-lkp@intel.com/
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202311281111.ou2oUL2i-lkp@intel.com/
> Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
> ---
>  drivers/crypto/stm32/stm32-crc32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

