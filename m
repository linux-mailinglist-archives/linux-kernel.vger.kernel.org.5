Return-Path: <linux-kernel+bounces-105547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAAC87DFF6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601B91C20D0B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D84200A0;
	Sun, 17 Mar 2024 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="C/uVcQgP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hV0P8wI+"
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310761EB2D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710706860; cv=none; b=E+IA4TR477/7BAD7wpt2tmnyk4rhIP7aInJPVl4YOlk6peiLt5cVVXZiUFmCeDnHrayiuu7HB6Nblf6c0DVBe8pkEKW7fFpXbtHcz+6We3I+wsG4lfznCdWGkX3Z2hnhg5HrhoYDUNvgn+a4KM1K/G1rFq5Fy/BUxn4le3+ZrJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710706860; c=relaxed/simple;
	bh=/1v7Vj6mpZndRJ2eX6+FUyOOJ7RtQ+j9vPkLALQZgAM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=j49fovNFbcBSX9QC7OoxENQ2EXr//mXcWfhEpFtWkFPQpDMkmrr/COvOrbTCnn/WkZEqOJGc2rZKb4Oqpk7bdgdFgDuPHzBetsdrF3gQmbNLdU68Daygupnp2xYhL4GtxwYvI5Q08WYJyx6P3A2VnLbQf2FVeDpdn6RbPp5MWVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=C/uVcQgP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hV0P8wI+; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 9B93F1C000BF;
	Sun, 17 Mar 2024 16:20:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sun, 17 Mar 2024 16:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1710706856;
	 x=1710793256; bh=6HrRUHpYXtmNtwn+NXIkI2LhSUVC7t5pMaTnPTvJqzA=; b=
	C/uVcQgPeNZzFNajaT9i48G1eVpZV83W8eXFp4qaMkEN0pU+66bys2zs3JAtoPDa
	ulKWcUxR4UD2LkXXeeSgoCqeJng2Mf1hqh3uKDDh0uwDjJHsP7WO3FFpF4hNOGaj
	/cpcjVahuc63MWtMeqdJCzNLvb9STt7tzly29kE2H8ePu0VWyhZlg3Ef5ziv37aS
	EbVNiPfxjl3Xk7cKCRkaE8Fhxs2x0OQ9yfhsL97D1NzN47nzhsphok5vA62mTDk3
	KSh+JjYUN+BTlCjNjXLx0b7UmmvfUINbSg2uAGq2Rgt2Q4IhSL67elkrUlPnBT6F
	BXSezF6ymmuxtAsMJuCHOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710706856; x=
	1710793256; bh=6HrRUHpYXtmNtwn+NXIkI2LhSUVC7t5pMaTnPTvJqzA=; b=h
	V0P8wI+qYNmmHPjirwWAC/ncxDmy1f6OGNfjSfg/8K/JPM2qOI2ru/t/pPcglaGc
	lOiWamZTrKoOsliVFgoTMmvx5jRpIf3NclgRy/P5K7ODamjaUqkP2ikv6NCUMuVl
	SAw31wIY1ojr9XTkcdJAgDiyhWKojeAIupdTZmz0ekSORKBZddHn2vrrFswlumfB
	i3cxcod71/VW+oJrGdE8MigzdyiBG+rEKFKsuBpkHS4/AsEoqGKJ6vpIa3Rb4Clt
	TrYaKx35+BdZH9TXs9/McfT2IufFWlZe0U/7uU8wEKowVLMjrF5ZkZaq6jcFF0hw
	sVkVtS7oh6fKVNfLEENjw==
X-ME-Sender: <xms:p1D3ZUmGH881RIK0Ub0P1mq0znlj8UQCIInElo1rReMFVwxMcj-uxQ>
    <xme:p1D3ZT3fU-TPUvpWVMRa99PAZpo0GcRHy9YL8CltdMSYebAvy1Z1wJ9zilwFKLyFs
    YbKS_onqiprHegiZgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeehgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:p1D3ZSoz4zum-TXcoZnOs1rVdgFC7H7aIQwrCDXaID4q-PXFHcCaGA>
    <xmx:p1D3ZQnxT3ujtJu_25NPrt7q5HPD8x2lGuijhoNQRnjTVQAGkXucmA>
    <xmx:p1D3ZS17J5I1r7Z-vOLTWiG06ErZolGZMbiGSxCezXU92pg8HCdSrQ>
    <xmx:p1D3ZXt83MdvDQCwwf0pcTFjupfpgBsA2zNwgk_J6AqwOnSJVWBR2w>
    <xmx:qFD3ZQxmV6TGwpvtkusWi-ZbGV7mJ0Ehha0p1AQHolqBACnnR3u41UX-myw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C1B81B6008D; Sun, 17 Mar 2024 16:20:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5716d138-ace0-4621-ab34-118610255207@app.fastmail.com>
In-Reply-To: <6c772d15-d249-4175-93f4-ca523006129b@gmail.com>
References: <6dc14151-e71e-4118-826d-3ca5c8ee907f@gmail.com>
 <fba3951f-00b7-41af-8ef4-1e7c86e0cb48@moroto.mountain>
 <6c772d15-d249-4175-93f4-ca523006129b@gmail.com>
Date: Sun, 17 Mar 2024 21:20:34 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Philipp Hortmann" <philipp.g.hortmann@gmail.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>, "Lee Jones" <lee@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Larry Finger" <Larry.Finger@lwfinger.net>,
 "Johannes Berg" <johannes@sipsolutions.net>, "Kalle Valo" <kvalo@kernel.org>
Subject: Re: [RFC] staging: wlan-ng: Driver broken since kernel 5.15
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024, at 21:07, Philipp Hortmann wrote:
> On 3/11/24 08:04, Dan Carpenter wrote:
>> On Sat, Mar 09, 2024 at 11:09:24PM +0100, Philipp Hortmann wrote:
> You are right with the statement that it is this commit.
> commit ea82ff749587807fa48e3277c977ff3cec266f25 (HEAD)
> Author: Lee Jones <lee.jones@linaro.org>
> Date:   Wed Apr 14 19:10:39 2021 +0100
>
>      staging: wlan-ng: cfg80211: Move large struct onto the heap
>
>      Fixes the following W=3D1 kernel build warning(s):
>
>       drivers/staging/wlan-ng/cfg80211.c: In function =E2=80=98prism2_=
scan=E2=80=99:
>       drivers/staging/wlan-ng/cfg80211.c:388:1: warning: the frame siz=
e=20
> of 1296 bytes is larger than 1024 bytes [-Wframe-larger-than=3D]
>
> But It is not depending on the line you pointed to.

Right, the kzalloc() already clears the data, so the memset
is not needed.

> I need another week to look into this.

I'm fairly sure this fixes the bug, the problem here was that
the cast to (u8 *) hides the incorrect conversion:

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-n=
g/cfg80211.c
index 471bb310176f..9d6a2dd35ba9 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -350,7 +350,7 @@ static int prism2_scan(struct wiphy *wiphy,
 		msg2->msgcode =3D DIDMSG_DOT11REQ_SCAN_RESULTS;
 		msg2->bssindex.data =3D i;
=20
-		result =3D p80211req_dorequest(wlandev, (u8 *)&msg2);
+		result =3D p80211req_dorequest(wlandev, (u8 *)msg2);
 		if ((result !=3D 0) ||
 		    (msg2->resultcode.data !=3D P80211ENUM_resultcode_success)) {
 			break;

     Arnd

