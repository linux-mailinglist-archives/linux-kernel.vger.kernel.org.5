Return-Path: <linux-kernel+bounces-14175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FA38218C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4413E1C21751
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1FE7492;
	Tue,  2 Jan 2024 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Xl84UyZI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C332CA68;
	Tue,  2 Jan 2024 09:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704186871;
	bh=P0k9lGdFmaxKCJJMVyMxCu4geNsr/+d84M64wiuVpes=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xl84UyZIduCiBoywPWkR0hiM9OXdAQE/50z2JX5XCX1EMdcFtnS/DLNdpi9XcHaK3
	 Zgweay3hseljaKTQQUIwknvk6Y7wm/IksS6amwpxErfFHMgkc7j7jIa0J+zgGV3Li2
	 lRS05HexKdL/6aCr0lHonX4XH8+M/WC2aNsY0jTA1Jdqt4/rtlxeFDXPvRF/GdI1b/
	 0mSW6otEtK/nXvWlYkf8qMY4W79HCY0BA2hXmWB/jPgnvpl5AyCM30VZlaICEbw4Gh
	 eJOthtSbzD4TOPgb59bhkF90FY/v8WLFeh9PV90Kc8PjBjNHpZj83o5SN7hW+0M2D5
	 7Yabcb6FrC9iQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9D99F37804B2;
	Tue,  2 Jan 2024 09:14:30 +0000 (UTC)
Message-ID: <bfebc5ec-8501-44b6-b05a-93f5f2072c3d@collabora.com>
Date: Tue, 2 Jan 2024 10:14:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] arm64: dts: mediatek: mt8186: fix VENC power
 domain clocks
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>, tiffany.lin@mediatek.com,
 andrew-ct.chen@mediatek.com, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org, kernel@collabora.com
References: <20231228113245.174706-1-eugen.hristev@collabora.com>
 <20231228113245.174706-6-eugen.hristev@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231228113245.174706-6-eugen.hristev@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 28/12/23 12:32, Eugen Hristev ha scritto:
> The larb clock is in fact a subsys clock, so it must be prefixed by
> 'subsys-' to be correctly identified in the driver.
> 
> Fixes: d9e43c1e7a38 ("arm64: dts: mt8186: Add power domains controller")
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



