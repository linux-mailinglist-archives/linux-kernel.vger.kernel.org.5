Return-Path: <linux-kernel+bounces-21097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0103E8289CE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B912852D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAEA3A1C4;
	Tue,  9 Jan 2024 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="PTokONlk"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F1B38DC1;
	Tue,  9 Jan 2024 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1704816881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9bfKWlLqQsQQRAseh4rBecx5vgdDZwtE/9STShTx68=;
	b=PTokONlkCtK2Opey7wzaUGXQBl1gkiL/El0gDy7rVAM3uIdCi8526WmDnH7BAoqv4sjohM
	E+c6Fjdg3jByXurVIjk4MzbUw94faHXUv8Cuo2qiK0XoaIqReo+lfTBZ8lcAxvTXaK65Ha
	Y1j2RjqupTHn2AfhPWr7xGm3xU9GSPSK3B/BypMZ2kU9tHhZMi9spUsrm3ok6RxYxh86U9
	heitUARfG3q02SMGmnEdfamuIo82pArpgexkNtgwPGKxDAdDpu8/iHAT43SdAhI1cKXXa7
	w0biVPqEuuiIpxJIzuE4u4G7GMpMCjg1AhMRdyKozjCK5vb1Qy5zzptLLTO/IA==
Date: Tue, 09 Jan 2024 17:14:41 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Quentin Schulz <foss+kernel@0leil.net>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Quentin
 Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: add spi controller aliases on
 rk3399
In-Reply-To: <2305627.1xdlsreqCQ@diego>
References: <20240109-rk3399-spi-aliases-v1-0-2009e44e734a@theobroma-systems.com>
 <20240109-rk3399-spi-aliases-v1-1-2009e44e734a@theobroma-systems.com>
 <685047b0-a907-49c6-919b-e46976d8ef7b@linaro.org> <2305627.1xdlsreqCQ@diego>
Message-ID: <0b82a9081578644545e8e3c32081aad1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-09 16:22, Heiko Stübner wrote:
> Am Dienstag, 9. Januar 2024, 16:15:30 CET schrieb Krzysztof Kozlowski:
>> On 09/01/2024 14:35, Quentin Schulz wrote:
>> > From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> >
>> > There are 6 SPI controllers on RK3399 and they are all numbered in the
>> > TRM, so let's add the appropriate aliases to the main DTSI so that any
>> > RK3399-based board doesn't need to define the aliases themselves to
>> > benefit from stable SPI indices in userspace.
>> 
>> But that contradicts the point that board should define aliases for
>> exposable interfaces. Sorry, that's a NAK.
> 
> didn't we have this same discussion some weeks ago? ;-) .
> 
> I.e. spi2 on Rockchip socs is called spi2 in _all_ SoC documentation,
> lines in _all_ schematics are also always called spi2_foo , so as 
> before
> I really don't see any value in repeating the very same aliases in
> _every_ board.
> 
> Same for i2c, uart .

Yes, and the RK356x SoC dtsi already defines the spiX aliases in the 
same way as Quentin proposed.  Taking that as an additional example, the 
RK3399 dtsi can do the same.

> It is of course different for non-numerable interfaces - like the mmcX
> aliases - where the controller is named sdhci, sdmmc, sdio ... and
> similar cases. These get to stay in the board dts files of course.
> 
> 
> Heiko
> 
>> > Cc: Quentin Schulz <foss+kernel@0leil.net>
>> 
>> No need to Cc yourself...
>> 
>> > Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> > ---
>> 
>> Best regards,
>> Krzysztof
>> 
>> 
> 
> 
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

