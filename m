Return-Path: <linux-kernel+bounces-5604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F912818CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE881F24A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB031208BC;
	Tue, 19 Dec 2023 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7w82t7I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87B520308;
	Tue, 19 Dec 2023 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2343c31c4bso378031766b.1;
        Tue, 19 Dec 2023 08:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703004763; x=1703609563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxC6S8Df4SvnkAXMbWUKpOTSQ1v3y3ScMeHuaO257hA=;
        b=F7w82t7I93vJJg9kag6+p3hWdH163rUKI0w8LOuIbZs5JbWpHTExBOQGIeJtvGXrUw
         ULTA2f43w/M3g44mVWOVs9Rfw5o8kk2KsdkbCP0v5iM6ha43IZYyDOqtjCqRwn1ozS+X
         9nECMTQy07SR6A5JIz4WJQwcWbc2o6kozBOV5yGNE5Lw5l8Hkb5R5stwf8YIfTldT8hK
         MLNB/3gseKRv8QgXpT4PLyKtAVLuiktdMNn7texsojFqWpwD9V+6M1bPChK/9sJF9IVn
         iw1u2dKmKLpCqEKobP1CgAU2EzF57Xkk0bSYJqFAKGfmNu89qRGTbLn7RTQYWOPWjWqZ
         22Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703004763; x=1703609563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxC6S8Df4SvnkAXMbWUKpOTSQ1v3y3ScMeHuaO257hA=;
        b=iBcbLtZyxCv/E86IbzijQztOl0tGyc3bbIuYY2yCpOhqoDgJW1WHGq17Qn5GtDglrO
         gJ0knkZP2OdurHGlYJ/qR9liLdiD3Ik3uxYJdS6+DocXq+15UeolwTBJ3SQ54Yv6oNgL
         8CQD4CDQ9gh0h9RtSt7RFNH749y9B7vXwpU5iXps34Ngx/TsP7QTu3R6g+a6YfvtlnIB
         M/2S41rdg4Vory9YBUUgTmu/+wiE/wFJSCI1gb+mi9LqvsSs7r0d24Ont1j5w75XN5bz
         LScYMFMEIwc4bZsqw6QtBrHjJYyxdq3bDaAjGGDq1FuxEJVNOu5K7ypgjEA/nUqx7/fE
         ro+w==
X-Gm-Message-State: AOJu0YztXmWY0k8dQgaJDbo41FpoSYksZkwxp5YdSk+mCU5/MhstCeG7
	Xk4y7wh08uaGku98PITwFFc=
X-Google-Smtp-Source: AGHT+IGAGwRqdPR1+1UIH4G19Rxphe2JUwS3RizzhgFClQPqT3fjslJQZ2yevwgtTAN2fDlpbvd1Wg==
X-Received: by 2002:a17:906:e011:b0:a23:350a:2d02 with SMTP id cu17-20020a170906e01100b00a23350a2d02mr1742458ejb.104.1703004762981;
        Tue, 19 Dec 2023 08:52:42 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id lm11-20020a17090718cb00b00a1db76f99c8sm15833180ejc.93.2023.12.19.08.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:52:41 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Frank Oltmanns <frank@oltmanns.dev>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Frank Oltmanns <frank@oltmanns.dev>
Subject:
 Re: [PATCH 3/5] clk: sunxi-ng: nm: Support constraints on n/m ratio and
 parent rate
Date: Tue, 19 Dec 2023 17:52:40 +0100
Message-ID: <1871631.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20231218-pinephone-pll-fixes-v1-3-e238b6ed6dc1@oltmanns.dev>
References:
 <20231218-pinephone-pll-fixes-v1-0-e238b6ed6dc1@oltmanns.dev>
 <20231218-pinephone-pll-fixes-v1-3-e238b6ed6dc1@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 18. december 2023 ob 14:35:21 CET je Frank Oltmanns napisal(a):
> The Allwinner A64 manual lists the following constraint for the
> PLL-VIDEO0 clock: 8 <= N/M <= 25
> 
> The PLL-MIPI clock is implemented as ccu_nm. Therefore, add support for
> this constraint.
> 
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
>  drivers/clk/sunxi-ng/ccu_nm.c | 21 +++++++++++++++++++--
>  drivers/clk/sunxi-ng/ccu_nm.h | 34 ++++++++++++++++++++++++++++++++--
>  2 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
> index ffac3deb89d6..cfc6981e398b 100644
> --- a/drivers/clk/sunxi-ng/ccu_nm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nm.c
> @@ -27,6 +27,19 @@ static unsigned long ccu_nm_calc_rate(unsigned long parent,
>  	return rate;
>  }
>  
> +static bool ccu_nm_is_valid_rate(struct ccu_common *common, unsigned long n, unsigned long m)
> +{
> +	struct ccu_nm *nm = container_of(common, struct ccu_nm, common);
> +
> +	if (nm->max_nm_ratio && (n > nm->max_nm_ratio * m))
> +		return false;
> +
> +	if (nm->min_nm_ratio && (n < nm->min_nm_ratio * m))
> +		return false;
> +
> +	return true;
> +}
> +
>  static unsigned long ccu_nm_find_best(struct ccu_common *common, unsigned long parent,
>  				      unsigned long rate, struct _ccu_nm *nm)
>  {
> @@ -36,8 +49,12 @@ static unsigned long ccu_nm_find_best(struct ccu_common *common, unsigned long p
>  
>  	for (_n = nm->min_n; _n <= nm->max_n; _n++) {
>  		for (_m = nm->min_m; _m <= nm->max_m; _m++) {
> -			unsigned long tmp_rate = ccu_nm_calc_rate(parent,
> -								  _n, _m);
> +			unsigned long tmp_rate;
> +
> +			if (!ccu_nm_is_valid_rate(common, _n, _m))
> +				continue;
> +
> +			tmp_rate = ccu_nm_calc_rate(parent, _n, _m);
>  
>  			if (ccu_is_better_rate(common, rate, tmp_rate, best_rate)) {
>  				best_rate = tmp_rate;
> diff --git a/drivers/clk/sunxi-ng/ccu_nm.h b/drivers/clk/sunxi-ng/ccu_nm.h
> index 93c11693574f..0075df6d9697 100644
> --- a/drivers/clk/sunxi-ng/ccu_nm.h
> +++ b/drivers/clk/sunxi-ng/ccu_nm.h
> @@ -31,6 +31,8 @@ struct ccu_nm {
>  	unsigned int		fixed_post_div;
>  	unsigned int		min_rate;
>  	unsigned int		max_rate;
> +	unsigned long		min_nm_ratio; /* minimum value for m/n */
> +	unsigned long		max_nm_ratio; /* maximum value for m/n */

Comment is wrong, it should be "n/m". For consistency with nkm patch,
min_n_m_ratio and max_n_m_ratio.

Best regards,
Jernej

>  
>  	struct ccu_common	common;
>  };
> @@ -108,7 +110,8 @@ struct ccu_nm {
>  		},							\
>  	}
>  
> -#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT(_struct, _name,	\
> +#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT_NM_RATIO(		\
> +						 _struct, _name,	\
>  						 _parent, _reg,		\
>  						 _min_rate, _max_rate,	\
>  						 _nshift, _nwidth,	\
> @@ -117,7 +120,9 @@ struct ccu_nm {
>  						 _frac_rate_0,		\
>  						 _frac_rate_1,		\
>  						 _gate, _lock, _flags,	\
> -						 _features)		\
> +						 _features,		\
> +						 _min_nm_ratio,		\
> +						 _max_nm_ratio)		\
>  	struct ccu_nm _struct = {					\
>  		.enable		= _gate,				\
>  		.lock		= _lock,				\
> @@ -128,6 +133,8 @@ struct ccu_nm {
>  						  _frac_rate_1),	\
>  		.min_rate	= _min_rate,				\
>  		.max_rate	= _max_rate,				\
> +		.min_nm_ratio	= _min_nm_ratio,			\
> +		.max_nm_ratio	= _max_nm_ratio,			\
>  		.common		= {					\
>  			.reg		= _reg,				\
>  			.features	= _features,			\
> @@ -138,6 +145,29 @@ struct ccu_nm {
>  		},							\
>  	}
>  
> +#define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT(_struct, _name,	\
> +						 _parent, _reg,		\
> +						 _min_rate, _max_rate,	\
> +						 _nshift, _nwidth,	\
> +						 _mshift, _mwidth,	\
> +						 _frac_en, _frac_sel,	\
> +						 _frac_rate_0,		\
> +						 _frac_rate_1,		\
> +						 _gate, _lock, _flags,	\
> +						 _features)		\
> +	SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT_NM_RATIO(		\
> +						_struct, _name,		\
> +						_parent, _reg,		\
> +						_min_rate, _max_rate,	\
> +						_nshift, _nwidth,	\
> +						_mshift, _mwidth,	\
> +						_frac_en, _frac_sel,	\
> +						_frac_rate_0,		\
> +						_frac_rate_1,		\
> +						_gate, _lock, _flags,	\
> +						_features,		\
> +						0, 0)
> +
>  #define SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(_struct, _name,	\
>  						 _parent, _reg,		\
>  						 _min_rate, _max_rate,	\
> 
> 





