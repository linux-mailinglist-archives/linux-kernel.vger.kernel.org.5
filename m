Return-Path: <linux-kernel+bounces-119206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA2788C586
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55431F60F6C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DB213C67E;
	Tue, 26 Mar 2024 14:46:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB15A13C3FE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464387; cv=none; b=XmuZNnNK5NTNm28ZKgTtlO/hxJ3n2JHpziEvRd/D0sQlt0TDSu3ybKk1GBen2hsjUwLdgUDgRxv/tNeRObfbEI57vywR+0tkhLHYlNgMhsZy4cyh8tf5hfzfFoyXksJ/miI5/wAQ5HJM0w/jurnAhkyiROkZnidLEz4raTUp0g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464387; c=relaxed/simple;
	bh=A90yMMr5SCVrA2WUZLrQNkNWu0fE12f5QJK/5Fl/ubY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLDk56/Y65YraEwo+pWy0VHTyBXFvUUiI3MXkLbkmjkIOkM4yIYjcS5AeycrU7fclk9euCf6H9REA95vEI95m1lL9amqObLZasncwBK6sdt6K+2Njq0J1s5WvAsCbPkncPZOiFMKZ8p8dKG//6r2ABDgxqbHSVQvNCiPdRn1ebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B883113E;
	Tue, 26 Mar 2024 07:46:57 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 013263F694;
	Tue, 26 Mar 2024 07:46:22 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	Pierre Gondois <pierre.gondois@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] firmware: arm_scmi: Fix wrong fastchannel initialization
Date: Tue, 26 Mar 2024 14:46:09 +0000
Message-ID: <171146431503.2983016.14413306679246522303.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240311090413.1710725-1-pierre.gondois@arm.com>
References: <20240311090413.1710725-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 11 Mar 2024 10:04:12 +0100, Pierre Gondois wrote:
> Fastchannels are initialized with a bad index in:
> commit 2441caa84aac ("firmware: arm_scmi: Populate fast channel rate_limit")
> Fix this and provide a correct index.
>
>
Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: Fix wrong fastchannel initialization
      https://git.kernel.org/sudeep.holla/c/17f243adf165
--
Regards,
Sudeep


