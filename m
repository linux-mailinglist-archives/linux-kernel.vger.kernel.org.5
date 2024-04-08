Return-Path: <linux-kernel+bounces-135317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B7589BEEA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551BD1F248E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4656A8A4;
	Mon,  8 Apr 2024 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9hfZWKF"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1624C2D057;
	Mon,  8 Apr 2024 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579230; cv=none; b=G1lVd4saRbrGJQ6tVIwxdLchYTcuJO+EhSf2KqwsVWKep7gE48WPmSpwvLGSrLTz/B6c9ZnBehV40Y3/Ee/iE8a10RCTp8y/bJk501vsulV8cgAECVdTU7x/liSuUczmi+VO8IKo72cgkOWJSWnDUWT7TKviWkoo1xgE948E1tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579230; c=relaxed/simple;
	bh=dOt7LZM25+j0aeS8Mr9l3sLd7L3WPiVLe9kA5eRFQ/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxoD4OlABauktiNjAJZt57SKfmGyD0Q2jDK7tPkd7MKuqD4vcHRokYoZikt7+mA4fKlnwMZSLxjC3KpCZ/Grca65LWBiZQwNorhKM0ifgAO/7k8/PLSzvqip7waovkiPzCH4MU95YMSbRpJdbx4VCEUF6z30krBQ40+CSVSPEwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9hfZWKF; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a4f7a648dbso2455600eaf.3;
        Mon, 08 Apr 2024 05:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712579228; x=1713184028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7LamdtnDDI5vKg7sEnvdU4PcvK43YQi33cvsRSsuUo=;
        b=F9hfZWKF0Nr6OuWti/bwSMaRgCznxqs7CWfO+Bhuvk9Ni9Vv/QxMyEOqviUx0QxXla
         5KuDbDTxhtdRCET6v6zrEd5Q68o7bfwnwEe1lHfrpyQuf/tRm9qY28hDfrCSxQzAOC4W
         cKImjxSo+p48MT+aqJC4yuj764K8FtAfIJnQW/mVkFpR7jcR78+ZLaF4RWbMOr9HXlg+
         ZewL6mqfeCNK91nhxPjviMyCbbRa6MBYpjs3LIpZxDJz4CCzMacq6kM6Uw1X8VX0yh2S
         19OgsAHjRyXzlDYMFNYXBmocR5hwlpJ0DarLpx61CTpqG9aXZ68It5peXNuJD1rkQdQC
         FuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712579228; x=1713184028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7LamdtnDDI5vKg7sEnvdU4PcvK43YQi33cvsRSsuUo=;
        b=sBmYyZYSPToTiOQlqlfphGMnePGy1KCEs0cSUehBXyv69vNpf/jlgYgDQc4uReOFMr
         /dU07RSJAoKKS991N+/R7l0YfEkjBc5VHke25xJ0B+O/N1iwm5c4DBdik7dzHaKtZnXE
         sUjQFhediWhpB0UUA9XBMvQg4AdrKNvhexpyuc7IONkfBNMDsG99Ttq4oOWz0asUgmUr
         rr5XEDzvQ3IgDCaDYrRm84gMX8jZDxq81/YfmLGxpKNbo1YZPpkcuEFjDSC7suj6CEhR
         XpUIPgupYTCqdUug80GGtWKTqkcOofNqXFPY82chWN9OsY0aciMLiaXKvy9SJXUrQKtv
         bsvw==
X-Forwarded-Encrypted: i=1; AJvYcCXwkco9YUIKuAGVQFbbr5ZVbHfsovOGzrAcT3Mt6HTF3nBH217fk+8akUthGRK56dNnvgQqrPhVJzpFGszfyZasT6iv6fb1Zv4CqzRqF0uddYYc+3B1syx91jC3KIZS+tGnYDAdleBfd0ynPag=
X-Gm-Message-State: AOJu0YwnhcYyqappOkiouUOHvv4LalFJE4IFfn7zyT5WXpyc84PYDebA
	XGJfctCcU7a93CwEYRKhexWQkZCi5GfBo8RVP72ZXZkmtsxyH3fqTGXe2D//
X-Google-Smtp-Source: AGHT+IGTZSZBEX5V4h4KXAJrhF/sT+qU4iSY/08K8POlotC/2WCiSPR/4zuqfCJ5lVwcXJfFnUkrhw==
X-Received: by 2002:a05:6871:1c5:b0:22e:8ec9:4463 with SMTP id q5-20020a05687101c500b0022e8ec94463mr10357765oad.51.1712579228163;
        Mon, 08 Apr 2024 05:27:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f15-20020a056a00228f00b006ed37f1a912sm1656934pfe.89.2024.04.08.05.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 05:27:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 8 Apr 2024 05:27:06 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Lee Jones <lee@kernel.org>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: bd9576: Drop "always-running" property
Message-ID: <9e5f6d58-b72f-43ba-8280-3cd8b9b974ef@roeck-us.net>
References: <ZhPAt76yaJMersXf@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhPAt76yaJMersXf@fedora>

On Mon, Apr 08, 2024 at 01:02:31PM +0300, Matti Vaittinen wrote:
> The always-running (from linux,wdt-gpio.yaml) is abused by the BD9576
> watchdog driver. It's defined meaning is "the watchdog is always running
> and can not be stopped". The BD9576 watchdog driver has implemented it
> as "start watchdog when loading the module and prevent it from being
> stopped".
> 
> Furthermore, the implementation does not set the WDOG_HW_RUNNING when
> enabling the watchdog due to the "always-running" at module loading.
> This will end up resulting a watchdog timeout if the device is not
> opened.
> 
> The culprit was pointed out by Guenter, discussion can be found from
> https://lore.kernel.org/lkml/4fa3a64b-60fb-4e5e-8785-0f14da37eea2@roeck-us.net/
> 
> Drop the invalid "always-running" handling.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: b237bcac557a ("wdt: Support wdt on ROHM BD9576MUF and BD9573MUF")

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

