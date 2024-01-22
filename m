Return-Path: <linux-kernel+bounces-33181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 783B88365CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 753B6B24100
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA653D99D;
	Mon, 22 Jan 2024 14:42:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC19D3D993
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705934526; cv=none; b=kFnYynSajnXl68vkqrsjwMpoLYrzZ23u/sb+vkyPYpYIEw0TKVkSKF6e0bUZHKGd1rVp9/0ERCD2dQAmc7fKjL3dIB2DXSbuxDhAd8OzbwfTbBbmP1WHBen94jNnQMNopnZLYJAEdWy/+/p4fvkI88FiO7ejIJL+j3oKewaH8i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705934526; c=relaxed/simple;
	bh=hIXTq7QEbff12FopLzQxcU510ptU8SmRF3I54P6ykIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEgyBZ/W+kOjzfwc88X21g78uurbnOlbJw+vb4JqlRsD7YPZ5tbjXUkiZN4XLAolNyS5sFFUYqHxP1xyW0hVWXeNJE1988doCBv9kcJe+2GXDnInlrJC0JBqfHQvKh+TPoDaTz/1kcrGcQYO46rMlWX3ZudbfA65iUqxUMgJOug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66BC6FEC;
	Mon, 22 Jan 2024 06:42:50 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9E9133F73F;
	Mon, 22 Jan 2024 06:42:03 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Fix Clock protocol version for v3.2
Date: Mon, 22 Jan 2024 14:41:58 +0000
Message-ID: <170592352320.3508921.4440754105974312725.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109150106.2066739-1-cristian.marussi@arm.com>
References: <20240109150106.2066739-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 09 Jan 2024 15:01:06 +0000, Cristian Marussi wrote:
> Enable SCMI v3.2 Clock protocol features only when Clock protocol version
> equals 0x30000.
>

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: Fix Clock protocol version for v3.2
      https://git.kernel.org/sudeep.holla/c/27600c96e2ff
--
Regards,
Sudeep


