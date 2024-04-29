Return-Path: <linux-kernel+bounces-162136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A08B5682
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A89E2843E9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347D04174A;
	Mon, 29 Apr 2024 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UiTg6Pfl"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16CE3FBBD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390015; cv=none; b=lfxsGmfC0bY8CuxEQ8ySIvor9zcvUs79m3PnZYOHqF5v36yla+1nDmjuEtfG4p5bepl0feEaUnJpy5i0jZnIih9PoZ0xRb9xr09k69oM68GVGv67637nx3R4t1CoQpk/5Aku9SGS6d2N1BZQGbho3lHQFoyV5tPMHrxY5kRBSq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390015; c=relaxed/simple;
	bh=3vn/fi/i6sQ9Va1NbbM7YvYj+Lt8pEeMyM3DF6Y9eNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVR9I3LNiDdaw5O7j7Q0RL47o8/+wAT8VGm1WfWkvM4G2aN1anCkrmc0qIZn13rWXFSZCMim0Jk+Si5/unjbQpy69Qt3sr6kdjLnmt6TYu1xSTdFwbX5+k8vkKt6rw+yc2GknL8K2rhj08n7juq8zE3ACJHQqpUM7txcu0cMmew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UiTg6Pfl; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5171a529224so5451590e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714390012; x=1714994812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=39YugN0AhrsG0ayBC0/e4hmLkEBwLSeUr7AqXUnVb0I=;
        b=UiTg6PflnDnmh4E7QGt/TyieAN/Rp2W3P6QU2tsHmcqyVXGgwoEa/hA9GgFIbbTtv5
         IOIwfj2L8VkWI3cudpQcoFpA7Pg4k8MBjDYD4m8GNJFQykQuHT6KtnliwMK8y+yWpEXP
         m64sQoNYKegqxuh8vECvoqUCRpaTEMC+j5N366bbVmEZfK6voleQOH8HO6Drx977MnWI
         s1Tnp09j2AJUmkOIgnSgAROrdqyAiUN4HMXltX15MZgkS+YkHPHLpbinvRJ5v+BahhA/
         +vkCZV/B5l4IaLPl+3HSqNMbgoupH2jfexj2E0O+19OqUxrxFtRrCrQSHMTdVUv0nw4V
         NDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714390012; x=1714994812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39YugN0AhrsG0ayBC0/e4hmLkEBwLSeUr7AqXUnVb0I=;
        b=eX3aKL1t7K1cS8XmKOT7zP92S3tUS/khFUakgoIUX6nRPMEjFhRBfgr2swL/csxFk/
         djHpezDH7dTs2KHGNvU8ePyOgVqud+8RlBAD/5jv7RQ19RILEHoDFG727A8AbLxq3mNV
         f3ISiPOv6jpshsLD7e1ZGYJ15YGmp6J9EOLT+yR0FR9fapWqIw5ioZx0KKwwalXS4wK6
         0DbsQFhZa2Slz7GAOcb3IcgEJa5VmsV2hrISFBLCzPVIYc7loJvSkssE16yJHVtSvKFl
         fPi7d+4f9Bh7GNbWBoEvDj7qFFghg+gdma/WPzZ24NGbL5GAd7Wrv13P2oUqCRiUEPaw
         1o3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlgL23X6qH6WFj5yLE01ucsudillJnYe1n2T04WOXRo95F7Dc5P9KYuoEPFSflESQhHuDEDdw27sMVOD8Rb498fYz6xN51BR68U2Gq
X-Gm-Message-State: AOJu0YyX00/Gf5EJz9A2tK2Ch/idT87/tHE27X9yNOXDGB6538HBsoDc
	tXJnJivK86tQfUyrXl+AjLB9ki5mcaCZJSy93bSWACL8toLhgCXLLmzqrFPGujrMoDhdi8WZXo0
	F
X-Google-Smtp-Source: AGHT+IFI3AluHhwTJpLYWZ4GiTLUyfPyto/m6pblcfEQZH7t+wQn7drSS1yqlWjP1qRAQv31+di14Q==
X-Received: by 2002:a05:6512:2393:b0:518:ddc3:b3a8 with SMTP id c19-20020a056512239300b00518ddc3b3a8mr7874643lfv.61.1714390011890;
        Mon, 29 Apr 2024 04:26:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id i10-20020a056512318a00b005159707b939sm4064914lfe.44.2024.04.29.04.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:26:51 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:26:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: gregkh@linuxfoundation.org, linux@roeck-us.net, 
	heikki.krogerus@linux.intel.com, kyletso@google.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rdbabiera@google.com, amitsd@google.com, stable@vger.kernel.org, 
	frank.wang@rock-chips.com, broonie@kernel.org
Subject: Re: [PATCH v3] usb: typec: tcpm: Check for port partner validity
 before consuming it
Message-ID: <sfy7bt7ygmjt2qvs2auxpz63rrvampj3vjyakt7rs77asnhqka@jsymy45qvbxb>
References: <20240427202812.3435268-1-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427202812.3435268-1-badhri@google.com>

On Sat, Apr 27, 2024 at 08:28:12PM +0000, Badhri Jagan Sridharan wrote:
> typec_register_partner() does not guarantee partner registration
> to always succeed. In the event of failure, port->partner is set
> to the error value or NULL. Given that port->partner validity is
> not checked, this results in the following crash:
> 
> Unable to handle kernel NULL pointer dereference at virtual address xx
>  pc : run_state_machine+0x1bc8/0x1c08
>  lr : run_state_machine+0x1b90/0x1c08
> ..
>  Call trace:
>    run_state_machine+0x1bc8/0x1c08
>    tcpm_state_machine_work+0x94/0xe4
>    kthread_worker_fn+0x118/0x328
>    kthread+0x1d0/0x23c
>    ret_from_fork+0x10/0x20
> 
> To prevent the crash, check for port->partner validity before
> derefencing it in all the call sites.
> 
> Cc: stable@vger.kernel.org
> Fixes: c97cd0b4b54e ("usb: typec: tcpm: set initial svdm version based on pd revision")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

