Return-Path: <linux-kernel+bounces-58226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2F784E31A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B135290F70
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106767A713;
	Thu,  8 Feb 2024 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKN5UCsy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B677993E;
	Thu,  8 Feb 2024 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707402301; cv=none; b=TZrlvElmFD7JwuGNv0+vOko3UypM6QOEmeoQXW9G28bfOV4fWu3s8pESCfPTRBe9Ywpokc/8dTAgAZbDB+DtvQhH2U5eSKFou5r+s25EkkC4A/6rTMu3ahnvbeqApUb3yFjNXE6KTaKaOE6HPHVnrnUxsSy2056QTTN1V5vPqlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707402301; c=relaxed/simple;
	bh=k9PWzREXb25IgI5xrvjYbQ9AfDmYYoThZ4v7NnxSkE4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h9pWWoS26vLys6CrlFhbLah6+yBukm70wOl0CpizVNYv3AxO+CgRtfMGLZ5UcjMQs0X2S+FwHK1/DjB9KEAZbjPtPCegnvRuiuKo3XR/Ed2QdiRqGxM/RVWgr07dY+PDergC1ar7XnwRMIzkzo5O28tRBiJwRHyZW8B2WRmai84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKN5UCsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9097C433F1;
	Thu,  8 Feb 2024 14:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707402300;
	bh=k9PWzREXb25IgI5xrvjYbQ9AfDmYYoThZ4v7NnxSkE4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HKN5UCsyzQDmfnSVUA0PWCr4yMUZNi+1lTyc0JbjjTsQb2UcMIusw04kON04kkTgZ
	 948z61i3hmXjbIWe8qSO9l5wG+h4glMKC6+BdVXxonSILXp24tafqTww0GCcZls3My
	 OZq1GfqXgkhPAyRS/lapHkeu6oBhtg6G3IzH3mCW+9fxtCcEuzyNEg+vEYRa5/UZGw
	 RH/0aEs1OHbGsGpaP/c0pLiCYssn7lBmC5gh5HZ5o3QiIAfiUOLNgpWG0nG7JTdJcU
	 xs4rgdJmjlkdIITupdx5kNo9x1RpgvYkBn0F5KTUejtILWmz01+JbrkwC/0rdq6+bZ
	 PQYII4pWOpX/Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, wens@csie.org, marek.vasut+renesas@gmail.com, 
 support.opensource@diasemi.com, neil.armstrong@linaro.org, 
 ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com, 
 mazziesaccount@gmail.com, mcoquelin.stm32@gmail.com, 
 alexandre.torgue@foss.st.com, Bo Liu <liubo03@inspur.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, patches@opensource.cirrus.com, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240206071314.8721-1-liubo03@inspur.com>
References: <20240206071314.8721-1-liubo03@inspur.com>
Subject: Re: [PATCH 00/18] mfd: convert to use maple tree register cache
Message-Id: <170740229742.1068783.15434523911244194304.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 14:24:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Tue, 06 Feb 2024 02:12:56 -0500, Bo Liu wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Bo Liu (18):
>   mfd: ac100: convert to use maple tree register cache
>   mfd: as3711: convert to use maple tree register cache
>   mfd: as3722: convert to use maple tree register cache
>   mfd: axp20x: convert to use maple tree register cache
>   mfd: bcm590xx: convert to use maple tree register cache
>   mfd: bd9571mwv: convert to use maple tree register cache
>   mfd: dialog: convert to use maple tree register cache
>   mfd: khadas-mcu: convert to use maple tree register cache
>   mfd: lochnagar-i2c: convert to use maple tree register cache
>   mfd: wolfson: convert to use maple tree register cache
>   mfd: rohm: convert to use maple tree register cache
>   mfd: rk8xx: convert to use maple tree register cache
>   mfd: rn5t618: convert to use maple tree register cache
>   mfd: rsmu_i2c: convert to use maple tree register cache
>   mfd: si476x: convert to use maple tree register cache
>   mfd: stmfx: convert to use maple tree register cache
>   mfd: stpmic1: convert to use maple tree register cache
>   mfd: rc5t583: convert to use maple tree register cache
> 
> [...]

Applied, thanks!

[01/18] mfd: ac100: convert to use maple tree register cache
        commit: 8745a81ac22f42c7233fbddc6aa5922b231aac2a
[02/18] mfd: as3711: convert to use maple tree register cache
        commit: 780b1aa441a3d64e400cb2ea96bc3e162322eb31
[03/18] mfd: as3722: convert to use maple tree register cache
        commit: aea5c3cbc51eee3ac25ff8f936252901c4549011
[04/18] mfd: axp20x: convert to use maple tree register cache
        commit: 009073d504f67146d936cc45f21cc27c1bc15490
[05/18] mfd: bcm590xx: convert to use maple tree register cache
        commit: 684c1f0b79417cf08810dfd57c5a549a9741ad7a
[06/18] mfd: bd9571mwv: convert to use maple tree register cache
        commit: 35b1b8622ca3172b3c6b2a377e5913bac0367634
[07/18] mfd: dialog: convert to use maple tree register cache
        commit: 1cb7a3bca56c124ca9e5c13fcac7de884c195c5c
[08/18] mfd: khadas-mcu: convert to use maple tree register cache
        commit: 5f734f5f374f68960afd2130a5ce982912c14c15
[09/18] mfd: lochnagar-i2c: convert to use maple tree register cache
        commit: 8881896e05b6a91251dde0ce21ce79c2c201888d
[10/18] mfd: wolfson: convert to use maple tree register cache
        commit: f353b2c639e4f4ac9831d94c8237026cebaa8e73
[11/18] mfd: rohm: convert to use maple tree register cache
        commit: aabd38f3779b8108b65cc7ae8b5c20a6c352b0a2
[12/18] mfd: rk8xx: convert to use maple tree register cache
        commit: 08aa1e797a5cc97d2106476263f938342e72015e
[13/18] mfd: rn5t618: convert to use maple tree register cache
        commit: a011cacb63c3ff6562bd86afae8cdd49d0f075c9
[14/18] mfd: rsmu_i2c: convert to use maple tree register cache
        commit: b85821cecdf933420a6ba93658e1e4710644f5c1
[15/18] mfd: si476x: convert to use maple tree register cache
        commit: 030473871c3f4f126bd43018517abfcb070f6b95
[16/18] mfd: stmfx: convert to use maple tree register cache
        commit: 87a48e35ce2ef992287b828b1268bedc7415d2de
[17/18] mfd: stpmic1: convert to use maple tree register cache
        commit: ab993d2d68951db3ebfeaa44567a790ec566526d
[18/18] mfd: rc5t583: convert to use maple tree register cache
        commit: d5132d176d6f21742ac67fd311ccc61fe830e999

--
Lee Jones [李琼斯]


