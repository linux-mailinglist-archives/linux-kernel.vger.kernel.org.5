Return-Path: <linux-kernel+bounces-151033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352768AA82E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91761F21CD3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D778CC8DE;
	Fri, 19 Apr 2024 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hsXXsDAH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jO32ZMpu"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0E4BA41
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713506569; cv=none; b=WLQM/l7sN1kiIt02q7htGB5jGEIfDDIVJ0anZyka8uUOMHgDu5xJrmZg5EXKbbz8NNToBOVPHp1AR6fhfXPye+vPNA3W/oZxfN/ENwa8rYJtLDuKQBcB4rQJHm0FsgFBTCUx3nc0UI7PASg8RQmobCG3+/LhITmWTyNMoZAlzWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713506569; c=relaxed/simple;
	bh=tcjzjhwS3K9FGNJZQHWhowFCXN/wfaOp1piIIKJ34n8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=J4D2jNOup554Uoym8cBTetcAKqIFB1CRUIqfs3l0hhSP9RCu/I7ZCh/m3/RRZE31OK5Z0Y+pa4nszxg1tRC02Iep/iI2Ihhv3ECNBHxP/3D38VP0J2kI8L+JCWXDoXeHwYR+8e0OEstKZIamvc/XJblNTFedTCcAo/MBsqJS4go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hsXXsDAH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jO32ZMpu; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id BF3CD1C000B8;
	Fri, 19 Apr 2024 02:02:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 19 Apr 2024 02:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713506565; x=1713592965; bh=A4M69jORvF
	CHqEouhHsHZnQ4o5IRiYtV1dtNmi8CWUY=; b=hsXXsDAHFJt0xpuVclnzQ+etJt
	+TAn5t4HUvCOFUtl0mIiCnW0F7cv3pwhi/9ahez+kgvMM+/1w2II4p+UxYyn1GPA
	BzJtUnA7/P+kVX67CVRuafpqoMclrozQUxJY2rXiAi3QtkJgImf0j5UMGRecLMSJ
	qITfG46yM613DRqkSn7YYooyXImtYkboj0ACrj2vHDd21tljUmMlTtifgdP9lJ1s
	hVGX0TBOjxDWhzYGyfJ2DqWyOE/k4rPbPVxfrv/vzKzq/dIEbl3WhLV4khYRPwYM
	O2c/RVIa+DK0MAj/4BNN07PAw3paTID4fCFlhvQM1m4OxxxzVjCffdIxCAjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713506565; x=1713592965; bh=A4M69jORvFCHqEouhHsHZnQ4o5IR
	iYtV1dtNmi8CWUY=; b=jO32ZMpu82TAl1uSUGyscvkcR+NJTl75CR+ka88a0CAF
	IR2ynM9HcbdrhjxC32Wj/6TQm96+rHM2ByvpBpTalLFQ1kYEVzYZ0enZqliTSLpa
	/us+JaNG8cVZxh2vEN/hPyejjBVU0l/RIGH2Di7kl2H4hhFabmYuHlsvNQrLUjgB
	hHOrK70HAGDU9csXAYEsr6i5WXGL7wQM+pd2bAmow8xj5Qx7KFhWviKhWd3bek1R
	UL9gWiOUcWbCG3kara/Gp8YY9TPQqCx83Xq/eqt0PbT4WPAq9yebmJbk/+O1r8iK
	eEG1tfBsto4+UpfviHY2E2d/zfa6XbKV5GAPJsbwIA==
X-ME-Sender: <xms:BAkiZlSKgku2N6AHb1qqYiLKUFCdTTC5GBVlXOo5NTf1DEbmuYxtRQ>
    <xme:BAkiZux5QhSUd9Qm5PHtwAi_BZPSikqX0zIoFYDRDRhHhO3q98YzrD49WnC6htrJ0
    -VfaBpUOgfHjEZWea0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekuddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:BAkiZq1JyF5-ESwrTXFzFYGpbVuyjFc0omO39LCf1ZtdyXGpfcWOgw>
    <xmx:BAkiZtA42IOVjsV76NrtTdaeETD76avy_hl5xo_rWUJYTmyaiPPmFw>
    <xmx:BAkiZujUHmL3BxSGjO35SJE59HrTQQaT5gFn669qQ6ekGyp8D-QXFA>
    <xmx:BAkiZhqzL3F7GxXuvLENG1GyX1rTbjAcc2PPYbd0eQgxeyJWQMGjCA>
    <xmx:BQkiZjZxBDEfduSzoxV9VXKf0XCrMBVEJ8Z8nKjwZpYX1MtEtZOMYI6K>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D4620B6008D; Fri, 19 Apr 2024 02:02:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4d63cbaa-63d9-49fa-bbf0-b3bc62ebfb36@app.fastmail.com>
In-Reply-To: <20240419060013.14909-1-r-gunasekaran@ti.com>
References: <20240419060013.14909-1-r-gunasekaran@ti.com>
Date: Fri, 19 Apr 2024 08:02:24 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ravi Gunasekaran" <r-gunasekaran@ti.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Nishanth Menon" <nm@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Tero Kristo" <kristo@kernel.org>
Cc: "Bjorn Andersson" <quic_bjorande@quicinc.com>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 srk@ti.com
Subject: Re: [PATCH] arm64: defconfig: Enable HSR driver
Content-Type: text/plain

On Fri, Apr 19, 2024, at 08:00, Ravi Gunasekaran wrote:
> HSR is a redundancy protocol that can be realized with any
> two port ethernet controller.
>
> Many of TI's K3 SoCs support multi port ethernet controller.
> So enable HSR driver inorder to support this protocol on
> such SoCs.
>
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

The normal way this gets picked up into mainline is that you
send it to the K3 platform maintainers (added to Cc) and they
send me a pull request or forward the patch to soc@kernel.org.

    Arnd

