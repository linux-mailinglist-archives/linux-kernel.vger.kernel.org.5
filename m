Return-Path: <linux-kernel+bounces-33180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9983D8365AD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393B81F22A21
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17883D56A;
	Mon, 22 Jan 2024 14:42:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A381A3CF6D;
	Mon, 22 Jan 2024 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934520; cv=none; b=jCAQQYirVF0LfsAgQP8x13Rcv6yQEIECdIUPOymZ14wKdAddLK2I/6NjML8aemwcW0dGeLdCnwMrekVCTqREa7NGPLi/5awI/O/mgchq1AhN3IiGwIOKmSjjGe8PaIUJVYfEp00nEo+sAlUmQukjv80ON3TXYmGEeYmEVQ/E5Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934520; c=relaxed/simple;
	bh=JvnshlR0gFiI2tKo5823WoQz/LUZa7lQ4DVNorByMPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZEEcj8ecGTtYOesZJnAhX1530pgOLSPp+9qujq47P3bFchhlpmVaT9wD1oLajMycg4izLQHPAU4PTbcDeNxuWzzoFWxx+n8wE3y92HeDagaRJ7bYCiWKBGVPdpUXda3Mu2Qcn5dj2747jihstKoJKEJL6RYvLoHah6uxhq/SSKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 186E31FB;
	Mon, 22 Jan 2024 06:42:44 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F21053F73F;
	Mon, 22 Jan 2024 06:41:56 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	vincent.guittot@linaro.org,
	Xinglong Yang <xinglong.yang@cixtech.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Check Mailbox/SMT channel for consistency
Date: Mon, 22 Jan 2024 14:41:50 +0000
Message-ID: <170592361006.3509502.11519593066787083768.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231220172112.763539-1-cristian.marussi@arm.com>
References: <20231220172112.763539-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 20 Dec 2023 17:21:12 +0000, Cristian Marussi wrote:
> On reception of a completion interrupt the SMT memory area is accessed to
> retrieve the message header at first and then, if the message sequence
> number identifies a transaction which is still pending, the related
> payload is fetched too.
>
> When an SCMI command times out the channel ownership remains with the
> platform until eventually a late reply is received and, as a consequence,
> any further transmission attempt remains pending, waiting for the channel
> to be relinquished by the platform.
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: Check Mailbox/SMT channel for consistency
      https://git.kernel.org/sudeep.holla/c/437a310b2224
--
Regards,
Sudeep


