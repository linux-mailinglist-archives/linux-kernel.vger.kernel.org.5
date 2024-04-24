Return-Path: <linux-kernel+bounces-156623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1608B05E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7E71C22CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36489158D92;
	Wed, 24 Apr 2024 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zoed2c3h"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D3158A22
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950259; cv=none; b=UKdu7GL94xKOZqS5YaBYky8mTnnHLFBLLCFrtj99OGKxBmTPFvO/h388Y/Z/KyQuDmCP5PuMU32qnSnfiKFByMTJsaZS+CjaePQii8PYDoN0S6teb01xn33h4DCkTbshJhhUeP7C+D56HlDeYryvtiM+QkF0Aalu4JocXXt4I84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950259; c=relaxed/simple;
	bh=6v6pmpTVgPnI69pOfFGBY/7JqehyACnXXZ0pMSagnQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE8Mkj77gQezluUC0EZ192ij/Ro0sy7JpkGDS2dl2n9qEANz7W1yY7HuLEHAhNe+aSAsDXSW6A26O3O/OIYsskm4CAjcGi75lxMY9M+64gtHJUTv50Glzy17Q+P9LzeeLFwWRI/9Qmv/XzOandf7I6WIlRiQ8RiQzU9/PLqp41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zoed2c3h; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41adf155cffso8686105e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713950256; x=1714555056; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EvNYwGwejd/vmVQ4glqR5CH2PWp5Gxwed8vZAqZp1Hg=;
        b=zoed2c3h0xMzyt9zrL4iIYxwpVShNECzfE1WZnOqufirHjLIDARNIHGb6AJ0uwbmNz
         ED7jSiIdZsaPku9YeY/wiIL03xiY8yEZiqc/EK1P5Cnx9cvTvMYjnhJcftvxvi73K4d0
         g30oR3e5/HWcHn9HeIF1WrHlJJ7ujQZ2Pf/7NfFlX493aAz9ASjWDgPZ90WMsikKs1NL
         WXYumESkVxu39Ved948ynXbS7DMj1a3z6+DvqLon16QL3Om4RfuKl4EqZNpLBI32M53W
         XcyfgXFOmbtdbHLXXssAAYGImnj3EkvvDNcEH0kfhQ6B4B8E7UHfhXWjg7pwr9aReRd9
         nnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713950256; x=1714555056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvNYwGwejd/vmVQ4glqR5CH2PWp5Gxwed8vZAqZp1Hg=;
        b=k7EknaxcXb+WFUN3ecAqOjc59o44KhYJnt8pkLphOGb2R0u/crhZlVFmhxNPLla7Dd
         GqIeZB1AdcR7Sc36wx6/n6RDByxLNCsnPjNY0D1leTh/9Dq9c/pSbwT/GiMxn4RYxnBC
         qZjpl35GtiOo2guZ4vOwKndLfWmDKqLH1Djro1s95jrTC8RAjmuUr2aa6c+mhl2LMmiq
         BvagWnFfgBiiePz7vuDiyjA8KlN10urxbXFQrnCIlfKUIUccn4tIJL7S0UUrPfwGySvm
         N+0YgTWi7N/VrbBpkJvQbJ5wXRyTSMiqMyvulMVtea8K9ITqMzhB/XcgDsyjupKPiNZ1
         o+tg==
X-Forwarded-Encrypted: i=1; AJvYcCVlrELv0KBlAVB3zvWHFZe0sBUpvNGdjzGEdb52WH4LM0F8r/GN/Nvyt9tF0BLVQ0tfadmGGbLEO7j1XSjFmcWspCC8Kx/DA2DbKZY+
X-Gm-Message-State: AOJu0YwIgImrg/Fm8nIDdFT68qWqvD+ZzKq3uCa8gmWW7Y9UmnJTRe3q
	RIcRday47TlJdkAx6yha+92saNYJT/uG1s2BYcmpvkO9Xb+3ezaQd/Bb6FDbFuI=
X-Google-Smtp-Source: AGHT+IETBR5NRDJvnmT+4jufXRV4MUnA6U+OX77MdwUghv6OF8LCeQsDz2Q0f1bV/GCLa2wnLyjtQg==
X-Received: by 2002:a05:600c:35d4:b0:418:f184:53f8 with SMTP id r20-20020a05600c35d400b00418f18453f8mr1605318wmq.36.1713950256284;
        Wed, 24 Apr 2024 02:17:36 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b0041a9fc2a6b5sm6491155wmo.20.2024.04.24.02.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:17:35 -0700 (PDT)
Date: Wed, 24 Apr 2024 11:17:33 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 16/16] thermal: core: Relocate critical and hot trip
 handling
Message-ID: <ZijOLZfQgQYTBzVl@mai.linaro.org>
References: <13515747.uLZWGnKmhe@kreacher>
 <9337957.rMLUfLXkoz@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9337957.rMLUfLXkoz@kreacher>

On Wed, Apr 10, 2024 at 07:44:34PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v1] 
> 
> Modify handle_thermal_trip() to call handle_critical_trips() only after
> finding that the trip temperature has been crossed on the way up and
> remove the redundant temperature check from the latter.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

