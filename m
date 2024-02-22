Return-Path: <linux-kernel+bounces-75951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 421EF85F110
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB03B1F22C89
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E6A111BB;
	Thu, 22 Feb 2024 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABKgzx6g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8970979FE;
	Thu, 22 Feb 2024 05:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708580694; cv=none; b=hmvV6N5is+T1XFjBc4+tQQulpcW2oBYwcrjFse7PFOeOJJOYCeEZqKXPp9WEk/MTtdWSqsQjTQ8RZ4Hb1EIkLOi6eJ9dxpdKzBF0wwDT4+j9KJLuyRkVMaqugBSkBPYaeuaXkLJUpzyyAz9MAyKg2dZiMTUfyigoin/dKsATkAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708580694; c=relaxed/simple;
	bh=Qy+DmTKK2ZiLmNsZrUpidDqv4dRIGVyvMhM3tcYze4E=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=PcADU6k5pCycmAhzXsnWbnLD4HcbFQT2hghi0zqiRITiQP8q8/Dj0t1sA9IZGl0Jt1als/Jia0+U+QSmOg3GhV6gVBMzOVMKZMP8o4w9E0aQXos5ReG+enV5/WWPWANL0hIX/s9PrI8LPQy06YWVvs6sh3tHJXT6vVKKHPzCgyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABKgzx6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDDAC433F1;
	Thu, 22 Feb 2024 05:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708580694;
	bh=Qy+DmTKK2ZiLmNsZrUpidDqv4dRIGVyvMhM3tcYze4E=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ABKgzx6gvVPREkUfTzE1+S8GdAXDdGG+UKBXRRivW3o5w9x8NTd7xcagRBo/ENwn6
	 vA6OBgnQx7iwFk7I+3QW3WZgY7liB5qGIQo9AwwrhqzKkMbiXdieDKnuTNcLW7me8L
	 XHjOEiiaAtHWc+eUymCzPxXYF5j0aiOcDP72zjDgQfbNTLyK5+XXobxYUHRDKD6+Yg
	 lHYsLoenypVJMbYkfP9xwOSDOPDVUKbIhRYyXN2el7sVE8v1k1GhR+ZkrJ+R6pMLFi
	 /ZGjHSW7+UAjB3mJr33FK0IHtwUZU6MTvQVuWpHxgLa9lAU3/MNSi5yzUv/GZp5fVs
	 PRI79+DnMjtAA==
Message-ID: <02eee0653b0f3c944fa605fe4786d2cc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240214183006.3403207-8-cristian.marussi@arm.com>
References: <20240214183006.3403207-1-cristian.marussi@arm.com> <20240214183006.3403207-8-cristian.marussi@arm.com>
Subject: Re: [PATCH 7/7] clk: scmi: Support get/set duty_cycle operations
From: Stephen Boyd <sboyd@kernel.org>
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, f.fainelli@gmail.com, vincent.guittot@linaro.org, peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com, quic_nkela@quicinc.com, souvik.chakravarty@arm.com, Cristian Marussi <cristian.marussi@arm.com>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
To: Cristian Marussi <cristian.marussi@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 21 Feb 2024 21:44:51 -0800
User-Agent: alot/0.10

Quoting Cristian Marussi (2024-02-14 10:30:06)
> Provide the CLK framework callbacks related to get/set clock duty cycle if
> the relared SCMI clock supports OEM extended configurations.
>=20
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: linux-clk@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

