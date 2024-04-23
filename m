Return-Path: <linux-kernel+bounces-154963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB80B8AE3AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B4E1C22816
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D527E573;
	Tue, 23 Apr 2024 11:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xxxt3KEA"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D507D3E3;
	Tue, 23 Apr 2024 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871027; cv=none; b=T8LxPvNjzNRZHGAkhnaM5mkhY/V8VruRoFN0KIg/bEnV2SJiLyMkx5j6NwFZtgb2CLX/uJkRv+EL0IL4uaD/9CKYK2vD/LhCJWa8Ha7+NYTWvYZi6vwZ7p2EgV9FxnLUjRExJtaXCNnl+LKkLOvMS5GBDXQIZfDJs9+fesb+xpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871027; c=relaxed/simple;
	bh=FQ8w7k3m+awfAt2WI00e6XPciwGL7V7j+ZsuF0hlZNg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thzjdE6+LpoFPV/m/Gp5aBWMmNlHhpUOC4uDcS43DbaBVNHcLMYfYMzhEN8YWQbweMCuAlamxc/3r5v1p6i+g2Fk/6B/oLTk2QWO8pQGdK6MVPBe/pGbdLWBqvi5mNi5Z7Oq4/wF3H/5kPRk5ZBNTfK6djoR7ngb0em9BcOSOiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xxxt3KEA; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713871026; x=1745407026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FQ8w7k3m+awfAt2WI00e6XPciwGL7V7j+ZsuF0hlZNg=;
  b=xxxt3KEAvput3fFDCwNmqGhF7sWrADNCm7NbssOKEI0QMR/UKwUjsbFw
   mLcGsnVSYGiiWHOcWtG0n7ZfWBI1LHio7aMzKVNuIBIaTZ/NRQCaZvfbV
   oEM5VBs3xsWxwSlI+MZfd4lrUnVN6lD9F9qK+Qch9rjLYuhqqyNZkrD6u
   JQvUADUgrQAIdmJgbVLtO9SZ4hAhOcYupWHDkrmHdXQn9Qj6WIHnEvvAc
   W3BeR7L1x++uTF46SrhiCdGHajSi9YZSfdCqBbIlquJJf7CtJft+7NE7h
   X41mLZEO/Sd/fKdyjAL6Fj5AvXqMpKz/kNDGQDZoXWpibqXdculc/v4ng
   w==;
X-CSE-ConnectionGUID: ffN6ugd4ShOnAf1ihcOd+g==
X-CSE-MsgGUID: 6Y+4TGCoRFez7yAkPzihEA==
X-IronPort-AV: E=Sophos;i="6.07,222,1708412400"; 
   d="scan'208";a="253077443"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Apr 2024 04:17:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 04:16:44 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Apr 2024 04:16:42 -0700
Date: Tue, 23 Apr 2024 11:16:42 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
CC: <netdev@vger.kernel.org>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>, <UNGLinuxDriver@microchip.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 2/2] net: sparx5: flower: check for unsupported
 control flags
Message-ID: <20240423111642.2pgzjpac65chjfxs@DEN-DL-M70577>
References: <20240423102728.228765-1-ast@fiberby.net>
 <20240423102728.228765-2-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423102728.228765-2-ast@fiberby.net>

> Use flow_rule_is_supp_control_flags() to reject filters with
> unsupported control flags.
> 
> In case any unsupported control flags are masked,
> flow_rule_is_supp_control_flags() sets a NL extended
> error message, and we return -EOPNOTSUPP.
> 
> Only compile-tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>  drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
> index d846edd77a01..f81d89f8f620 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
> @@ -197,6 +197,11 @@ sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
>                 }
>         }
> 
> +       if (!flow_rule_is_supp_control_flags(FLOW_DIS_IS_FRAGMENT |
> +                                            FLOW_DIS_FIRST_FRAG,
> +                                            mt.mask->flags, extack))
> +               return -EOPNOTSUPP;
> +
>         st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL);
> 
>         return err;
> --
> 2.43.0

As mentioned in patch #1, use supp_flags here. Otherwise looks
good.

/Daniel


