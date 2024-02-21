Return-Path: <linux-kernel+bounces-74128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3421785D042
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D9A284562
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3079F39FF2;
	Wed, 21 Feb 2024 06:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yC9ZYg11"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B881539FE4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708495916; cv=none; b=DCTc3FAC8RAohUHNH6KRjIlmqQlLsUzETtt9c4y3EU2sYS/oAfKATOrkO0uwS8OQ2tGG2LWMHwfVCHpZWsU+0XBp3U6rXhUbgYH2zmt/5MEhQXX4UHpV5ND/CaVXwXl9N0u0OGauraNHSwz64oeaG6ssfFHkuKrX3wDi6FuvZw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708495916; c=relaxed/simple;
	bh=2TAQVV25B3Mep0g8bVd1ctba4+Nb47hssI9JMLGlWw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IK2hBQmTW/BZfzilW1FcZY6W5jwscyfyyVSMPK3e0uVtWCZMHKFqJ4ffRr4AwcSC49PladzfGC29WFTEl4G5lyL836GIlRaic7S/h7okTZ+R2f6Ij8o8fzIIKbLJB+uAMgk2S622MQqqHpB1BzngBSRZXgtnp9Ej/QzWjG4vzyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yC9ZYg11; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-218eea4f1a7so2000317fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708495914; x=1709100714; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fL2zwEDwboBOluBoCe5ERhhpUpWk0xO78/TTkM69qsU=;
        b=yC9ZYg11G1iqQHNIfpM/Z7zOLx5oT9S+Vt63cIGDgkFUWBH0rWbVZqFqlJJisR1vIy
         gkmkhOdgs/WrmGZUk2R3zP4DV62bSRlFgYzaGAUcxjv1UZqrwQJ39RCbknPwcuF6G/Y1
         iTmttM/HCaV3kp05WoLhK5gPdwWs4mYS9g20hzxuL2LfkbcFrAdUkBJzLSj1Lt3ZICmS
         F7DBkJ1wBelM0AbK1chW9dmD5o7/UtLD4q6VxU8DYwMTeUvwSmsewzzMcynJxgVMfcGb
         ZWhpNzyVyI9z8T+vE1qopd2jmAqEB3JzP0h1jPlu+CE4vNDzx/cnscUVDf68h1SUyyWt
         gSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708495914; x=1709100714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fL2zwEDwboBOluBoCe5ERhhpUpWk0xO78/TTkM69qsU=;
        b=KNNGG0EmGcRuw86pP2qhS4/ed3fa5LpvlnMYxaXDaIOT0TECila/JFrJA+ffHsDIAa
         +cz6tzKdV+oD0xd9M+zm3G+QhI44bNF0kfnNV4UzdH8YfuGWY5QgIPcS5kOZJM4JqAZ7
         /D79Z/BYF8BBi83zNb+X5wv8KKqUKIbsAhShGOwd6zjATIYvlVnjgdEkg0oMj2Zsklsp
         KNi3yvwqoT9n5UwlKmnkjKU1St4r0Buh5QR867qcOpPkF8tfqDeyV0POG5Fybjp4I62K
         +dpD7zXUOjAZB8mzfxizC+I6GOl1vV01oNsmEvFKsvhfF+CraC1pDponODP0G/2OJl1d
         sgQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz7SFsQ6uVA9bavy/TtLU7k6Juwp8Dxf0yfUbudqxk51xl/50dDbLJtPq+ylIFxdJVmXi3569SVOi5Amq8k7LKYpS06/NgxnZQ+KmO
X-Gm-Message-State: AOJu0YwDtVn7t6+jE3XmCTHmFm6MyF+y2BwIGLJYn5XqOv+oxu1k71u8
	YA0IeYClURayxNmcI8Rasj+/cfF/G68Nqh+0GhJh2HqHsqpCGY1A2/NzHd7lFw==
X-Google-Smtp-Source: AGHT+IEXMreBXKcUfZWk6J8tb7zlxvS17xKsDFwi7Dxrk9YaZ/GcMzlIx9Pg4VQIy7bL/eGMHKNC3g==
X-Received: by 2002:a05:6870:ac1f:b0:21e:7ad8:dce8 with SMTP id kw31-20020a056870ac1f00b0021e7ad8dce8mr13146574oab.23.1708495913799;
        Tue, 20 Feb 2024 22:11:53 -0800 (PST)
Received: from thinkpad ([117.207.28.224])
        by smtp.gmail.com with ESMTPSA id g2-20020a636b02000000b005dc87f5dfcfsm7555975pgc.78.2024.02.20.22.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 22:11:53 -0800 (PST)
Date: Wed, 21 Feb 2024 11:41:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com,
	quic_skananth@quicinc.com, quic_parass@quicinc.com
Subject: Re: [PATCH] bus: mhi: host: Change the trace string for the
 userspace tools mapping
Message-ID: <20240221061146.GF11693@thinkpad>
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

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

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

