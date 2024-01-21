Return-Path: <linux-kernel+bounces-31941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC270833729
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 01:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F8A1B217D1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 00:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E8D651;
	Sun, 21 Jan 2024 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="vWin7zMV"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE88119F
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705795864; cv=none; b=sVV6QB5zcEj4Yp5yDuMXijJe7TLj/INZ3g1k9nImfyAjtodMkZby7Z7IrOVR3POS/A0+ZGrdCnmr86oTJJAk9LMXYYYLUYyPNaxLKaqW1vyHO/CauxxgboPSvB5NXPqtGMeGuz5rQ1VTB8UdIOhlSSnbNi4LA0DsGstaId+i08k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705795864; c=relaxed/simple;
	bh=h75tULPlCdor/jvYObh4MOVd0PPsKoCyF3o5yozt/e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3Qh1wVr1o2XAwWsWT/otCzj3Os0njiORtF92Knwv8T5GfazZYJG7LwQvw6hZpZaD125R8oeTRv1dVgi/idP7k8P3EcMvS2dKj1bIZKy5wdEY4eXKTNH6ZxC2DUDN75AiE4P4bW41lEp7XDvmJh55GvljnTwHvX5+MQyj5wdF9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=vWin7zMV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-339289fead2so840977f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 16:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1705795861; x=1706400661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sLEQsFpn0ma2xUaIH+LxXcWOgEsaeulT2oHQwdeJmOM=;
        b=vWin7zMV75pwwr9K8xQOQ/xkCabBE+jTQMLGW9o6uV6ErB7m4P6kvnDdAefwBULtEZ
         sONuUo0jvsoV+e1E4j4cDMQigsOLrsEMoJP24RQMzGPs4Cc1xX2u1Ejew+2YIWKh91Cq
         kvzERvZSl4YOLS5LFoRSmQi9TaRboywQlnZalXTXBgl4qXRlOtBOJ5JPFsQ+d5RVbE15
         Zx/mAmr0OCj2NBKuETbb4AyeR2ErSf2rwD1GpsN6+TWVB8P6TIEUW3+a7fcr12Gsg/wz
         xc4haxnaN0iyG+79wJBbCNYpOYnt6fyWVJIdNr+NlhuuEEfgBxRDw3uAVQ+8+6/UgETz
         OjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705795861; x=1706400661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLEQsFpn0ma2xUaIH+LxXcWOgEsaeulT2oHQwdeJmOM=;
        b=YJbixihrnJATEIdoV/pTQjFaumEE74rQRySzvU5KlHjpBvQOI0iIiDbn7IHqFF8quP
         34Z7VyrqmxFdnVLXd/jF1SPS59b2/Zv8KYNyOzNQmHdOyJLwwrpLMkkWfzRowbnewU9g
         VFv9hjx6duLjU5z8fT3tDqy6krRijMo+2owc5Re2W4ufsdMLSeG83SNrjBeB/e7V7xr1
         5GgvGhTZnZ/71kXebp+dhbc6FmovHyHJjtNoilEXYTyZhWpOoMFzQyL7pcc9MXOULKOI
         4oAcbhjSCvuQLSK9VRycd3ZV4xiO6aDoY1PPrpQQl8cZ2GDvx9MO/0VWo8cfMGUvAn3V
         XXzA==
X-Gm-Message-State: AOJu0YxCKi12pEQiQir1uAH9XJzdMIIxKAiz/X1dbdrGEWYz4vL4dn1d
	RdnIFSZ9tl/RtZeyCyU0u21wLBEbWvR6y/Nfb9gEmGDDBcuWnG/Cjnk/gNDGmBOeLFmIwufwi/Y
	Q4gw=
X-Google-Smtp-Source: AGHT+IF7u6viM5Lb3cZ7tif/WBvqMkSaSFYfbYaw7cAYAr77IkdL/kqJWrA4UkkDehvUXaLFJ+5y1Q==
X-Received: by 2002:a05:600c:3c93:b0:40e:596a:9850 with SMTP id bg19-20020a05600c3c9300b0040e596a9850mr1042375wmb.240.1705795860837;
        Sat, 20 Jan 2024 16:11:00 -0800 (PST)
Received: from airbuntu ([213.122.231.14])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0040d1bd0e716sm34257599wmq.9.2024.01.20.16.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 16:11:00 -0800 (PST)
Date: Sun, 21 Jan 2024 00:10:59 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v4 0/2] sched: Don't trigger misfit if affinity is
 restricted
Message-ID: <20240121001059.yygptzy6jzmcbbhk@airbuntu>
References: <20240105222014.1025040-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240105222014.1025040-1-qyousef@layalina.io>

Hi Vincent

On 01/05/24 22:20, Qais Yousef wrote:
> Changes since v3:
> 
> 	* Update commit message of patch 2 to be less verbose
> 
> Changes since v2:
> 
> 	* Convert access of asym_cap_list to be rcu protected
> 	* Add new patch to sort the list in descending order
> 	* Move some declarations inside affinity check block
> 	* Remove now redundant check against max_cpu_capacity in check_misfit_status()
> 
> (thanks Pierre!)
> 
> Changes since v1:
> 
> 	* Use asym_cap_list (thanks Dietmar) to iterate instead of iterating
> 	  through every cpu which Vincent was concerned about.
> 	* Use uclamped util to compare with capacity instead of util_fits_cpu()
> 	  when iterating through capcities (Dietmar).
> 	* Update commit log with test results to better demonstrate the problem
> 
> v1 discussion: https://lore.kernel.org/lkml/20230820203429.568884-1-qyousef@layalina.io/
> v2 discussion: https://lore.kernel.org/lkml/20231212154056.626978-1-qyousef@layalina.io/
> v3 discussion: https://lore.kernel.org/lkml/20231231175218.510721-1-qyousef@layalina.io/
> 
> Food for thoughts:
> ------------------
> 
> Should misfit cause balance_interval to double? This patch will still be needed
> if the answer is yes to avoid unnecessary misfit-lb to trigger repeatedly
> anyway.
> 
> Should the doubling be made independent of tick value? As it stands 3 failures
> for TICK = 1ms will increase it to 8ms. But for 4ms tick this will become 32ms
> after 3 failures. Which I think is too high too soon.
> 
> Should the balance_interval be capped to something more reasonable? On systems
> that require fast response (interactive Desktop for example);
> a balance_interval of 64ms and above seem too high.

Does this series address your concerns about scalability now?

If you have thoughts on the above that'd be great to hear too.


Thanks

--
Qais Yousef

