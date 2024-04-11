Return-Path: <linux-kernel+bounces-139911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 401278A0910
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3A71F21E81
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F2313DDBD;
	Thu, 11 Apr 2024 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="w97xjmBZ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17320523A;
	Thu, 11 Apr 2024 07:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819088; cv=none; b=F8Uk7a/Rg5PObN7ekXuqMeJU5roPUST2dFYfNCdPtlNyYi0un28FUK9n8Sm46bRMg5VcCaA0HacRjor/ETmt5HiqLhThYgvXX0hAp0MOROkyMw6O3vyQq18Z2EykMeeqB6ubKXSfdk5C2awuehGOLxNiv1QlJqSNY8RM+9pwH48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819088; c=relaxed/simple;
	bh=0OAlRLFkgYzXEC0BlyzffbfPcf/pRXaaT8I3u/trQ00=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0PeYC2PKVHFwK4RElE3y9/eNAr71nyt/b7wesit6+iCblJZ3cPxcUEs57LPTa7x5rFWk05CJWguzqzP96kuAx1z+MPqEG1b93sNhLNmuH31LC5uEfNVv7wVqifiSSLrBNN7ntqKPhlaErqTIKLxh7bswn9uDbz7ZBtyZ+c53KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=w97xjmBZ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712819086; x=1744355086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0OAlRLFkgYzXEC0BlyzffbfPcf/pRXaaT8I3u/trQ00=;
  b=w97xjmBZPPIvpc0D3NNbuISVYnpLElJqBNfHvx+q6d6hLPyZ0Jd4nfXm
   HZfMmGDAAfi4D/6fzxwI42lhNbHu2VBFBLUa7MFq+JDGXVFaDZ5TnZdxp
   iMezS+DgnKZIVHQI1ngWzPkxAwExlkE7lliGwiPq+1iRHM/d0i80nTM0u
   SIO8g09S3aA6Tr4pvlxCs1rbdmtRPIWS5LnkgaUb4rvJbgM38tbM2VZCE
   g4lCjCExuLfyA2sUqQkoHWEb1FqWZ4AOZKJTk1TojCHl69rH3gWzhOwaq
   LRO/tJaOl1xCzNmHc2Dnc1lj/jjEieK92YfFx77AqEkMDrgAgI7JSEBMC
   g==;
X-CSE-ConnectionGUID: umr+2rzeTmeMDSDDw69iGA==
X-CSE-MsgGUID: tkV1ScQ/R72oUu+yKOdD7A==
X-IronPort-AV: E=Sophos;i="6.07,192,1708412400"; 
   d="scan'208";a="20531085"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Apr 2024 00:04:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 00:04:11 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 11 Apr 2024 00:04:08 -0700
Date: Thu, 11 Apr 2024 07:04:08 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
CC: <netdev@vger.kernel.org>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>, <UNGLinuxDriver@microchip.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] net: sparx5: flower: fix fragment flags handling
Message-ID: <20240411070408.jtic3ndd2zxngga6@DEN-DL-M70577>
References: <20240410095224.6372-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410095224.6372-1-ast@fiberby.net>

Hi Asbjørn,

I know I am nitpicking here, but could you please sneak in below
changes.

>  static int
>  sparx5_tc_flower_es0_tpid(struct vcap_tc_flower_parse_usage *st)
>  {
> @@ -145,29 +166,27 @@ sparx5_tc_flower_handler_control_usage(struct vcap_tc_flower_parse_usage *st)
>         flow_rule_match_control(st->frule, &mt);
> 
>         if (mt.mask->flags) {
> -               if (mt.mask->flags & FLOW_DIS_FIRST_FRAG) {
> -                       if (mt.key->flags & FLOW_DIS_FIRST_FRAG) {
> -                               value = 1; /* initial fragment */
> -                               mask = 0x3;
> -                       } else {
> -                               if (mt.mask->flags & FLOW_DIS_IS_FRAGMENT) {
> -                                       value = 3; /* follow up fragment */
> -                                       mask = 0x3;
> -                               } else {
> -                                       value = 0; /* no fragment */
> -                                       mask = 0x3;
> -                               }
> -                       }
> -               } else {
> -                       if (mt.mask->flags & FLOW_DIS_IS_FRAGMENT) {
> -                               value = 3; /* follow up fragment */
> -                               mask = 0x3;
> -                       } else {
> -                               value = 0; /* no fragment */
> -                               mask = 0x3;
> -                       }
> +               u8 is_frag_key = !!(mt.key->flags & FLOW_DIS_IS_FRAGMENT);
> +               u8 is_frag_mask = !!(mt.mask->flags & FLOW_DIS_IS_FRAGMENT);
> +               u8 is_frag_idx = (is_frag_key << 1) | is_frag_mask;
> +
> +               u8 first_frag_key = !!(mt.key->flags & FLOW_DIS_FIRST_FRAG);
> +               u8 first_frag_mask = !!(mt.mask->flags & FLOW_DIS_FIRST_FRAG);
> +               u8 first_frag_idx = (first_frag_key << 1) | first_frag_mask;
> +
> +               /* lookup verdict based on the 2 + 2 input bits */
> +               u8 vdt = sparx5_vcap_frag_map[is_frag_idx][first_frag_idx];
> +
> +               if (vdt == FRAG_INVAL) {
> +                       NL_SET_ERR_MSG_MOD(st->fco->common.extack,
> +                                          "match on invalid fragment flag combination");

Please start this NL msg with a capital letter. All (AFAICS) other
places in this file do this - nice to stay consistent. As a matter of
fact, also do this to the new comments introduced.

> +                       return -EINVAL;
>                 }
> 
> +               /* extract VCAP fragment key and mask from verdict */
> +               value = (vdt >> 4) & 0x3;
> +               mask = vdt & 0x3;
> +
>                 err = vcap_rule_add_key_u32(st->vrule,
>                                             VCAP_KF_L3_FRAGMENT_TYPE,
>                                             value, mask);
> --
> 2.43.0
> 

Checkpatch is producing a warning about the placement of the version
information of the patch. Might as well fix this while at it.

Thanks,

/Daniel

