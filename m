Return-Path: <linux-kernel+bounces-155786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 320878AF717
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D161F2550A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382CB13FD86;
	Tue, 23 Apr 2024 19:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hzFa8ov+"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8C413F458;
	Tue, 23 Apr 2024 19:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713899730; cv=none; b=Mz82otAydzd6Cp88CbMbFqSVep5/lfQqfXEabO6G7f8K32Xsd2nYZgOf/+I1Z/pJdv4z42WYToSgmW8IJF/h6/iFsx0eJfRUxbSNnoKu+FwTB490RorrViwdRiX+c5n77hAR2Jweyx9ibK1yLImDV5xyYoDUPireS1bbGzTy2p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713899730; c=relaxed/simple;
	bh=NamVyGNhcAdeE0FhFAkCQho8WPc4LSkNyW3eImgeIWg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2cUGzottuBXjSgTk0ebQNsnDB2BCpS2fM/hRxJuSKrw0uhRwg25Ja3GYDrv8PXnxv+mHDHFqZ4hDzg0MoKPp9xRdIParWijagDG5q1G/EE6cZJh33TE/T1XuE4SAinDBNM0sRRRZGVNOj2A88uLedhWSQcgQ26H5lnXMhLmD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hzFa8ov+; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713899728; x=1745435728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NamVyGNhcAdeE0FhFAkCQho8WPc4LSkNyW3eImgeIWg=;
  b=hzFa8ov+I39C5k+TN8xuPYAJgxKYhGTThO8EvPyZlaIeyeTQmsV3ALzd
   l/xkfGbMAFyGSKwot86jYtQWnaOZ7ge01zWMVzlN49UUu31rJso1/G2wD
   8P0KTgIkMP7fqINgL0NTnf3xjRI2QPimaKZzfLBi2Fk61L6ToA5YkjmEe
   9i7M9OYLs2HXBjQtnIo+8i2eDmAcF0E9kL3oRVgAvaAWJNlGme8F/hu18
   h3m9wGigXYgoqrWt6AdHs4LzF964AQ3bIO2Ox0453Tg+RPb2Z3apA8t5H
   vXcBTfzTVkfQdaQlwkzrV/NRYV8dps62aSkGGlGmt6UFmNOKB4gS+NNgJ
   A==;
X-CSE-ConnectionGUID: Kl1sSzTvQmW3T0xKu8i8cQ==
X-CSE-MsgGUID: kh67dMNmQUKYdaHvQwgKZQ==
X-IronPort-AV: E=Sophos;i="6.07,222,1708412400"; 
   d="scan'208";a="189648523"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Apr 2024 12:15:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 12:15:19 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Apr 2024 12:15:16 -0700
Date: Tue, 23 Apr 2024 19:15:16 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
CC: <netdev@vger.kernel.org>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>, <UNGLinuxDriver@microchip.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next 1/2] net: sparx5: flower: cleanup
 sparx5_tc_flower_handler_control_usage()
Message-ID: <20240423191516.o6ssgqhrsk7hizdk@DEN-DL-M70577>
References: <20240423102728.228765-1-ast@fiberby.net>
 <20240423111515.wzvclnlxdwv77zy7@DEN-DL-M70577>
 <8e112b31-0168-4e82-a378-87211ea99cfa@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e112b31-0168-4e82-a378-87211ea99cfa@fiberby.net>

> > > -       if (mt.mask->flags) {
> > > +       if (mt.mask->flags & (FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG)) {
> > 
> > Since these flags are used here and in the next patch, maybe assign them
> > to a variable:
> > 
> > u32 supp_flags = FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG
> > 
> > And update the use throughout.
> 
> In an earlier state this patch had a #define SPARX5_FLOWER_SUPPORTED_CTLFLAGS,
> in the same style as nfp in drivers/net/ethernet/netronome/nfp/flower/offload.c
> 
> Right now, this driver supports all currently defined flags (which are used with mask),
> so the point of using flow_rule_is_supp_control_flags() to this dirver, is to
> make it possible to introduce new flags in the future, without having to update
> all drivers to explicitly not support a new flag.
> 
> My problem with using supp_flags in both places is: What happens when support
> for a new flag is introduced?
> 
> u32 supp_flags = FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG | FLOW_DIS_NEW_FLAG;
> 
> if (mt.mask->flags & (FLOW_DIS_IS_FRAGMENT | FLOW_DIS_FIRST_FRAG))
>         /* handle fragment flags through lookup table */
> 
> if (mt.mask->flags & FLOW_DIS_NEW_FLAG)
>         /* do something */
> 
> if (!flow_rule_is_supp_control_flags(supp_flags, mt.mask->flags, extack))
>         return -EOPNOTSUPP;
> 
> The fragment lookup table code currently requires the above guarding,
> as [0][0] in the lookup table is FRAG_INVAL, and not FRAG_SHRUG.
> 
> What do you think?

Yes - lets only check for fragment flags when doing the lookup. I am
fine with your original impl.

If you can fix the remaining issue, I will take the patches for a test
spin tomorrow.

Thanks!

> 
> --
> Best regards
> Asbjørn Sloth Tønnesen
> Network Engineer
> Fiberby - AS42541

