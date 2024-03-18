Return-Path: <linux-kernel+bounces-105775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA1187E42E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6192D1C20B55
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3702421D;
	Mon, 18 Mar 2024 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="fdIxhYz0"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DBB22EF2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710747563; cv=none; b=GHmWf/xF6rKl55+mbRWt8kN/W+rCbO+w2zQYqaLFDSkwyCrRMPIMLBH79nHU9MkjATZ+qfT+9NcoDuJfU8Gr9sVBrybzwh8+O0jjAc6fdy58XJZnMUcE2X1T1kzAsTBANYXqMh0EsTaSpfixfrXqH8Egf/yZF4aXIDVKMIexsuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710747563; c=relaxed/simple;
	bh=EPLKDH3VljXFWrIbZBKT4SRpU0X8LxisU7rbFzf2ES4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NtYg3Xj8S5xt2gP5OWxqidSDwP2NSY8bo4ZK1Nn0q+B3/y3K2Hyp/4Dkt5zerAhlYpKRg7tXIPYEMUE/nVf7ox2rPkmcVNIN+gvOs+bZUTXZcyqOG7ktrdGcQ4UGKF0auhKJcWbgtxHYmdbW77IT+GlddHC8quIdEjrvp09039I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=fdIxhYz0; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MbnpG8HNWfn6gCZ9HY/lgZBQCyKazod2hyic2wq2c0E=;
  b=fdIxhYz0rTABKuRyQSTg26nnVDVMP0hgoNRMoiEOa3YOnUAa1L/9sWPl
   vHge/fk4WW//hyx4PJWi0jeeQQXwKUfP/6suV3FncjElHOvgQvyH90Sie
   HxbfgSjoTLRc/yauUrJ/pJrFZ2W1QRrLcao2V4ccDAY/fEQN6qgsphmPM
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,134,1708383600"; 
   d="scan'208";a="82398387"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 08:39:11 +0100
Date: Mon, 18 Mar 2024 08:39:11 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com, 
    gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
    linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH 1/3] staging: rtl8712: rename backupPMKIDList to
 backup_PMKID_list
In-Reply-To: <10336a70a7d1b87857664e9733a419791e0e2ada.1710703217.git.ayushtiw0110@gmail.com>
Message-ID: <c06e1e30-aeba-c8c-19d7-cdf83ff2099@inria.fr>
References: <cover.1710703217.git.ayushtiw0110@gmail.com> <10336a70a7d1b87857664e9733a419791e0e2ada.1710703217.git.ayushtiw0110@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 18 Mar 2024, Ayush Tiwari wrote:

> Rename backupPMKIDList to backup_PMKID_list and remove extra spaces
> between RT_PMKID_LIST and backupPMKIDList to address checkpatch
> warnings and match the common kernel coding style.
>
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---
>  drivers/staging/rtl8712/mlme_linux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rtl8712/mlme_linux.c b/drivers/staging/rtl8712/mlme_linux.c
> index b9f5104f3bf7..a8cda81f4240 100644
> --- a/drivers/staging/rtl8712/mlme_linux.c
> +++ b/drivers/staging/rtl8712/mlme_linux.c
> @@ -84,7 +84,7 @@ void r8712_os_indicate_connect(struct _adapter *adapter)
>  	netif_carrier_on(adapter->pnetdev);
>  }
>
> -static struct RT_PMKID_LIST   backupPMKIDList[NUM_PMKID_CACHE];
> +static struct RT_PMKID_LIST backup_PMKID_list[NUM_PMKID_CACHE];

This one looks suspicious, because you have changed the definition but no
uses.  Is it not used?

julia

>  void r8712_os_indicate_disconnect(struct _adapter *adapter)
>  {
>  	u8 backupPMKIDIndex = 0;
> --
> 2.40.1
>
>
>

