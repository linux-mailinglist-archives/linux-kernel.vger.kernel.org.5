Return-Path: <linux-kernel+bounces-92042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 546B5871A27
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CC91C210FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0331F54747;
	Tue,  5 Mar 2024 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjDnJHzI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467DE535CF;
	Tue,  5 Mar 2024 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633068; cv=none; b=bUqRlPvZi22XkZOgO+gobXUJwV47KnyL8oIKTmmgmrAwZmJFjddTRKHioTBdRCT1sVf/w1WodKiMESeSB2kklGHxT0JvRFKXiAw3WwCLe6euTvpjXlOxqFW4Cd36NvgqfrjtmRUGXgkJOoZ0x0jIfhargIUhR92hthnY95otYVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633068; c=relaxed/simple;
	bh=8W2qw1WVmAoRpkjb/Rl0uY6LpoazYFR3M96IUv9XMAs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QP4Dq6isdaZbWO4Q8ZXENtyb7U4ry2duCVI8Y6vQB16ZvWsZ2yddV7xLgDR3oFvlDDKPuug56WfPan3RDvEAzspATgF6mAFOTo93IS8qYkLCGtPRmzAjkIH6daPrwSwKUcl4KoEhKObVD9BN9yU9JYsRZhNyhv0dpe5dZ6POK8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjDnJHzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77714C433F1;
	Tue,  5 Mar 2024 10:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709633067;
	bh=8W2qw1WVmAoRpkjb/Rl0uY6LpoazYFR3M96IUv9XMAs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IjDnJHzIKlI5pTTxw9ouETpa8Qru8SG6F+ONURQ03blCAJrme1qkftj3wylFthZH8
	 IQtZsB3GyU1YvZXM7MnEKATyR6GkpNtb9zz04jYsp39xO6LlFG2oT9CyCJESRg+YtX
	 /jsJgNg4hbKmLMA1rd9/LkVYTOhgOhThPJHoOrOk8DaIVUViDG78DAulvTL0c1a/Dt
	 B7WJoK2+uwQV8dDx57HpbDjXkhDHcDlYQuUuN1fTuS1Uuo0GCPQrg0wzqVqNLbsOio
	 3E6UZEpuH9cTBtbo0duncn9k2ha82s+Sgiy/4aMm87SVnGsJPC9PKKVmwIVO8QK1ei
	 zXlP8baeG+jTg==
From: Lee Jones <lee@kernel.org>
To: Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
References: <20240305-backlight-probe-v2-0-609b0cf24bde@linaro.org>
Subject: Re: [PATCH v2 0/7] backlight: Simplify probe in few drivers
Message-Id: <170963306625.66390.18051034360544296280.b4-ty@kernel.org>
Date: Tue, 05 Mar 2024 10:04:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 05 Mar 2024 09:11:55 +0100, Krzysztof Kozlowski wrote:
> Simplify old code in few backlight drivers.
> 
> Changes in v2
> =============
> 1. Patch #1: Drop "Error :" msg.
> 2. Add Rb tags.
> Link to v1: https://lore.kernel.org/r/20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org
> 
> [...]

Applied, thanks!

[1/7] backlight: gpio: Simplify with dev_err_probe()
      commit: 2f5929cd930b24a88d6fa73ab08ba857c59f7686
[2/7] backlight: l4f00242t03: Simplify with dev_err_probe()
      commit: d3de24fc13465a4b45047d193f729b73e062a881
[3/7] backlight: bd6107: Handle deferred probe
      commit: e00b57b4d4464071cb18d03cc8040e103c662d80
[4/7] backlight: as3711_bl: Handle deferred probe
      commit: fd9f81bc3f48d5064bfd894eeb0202f5825ea4b1
[5/7] backlight: lm3630a_bl: Handle deferred probe
      commit: c7fa2f12e74a437fc8c77b7780131b13acc2fa49
[6/7] backlight: lm3630a_bl: Simplify probe return on gpio request error
      commit: dedd6eb26bbb37139d0a0122e4b4ad94f06edaa1
[7/7] backlight: pandora_bl: Drop unneeded ENOMEM error message
      commit: 07dbc9e6e2433fe312423096efc037bf47298ed1

--
Lee Jones [李琼斯]


