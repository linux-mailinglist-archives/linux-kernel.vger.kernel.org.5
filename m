Return-Path: <linux-kernel+bounces-163200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D2D8B671A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96DB1C21640
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9411FAA;
	Tue, 30 Apr 2024 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jiTgPDIQ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BFC8C07
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714438808; cv=none; b=bH9J+3MaqXCs0/4khMLq1NOOAB81PCQW/9tNeoI0/EZkE1kFIdI4F+f6MMRbwusrxE0wkOkfJsWXBEyf47Fm7jkUDc4sIyz7+PLsFzURh13GMC/ahxyIsFBPcvfsOdBnxjk/OprsuPgwoIbeN3PpE5mtTRp44LS498sE6hgPbP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714438808; c=relaxed/simple;
	bh=v/3ypErDQNVa5jM2PW3ZxxHtoGiydoIMw9j2sXoqxmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ka2shd5pkMfL6BFZnxIUyVL9e+muJqRz7rm3gmsMvbXTf++SzCe65YFAiEaN5Te9Qc0/WrMdJiqorqJJRMmv+vDPbubwuyk2w9KWvGx0S4+nAz1doxj5wQCgXMKXwE2O0LsoDw96LMs6FYpEfaxDNv+b9xrfu18d4/W4RAES1gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jiTgPDIQ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51aa6a8e49aso6285267e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714438805; x=1715043605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MW0gqjW4MurI9jv8tMts5CfcO8yjTWyj1BIw62uNuSo=;
        b=jiTgPDIQ+MNSOlLlWy8wkW7sZ5gw87ziGmOWuvVa8n322C1Myl5dQptoW6aCiTwxN3
         COmx36vMCaP9g/4tI9Eo0WZpFZXpsCkHtQOK3kKzWaapc0vbtLexh/fTAXtD/XjVPVGV
         47w9SPUC+dcjhidP8C7AXaGaO2TaP1G9r0pyzzIH0nxRnU4i9AMpuwmNGdrqaUI9Tb1S
         5VKRclT7pbVOubMOoVGE8KzS2WNcml/Dpy3VZt02smOIl+Zv9E3MGiJX4wlkiicyEwkS
         LldffE9PXP0GtmMuEZf0/+Mq/ncneyulcruZn4xZ1tv5agw025Il2cFuZ/ccDjgGVB0Z
         3oQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714438805; x=1715043605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MW0gqjW4MurI9jv8tMts5CfcO8yjTWyj1BIw62uNuSo=;
        b=gmRrN7lgp6kibjbF7U20Ch55ZLM4ljozdPvYGJzAbqTMi+1gQXFCUppg4P/a3zoVAY
         5F+unFXfzbtZfukbz0EFlrzudD15jk8aMQ47CrvNDLIOtAlghLU5b1LaB2l+yzSe4KN5
         oRUiUH/TqOoU1GSNIumagzGUzPTLUuEvyjgQpkjVlej2fiSWSVD/yr8lSTsiq/0+27pQ
         sYjnM80Uk0q9Ev+7Zc6DSS1KxfJR6VA+m6JlVv1Lxml9kyQ33wIxyeG6ESFxUxXpSgll
         fUgD3hF8QtKV0Wsvn2so2EljP7Ujt8vHlExIci7sbIxfCi2J0scDjHt3gICpAVk/FhXp
         MPAw==
X-Forwarded-Encrypted: i=1; AJvYcCUsOrqnz7VOKDgmbpyKyrIZKsQ16Z7x5mbtky2ledwvaTXBNiNSA/EAaVlA/dKGzwH7alpriu4JhubWjURQ7eeBpMf8omKKBDEIY9qo
X-Gm-Message-State: AOJu0Yy4929oGboDTfd0IQU28N1MFW4AJkfMaoqABlbG0OOwt4ogAoCO
	FnVza+nVbblZ/Q0SLTuBZN7QmpJupyoYtc4dAF0SiDKmz2Oqd1XUb/0Ujh5aIYM=
X-Google-Smtp-Source: AGHT+IEq2ipl3ls8zb9TZIFgBvt6x/YPQAoaIZznDXqzZLSoP6flW8/WnEU4hDj/Dy2Amhe1YlDM1A==
X-Received: by 2002:a05:6512:5d1:b0:51b:6d63:e0e4 with SMTP id o17-20020a05651205d100b0051b6d63e0e4mr7208497lfo.29.1714438804631;
        Mon, 29 Apr 2024 18:00:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id y21-20020a199155000000b0051d108efcbfsm1088936lfj.81.2024.04.29.18.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 18:00:04 -0700 (PDT)
Date: Tue, 30 Apr 2024 04:00:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jameson Thies <jthies@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Markus Elfring <Markus.Elfring@web.de>, Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
	linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Benson Leung <bleung@google.com>, Bjorn Andersson <andersson@kernel.org>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Hans de Goede <hdegoede@redhat.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Prashant Malani <pmalani@chromium.org>, 
	Rajaram Regupathy <rajaram.regupathy@intel.com>, Saranya Gopal <saranya.gopal@intel.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/4] usb: typec: ucsi: Fix null deref in trace
Message-ID: <bs4r3zdc52l7zfwphiycljucjb6hqcuadq3ecgipxjgs3wj6ch@7em7rhspi7j7>
References: <20240424014821.4154159-2-jthies@google.com>
 <6e028bfa-9063-42ac-b40f-cf17a81c2af2@web.de>
 <2024042547-shimmy-guileless-c7f2@gregkh>
 <CAMFSARfOYWy0a_iZyuh9e8++xHdAYXcs2pT1_yJaJ60tHR17xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMFSARfOYWy0a_iZyuh9e8++xHdAYXcs2pT1_yJaJ60tHR17xQ@mail.gmail.com>

On Mon, Apr 29, 2024 at 05:43:16PM -0700, Jameson Thies wrote:
> Hi Dmitry,
> what are your thoughts on Abhishek's comment? I think we should
> attempt to register the alternate mode when CONFIG_TYPEC_DP_ALTMODE is
> not enabled. It would give us a more accurate representation of the
> partner in user space. I understand your point about ignoring a
> potential EOPNOTSUPP response from the non-stub function. What if we
> leave ucsi.c alone, and replace the stub function's null return with a
> call to typec_port_register_altmode(). That would register DP altmode
> as an unsupported mode when CONFIG_TYPEC_DP_ALTMODE is not enabled,
> and fix the null pointer dereference. But, it won't change behavior
> when CONFIG_TYPEC_DP_ALTMODE is enabled.

Yes, this sounds like a perfect idea!

> 
> Hi Markus,
> thanks for your feedback. I'll update the commit message to say "null
> pointer dereference" when I upload a v3 series.
> 
> Thanks,
> Jameson

-- 
With best wishes
Dmitry

