Return-Path: <linux-kernel+bounces-107190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB50387F8E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F457B2136D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE015380D;
	Tue, 19 Mar 2024 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pK7+2DYV"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E300250249
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835636; cv=none; b=K/IbL1/TLZL/ZwhRvzfLDRDbIAXyEc+1ZEdQ6m3YkWITHG3+x7NO8C+jyrMdjVRdpDipuxNupkfKrFAmsh3c/9wuSc6yiHbE+QuYZCkHm4XyB4Mxmuc9SEupFf9PneDh+cyumV7ZhKSuMbQ9Xuf6NzKegeyDHpqQ1SkI+Wbha6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835636; c=relaxed/simple;
	bh=BWfuo9855ONPF1k1D4oUaIBz6CAGhQMFb/rHZw4p2oE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DwuWaiVUcZFyok232osTs1iB81D35IA8/pBPvrGWVnfDUFY08f+nn2eX0TiiWO78gPe2kaNfXrkX7TUwljqi+TFudeYuZ0Pa1Vt/M9QAMuMpFBoeLbYDoxK2G2zNXARppqvMYUItI/jAyEXbDlPHzhxjtfcdMYjnPe9yzF5mrRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pK7+2DYV; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ddd1624beso3235789f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 01:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710835632; x=1711440432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=spYxpIEXYSNCSvAxWfrD34Q6PwS/7IJ3TtTp+AY4irk=;
        b=pK7+2DYVqiVYb1RfP+VxSnGlaKTUC3zv8IZIXwKegYU5cPJ0kz2TOitEGgua72XG3x
         5WHXs3z1DoELhnKYNMdlIT0oYngdHq8TZyvR4D31rzH3nhf1KnnCoZSp2YXjGbFgvJP8
         e7urFdJT2v9it+7RfMXNuObtYMeFGBXWeKgkzRs8Jqg7ifB37+FL/m+29PUCZG3biP1X
         yc+SSpEBzrVsJygRDTiUNHekIA4BcIoREdlfFFfbR2BQLzE73TjWk2yq2lOljvijDqen
         QOGa+ziELW6Abb144XiV1f9TOkcStPrh/BtKfAHshM0FEPKycYzL9TeQIuRWJhXB3jjn
         aH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710835632; x=1711440432;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=spYxpIEXYSNCSvAxWfrD34Q6PwS/7IJ3TtTp+AY4irk=;
        b=NCQ+H9N8F48kXn92W6z2xsmYTfp4vLPjSfhZvoo0GSbXKZMGWsW22j2Q9F6vdjp0DX
         p8sh/IH5KJp0jnXi4Y/yzCnZgvG22DFVAjcAWPHiSvg3bhGRN1p+NAzMy8WXoKP/ju2F
         RIsGNnMiXM3Y7YHscQf8dnjYgWakaIwKC3NEIU/HVeneQGbtyrY38ocile266aEQMuE4
         wwkPM12aMuVom0D5YLaPY85d4T9jPMB1h/4QOiPY7MyA3BuVI/Hbp1eL4YzGQ3NoLH91
         9WzGsiZOc9351pgRSeaYd6lHcsuM9zPsXBdQNqtd76aEiVKgwG0KgWLbHUT3vDwf4bKZ
         gSrg==
X-Forwarded-Encrypted: i=1; AJvYcCW78giXhfYbE/g1xJIEwqUwqfPvuMNfkXjSXI8eq62pux5AxBA3j5ENIqzySN1Ox+I2yJJoGoUeuPzkiVWVb8stmb+TicqX5ZNDMCoc
X-Gm-Message-State: AOJu0Yz28AEBrQYXMuR8dmLWx5JDcZniTwa3dLeNdsTrpYceDk7sVAsr
	YREL6kS7e7lna+SiAkDuwg6KmTXbYp2SCmBcUyb+uEX2T1A1NPWHJM4QpsCEjag=
X-Google-Smtp-Source: AGHT+IFcvq6E9fBSZM2MY1IqdcxNGVVY1riao78wmDDVCMtvpbhSlftq640TPYVM8TuqdrlVOk7mkg==
X-Received: by 2002:adf:e2ca:0:b0:33e:764b:ab17 with SMTP id d10-20020adfe2ca000000b0033e764bab17mr1433241wrj.14.1710835632086;
        Tue, 19 Mar 2024 01:07:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:2fcf:6f16:3b3b:da8e? ([2a01:e0a:982:cbb0:2fcf:6f16:3b3b:da8e])
        by smtp.gmail.com with ESMTPSA id bu27-20020a056000079b00b0033ecbfc6941sm11461315wrb.110.2024.03.19.01.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 01:07:11 -0700 (PDT)
Message-ID: <9907040c-7e25-4aa5-a4be-6f4820e335f1@linaro.org>
Date: Tue, 19 Mar 2024 09:07:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] drm,fbdev: td043mtea1: Convert sprintf() family to
 sysfs_emit() family
Content-Language: en-US, fr
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kernel@vger.kernel.org
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg
 <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Helge Deller <deller@gmx.de>, linux-omap@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20240319035555.1577734-1-lizhijian@fujitsu.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20240319035555.1577734-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 19/03/2024 04:55, Li Zhijian wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
> sprintf() and scnprintf() will be converted as well if they have.
> 
> Generally, this patch is generated by
> make coccicheck M=<path/to/file> MODE=patch \
> COCCI=scripts/coccinelle/api/device_attr_show.cocci
> 
> No functional change intended

Please split patches in 2, while the driver targets the same hw, they
are not under the same subsystems.

Neil

> 
> CC: Neil Armstrong <neil.armstrong@linaro.org>
> CC: Jessica Zhang <quic_jesszhan@quicinc.com>
> CC: Sam Ravnborg <sam@ravnborg.org>
> CC: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> CC: Maxime Ripard <mripard@kernel.org>
> CC: Thomas Zimmermann <tzimmermann@suse.de>
> CC: David Airlie <airlied@gmail.com>
> CC: Daniel Vetter <daniel@ffwll.ch>
> CC: Helge Deller <deller@gmx.de>
> CC: linux-omap@vger.kernel.org
> CC: linux-fbdev@vger.kernel.org
> CC: dri-devel@lists.freedesktop.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V2:
>     Fix missing '+' before '=' in drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
> 
> This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
> Split them per subsystem so that the maintainer can review it easily
> [1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
> ---
>   drivers/gpu/drm/panel/panel-tpo-td043mtea1.c        | 13 ++++---------
>   .../omap2/omapfb/displays/panel-tpo-td043mtea1.c    | 12 ++++--------
>   2 files changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
> index cf4609bb9b1d..0983fe47eb5a 100644
> --- a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
> +++ b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
> @@ -242,16 +242,11 @@ static ssize_t gamma_show(struct device *dev, struct device_attribute *attr,
>   	struct td043mtea1_panel *lcd = dev_get_drvdata(dev);
>   	ssize_t len = 0;
>   	unsigned int i;
> -	int ret;
>   
> -	for (i = 0; i < ARRAY_SIZE(lcd->gamma); i++) {
> -		ret = snprintf(buf + len, PAGE_SIZE - len, "%u ",
> -			       lcd->gamma[i]);
> -		if (ret < 0)
> -			return ret;
> -		len += ret;
> -	}
> -	buf[len - 1] = '\n';
> +	for (i = 0; i < ARRAY_SIZE(lcd->gamma); i++)
> +		len += sysfs_emit_at(buf, len, "%u ", lcd->gamma[i]);
> +	if (len)
> +		buf[len - 1] = '\n';
>   
>   	return len;
>   }
> diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
> index 477789cff8e0..3624452e1dd0 100644
> --- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
> +++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
> @@ -228,14 +228,10 @@ static ssize_t tpo_td043_gamma_show(struct device *dev,
>   	int ret;
>   	int i;
>   
> -	for (i = 0; i < ARRAY_SIZE(ddata->gamma); i++) {
> -		ret = snprintf(buf + len, PAGE_SIZE - len, "%u ",
> -				ddata->gamma[i]);
> -		if (ret < 0)
> -			return ret;
> -		len += ret;
> -	}
> -	buf[len - 1] = '\n';
> +	for (i = 0; i < ARRAY_SIZE(ddata->gamma); i++)
> +		len += sysfs_emit_at(buf, len, "%u ", ddata->gamma[i]);
> +	if (len)
> +		buf[len - 1] = '\n';
>   
>   	return len;
>   }


