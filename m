Return-Path: <linux-kernel+bounces-139233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217B78A0031
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B50B1F2808C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1801802DD;
	Wed, 10 Apr 2024 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Keu3+nEQ"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB8E1802C3;
	Wed, 10 Apr 2024 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775518; cv=none; b=mFcy3bL4tBIPbcW48Z68qtb+V+3vkpxAv8XHnrlX2Jo0kpsm8zKLBJEQMCn1NXqvwrzNMO8/8uCE5UxKZyE6G1BGx1+ucrxlbdD4op7EVu6FP3LvE5BZYIQI0tot/+bXvt7syYNJ+PCL+suV6YL06XJqE3jBG2v99ercDHcS9NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775518; c=relaxed/simple;
	bh=lh2gm0kHeYgCJ8cQXm65KiV9dBGvDMtnxA7aJBAbQW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzGokY+t2mMozp2p3IjsQElMbYi6RJUNtpjuv+tOZjpT38037w1L7LO6PaV8BDEk2ISjRWPXOg0ILi9BX2yN5A1A57eaGaSV5ZUZIyh1lq0HtRc0IH5oZB6Uc1LtKR97x2e+nu9yKioV9vGNeEQVDKewDTgT3lsYo62WIjCCJLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Keu3+nEQ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-346a7841713so102025f8f.0;
        Wed, 10 Apr 2024 11:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712775515; x=1713380315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VfjXX6/HzDFyrzenYHCjHv4rR+msuREnAg9dECeqgyE=;
        b=Keu3+nEQl5+VXwzo82wLSZuIekfwzQTvoy+gwNEXTvTAhnw8aoHr5jmA6wcZkVd19V
         b72AOsdRAy+Nc6ajwfL3EDg/mLnzutOphOqVfHob8RUcC8KOlgqdppbvtdxjFzwIuXQE
         aNRu2lHMEVvede+NyeMtLQgK4IfG6Bn+c7dpTRGBxNjJKHvhshsqDtpSZVxL9jHuiW6T
         uUt8/ltmYdpI7nVivaVo4HYA4BNPWjwh83Lv3BaSW/fvk1PGoMqA4efMXlo2/aOTKNHk
         E6UCVgHZSRow35eiLT84y2xEv9UYCCZY5oxmsbrLKn/I/1ymr9SJnueX9KkcJlOrZ4UU
         qTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712775515; x=1713380315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfjXX6/HzDFyrzenYHCjHv4rR+msuREnAg9dECeqgyE=;
        b=sgnDML9pL3v4EOzBsHhJbX5bwRlXgExFdMxPlPWoymRfFhVAmG9pdwSKA2O+ELRfjH
         7gQPKMbRd8beB59vlwszV5087ET6EKfSC7WQfiLNJzBh13IX7rOHyq2CChuxgoKe3JQA
         gTTuzMDjK/jLAl4hNihdZ2GIAgs/YLyUeTojufQU1qPSyG/Td3yav49gLzYnHPLUgQKJ
         gsslngY6da1q+RZAGzCNRJ5RawneiVNdpWT0CtBZq5WivQbpBuPStvCMoUfbMvbkGL49
         sHxwJZO7zex9ae6R6wjj/ISVPyGc3KleOZpJxEFcrVz5pUsADb/tZSUepuWXjDQXx49r
         zoug==
X-Forwarded-Encrypted: i=1; AJvYcCWbn6SX5sATjNZvw2Y7xVy4QTwIISJgEdtQun6KHYM7iRWq5MIc0/nsId1Cuzy6ElWXFihPUiAozKNY2OTDClXkiMZiMfyXdkmRvSd+2wws4rA0DfttTrld7P4ex9l0UCsiTCO0dTo=
X-Gm-Message-State: AOJu0YzxAScboljzVKa6NqmH3VnKWW8zrj46UCdE/R/n9BTNeukmSCdG
	QHSpm1x4giRq1XWEP7NsQczEDGVl4Ffi8SgAY678cFsM7e7kCmRE0I8I/Mz4i5A=
X-Google-Smtp-Source: AGHT+IGfDRR+m0n1Eik2IVGMrnMInH5L/2Z4F7sVzdvFZtgZO/0CvL7ZhRnAy4FCVy9kMHx2PmUaxw==
X-Received: by 2002:a05:6000:2ad:b0:33e:c2ed:d94e with SMTP id l13-20020a05600002ad00b0033ec2edd94emr2776972wry.56.1712775514988;
        Wed, 10 Apr 2024 11:58:34 -0700 (PDT)
Received: from trashcan (public-nat-13.vpngate.v4.open.ad.jp. [219.100.37.245])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d58cd000000b00341b7d5054bsm14431144wrf.72.2024.04.10.11.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 11:58:34 -0700 (PDT)
Date: Wed, 10 Apr 2024 21:58:02 +0300
From: Vladimir Lypak <vladimir.lypak@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OPP: Fix required_opp_tables for multiple genpds using
 same table
Message-ID: <ZhbhOsNQeFnLHzsp@trashcan>
References: <c274500b623b83c00c0460383cbe1cdc7490eeac.1712658693.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c274500b623b83c00c0460383cbe1cdc7490eeac.1712658693.git.viresh.kumar@linaro.org>

On Tue, Apr 09, 2024 at 04:02:19PM +0530, Viresh Kumar wrote:
> The required_opp_tables parsing is not perfect, as the OPP core does the
> parsing solely based on the DT node pointers.
> 
> The core sets the required_opp_tables entry to the first OPP table in
> the "opp_tables" list, that matches with the node pointer.
> 
> If the target DT OPP table is used by multiple devices and they all
> create separate instances of 'struct opp_table' from it, then it is
> possible that the required_opp_tables entry may be set to the incorrect
> sibling device.
> 
> Unfortunately, there is no clear way to initialize the right values
> during the initial parsing and we need to do this at a later point of
> time.
> 
> Cross check the OPP table again while the genpds are attached and fix
> them if required.
> 
> Also add a new API for the genpd core to fetch the device pointer for
> the genpd.
> 
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218682
> Reported-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Co-developed-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Vladimir Lypak,
> 
> Can you please give this a try and confirm that it fixes the issue.
> 
>  drivers/opp/core.c        | 31 ++++++++++++++++++++++++++++++-
>  drivers/pmdomain/core.c   | 10 ++++++++++
>  include/linux/pm_domain.h |  6 ++++++
>  3 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index e233734b7220..1f64b703b744 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2394,7 +2394,8 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
>  static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
>  			const char * const *names, struct device ***virt_devs)
>  {
> -	struct device *virt_dev;
> +	struct device *virt_dev, *gdev;
> +	struct opp_table *genpd_table;
>  	int index = 0, ret = -EINVAL;
>  	const char * const *name = names;
>  
> @@ -2427,6 +2428,34 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
>  			goto err;
>  		}
>  
> +		/*
> +		 * The required_opp_tables parsing is not perfect, as the OPP
> +		 * core does the parsing solely based on the DT node pointers.
> +		 * The core sets the required_opp_tables entry to the first OPP
> +		 * table in the "opp_tables" list, that matches with the node
> +		 * pointer.
> +		 *
> +		 * If the target DT OPP table is used by multiple devices and
> +		 * they all create separate instances of 'struct opp_table' from
> +		 * it, then it is possible that the required_opp_tables entry
> +		 * may be set to the incorrect sibling device.
> +		 *
> +		 * Cross check it again and fix if required.
> +		 */
> +		gdev = dev_to_genpd_dev(virt_dev);
> +		if (!IS_ERR(gdev))
> +			return PTR_ERR(gdev);

This condition shouldn't be inverted. It returns if gdev is valid.
With this bit corrected patch fixes the issue.

