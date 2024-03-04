Return-Path: <linux-kernel+bounces-90452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462F186FF5A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782E11C21996
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBF8374C9;
	Mon,  4 Mar 2024 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHc/qnd+"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3041325764
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549094; cv=none; b=ryeYoByTuJ4UcIaD15cAgBAhLNaEoEqQ4jhPoWGQf9TqsYmW7uggyfvtiUCHmEiaYKOadyAGATaiPYuM+4F6cup2/cc8KW0LlKk2s7SKN+M7FCJ1MhW6kv3AjiFbzDfz12Dmt+iTdiejYAt60qt/WfHsgTd+9AhcmQ1yd2MGBgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549094; c=relaxed/simple;
	bh=DShOdkyxQQydWFkGrr4h1cWbRj4V/cqaen17JYA3fLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcviTW/mqYJMWyZ/8J1OKnUiMNqH0VyTNU0wHmMAkWzbmhxwlhmn30TPuBQjF9Eag4dptTZwRO+g+Wau1b36FaeITTvqYih07cLY5Rj11REZeEehdgrI1CRQ2mYjDO5y3HKEjsR4x2vEmK6rYzx0PYF9UCGINscIPvMOtFYkl5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YHc/qnd+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e162b1b71so3295192f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 02:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709549089; x=1710153889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DShOdkyxQQydWFkGrr4h1cWbRj4V/cqaen17JYA3fLo=;
        b=YHc/qnd+JSnx05cPqvb/C3njAEicMucAFRNqoMDBp6nkWV38jk3DjPB4yAjfO/MJ6R
         U10Z7UvOL6O00yhWdCl55YMM3rr5jM6ji96MfOUa6ZJnyLGl1aidQTmNd2a43fXtG5jG
         KnCu+lkbr8b7Eu3wthl3X2dPRTD9K33K1LLZdKqBr2BMtFzMWj28RyADTn2gjrLjEO9f
         Mf6OETZ1MY5s+/G+dc9AF8MFFBqOa5pPdVEwErkY0qJ9DsepIj6+ZxjAcn7lJp4EMH95
         d62mh8HEtWdIncCE9bZUX4fkGt1MuGqhikVLFaaUwcQxcHreEqYRcGG7+/2AM5uUsbHF
         p2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709549089; x=1710153889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DShOdkyxQQydWFkGrr4h1cWbRj4V/cqaen17JYA3fLo=;
        b=BY7hOUsJD4T/oOFFVrjGWbWhTObza7w249h3JfRf28XjWV/yx+E8/uxS4ZpMaNqbe6
         XIA6ExYzmHp+K/UnQ7E4DdNHSHIGO3FH0i8cYVJC01XQZMiA43bZUs2fpvPV5UKIkN0w
         xb3gfo3IQ936/3bceC13tqOoD+JO9+OYRybjPwalON0NtmVGKgg9RypUv81guFMKdcWo
         VxRiCnLasEYUSM3zVeWTLMSAq/B71909xpPQ1hUs4VS62H9DhSWxpAsyQxVKz6IhvJwm
         OJs59GQ6ruxIXoFNdFBgnjcrN1l2fOeN/5aaaehten9JUVNRQqIUqIPqEPNsuTyNxSEt
         dg5w==
X-Forwarded-Encrypted: i=1; AJvYcCWcrSkfAs0NUzib7/qbYITP3wrd6jJJEYsHod79EBPpWZDnRnei9uLTll8ZWto8L9qxzrBxjjv5/ZQa1suzQvaT20ICqSPZ1XzuBGRG
X-Gm-Message-State: AOJu0Yyo+yMpcew67e5Dl+2DmPwPmGcsjcCDE/omO4HXsXf86CVnDVnb
	44T6PW8TiNE8YBjRoxvW7lw3Mju9d793FguGuDV+uIUSjfpze7ipwjrewAo1R68=
X-Google-Smtp-Source: AGHT+IGHNvJcAynoDjTNPW/ad/wQJ0F772XQ2t3xcrYzgUbC2j348i+2RyW2OuqOddYLNpQK9qlF5g==
X-Received: by 2002:a05:6000:181b:b0:33e:162b:5353 with SMTP id m27-20020a056000181b00b0033e162b5353mr6523335wrh.16.1709549089558;
        Mon, 04 Mar 2024 02:44:49 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id t2-20020a5d42c2000000b0033d7dd27d97sm11832699wrr.45.2024.03.04.02.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 02:44:49 -0800 (PST)
Date: Mon, 4 Mar 2024 10:44:47 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] backlight: lm3630a_bl: Handle deferred probe
Message-ID: <20240304104447.GE102563@aspen.lan>
References: <20240304-backlight-probe-v1-0-e5f57d0df6e6@linaro.org>
 <20240304-backlight-probe-v1-5-e5f57d0df6e6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-backlight-probe-v1-5-e5f57d0df6e6@linaro.org>

On Mon, Mar 04, 2024 at 11:11:42AM +0100, Krzysztof Kozlowski wrote:
> Don't pollute dmesg on deferred probe and simplify the code with
> dev_err_probe().
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

