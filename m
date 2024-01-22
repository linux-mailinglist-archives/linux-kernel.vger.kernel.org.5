Return-Path: <linux-kernel+bounces-32641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0AA835E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9041C234A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2661439FC8;
	Mon, 22 Jan 2024 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hsFuu2b2"
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F8539FC5;
	Mon, 22 Jan 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916363; cv=none; b=LrmuiegyY12ZTVyLgOH9KrSsxHZ2tE8U3gvwXt1My609km4ISZUune88rjeAKRuDFACC8X8/isYC5dxvBWhjFiXCrTfYO8lRskB6rf5mI2ov4UWN00J8qKJBKUdeEFTUDCqlzDLOtQxwGva7M9NeKjardEvBSyMAITCPYOWR2d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916363; c=relaxed/simple;
	bh=//UbHTP66T/3Bbp+ALZPOi1OABLSsOFzh5n/KVWypkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXlFxWA9NCpB6TMKDFhGNVxizFFW5uqTD/Vqi6vDtQjotOVU7oSWhV6sCwqxUPt3BpahoZeBDSm8XZz479kaGvhsUwZgnSEGr/Zwd8RqUQc70MZJxsTxGUksKOXWbtMhwNsB7rTLYEAZiOw4ysysMD+MBqxhgDZ27QltRRp/Fjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hsFuu2b2; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 85D785C00C4;
	Mon, 22 Jan 2024 04:39:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 22 Jan 2024 04:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705916360; x=1706002760; bh=PotvrWwsMR7MuOH77N/IRKZsV4mk
	ArNK04ios3YAzIE=; b=hsFuu2b2twCbknwE+EuDoJTW9qkJ2mGnsHoYDbZ8NLCc
	KiG9Ia2LrUf57XxrJycupOOrY1TX4jLx2XgtavqXsXr0xKTe2nJzENY5mFT1G2t/
	jXD4XSinaIQmBv+TQwVKQgrHKgF+osHgV+g/7oiPb2gPrLjFOL4UVbU3IBkkPWVU
	RO5Rv/vAp2EtOgrRXtUAqwjj8f/8/Lcuclim/hrUeIyYWIfr3xCj51cK5sA9kTi2
	9I8i0KUzdM2VxFT10OVrgPtC94KsGucrknT/arg1XrNjvmwtT+RlunaRH+WZ1kCd
	sB0qemqQQtIXbw5pxsvF/4dWp91/oZBiLcjmqaYgRA==
X-ME-Sender: <xms:yDeuZb6TPPVuOY5yfTIFF3yXTScpTerW5Bf8K5dXSwy5OM6nCrZiXQ>
    <xme:yDeuZQ64pRbjeNOmKtjSAi-9J25szfF4C9ppmCQwAvo_UcuCvo70i6mEE6kJZg0lK
    VcQff4rExP0osI>
X-ME-Received: <xmr:yDeuZSdKNFCe-1iSyVs1VM4Ckkr_AdTqLeV7eygihpOdkRgXRIzgERGNCQIB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:yDeuZcIIupMje_iHZoxF1OdxwQ2zZW31ChpAcZ5atPYIm-UwYZvtHA>
    <xmx:yDeuZfLKL5WyuJkX-rkwz6vGtoQzugMiqlVMZ99rGSFjEvEExQ2XtA>
    <xmx:yDeuZVxxrelR5apV_1K4F8678Zp6Tss3QnIlZiRXj65wRt6gAq0wFg>
    <xmx:yDeuZcFQzG5cGj0Mp7cLyCABKiWM084MABd998OhUsRMK3JLFz5fFA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 04:39:19 -0500 (EST)
Date: Mon, 22 Jan 2024 11:39:16 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Thomas Lamprecht <t.lamprecht@proxmox.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: vxlan: how to expose opt-in RFC conformity with unprocessed
 header flags
Message-ID: <Za43xKoWDtL6MxCn@shredder>
References: <db8b9e19-ad75-44d3-bfb2-46590d426ff5@proxmox.com>
 <20240116082357.22daf549@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116082357.22daf549@kernel.org>

On Tue, Jan 16, 2024 at 08:23:57AM -0800, Jakub Kicinski wrote:
> On Fri, 12 Jan 2024 16:13:22 +0100 Thomas Lamprecht wrote:
> > What would be the accepted way to add a switch of making this RFC conform in
> > an opt-in way? A module parameter? A sysfs entry? Through netlink?
> 
> Thru netlink. 

+1 

> My intuition would be to try to add a "ignore bits" mask, rather than
> "RFC compliance knob" because RFCs may have shorter lifespan than
> kernel's uAPI guarantees..

Newer Spectrum chips have a 64 bit mask that covers the entire VXLAN
header. If a bit is set in the mask and the corresponding bit in the
VXLAN header is not zero, the packet is dropped / trapped.

Another option, assuming the interface that receives the encapsulated
packets is known, is to clear the reserved bits in the VXLAN header
using pedit. This seems to work:

tc -n ns2 qdisc add dev veth1 clsact
tc -n ns2 filter add dev veth1 ingress pref 1 proto ip flower ip_proto udp \
        dst_port 4789 \
        action pedit munge offset 28 u8 set 0x08

Tested by setting the reserved bits on the other side and making sure
ping works:

tc -n ns1 qdisc add dev veth0 clsact
tc -n ns1 filter add dev veth0 egress pref 1 proto ip flower ip_proto udp \
        dst_port 4789 \
        action pedit munge offset 28 u8 set 0xff

The advantage is that no kernel changes are required whereas the netlink
solution will have to be maintained forever, even after the other side
is fixed.

