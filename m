Return-Path: <linux-kernel+bounces-146440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAA68A654D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5C81C218C0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6793C84D22;
	Tue, 16 Apr 2024 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yA1lYQgN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592F0386;
	Tue, 16 Apr 2024 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253230; cv=none; b=UyDpk8KXTBXRyvpZJxYehSJNIl2NHGX4kHUXfvtsDYlSV1EZ+UiJAb0aQlBxNlmrSvVPy86xg2a2tjnioArCpHbmk8lVi3LhXgPVkSarqgqa+uqF/fDV4aVS/Wn+G+BOr58INmey1VAOAvd5xKR3LAVDwb+lZ87CFJkpg2d0kOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253230; c=relaxed/simple;
	bh=FoIbanP3UpVckOe8AjCzCFkDAEl2hpy2mVru5y5z+Zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+/Ks3n/I17kMDn8/ZsjPV1Rw2WKAEbj+Kxkr9Lg9fD4qbnk/eiQrBUE34nBie3yf1iMpSksKgjoCB76URNKfDGgHWcD/kfOxzyp3Y0RcDjwiqHVYpo7hSy/zJtAT8LuOSrX7iBt4tkKDpJV/JykBgQPm01Sl4qdkC3PUOyEwuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yA1lYQgN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713253227;
	bh=FoIbanP3UpVckOe8AjCzCFkDAEl2hpy2mVru5y5z+Zk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=yA1lYQgNRdORbdwPBABZZ9bTqZwbM3E9mwwzwx8xH+P17s9nEL1B8cT2nYkhfPKs9
	 TPO9KsTg5dlFxNMv2T8rXsD28iduuNPuqLUm1czYHgj2+e/WfVwrRr92U4mV8lEP04
	 GN3DbTq8rHspHmKBX+lDQFju/NThawX0GiUY3kuCxIAhWvU/Bb29ALvsuZK4mx0wYB
	 QWI6p7xkrvCq+QZUKgN15bEy7LSO0NI+qM/ibkOxLnrmFFbqs4QtRPa8n5ULW1e/hH
	 AGE4I8cpLem3nf76FaS1LUN2ogBE6n1q6HW2TEHhULEilRJT0Sdu4SiDnABJrNC4vg
	 nk4tkRu7i7b4w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A5D5F378210B;
	Tue, 16 Apr 2024 07:40:26 +0000 (UTC)
Message-ID: <e3710200-d780-4e76-b630-db720cf01c21@collabora.com>
Date: Tue, 16 Apr 2024 09:40:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] thermal/drivers/mediatek/lvts_thermal: Add
 coeff for mt8192
To: Hsin-Te Yuan <yuanhsinte@chromium.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
 <nfraprado@collabora.com>, =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?=
 <bero@baylibre.com>, Balsam CHIHI <bchihi@baylibre.com>
Cc: Alexandre Mergnat <amergnat@baylibre.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240416-lvts_thermal-v2-1-f8a36882cc53@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240416-lvts_thermal-v2-1-f8a36882cc53@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/04/24 09:35, Hsin-Te Yuan ha scritto:
> In order for lvts_raw_to_temp to function properly on mt8192,
> temperature coefficients for mt8192 need to be added.
> 
> Fixes: 288732242db4 ("thermal/drivers/mediatek/lvts_thermal: Add mt8192 support")
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



