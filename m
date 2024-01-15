Return-Path: <linux-kernel+bounces-25964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8441A82D8DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBD128248C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 12:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6348B2C6AA;
	Mon, 15 Jan 2024 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="dR4rXaYo"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD992C69E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e7983ebbbso7148095e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 04:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1705321318; x=1705926118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fs9uZtOZSZY983MbpbNus0vFFfYsEJx/IcWyQ7BJ8qQ=;
        b=dR4rXaYonRG47u/Wan5x7joH90okSquWbu7LzVEPuzJgwN4XQnfbNjsl5wS90mD5Zf
         HOJ84Fi4Y4BzVb2DMwZ6ZAXSM5qYQI85D8gDMNbXxZ5xB5abKB7FARCNGO/oiUeEmRLA
         PLiUekgPJol7kAXl9uyFkdPV2GrvWA/u41bhhWYI0hD/PzQMrRqWPVKGhd7D+mCQ8Fyu
         sEoMII0NHPd1h6L9LC6411xcsytxoOh94PNbXiKG40Nz3LURORpCzp3uiLOvGHpQPL0m
         cDJ2Ltv7FsQ1ZU3hj9hVIDtDK3gg9S7Y90fMs3tzGLY71FrVD5BqEye4egQpk8hFNc71
         jhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705321318; x=1705926118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fs9uZtOZSZY983MbpbNus0vFFfYsEJx/IcWyQ7BJ8qQ=;
        b=AYyrLOZvv0IIOTdKV+YWN3IUeFBJT+CHST00OUDg01UiHw0A4fWrwUfN6xDsFP1RPi
         QWiYhGOIuXPornwjkDyqyBeg6zT3vuuPyW5zDOisN5NbjSEccs9g5QE9xQcBCjQApumk
         omTj192Lx5keffV0WmSDTPWtGuVosPZJZAfjaJ3JKBzemCxA98gc5btIcX9GqOZ3J3k+
         qaoofPhJYzu5lh6W7O72QWQZ4jL6yN4qjtrzkpWfTUGxqbw+stgoy0Kad6XrBITB4jbN
         ZFlfxayFTU3ijKXdTBWn2HtANmIGMprf5dqzDd6LaOB14mLW3lZZPW9PqZMMmgO/4r9+
         AsNA==
X-Gm-Message-State: AOJu0Yx9Udxa8INHm/nlUUSre1sfdRyKgvopqmFPRkokCQ6sBYob1TJH
	DD/98DV/Q7JUheII1kMuHH0nYLNLgl7CWQ==
X-Google-Smtp-Source: AGHT+IFTqeFwsp0sSGf85DjiCCFXr/mbW4IrvFkzgBdtdzzRff7gq4EUX1KCFcsdSLxxrS7JXzKX2g==
X-Received: by 2002:a1c:7c01:0:b0:40e:4ec1:ad2c with SMTP id x1-20020a1c7c01000000b0040e4ec1ad2cmr2857518wmc.52.1705321318263;
        Mon, 15 Jan 2024 04:21:58 -0800 (PST)
Received: from airbuntu (host109-154-205-127.range109-154.btcentralplus.com. [109.154.205.127])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c154f00b0040e3b12052bsm19784532wmg.5.2024.01.15.04.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 04:21:57 -0800 (PST)
Date: Mon, 15 Jan 2024 12:21:56 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	rafael@kernel.org, dietmar.eggemann@arm.com, rui.zhang@intel.com,
	amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
	daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
	len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
	wvw@google.com
Subject: Re: [PATCH v5 15/23] PM: EM: Optimize em_cpu_energy() and remove
 division
Message-ID: <20240115122156.5743y4trhm4tkgs3@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-16-lukasz.luba@arm.com>
 <20231228180647.rwz4u7ebk5p2hjcr@airbuntu>
 <d9bea2d0-3869-4f08-8eb8-0ca33ce525ea@arm.com>
 <20240104192355.mrtqnek2cyw7rlkd@airbuntu>
 <2a8aa860-17dc-442a-a4ed-8f7c387b15ba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a8aa860-17dc-442a-a4ed-8f7c387b15ba@arm.com>

On 01/10/24 13:53, Lukasz Luba wrote:
> 
> 
> On 1/4/24 19:23, Qais Yousef wrote:
> > On 01/02/24 11:47, Lukasz Luba wrote:
> > > > Did you see a problem or just being extra cautious here?
> > > 
> > > There is no problem, 'cost' is a private coefficient for EAS only.
> > 
> > Let me  ask differently, what goes wrong if you don't increase the resolution
> > here? Why is it necessary?
> > 
> 
> 
> When you have 800mW at CPU capacity 1024, then the value is small (below
> 1 thousand).
> Example:
> power = 800000 uW
> cost = 800000 / 1024 = 781
> 
> While I know from past that sometimes OPPs might have close voltage
> values and a rounding could occur and make some OPPs inefficient
> while they aren't.
> 
> This is what would happen when we have the 1x resolution:
> /sys/kernel/debug/energy_model/cpu4/ps:1008000/cost:551
> /sys/kernel/debug/energy_model/cpu4/ps:1200000/cost:644
> /sys/kernel/debug/energy_model/cpu4/ps:1416000/cost:744
> /sys/kernel/debug/energy_model/cpu4/ps:1512000/cost:851
> /sys/kernel/debug/energy_model/cpu4/ps:408000/cost:493
> /sys/kernel/debug/energy_model/cpu4/ps:600000/cost:493
> /sys/kernel/debug/energy_model/cpu4/ps:816000/cost:493
> The bottom 3 OPPs have the same 'cost' thus 2 OPPs are in-efficient,
> which is not true (see below).
> 
> This is what would happen when we have the 10x resolution:
> /sys/kernel/debug/energy_model/cpu4/ps:1008000/cost:5513
> /sys/kernel/debug/energy_model/cpu4/ps:1200000/cost:6443
> /sys/kernel/debug/energy_model/cpu4/ps:1416000/cost:7447
> /sys/kernel/debug/energy_model/cpu4/ps:1512000/cost:8514
> /sys/kernel/debug/energy_model/cpu4/ps:408000/cost:4934
> /sys/kernel/debug/energy_model/cpu4/ps:600000/cost:4933
> /sys/kernel/debug/energy_model/cpu4/ps:816000/cost:4934
> Here the OPP with 600MHz is more efficient than 408MHz,
> which is true. So only 408MHz will be marked as in-efficient OPP.
> 
> 
> This is what would happen when we have the 100x resolution:
> /sys/kernel/debug/energy_model/cpu4/ps:1008000/cost:55137
> /sys/kernel/debug/energy_model/cpu4/ps:1200000/cost:64433
> /sys/kernel/debug/energy_model/cpu4/ps:1416000/cost:74473
> /sys/kernel/debug/energy_model/cpu4/ps:1512000/cost:85140
> /sys/kernel/debug/energy_model/cpu4/ps:408000/cost:49346
> /sys/kernel/debug/energy_model/cpu4/ps:600000/cost:49331
> /sys/kernel/debug/energy_model/cpu4/ps:816000/cost:49346
> The higher (100x) resolution does not bring that much in
> practice.

So it seems a uW is not sufficient enough. We moved from mW because of
resolution already. Shall we make it nW then and multiply by 1000 always? The
choice of 10 looks arbitrary IMHO

> 
> If you have other questions, let's continue on v6 series.

