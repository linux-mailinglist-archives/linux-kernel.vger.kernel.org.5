Return-Path: <linux-kernel+bounces-92118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBF1871B59
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF8C1C2205C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7315B5DB;
	Tue,  5 Mar 2024 10:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="Z/JaDtsj"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1602254907
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633990; cv=none; b=Z/WVAij3Ddz+rPIDrqC1e5NmovEVhitLLM8i8NBTPWXICFbe3u1z2fMMOo4QY/tG/+P3qD+al6LCWgpMip2tlvgJTpD3l/QUlmv5vRQhBZxv3qoHc6yN+X32tjhrKp2iByZ4+bXcuVuWLmP5pus7u8l50uXTKaZTUWOnLqxYjZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633990; c=relaxed/simple;
	bh=WPYjAo35ueTIaoUFIBDZ9jCMG4Vux8IKHZr4s0+HkKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvbjUqVGNiYYHcKIjCHsEbUOYYUGu1ZJn+suRO1ZsmvNIAQd4moBgAX5KcKlFL3NDvOy+7QJifm/EjTfokLBaMszcbgtvv0C9oRu3Zvceffmg2MUaUi+kQp2T0FJ23ymZ4yfvAIRdWi4O/HbBNcgYOu03/iEgprwWRUS7QwcPGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=Z/JaDtsj; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e2268ed96so3427489f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1709633986; x=1710238786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H6OcsG3MUfMZHlFyq7Y4+mYfeDO+WAVX0fDPYMZUXpU=;
        b=Z/JaDtsjgXeS8rE48iuKi92W+nmsXYOlLKsk2clwBw78pHpLaIVw+5E7uMDHt6AuOh
         ePCusj2ys5+XYGg9JBtn6pjSgpoy3tuqAeucZywRcqcJghbeYI4tkIBHaysEB8TLmw3G
         sJHsxN5sAhRYX1Fe/pEyKoOa6dkBoLSSm+dj54KSxHo7R+vuOzRktpFembYkanVWtIyR
         st9DsI5GwCXu6xQ1d7VFwO+QdGBTPdmKsqIrk3JZABpqPuSXHBR38JcFIwH/DD8Q+7yE
         3vI5FJaMTGtZxHJ3OKllIl5/BamM5zT9ramotSbNRqRnO/cQvLM+cg5Ggn6ETBqBw23b
         fkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633986; x=1710238786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6OcsG3MUfMZHlFyq7Y4+mYfeDO+WAVX0fDPYMZUXpU=;
        b=kfBjcyH+I2SOiS6yUDdevnLUjUHlRprUdtGSRNVhsjtRkWv7asLsSSvBcEKWi/N9c+
         YFcrcWoEMmbqYXsKaParZIzrBqBpZ2RhKUWi3N4iGZI5WnoscZM93UPfBGpWsdQfjTgk
         AoE+EjM923CdqqSiC8v4KYwDmNbANRXRY5CqAjhvWZZCoRftNE0EFmuRDFfCDWI/Y3C6
         mD06MUibq44W54AGarSlvCh5/muj+g1cnIC2DvfZCv4Am+jmRzrEYZa2De3FMMDti8Am
         xBtMNo/2RyYICNPjiAi1ZfkRw6YWscNn8cOcAiETR4cCMPxDUcPIbej70r3Ii4JtRjWX
         xIGw==
X-Forwarded-Encrypted: i=1; AJvYcCVeff9P30tU6f55dh35T5KFzeLe9gkZvqVdxdgIqd7fkGJjjbRP13EeWzK4LxbyBWKmZlH6pcNexQHouG/xKdcGddXqIEKXIdtZPPvE
X-Gm-Message-State: AOJu0YyiisJzWHdVxLBnxPQnJR9ClIs4b8107z3Z6wF8oLZUx24kSxqN
	d/dApVubSjWkQIJYw89RJQbRtcKeWTr76ex421toP6cuJgfsXldeFW5hCmT7IZw=
X-Google-Smtp-Source: AGHT+IH/77zfXrO7ZIqGIgGa0F4+3NcxV6NtMMOieHxgw97x0APZizQxin7XgKQgimZtxUGjPwKeLw==
X-Received: by 2002:a05:6000:1cd2:b0:33d:ab46:22d1 with SMTP id bf18-20020a0560001cd200b0033dab4622d1mr7739526wrb.29.1709633986091;
        Tue, 05 Mar 2024 02:19:46 -0800 (PST)
Received: from airbuntu (92.40.185.97.threembb.co.uk. [92.40.185.97])
        by smtp.gmail.com with ESMTPSA id i10-20020adff30a000000b0033b6e26f0f9sm14577292wro.42.2024.03.05.02.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:19:45 -0800 (PST)
Date: Tue, 5 Mar 2024 10:19:41 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
	yu.c.chen@intel.com, dietmar.eggemann@arm.com,
	linux-kernel@vger.kernel.org, nysal@linux.ibm.com,
	aboorvad@linux.ibm.com, srikar@linux.ibm.com, vschneid@redhat.com,
	pierre.gondois@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH v4 2/2] sched/fair: Use helper function to access
 rd->overutilized
Message-ID: <20240305101941.c5foq7v43xwohrzp@airbuntu>
References: <20240301151725.874604-1-sshegde@linux.ibm.com>
 <20240301151725.874604-3-sshegde@linux.ibm.com>
 <20240303185441.km7c4u7yui3b5nl2@airbuntu>
 <5e5c0a81-3c60-437c-b164-e1245222d964@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e5c0a81-3c60-437c-b164-e1245222d964@linux.ibm.com>

On 03/04/24 13:58, Shrikanth Hegde wrote:
> 
> 
> On 3/4/24 12:24 AM, Qais Yousef wrote:
> > On 03/01/24 20:47, Shrikanth Hegde wrote:
> >> Overutilized field is accessed directly in multiple places.
> >> So it could use a helper function. That way one might be more
> >> informed that it needs to be used only in case of EAS.
> >>
> >> No change in functionality intended.
> >>
> >> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> > 
> > Can we do the same for rd->overload too? A set_rd_overload_status() would be
> > a nice addition too. Anyway.
> 
> 
> We have some more experiments going around overload. 
> For example, currently it is writing sg_status & SG_OVERLOAD without checking if it has 
> changed first. On large systems that are not overloaded, that may help by reducing the 
> bus traffic. 
> 
> I will pick up this after we have some more data on the above. 

*thumps up*

> 
> > 
> > Reviewed-by: Qais Yousef <qyousef@layalina.io>
> > 
> 
> Thank you.
> 
> > 
> > Thanks!

