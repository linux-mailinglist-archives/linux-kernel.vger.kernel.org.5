Return-Path: <linux-kernel+bounces-157566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC3B8B12FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 082F81C20D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373E91BF31;
	Wed, 24 Apr 2024 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="N9YffqBo"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7EF1CD13;
	Wed, 24 Apr 2024 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984912; cv=none; b=dPSzY6IQwd1mYDUXHzeouNc16khGzyu2LI6vdeUAstRgExMX8gzkilUihtJ5IWw5EeBgzhDSYTsYl27sSZkbgICE/A/Fx4yW2IHun2LhS1ASgCMCu6wnsE4bEFcN9sIFzl4Jcn4CTDoL+9OC/7or3lJPUuUReQ/KTUpGFRmS1O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984912; c=relaxed/simple;
	bh=9h9XSuWvb5TMFWVoA2JzaGK8vJ7HZ7sMfKj7T0OuiFw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqKr18+QEe+m1n8wFT8QTGl3U3ov0T4rDkL1LNQSSkzmD+kwGbuDGmLdU7uCo2F49Zeiwpbmue28nH4Z9k3Gbf2i1MzEzunTqvPBWUXcpniTsi83OVxdc6nIjcqKmyQX+F3NNZdck23qcFdp9qI6DMLqewZ4BavFBsLBhkc82Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=N9YffqBo; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713984910; x=1745520910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9h9XSuWvb5TMFWVoA2JzaGK8vJ7HZ7sMfKj7T0OuiFw=;
  b=N9YffqBo0N1tvRP1J6X3l12h3eMhHuEmP9j9JoUXeSOO8TJDEraQn1x/
   LlYjE3e+uusAsi/vtBiiwC4M5aCurchKIMCPq7n6asHo3ThQmmgb58fHh
   aql5P9cwXuNkE0hsB/Jz+pi8Vd9uLf6KLUNTeSt13rFaAQWIhIN9j09Me
   FZ+JLd2tBGLzBL70ITXwLVM4Q2N6ylmyKlq1oZha6lniDwPyNeDxiwLYB
   6RUmx51lkWp2C3DuoqzG+kMmX5jGcXQr0xQ3doTl7bSyz63bXdUNWzuBn
   O9nC38Yhw9VCarL1i1dDEO5Dwcv+dsYFP0tZ97uLEjHEW35blMIzzQuUB
   g==;
X-CSE-ConnectionGUID: vKyXeTDKRPST0335z8A8qQ==
X-CSE-MsgGUID: AJXK7MjuTSG+e9x+TXfBow==
X-IronPort-AV: E=Sophos;i="6.07,227,1708412400"; 
   d="scan'208";a="23075848"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 11:55:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 11:54:56 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 11:54:56 -0700
Date: Wed, 24 Apr 2024 20:54:55 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
CC: <netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>, Simon Horman
	<horms@kernel.org>
Subject: Re: [PATCH net-next v2 0/3] net: lan966x: flower: validate control
 flags
Message-ID: <20240424185455.p35dp3sqnlugxenv@DEN-DL-M31836.microchip.com>
References: <20240424125347.461995-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424125347.461995-1-ast@fiberby.net>

The 04/24/2024 12:53, Asbjørn Sloth Tønnesen wrote:
> 
> This series adds flower control flags validation to the
> lan966x driver, and changes it from assuming that it handles
> all control flags, to instead reject rules if they have
> masked any unknown/unsupported control flags.

For the entire series:
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> ---
> Changelog:
> 
> v2:
> * Split first patch into 2 (requested by Jiri)
> * Added cover letter (requested by Simon)
> 
> v1: https://lore.kernel.org/netdev/20240423102720.228728-1-ast@fiberby.net/
> 
> Asbjørn Sloth Tønnesen (3):
>   net: lan966x: flower: add extack to
>     lan966x_tc_flower_handler_control_usage()
>   net: lan966x: flower: rename goto in
>     lan966x_tc_flower_handler_control_usage()
>   net: lan966x: flower: check for unsupported control flags
> 
>  .../ethernet/microchip/lan966x/lan966x_tc_flower.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> --
> 2.43.0
> 

-- 
/Horatiu

