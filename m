Return-Path: <linux-kernel+bounces-4410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30371817CA7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8110928239B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CFB74E02;
	Mon, 18 Dec 2023 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZDgE19eU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32E1740A2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cb21afa6c1so51094711fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702935209; x=1703540009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HhtQ4/swFAAhvY0/S4bZ35rOfbKjnZrhXJFZl40TyLU=;
        b=ZDgE19eU8CqmZVjWgC/QBw73f1L8Jpi/dEfSbtqu+IN6e6H1A/3IYtITucU5l8aPSt
         hqjrPaKTYOIexFkdth8dCaActayFVn0nuQt+Bbqp7/I/wvcM3Rzq8m1jLuzCepeWAkZc
         vvF3gwhR00u/ndJIA3Xx4poWUfNw2IWrxmzr4kYP6RzkD0xwEnR/C2TE/A/7rm65dPzt
         zh0FQEx2rMDURb5v1LO2JtDAS1fSp6ZVOhV9ixk1b5GO3e7e33Cp+4GZLej+7yU8nToO
         gtNJM5f/WrbbCGnZ7LdbALbd4P4z4nQRNuNZM9ftpFI6DwRMauk2mpDycgllmcc6EnKC
         K3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702935209; x=1703540009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhtQ4/swFAAhvY0/S4bZ35rOfbKjnZrhXJFZl40TyLU=;
        b=WY5ElYa6qrfINWB/V4MkHpTS5jJD0TTC5xQU7fV1soaTGgcmIBiphedbDTCs3OU6rT
         N+a+h4USxt7vXZN+BFugwwIokx5gC4HF5t9datQKYsShOCG4VzB5nUlVLK2k1+dAdymX
         5PhNa2wgPoYDqUTVmFlqMkT0G4SaQmfRP6HQC41vCmJVVmtKhF7JRmwP9OYrcoNn3nm1
         BMwrLVBQ2nNCVpfGVcachJF/qAgTHZDEqSfU/Y6ZxsPeAActShGk5PIsH9cjz1oNmI+r
         hKEltDbRD9mlgZiorZ07C/+YFOmsJbuF2VdxFdRCBP006JHEvbZdijF4wWReNMy1M0ig
         +Jmw==
X-Gm-Message-State: AOJu0YxlVk3rtTrBXM8R63JgydzJsivJgJSx8wn5392311Tq5jiuNhqN
	GjC4z3lciKf7czRWgd4NOxtKkA==
X-Google-Smtp-Source: AGHT+IHzDhaGl5qdWTrWBYnsWxMtQwCMHQDcexz4NcamhE1koD41N+tENsnkeiqpZ5wa4nyRDz2PLg==
X-Received: by 2002:a2e:a54f:0:b0:2cc:2fcc:c589 with SMTP id e15-20020a2ea54f000000b002cc2fccc589mr6267824ljn.34.1702935208834;
        Mon, 18 Dec 2023 13:33:28 -0800 (PST)
Received: from [172.30.205.119] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id w22-20020a2e9bd6000000b002cc710614besm507393ljj.0.2023.12.18.13.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 13:33:28 -0800 (PST)
Message-ID: <7b3674ce-e372-44e4-adda-8af78e2a9053@linaro.org>
Date: Mon, 18 Dec 2023 22:33:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/34] media: iris: initialize shared queues for host
 and firmware communication
Content-Language: en-US
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com, agross@kernel.org,
 andersson@kernel.org, mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-10-git-send-email-quic_dikshita@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1702899149-21321-10-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/18/23 12:32, Dikshita Agarwal wrote:
> Shared queues are used for communication between driver and firmware.
> There are 3 types of queues:
> Command queue - driver to write any command to firmware.
> Message queue - firmware to send any response to driver.
> Debug queue - firmware to write debug message.
> 
> Above queues are initialized and configured to firmware during probe.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
[...]

> +	ret = hfi_queue_init(core->dev, &core->iface_q_table, &core->sfr,
> +			     &core->command_queue, &core->message_queue,
> +			     &core->debug_queue, core);
> +	if (ret) {
> +		dev_err_probe(core->dev, ret,
> +			      "%s: interface queues init failed\n", __func__);
> +		goto err_vdev_unreg;
> +	}
> +
>   	return ret;
Like before, you're suppose to return dev_err_probe

Konrad

