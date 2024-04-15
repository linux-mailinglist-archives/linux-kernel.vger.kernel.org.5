Return-Path: <linux-kernel+bounces-145310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E488A527B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25D128249C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097947352B;
	Mon, 15 Apr 2024 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="KMolAgPr"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E641373163;
	Mon, 15 Apr 2024 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189578; cv=none; b=tnesEQAXRP1/cEGTxpPc7gOHaYm+k3rkZsujjk4Xtt3PtzPcMKvIKBWa6uc5B8PVed6PmiXbDis1Bu6mQGRl/D9DYwTvLsjCc7Kudj4PXJGAvU/fzcWV+/AjTXDHlGWuy5ajqPS8kKwDpiiNfwPlPj+FuEOrouqncHTF911ace4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189578; c=relaxed/simple;
	bh=9vZ/az2uga1smaAnN/seIO0ar+qO2aTQ6YgT7f9CcOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TerGmwJpc6VWWwlvb8sxiRkOpNbYNmovA84E41SBrhqr9+S4ErsinWAGeMsI8ckkgUeXc6WRlZhODZWRLZqBOToVh9foorfdhaikNtthMFMyX4wWvVF2g7GzT2v0Iw5r/BgKvBHRIOwwy0hc4drUCKRpPiRI2S09IZj/xUdLRkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=KMolAgPr; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 408DA88193;
	Mon, 15 Apr 2024 15:59:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713189575;
	bh=RZbptOuQs2swmZA+KPuVax4YoS8La7KM0DF+wW2keM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KMolAgPrDFouc2CIcpEt1ElhDEmxKDEsrIfW79bXyyMWoEiRFccBOSlTne9clSzjA
	 QQMqFmPv1LCoq2KYsZVPCNUUymRg+mlz78k1KjxxNGUp4egq4Hiuqt5LQadfsUaTZi
	 6fkhIfyzZ2of4SVshOE//c8qtc5zQ+RasKN8PdpFbKCdkxzrlGUPtJ5pcLhEc1Bq3R
	 zMy/JFS/VD6LEdhq9AP2wNZ/CGZZ98VyKizAbvIlfMba3avbmy17wqflLhP+0aCHak
	 GTCe2sbLkJl0mHNqO4YlRDnsMRHWmD5gH0FqkZvXbqm4NaxUyWpE4jshQ1nZR/6LHr
	 lXdQfRDEviF+g==
Message-ID: <97a6261b-7d26-4e29-88b3-1ac5084a6fc7@denx.de>
Date: Mon, 15 Apr 2024 15:24:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: rs9: fix wrong default value for clock amplitude
To: Catalin Popescu <catalin.popescu@leica-geosystems.com>, sboyd@kernel.org,
 mturquette@baylibre.com, biju.das.jz@bp.renesas.com,
 marek.vasut+renesas@mailbox.org
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 bsp-development.geo@leica-geosystems.com, m.felsch@pengutronix.de
References: <20240415124219.604339-1-catalin.popescu@leica-geosystems.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240415124219.604339-1-catalin.popescu@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/15/24 2:42 PM, Catalin Popescu wrote:
> According to 9FGV0241, 9FGV0441 & 9FGV0841 datasheets, the default
> value for the clock amplitude is 0.8V, while the driver assumes 0.7V.
> 
> Additionally, define constants for default values for both clock
> amplitude and spread spectrum and use them.
> 
> Fixes: 892e0ddea1aa ("clk: rs9: Add Renesas 9-series PCIe clock generator driver")
> 
> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>

Use git send-email -v2 next time.

Reviewed-by: Marek Vasut <marex@denx.de>

