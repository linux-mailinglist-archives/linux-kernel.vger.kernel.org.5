Return-Path: <linux-kernel+bounces-106587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8817987F0AB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBB21F22A34
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552B15733F;
	Mon, 18 Mar 2024 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="S3WiUdBG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jnAYL+N6"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357B45789B;
	Mon, 18 Mar 2024 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710791915; cv=none; b=q1WfY9Ziag0ZVExJp1LZ0YHHP7b/4YEIuVNVSIIO/mdVnop7hwIzxV0tFgsO32worAwTh3jesR9EZwt5F9tXeVHo1pFb2E4vVGFac2qQppa17u9R8u2YFrlg16KKhZDmhjRWMPXl9/D4xR5kOcUZli+LmSyZwUyHRp6bcuyRCIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710791915; c=relaxed/simple;
	bh=pzuE4YP2rRS8OHKAZHUUC1TXYvLCTQj9bof0aUirCXA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=C+ueilsc3BxCySKxOaWb3+nt2wwRIw+vJq/SUhsSRGbTIAvILmgaKj0KbzoJ/i13GFfwJpNQ0xV0UsDhpHNxsk7oQ9kfgS9alueYSNV9nt2Cf5HsuEreFrTYpKjwAiL1m/UbxGkzDG16rHnwkbPO6uLQ66U3m1g97eLxECpIs4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=S3WiUdBG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jnAYL+N6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 237A81140111;
	Mon, 18 Mar 2024 15:58:32 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute2.internal (MEProxy); Mon, 18 Mar 2024 15:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1710791912;
	 x=1710878312; bh=A2axe0Z4A4luBsCO2YW01p36HbVjlyDUfOi4kr5ev4Q=; b=
	S3WiUdBGmQMdEkiwntifAy/gwZjjJC/sJt/WKAgo0hYJfkOvtP11hwjMqHMY+QrG
	AEjGfbhwfdHjEJi98XHpoHj2ILx6spdH3HJf9Tthkn8Dy+5jwGbTwQhIBzqtCmLb
	p8xsitFkhhaI9oQR4oOnea73L0hMcNwq5lFIyL35h12REULcGVZrV9cI3RGoQ9yj
	igVOwcPyPkEr5zVnEogS6EHBA9toHm6+QSqlUsZV594YI3f0HCJ0PfUKUHeIIqrX
	/tLzEK/jQXfOqwOQ6XENoD4kKhenNs/7y4CXCaUjAn+yYXkukyRs5VvM1wMWqDCU
	KxjxDV3uEg+HZI6XIWwV2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710791912; x=
	1710878312; bh=A2axe0Z4A4luBsCO2YW01p36HbVjlyDUfOi4kr5ev4Q=; b=j
	nAYL+N6nrcNjvahTnrbtCchgdVyApvvBLLxGQ7iwVpRsOg+NN6QZb2s8KI6WwcKU
	EPRggNcnWL1zwySjesA9rYH9FdfcczrQ5F0QtwxCjIZcmzgu6BcpfNkr8tKByLeu
	Au80uH4CIz8IyXRgAUen9FKqFyz7JMUw1KX+mCzsaEs6dg926s/Kj4h2piTJnt6O
	7wEyFye7AbqFIyf7JjLZf3xCnmoQi6Q59p57tQyf4M7xnoaXDzZ7J5BR0OaDM1L0
	vOFG8u4G9c90BWuzTc/GRXlTcz+0j6BqqkuYOz0m+C1erTzTiHaYvpOSaVBCb3LO
	JnP+d56RMmNXYyxeQQlNA==
X-ME-Sender: <xms:55z4ZczhdLVfUx2oiiuWqxFjgKiL6U04mDLjKmxACO3sNIBv20gt_g>
    <xme:55z4ZQSIp50GArJbtICRb--0FsiSCeY_91P4KVXVy2DrVxRRiQZmOsonNbEKlGl2N
    6Khn5MooxwI9UgZpz4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfn
    uhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvheqnecuggftrfgrth
    htvghrnhepueekiedtfeethfeuudegiedtveffteefueeiveejieegkeehgfeghfffgfek
    teevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:55z4ZeXZmHeYNnvNdKf6gtZS--7-CUiW3jenO7YWIzWQgasx10dYYg>
    <xmx:55z4Zajw1_n28oi9QnV0lwsNqjxu_miWilCBD_gFXpT-Zo-uKeduMA>
    <xmx:55z4ZeArTCpGhIqTejaatkIykB-n8Pj8crzvWs4iJcY1QDUCQudliQ>
    <xmx:55z4ZbKKQKVkOgf3Vj1xqVyCCel_C1vm1k6dGDLRR_sV9qUbhgRHfA>
    <xmx:6Jz4ZZPU2OKQAe8xY4iFEdmVEMnwWdqMq0C_fucLu3Uy0qdsGm9ndA>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D07532340081; Mon, 18 Mar 2024 15:58:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <90fe07e4-2945-4b78-971c-1012615e2fea@app.fastmail.com>
In-Reply-To: <9ccb144f-3e6e-0ae7-496e-de4cf75171e5@linux.intel.com>
References: <20240310065408.63703-1-luke@ljones.dev>
 <9ccb144f-3e6e-0ae7-496e-de4cf75171e5@linux.intel.com>
Date: Tue, 19 Mar 2024 08:58:10 +1300
From: "Luke Jones" <luke@ljones.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
 "Hans de Goede" <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/1] asus-wmi: add support for 2024 ROG Mini-LED
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 Mar 2024, at 1:09 AM, Ilpo J=C3=A4rvinen wrote:
> On Sun, 10 Mar 2024, Luke D. Jones wrote:
>=20
> > Changelog:
> > - v1
> >   - Add missing value conversion for new mini-led
> >   - Catch and ignore a bogus read return if set to "off"
> >=20
> > Luke D. Jones (1):
> >   platform/x86: asus-wmi: add support for 2024 ROG Mini-LED
>=20
> Hi Luke,
>=20
> I've small troubles in following the patch version in your recent batc=
h=20
> of patches. Could you please list which of these are the versions you=20
> consider the correct / "latest" one:
>=20
> https://patchwork.kernel.org/project/platform-driver-x86/list/?submitt=
er=3D193685
>=20

Yes very sorry about that. The following are latest:

https://patchwork.kernel.org/project/platform-driver-x86/patch/202403100=
55312.11293-2-luke@ljones.dev/

https://patchwork.kernel.org/project/platform-driver-x86/patch/202403100=
55750.13160-2-luke@ljones.dev/

https://patchwork.kernel.org/project/platform-driver-x86/patch/202403100=
61715.16531-1-luke@ljones.dev/

https://patchwork.kernel.org/project/platform-driver-x86/patch/202403100=
65408.63703-2-luke@ljones.dev/

https://patchwork.kernel.org/project/platform-driver-x86/patch/202403102=
33722.30884-1-luke@ljones.dev/


> ?
>=20
> While Hans will be handling the 6.10 cycle, I could review the latest=20
> versions and close the wrong ones so it will be easier for Hans to pic=
k up=20
> the correct ones.
>=20
> --=20
> i.
>=20
>=20

