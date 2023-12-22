Return-Path: <linux-kernel+bounces-9311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F7D81C3D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98AF2B2424C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 04:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D808F67;
	Fri, 22 Dec 2023 04:24:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC67476;
	Fri, 22 Dec 2023 04:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rGX4r-00DhGk-B3; Fri, 22 Dec 2023 12:24:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Dec 2023 12:24:12 +0800
Date: Fri, 22 Dec 2023 12:24:12 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	qat-linux@intel.com, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>
Subject: Re: [PATCH 1/5] math.h: Add avg_array()
Message-ID: <ZYUPbIGNJAfow5tz@gondor.apana.org.au>
References: <20231215152440.34537-1-lucas.segarra.fernandez@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215152440.34537-1-lucas.segarra.fernandez@intel.com>

On Fri, Dec 15, 2023 at 04:24:40PM +0100, Lucas Segarra Fernandez wrote:
> Add macro to compute average of values within an array.
> 
> This patch is based on earlier work done by Wojciech Ziemba.
> 
> Signed-off-by: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
> Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
> ---
>  include/linux/math.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

I think adding this to a common header when there are no other
users is a bit premature.  Please keep it in a local header file
until a new user appears.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

