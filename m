Return-Path: <linux-kernel+bounces-76233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8856085F491
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4E71C227E0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5747374E6;
	Thu, 22 Feb 2024 09:37:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8B2BD1C
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594636; cv=none; b=X+99+5khq+8ItRxlArjxFxths/zgAxEhuiro0dCqsqInzqYeAmnwh/Qaf6jiq1ELY+ENqB1e/bHxs7mhspaZ5Ljd09ns5T/rYyW01cBWWGwc5h9Aq2A9BmFtM74f+CvnkTOm/ES1zDkF1AfFcZ3+eIQQFjQ6NqlsxkMGpv/LEe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594636; c=relaxed/simple;
	bh=HNzOg6wqN3m2tjjs1yOSGdRTUFU1thHUxi7KwSXfOqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nou0y0SqsDvIG965AYc4Mq6RgIFvXiAPqKVt1FxK9NbT46v1WXpGrzVc2ufSqPUumWroaV/fwIEjNpZ0AgeLduIkVHpDj5EPO0r5Ogw45jSNCFAuTMxvQuGb0LCqpc/bVGdiLJH7dE5s0VYOYYbBVxgBfnkfKKrvGkWbCx7UGus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F36C21007;
	Thu, 22 Feb 2024 01:37:51 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 138083F766;
	Thu, 22 Feb 2024 01:37:11 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	souvik.chakravarty@arm.com
Subject: Re: (subset) [PATCH 0/7] SCMI V3.2 Misc updates
Date: Thu, 22 Feb 2024 09:37:07 +0000
Message-ID: <170859450806.109018.322936287404084370.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240214183006.3403207-1-cristian.marussi@arm.com>
References: <20240214183006.3403207-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 14 Feb 2024 18:29:59 +0000, Cristian Marussi wrote:
> another round of updates related to the last v3.2 SCMI spec, mostly around
> Clock protocol.
>
> Note that the series is based on sudeep/for-next/scmi/updates on top of
>
>   7dd3d11f4dac ("clk: scmi: Add support for forbidden clock state controls")
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/7] firmware: arm_scmi: Add a common helper to check if a message is supported
      https://git.kernel.org/sudeep.holla/c/637b6d6cae9c
[2/7] firmware: arm_scmi: Add support for v3.2 NEGOTIATE_PROTOCOL_VERSION
      https://git.kernel.org/sudeep.holla/c/8c80c42ad401
[3/7] firmware: arm_scmi: Add Clock check for extended config support
      https://git.kernel.org/sudeep.holla/c/e4ad2b0130ef
[4/7] firmware: arm_scmi: Add standard Clock OEM definitions
      https://git.kernel.org/sudeep.holla/c/62092c428fb5
[5/7] firmware: arm_scmi: Update supported Clock protocol version
      https://git.kernel.org/sudeep.holla/c/5e0d2fe70cb8

--
Regards,
Sudeep


