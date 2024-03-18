Return-Path: <linux-kernel+bounces-105859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FA387E59F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF3D280E07
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA53D2C198;
	Mon, 18 Mar 2024 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="1e3CM53i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UPEWiFgY"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E421828E34
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753798; cv=none; b=LgehOliPj7fCLFBkkfryJQSkQTrM5cTGROH3wyMcSMJ8rsB+4q/zolLUSTXcRjMiHA8JeOIcDG7oGgBkSw62CZL/CPiqFCRomfu0J6yvGfyKoVrzhM6b0e0tArX47Mt86G2zyah6aed++3kOXYVAsBu6UUaF4+15ugTngMifKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753798; c=relaxed/simple;
	bh=vgVc0nJTSCtGLh4Qy77vLltYe2aYnfglXF90ldEZ9WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2NsUi+iHJBY5C+3xRuHXRfskllxzD0QGcZ6eAcHj+PBsWxH1ITQzpxV26wSx0s6xku9O/GH23IdH9wJVTU6dDNcnPxHQUjRzsP26tu1fgRYUhWhSOR9J56Oj3hQscD89Ktuoljkdf0edGoFj4FD/yvDEZBOjy1fsl/UM1jqfU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=1e3CM53i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UPEWiFgY; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id C8C5B18000B9;
	Mon, 18 Mar 2024 05:23:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 18 Mar 2024 05:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1710753795; x=
	1710840195; bh=PUa/R/clxm2N8V+OKy2y0wtEIZOYD27dJAqezZK5f9M=; b=1
	e3CM53iHxosZylc36+6xVFeSSSsnKAkj2NWTI34viiMVKkedvIQkewHjWfpxoZBC
	36DKUzlrQJM5chxDzCpI/dzu79mh7MFtGUrPzfGP56XOrFDEdsU4F2UTNwaAnQqr
	pn1hRu6yXtxl6rnSGxWmUSoLTurOi7Q3Kxe2KgKDj/HQW4fuBcz2tLa0myNA3/6z
	7uEEY5JvkCrs/Ob9caUt+j+9gPjt4U1AE+n2QwceeMImnO51Vvo/jugJW2tTxBq6
	y+gvtrvuKlxGPcI7/JPvbGzD+uof0lmnyiBHCHrQxdrIDNIvAlw/EthuThHVmpfL
	45ybm5bUPFwFMJ85cmyEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710753795; x=1710840195; bh=PUa/R/clxm2N8V+OKy2y0wtEIZOY
	D27dJAqezZK5f9M=; b=UPEWiFgYFN/zDywhTp18AovpShgb4x85qjodUZAbvwCs
	SFJbLQ+1PbYSCAO6fLS1WGnrIx+oFj6yVat3sMbcgqbViYQA5JqNfEny4F40052f
	r76eSkTg8lLmkmBg0IoBhzUrH8gaxpB0XOhZjnkW2Od00yCRf6N2vEYyrvQ1baC2
	JMRDES+yg8m0UBPt4IGO4kc1ePA7du51D+K39YTqwxt7lX2KdIfP8IcGkz99m1i+
	Rsc0+usL95Iap+huhYshlKxbgHeiZIqzDr5OLCK7EAC2WcVdOf913m+PqYcYbcYB
	uIHVZseOiPp71bMB1SoLTPsdefAorGFc7O5BqFKoDg==
X-ME-Sender: <xms:Awj4ZaUY5kqN35OQOUhMf9i3yP5mUVrA3sFxzc4dBHkg06Ks_ofYEQ>
    <xme:Awj4ZWnYLrSlvVDCmAhncjYEycIG0XRXZ3gud33FlDRWFYGy5GvSQD6nJwrNxPar_
    rzrpi8_bR6_qcXCpE8>
X-ME-Received: <xmr:Awj4ZebSjFQj9QyfdyyV0tgp6yVvRkbFV-BzSwrihEG5I777JgqsK6kunCL_D3oYSX6r0-X5mgl3D0wIRhyZ3ebjSNmGWTSj-68>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeehhffhteetgfekvdeiueffveevueeftdelhfejieei
    tedvleeftdfgfeeuudekueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:Awj4ZRXcW6rE_HOLItLLrPsISZU5k_ovwhf32LHC60r5qO5rY8WPAg>
    <xmx:Awj4ZUlXd2YHZuzNPXgsZkxDDgfS3bnT7KQ-1YctSEBJgOBetU8uyg>
    <xmx:Awj4ZWdcbh_NrsdpBh40qN_GK3Y0_ALp-sR3gH5J6iLxEacbLbRCcQ>
    <xmx:Awj4ZWFzk3yyxlgGDcToiySF_uYqP5yaxqRc1NLr5qPCcMUrU8Cl4g>
    <xmx:Awj4ZVCtoeR73GRGh61qP6JNcHSc8mIJcBZzbtmqayViqaLTmqg8w_Ccr4o>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 05:23:13 -0400 (EDT)
Date: Mon, 18 Mar 2024 18:23:11 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux1394-devel@lists.sourceforge.net" <linux1394-devel@lists.sourceforge.net>
Subject: Re: [PATCH 1/2] firewire: Kill unnecessary buf check in
 device_attribute.show
Message-ID: <20240318092311.GA678645@workstation.local>
Mail-Followup-To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux1394-devel@lists.sourceforge.net" <linux1394-devel@lists.sourceforge.net>
References: <20240122053942.80648-1-lizhijian@fujitsu.com>
 <20240122085604.GA254251@workstation.local>
 <20240318044609.GA659599@workstation.local>
 <625470f3-b196-43f7-9844-fa1cb6da99f8@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <625470f3-b196-43f7-9844-fa1cb6da99f8@fujitsu.com>

Hi,

On Mon, Mar 18, 2024 at 06:24:52AM +0000, Zhijian Li (Fujitsu) wrote:
> ...
> Sorry for the mistake. I haven't considered callers from other than sysfs.
> I'm fine to reverting both *two*.
> 
> If we are interesting in the sysfs_emit conversion one, i cooked(see the attachment)
> a patch to revert "firewire: Kill unnecessary buf check in device_attribute.show" only.
> 
> (Feel free to ignore it if you have had a local fix.)
> ...
> From 96ad3e15b86e2504f3c17fd6a10be48e5ff81cb1 Mon Sep 17 00:00:00 2001
> From: Li Zhijian <lizhijian@fujitsu.com>
> Date: Mon, 18 Mar 2024 14:05:32 +0800
> Subject: [PATCH] Revert "firewire: Kill unnecessary buf check in
>  device_attribute.show"
> 
> This reverts commit 4a2b06ca33763b363038d333274e212db6ff0de1.
> 
> The previous fix didn't consider callers from other than sysfs. Revert
> it to fix the NULL dereference
> 
>  kernel:  ? sysfs_emit+0xb5/0xc0
>  kernel:  show_immediate+0x13f/0x1d0 [firewire_core]
>  kernel:  init_fw_attribute_group+0x81/0x150 [firewire_core]
>  kernel:  create_units+0x119/0x160 [firewire_core]
>  kernel:  fw_device_init+0x1a9/0x330 [firewire_core]
>  kernel:  fw_device_workfn+0x12/0x20 [firewire_core]
>  kernel:  process_one_work+0x16f/0x350
>  kernel:  worker_thread+0x306/0x440
>  kernel:  ? __pfx_worker_thread+0x10/0x10
>  kernel:  kthread+0xf2/0x120
>  kernel:  ? __pfx_kthread+0x10/0x10
>  kernel:  ret_from_fork+0x47/0x70
>  kernel:  ? __pfx_kthread+0x10/0x10
>  kernel:  ret_from_fork_asm+0x1b/0x30
>  kernel:  </TASK>
>  kernel: ---[ end trace 0000000000000000 ]---
>  kernel: ------------[ cut here ]------------
> 
> Fixes: 4a2b06ca3376 ("firewire: Kill unnecessary buf check in device_attribute.show")
> Reported-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  drivers/firewire/core-device.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)

Thanks for your immediate action. I applied it to for-linus branch, and
will send it in this week with my additional patch for notes. Let's back
to test, hehe.


Thanks

Takashi Sakamoto

