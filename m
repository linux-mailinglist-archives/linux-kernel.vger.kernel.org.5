Return-Path: <linux-kernel+bounces-130986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8539898199
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E60C1C23209
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54851446BF;
	Thu,  4 Apr 2024 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="s3RmDrb1"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D1339AC;
	Thu,  4 Apr 2024 06:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712213227; cv=none; b=qjS2UAz/CRBF6FykuHgqcl7nY2pVPAPHBy9h3gHNsI57wLUYv7qOeI3MZSI+/S0MC97hwuP320rqrLch0vACzxfr+u3ypQukXgV9mzUb9TfIDFj+H5EsW9iMGStXWDJqoGmo2bHOGqRsQDqUFOOGzdHKW5F9P4ZpHAvGCuNfbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712213227; c=relaxed/simple;
	bh=BS/s55oBb1N9cMaDzp7eKHOCuDD7OcEW31rL76+i51g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=An8/WuW5+rxVF5Q+o1fUvCyAwl78QPQ5KhTlHbPAd/626YSiAOFn1z6EGRiCOlUmUdaAOOjr7ZIgqMBSKLht7i6wg39KiPWUJPi2rQTeDibtxDDby38sqk4FO1NM8v5OXTG+DE2KLC5xNkQj4ikVAYkULaWWXwxqvQV+knh3xd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=s3RmDrb1; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712213225; x=1743749225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BS/s55oBb1N9cMaDzp7eKHOCuDD7OcEW31rL76+i51g=;
  b=s3RmDrb1PA8C4NlIDe6c6vkMzj9XfZLWAv8UR/uNP7m6vllYBQm5+oWZ
   NVHZO7xgzdXr9JUrQWDngoJJ8z7UzLVwibiY2TBk9cHMIZyd9HIR69v0z
   lA5kj75nWG9L00qNqBhZmGUk0cOf9luVCvIBuj8JWSKGnSHaa3j80f8cn
   JLk2hijDth3oKezhuG/m4lXb6efZF0bYWn308n2R287T6gyiA5K+lYs1t
   AqhxiH8VnJgaUuHASyopOb+wdwcaNGbX776U+5kzVmNEEOlMYmLj9ChQ2
   f3vVXzqItSFRyFXjfZ/TrrFV3gs7YUvpNaTRrT8cb0YjlajhPuTjYxyfq
   Q==;
X-CSE-ConnectionGUID: axQ+w/uKQnKRlWfZ5SIJiw==
X-CSE-MsgGUID: kNgSi04tRKyk6BXjxBVdHQ==
X-IronPort-AV: E=Sophos;i="6.07,178,1708412400"; 
   d="scan'208";a="186701098"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2024 23:47:04 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 23:46:28 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 3 Apr 2024 23:46:28 -0700
Date: Thu, 4 Apr 2024 08:46:27 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
CC: Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] net: sparx5: add support for tc flower
 mirred action.
Message-ID: <20240404064627.6m25m2mi7zbpqbyo@DEN-DL-M31836.microchip.com>
References: <20240403-mirror-redirect-actions-v1-0-c8e7c8132c89@microchip.com>
 <20240403-mirror-redirect-actions-v1-2-c8e7c8132c89@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240403-mirror-redirect-actions-v1-2-c8e7c8132c89@microchip.com>

The 04/03/2024 20:41, Daniel Machon wrote:

Hi Daniel,

..

> +static int sparx5_tc_action_mirred(struct vcap_admin *admin,
> +				   struct vcap_rule *vrule,
> +				   struct flow_cls_offload *fco,
> +				   struct flow_action_entry *act)
> +{
> +	struct vcap_u72_action ports = {0};

Maybe this is just a preferences, but usually we use memset instead of {0};

> +	int err;
> +
> +	if (admin->vtype != VCAP_TYPE_IS0 && admin->vtype != VCAP_TYPE_IS2) {
> +		NL_SET_ERR_MSG_MOD(fco->common.extack,
> +				   "Mirror action not supported in this VCAP");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	err = vcap_rule_add_action_u32(vrule, VCAP_AF_MASK_MODE,
> +				       SPX5_PMM_OR_DSTMASK);
> +	if (err)
> +		return err;
> +
> +	sparx5_tc_flower_set_port_mask(&ports, act->dev);
> +
> +	err = vcap_rule_add_action_u72(vrule, VCAP_AF_PORT_MASK, &ports);
> +	if (err)
> +		return err;

You can just return directly the return value from vcap_rule_add_action_u72
Something like:

return vcap_rule_add_action_u72(...)

> +
> +	return 0;
> +}
> -- 
> 2.34.1
> 

-- 
/Horatiu

