Return-Path: <linux-kernel+bounces-149590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0972E8A9332
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8109AB21490
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAB929424;
	Thu, 18 Apr 2024 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="YQ94x1Le"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9EB12B75;
	Thu, 18 Apr 2024 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422286; cv=none; b=UUCs4cuNUMaqnxQGLxPcitqC6J5ZAcrVpIkHqA3c3XQIm2j5RoKDwgbqYFZ3k9FkEh7r2Ns9UtBjT2ElI59NQ5TpZfvfhPdTyFU+0sA7wbnPNS/pABF/iG0ffBzPb2f1oA5dsbHnUf+eS0aEyDbAdT9Veh8vugsBGiIV0abI5xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422286; c=relaxed/simple;
	bh=yFuVDKMmscdC12h/cA7xYWXQ6qRBbK3YvK3Czf/Uf7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzfG/7at2SWURRaDa+HX/aYrbAehEX9FVn//wpcECyBLalP+R4WCXlT1rYH3bR7fNdjzTro4Tk/pTQo9FsTGCj1cBjSjCsX8n38IZsHb9PXJhXqozInToOp89P2yXwSsPDbTyvrwsXJ9bLObmxrtYAeUTNCqLoYUwJC8W6cV58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=YQ94x1Le; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 3498F20AA7;
	Thu, 18 Apr 2024 08:37:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1713422275;
	bh=yLnlx8Q86m3QvBz6Xq7De3vFbuIviUkTLXjUy3+0IsE=;
	h=Received:From:To:Subject;
	b=YQ94x1Le225KPj3FAfASIb+u+DRlyjsGqR5wA8C2gzZXQCI+2EOdsbFqK5A8GAzcF
	 SXJHHjfeldQ02zG3HbybvmPaYjN4NoFhzFKRbPjs6BzgFTrQwf3HRnGXo7Mc0e5w1P
	 rMbqTCIbWZ9fx6ulGZyn/Pp9o77atH9zXUJYdQ6zvcypsgVlKAzLJegRxU/dVkLCFH
	 fvzPNphV4Jgnomcj6L+e4U3ksqhmFcGfvoSgEV6RpFEJw8A8djrg4VY4Z7/WI+ecnG
	 RSmsp4RCZHUCxBOpBdNgaPoT/vcXvyaf6z/UuDeLyNO+mTE+pMom5oYP0xh3a3gAQU
	 uitnZAsDz+Etw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id D5CCA7F975; Thu, 18 Apr 2024 08:37:54 +0200 (CEST)
Date: Thu, 18 Apr 2024 08:37:54 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v10 1/2] wifi: mwifiex: add host mlme for client mode
Message-ID: <ZiC_wjm79RvrC1jp@gaggiata.pivistrello.it>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-2-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418060626.431202-2-yu-hao.lin@nxp.com>

On Thu, Apr 18, 2024 at 02:06:25PM +0800, David Lin wrote:
> Add host based MLME to enable WPA3 functionalities in client mode.
> This feature required a firmware with the corresponding V2 Key API
> support. The feature (WPA3) is currently enabled and verified only
> on IW416. Also, verified no regression with change when host MLME
> is disabled.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

..

> diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
> index 745b1d925b21..3817c08a1507 100644
> --- a/drivers/net/wireless/marvell/mwifiex/util.c
> +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> @@ -417,6 +456,47 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,

..

> +				mwifiex_dbg
> +				(priv->adapter, MSG,
> +				 "assoc: receive disassoc from %pM\n",
> +				 ieee_hdr->addr3);

The way you indented this does not seems kernel coding style compliant ...
however checkpatch does not complain ... so maybe I am just wrong.

In case you need to send a new version, please keep the open parenthesis together with the function name

				mwifiex_dbg(priv->adapter, MSG,
					    "assoc: receive disassoc from %pM\n",
					    ieee_hdr->addr3);

(yes, it's 81 column - and it's fine).

Again, IMHO, do not send a v11 just for this trivial change.

Francesco



