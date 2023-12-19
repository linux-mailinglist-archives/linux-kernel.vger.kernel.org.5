Return-Path: <linux-kernel+bounces-5313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC216818952
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4A61F23BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906831B283;
	Tue, 19 Dec 2023 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hh2h5Z7I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819821B268;
	Tue, 19 Dec 2023 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702994781; x=1734530781;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=MM7tSUvdzpwrauOve1hWyK60/Xq+XyRaOR3Y645l/Sk=;
  b=hh2h5Z7IPMdg4bamzpQ/zf32+Z8ijb95HbJEMVY0ubUnCCGHBnhNVDCz
   yy43lOHj4EWfia1J12TlUxTn277X928Bu0lFbowKWSpDk+mmQC1KBs8Zl
   x9rTSThd+OsxXN9HFc1avgvXJhhEx8hgxDvJRJ9JaclSWVulAQRqPGjO+
   MzuPK8q/RDMAhaJKtk43Iw1V6M8N9Mtmb9mP2FGfquApDJtcARJhAUpWE
   PzY0yC0wPkmysCDPylA4FZgRRjugoe+BvkMJ4Ok24Fbldw37d5nA3lx3a
   avboX9W7w87pSO6NoMs82jnBikIOYZBDJe2hT0mW9Z4JxBgNn6jDbDPot
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2757322"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="2757322"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 06:06:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="752169140"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="752169140"
Received: from leavitia-mobl.amr.corp.intel.com ([10.212.72.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 06:06:19 -0800
Message-ID: <234a7737353d0de94f03325f28eb54b1a4b97cb8.camel@linux.intel.com>
Subject: Re: [PATCH] crypto: iaa - remove unneeded semicolon
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Abaci Robot
	 <abaci@linux.alibaba.com>
Date: Tue, 19 Dec 2023 08:06:17 -0600
In-Reply-To: <20231219061520.77128-1-jiapeng.chong@linux.alibaba.com>
References: <20231219061520.77128-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jiapeng,

On Tue, 2023-12-19 at 14:15 +0800, Jiapeng Chong wrote:
> No functional modification involved.
>=20
> ./drivers/crypto/intel/iaa/iaa_crypto_main.c:979:2-3: Unneeded
> semicolon.

Thanks for the report.

Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>


>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D7772
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> =C2=A0drivers/crypto/intel/iaa/iaa_crypto_main.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c
> b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> index eafa2dd7a5bb..648da8740e6b 100644
> --- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
> +++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
> @@ -976,7 +976,7 @@ static int wq_table_add_wqs(int iaa, int cpu)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0pr_debug("rebalance: added wq for cpu=3D%d: iaa wq
> %d.%d\n",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp=
u, iaa_wq->wq->idxd->id, iaa_wq->wq->id);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0n_wqs_added++;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!n_wqs_added) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0pr_debug("couldn't find any iaa wqs!\n");


