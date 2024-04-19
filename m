Return-Path: <linux-kernel+bounces-151227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3827D8AAB63
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFB21F224CF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2847641B;
	Fri, 19 Apr 2024 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="UPvkd/i8"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9A0757F6;
	Fri, 19 Apr 2024 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518526; cv=none; b=gmMWaFGlQ9HfLtRAbF93m+FENpcaEdoccNnMVDOQAsenkHf+NA1aCsdU1zZajGAJdjnOfrHFP0W9aMckMqmveYmIcoejUkyBtodFlfk/TW1XRIY5AWbJWzYt/pA3v2f6f7zlRDtPRB54PDNSphFR0GvUMUBnHrQMz8vC+2c/nG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518526; c=relaxed/simple;
	bh=IUrIh1I9EDMmK3qzfuZjUzF9xzQMX9HYeY8NCQKJLtg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cbS/N5WL1eZYrB6v3PwVHkKdj3TXcX+DtAM0pDr/NdPxd81Ogd55X92oBg63u9EWzWfF74xUCfqeBr/e9XuIWR517rS3h5nDaWE7gUE+0UAQC2eRRBp4kvynIGOaxjT37q9msX/8uu/a5BYUtwb9WBu66T20HyUGXqt/2/oPMRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=UPvkd/i8; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TFSJ5LfZA5Gm93ONYseApmxHZXK4HLQCtQRfs6Mkz/E=; t=1713518523; x=1714123323; 
	b=UPvkd/i8C4TZos6R0FScCUAAqAuJf/dcdPgMP79F89ovozgn7Lpm0d0xr8bxkmo9q3eM06k+03B
	DKo0gQGryrCWNZjyzUZV+zzoSU7dj/G/EvXYi4AfvPLmZBg1nzzAmKwJWcUijTX6MFWi/7pAgjtEb
	9Yb3xFnvJMadMKWxgvG6o4QwWc4pgqxWbxYvkQGeXgzfJISD3Irh/Gu/2FqRaYB46o79cuu2aw+EP
	s9LnX04Wyd4kLdblTpCgg4WAkYN+WSGstvNx0wdVwNBHDLDxrW8X/oLyUyIWYQj9sP8xJVjAc58yX
	XQGal+NjHC6oEkSrTHmsEkBhncM+r7TWYOZw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rxkRP-00000001UNO-3Ki2; Fri, 19 Apr 2024 11:21:55 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rxkRP-00000001KE4-2Rb3; Fri, 19 Apr 2024 11:21:55 +0200
Message-ID: <377b0acf906b9bcfbc1053ca07d64f14a6cf9a1e.camel@physik.fu-berlin.de>
Subject: Re: [PATCH -next] dma: Add dev_id parameter description in
 request_dma_bycap
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Yang Li <yang.lee@linux.alibaba.com>, ysato@users.sourceforge.jp, 
	dalias@libc.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 19 Apr 2024 11:21:55 +0200
In-Reply-To: <20240419090259.39542-1-yang.lee@linux.alibaba.com>
References: <20240419090259.39542-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Yang,

On Fri, 2024-04-19 at 17:02 +0800, Yang Li wrote:
> This patch adds the missing description for the dev_id parameter in the
> kernel documentation for the request_dma_bycap function.
>=20
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/sh/drivers/dma/dma-api.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.=
c
> index 89cd4a3b4cca..65005d348877 100644
> --- a/arch/sh/drivers/dma/dma-api.c
> +++ b/arch/sh/drivers/dma/dma-api.c
> @@ -116,6 +116,7 @@ static int search_cap(const char **haystack, const ch=
ar *needle)
>   * request_dma_bycap - Allocate a DMA channel based on its capabilities
>   * @dmac: List of DMA controllers to search
>   * @caps: List of capabilities
> + * @dev_id: Unique identifier for the device that is requesting a DMA ch=
annel
>   *
>   * Search all channels of all DMA controllers to find a channel which
>   * matches the requested capabilities. The result is the channel

Thanks. This should include "sh:" in the subject. I will add this manually
when picking up the patch. Also, the missing Fixes tag as Geert noted.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

