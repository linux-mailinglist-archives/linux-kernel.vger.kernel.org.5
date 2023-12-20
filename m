Return-Path: <linux-kernel+bounces-6762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC5C819D22
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015DBB21624
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7679820DD5;
	Wed, 20 Dec 2023 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="V8RNUcvu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E38C25758
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231220103935euoutp02c2b35a0bdfd81b34602b2eefa2306281~ihAcglhMx1574015740euoutp02V
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 10:39:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231220103935euoutp02c2b35a0bdfd81b34602b2eefa2306281~ihAcglhMx1574015740euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703068775;
	bh=TFBsvCINmEriidTZBHaDtaqOu3mdpDyVL7CdLeBbcwU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=V8RNUcvu8VLCe6PIVPpK8sLdbCq5VmzDrgvhAwaz5KSBH0UQpQzQ8ohf3ZcBqvmzw
	 q0DsI7Qu4fXg7lDqktXC6vtLOfGWWkUtaXUveK1dBkOXSOT03AmP9Zv4WoVDJNWeuv
	 mQil3uTDk+2GtLuGOp3QaffeWxSLXUSEMzUKoBws=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231220103934eucas1p226848411e2faf198815082e4f018e528~ihAcEnALh0402304023eucas1p2p;
	Wed, 20 Dec 2023 10:39:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id D2.F2.09539.664C2856; Wed, 20
	Dec 2023 10:39:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231220103934eucas1p18a70564f77e4dfef3b83ba11b20c60ae~ihAbj7Tii0155701557eucas1p1F;
	Wed, 20 Dec 2023 10:39:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231220103934eusmtrp16ba5daa0ba976cef02ccde105b78a5ec~ihAbjPwY43254832548eusmtrp1V;
	Wed, 20 Dec 2023 10:39:34 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-74-6582c46662c4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 41.1B.09146.664C2856; Wed, 20
	Dec 2023 10:39:34 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231220103933eusmtip12e7d4be67ee3218d1a091619543802df~ihAa2X8u70415704157eusmtip1D;
	Wed, 20 Dec 2023 10:39:33 +0000 (GMT)
Message-ID: <111adf74-5239-420a-880c-be92a2f663fd@samsung.com>
Date: Wed, 20 Dec 2023 11:39:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/exynos: gsc: minor fix for loop iteration in
 gsc_runtime_resume
Content-Language: en-US
To: Fedor Pchelkin <pchelkin@ispras.ru>, Inki Dae <inki.dae@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park
	<kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20231220095316.23098-1-pchelkin@ispras.ru>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7djPc7ppR5pSDbpfq1mcuL6IyeLBvG1s
	Fv+3TWS2uPL1PZvFpPsTWCx2rNvJbrH39VZ2i7NNb9gtNj2+xmpxedccNosZ5/cxWXw4v5rJ
	YuaVBYwWMya/ZHPg89j7bQGLx85Zd9k9Zvybyuhx59oeNo87r/+yetzvPs7ksXlJvUffllWM
	Hp83yQVwRnHZpKTmZJalFunbJXBl3FlxgqXgD0fF34Mf2RoYV7N3MXJySAiYSOy8cIupi5GL
	Q0hgBaPE7nmzWSCcL4wSW5fBZD4zSiy9tocVpuXz25mMEInljBKtD++xQzgfGSWu3OsGq+IV
	sJO4umQxC4jNIqAqcXNHPwtEXFDi5MwnYLaogLzE/VszwA4RFoiS2LnlFzOIzSwgLnHryXwm
	EFtEwENi9qp9rCALmAUuM0vsvtgIlmATMJToetvFBmJzClhILOu5yATRLC+x/e0cZpAGCYHN
	nBK/329jgrjbReLV+SmMELawxKvjW6BBICNxenIPC0RDO6PEgt/3mSCcCYwSDc9vQXVYS9w5
	9wtoHQfQCk2J9bv0QUwJAUeJPwtMIEw+iRtvBSFu4JOYtG06M0SYV6KjTQhihprErOPr4LYe
	vHCJeQKj0iykYJmF5P1ZSL6ZhbB2ASPLKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMCU
	d/rf8U87GOe++qh3iJGJg/EQowQHs5II797OplQh3pTEyqrUovz4otKc1OJDjNIcLErivKop
	8qlCAumJJanZqakFqUUwWSYOTqkGJi1NXTOO0AqzKIaK+cw/pe4vPFJTKLbN+dmPUp3dTt+r
	Cm7mhQjOCyzv2PTha5LPt1c7VHU/cFWocd9xiHk0kdtjy/yJVpNE1jDfnb76l9m5f76FkbK/
	/So9y5OSW34WLw790aEqLnvP3Y3556Hz+cbO2900/zkt5L3l7LDW+uDs2/qsa5WcT9qI5ejP
	mdvcmZ3/NUF/MuMEt2BXxx3FXWKumz+9tJnzz9Tw3JeMNBaLlA6Zn9Efb1gy2NzxD53j/6hy
	udmO0we9LouvM7nw/7NYsYdJUJTB3dl5HH9f6Xf+0o9fdDaxcZuGk/SdqybTXl8r6UxyXj3r
	I2dWi2n5/Q1fl/IuKy6/ftNf3e2oEktxRqKhFnNRcSIAWpfviegDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xu7ppR5pSDR5N4rA4cX0Rk8WDedvY
	LP5vm8hsceXrezaLSfcnsFjsWLeT3WLv663sFmeb3rBbbHp8jdXi8q45bBYzzu9jsvhwfjWT
	xcwrCxgtZkx+yebA57H32wIWj52z7rJ7zPg3ldHjzrU9bB53Xv9l9bjffZzJY/OSeo++LasY
	PT5vkgvgjNKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3
	S9DLuLPiBEvBH46Kvwc/sjUwrmbvYuTkkBAwkfj8diZjFyMXh5DAUkaJtsOrGSESMhInpzWw
	QtjCEn+udbFBFL1nlPix9zFYEa+AncTVJYtZQGwWAVWJmzv6WSDighInZz4Bs0UF5CXu35oB
	tk1YIEpi55ZfzCA2s4C4xK0n85lAbBEBD4nZq/axgixgFrjKLNF84R8zxLZuRomzu76DdbMJ
	GEp0vQU5g5ODU8BCYlnPRSaISWYSXVu7GCFseYntb+cwT2AUmoXkkFlIFs5C0jILScsCRpZV
	jCKppcW56bnFhnrFibnFpXnpesn5uZsYgVG+7djPzTsY5736qHeIkYmD8RCjBAezkgjv3s6m
	VCHelMTKqtSi/Pii0pzU4kOMpsDQmMgsJZqcD0wzeSXxhmYGpoYmZpYGppZmxkrivJ4FHYlC
	AumJJanZqakFqUUwfUwcnFINTCVPMqvF44Kr/hx9d+bV9luaFruPRiW/m3rC43ngfPUSP/v8
	27wzls5TP1X1dfnNe2n6XPWr+gNVlD9+5dWx5H3g0119QPz+L75Pkjm+ARxbVK89ERRzufrv
	/I29d7cdnngzOMn/7aOtiVVlm3efqfoouGvG83OlKywMf35Yufzzbue4HYcLr9gL9TToPHds
	Tb+91cG2WVTvwtw/Qde6V+j7v9t/aLNRjsMrk/cVDtKsXQ++fZLRX1AQtdrqwdRa2+ypy2UL
	suIWmZ6yCJtW1B/NeOXG+52mL1d3f92y5qdA+bpfIjd+9JTuagpreXN224tw1brSyorWkkOR
	XZ1aE0uTI9l3vGQ2st3UuEN22QclluKMREMt5qLiRAA49h6mewMAAA==
X-CMS-MailID: 20231220103934eucas1p18a70564f77e4dfef3b83ba11b20c60ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231220095336eucas1p1f6cec297f84463fbf50a875cc0fb64f6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231220095336eucas1p1f6cec297f84463fbf50a875cc0fb64f6
References: <CGME20231220095336eucas1p1f6cec297f84463fbf50a875cc0fb64f6@eucas1p1.samsung.com>
	<20231220095316.23098-1-pchelkin@ispras.ru>

On 20.12.2023 10:53, Fedor Pchelkin wrote:
> Do not forget to call clk_disable_unprepare() on the first element of
> ctx->clocks array.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: 8b7d3ec83aba ("drm/exynos: gsc: Convert driver to IPP v2 core API")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpu/drm/exynos/exynos_drm_gsc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> index 34cdabc30b4f..5302bebbe38c 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
> @@ -1342,7 +1342,7 @@ static int __maybe_unused gsc_runtime_resume(struct device *dev)
>   	for (i = 0; i < ctx->num_clocks; i++) {
>   		ret = clk_prepare_enable(ctx->clocks[i]);
>   		if (ret) {
> -			while (--i > 0)
> +			while (--i >= 0)
>   				clk_disable_unprepare(ctx->clocks[i]);
>   			return ret;
>   		}

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


