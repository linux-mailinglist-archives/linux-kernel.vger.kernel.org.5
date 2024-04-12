Return-Path: <linux-kernel+bounces-142010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8343B8A2610
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3ABDB2281E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1281CD04;
	Fri, 12 Apr 2024 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPjz9UuK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516881C2B3;
	Fri, 12 Apr 2024 05:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901587; cv=none; b=ko3BmuLKJji8HUTWuXIsuMovD3yiPgFN8Aj8hvNCcJASPw5JwQbaF5vVWRMa+C8nYnIV90soTEEYSdTWaWBnRH2QLb31AjKHEi7xE/5n35hDzetiHHcOtGazKutFBLB98F4XVboaYEf2erFX5u1VGJOGivpOIM0VqB1Z229McRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901587; c=relaxed/simple;
	bh=RZmcayPnF618npxKtoNHMaaHGNdqbV0wNnATB0Wu0MU=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=XyosUTWOQsAzkySwvSvEpGKGNGPMIbzyznKYO7ENzqKT3jCCq5td3K7QGswTla7tWRztDjYY7H5V7IGoxCj43B9hNRgj/unIH8scl8TA2FlzM1t4pTi+qu8AKwZhZVwhJzKbjjC3Y/zS4FiKoY63Oqnb1K5nS+3vM5dh4W5B4dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPjz9UuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC179C2BBFC;
	Fri, 12 Apr 2024 05:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712901586;
	bh=RZmcayPnF618npxKtoNHMaaHGNdqbV0wNnATB0Wu0MU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=oPjz9UuKtqk/uY9Gv5dBuLPKPFNRKQUSRsULivPUW+5PDuxb3wnzYmJ3/p7iy6+Yw
	 K5Lo7Hq57qC+FUaiWEWO2XIkh3gWqq25AQqeD5SVD8GHlI+gAWVgnqGPIj9hKN9PZD
	 7Qk8QXrfiquu/odgLCR4Y+kSCdEPK6+iJNe0rUXYb0r7MdxjFIDYf3rHswmqiAmc12
	 CAgv+4OdIUJHkQZLhgg9zzwhPHTB92qmPVg382/9o3h1WuD3B6v5rL8ctNjYhXjexq
	 XEQSPVPDc55S7yd776X/BQKonT1cKErtLLNeWFcsiv31AC/O7cLRMw4R4u7zJd2P/v
	 J3xfVW2tGiBjQ==
Message-ID: <7480aa086d187f1ae70f10e4479cbf53.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240412051041.90376-2-mmyangfl@gmail.com>
References: <20240412051041.90376-2-mmyangfl@gmail.com>
Subject: Re: [PATCH v9 00/13] clk: hisilicon: Migrate devm APIs
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org, David Yang <mmyangfl@gmail.com>
To: David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Date: Thu, 11 Apr 2024 22:59:44 -0700
User-Agent: alot/0.10

Quoting David Yang (2024-04-11 22:10:29)
> Migrate devm APIs for HiSilicon clock drivers and remove redundant codes.
>=20
> This series is a partial improvement of [1]
>=20
> v2: fix test robot error
> v3:
>   * size_t for all these num types
>   * hisi_clk_unregister() change into separate patch
>   * keep relevant header inclusions
>   * split driver files changes into separate patches
>   * explain hisi_clk_register_fn() checkpatch warnings
>   * not fixed: MODULE_LICENSE("GPL v2"), as stated in SPDX-License-Identi=
fier
>   * not fixed: "hisilicon,hip04-clock" un-documented, as none of dts file=
s in
>     arch/ use it, better to ask hisi people why they pushed this driver
> v4:
>   * typo: hisi_clocks_get_nr() should check clks->nr first
>   * unexport hisi_clk_unregister_fn() as no one use them outside
> v5: catch up with remove_new refactoring
> v6: fix compilation error and expand macros
> v7: rebase and use mod_devicetable.h instead
> v8: rebase again
> v9: add linux/platform_device.h include in patch 09 according to reviews

Still doesn't work. Please compile every file before sending again.
Hint:

	make path/to/file.o

