Return-Path: <linux-kernel+bounces-130988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9830E89819E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74861C242BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7646854902;
	Thu,  4 Apr 2024 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="d/5YONai"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F97B53E2E;
	Thu,  4 Apr 2024 06:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712213304; cv=none; b=l1q9L807n4xANy1uci0AC6Bdspho/LFY9jJ6A7jg+ez8nKD/V9IqKN76NE/v3n8gBCoGZaTqP46xIUkUiIw6Yg6sAGLi7GZmb1RR+yUhWIyBlFPqgvvX+tu5MFd+f4DokS52H5/H6YoUMf0sidLya8Ac8xA2iPaOOp1QK5Q10Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712213304; c=relaxed/simple;
	bh=LGK2yHu2NA1tw1OVzxXDi8K+v7+Kt4wEU5L7h21w5BU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVP8SAkGT1j4KG9coHmOCUXU4RD55QoCuEk/sdqLbM7TpPGg4zEM8Kln/ljlS1y6kGEAhXKpafqeFeIpUSLmzg1Kixap2V/ouR5DqygFD3thRiy2dhF4xU7GTJFkBln60FMPp55jAMO25YdMDU2aAI0Vr3iSE4QbK18Pkj6d0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=d/5YONai; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712213303; x=1743749303;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LGK2yHu2NA1tw1OVzxXDi8K+v7+Kt4wEU5L7h21w5BU=;
  b=d/5YONaiIEL4Wuw8gf5F7ALD8YC6Yis6Qkv2g9vy+mHgUsIstnPdOFrp
   O2f5H/pngiLRm8YDRr+neIwSg05My3qEZu23IjGnpdbaDI/cTcVW4CjTe
   gQjkQAk4epxc+xsBxdCAuJFz5GRo9hCSu4revDtOe8YxeoqWpym6hjrfe
   S5ZyJ3CW+p3KeuFpP29XI4AM8fghJy9CTjD63fkPyE4CMFm7Xk8Bqe/WO
   c/5/5CuheW7kW3Vs48BgcMuF3+xkV9VxCC9MrAgQeIC+qYB+3zoD3ZeZt
   JSLlb7h/nvZxPCIJW+4CrukHalv/0U/w0iRmnOulYIXlqnhXSMB30Z9JC
   w==;
X-CSE-ConnectionGUID: GsiGwEYZQ9CUJDJZMZRgQg==
X-CSE-MsgGUID: CFzFroZ/TOuqjz/ebU1XeA==
X-IronPort-AV: E=Sophos;i="6.07,178,1708412400"; 
   d="scan'208";a="19959521"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2024 23:48:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 23:47:51 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 3 Apr 2024 23:47:51 -0700
Date: Thu, 4 Apr 2024 08:47:50 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
CC: Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net: sparx5: add support for tc flower
 redirect action
Message-ID: <20240404064750.psxhftdmvf5pannf@DEN-DL-M31836.microchip.com>
References: <20240403-mirror-redirect-actions-v1-0-c8e7c8132c89@microchip.com>
 <20240403-mirror-redirect-actions-v1-3-c8e7c8132c89@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240403-mirror-redirect-actions-v1-3-c8e7c8132c89@microchip.com>

The 04/03/2024 20:41, Daniel Machon wrote:

Hi Daniel,

  
> +static int sparx5_tc_action_redirect(struct vcap_admin *admin,
> +				     struct vcap_rule *vrule,
> +				     struct flow_cls_offload *fco,
> +				     struct flow_action_entry *act)
> +{
> +	struct vcap_u72_action ports = {0};
> +	int err;

The same comments from previous patch applies also here.

> +
> +	if (admin->vtype != VCAP_TYPE_IS0 && admin->vtype != VCAP_TYPE_IS2) {
> +		NL_SET_ERR_MSG_MOD(fco->common.extack,
> +				   "Redirect action not supported in this VCAP");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	err = vcap_rule_add_action_u32(vrule, VCAP_AF_MASK_MODE,
> +				       SPX5_PMM_REPLACE_ALL);
> +	if (err)
> +		return err;
> +
> +	sparx5_tc_flower_set_port_mask(&ports, act->dev);
> +
> +	err = vcap_rule_add_action_u72(vrule, VCAP_AF_PORT_MASK, &ports);
> +	if (err)
> +		return err;
> +

And here.

> +	return 0;
> +}
 
> -- 
> 2.34.1
> 

-- 
/Horatiu

