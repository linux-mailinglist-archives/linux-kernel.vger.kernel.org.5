Return-Path: <linux-kernel+bounces-130635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16220897ACC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF291F24D85
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F1615689F;
	Wed,  3 Apr 2024 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRYEbEtZ"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB6215667F;
	Wed,  3 Apr 2024 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179866; cv=none; b=G0OHbdUrQ/o2ZUN7FYEl3ByWZ1P6GP8poVVGjFmbDmoZZY8v1mjFhXbmqRZ0gd6tpCkALk/geuyJeN5WfRtMcRm4zcwuxHvRUw/WBPbRcYU26qvtXoyspv7eAs+Eb0sZYWHOhduaAqppVaqfuM/81/BWq9veCJCY5oNY7GRcKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179866; c=relaxed/simple;
	bh=tKAe81m93DUX+Pe0O6nN/FdGfxyWXJ93yUEYPn0VMx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjVeEuOx0nYY5QVcMJsUPe5QyHlAo/zeBnHtLcQPtfM7Dw4/rkTLS13y0zLxSiuOWGARGRz+QAvMoW2ecMa4ORNUtJFJrJWiKrGR37/jYsWfV0Dn4SrKVxCbLLQ07OyTE4zwVjqI/brph8Exsp7qXN9yknzf2e2EkSGPSkCcU10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRYEbEtZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ea8a0d1a05so997374b3a.1;
        Wed, 03 Apr 2024 14:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712179864; x=1712784664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+OVOftGyrkMfiseFAhySCoXpi6lnMzQVtXHkefv4+0=;
        b=KRYEbEtZPh2lCTvtGDRUxPewQV6dQk8vfbIEObjcUvy10kTE5ld9m3UIhgQexJ6wGq
         CN4lXDjAtOtooFwMS3xFIDZIBnY1ewBjoJJL6dGhPoRqSz3bW9bmCzlCdyDlqO3sbu7B
         3cHU+0MMO/ndeWJ1w1dhWtQt4vgr2kwamVuovh56rgrOTToAeuv01Lzg4COTVAGrQlkv
         21G9izoLlTDOZFb3Ea0ELoFqGYZJmRWY9C939AxQnbTE0howO5Aj6XUx8Vl9Vmj3vof3
         1W7iY1NUdYJf7xmQy2lOU84iMNdQfbC36gGfnGudIILrHxfY82AUTyRDdswyrZUM9V/T
         +zfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712179864; x=1712784664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+OVOftGyrkMfiseFAhySCoXpi6lnMzQVtXHkefv4+0=;
        b=SNFNzBG6cTZLKaDdy8mlTj0KSf9s365gqdJ1kOoGAwHLhofaDbWPqL2NDQc5+GscDe
         YT4lGa1/amIwy80wF6ll9PPgokOyZjP6t20AqL38o9OOUPIbwzu+Nz9L6c9A5nEmRQ+k
         45T7Fp6DdRufA0GCd6XoMHutUHVgX4rgvLFSUne5Tufa0ThECgNKciC5wMdIHedhBxaC
         20N9kRObJQT/7OfVoDuKNzJowpm8BiE2B4UI77NAOyjNrwqsbTA8Uk66S/0Uo9UxpLR9
         vAbIp3Jn+/RtzqM+bwLOuXeE6S4e7pxQ+5IE0yFEMqhd1cT+RlzxD8fVxt+J6XKqPIkr
         fp+A==
X-Forwarded-Encrypted: i=1; AJvYcCWS2PsYaRckDltVGfxvSXir+bfJNHZecaLOCv4LZDdnCIsaUkk+ZsYTKZ+G0gOwESnGtavI+FUPvpqhsOwbaV5HCGMchBKgiX6W7YNzE5TWBWQc7QkHdFFRYr+bq6KAabWl0WroVjAuTSw=
X-Gm-Message-State: AOJu0Yz49H927ed303tTmdbecaJwP23n7is9XCRhe90V+x8BKWhIYb27
	rXrieofpYVha8aJ9maNNMzIoAxlSkIw8r1gYV73dRk+e7L/yjKcW
X-Google-Smtp-Source: AGHT+IH0CzecyhPovODsRO/XHWaimeNmFZriFnFeM28R0lcBCphA88X3csvxzy+T6N0oMiXHeYR/2w==
X-Received: by 2002:a05:6a20:394a:b0:1a3:4bfb:2cb4 with SMTP id r10-20020a056a20394a00b001a34bfb2cb4mr1116536pzg.23.1712179862324;
        Wed, 03 Apr 2024 14:31:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i21-20020aa787d5000000b006eaada3860dsm12203857pfo.200.2024.04.03.14.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 14:31:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 3 Apr 2024 14:30:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Davis <afd@ti.com>
Cc: Jean Delvare <jdelvare@suse.com>, Juerg Haefliger <juergh@proton.me>,
	Riku Voipio <riku.voipio@iki.fi>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/31] Remove use of i2c_match_id in HWMON
Message-ID: <0e43aa83-2e02-49e2-96b8-24cac0362a7b@roeck-us.net>
References: <20240403203633.914389-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403203633.914389-1-afd@ti.com>

On Wed, Apr 03, 2024 at 03:36:02PM -0500, Andrew Davis wrote:
> Hello all,
> 
> Goal here is to remove the i2c_match_id() function from all drivers.
> Using i2c_get_match_data() can simplify code and has some other
> benefits described in the patches.
> 

The return value from i2c_match_id() is typically an integer (chip ID)
starting with 0. Previously it has been claimed that this would be
unacceptable for i2c_get_match_data(), and chip IDs were changed to start
with 1. Commit ac0c26bae662 ("hwmon: (lm25066) Use i2c_get_match_data()")
is an example. Either this series is wrong, or the previous claim that
chip IDs (i.e., the content of .driver_data or .data) must not be 0 was
wrong. Which one is it ? I find it very confusing that the chip type for
some drivers now starts with 1 and for others with 0. Given that, I am not
inclined to accept this series unless it is explained in detail why the
chip type enum in, for example, drivers/hwmon/pmbus/lm25066.c has to start
with one but is ok to start with 0 for all drivers affected by this
series. Quite frankly, even if there is some kind of explanation, I am not
sure if I am going to accept it because future driver developers won't
know if they have to start chip types with 0 or 1.

Guenter

