Return-Path: <linux-kernel+bounces-75930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF87E85F0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A121F22994
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3342B12E40;
	Thu, 22 Feb 2024 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQLXTAfk"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6562F501
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708578993; cv=none; b=XTcmerWd6zPP3Q0j3QJPu/iTxqO94pE5uT4jmdZDopL+F9r97m7HO9wTVh0a8yAokXOKQX2qLs5BCUTRtXV/rlxKSINYAraiA/Zsz3qrBb8pvciAmEhqc4ZXNbZJedXgMniK/VAVfzRSIWc5KenrcBW10Vqg1oNNiT3LY3Md60o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708578993; c=relaxed/simple;
	bh=EYqco1GKfph2qvviCl2qwp3U+UCjcwLr0vJ5cMoQcXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJ0GEH0DoYN/UfPS+Fv3YXuA+9DDRdl7Wu5MfNDHzaa24WiXpJcY+dsUai/ALflCSb/8dTy7OoW+8OlucGGfm9G0tptRPlamEPLyRKHKav3FNKdEpXoVeO+skYDV+w+go2kLS050yc31f4ejj1YAiGecz3MNwpl5AoHb3knWo7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZQLXTAfk; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so6093854a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708578990; x=1709183790; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=duIZxpvn6RingjjUFfVcxJVtZ2NkUSkNaC91pQVkegY=;
        b=ZQLXTAfk0RvwuVmUULKeLpNK72O3zrBu5wE1qw3+2yR0JULUCbtWv8gI7vM34cq7BB
         cxvlDNdpDt6w25riE3cK4aDqefh9ZoXIyIeU53K6P5ZKdsCBarecrUKVTeDMdaw2ff5U
         tJe+UitS43xJ7zxgUQb8mQw4qtwPfr30WQCa3nXG2l4319NT6yG1FQ6EiJHXK9w8VKBj
         WAfg5BMAdkMj6RH6NYBUIfTbHXTHchQkgOrjdUVHB8psQbEMG4lAfKJO6hQ13iidhH5G
         oBwKYoVQFI8W1mAnM6j4t2Wo6/5g0uYPXnBnWBuXLby53HGl2R+es0dMmf4tvLRKSq9k
         trTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708578990; x=1709183790;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=duIZxpvn6RingjjUFfVcxJVtZ2NkUSkNaC91pQVkegY=;
        b=EkIGNSEr+FzxUda5TJucCpcfVu4Q6FpGvqweNxXWXPtCuTPIwgg2S1EvfvDzh1Xyz9
         kM5zRfPg2isaqrx0Jgoj4CrJBk7Vgx4mBQzFYfN+MsczArGvqBVmABdVutvbau/t5aJQ
         wxJ6Z326Tv+/lh93ccQxaFyJsdORYUBS18jYVBHTEsEV9FYilhZykQ64LvpR01g9Q89B
         IouBfhuK/JRd2+ynjhyzQ5YJNQk4KTVGmFw0rVlswAGwskilzM/PxV332A0e4xcb/wR6
         TfKmduArucikLJPxtetL+4sEjFs8nf64c9GEpXzwuwsZaVQLDOaKPBzXi431an+HZL9G
         sHOA==
X-Forwarded-Encrypted: i=1; AJvYcCVWQkCO8p7xLeB+c8PtIg4F8Q8eooXPmm6aAcwWjlsa2Iw6S5ChoW7EMuF/ADw3/6u1df/ErQRhq2Kc+a9j59+bS57cK5RZ1dgUv5Xw
X-Gm-Message-State: AOJu0YzaINUSxVRL4EOJRBJW/I02Umyb3KAUp1JmBeP5JLA5Yrh4IbN8
	poAokz5AxHB5SUf+r9KvOR/8QQJPg7BjGRxHvrbM+jYMJRKqpaDWzb5yYs3nPg==
X-Google-Smtp-Source: AGHT+IF1BbQ0EnZKJMj1ATUyc9q4gcsnLCvpFzHDOMbytY3INdyz3p1P9lC6mFjFGyQVSpe1j4yvSg==
X-Received: by 2002:a05:6a21:1693:b0:19e:b6e0:8d26 with SMTP id np19-20020a056a21169300b0019eb6e08d26mr19510388pzb.15.1708578990015;
        Wed, 21 Feb 2024 21:16:30 -0800 (PST)
Received: from thinkpad ([117.193.212.166])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902bd0b00b001dc35e04b02sm1933206pls.32.2024.02.21.21.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 21:16:29 -0800 (PST)
Date: Thu, 22 Feb 2024 10:46:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com,
	quic_skananth@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH] bus: mhi: host: Change the trace string for the
 userspace tools mapping
Message-ID: <20240222051621.GD3374@thinkpad>
References: <20240218-ftrace_string-v1-1-27da85c1f844@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240218-ftrace_string-v1-1-27da85c1f844@quicinc.com>

On Sun, Feb 18, 2024 at 02:13:39PM +0530, Krishna chaitanya chundru wrote:
> User space tools can't map strings if we use directly, as the string
> address is internal to kernel.
> 
> So add trace point strings for the user space tools to map strings
> properly.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Applied to mhi-next!

- Mani

> ---
>  drivers/bus/mhi/host/main.c  | 4 ++--
>  drivers/bus/mhi/host/trace.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index 2d38f6005da6..15d657af9b5b 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -1340,7 +1340,7 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
>  	enum mhi_cmd_type cmd = MHI_CMD_NOP;
>  	int ret;
>  
> -	trace_mhi_channel_command_start(mhi_cntrl, mhi_chan, to_state, "Updating");
> +	trace_mhi_channel_command_start(mhi_cntrl, mhi_chan, to_state, TPS("Updating"));
>  	switch (to_state) {
>  	case MHI_CH_STATE_TYPE_RESET:
>  		write_lock_irq(&mhi_chan->lock);
> @@ -1407,7 +1407,7 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
>  		write_unlock_irq(&mhi_chan->lock);
>  	}
>  
> -	trace_mhi_channel_command_end(mhi_cntrl, mhi_chan, to_state, "Updated");
> +	trace_mhi_channel_command_end(mhi_cntrl, mhi_chan, to_state, TPS("Updated"));
>  exit_channel_update:
>  	mhi_cntrl->runtime_put(mhi_cntrl);
>  	mhi_device_put(mhi_cntrl->mhi_dev);
> diff --git a/drivers/bus/mhi/host/trace.h b/drivers/bus/mhi/host/trace.h
> index d12a98d44272..368515dcb22d 100644
> --- a/drivers/bus/mhi/host/trace.h
> +++ b/drivers/bus/mhi/host/trace.h
> @@ -84,6 +84,8 @@ DEV_ST_TRANSITION_LIST
>  #define dev_st_trans(a, b)		{ DEV_ST_TRANSITION_##a, b },
>  #define dev_st_trans_end(a, b)		{ DEV_ST_TRANSITION_##a, b }
>  
> +#define TPS(x)	tracepoint_string(x)
> +
>  TRACE_EVENT(mhi_gen_tre,
>  
>  	TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
> 
> ---
> base-commit: ceeb64f41fe6a1eb9fc56d583983a81f8f3dd058
> change-id: 20240218-ftrace_string-7677762aa63c
> 
> Best regards,
> -- 
> Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 

-- 
மணிவண்ணன் சதாசிவம்

