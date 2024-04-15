Return-Path: <linux-kernel+bounces-145102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EF98A4F96
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE69283FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9B5745C4;
	Mon, 15 Apr 2024 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HX7DPTIZ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238DA74414
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185356; cv=none; b=DOY1ObjbAQYnCPXE4TJla6JYP1u00h2tKvTG1w24l4gsJHqdAc2yym8aAqSFsTb21fEF4pBtO4mxMues9l9dZyLfWXoVagu45P/09l520uRgrJ6VXzbBOtsqHjIJOqiPs9PhNhD4jSUYHSsjLP4c6SuOWVVGSIeazGbDidWHSCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185356; c=relaxed/simple;
	bh=UimYHbIWNJzstbVfXQ3wDGyO5qJZelnD1Pr7R7RINlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+/JKeqfq8mHi35ktWV1lCOdWx/C1Cgc9qrCKei2ay2tZWc+0+jPR+FUhLpNF/2RGjmJ48z+v+2hDuvrT4H/rFjK1A2ur7XpZ+4pccbtZq5tFC0iyHR/Cj1Jm8zSA8PlvIiOYBucHsaSDNpX2Bt1bPRiZwHRjm5DgIE2cFY+yWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HX7DPTIZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41879819915so2703345e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713185353; x=1713790153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UimYHbIWNJzstbVfXQ3wDGyO5qJZelnD1Pr7R7RINlo=;
        b=HX7DPTIZaxzoegN3sHKimHkG3nrx5yoTyOBKQKZo2Dcc9U17zD52ndDLR5kPE8PV2V
         xbVd/UB0rgu+BHp4gkc59Z22M+hSsOv3DU6wIzlLkc6DWsolBvqpxwPLP6Gk8twxvzmG
         TpkNuITDDhAb4MhZvmo2ogQobMEL4cJ2usPiY7iwgQfuN8oTdjzmWl9lSRg5qc6VIaO3
         bAKArGlO7lcPD11osxYdiljVdPCRkMVaWLmmrpT88p5lMbIPOMS8MsUvQvDAL80sdpa7
         w6KnIQo3+1XnNFVR4F4kvvddDpK3GTO80BZsk3AaiOmaXqP6OzuIEYWg/ROThGn9h35l
         o1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185353; x=1713790153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UimYHbIWNJzstbVfXQ3wDGyO5qJZelnD1Pr7R7RINlo=;
        b=InDjIRrt2YfduC5euc08E0V9XDGnIcmdERY79lD3Dku03IOKsNJ2dK+i+ceLo1qHBZ
         bIniZhA0oYatlYouy9YLwq3DSICzQC7M/CMEerSc+StyVQvZ6tC1zOlhOW76o4EByxbH
         NKdef1/r8VmEhWQiPMSQCaPPnGH7OzTGa0sTAM3CjPsFIh/TsqQ4hgtHGTALBUxSxfIJ
         R1mmtoBHuL8Gto4z94ZLlnhLxUVQvpTS3ZikpD0AMjxgyiwcTAYfyDkeNagYufTHTfhz
         D0jTj8BHDLB/jz8FlND2oHsogyyMCw0Xg/wBmHE3bIETvuiNsAkCkMukuMGfqeAxjFR4
         5Jtg==
X-Forwarded-Encrypted: i=1; AJvYcCWcbC2NmkqxZJzAk9DbQAy8WtIesp378z7ItqEPkbZHb823CjlVtPB2JEifPPt2h0P+kxUwE4KguIiT2dK9thH5ue6ODDqTtCeU9HR9
X-Gm-Message-State: AOJu0Ywr9/9IJoI49l78uZ8plqQku/c+qLg24cHgIhXgiMMQSRJ9xa6N
	dOnUlf+rfMM8x+wa8xHBKL1i9FTorz+IY8iUUCkYe0dJdJ2lHVy4A/BkC1+T1CA=
X-Google-Smtp-Source: AGHT+IGio3O7mWx35mEvR609b07A+RZnNzN0tC57IoZigX+R2Bsw1mIXox4a962UuZkyigWVe02A1Q==
X-Received: by 2002:a05:600c:358d:b0:417:4ff3:391a with SMTP id p13-20020a05600c358d00b004174ff3391amr7933682wmq.31.1713185353445;
        Mon, 15 Apr 2024 05:49:13 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id d4-20020adfc084000000b00343c1cd5aedsm12044366wrf.52.2024.04.15.05.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:49:13 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:49:11 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexander Shiyan <shc_work@mail.ru>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-omap@vger.kernel.org
Subject: Re: [PATCH 04/18] backlight: hx8357: Constify lcd_ops
Message-ID: <20240415124911.GD222427@aspen.lan>
References: <20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org>
 <20240414-video-backlight-lcd-ops-v1-4-9b37fcbf546a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414-video-backlight-lcd-ops-v1-4-9b37fcbf546a@kernel.org>

On Sun, Apr 14, 2024 at 06:36:02PM +0200, Krzysztof Kozlowski wrote:
> 'struct lcd_ops' is not modified by core backlight code, so it can be
> made const for increased code safety.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

