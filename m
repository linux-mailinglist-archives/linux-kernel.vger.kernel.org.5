Return-Path: <linux-kernel+bounces-11429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D9581E623
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CFCCB21D15
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E974CE10;
	Tue, 26 Dec 2023 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rYuljJqV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216464D129
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231226090334epoutp02ebad47f5b08d9e67496cf3aee0883c7c~kVkU13v3-1227712277epoutp02L
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:03:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231226090334epoutp02ebad47f5b08d9e67496cf3aee0883c7c~kVkU13v3-1227712277epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703581414;
	bh=iPJzPZUJOtcFEy3kJlM41T2FNvVSeCHrT2eoeFqvIx4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=rYuljJqVLeBxt/KoS0zUnioaasBj9EWsmUC9x7qVpai+9sy63MVzokFoVIVf4Vbvo
	 q1LwSEPmj+k95cUK5jDKph54qpkQQ8CZxHLoxlsdm3KYuJMfL9JCWYXKw6bwQrICTi
	 V/fksnR+jfFaFTToGh0G/4r5T10jkWycWDMz8FTY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231226090333epcas5p11b16ede09752c50897a8d0fb7cf6a7cd~kVkUJ3ym61563415634epcas5p1B;
	Tue, 26 Dec 2023 09:03:33 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Szphz6sjvz4x9Pw; Tue, 26 Dec
	2023 09:03:31 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D4.29.09672.ED69A856; Tue, 26 Dec 2023 18:03:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231226090225epcas5p2b9a73c36fd351c2a9d8e4d429456fcfa~kVjUck2Ui2793927939epcas5p2W;
	Tue, 26 Dec 2023 09:02:25 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231226090225epsmtrp22351024fb23caef0491aaefd51205aca~kVjUbrGHd1093010930epsmtrp2H;
	Tue, 26 Dec 2023 09:02:25 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-cc-658a96de826a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8B.CF.07368.1A69A856; Tue, 26 Dec 2023 18:02:25 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231226090223epsmtip13586d82508c67c42804bf7c853d0a79a~kVjS9iX490592105921epsmtip1B;
	Tue, 26 Dec 2023 09:02:23 +0000 (GMT)
From: "Aakarsh Jain" <aakarsh.jain@samsung.com>
To: "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>, "'Marek
 Szyprowski'" <m.szyprowski@samsung.com>, "'Andrzej Hajda'"
	<andrzej.hajda@intel.com>, "'Mauro Carvalho Chehab'" <mchehab@kernel.org>
Cc: <linux-fsd@tesla.coma>, <linux-samsung-soc@vger.kernel.org>, "'Smitha T
 Murthy'" <smithatmurthy@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20231224-n-s5p-mfc-const-v1-7-a3b246470fe4@linaro.org>
Subject: RE: [PATCH 07/15] media: s5p-mfc: constify s5p_mfc_hw_cmds
 structures
Date: Tue, 26 Dec 2023 14:32:22 +0530
Message-ID: <15d601da37da$3e8235d0$bb86a170$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKOGlHY6WxiJqLoSx78067AznjgmAFHw44hAPsYYjuvQWjYAA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmuu69aV2pBg83qlrcX/yZxWLv663s
	FpseX2O1WDY7yOLyrjlsFj0btrJazDi/j8li7ZG77BbLNv1hsmhpXMLqwOWxc9Zddo/Fe14y
	eWxa1cnmcefaHjaPzUvqPfq2rGL0+Pv6FZvH501yARxR2TYZqYkpqUUKqXnJ+SmZeem2St7B
	8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QCcqKZQl5pQChQISi4uV9O1sivJLS1IVMvKL
	S2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEKE7Izbl2rKJivXnHzTlwDY59SFyMnh4SA
	icTKFbfZuhi5OIQEdjNKnP+5jBXC+cQoce73FqjMN0aJ7avPM8O0LF19jAkisZdR4szHWSwQ
	znNGiY7f15lAqtgE9CXun+oBmyUicI5RYlv/FLAWZoGbjBLH3swEm8Up4CKx7skhMFtYIEDi
	w/ZHLCA2i4CqxP/2w2BxXgFLiTOtR9khbEGJkzOfgNUwC8hLbH87B+omBYmfT0Eu5wTa5iSx
	Ze1iNogacYmjP3uYQRZLCBzgkHg49R8bRIOLxJ7jc5ggbGGJV8e3sEPYUhKf3+2FqkmWeLzo
	JdSCHIn1e6awQNj2EgeuzAGyOYAWaEqs36UPEZaVmHpqHRPEXj6J3t9PoMbzSuyYB2OrScy5
	84MVwpaROLx6KeMERqVZSF6bheS1WUhemIWwbQEjyypGydSC4tz01GLTAuO81HJ4jCfn525i
	BCdhLe8djI8efNA7xMjEwXiIUYKDWUmEV1axI1WINyWxsiq1KD++qDQntfgQoykwvCcyS4km
	5wPzQF5JvKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxSDUxLfKap3laO
	dzAyPsvjLrWCq/5zsK3RljvT4z4qqL56kJu4uONnGXePxHLXf8ca+HcdeXii6p5cyIZIb5Pd
	h/dpPlWMrLshe65a1Marf/Y63stb++aU9odN3dgiee787k3rHpoe196nJHY1fbKO/tL3l3MX
	xmfscZJ6nX7I2cYo9z83f1PUzWtdy/Q+77Oo+rRbr/rJi/lP+vJW9czfcFqkeNmEHk6B3V6n
	w0On5DoacGvzSkhMcm/4n+2fWrRPqIvXZUNXifRNgR97zjxVP26Ytu1MYcbxA7K6/wyv3No3
	IblgrvlxuQ82cw90bN9RUc7BO2114oKAG1Uq9idM8u+aCFoeV8wurPOoM9S+bKrEUpyRaKjF
	XFScCABEa80iSwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsWy7bCSnO7CaV2pBp+6WSzuL/7MYrH39VZ2
	i02Pr7FaLJsdZHF51xw2i54NW1ktZpzfx2Sx9shddotlm/4wWbQ0LmF14PLYOesuu8fiPS+Z
	PDat6mTzuHNtD5vH5iX1Hn1bVjF6/H39is3j8ya5AI4oLpuU1JzMstQifbsEroxb1yoK5qtX
	3LwT18DYp9TFyMkhIWAisXT1MaYuRi4OIYHdjBJbPuxkh0jISPxvOwZlC0us/PecHaLoKaPE
	4t79zCAJNgF9ifunelhBEiICF4C69yxgA3GYBe4zSnRt2s4EUiUkcJZRYunRYBCbU8BFYt2T
	Q2DdwgJ+EpN2TgSrYRFQlfjffhgszitgKXGm9Sg7hC0ocXLmExYQm1lAW6L3YSsjhC0vsf3t
	HGaI8xQkfj5dxgpiiwg4SWxZu5gNokZc4ujPHuYJjMKzkIyahWTULCSjZiFpWcDIsopRMrWg
	ODc9N9mwwDAvtVyvODG3uDQvXS85P3cTIzgOtTR2MN6b/0/vECMTB+MhRgkOZiURXlnFjlQh
	3pTEyqrUovz4otKc1OJDjNIcLErivIYzZqcICaQnlqRmp6YWpBbBZJk4OKUamAzkuCfMStlb
	4lNpWaOu+bdsNvuzz/vOGLL1TwqbvU7V9SZr9OlYFrF6YZaQ7Ju27OHHty8+ezuvvHjXUe5p
	at8/Jyz5otXbPq3bPYuzcLGmJ0sa5x3NSNtHodef2fs9so0sUpimZeVd8fHnTmXvL6k7LNwj
	K9WLAhbarVXUKo9zM3j4tNmy/I7VzwaTykWJPxYv+qIvK53PUCJ5+8Gfl+8XuLK9P9V+7MuU
	WElmsVUFqpe6bj0Pd340Qcxt6yGPyym+es47z7cc90uJCn2lYRp+5dIpPXeWZ1P4nDi/pDAd
	enpQt9F/y++NjVaZ3toGHHy/skw0511TsuCREny1UPyOidqGuYvvJE8RruxSYinOSDTUYi4q
	TgQAvqbLhzIDAAA=
X-CMS-MailID: 20231226090225epcas5p2b9a73c36fd351c2a9d8e4d429456fcfa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231224154443epcas5p1ff84ea0f066dc19c908a18ccf0222b2f
References: <20231224-n-s5p-mfc-const-v1-0-a3b246470fe4@linaro.org>
	<CGME20231224154443epcas5p1ff84ea0f066dc19c908a18ccf0222b2f@epcas5p1.samsung.com>
	<20231224-n-s5p-mfc-const-v1-7-a3b246470fe4@linaro.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: 24 December 2023 21:14
> To: Marek Szyprowski <m.szyprowski@samsung.com>; Andrzej Hajda
> <andrzej.hajda@intel.com>; Mauro Carvalho Chehab
> <mchehab@kernel.org>
> Cc: Aakarsh Jain <aakarsh.jain@samsung.com>; linux-fsd@tesla.coma; linux-
> samsung-soc@vger.kernel.org; Smitha T Murthy
> <smithatmurthy@gmail.com>; linux-arm-kernel@lists.infradead.org; linux-
> media@vger.kernel.org; linux-kernel@vger.kernel.org; Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org>
> Subject: [PATCH 07/15] media: s5p-mfc: constify s5p_mfc_hw_cmds
> structures
> 
> Static "s5p_mfc_hw_cmds" structures are not modified by the driver, so they
> can be made const for code safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c | 4 ++--
> drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.h | 2 +-
> drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c | 4 ++--
> drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.h | 2 +-
> drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c
> index 327e54e70611..1fbf7ed5d4cc 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c
> @@ -148,7 +148,7 @@ static int s5p_mfc_close_inst_cmd_v5(struct
> s5p_mfc_ctx *ctx)  }
> 
>  /* Initialize cmd function pointers for MFC v5 */ -static struct
> s5p_mfc_hw_cmds s5p_mfc_cmds_v5 = {
> +static const struct s5p_mfc_hw_cmds s5p_mfc_cmds_v5 = {
>  	.cmd_host2risc = s5p_mfc_cmd_host2risc_v5,
>  	.sys_init_cmd = s5p_mfc_sys_init_cmd_v5,
>  	.sleep_cmd = s5p_mfc_sleep_cmd_v5,
> @@ -157,7 +157,7 @@ static struct s5p_mfc_hw_cmds s5p_mfc_cmds_v5 = {
>  	.close_inst_cmd = s5p_mfc_close_inst_cmd_v5,  };
> 
> -struct s5p_mfc_hw_cmds *s5p_mfc_init_hw_cmds_v5(void)
> +const struct s5p_mfc_hw_cmds *s5p_mfc_init_hw_cmds_v5(void)
>  {
>  	return &s5p_mfc_cmds_v5;
>  }
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.h
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.h
> index 6eafa514aebc..c626376053c4 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.h
> @@ -11,6 +11,6 @@
> 
>  #include "s5p_mfc_common.h"
> 
> -struct s5p_mfc_hw_cmds *s5p_mfc_init_hw_cmds_v5(void);
> +const struct s5p_mfc_hw_cmds *s5p_mfc_init_hw_cmds_v5(void);
> 
>  #endif /* S5P_MFC_CMD_H_ */
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
> index 25c4719a5dd0..740aa4dfae57 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
> @@ -154,7 +154,7 @@ static int s5p_mfc_close_inst_cmd_v6(struct
> s5p_mfc_ctx *ctx)  }
> 
>  /* Initialize cmd function pointers for MFC v6 */ -static struct
> s5p_mfc_hw_cmds s5p_mfc_cmds_v6 = {
> +static const struct s5p_mfc_hw_cmds s5p_mfc_cmds_v6 = {
>  	.cmd_host2risc = s5p_mfc_cmd_host2risc_v6,
>  	.sys_init_cmd = s5p_mfc_sys_init_cmd_v6,
>  	.sleep_cmd = s5p_mfc_sleep_cmd_v6,
> @@ -163,7 +163,7 @@ static struct s5p_mfc_hw_cmds s5p_mfc_cmds_v6 = {
>  	.close_inst_cmd = s5p_mfc_close_inst_cmd_v6,  };
> 
> -struct s5p_mfc_hw_cmds *s5p_mfc_init_hw_cmds_v6(void)
> +const struct s5p_mfc_hw_cmds *s5p_mfc_init_hw_cmds_v6(void)
>  {
>  	return &s5p_mfc_cmds_v6;
>  }
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.h
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.h
> index 9dc44460cc38..29083436f517 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.h
> @@ -11,6 +11,6 @@
> 
>  #include "s5p_mfc_common.h"
> 
> -struct s5p_mfc_hw_cmds *s5p_mfc_init_hw_cmds_v6(void);
> +const struct s5p_mfc_hw_cmds *s5p_mfc_init_hw_cmds_v6(void);
> 
>  #endif /* S5P_MFC_CMD_H_ */
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> index 6a47f3434c60..9278ed537e9c 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> @@ -339,7 +339,7 @@ struct s5p_mfc_dev {
>  	struct s5p_mfc_priv_buf ctx_buf;
>  	int warn_start;
>  	struct s5p_mfc_hw_ops *mfc_ops;
> -	struct s5p_mfc_hw_cmds *mfc_cmds;
> +	const struct s5p_mfc_hw_cmds *mfc_cmds;
>  	const struct s5p_mfc_regs *mfc_regs;
>  	enum s5p_mfc_fw_ver fw_ver;
>  	bool fw_get_done;
> 
> --
> 2.34.1

Reviewed-by: Aakarsh Jain <aakarsh.jain@samsung.com>

Thanks!



