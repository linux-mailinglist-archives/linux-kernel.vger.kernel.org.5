Return-Path: <linux-kernel+bounces-74827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C5585DC69
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8509D1C2351A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A266B79DAE;
	Wed, 21 Feb 2024 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qncFkFv7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AbOLWOz/"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50A455E5E;
	Wed, 21 Feb 2024 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523573; cv=none; b=CU/vx4boDLrG7SowFIgO0KABa2qT9nAH9TFvuxUlmJX0TuITvcBmTHUGsq0YpF6mz54y+1f2Tqv+BTFhO/qOZQHuXquTrJ3T8yqt2fnzzJHG+enf9I+bALi4g6BWlQnZvnfyLuD2//cwC+m6zv+fSNNWQR1sxbcuWSV9UsC3/dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523573; c=relaxed/simple;
	bh=Fv8kuaoza9YOxN8E6T3xT5ybKEYe2If0/PtQZaqhls0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=WNBwpdV0QDotHpSGDvaouyf4WYf/m+C9m5iiHoz/RSTNWBbEcLRCJWgRLLfEa0i5ajzZVZ21Uum9vTiLzyxREPOD3yGVkzET0+WG6q/P43+XjsmAk3pkuT5i5rqKtJ4M4VTz6Gv4KhId61uPWCQKx+ddOfL/wMqQ+/x45m0UEvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qncFkFv7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AbOLWOz/; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id DA7365C006D;
	Wed, 21 Feb 2024 08:52:50 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 21 Feb 2024 08:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708523570;
	 x=1708609970; bh=Fv8kuaoza9YOxN8E6T3xT5ybKEYe2If0/PtQZaqhls0=; b=
	qncFkFv7ETvjKcESrtavSqlH8Tf+3LAaBrjA1uzsklwIASXX/c1esyC31T1IFopl
	qbqZCvKxuDv0tpex9rautEhrSajiNQ1LYzwb425bUZ0uCQ9IkKgAqRcleL7W3Gvb
	J79Y5toy+NfiZ1BPQlzoWpcd8oNA4GiHm7riKMHsPuS8K9BKsEl3Ouw87n3uo3+s
	G/pb6ClCPRbNesxdAuxoooB5QP7VN/MGYATPOsLZgbHwyUzlh6t7cvN1CVB6bOst
	y+TjHH97qwla56bNSgHN9bhUOJQT9WlAin1XXGHlZVCNKjnlUeQFnPMiiT+g4V9J
	JjwNHdDCrlvbq6+oPxGVaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708523570; x=
	1708609970; bh=Fv8kuaoza9YOxN8E6T3xT5ybKEYe2If0/PtQZaqhls0=; b=A
	bOLWOz/VPER9zHZyg+eUyR4mscAN4boRgccGe0TBxUO8HrP5kwyW74UjHP6G248W
	PFDU7DfdQY3tll5lBCN/4+Dnno5f1RfggzA/6l0Hfo8Hf19nOeqW3Z3wbMSMDyVQ
	9OkYF1fti9Z/PzATKtYtZRtjr3ACGbxfxMjI39TB56N7z3G3CGWP2zUNgXHA8JZ5
	dCXFv8B9gNEuu2Hpev42+ldkmX6MmwjbrQJpHc2AyXpoh86Hvga74ihTS9c4kJCA
	rd0SmvDTvoC3gGT6+d0/D9Xc0UhvTv0OY6KRWDMxTAxof5lZOGgxFveWZ16QqhmF
	ZyFhuV7IhcIKF4s/R4f8A==
X-ME-Sender: <xms:MgDWZQfR5BNm678P3PLqS1SqEstXMQrpRw-jpfDzDcyGHFA0AkQn3Q>
    <xme:MgDWZSNmoxj7K5-Yu-LkOzbXlqngLLoxbkGgaZZuvnT3N55kuwIMaaG5-HiGK2qly
    S02pZeogiN-Vyvwb8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:MgDWZRhH-sTKPdtaQ6Mc8ClwL8DfOjzDFRGPdW_1dbbA1gX1yzZylg>
    <xmx:MgDWZV9Bc1kwqifJ_TguKAr6DhGpm0-ECx-Xbxc_4Hkud_NV2GuHHA>
    <xmx:MgDWZcvzpYRsIq_i1a9RxvyriULbMmv5ADZZ4I_6lS28GSWobCybOg>
    <xmx:MgDWZdMnxMV2Zg6pTtR-mMX79CjzwddXh0BwJAdvl5BIzDbErqhk9g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7FD5DB6008D; Wed, 21 Feb 2024 08:52:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d6c4ff9e-756a-4604-993a-cf14cfdbc53c@app.fastmail.com>
In-Reply-To: <cover.1708508896.git.u.kleine-koenig@pengutronix.de>
References: <cover.1708508896.git.u.kleine-koenig@pengutronix.de>
Date: Wed, 21 Feb 2024 14:52:29 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
 "Andrew Donnellan" <ajd@linux.ibm.com>, "Jiri Slaby" <jirislaby@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Michal Simek" <michal.simek@amd.com>,
 "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
 "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Justin Stitt" <justinstitt@google.com>,
 "Frederic Barrat" <fbarrat@linux.ibm.com>,
 "John Stultz" <jstultz@google.com>,
 "Tomas Winkler" <tomas.winkler@intel.com>,
 "Amol Maheshwari" <amahesh@qti.qualcomm.com>, linuxppc-dev@lists.ozlabs.org,
 "Appana Durga Kedareswara rao" <appana.durga.kedareswara.rao@amd.com>,
 linux-arm-kernel@lists.infradead.org, "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH 00/11] misc: Convert to platform remove callback returning void
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024, at 10:53, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> this series converts all drivers below drivers/misc to struct
> platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
> Provide a remove callback that returns no value") for an extended
> explanation and the eventual goal.
>
> All conversations are trivial, because their .remove() callbacks
> returned zero unconditionally.
>
> There are no interdependencies between these patches, so they could be
> picked up individually. But I'd hope that Greg or Arnd picks them up a=
ll
> together.

These all look good to me, whole series

Acked-by: Arnd Bergmann <arnd@arndb.de>

