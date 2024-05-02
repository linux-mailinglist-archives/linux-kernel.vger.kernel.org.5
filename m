Return-Path: <linux-kernel+bounces-166307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44698B98DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D3E1C21E48
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD49A59167;
	Thu,  2 May 2024 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="bpT9eH6W"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91835A0F8;
	Thu,  2 May 2024 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645922; cv=none; b=Yee6NkDGm/zuAm2IXF4M2/VUkssoMdn2deqn55aQ1YaantHBZ/ckhePeF7fX9LmXTwJHatc/D55hH6QP+IO7JXkoOv4eq1MsHVx8fBpR4C/gKPOK8p+hjFr/dPjXVzSzndDpRfR5VUsfZGuKdXAZ+mmK5xWvmjO1D3B5w6uqsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645922; c=relaxed/simple;
	bh=Da4+eR7XE6IbAMa48VcRB0SaIiLrNv/1XK4YaJFKaDE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u3UbeOada9X7iuwjWhJM5CqwSQGf9zEMeT4yF2skrmcnvaObcZSlO8BMXlKyGgrq3dwHI84gGnvsesAAEbAp4XALQuYCXeRMJflLx3wNJY0o5Al50khgbybHwyGXbwDi9j7frZU2aiBxOevNGesz9fx39RVCj3wQkkHj+y70vBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=bpT9eH6W; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hr8bu2LObnNnEnBECK9K132QleQOiYq/S4hpvwrzk8Q=; t=1714645918; x=1715250718; 
	b=bpT9eH6WEhi9Vi/NL4VqxAFRcOBYPdOitkssTHyog2ir8/zBZfUs87iK1s/kEWc7s9GmsX5Dh45
	GvS1bahrgHdG3L4PgtmvE8f3E/6Zmio789+3bn4VUJEgV8szNz+SaRhRxUwHrMcy5V7wNdTandT2D
	QxZ2YuBAC1jB+EGPANGuzpNOBiISmhh0YZheM0jS13t4PYfvKqBFIEv450RJDChJ3t3DbmgHaM7AD
	AMWxXk1JIeaDjbpNxzGtoFvvIU3NO+TmiJopFwRigQuPRGLnvVbZgcZ9yiikAi8pmlvcYQyzFC9ge
	l69AOWMCknuYZ51xHFS/f7IaMhdQt05XFRcg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s2TjH-000000020K0-2jRF; Thu, 02 May 2024 12:31:55 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s2TjH-0000000082Q-1rpx; Thu, 02 May 2024 12:31:55 +0200
Message-ID: <98810f30345bff398b23f61ffcf5ecb874402c0a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH -next] dma: Add dev_id parameter description in
 request_dma_bycap
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Yang Li <yang.lee@linux.alibaba.com>, ysato@users.sourceforge.jp, 
	dalias@libc.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 May 2024 12:31:54 +0200
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

This patch is now obsolete since search_cap() was removed in for-next by Ge=
ert
Uytterhoven in 89256d73 ("sh: dma: Remove unused functionality").

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

