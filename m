Return-Path: <linux-kernel+bounces-154961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E26098AE3A8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ECB2282971
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7131D20B33;
	Tue, 23 Apr 2024 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mlSiZK39"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B95F76C61;
	Tue, 23 Apr 2024 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870943; cv=none; b=fFHXbUlYOI70oc8iM4etmDxe9QQDUkGQuh6vujOMzaAuHkt/8T6iSBExi+gHsDraZ4GyR3tjhO/kqnoJSa51mFJkpo5CsEYNm1QO5BkinhXRaPrj8KbuAHYYJe+nYXp/Hsrvv3jBCf+FQn+Uu/ttkTBY8OwWOcjxRuHv7KJZLew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870943; c=relaxed/simple;
	bh=baFMNWGyou+cGTsc/4yhjdBlXemDBb5oXUXZS+PgXNk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdrpN2ar1gdgg/ah63OJMj3rScPbaSwn4FdNdf+HDpEqke871U3ovH6CnxCBbSawyO3F2rL8pOl/GAzxnS/kUyr8jPE/ttNMtrqe92BmBSK2QR5MWhboIY/tqUsbY8Q3T1IoPX0cxEoNl1eK0pMyN3N/ZKyOyi6MOwDii7gP+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mlSiZK39; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713870942; x=1745406942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=baFMNWGyou+cGTsc/4yhjdBlXemDBb5oXUXZS+PgXNk=;
  b=mlSiZK399cW+CJs9r9ED2niWPqJjSH3H1Ot/zvrcR4YvSa3Mo8E2tnZ6
   Ab8lLwEHvH6K1vfRN/QHRY72oinrHQH/gEdt2GP6pWb5+/9UgcOaVfPfH
   laU9IHUJXfZs7jijfmGP3EiraC3oE5aeovuzvu85i6KXgppedKYzLnY9S
   KNXzIZY8OvNvL8UASPtsNhO9ULY7zYX73UjkRAJLKQyxvUG/C3gDpJKrJ
   Aeza/aglYU2b1dFIWhDkpzMG6E0m/CUAxrUu+XNmG+Yi0JZGi5bQmYRyN
   h5LXzuVlrgEiBJmuCtmOKrjE0LBpRAwPSNDIIW1S4SGGVjNYsI0kiOOQq
   g==;
X-CSE-ConnectionGUID: DdasAwANSf+S3v9cTxLjwg==
X-CSE-MsgGUID: xhX+9NR7Q3Stoz0pADNDug==
X-IronPort-AV: E=Sophos;i="6.07,222,1708412400"; 
   d="scan'208";a="253077175"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Apr 2024 04:15:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 04:15:17 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Apr 2024 04:15:15 -0700
Date: Tue, 23 Apr 2024 11:15:15 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
CC: <netdev@vger.kernel.org>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>, <UNGLinuxDriver@microchip.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 1/2] net: sparx5: flower: cleanup
 sparx5_tc_flower_handler_control_usage()
Message-ID: <20240423111515.wzvclnlxdwv77zy7@DEN-DL-M70577>
References: <20240423102728.228765-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423102728.228765-1-ast@fiberby.net>

Hi Asbjørn,

Thank you for your patch!

> Define extack locally, to reduce line lengths and future users.
> 
> Only perform fragment handling, when at least one fragment flag is set.
> 
> Remove goto, as it's only used once, and the error message is specific
> to that context.
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
> ---
>  .../ethernet/microchip/sparx5/sparx5_tc_flower.c    | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
> index 663571fe7b2d..d846edd77a01 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c
> @@ -159,13 +159,14 @@ sparx5_tc_flower_handler_basic_usage(struct vcap_tc_flower_parse_usage *st)
>  static int
>  sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
>  {
> +       struct netlink_ext_ack *extack = st->fco->common.extack;

Could you please update the use of extack in all places inside this
function. You are missing one place.

>         struct flow_match_control mt;
>         u32 value, mask;
>         int err = 0;
> 
>         flow_rule_match_control(st->frule, &mt);
> 
> -       if (mt.mask->flags) {
> +       if (mt.mask->flags & (FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG)) {

Since these flags are used here and in the next patch, maybe assign them
to a variable:

u32 supp_flags = FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG

And update the use throughout.

>                 u8 is_frag_key = !!(mt.key->flags & FLOW_DIS_IS_FRAGMENT);
>                 u8 is_frag_mask = !!(mt.mask->flags & FLOW_DIS_IS_FRAGMENT);
>                 u8 is_frag_idx = (is_frag_key << 1) | is_frag_mask;
> @@ -190,17 +191,15 @@ sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
>                 err = vcap_rule_add_key_u32(st->vrule,
>                                             VCAP_KF_L3_FRAGMENT_TYPE,
>                                             value, mask);
> -               if (err)
> -                       goto out;
> +               if (err) {
> +                       NL_SET_ERR_MSG_MOD(extack, "ip_frag parse error");
> +                       return err;
> +               }
>         }
> 
>         st->used_keys |= BIT_ULL(FLOW_DISSECTOR_KEY_CONTROL);
> 
>         return err;
> -
> -out:
> -       NL_SET_ERR_MSG_MOD(st->fco->common.extack, "ip_frag parse error");
> -       return err;
>  }
> 
>  static int
> --
> 2.43.0

Also I think you missing a cover letter for this series.

I will run the patches through our tests once the issues are addressed.

/Daniel


