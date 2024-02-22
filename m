Return-Path: <linux-kernel+bounces-76032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0966785F230
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0975A1C22F30
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F20C179B0;
	Thu, 22 Feb 2024 07:54:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA45C179AA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588476; cv=none; b=g3udGpawrQLcU+3xGlKcRhweGJLU3kfZ2S4xsDJXpZDgiipPkNS5gm+PQfR1BheRMRo8lOJjrVeAAo/YzsjPFByNV8EomSXA32Wgveh+0tloNnSF+4kDQMKSQ76DatMbaTPV2zNLM1UVwylbfAuTl8n3g6maA8WLCcYTmpttVzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588476; c=relaxed/simple;
	bh=Sz/VJNKLM3xWaRfZ346t8Q+I3e0N0tL+uXnohDmAUyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxEtfEml47wWD+RXo0BTLTLbINI8VGvrTNfbVNORIwutlBX/QHOz/wL+Tk+aLeQvwgObKZJHPR7BreHvunA54qTg9f0T2MjHIV94e8166nxI2Yoku6pYzvZ04GnRsFxg+nqE5jXfgaD/Al/vV9vsJYO8c29Pzbwo89uWyKy43vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 268E91007;
	Wed, 21 Feb 2024 23:55:11 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 267D43F762;
	Wed, 21 Feb 2024 23:54:32 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Rework Clock domains info lookups
Date: Thu, 22 Feb 2024 07:54:24 +0000
Message-ID: <170858826800.106333.5043612997177254784.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240110120916.2482603-1-cristian.marussi@arm.com>
References: <20240110120916.2482603-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 10 Jan 2024 12:09:16 +0000, Cristian Marussi wrote:
> Accessing Clock domains descriptors by the index from the SCMI drivers
> can potentially lead to out-of-bound violations if the SCMI drivers
> misbehaves.
>
> Use a common helper to check the consistency of such accesses.
>
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/1] firmware: arm_scmi: Rework Clock domains info lookups
      https://git.kernel.org/sudeep.holla/c/dea893a66cd5
--
Regards,
Sudeep


