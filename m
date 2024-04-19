Return-Path: <linux-kernel+bounces-151585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCE48AB0BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1151F235E9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8154F214;
	Fri, 19 Apr 2024 14:28:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4C61292DC
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713536895; cv=none; b=cmpw35a664EWNrtcYjd0zNonTdlReoRYJPK9Vpqs32sIgzQklYzj9q8EQ0uGvRw8Y+4l5jHdpTgufzczJYsC/zrNiRtWz8poI0VcqNiOe6t3WxUiXM6yY5LqJzIVOujIoKoL0YRneUS4PdgLKadWAmzC8KcmtcWN8jmnfzf5lCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713536895; c=relaxed/simple;
	bh=+cD+Ajo1an/ruAiDGbLFFBmZQcihctHdRVOp5OgCLBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+XhCt4HphHVdoGTRxGbsi6/fgWLePs0gXJRTK8Yg21oMqWGV8i5K2QfFbbqXRqSO2rxyG/bqoMn6wZoBux7gSrRB3BcYYjglb/4UoUj8S4pX7yQdvwlPTOUx9p78nOgA/rHK/iUusSPqLZij6uzqatPvAaUHVqUGJ+X0yAKGbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FBF3339;
	Fri, 19 Apr 2024 07:28:41 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 625A83F64C;
	Fri, 19 Apr 2024 07:28:11 -0700 (PDT)
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
	konrad.dybcio@linaro.org,
	souvik.chakravarty@arm.com
Subject: Re: (subset) [PATCH v3 0/2] SCMI multiple vendor protocol support
Date: Fri, 19 Apr 2024 15:28:08 +0100
Message-ID: <171353681224.3806784.654901600413179714.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240418095121.3238820-1-cristian.marussi@arm.com>
References: <20240418095121.3238820-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 18 Apr 2024 10:51:19 +0100, Cristian Marussi wrote:
> this is meant to address the possibility of having multiple vendors
> implementing distinct SCMI vendor protocols with possibly the same
> overlapping protocol number without the need of crafting the Kconfig
> at compile time to include only wanted protos
>
> Basic idea is simple:
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/2] firmware: arm_scmi: Add support for multiple vendors custom protocols
      https://git.kernel.org/sudeep.holla/c/fc110108b983
--
Regards,
Sudeep


