Return-Path: <linux-kernel+bounces-156990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB6E8B0B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF2A1F25211
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB9115F3FE;
	Wed, 24 Apr 2024 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2VwaBiS0"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8B115CD7B;
	Wed, 24 Apr 2024 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965983; cv=none; b=kl09alBF/PHb/c3jLCJVUzVLDLSij18mxrprDQnxq9o7TCMz/UlskIyX+BscB4Yrb9bYMih3KCibJxHE+1i5l3A+6JYTPtbKCDntiD6+efBwBNwaSa8aofeawLzhRVuDT+fbCgm3rDGvLr+rBfbF8eQaRnG8uP6qMEST1n7XxFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965983; c=relaxed/simple;
	bh=64mDTdBCtb8WNuIGOYCX/n2GuSDDhRGuuaVDFtoB9wI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0L12Sa5iRUGZ4GenegZO+6Bk9PPQygH/bOzY25sqNjoYcY82n0KBuW4rHCbdYF+jnPXWtedNs+E4IHD2jT/xa01E9VbF6HS8me1e1t/pg+cFabAdYKu7zP2xTUQppSIto4eyoTxUnzx3shuQBytDdcRdEbfGFdGVkFD/BmzbLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2VwaBiS0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713965981; x=1745501981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=64mDTdBCtb8WNuIGOYCX/n2GuSDDhRGuuaVDFtoB9wI=;
  b=2VwaBiS01Yx8YlNfq4yX53UAeQ1rCN9wkNHxD718YNjitX2o6nPztNEA
   WoPH6AQr41BZhIeSHtpEXiLnSNzaebeilGdfASwYezueBvNWgk5ats7fr
   TkLFnWSvsqiha+kJcJAM4saPvtsWgCJPsZdfGbLhvjirNhepJ+uO026fu
   GxFLuLEga5rfa8kbx4ZQ4FH8PLA4MXb7jl5o5mOt/5cIeB3Ffi05ZpGqR
   FpJcesV6bhLJTAP7zm8Oi1mFA23WWCNN1gyJYgLFygTlb7SyK8cVQNw1C
   FncC3GuWu4mkFrfoo7Z6or+XJDIIaTbdeDS2Jz4oXr1K2uYKx6dq1DOdW
   g==;
X-CSE-ConnectionGUID: DZwg016nQRyZW6QR0k7REg==
X-CSE-MsgGUID: UqCHhIGESMmxZaRwjd1Piw==
X-IronPort-AV: E=Sophos;i="6.07,226,1708412400"; 
   d="scan'208";a="23034276"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 06:39:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 06:39:08 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 06:39:06 -0700
Date: Wed, 24 Apr 2024 13:39:05 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
CC: <netdev@vger.kernel.org>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>, <UNGLinuxDriver@microchip.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, Simon Horman
	<horms@kernel.org>
Subject: Re: [PATCH net-next v2 0/4] net: sparx5: flower: validate control
 flags
Message-ID: <20240424133905.iex24gviwgoe7h3t@DEN-DL-M70577>
References: <20240424121632.459022-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424121632.459022-1-ast@fiberby.net>

> This series adds flower control flags validation to the
> sparx5 driver, and changes it from assuming that it handles
> all control flags, to instead reject rules if they have
> masked any unknown/unsupported control flags.
> 
> ---
> 
> Changelog:
> 
> v2:
> * Split first patch into 3 (requested by Jiri)
> * Convert a missed extack usage (noticed by Daniel)
> * Added cover letter (requested by Simon and Daniel)
> 
> v1: https://lore.kernel.org/netdev/20240423102728.228765-1-ast@fiberby.net/
> 
> Asbjørn Sloth Tønnesen (4):
>   net: sparx5: flower: only do lookup if fragment flags are set
>   net: sparx5: flower: add extack to
>     sparx5_tc_flower_handler_control_usage()
>   net: sparx5: flower: remove goto in
>     sparx5_tc_flower_handler_control_usage()
>   net: sparx5: flower: check for unsupported control flags
> 
>  .../microchip/sparx5/sparx5_tc_flower.c       | 20 +++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> --
> 2.43.0
>

For the series:

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Tested-by: Daniel Machon <daniel.machon@microchip.com>



