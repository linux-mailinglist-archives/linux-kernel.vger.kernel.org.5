Return-Path: <linux-kernel+bounces-40087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEFD83DA0F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A111F26780
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9A118EB2;
	Fri, 26 Jan 2024 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Bz3idoCR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h5GGOEew"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721E918B1B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706271565; cv=none; b=BqRj7y9Gioxzo7UwgL1+vWuZl2clOqFYItFZiyIT796gUkoubao/UYsts4Ucu4dLLJj1JpoMWS7/P1//vPHggz7/+ryIep2p3pr1UMjOzizBbS4zctPYt9GiJCSQxJcbUeMyVKnit/D06rag8YhkUKuogvaavT9kgIVwP1uJBbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706271565; c=relaxed/simple;
	bh=bQYRCu5f1SIav7s2qBfsJldzhFPPaxmxeMXUGttv6LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8XCeCoIEISucckzF88tEHh2wpL8TeAUlN+haR4zvRI6ut+h7s4Cgq1vhj/cz7Aj4GAAAu63xZaUImgJo5korFpI2JPdmaTOeWREcSKq1kYR/+MTnMEReqFmqOSEYO0Ww1wfrDv30Ssz2l7IedoBVC8PI8CLCxpMD9bNuco9pA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Bz3idoCR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h5GGOEew; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 22A5A5C01A7;
	Fri, 26 Jan 2024 07:19:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 26 Jan 2024 07:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1706271561; x=
	1706357961; bh=1gnexpyBBPN644lYANlOBioOt6k8t58q8rd2KJDGfqk=; b=B
	z3idoCR/T2k2tfwvFx25weT1qdCBUEdR+9XzjPxNdBbrnb3Vm/632i+sNtlbu59J
	w9aYVWKfy9w31LILKwpgdJZsmb0mVXytNatttHVX04kuDvd2rMnd1dd4G4Ao9oIO
	vsDhgrxWCCvJeUa/mRFtqqtn1f92tt6b1Ef0dar9jZHC9aWHTJ3r4V6MELLXg+5b
	0MOEpBIgdbEruevPIJwmkjueLeUzxpEu64V0RG2kIwF3QvHSqNPJ09D6CfELhQeD
	g1YlIWJX7cM6TLW2fXQWzB51m5V7aCeiKVL0mhR6PxmovCt7hw+gVe20QqGvGdBy
	yv3EImodNq6xINdAntshQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706271561; x=1706357961; bh=1gnexpyBBPN644lYANlOBioOt6k8
	t58q8rd2KJDGfqk=; b=h5GGOEewUHdTps9f6l1Q6wiNRA5MckKd13iKvN4CgVOp
	XAuyUZAhzXwPM+jpTIM+tdi5nT7AEkb0mKrkWQpE2g+DGn0MXeAEeStEkIdsi59t
	VJR9jLnpghEvlP/JCjA4lQY1eAy9OdkQJLc8CSlAGk5pExs5xxGVMslVi8X50qpJ
	sXo4NbSA6P1IUqEI9+gJfoT423eBBW5khOiGomoO3T9xwi6RVhA5x1ddWu3zbjoN
	vc/2OKi0pPXoBKrBE/7C56X8kwV4MUXuFjPu0dR/Xz27BH/V2Zrk9V27+hnf3rrs
	vbKaPJyLsvFefZl3J6iFTaMkDShVj67TuB1NV3pz7w==
X-ME-Sender: <xms:SKOzZWkBSluZ4ZhULMDidtnpUkscaFtc9S-3OgmERksDCTmg3aU-Hg>
    <xme:SKOzZd0Lif5yFfL5kxxVlBnp6ucjqUSEX3e9hBDBf-Ph-hay7nOfmDMGiOUBVpiGW
    5jt1kfr6zqLRJyW60s>
X-ME-Received: <xmr:SKOzZUrzHg4adg50DKBkJdlJli6lO9E73AiTP2Pzk1bDd7AQzVz6Fo5dxLpivd_tLowuZ49PYz1CHm7patprkZwaOjrhtM5JMmY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeljedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeuffevveeufedtlefhjeei
    ieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:SaOzZal-3YqD-pN4xsslKPSB0AEHL0BVWZOcATERocRputI6YZfEew>
    <xmx:SaOzZU2IKq6xUSC-T2UBJwulWM1MwX74MYS2lDyw2oova2wYFq1j3g>
    <xmx:SaOzZRvTc0x8Mvv7MSPks2ltA2xg9xdrr-gDNtrUpPh-nAJh0dc52A>
    <xmx:SaOzZR9W_Nj-4vazIZjThAOMZ5zU_qTarV_gRFbpX1WYmRfl_72TfQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jan 2024 07:19:19 -0500 (EST)
Date: Fri, 26 Jan 2024 21:19:17 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Adam Goldman <adamg@pobox.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: mask previous entry's type bits when
 looking for leaf
Message-ID: <20240126121917.GA99160@workstation.local>
Mail-Followup-To: Adam Goldman <adamg@pobox.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <ZbJQ0JdbGixJouvn@iguana.24-8.net>
 <20240126011705.GA22564@workstation.local>
 <ZbNyHg3TTWpjiieI@iguana.24-8.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbNyHg3TTWpjiieI@iguana.24-8.net>

Hi,

On Fri, Jan 26, 2024 at 12:49:35AM -0800, Adam Goldman wrote:
> On Fri, Jan 26, 2024 at 10:17:05AM +0900, Takashi Sakamoto wrote:
> > Would I request you to update the API documentation of fw_csr_string()
> > as well and send the renewed patch as take 2?
> > 
> > 
> > I have a mixed feeling about the change, but I'll finally accept it since
> > we face the exception against documentation.
> > 
> > As you know, in Annex A of document for configuration ROM of AV/C
> > device[1], we can see the legacy layout of configuration ROM (page 22).
> > In the layout, the descriptor leaf entry for vendor name locates after
> > the immediate value entry for vendor ID, then the directory entry for
> > vendor directory locates. However, in the case of Sony DVMC-DA1, the
> > descriptor leaf entry locates after the directory entry. It is an
> > exception.
> 
> Hi Takashi,
> 
> Thank you for your review and feedback.
> 
> After checking the 1394TA Configuration ROM document again, I agree that 
> the leaf entry for vendor name should be after an immediate value entry 
> according to this standard. The DVMC-DA1 does not conform. We should 
> consider its configuration ROM format to be another variation of the 
> legacy format. This variation is not mentioned in Annex A.
> 
> I will update the API documentation of fw_csr_string() and send a 
> revised patch.

I think we can handle the quirk of configuration ROM without changing
the kernel API. Would you test the following patch? (not tested in my
side).

======== 8< --------

From 83bf1e04d308ea89c76c64e3168b9701f9d9191b Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Fri, 26 Jan 2024 20:37:21 +0900
Subject: [PATCH] firewire: search descriptor leaf just after vendor directory
 entry in root directory

It appears that Sony DVMC-DA1 has a quirk that the descriptor leaf entry
locates just after the vendor directory entry in root directory. This is
not equivalent to the legacy layout of configuration ROM described in
Configuration ROM for AV/C Devices 1.0 (1394 Trading Association, Dec 2000,
TA Document 1999027).

This commit changes current implementation to parse configuration ROM for
device attributes so that the descriptor leaf entry can be detected for
the vendor name.

$ config-rom-pretty-printer < Sony-DVMC-DA1.img
               ROM header and bus information block
               -----------------------------------------------------------------
1024  041ee7fb  bus_info_length 4, crc_length 30, crc 59387
1028  31333934  bus_name "1394"
1032  e0644000  irmc 1, cmc 1, isc 1, bmc 0, cyc_clk_acc 100, max_rec 4 (32)
1036  08004603  company_id 080046     |
1040  0014193c  device_id 12886219068  | EUI-64 576537731003586876

               root directory
               -----------------------------------------------------------------
1044  0006b681  directory_length 6, crc 46721
1048  03080046  vendor
1052  0c0083c0  node capabilities: per IEEE 1394
1056  8d00000a  --> eui-64 leaf at 1096
1060  d1000003  --> unit directory at 1072
1064  c3000005  --> vendor directory at 1084
1068  8100000a  --> descriptor leaf at 1108

               unit directory at 1072
               -----------------------------------------------------------------
1072  0002cdbf  directory_length 2, crc 52671
1076  1200a02d  specifier id
1080  13010000  version

               vendor directory at 1084
               -----------------------------------------------------------------
1084  00020cfe  directory_length 2, crc 3326
1088  17fa0000  model
1092  81000008  --> descriptor leaf at 1124

               eui-64 leaf at 1096
               -----------------------------------------------------------------
1096  0002c66e  leaf_length 2, crc 50798
1100  08004603  company_id 080046     |
1104  0014193c  device_id 12886219068  | EUI-64 576537731003586876

               descriptor leaf at 1108
               -----------------------------------------------------------------
1108  00039e26  leaf_length 3, crc 40486
1112  00000000  textual descriptor
1116  00000000  minimal ASCII
1120  536f6e79  "Sony"

               descriptor leaf at 1124
               -----------------------------------------------------------------
1124  0005001d  leaf_length 5, crc 29
1128  00000000  textual descriptor
1132  00000000  minimal ASCII
1136  44564d43  "DVMC"
1140  2d444131  "-DA1"
1144  00000000

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-device.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 0547253d16fe..30a734ee9de9 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -368,8 +368,16 @@ static ssize_t show_text_leaf(struct device *dev,
 	for (i = 0; i < ARRAY_SIZE(directories) && !!directories[i]; ++i) {
 		int result = fw_csr_string(directories[i], attr->key, buf, bufsize);
 		// Detected.
-		if (result >= 0)
+		if (result >= 0) {
 			ret = result;
+		} else if (i == 0 && attr->key == CSR_VENDOR) {
+			// Sony DVMC-DA1 has configuration ROM such that the descriptor leaf entry
+			// in the root directory follows to the directory entry for vendor ID
+			// instead of the immediate value for vendor ID.
+			result = fw_csr_string(directories[i], CSR_DIRECTORY | attr->key, buf, bufsize);
+			if (result >= 0)
+				ret = result;
+		}
 	}
 
 	if (ret >= 0) {
-- 
2.40.1

======== 8< --------


Regards

Takashi Sakamoto

