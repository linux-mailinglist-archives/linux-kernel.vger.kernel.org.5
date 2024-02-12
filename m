Return-Path: <linux-kernel+bounces-61417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9D585121D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BFDE283059
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D9738FAA;
	Mon, 12 Feb 2024 11:23:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7714D2BAE7;
	Mon, 12 Feb 2024 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737026; cv=none; b=Zfuoz1u4KnK1TroNILZ2GujO3Zw64S0/vHukvonu0YTXDKHabM05sWR8pkxakDP6SxIwVWylhNA9tGWjlE1m1dYmfTHerhlzvQQRLxpnOnTcbu6v/NuL4/evIA0I7IvNAw3obmwIDqDMy1LVFP7i/uxQK9Ehp8d7M5VYXFZau50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737026; c=relaxed/simple;
	bh=zkUeIEL6zo2OmswhX9jyQx6HUKco05JwjtkyOqoAXpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQ48+4fZWXq7JSWG+QaHF+pn6q9ipib19YT533EGJUR0abBf8qnJIII6oHPRZn6HdtIXARVbA90AVnMwjEVu8pLiIBW7jx1ix/66gexi3Py++KmImeVT4VqLe18lcnMaYJoiFcJXrP8124oMKe5HLX3rxHVLvXfIDCh1JBy/DX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62AABFEC;
	Mon, 12 Feb 2024 03:24:25 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 823EB3F762;
	Mon, 12 Feb 2024 03:23:42 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	Mao Jinlong <quic_jinlmao@quicinc.com>,
	Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: etm4x: Set skip_power_up in etm4_init_arch_data function
Date: Mon, 12 Feb 2024 11:23:35 +0000
Message-Id: <170773625002.2157180.12446966066185707431.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131105423.9519-1-quic_jinlmao@quicinc.com>
References: <20240131105423.9519-1-quic_jinlmao@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 31 Jan 2024 02:54:19 -0800, Mao Jinlong wrote:
> skip_power_up is used in etm4_init_arch_data when set lpoverride. So
> need to set the value of it before calling using it.
> 
> 

Applied, thanks!

[1/1] coresight: etm4x: Set skip_power_up in etm4_init_arch_data function
      https://git.kernel.org/coresight/c/1bbe0a247e5d

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

