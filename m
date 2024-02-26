Return-Path: <linux-kernel+bounces-81298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 961598673BA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43311C25A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96CB1DA37;
	Mon, 26 Feb 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="htCSDjcg"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A074D1DA20
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947907; cv=none; b=QSzMlVuz5hoe+HpZRIZGjQm+gLhBnDjsv+xPoNJcOj+b55JQrHQj49YjKCIB0X2kTS631ezfeBeuUe09CTPvCMWzf9eWAL65r6G9b72/uhqqlqdRyUGiKqPUK9cLAbe5eY/EqJCR3LK8o3ELVLzhsdwOaX++nUi3kIq0Z/drqDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947907; c=relaxed/simple;
	bh=prNgVbePwRcKo0ldZvLmcT9NEprnyubS2n4dPuEAQS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8MP6XrEWLxG3/d91D/LR7GUjTyM05C5v5C+b3/KLWJz9Hg9TBy5J9Kn1Ya4sk1aRDdKWymeOqcGdhjgl5w8+boKvl80IddUnRDiPDfTw3K9HiktAYWI+LBiOaCIa23i7UbsXQRB0YZb7tsTUKQJHFQEoo2MgOQLCWCLhGY3EXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=htCSDjcg; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68facd7ea4bso7725036d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708947904; x=1709552704; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CSKU6X8Qwf8AFWfUlivJ0Qu0nT+8oAq4LKU9650PhEY=;
        b=htCSDjcgeWBxcIrFZFAJ7xcoOBhvWyUPFe8PIYRrjmJt1A8MQflEdaEB8PhWIGzuad
         8yXrRxSYPKZ6tPaDEhDOLigNAm+QZsrfDjqbH7CFrw1BTawmqHmB4NZuKGsQGvKTVinJ
         7fIAjW1SX3boe6A4YYTgXOnDMntBiJ2IoA+IzNrteHUZS/qoLGEcJI2SO9Ct/H1qV9Mh
         446lEj6RS5wKIylYSYSzxi2Lj9tUDUo5MELA4E1ahEAI6kQfs1NIbmZWPxp9rrWdiAIn
         ekmNn9hkvZDWbYsUGhespAYerJr8S9mk6rYteD7zrqk2s6f/MVsrvI0y/mxNoskxqxp6
         ulbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947904; x=1709552704;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSKU6X8Qwf8AFWfUlivJ0Qu0nT+8oAq4LKU9650PhEY=;
        b=e2Nz9TQmBV8Rv0Iho0BchMAJbDsCnDBurvUIturRmntRnnPuLWwHG7Cv2Rc+1NpPic
         Rkcj6Iq7ztmqWw5wLfGrmSfZ5DKBadJUzsRh6+Z1HKPT0kBoCeh8ju76VIet42/FOLzM
         j5J3h/E08qc0b00KTr+m5FHOQmLF45pwGVv2hsj4W99YPKUGEWb1QmLdD0wEnsYM39Xt
         qP+Xj1aRkMU/K7L43+YLgPvlolG8xu6gYFQcshqt4OKFxpz/rCnHlbDNeL1jh3xr784Q
         Dyl8fGkImLBIYPvnvaj18fqFq8vah9BvmwVa3PJ5M7r98MDLdbvBEkJtzww4xeeg7NOY
         XGCw==
X-Forwarded-Encrypted: i=1; AJvYcCU5mocUlW5+/ZFQ7ZninuyCtRqLJn2o2dvC1dfd5n+5N3FSFiYohAJ4hpycJwMjDbxHyFdYEXPrEQ9sRzYZmwEXBkknv1tEoM+Jc4qI
X-Gm-Message-State: AOJu0Yzupw4IiMRQBToCwQB3RiYYAcIzsMnc++q0mIr/xSWMbKiQReKL
	C2p6bzrwiIaQenDohn66xx+Qihm4BQr4Epwtl74QwuyZPBcaFeSGUdS3H/Rb0g==
X-Google-Smtp-Source: AGHT+IGpa5Q2fHBV5USsuqQLitp7DsDSNKdukrxekBdLBW00T7uhMM/LdUvMDcnQPH4wSebMQTN4JA==
X-Received: by 2002:a0c:f0d3:0:b0:68f:e821:ed43 with SMTP id d19-20020a0cf0d3000000b0068fe821ed43mr5600040qvl.42.1708947904574;
        Mon, 26 Feb 2024 03:45:04 -0800 (PST)
Received: from thinkpad ([117.202.184.81])
        by smtp.gmail.com with ESMTPSA id bd3-20020ad45683000000b0068fa52f5f7esm2811461qvb.7.2024.02.26.03.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:45:04 -0800 (PST)
Date: Mon, 26 Feb 2024 17:14:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH] bus: mhi: host: pci_generic: constify
 modem_telit_fn980_hw_v1_config
Message-ID: <20240226114459.GB8422@thinkpad>
References: <20240222-mhi-const-bus-mhi-host-pci_generic-v1-1-d4c9b0b0a7a5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222-mhi-const-bus-mhi-host-pci_generic-v1-1-d4c9b0b0a7a5@quicinc.com>

On Thu, Feb 22, 2024 at 06:00:23PM -0800, Jeff Johnson wrote:
> MHI expects the controller configs to be const, and all of the other ones
> in this file already are, so constify modem_telit_fn980_hw_v1_config.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/bus/mhi/host/pci_generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index cd6cd14b3d29..51639bfcfec7 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -538,7 +538,7 @@ static struct mhi_event_config mhi_telit_fn980_hw_v1_events[] = {
>  	MHI_EVENT_CONFIG_HW_DATA(2, 2048, 101)
>  };
>  
> -static struct mhi_controller_config modem_telit_fn980_hw_v1_config = {
> +static const struct mhi_controller_config modem_telit_fn980_hw_v1_config = {
>  	.max_channels = 128,
>  	.timeout_ms = 20000,
>  	.num_channels = ARRAY_SIZE(mhi_telit_fn980_hw_v1_channels),
> 
> ---
> base-commit: 3ab6aff5793c3c7bdf6535d9b0024544a4abbdd5
> change-id: 20240222-mhi-const-bus-mhi-host-pci_generic-5ddf8f13d35c
> 

-- 
மணிவண்ணன் சதாசிவம்

