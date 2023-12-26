Return-Path: <linux-kernel+bounces-11380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84BA81E562
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22E1FB211E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1264BA80;
	Tue, 26 Dec 2023 05:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BpNWEsBX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDF94BAAF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 05:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-58dd3528497so2453578eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 21:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703570379; x=1704175179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RYU5XBHw7RO5kr9ESuLQkgv8rIFLgju8O+JeKWuCuic=;
        b=BpNWEsBXX+Jbt2IS7r5HqNOBJdCZCJrV7aTitpjwXg9Wq2Jkj9VhJBYVRaqGdI5yrh
         WgtlGueqyZzfqttw82UhQSsSIGf8CB3nntybAdsKm87+Y4cdgssSOSqR5xFmraFpRWWB
         lxWwyinMcnIVeifmpBoqO9TBcUgewCW4Q87wRpEGbw1bzwVgZ1qklN0Zh7jP5FR9tsIE
         tGAzeXZhLV5/wfIRkTp9razxUaHje+Oytxl1ZSnl1QcQYKSnQUTQWk/bjkiL3wB9nDC7
         fLPjkuIBpMrDpXWn9tuk5H/XZXUCB9QLMcYYUGhOREgfpKlQD3U4nsMBvTKEX+2OUiEy
         AtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703570379; x=1704175179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYU5XBHw7RO5kr9ESuLQkgv8rIFLgju8O+JeKWuCuic=;
        b=PzjlqVjgyU+0/3YvJF+kevCdnJUV5qOpBn/qZs+Wln2ZJaDvj5nyH7zWZCHP0RawEX
         uQ7IJ2TDncfMU2w+AjbwW/sX+BHQCZHiTqils+kwe8oQjzkJAuVw7TPQ+CR7pzOQzFmZ
         r29CUwYg6vAq3+/U1eI9I/A0IDcMQV1BWthKs+oECdgCeGBZndgZ0tu1TwNpG0mlvyhg
         ebDDYaoQxEnjLcyyeBgNtpecTaJCOl2lqB9+UrEajYOqVSHDhu7iW7ZtEb4vhKXhqsTZ
         Fr7OwS3IeSJmnE1hvWuK9MrVotHGcxoa0eGAcDHEVnB3p+A1hQCNkO729MxBNwC2S80I
         sL/Q==
X-Gm-Message-State: AOJu0YyJLO+D2k7wmm43QSLnEIQFhrQAQ+/4KWK6m5PrbZeB0bj6/emv
	o8CS/mnklyCAT5EtQK6j44sa2GkBAtXjkA==
X-Google-Smtp-Source: AGHT+IHu5AN3U6iQc8bla5r9958cIygPCgNt7i6q1mT/HntRr6jX+TxIxuLIpaqJqfqE1l7qOA+VZQ==
X-Received: by 2002:a05:6808:2226:b0:3b9:df4a:978b with SMTP id bd38-20020a056808222600b003b9df4a978bmr7675727oib.82.1703570379414;
        Mon, 25 Dec 2023 21:59:39 -0800 (PST)
Received: from localhost ([122.172.86.168])
        by smtp.gmail.com with ESMTPSA id qc12-20020a17090b288c00b0028b6f522fedsm13518526pjb.43.2023.12.25.21.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 21:59:38 -0800 (PST)
Date: Tue, 26 Dec 2023 11:29:36 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, ulf.hansson@linaro.org,
	stephan.gerhold@kernkonzept.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OPP: Fix _set_required_opps when opp is NULL
Message-ID: <20231226055936.pzyt4xjzlfhfqb4y@vireshk-i7>
References: <20231223023421.3818297-1-bryan.odonoghue@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223023421.3818297-1-bryan.odonoghue@linaro.org>

On 23-12-23, 02:34, Bryan O'Donoghue wrote:
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index c022d548067d7..182e07ab6baf3 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1083,7 +1083,11 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
>  
>  	while (index != target) {
>  		if (devs[index]) {
> -			ret = dev_pm_opp_set_opp(devs[index], opp->required_opps[index]);
> +			if (opp)
> +				ret = dev_pm_opp_set_opp(devs[index], opp->required_opps[index]);
> +			else
> +				ret = dev_pm_domain_set_performance_state(devs[index], 0);
> +
>  			if (ret)
>  				return ret;
>  		}

Sorry about that, my mistake. Can you test below instead please ?

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c022d548067d..c4d695e0e5fd 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1061,6 +1061,7 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
                              struct dev_pm_opp *opp, bool up)
 {
        struct device **devs = opp_table->required_devs;
+       struct dev_pm_opp *required_opp;
        int index, target, delta, ret;

        if (!devs)
@@ -1083,7 +1084,9 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,

        while (index != target) {
                if (devs[index]) {
-                       ret = dev_pm_opp_set_opp(devs[index], opp->required_opps[index]);
+                       required_opp = opp ? opp->required_opps[index] : NULL;
+
+                       ret = dev_pm_opp_set_opp(devs[index], required_opp);
                        if (ret)
                                return ret;
                }

-- 
viresh

