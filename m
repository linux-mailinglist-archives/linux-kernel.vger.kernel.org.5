Return-Path: <linux-kernel+bounces-131066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3BC8982A6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22018B28157
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64355E07E;
	Thu,  4 Apr 2024 07:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ywRjfuXD"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796595CDE4;
	Thu,  4 Apr 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217506; cv=none; b=KWIyhy7QprBHfnOz5/wrFGX0tSlOqVCqunSsZ6oForJkXChL1ONYAMyJP3nny0a8XcMqScfQ6/dqMNvI73OD9fmONxv8RE7/dgyaoFO+UGm3sWYbsnbl8kziENPPYaX+gzd3L3XlMjzuRnvR95bAWmHajSwaMRo/4cm4greRkj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217506; c=relaxed/simple;
	bh=ex8Jbm7t4k8Fpjz2pzUFpRuPZgP2C2fuI1ETdKnGMcE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ces7ftp5liMECRD/nFA9uAjw81joOtLVwijWooEBRws5aKKC+9Ylr2OPdM3qkUh7zhdibkZWKzvqh74bANABLiiDXSYM3wk0CiZUdGUlTsqzb4GhMjONjegWzIgdIefGE9Gp8EbxPbkhRiB6pcwq/cA8DZ+RKe7veH+Qs/bA9os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ywRjfuXD; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712217503; x=1743753503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ex8Jbm7t4k8Fpjz2pzUFpRuPZgP2C2fuI1ETdKnGMcE=;
  b=ywRjfuXDoSVG2YHRnqeUC2Cuhy2bfuxJlj6EsiF8adCKEdWml/BoiNEy
   3sH1IMLPtKR/nP/XMipUrd8HpfPgVljqpSo01p4Xk1IF9mkJRqQCGtDv4
   dPm8qX+L/04EBghkUQk21H2F8MZ8h+qCWeROp9fIYvI8PpYNiiP97u1B1
   Bp9QrmofJsIUwT9dune8pDgMcgdZmYS7z5PLNyC2qOtR8xb1o7XMlQL8f
   BhndKu0V+jOq8D15JyJck8uebay5Ag5yW1M+Gr6dSDZdgOxbN5o27XR4p
   STZE2uKDBhYaAx/9uRx4tq+YyeqgjHsPXm8Yaw43+6v5pfiOQydYhaBnV
   w==;
X-CSE-ConnectionGUID: xzFzvc8LTJeba3q7BJRCVg==
X-CSE-MsgGUID: exhvIqGvSK6Mb92ZHSxnIg==
X-IronPort-AV: E=Sophos;i="6.07,178,1708412400"; 
   d="scan'208";a="21363534"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Apr 2024 00:58:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Apr 2024 00:58:16 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 4 Apr 2024 00:58:14 -0700
Date: Thu, 4 Apr 2024 07:58:13 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
CC: Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/3] net: sparx5: add support for tc flower
 mirred action.
Message-ID: <20240404075813.nploesovm4katckb@DEN-DL-M70577>
References: <20240403-mirror-redirect-actions-v1-0-c8e7c8132c89@microchip.com>
 <20240403-mirror-redirect-actions-v1-2-c8e7c8132c89@microchip.com>
 <20240404064627.6m25m2mi7zbpqbyo@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240404064627.6m25m2mi7zbpqbyo@DEN-DL-M31836.microchip.com>

> The 04/03/2024 20:41, Daniel Machon wrote:
> 
> Hi Daniel,
> 
> ...
> 
> > +static int sparx5_tc_action_mirred(struct vcap_admin *admin,
> > +				   struct vcap_rule *vrule,
> > +				   struct flow_cls_offload *fco,
> > +				   struct flow_action_entry *act)
> > +{
> > +	struct vcap_u72_action ports = {0};
> 
> Maybe this is just a preferences, but usually we use memset instead of {0};

Yes, I think this falls under preference. I'd like to keep this one as
is.

> 
> > +	int err;
> > +
> > +	if (admin->vtype != VCAP_TYPE_IS0 && admin->vtype != VCAP_TYPE_IS2) {
> > +		NL_SET_ERR_MSG_MOD(fco->common.extack,
> > +				   "Mirror action not supported in this VCAP");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	err = vcap_rule_add_action_u32(vrule, VCAP_AF_MASK_MODE,
> > +				       SPX5_PMM_OR_DSTMASK);
> > +	if (err)
> > +		return err;
> > +
> > +	sparx5_tc_flower_set_port_mask(&ports, act->dev);
> > +
> > +	err = vcap_rule_add_action_u72(vrule, VCAP_AF_PORT_MASK, &ports);
> > +	if (err)
> > +		return err;
> 
> You can just return directly the return value from vcap_rule_add_action_u72
> Something like:
> 
> return vcap_rule_add_action_u72(...)
>

Yes, seems like a reasonable change :-) I need to respin anyway, since
NIPA is complaining about something I didn't catch in my local run. Will
incorporate changes in v2 - thanks.

> > +
> > +	return 0;
> > +}
> > -- 
> > 2.34.1
> > 
> 
> -- 
> /Horatiu

