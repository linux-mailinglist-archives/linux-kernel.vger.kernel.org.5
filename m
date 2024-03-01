Return-Path: <linux-kernel+bounces-89164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C64D886EB68
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A14E28428D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E83658AC8;
	Fri,  1 Mar 2024 21:50:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8DC58AA6;
	Fri,  1 Mar 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329829; cv=none; b=ON7+vzN5I+O4AkavdwVm531tII6cxdJXz1Lv2iwqd1lYjVhzwxkKaOgbxeZ65d/x/UV91cPCBopj9v3JdPQi0f/B6qN7Qk/S5f3cdhCxSYc2Ylt0HFhs6+LzxlA9Kmh11WUaZUFGGJZTVaQtz8om/Qnm0LtyQ4Kx0yUwkXGjJSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329829; c=relaxed/simple;
	bh=HDD0YdAntBqh6zTcDVRYRSlUPcXbImGl1KPnu2ZtboU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RBVTdoCzq7racLbUuN91pSNHtlujGCe/m2m2bwdVz34jlHikkpfZB89+IeeqtWANXcf1fTPt10do9B+TxkKdCOa5oj05lot4WHEw+7KaBjY+dij5h3xBJBE+OPXQR0Ea2qqstAaDeoZJ+C5UY6uSuuZQPRi/Z2QNtKpNfmwcWCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C008C433C7;
	Fri,  1 Mar 2024 21:50:29 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 988FF10633B9; Fri,  1 Mar 2024 22:50:26 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240301-class_cleanup-power-v1-1-97e0b7bf9c94@marliere.net>
References: <20240301-class_cleanup-power-v1-1-97e0b7bf9c94@marliere.net>
Subject: Re: [PATCH] power: supply: core: make power_supply_class constant
Message-Id: <170932982660.281458.3124950180863553573.b4-ty@collabora.com>
Date: Fri, 01 Mar 2024 22:50:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 01 Mar 2024 14:46:15 -0300, Ricardo B. Marliere wrote:
> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the power_supply_class structure to be declared at build
> time placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> 
> [...]

Applied, thanks!

[1/1] power: supply: core: make power_supply_class constant
      commit: 71c2cc5cbf686c2397f43cbcb51a31589bdcee7b

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


