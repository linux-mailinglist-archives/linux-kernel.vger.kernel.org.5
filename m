Return-Path: <linux-kernel+bounces-122467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B7B88F80A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140F8292EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA9A3399C;
	Thu, 28 Mar 2024 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oZfORKNH"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB32C6B8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711607964; cv=none; b=MqculHgM27jCo8y6eDAF0kuYvtBEEyMzgOUsPsvUFAqU8cEwYbCvD07XIQDPt6nCv6y7eJqvpqzk0Ol+WdowbAqLiBTcBGhX0yRH4KKRMyOoGmmm0l/6tJzxF97B8Fdhosw7UXumianUUJVTT9T/kMwCqGOQBv0jAs785c8HL0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711607964; c=relaxed/simple;
	bh=iM/Zrr6xg5+bDVZfSFnEORtiFT+7aRXqsnR+cnaan98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDYhHLm+F9ZYchWHJ1sfbIo8wZGpTleQSqvQiUYQf8DPuDD2Xco/CwqICQkq8YXO6hB1GMezNPT49NkduNyPB1hIBOa0/6h1hZROPf8wtwahK94+pOSqE78hrhIsbI2cEbH2kmXEyuKN8wQ7ftFQ2Vc4Epa4a2Ws1bNV3KhyXWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oZfORKNH; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513d599dbabso718002e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711607960; x=1712212760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqD6QFkv4RcPR01vWVUf1wMB4qAMJiEap/VS8LtfkEg=;
        b=oZfORKNH2WFA7aM0WqvWbeFYIug6TpgxrzFUXjnjv9MOq9lorH5F+9Dc3DgsHlMkBq
         PNWZm2xP++LJzPeLnn5jCjmCPS8BFSjRTbfVTZsBqw3bA55uOiWWZT3+T+LSJ7zSpkCc
         zTgbf7LRNKi5lR1DfppJ3ciiAEBOwHqgXwS59CV+44oeoRbu2rtRW6Rv5rSBw/SplwUS
         nzcWudALQVXE0Jr19T6gxRNXJ0WASTDN+KdKp709HnA0U9DVTvwZcLDyXi0s8NRbGavr
         p0GDdSjbu5O/BOXasa5KgZ+k+b183zfa7mNNTVtQADdPA71mAOShbRA4hSPwzgbSShJu
         SpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711607960; x=1712212760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqD6QFkv4RcPR01vWVUf1wMB4qAMJiEap/VS8LtfkEg=;
        b=r94H84/05dh32ERzVYjWYJp07685tp7bSbjbbnRLDVPwapzxH+8MlEdxS/IujvhooY
         XDlm9NqlQ4RHtDNKBRLg8rMXtMeA/96cWBkMRczLsr4jOomZjQZW/fEvqyMGqKdOetVj
         JYHzlMNn0XcOk2DCs8TuoAts657LoX9nFKbAA+a8ptcLtlKzXaHj2zmUpzaz5zsfzV7I
         kLLFYWXMEegSDnZ+hANpcSUYpg+LjZIyH7pwUMCtavwdNk+3rn/Sdat7f08QQJBwBqmu
         pRdxb9JjCGqchFdal911ftsGNtxJzm1LGIglp9dS861Wuf1aqEhy74lkN52WL/LDX4MM
         JPiA==
X-Forwarded-Encrypted: i=1; AJvYcCU71XyHjslvJr+NKomCD8vYd564riepzr4Bejwc/zutULq2jpCBYQlFuvlCfu4gN0m1p/EgZq629RYD2CB/fTvLbq8Cv850BlrDrAeB
X-Gm-Message-State: AOJu0YxA9ityIOAd/j00rKLLqMWzeTpvF99jououGaoHZZiVCxUgeL5w
	sN+YF0hqOcPBjGb83/tPQjqkuDbwZ9Mr6blBirGiBqDGeVL8gQPEQOGBBHwHsm5QGHp03eKomtL
	b
X-Google-Smtp-Source: AGHT+IHWJOoEo7pRzUGI3H9oyAn6IMRYBaACNvS/9pjMj7sskPE2i+M+a3M7zfiBUiKyrs+HJVaBkg==
X-Received: by 2002:ac2:4823:0:b0:513:9e44:c68c with SMTP id 3-20020ac24823000000b005139e44c68cmr1172033lft.6.1711607959469;
        Wed, 27 Mar 2024 23:39:19 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id fd6-20020a056402388600b0056c53ea5affsm217009edb.77.2024.03.27.23.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 23:39:19 -0700 (PDT)
Date: Thu, 28 Mar 2024 09:39:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: alison.schofield@intel.com, paul@paul-moore.com, mic@digikod.net,
	fabio.maria.de.francesco@linux.intel.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LANDLOCK: use kmem_cache for landlock_object
Message-ID: <dfa6ddcb-9a2d-49ac-90b7-bb30b23e32c4@moroto.mountain>
References: <ZgSrBVidW1U6yP+h@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgSrBVidW1U6yP+h@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Thu, Mar 28, 2024 at 04:55:57AM +0530, Ayush Tiwari wrote:
> Use kmem_cache replace kzalloc() calls with kmem_cache_zalloc() for
> struct landlock_object and update the related dependencies.
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>

Is there some advantage to doing this?  You need to re-write the commit
message to give us some clue why you are doing this.

regards,
dan carpenter


