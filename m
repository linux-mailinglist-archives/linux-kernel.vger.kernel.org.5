Return-Path: <linux-kernel+bounces-58899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B71D84EE54
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258B4281086
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27D1634;
	Fri,  9 Feb 2024 00:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkfkWhys"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64CA360;
	Fri,  9 Feb 2024 00:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707438025; cv=none; b=VWSH8aKPubw4IsWAyRaRNhlyFLmtapHu7Uk2FISGLQFIqUFUSBTsb75NqVJnD1pyo+rhGkkju4L8elbq9NbOKzDgk6Dy2otiQz+0C1LI9HNmK7gQqgEl81PzOwpuzPnVh3bJTXpFy2IMC43i2yMEbuFl14JO+LtfWz221l2twCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707438025; c=relaxed/simple;
	bh=fQWAOxbdQHOI67uYRWUiLe/DLkQixdHM/rCmFw0lUSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWWXs0twq8wNXpIZfq0ksGwMFQut2yKIxMMVG/7I1ihGURXvIOrqIjPDiHvfrKqVtUE2Xtwe6HJcEgZEwX0027bKhZ3z/qmArdao55frT7oCOrdWznIsMk02xV8S5y31gNOIXXo66mXiG/8ncrUtA50eCtMLc7X6ZHU2AyTWpS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkfkWhys; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so243037a12.0;
        Thu, 08 Feb 2024 16:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707438023; x=1708042823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qdbUMa7QPeYlxa1Su029+aRrsMhXW6Au1xJECB9csBs=;
        b=FkfkWhysalDRtusQgYdI/RNRHQW5YLEbtS9XeaIMtLGcmZWAkWIY2gXuRSDzrxS3lU
         W1709lwW9EcJCewcuqbgHTUMtxjw6jQzxNUApqdvmrxxRhuqZT696DADHu02zGsA2OZO
         lD5c4shiyKdgL8jk8YFDz56pWe8I0bVSrA12mVya3zN5I7my4CwHY8woDizsL82Kl8hV
         SVr33np5zrDMC7+jL/1I3GHLyfO+vbobn2BQiXr6ozyL2NXJUsX/Pfssu3+yZTG+kvGO
         FkecJ779GRlxi2QEeUUGXafdqiJcCzDekNSIGEz7zaP0fb6r3rYuJgFpF4aqAaj0QlH+
         j4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707438023; x=1708042823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdbUMa7QPeYlxa1Su029+aRrsMhXW6Au1xJECB9csBs=;
        b=GRHz7JkjB+9hrquDSRuv59ly8+Qej1X9iptaGQo7xnEhfU7rQwZrY1CgEKEq+6/IEa
         iWGK607IL+XOUgc0RaxBIym2fuL5O+sI1GqRnixFiM60HtIY/HzSsPV/GPosMv5nj1bQ
         oEuuNpqClE7lrwxRqbMbIL0PpqpbKxwR1RBMac3EgZ8u7xIUFNpfKktdfeI9n0G+uRGW
         mQW0g7GGAdIAm37QXKrUM4HEORG7RTvUiupQiJY+0dLIu0s/aQDaW2YKbQsFhbGFxmbt
         x8QrXWPxtZFCBl8seWh8ydTQ6zMFHzFAIIjwELrMJUWrMq62fgWWgCqzGBVjeLei0pAk
         WSpg==
X-Forwarded-Encrypted: i=1; AJvYcCXyjIGWYnwVVs4Rjcsjs9DXiMvW+dFPYjPBN/S37P3G6CRXTBIf6T24irbujytxzeN0300er7Tf5rJDiNvln59LBDNyWB4JChF+MFu3b0JtqS4nfneAjmfoDRYqN/i1MSguIjwdzMY=
X-Gm-Message-State: AOJu0YxzpA+phSjtt7lvU3sICoSNlzKkf3cuiDlYHDxSPWP3IERGwBzv
	LqjGcIVdbDP0TW5017EtlI0DFKxyuHGzEU4ropZmW2eZgIYyJ8V6
X-Google-Smtp-Source: AGHT+IHNrMo6YwDPyVjTY4o+I0H0GK9eFo6mEShWLsRp44mLwJXyI2sMJT3S1GF7QoNDZH7h7RZQAQ==
X-Received: by 2002:a05:6a21:910c:b0:19c:7b2b:6cbf with SMTP id tn12-20020a056a21910c00b0019c7b2b6cbfmr132390pzb.47.1707438022874;
        Thu, 08 Feb 2024 16:20:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWwbMylMOXtZirFccrYiGQ+FeRED7/Iu4gbTGnMDE3n3U9fn1RUWQoe1fMEXn+HYKL3CuID4PZFL+0ON01URiokctgRfflwt27wVQy78VyEz4vh1ur8OEijsm9OvZgWAwQxu8xYRxpnzrS2LrlzZSArGKDk9XXLjx8qAJrQl+QO5E1fVM4cCr9tupQO8ILgT+DfltuI2NHKLEKXmjyVvST/FMHpqJjgDBUGB50/sSF9EgLC6MHMAfPxZea/A7lNiuH+r7BxHNXi/mV2Y8g6j1qwKKb5b6CYHqOD/iVhAkO3BZf6HHRmpBmxmFOsetnyy7+3IjrPoRbGIYj5V9FXnnJraIfzV6rjTpWTMWoHWmhURRuh6FUaQTG3kwvvrJs=
Received: from localhost ([2620:10d:c090:400::4:3c45])
        by smtp.gmail.com with ESMTPSA id kn13-20020a170903078d00b001d75c26e857sm341088plb.288.2024.02.08.16.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 16:20:22 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 8 Feb 2024 14:20:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume
 optimization
Message-ID: <ZcVvxbKOlrWmmyhS@slm.duckdns.org>
References: <4a043533-009f-4db9-b107-c8374be28d2b@samsung.com>
 <CAJZ5v0hDmwaFEtLc8yDc4cXn2wODXAqATe0+_Hpm9QPODUPMQw@mail.gmail.com>
 <ZcOyW_Q1FC35oxob@slm.duckdns.org>
 <2f125955-8c7c-465c-938c-8768f7ca360b@samsung.com>
 <ZcPSuUBoL_EDvcTF@slm.duckdns.org>
 <ZcPelerpp3Rr5YFW@slm.duckdns.org>
 <b4ceab79-3208-419b-9a79-f34540db3f70@samsung.com>
 <CGME20240207213600eucas1p1615e189e07dd1e96b001c7a187854fce@eucas1p1.samsung.com>
 <ZcP3uiapKGZqw0q5@slm.duckdns.org>
 <8c468452-1b00-438a-b634-eeccc35d9a41@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c468452-1b00-438a-b634-eeccc35d9a41@samsung.com>

Hello,

On Thu, Feb 08, 2024 at 08:47:12AM +0100, Marek Szyprowski wrote:
> I've tried to get drgn running on the test target, but then I've noticed 
> that it is not possible to run it on ARM 32bit target, as it requires 
> PROC_KCORE support, which is 'Visible if: PROC_FS [=y] && MMU [=y] && 
> !ARM [=y]' for some reasons.

Bummer. I instrumented code on my test setup (x86) and couldn't repro usage
of the dfl_pwq, unfortuantely.

Independent of understanding what's going on with the system_unbound_wq, the
correct solution seems like using a dedicated workqueue with raised
min_active. Just posted the patchset to do that:

  http://lkml.kernel.org/r/ZcVtzJvJCRV5OLM-@slm.duckdns.org

Thanks.

-- 
tejun

