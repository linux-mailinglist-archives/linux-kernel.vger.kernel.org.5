Return-Path: <linux-kernel+bounces-37249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 755FE83AD44
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F161C23904
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F8B7A70C;
	Wed, 24 Jan 2024 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XOOstg60"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B7F22085;
	Wed, 24 Jan 2024 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110015; cv=none; b=D3Zfqqq/ZJxSgtmhGp/PQshmEX0OGMYlYVi3hsl2u6w6xNcan6vyFqlJO/9TErlIANNX68NbxiSLhfHVnJO67RFeszZQ4sNzpnXDYKYxe0m4tCYOnGSAIEDgMdenZFsIKYBdm4/8RNs9bab2cqF8G5V1MTldpDSI5lQbtAQ9Abw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110015; c=relaxed/simple;
	bh=4P57sBKVCs3MY83Hd0Fp0MqjqaVsRdjUHDjmEhi/6eI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdLHPPeHW97QED7v3Z2Ks7Lm3vU4JCUckTy7OKjc+n3Hi0NlCK2vc0drO9Ezyr2sCjj4pXjN7S1W4n+d3B75P3xBhPb+cwWH5+ldAE76bK5ymdWlI7B5qeVwe9zBA1m5/kNEj9rjLVG2GVjYslYnNeLqm3eJYUQjLibZa8hwPrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XOOstg60; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A345160007;
	Wed, 24 Jan 2024 15:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706110010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TGKqb8PfNbcdc7vOG6mzmbB70CQFl8QHgJOa/gqXS78=;
	b=XOOstg60KgIbgyGgmgT6sVR+BznJZGxgtuMaNvi2uKxrvRhNy0pjmLTdmOBWrHpbzQOpxS
	gUiZyRRXGNu/gasgAWh7ilfgenSA6py0gC5+riKvq+4tO+vAfjwYeezowvUng4cyc4v/Mt
	oGwBLecvDGt1t2XaQfjyOaYG/KulXg4RiGl8yVc+xE//JvRuqhAxWcw7bAA6+Eewl1AViQ
	/MUZjmldwWdDWBo8f4Vws99TzRH2Y4MtOhK/JhxY8OFw/Cy7f2GTJtGR7xmQwLRH+897pa
	5Z2z5yCNRuXSmtflltBdnP2vfasJ9Lm/Do09I6ql4bK1psTTfe//1/331v8bTA==
Date: Wed, 24 Jan 2024 16:26:46 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>, Mark Brown
 <broonie@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/4] net: wan: fsl_qmc_hdlc: Add runtime timeslots
 changes support
Message-ID: <20240124162646.24bf9235@bootlin.com>
In-Reply-To: <fc421c38-66b7-4d4e-abfa-051eccbf793c@linux.dev>
References: <20240123164912.249540-1-herve.codina@bootlin.com>
	<20240123164912.249540-4-herve.codina@bootlin.com>
	<fc421c38-66b7-4d4e-abfa-051eccbf793c@linux.dev>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Vadim,

On Wed, 24 Jan 2024 10:10:46 +0000
Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:

[...]
> > +static int qmc_hdlc_xlate_slot_map(struct qmc_hdlc *qmc_hdlc,
> > +				   u32 slot_map, struct qmc_chan_ts_info *ts_info)
> > +{
> > +	u64 ts_mask_avail;
> > +	unsigned int bit;
> > +	unsigned int i;
> > +	u64 ts_mask;
> > +	u64 map;
> > +
> > +	/* Tx and Rx masks must be identical */
> > +	if (ts_info->rx_ts_mask_avail != ts_info->tx_ts_mask_avail) {
> > +		dev_err(qmc_hdlc->dev, "tx and rx available timeslots mismatch (0x%llx, 0x%llx)\n",
> > +			ts_info->rx_ts_mask_avail, ts_info->tx_ts_mask_avail);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ts_mask_avail = ts_info->rx_ts_mask_avail;
> > +	ts_mask = 0;
> > +	map = slot_map;
> > +	bit = 0;
> > +	for (i = 0; i < 64; i++) {
> > +		if (ts_mask_avail & BIT_ULL(i)) {
> > +			if (map & BIT_ULL(bit))
> > +				ts_mask |= BIT_ULL(i);
> > +			bit++;
> > +		}
> > +	}
> > +
> > +	if (hweight64(ts_mask) != hweight64(map)) {
> > +		dev_err(qmc_hdlc->dev, "Cannot translate timeslots 0x%llx -> (0x%llx,0x%llx)\n",
> > +			map, ts_mask_avail, ts_mask);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ts_info->tx_ts_mask = ts_mask;
> > +	ts_info->rx_ts_mask = ts_mask;
> > +	return 0;
> > +}
> > +
> > +static int qmc_hdlc_xlate_ts_info(struct qmc_hdlc *qmc_hdlc,
> > +				  const struct qmc_chan_ts_info *ts_info, u32 *slot_map)
> > +{
> > +	u64 ts_mask_avail;
> > +	unsigned int bit;
> > +	unsigned int i;
> > +	u64 ts_mask;
> > +	u64 map;
> > +  
> 
> Starting from here ...
> 
> > +	/* Tx and Rx masks must be identical */
> > +	if (ts_info->rx_ts_mask_avail != ts_info->tx_ts_mask_avail) {
> > +		dev_err(qmc_hdlc->dev, "tx and rx available timeslots mismatch (0x%llx, 0x%llx)\n",
> > +			ts_info->rx_ts_mask_avail, ts_info->tx_ts_mask_avail);
> > +		return -EINVAL;
> > +	}
> > +	if (ts_info->rx_ts_mask != ts_info->tx_ts_mask) {
> > +		dev_err(qmc_hdlc->dev, "tx and rx timeslots mismatch (0x%llx, 0x%llx)\n",
> > +			ts_info->rx_ts_mask, ts_info->tx_ts_mask);
> > +		return -EINVAL;
> > +	}
> > +
> > +	ts_mask_avail = ts_info->rx_ts_mask_avail;
> > +	ts_mask = ts_info->rx_ts_mask;
> > +	map = 0;
> > +	bit = 0;
> > +	for (i = 0; i < 64; i++) {
> > +		if (ts_mask_avail & BIT_ULL(i)) {
> > +			if (ts_mask & BIT_ULL(i))
> > +				map |= BIT_ULL(bit);
> > +			bit++;
> > +		}
> > +	}
> > +
> > +	if (hweight64(ts_mask) != hweight64(map)) {
> > +		dev_err(qmc_hdlc->dev, "Cannot translate timeslots (0x%llx,0x%llx) -> 0x%llx\n",
> > +			ts_mask_avail, ts_mask, map);
> > +		return -EINVAL;
> > +	}
> > +  
> 
> till here the block looks like copy of the block from previous function.
> It worth to make a separate function for it, I think.
> 
> > +	if (map >= BIT_ULL(32)) {
> > +		dev_err(qmc_hdlc->dev, "Slot map out of 32bit (0x%llx,0x%llx) -> 0x%llx\n",
> > +			ts_mask_avail, ts_mask, map);
> > +		return -EINVAL;
> > +	}
> > +
> > +	*slot_map = map;
> > +	return 0;
> > +}
> > +
[...]

I am not so sure. There are slighty differences between the two functions.
The error messages and, in particular, the loop in qmc_hdlc_xlate_slot_map() is:
	--- 8< ---
	ts_mask_avail = ts_info->rx_ts_mask_avail;
	ts_mask = 0;
	map = slot_map;
	bit = 0;
	for (i = 0; i < 64; i++) {
		if (ts_mask_avail & BIT_ULL(i)) {
			if (map & BIT_ULL(bit))
				ts_mask |= BIT_ULL(i);
			bit++;
		}
	}
	--- 8< ---

whereas it is the following in qmc_hdlc_xlate_ts_info():
	--- 8< ---
	ts_mask_avail = ts_info->rx_ts_mask_avail;
	ts_mask = ts_info->rx_ts_mask;
	map = 0;
	bit = 0;
	for (i = 0; i < 64; i++) {
		if (ts_mask_avail & BIT_ULL(i)) {
			if (ts_mask & BIT_ULL(i))
				map |= BIT_ULL(bit);
			bit++;
		}
	}
	--- 8< ---

ts_map and map initializations are not the same, i and bit are not used for
the same purpose and the computed value is not computed based on the same
information.

With that pointed, I am not sure that having some common code for both
function will be relevant. Your opinion ?

Best regards,
Hervé

