Return-Path: <linux-kernel+bounces-38534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1DA83C125
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1741F230D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8EF45026;
	Thu, 25 Jan 2024 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eVKYlYU6"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562C836123;
	Thu, 25 Jan 2024 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182809; cv=none; b=IB+hzUEKuZlGyJZAfuwyj5FpUDHefT/dnzgtjO9poQm313l/vKZ+R8jEYhnME0RGJKggk9cpc86Pl5AUWOdX+50TSQhz+y7udXk12BcPsXQDLhZbKmDywUEyZnOXKEpWW8/GvsOOhEyloOXwzHnZyZtYN44pefVb6oTK+arpoWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182809; c=relaxed/simple;
	bh=PR4u1uqnWtL4FpwQTctaeO9GFlt3IXMBIyn9Kgq6A+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlhAaKWkRbuSDTNfNXuYqKxRtnzyje+xdYPg0ppfgT0zqf5BTIKVX/z5d6qg3ilhJCr5I4HQvUqoqPwdt7SismtQXzdhvHqQExSbne1I3dK1hYYZg1d6ximsFiml4paQbWloNSYNTPPyHMdxKEMALDFDSBYFzVkMBQe0xf0Gwek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eVKYlYU6; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706182806;
	bh=PR4u1uqnWtL4FpwQTctaeO9GFlt3IXMBIyn9Kgq6A+M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eVKYlYU6KBauHZRU1CRYJAetxjkon0LICA7nDXhf+97gGq0E+QptID4kWpToeb4eA
	 6mMK13H4IBddoXW5Wl8PTX7flr1quUk+6Hdf9YpWGCzmu92Uix50R1f70ZjBBe4DNB
	 mmVGMZuvw+1IDCgc8pS+Xp2J1xtzovla0Dh9mBhTzB3lK5Yl94d/BNR1EvuszaXUyO
	 5PS0qOF87CEJhgBumoTA8uHokoUhKtyZ5ScsASW24j6z41z9ZNtbhDfAO0NMTwzJFd
	 RRLGYe8FscPP9xQu3MRgQbQwX7gnjdd9/TKMtF5RiYflwjvkTohCNd2XE0oTY7zsmB
	 K9K1UVyqjx5bA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DEF783782074;
	Thu, 25 Jan 2024 11:40:05 +0000 (UTC)
Message-ID: <f0ba1132-1394-49c0-954a-7efd7066722b@collabora.com>
Date: Thu, 25 Jan 2024 12:40:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8183-pico6: Fix bluetooth
 node
Content-Language: en-US
To: Chen-Yu Tsai <wenst@chromium.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240125095240.2308340-1-wenst@chromium.org>
 <20240125095240.2308340-3-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240125095240.2308340-3-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/01/24 10:52, Chen-Yu Tsai ha scritto:
> Bluetooth is not a random device connected to the MMC/SD controller. It
> is function 2 of the SDIO device.
> 
> Fix the address of the bluetooth node. Also fix the node name and drop
> the label.
> 
> Fixes: 055ef10ccdd4 ("arm64: dts: mt8183: Add jacuzzi pico/pico6 board")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



