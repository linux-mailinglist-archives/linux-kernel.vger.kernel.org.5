Return-Path: <linux-kernel+bounces-17152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 844BB8248F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 20:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16BE71F257DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177CC2C1AF;
	Thu,  4 Jan 2024 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="lZuEGPyN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4EF2C6AF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28d61ba65eso104430266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1704396238; x=1705001038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vP64jz0/VAK3xfeL/8CfdG5CwhX3wPofMDHlLSKDnNM=;
        b=lZuEGPyNKaZ47Yqk/JSy8z5LHLC9wiyQHaoia4AiwaBGIl5EU++NeuC0wxXg2v245S
         FBUbVhOJrHjQZTqN+Y1qYFUtABeeVcZwg87+TqCoArZazWhnf5vwbQ/Fj+BXUDzcEy5D
         VFiQehFo9bXCjcc6F0Qt0QrkAuqJdl4Yb9v6vGSuTaK9qqewLpm8kRg/swL6A07tDI2N
         9Dfz9E4VOCHOGTKoQQ4y+DK20R9KoxmR2fws9U8bG+pVPl9jKStwsnvti9xpXxW5t9vu
         0Hdpidbv9wr/1kG4/pYLzz0ww6DNbmiIcVtD/cFJpnITDEbQxQ0AOKJ0+BZYMIi0y7+t
         2naQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396238; x=1705001038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vP64jz0/VAK3xfeL/8CfdG5CwhX3wPofMDHlLSKDnNM=;
        b=LTP9Ibho+dbVPWH9rkt4N8XscalOExsDtEk26MmqYn3KmkGV+DvGAodkYHX33ytaRv
         tQwNc0cHrsjCGzHIRANd0SpEJXgtBs9iYaBOkR1l83aSfs5YlcTuKOkpqqLYaHPzde9g
         0jFc8Rn08PYc4g87k+coipnBkCzh3KgT+VVb/rztDnEdux/Ik+ULAMRGDMA5re4vSxmw
         Z3gFVN5gwThwVYs9JwHbr0+1+fHxfTpthHWVCzThqmKcXIr6iF6tcQREy/U/jbCkCA03
         NXf0I51MeT0aFdAeoblCoblgG4OeNQl98t/vNqgsQHz3c7Gn6beeuLfhrc3XpjTuyPpy
         5uwg==
X-Gm-Message-State: AOJu0Yyob+7SoIIXU8jyCDYLfgxsazpTo0yF3J6QzuE0R0ag9pnrvS3M
	D7sGP4unNZ/XNf0IfrkPS7FFpsZZat7cnw==
X-Google-Smtp-Source: AGHT+IGt53v/I2xmcHd9Rpuooy2t5yo5vlHjdZu4FjkULa/G5M5nIe6mNsh4s8NwE5M3u0QLx+68pQ==
X-Received: by 2002:a17:906:3606:b0:a27:2f10:fa06 with SMTP id q6-20020a170906360600b00a272f10fa06mr431974ejb.109.1704396238232;
        Thu, 04 Jan 2024 11:23:58 -0800 (PST)
Received: from airbuntu (92.40.216.189.threembb.co.uk. [92.40.216.189])
        by smtp.gmail.com with ESMTPSA id ex15-20020a170907954f00b00a26ae85cfeasm13297121ejc.28.2024.01.04.11.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 11:23:57 -0800 (PST)
Date: Thu, 4 Jan 2024 19:23:55 +0000
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
Message-ID: <20240104192355.mrtqnek2cyw7rlkd@airbuntu>
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-16-lukasz.luba@arm.com>
 <20231228180647.rwz4u7ebk5p2hjcr@airbuntu>
 <d9bea2d0-3869-4f08-8eb8-0ca33ce525ea@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9bea2d0-3869-4f08-8eb8-0ca33ce525ea@arm.com>

On 01/02/24 11:47, Lukasz Luba wrote:
> > Did you see a problem or just being extra cautious here?
> 
> There is no problem, 'cost' is a private coefficient for EAS only.

Let me  ask differently, what goes wrong if you don't increase the resolution
here? Why is it necessary?


Cheers

--
Qais Yousef

