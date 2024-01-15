Return-Path: <linux-kernel+bounces-25707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4740982D4D7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDEC4B207E5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95A65666;
	Mon, 15 Jan 2024 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzijKyTc"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BA85233
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-336dcebcdb9so7902483f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 00:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705305693; x=1705910493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I/aE5YgSwZvRxpVfNEI0v5SWIFUTsbI7X+o9Mrjo03s=;
        b=GzijKyTcMlw+AH1VQa4jYCyWCAw8lhvj1ADnIovIVHG9QlX6m+vxLwI1+rcHCDr242
         5qUdJCAb3nfPUi/RqzfJxHSIExEB9iZFjweaYByq1onS5b7VqUnn3TeTb3q71VMFfulh
         zWb/oAxq50/JidV/WHfH4JfqLiHG1m80YEl6ym4awts3iSRalk24vvU2RI1rXornC7ZE
         qD/Ja3yXeIYNCEkDWwZ70bj9yNYXW42n6tFhP0nyHyfXEG1YTK349uhXltNzBFD3h0oZ
         rA8gDoA68zxPxbfa8+rncds5o/cMIWo6nfipvRWAOYp3QVSt0jUd0dfTaBxGPknMS1Bl
         Gbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705305693; x=1705910493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/aE5YgSwZvRxpVfNEI0v5SWIFUTsbI7X+o9Mrjo03s=;
        b=EtUFb9cgsAQqq75UlzFCAbUStMnfT1QiHVUe8YvMh/FuOezUsezJ9oZYMXr2cwQz/9
         EuA98yNLqGNt+SDqr8GEqtkW35mh50latXW9pIbKwagLjYNGcQsResAFMFlZPZ04kjp9
         lshSVAEfNCFUN9eQLOj9mjfA2r4LZBLbGJiHBAKMFLCMlct9qVpKxKPux9OAZ9W5y4DA
         ADtyqzmkJfN03cdJ+2B5LhrbLDh8/JQ0DAXD9/mUwA4oThuBgOKYGSiaDTsgq3/EU8WI
         eCblqjG4eoBaAbXVNwqhf6Qt3RHpDJaCy/Ou81t349pgSS+ZBNtzZTckmq4S4dzk7Ucs
         VQCg==
X-Gm-Message-State: AOJu0YzPBoss/3VwWOHEHMiDJ+CCKYfbQcELL5SyCZr9y9sT5zRee9qC
	UFdGDzHZtODM+9GhecxDfMAefO644NGQ8Jq2RtlFmBMRcCU=
X-Google-Smtp-Source: AGHT+IHRBYCALoZlXWdYDqozlX5c1sfq0QbOuoCaTO6X2o64cTganWJbbuW3QhU6P0q3+XQnYu+NuQ==
X-Received: by 2002:a05:600c:378f:b0:40e:5f61:56e3 with SMTP id o15-20020a05600c378f00b0040e5f6156e3mr1572573wmr.47.1705305692978;
        Mon, 15 Jan 2024 00:01:32 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id q28-20020adfab1c000000b003372b8ab19asm11199087wrc.64.2024.01.15.00.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 00:01:32 -0800 (PST)
Date: Mon, 15 Jan 2024 11:01:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Meir Elisha <meir6264@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs: rtw_ieee80211: Remove extra space
Message-ID: <15008951-9c0d-4bf8-8bc6-a639a6726105@moroto.mountain>
References: <20240115075425.108134-1-meir6264@Gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115075425.108134-1-meir6264@Gmail.com>

On Mon, Jan 15, 2024 at 09:54:25AM +0200, Meir Elisha wrote:
> Fix checkpatch warning: please, no space before tabs
> 
> Signed-off-by: Meir Elisha <meir6264@Gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> index 30e7457a9c31..cfa994835008 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
> @@ -1036,7 +1036,7 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
>  	struct HT_info_element *pht_info = NULL;
>  	struct ieee80211_ht_cap *pht_cap = NULL;
>  	unsigned int		len;
                    ^^^^^^^^^^^
How about we delete these as well.

> -	unsigned char 	*p;
> +	unsigned char *p;
>  	__le16 le_cap;

regards,
dan carpenter


