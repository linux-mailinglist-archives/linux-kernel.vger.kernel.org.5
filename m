Return-Path: <linux-kernel+bounces-25749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDC182D54A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28411C2113C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D55BE74;
	Mon, 15 Jan 2024 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zKe69Heb"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD61882F;
	Mon, 15 Jan 2024 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705308463;
	bh=oWi9eFoF7K88Adnz8j47J1hlMriFpHzstYkAobfziBk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=zKe69HebDyxC7eRQBzOcqQAagTcarugxixtfa1NcKFE+vOH4vFdRrz8OJg4UDcczq
	 sOvlKx44FqaVtrayHZhav65bCR6K4Ne2IGUJxQs7GQ+FeQVtObx859wXCVzEeOhT+h
	 5xYBpFpP6ZyHWYZaeUREJ5uvOy6QMcBZo1FF+M1dC0Fe7Ufyxfxwf4hII6+kXicAQz
	 OC+vtxnZP6vJqkc/4sMkTQuVEY69KBQc5fTm2shnJeQy3Q1UbIsjrAyiL02oyfQBM9
	 EsC5Xg6EjtEgx+QJqjtXVu3Q84Gb7l8jv+bET0xWsOc89ZdgZwfEqNDf7MF06CZDV2
	 acUTKKjvKfYYQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2CF503781F80;
	Mon, 15 Jan 2024 08:47:42 +0000 (UTC)
Message-ID: <0e1f7d19-9a11-4a65-8a4f-72dafaa5a2ec@collabora.com>
Date: Mon, 15 Jan 2024 09:47:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: mt8183: jacuzzi: Remove CrosEC base
 detection node
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Ikjoon Jang <ikjn@chromium.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Stephen Boyd <swboyd@chromium.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240112142032.909736-1-nfraprado@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240112142032.909736-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 12/01/24 15:20, Nícolas F. R. A. Prado ha scritto:
> The cbas node is used to describe base detection functionality in the
> ChromeOS EC, which is used for units that have a detachable keyboard and
> thus rely on this functionality to switch between tablet and laptop
> mode.
> 
> All machines in the jacuzzi family are either clamshells (ie normal
> laptops) or convertibles, meaning the keyboard can be flipped but not
> detached. The detection for the keyboard getting flipped is handled by
> the driver bound to the keyboard-controller node in the EC.
> 
> Since there is no base detection in these machines, and the device
> backed by this node fails to probe and goes unused, delete the node from
> the DT.
> 
> Fixes: 4fa8492d1e5b ("arm64: dts: mt8183: add cbas node under cros_ec")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

I really don't like seeing /delete-node/ statements, unless there's an
exceptionally good reason to do so, and I don't think this is the case.

Please remove cbas from the base inclusion and add it on a per-device basis.

Thanks,
Angelo


