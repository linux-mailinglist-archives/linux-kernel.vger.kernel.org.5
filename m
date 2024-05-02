Return-Path: <linux-kernel+bounces-166783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 075918B9F73
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9BA1F23EEE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7DD16FF45;
	Thu,  2 May 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdpCAseE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFE513C820;
	Thu,  2 May 2024 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670799; cv=none; b=ZCAd/SmVsHMO8t25x6LQFUKWJt+cKx0Ut214w6YHprqbskQwK+iLIpTOE8K8mDogLzNt0kY85nBI55bXf35I+5u0OGz5oW/LsRMo1RYG1Fw1m6Wiq0OYqkd8pXKJziIk/u+cGA3GTPO5emwRJGcG3lKl5FTC8s1zaypntHgJpPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670799; c=relaxed/simple;
	bh=ZaiiRZ2rHARj9qlIVThHOdD9gBPLlRdbHjtki6AAwhM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CmSsR2TAo13FGbNx3raR3kgtYJ/xd0gUWdxq4OjK52Wp0CPbr9+1QCyw5PZ1fiYRZP8XSpA/weAQbN9QlmjawjbjdY9U5FXOwV/QeeDY3kHXuUecd2aq0k+X/E5513d+JY05fBjOI6WvDTwf90fQ7VsENJIunyu+1g/+A2D9Rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdpCAseE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1FCC113CC;
	Thu,  2 May 2024 17:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714670798;
	bh=ZaiiRZ2rHARj9qlIVThHOdD9gBPLlRdbHjtki6AAwhM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LdpCAseEXC1l0+nRg+IFZwPvDYNnioSl5U++nFBZrw8Aa40h7cPTx6ym1wzsOFPqX
	 nl0O5Ffm38F29REUyV9MATORkoPzLjho+VnQTvs4vVzYdSBK+Jd2DfHzKXvcstlY57
	 R1kFl9hJUtJQ9FykDhHys2FIFa29Qiz9cJH3pUR02e5ArKGDwGFAGXhWYKiHfAAyRm
	 G+zDk3TpR/2Y/1wm2MbzSA6jBcpByiqBQtnEJORz1J+HqNBlwvRtHmb3wHaapNpe73
	 CIs3p7n6GrJz22v9+2qP7CSVWYHOpMBbefhxDeZWQt1CRelkbopMn5U3xnfToo8h7n
	 6jsfMgtcz/Zyw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, 
 deller@gmx.de, Shresth Prasad <shresthprasad7@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com, 
 skhan@linuxfoundation.org, julia.lawall@inria.fr
In-Reply-To: <20240502172121.8695-2-shresthprasad7@gmail.com>
References: <20240502172121.8695-2-shresthprasad7@gmail.com>
Subject: Re: (subset) [RESEND][PATCH v3][next] backlight:
 sky81452-backlight: Remove unnecessary call to of_node_get
Message-Id: <171467079621.1227065.12439900385268240993.b4-ty@kernel.org>
Date: Thu, 02 May 2024 18:26:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Thu, 02 May 2024 22:51:21 +0530, Shresth Prasad wrote:
> `dev->of_node` already has a reference to the device_node and calling
> of_node_get on it is unnecessary. All conresponding calls to
> of_node_put are also removed.
> 
> 

Applied, thanks!

[1/1] backlight: sky81452-backlight: Remove unnecessary call to of_node_get
      commit: 4da294108e38bf9cd5c62c2caa47611e5dbb7fb1

--
Lee Jones [李琼斯]


