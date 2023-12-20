Return-Path: <linux-kernel+bounces-7357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540C981A679
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10AA02875AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3099481AC;
	Wed, 20 Dec 2023 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="aXXh4QTI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MrbqF/6E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A3E47A59;
	Wed, 20 Dec 2023 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 19A265C0442;
	Wed, 20 Dec 2023 12:37:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 20 Dec 2023 12:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1703093839; x=1703180239; bh=GnEOfo/anO
	WPxQKbFe9WTvHxFyLYv0rH36Sgz3O76EA=; b=aXXh4QTI7ED5bSnleEslOsioM6
	YoRDVZ74YnQU0cOVdLvloTPUot0eUYa9XmQmN2yJx4fAfiTwaglQJkyS6T9A2Qu6
	ZcY7a9HqWaMNV9Q5HKOpvH8p7dlXvfR4CPRtKfCl/23egGabG3cRvXr75CA1wlr1
	MdcukxgH1L+piPaDe2wcRI4ojzltu5/v/EDHMiFghTnk/ifNQS564GvqhgDnp0/Z
	GgxGZBSLZeCP/l5n73prVvhcGKW8mW3EqCa5Rji5SZI05knYJyofk6yyxCTG3V3e
	46/iRm0XjzN+Ja5gNL4UlxRA25HCshD6dwMIAL1C05GF6tm74rbKqc6QsjZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703093839; x=1703180239; bh=GnEOfo/anOWPxQKbFe9WTvHxFyLY
	v0rH36Sgz3O76EA=; b=MrbqF/6ESfm7v+lfWAl0Y0jTu/CYn+TBctauTik8BT2c
	8ycFNg7CxokRozm2bz5/a0Zbk2b2m8T7MHqmKAOimGo+2v0KoBc1+SIUZD5/Hn9n
	10B4A51PojaiUhTrQ59PGLpzq1ewmYWiFk/xD19o4K7n3D0PUrNWvqXqd+hF0sxA
	mLrzINgcPEUAv7ivEn5R9kHIypeJZ92R1CNPM3iHOJxdw99jhlbhHu/Om5RelZst
	rBVKty6LELb2Jikz7Idi0t51yRAX2OPIUJEejA3rZgVf6ua2bea/2X97xKH8Bnmq
	k1Iq+iCgxHJl6fnVioatlu8zfi/5lVc8cjqn+MPxwQ==
X-ME-Sender: <xms:TiaDZZr-RYhvDpYhO1PKQY0t5viCD-RgsAD2KXVtYbC-7cX3oK2A6Q>
    <xme:TiaDZbrfeXJSRpFudtXJzkO5ilpa0nMZBAtorUsyYE_MAuhKgd-qB0ZPgxPcPBRfq
    ZH8zes5uGkk3Q>
X-ME-Received: <xmr:TiaDZWO2vb8ihjMJStPeVh-Yr9MWzdKucj2L8lin6UD85hBnNO5MxmpMCcxIK8VhA0RKbHqWht-nYoIMfZv1FrIvOzg8ERuv1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:TiaDZU4Gy1eoXwmJn_MFs-OvVZaWEQBDsUWwuxsBMU6z1iQH-fOOig>
    <xmx:TiaDZY6HR3mqMKamGePb70QNMRpZ8ISGcEOL6EjHDEy_SwIH5pWQqg>
    <xmx:TiaDZcjnDINQk2k1EleuQn1fUtWmwnVTPa7ILNOIM1NQ6MPe59EmgQ>
    <xmx:TyaDZYy5nb9sRfb6yFIOVos_JX9bxHDiwD7JEn_naB-tVU27bm49bA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Dec 2023 12:37:18 -0500 (EST)
Date: Wed, 20 Dec 2023 18:30:53 +0100
From: Greg KH <greg@kroah.com>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Reduce retry timeout to speed up boot for
 some devices
Message-ID: <2023122056-snowflake-visor-1262@gregkh>
References: <20231220150956.230227-1-wse@tuxedocomputers.com>
 <2e00a0dc-5911-44ee-8c50-a8482eb44197@tuxedocomputers.com>
 <2023122012-spruce-unsteady-e187@gregkh>
 <e7c768aa-a071-4590-ab1a-d80738dce1e5@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7c768aa-a071-4590-ab1a-d80738dce1e5@tuxedocomputers.com>

On Wed, Dec 20, 2023 at 05:41:01PM +0100, Werner Sembach wrote:
> 
> Am 20.12.23 um 17:04 schrieb Greg KH:
> > On Wed, Dec 20, 2023 at 04:23:15PM +0100, Werner Sembach wrote:
> > > Am 20.12.23 um 16:09 schrieb Werner Sembach:
> > > > This is a followup to "thunderbolt: Workaround an IOMMU fault on certain
> > > > systems with Intel Maple Ridge".
> > > > 
> > > > It seems like the timeout can be reduced to 250ms. This reduces the overall
> > > > delay caused by the retires to ~1s. This is about the time other things
> > > > being initialized in parallel need anyway*, so like this the effective boot
> > > > time is no longer compromised.
> > > > 
> > > > *I only had a single device available for my measurements: A Clevo X170KM-G
> > > > desktop replacement notebook.
> > > > 
> > > > Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> > > I wonder if this could also land in stable? Or would it be to risky?
> > If it's really a bugfix now, why would it _not_ be relevant for stable?
> 
> Because it changes a timeout that could cause issues if set to low: This
> Patch sets to to 250ms. Set to 50ms it causes issues, currently it's 2000ms,
> 2 people tested that 250ms is enough, but i don't know if this is a big
> enough sample size for stable.

Remember, the next kernel will be a stable kernel tree, just like the
one after that.  If it's good enough for Linus's tree, why wouldn't it
be good enough for all stable trees?  Either it works or it doesn't,
none of this "we will break things when you move to a new kernel" stuff
please.

thanks,

greg k-h

