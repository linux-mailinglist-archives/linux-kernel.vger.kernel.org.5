Return-Path: <linux-kernel+bounces-123596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29177890B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89741B21A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C03F139D13;
	Thu, 28 Mar 2024 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBgEDQy7"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC40413A418
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658350; cv=none; b=ClPyG8YrJrPhgpCMgXkoqsZjUdsC5C3hSpQ+min5mh8is1aDhgdEwN8X+TzFxyOk9WqGq9j9EtDpxMCu4sPkyoRBFIBbDzuZ2C9Ka8JGNyW3FaYoEnNxh038tXtJo79FnbmZZ9ADLnxOsrrK6NWoVBsAJfdSG9jq4cNsqFZHp18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658350; c=relaxed/simple;
	bh=c76w6ANOZw/3hvDVKikFOR104FP3uq0xGTMZX9yqf8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NA+x4qZ5p0qsqeejsbQqcTJ7qn9KXT/bwOCWJ8RFA2o7TERrmPKrpFCfqiiyv/cy92a2kwYMNlXTOpUJ+XF05NOWDTnxjd2v2lP+Z2ZljkMI6+BMVyL9MkrFWdJrd4JAdl9dgQYC/ZK0oREsdpdJBLBWIa+4ORFqKOdbTQvCvUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WBgEDQy7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a450bedffdfso163188266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711658347; x=1712263147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vXXOSZfz8O5OKgyE9PyGnB12GSSexqRiRe1MSPJ2Dvs=;
        b=WBgEDQy7jidLSUfSCwFur8lXCW6mFyw0ulkGHuki29/26T/2wHrX6X0Bjgh2Bkw83+
         Bmc/hIjvy0KLSttN3MLGxbM8+YA8Tc35p6aYG/9ADdu9TxPPV8ir23EKvL3FQgU9hVqE
         I3oB0dPHhag3EjamTZPjCVnq9AAsCP/gSa84RxZMBiM0qzESuug1q5r1YkII7peSkYqM
         dqCGjF5IqkTvqbz+937bJICfienaLYlEVGxCVxKN9QEeQ3lh+aWNi1tvM5ZOj+B85bUQ
         yCTqq0et3426MtSKEaiCPltTPzpjwAmlldOh5CXtex73ZqPz+gQAbE/S00snahLvCuiL
         jT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658347; x=1712263147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXXOSZfz8O5OKgyE9PyGnB12GSSexqRiRe1MSPJ2Dvs=;
        b=BKewio+8fofoW6KO5X022MUlCI2YAzoQSadlvDnJyuxkG0Du+oou3ex1Qj08ATinh9
         xfAzNENV/ZsThwJ4lg+AI+9Ferav3Sl0FQJUv0s+rSibH+Yn+qKB/WxcEqonJ+YonI+X
         7QywgpPyHnnUj4fMR5ORjqgRapH9RQm1ooywokbLvf21JFIkRYNGCXgcHiE5i1nxFSqz
         tE6e7fTjr3m0WFwVAHgqPY5N1PQ70T4Dkmqi5G0qTJM8YGatCX+u/drLzGFD5l0KWA2a
         QfsKrw9MYE/HcjTTtoSH3IBaKiD2WAKPO7CWZv6saiVZhUa6r5yjm6xsoSzL81qInGCG
         C6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/4dZ0E/U0TuwTJWUnVQsXcPYu4DRBznS27RpZQrIYEc+Dp2wTni57Y/2t0LBB8sGIqDDcmXeZVYjoA8R/PSAOx+0bZauk5tfN9y++
X-Gm-Message-State: AOJu0YxT4IHkES09cWfnx+DCxPm/Aj7oMIyViYwoUaowI+/s7Zf2LOe1
	Xn5DxilndC7NJ/MM1Qpa8gQxTzidliqqEr1VEZGvVbuZqnlneLUzvGRpeDhQkMiIssGxbfs2YTL
	M
X-Google-Smtp-Source: AGHT+IEfI6/ElqbxX011QI3EBz6Tqo72909UkKh+kFTHngulAL02ypmJA9aR2eFcAe+MhiuYzBH3uw==
X-Received: by 2002:a17:906:2654:b0:a4d:d356:fd69 with SMTP id i20-20020a170906265400b00a4dd356fd69mr219001ejc.12.1711658346886;
        Thu, 28 Mar 2024 13:39:06 -0700 (PDT)
Received: from linaro.org ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id mf9-20020a170906cb8900b00a46faaf7427sm1133467ejb.121.2024.03.28.13.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:39:06 -0700 (PDT)
Date: Thu, 28 Mar 2024 22:39:04 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, robdclark@gmail.com, sean@poorly.run,
	swboyd@chromium.org, dianders@chromium.org, vkoul@kernel.org,
	daniel@ffwll.ch, airlied@gmail.com, agross@kernel.org,
	dmitry.baryshkov@linaro.org, andersson@kernel.org,
	quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
	quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
	freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/msm/dp: assign correct DP controller ID to
 interface table
Message-ID: <ZgXVaA6mbbUbVR0p@linaro.org>
References: <1711656246-3483-1-git-send-email-quic_khsieh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711656246-3483-1-git-send-email-quic_khsieh@quicinc.com>

On 24-03-28 13:04:05, Kuogee Hsieh wrote:
> At current x1e80100 interface table, interface #3 is wrongly
> connected to DP controller #0 and interface #4 wrongly connected
> to DP controller #2. Fix this problem by connect Interface #3 to
> DP controller #0 and interface #4 connect to DP controller #1.
> Also add interface #6, #7 and #8 connections to DP controller to
> complete x1e80100 interface table.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

Nitpick: Probably mention the x1e80100 in the subject line somehow.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

>  .../drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h   | 34 ++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
> index 9a9f709..a3e60ac 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h
> @@ -324,6 +324,7 @@ static const struct dpu_wb_cfg x1e80100_wb[] = {
>  	},
>  };
>  
> +/* TODO: INTF 3, 8 and 7 are used for MST, marked as INTF_NONE for now */
>  static const struct dpu_intf_cfg x1e80100_intf[] = {
>  	{
>  		.name = "intf_0", .id = INTF_0,
> @@ -358,8 +359,8 @@ static const struct dpu_intf_cfg x1e80100_intf[] = {
>  		.name = "intf_3", .id = INTF_3,
>  		.base = 0x37000, .len = 0x280,
>  		.features = INTF_SC7280_MASK,
> -		.type = INTF_DP,
> -		.controller_id = MSM_DP_CONTROLLER_1,
> +		.type = INTF_NONE,
> +		.controller_id = MSM_DP_CONTROLLER_0,	/* pair with intf_0 for DP MST */
>  		.prog_fetch_lines_worst_case = 24,
>  		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 30),
>  		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 31),
> @@ -368,7 +369,7 @@ static const struct dpu_intf_cfg x1e80100_intf[] = {
>  		.base = 0x38000, .len = 0x280,
>  		.features = INTF_SC7280_MASK,
>  		.type = INTF_DP,
> -		.controller_id = MSM_DP_CONTROLLER_2,
> +		.controller_id = MSM_DP_CONTROLLER_1,
>  		.prog_fetch_lines_worst_case = 24,
>  		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 20),
>  		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 21),
> @@ -381,6 +382,33 @@ static const struct dpu_intf_cfg x1e80100_intf[] = {
>  		.prog_fetch_lines_worst_case = 24,
>  		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 22),
>  		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 23),
> +	}, {
> +		.name = "intf_6", .id = INTF_6,
> +		.base = 0x3A000, .len = 0x280,
> +		.features = INTF_SC7280_MASK,
> +		.type = INTF_DP,
> +		.controller_id = MSM_DP_CONTROLLER_2,
> +		.prog_fetch_lines_worst_case = 24,
> +		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 17),
> +		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 16),
> +	}, {
> +		.name = "intf_7", .id = INTF_7,
> +		.base = 0x3b000, .len = 0x280,
> +		.features = INTF_SC7280_MASK,
> +		.type = INTF_NONE,
> +		.controller_id = MSM_DP_CONTROLLER_2,	/* pair with intf_6 for DP MST */
> +		.prog_fetch_lines_worst_case = 24,
> +		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 18),
> +		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 19),
> +	}, {
> +		.name = "intf_8", .id = INTF_8,
> +		.base = 0x3c000, .len = 0x280,
> +		.features = INTF_SC7280_MASK,
> +		.type = INTF_NONE,
> +		.controller_id = MSM_DP_CONTROLLER_1,	/* pair with intf_4 for DP MST */
> +		.prog_fetch_lines_worst_case = 24,
> +		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12),
> +		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13),
>  	},
>  };
>  
> -- 
> 2.7.4
> 

