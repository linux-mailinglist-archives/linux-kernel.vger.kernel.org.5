Return-Path: <linux-kernel+bounces-5094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2841818685
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D77C9B23636
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D25F16415;
	Tue, 19 Dec 2023 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sMrJfnel"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7916179BC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-336668a5a8dso2895715f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702986010; x=1703590810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6kPTqEltuZTKg6cwZ0yCtniHlC19Lun3lrDCubLGZM=;
        b=sMrJfnelyNMuoznquyyJJerc+bp2LEjzbNVNozT9SyS0OOHDLPe0WLaFAzHiOUnL+R
         utXwxxPRUinsmvsYoymMVV/vLUFqi7BP7DWiRKfUoWrS4FcA4n2Jak5K7fNEEs1JxwNV
         XWQHlmG/TUs5V1OpRWmOeWGxuFpgvvc7r1QYZnEjPQfyX4NKg9dOXa/rXy57NCs4EQ5I
         wNVJ9dSDqTQ1b9wMr5HSfl7uxa4N7DjRfeea6SWuZrqoDTU8dHBhtwEXP2/j9CwSlnSN
         V+UAa+PdInkJ+UDePCtyY/oxNL4p6cP8Rrc8xoyBLQ7QL3G0oYliPwXieaCe9PE8XmbB
         ydEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702986010; x=1703590810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6kPTqEltuZTKg6cwZ0yCtniHlC19Lun3lrDCubLGZM=;
        b=PCQ3YqG4ehQhMsLVsMXbzVPckNeSaSy4mtEs8xFNOtUjdziGdUMDGpksJjEQM11Etk
         f/rFVMnf5MNoldoZrXeVYJJ12Gfw3eh+X5FNE/8W8+CQfcslYFwGCVrZQHnLCthA0IuQ
         NFGYAmL5tdoS6kZcly5bLEyOyGm5wN8eby9H305g5Ur2mQwmmBnJiuGRL0IiGKGkVOwW
         Xyab7wzWCVvKGpmkavPa4UN9+SduN+ZiNuWp+xfzPfMe7BRmeFTccLrGGLEdNa2LE2iQ
         EU/wS0bQim2jXAe4TzblMmgSNeWdsByKi8DKyaZyMAmtgbWaJJ5Kxey1mcHXiwf6tB1H
         B8JQ==
X-Gm-Message-State: AOJu0YyDmCa7ihkPIzrv3LEj7AEeD7l6K2GRd56ij6YNB3quB5slU+Yj
	7196ZR5qmlY5yceBexsVHZFmVA==
X-Google-Smtp-Source: AGHT+IF5TN/5hBo5enuofc1gxqcd5M7N9jJXA5AOe2M0sLiFa/NG0B8GQbWkSKo3h6t3Q7hp+Ks9kQ==
X-Received: by 2002:adf:e282:0:b0:333:2fd2:5d1f with SMTP id v2-20020adfe282000000b003332fd25d1fmr9210991wri.81.1702986010038;
        Tue, 19 Dec 2023 03:40:10 -0800 (PST)
Received: from [192.168.100.86] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id c11-20020adfef4b000000b003366f4406f6sm2317785wrp.97.2023.12.19.03.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 03:40:09 -0800 (PST)
Message-ID: <e08f54cb-5b28-497b-9484-b691dce0acff@linaro.org>
Date: Tue, 19 Dec 2023 11:40:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/34] media: introduce common helpers for video
 firmware handling
Content-Language: en-US
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-2-git-send-email-quic_dikshita@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1702899149-21321-2-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/12/2023 11:31, Dikshita Agarwal wrote:
> Re-organize the video driver code by introducing a new folder
> 'vcodec' and placing 'venus' driver code inside that.
> 
> Introduce common helpers for trustzone based firmware
> load/unload etc. which are placed in common folder
> i.e. 'vcodec'.
> Use these helpers in 'venus' driver. These helpers will be
> used by 'iris' driver as well which is introduced later
> in this patch series.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---

This is a very large patch, I think it needs to be broken up into 
smaller chunks.

#1 Introduce common helper functions
#2 Use common helper functions

Its alot of code to try to eat in the one go.

Could you consider making patches 1-3 a standalone series to reduce the 
amount of code to review here ?

* 77e7025529d7c - (HEAD -> linux-stable-master-23-12-18-iris-v2) media: 
iris: add power management for encoder (21 hours ago)

* ceb6a6f023fd3 - (tag: v6.7-rc6, linux-stable/master) Linux 6.7-rc6 (2 
days ago)

git diff ceb6a6f023fd3 | wc -l

21243

Also I feel it wouild give more time for the changes to "digest" though 
upstream users and to find any unintended bugs.

> +int load_fw(struct device *dev, const char *fw_name, phys_addr_t *mem_phys,
> +	    size_t *mem_size, u32 pas_id, bool use_tz)
> +{
> +	const struct firmware *firmware = NULL;
> +	struct reserved_mem *rmem;
> +	struct device_node *node;
> +	void *mem_virt = NULL;
> +	ssize_t fw_size = 0;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER) ||
> +	    (use_tz && !qcom_scm_is_available()))
> +		return -EPROBE_DEFER;
> +
> +	if (!fw_name || !(*fw_name))
> +		return -EINVAL;

The parameter check should come before the qcom_scm_is_available()

No matter how many times you -EPROBE_DEFER -EINVAL is still -EINVAL.

> +
> +	*mem_phys = 0;
> +	*mem_size = 0;

I don't think you need this, you don't appear to use these variables 
before you assign them below.


> +
> +	*mem_phys = rmem->base;
> +	*mem_size = rmem->size;

> +
> +int auth_reset_fw(u32 pas_id)
> +{
> +	return qcom_scm_pas_auth_and_reset(pas_id);
> +}
> +
> +void unload_fw(u32 pas_id)
> +{
> +	qcom_scm_pas_shutdown(pas_id);
> +}
> +

Do these wrapper functions add anything ? Some kind of validity check on 
the pas_id otherwise I'm not sure these are justified.

> +int set_hw_state(bool resume)
> +{
> +	return qcom_scm_set_remote_state(resume, 0);
> +}
> diff --git a/drivers/media/platform/qcom/vcodec/firmware.h b/drivers/media/platform/qcom/vcodec/firmware.h
> new file mode 100644
> index 0000000..7d410a8
> --- /dev/null

---
bod


