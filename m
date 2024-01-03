Return-Path: <linux-kernel+bounces-15511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD1E822CEF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1F4BB2213B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2DA1A27D;
	Wed,  3 Jan 2024 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E9mSVbTY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619B9199D9;
	Wed,  3 Jan 2024 12:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704284548;
	bh=lvVhhUPH6kgSD2hH7kfMwPENfYjI5v43CDGfoYJVRe0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E9mSVbTYG4tlQT1A7IfwrqibQxxjhvypSmCoxWCccB8QSi16wIajqfsJDJq6dmLJ/
	 PTucrbfUU0HyfT5wkpHwRVnQCpEjRDlAeYxUXI8A86eYgEfrfuxLxAhwA4sZK/UeOg
	 rEk8mYSfJ1ackWN/aW2sFJF5hUwdUjL6sYexWjfCBcBsXE6/CsarDJ1yAZFQ8JNnfI
	 yDL0EGeXpotrbN4wyRjq5lyEZWC66VIARJk7sY5XYDCTRsHMHUEP7LmV831qOMQj9I
	 LdiVTPqGD/+k3u7mHwkl/aRnNvR0i8nyCfq1q3ZUFdEZMfN1FyBezRhLDnxRxr6Cbx
	 dpIUxvcIiyqOQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9BC163781F8C;
	Wed,  3 Jan 2024 12:22:27 +0000 (UTC)
Message-ID: <709e7af4-21d5-408a-9989-98493232421f@collabora.com>
Date: Wed, 3 Jan 2024 13:22:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/24] arm64: dts: mediatek: mt8173: Enable cros-ec-spi
 as wake source
Content-Language: en-US
To: Mark Hasemeyer <markhas@chromium.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Raul Rangel
 <rrangel@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240102210820.2604667-1-markhas@chromium.org>
 <20240102140734.v4.9.Ic09ebe116c18e83cc1161f4bb073fea8043f03f3@changeid>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240102140734.v4.9.Ic09ebe116c18e83cc1161f4bb073fea8043f03f3@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/01/24 22:07, Mark Hasemeyer ha scritto:
> The cros_ec driver currently assumes that cros-ec-spi compatible device
> nodes are a wakeup-source even though the wakeup-source property is not
> defined.
> 
> Some Chromebooks use a separate wake pin, while others overload the
> interrupt for wake and IO. With the current assumption, spurious wakes
> can occur on systems that use a separate wake pin. It is planned to
> update the driver to no longer assume that the EC interrupt pin should
> be enabled for wake.
> 
> Add the wakeup-source property to all cros-ec-spi compatible device
> nodes to signify to the driver that they should still be a valid wakeup
> source.
> 
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



