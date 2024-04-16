Return-Path: <linux-kernel+bounces-147310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FB88A7249
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D48F281844
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABC11332BC;
	Tue, 16 Apr 2024 17:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XgF0QLxS"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A331A132C1F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288522; cv=none; b=ti83UTW85IIGV+mCQG7vZMSZXyunC2bLgUg91BKv/YJdP+dF7+jRIijpM69f4tEeBZGFyYffY23UrJ3eo7hLAT0wO3ahsRMKGCxBNURf6jEgfS6UsPo1SjzOkNSw99rU4RCE2KLE/UWCE1LDy70yb3r3O0zV21XMHHdTvcBkFWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288522; c=relaxed/simple;
	bh=8XPbzCyiV/2fpDM6Skf+nUqvJTuMI/dwcR/DrTukkjE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KOSDIMddawwMIwh0HfNIENdPQjnI/CTLPe4B/sFOd/fs1il2Kyp6upS24nOUxAcwPG0qVQKizq7CIrQ6EdzKi3uAyem40b52RLA9Ib3gsAVlFmGxS+6retVTE4ZcUmU5Yj7gVXtK0i1rE28pTD+ReoOiqm+rWrjEkDgiaD82JQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XgF0QLxS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e51398cc4eso43910535ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713288520; x=1713893320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTuR9E70nAlgpS27zTEvS3dG58ZWZq9znfhZxK8dgH8=;
        b=XgF0QLxSWJBkRaKDnbr0k3ufopsEOk1qDWNcqrma7Mt8CoamJkuwTAZy0LDUhuqLJ9
         8L4UMWd594VKRzbKD44Dy1PsyJFEMr5uyQCC8dQaqSsFTmt3FzUHQsl3RHjohagFdATN
         RJgO6atmwhONjyeEwQimUG/u+uZNL8cL/na3OCduGR8GxtnBp2QtxB5cLO8LQqAauK6r
         cir43PDLCBbNmEFCBi+3U3Rc0LGFCNaps9iU3s/gZJ4iIVkpaOY+N2hVL97YAiNFZ0ku
         prGOeUSfnU8ORbU0fhJ5GO4CMFk8DrWhODTrhUJAP5OxNWBR4t29vgKOf911r41gtJKf
         wJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713288520; x=1713893320;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zTuR9E70nAlgpS27zTEvS3dG58ZWZq9znfhZxK8dgH8=;
        b=DC8Yu+JNU21sUWaKD6blZqnT2jEkOT19vn/bk8S2H5NXRLx5xapyp2nsoClDcpmXMT
         gbjfFCDw/wJ4qc219P+08g4KjJPIdpaOTe9KFBbzbcWtlRslpt8Hz5dfE9Zh5KdQFgjn
         6bihqSC3nlicYedFsw1hv3Y55ZneHUb0nb0qF1eDOPyLZKvrZb/IRvI3U8AJ5hEkZH2T
         +eqCpr+VsHF+/cLp7hJwkN0WamNliPMV6vzkPKVp7lDkn5RQrRllslQnw3UAA1WEx+Uh
         kcY+Ja2L7C+ZJ6+IJdqiwfzEPFI7kL1KPcXPOlCB9s+37LcnRug/sSs3I0i8Pjqizn5x
         4+Dw==
X-Forwarded-Encrypted: i=1; AJvYcCXT6ILl4GrOZ4MuFTodRL5AHabtwbXMBkLQ0JCT5IX95ADTGAkUopVVHWC10lflI/nwohtRhby9ZXgDBRBiKBizrXEEIYY5+YHLIYGG
X-Gm-Message-State: AOJu0YzEv6Zt7Ym120mkut0yQ7cXKpjHKBBX9KOfyX9v7wDETyuinspV
	qXdtmHZ6Zkk3HtS34nHfS+uS23fQ8TrL+Jw7COBfObJj/vL9yabD2pjk9N3PXsY=
X-Google-Smtp-Source: AGHT+IFxfA3rNQm6U5J0p3r8Nmv4+VJasUOaU4viGZz2EHrZrD+RsVzSJM5qFCloHItvUeR4h80LJw==
X-Received: by 2002:a17:90a:8d84:b0:2aa:5c79:853c with SMTP id d4-20020a17090a8d8400b002aa5c79853cmr4465059pjo.21.1713288519972;
        Tue, 16 Apr 2024 10:28:39 -0700 (PDT)
Received: from [10.36.52.145] ([24.75.208.156])
        by smtp.gmail.com with ESMTPSA id 42-20020a17090a09ad00b002a2a3aebb38sm10035010pjo.48.2024.04.16.10.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 10:28:39 -0700 (PDT)
Message-ID: <2d0a026f-a4f0-49e2-8501-358db5935e14@linaro.org>
Date: Tue, 16 Apr 2024 19:28:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 4/8] usb: typec: ucsi: glink: use le32 for message data
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240416-ucsi-glink-altmode-v1-0-890db00877ac@linaro.org>
 <20240416-ucsi-glink-altmode-v1-4-890db00877ac@linaro.org>
Content-Language: en-US, fr
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
Organization: Linaro
In-Reply-To: <20240416-ucsi-glink-altmode-v1-4-890db00877ac@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/04/2024 04:20, Dmitry Baryshkov wrote:
> The message structures as transferred by the PMIC_GLINK use le32 for
> data encoding. Correct struct accessors to follow the lead of the main
> pmic_glink.c driver.
> 
> Fixes: 62b5412b1f4a ("usb: typec: ucsi: add PMIC Glink UCSI driver")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/usb/typec/ucsi/ucsi_glink.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
> index 6be9d89d4a28..d029cc9d82e3 100644
> --- a/drivers/usb/typec/ucsi/ucsi_glink.c
> +++ b/drivers/usb/typec/ucsi/ucsi_glink.c
> @@ -33,7 +33,7 @@ struct ucsi_read_buf_req_msg {
>   struct ucsi_read_buf_resp_msg {
>   	struct pmic_glink_hdr   hdr;
>   	u8                      buf[UCSI_BUF_SIZE];
> -	u32                     ret_code;
> +	__le32                  ret_code;
>   };
>   
>   struct ucsi_write_buf_req_msg {
> @@ -44,13 +44,13 @@ struct ucsi_write_buf_req_msg {
>   
>   struct ucsi_write_buf_resp_msg {
>   	struct pmic_glink_hdr   hdr;
> -	u32                     ret_code;
> +	__le32                  ret_code;
>   };
>   
>   struct ucsi_notify_ind_msg {
>   	struct pmic_glink_hdr   hdr;
> -	u32                     notification;
> -	u32                     receiver;
> +	__le32                  notification;
> +	__le32                  receiver;
>   	u32                     reserved;
>   };
>   
> @@ -255,7 +255,7 @@ static void pmic_glink_ucsi_write_ack(struct pmic_glink_ucsi *ucsi, const void *
>   	if (resp->ret_code)
>   		return;
>   
> -	ucsi->sync_val = resp->ret_code;
> +	ucsi->sync_val = le32_to_cpu(resp->ret_code);
>   	complete(&ucsi->write_ack);
>   }
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

