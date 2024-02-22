Return-Path: <linux-kernel+bounces-76189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4D485F403
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3641F2531F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1736D381A0;
	Thu, 22 Feb 2024 09:09:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5164381A1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592975; cv=none; b=nYFRj8qSSXCYjUNzM617JZTA4G5d1d84WwT7bdvkWIx1hSp2jYYRNvFvRZpSMPjGD7TRvETJ+ozEsy18DIf23ujdw4QlLT+bt3gVwkfhfKoBrQGg5YXFezRl1Hxh1ZSVc6f2YznJnC5P45eLQYfyMOiiUb0LJtsjjQ+n9B4rsTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592975; c=relaxed/simple;
	bh=CAEOYelvFs2ksjQ0owb/6iGR2EU0bVR2zjuF4dK3bUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o0l3zVQZJjNWOidk88vgdXYqPDuHETdYqM2kfOCzkkfxywl5NzaAnf1ayUgeW3H9eiedCYpvM0QCXBO3rEJXxeUeDWLmZJERTupErCtyQoshZEPpW4bUxdrJK14EjiRXDiFn6s/rjurgIPStJm9s2IJvU7uoky/E22f3wea2aBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 544561007;
	Thu, 22 Feb 2024 01:10:11 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A6D8C3F766;
	Thu, 22 Feb 2024 01:09:31 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	souvik.chakravarty@arm.com
Subject: Re: [PATCH 00/11] Add SCMI core checks for notification support.
Date: Thu, 22 Feb 2024 09:09:23 +0000
Message-ID: <170859289755.107527.12693501284171395498.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240212123233.1230090-1-cristian.marussi@arm.com>
References: <20240212123233.1230090-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 12 Feb 2024 12:32:22 +0000, Cristian Marussi wrote:
> this small series adds a new logic into the SCMI core to implicitly check
> for notification support when some SCMI driver attempts to register for
> notifications.
> 
> Till now, trying to register a notifier for an unsuppported notification
> returned an error and this behaviour generated unneeded message exchanges:
> the only way to avoid this was to lookup in advance the specific protocol
> and resources available in order to avoid registering at all any notifier
> where not supported.
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[01/11] firmware: arm_scmi: Check for notification support
        https://git.kernel.org/sudeep.holla/c/8733e86a80f5
[02/11] firmware: arm_scmi: Add a common helper to check if a message is supported
        https://git.kernel.org/sudeep.holla/c/637b6d6cae9c
[03/11] firmware: arm_scmi: Implement Perf .is_notify_supported callback
        https://git.kernel.org/sudeep.holla/c/120d26312abc
[04/11] firmware: arm_scmi: Implement Power .is_notify_supported callback
        https://git.kernel.org/sudeep.holla/c/b7e400bc2e2d
[05/11] firmware: arm_scmi: Implement SysPower .is_notify_supported callback
        https://git.kernel.org/sudeep.holla/c/9f5ddbc22225
[06/11] firmware: arm_scmi: Implement Clock .is_notify_supported callback
        https://git.kernel.org/sudeep.holla/c/cf1bba2775ec
[07/11] firmware: arm_scmi: Implement Sensor .is_notify_supported callback
        https://git.kernel.org/sudeep.holla/c/7ac7932df247
[08/11] firmware: arm_scmi: Implement Reset .is_notify_supported callback
        https://git.kernel.org/sudeep.holla/c/12d6a03f3224
[09/11] firmware: arm_scmi: Implement Powercap .is_notify_supported callback
        https://git.kernel.org/sudeep.holla/c/e85beaf76080
[10/11] firmware: arm_scmi: Use opps_by_lvl to store opps
        https://git.kernel.org/sudeep.holla/c/23443a3c7c0c
[11/11] firmware: arm_scmi: Report frequencies in Perf notifications
        https://git.kernel.org/sudeep.holla/c/22ffc748a647
--
Regards,
Sudeep


