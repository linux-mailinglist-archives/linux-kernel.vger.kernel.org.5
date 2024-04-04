Return-Path: <linux-kernel+bounces-131572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BC189899F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B971F2B6F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CA81292FB;
	Thu,  4 Apr 2024 14:10:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7D7129E6E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239818; cv=none; b=jJajBwNX4Xy1PX19NErRSKjueIrwxXTJJqCXPc+xmUblcsmySYVno8d8IGBAa7pVxa10XV1s275P0G6WYV1ck6Pb3f6QJfvE91z4Tw4RtHp6Vp8ZIMfBlVmxlG/+C3556AtGasi9uJsFnCREa/oORj53T3FVAnVTPQ6hpcofDWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239818; c=relaxed/simple;
	bh=wVLB1krQLHRu+YiNi21HhMdn2rnox3JVbTq0Qx5Rp0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2yeFQeUPFpchUmsE6vGB+vN3Cn5I4Kwa815oSt2mV/JrlMc9eDGORfaW6iZ2jcj3i3GdklXsuihw/x1ppCbl4A2soV/EAQkSlWJRIwjl27am4H0Pfnuva0dlk8FlSfn9Hmr3gECE4B1DMP1GfmajKuntZmxwVA9AFzcoych0Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B0126FEC;
	Thu,  4 Apr 2024 07:10:46 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 331723F64C;
	Thu,  4 Apr 2024 07:10:15 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 0/5] SCMI misc small-updates
Date: Thu,  4 Apr 2024 15:10:06 +0100
Message-ID: <171223976883.451467.5338059341557064927.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240325204620.1437237-1-cristian.marussi@arm.com>
References: <20240325204620.1437237-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 25 Mar 2024 20:46:15 +0000, Cristian Marussi wrote:
> a bunch of small SCMI updates based on v6.9-rc1.
> Mainly adding traces for weird SCMI messages like late timed-out replies,
> out of order unexpected messages and malformed messages due to spurious
> mbox IRQs.
>
> Thanks,
> Cristian
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/5] include: trace: Widen the tag buffer in trace_scmi_dump_msg
      https://git.kernel.org/sudeep.holla/c/da251ce21061
[2/5] firmware: arm_scmi: Add helper to trace bad messages
      https://git.kernel.org/sudeep.holla/c/5dc0e0b1f0ea
[3/5] firmware: arm_scmi: Add message dump traces for bad and unexpected replies
      https://git.kernel.org/sudeep.holla/c/5076ab66db16
[4/5] firmware: arm_scmi: Simplify scmi_devm_notifier_unregister
      https://git.kernel.org/sudeep.holla/c/264a2c520628
[5/5] firmware: arm_scmi: Use dev_err_probe to bail out
      https://git.kernel.org/sudeep.holla/c/3a7d93d1f71b
--
Regards,
Sudeep


