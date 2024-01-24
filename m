Return-Path: <linux-kernel+bounces-37414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C709083AFB6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8029328C7F8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813277E798;
	Wed, 24 Jan 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXK9nLAM"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FD77E789
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116874; cv=none; b=OOqgRL6gWC8NEVyHUWTiCsVfHay7rHYig7y12VDE/AVDQmZ/aC2MH8K262SM4vWkFfZgO5FS8fLJvF2CiNujRFgKEblY4VnXqe9xuojXAmYq2WhW5F3GxFIOiSYoX66YRmTKk1eji2CWevGOCZCczVqcwgMIIHrjh3pC3orPLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116874; c=relaxed/simple;
	bh=4xiz0GcQG54/BySvte8DcHDS1R9W9I7lbxkZQ/Iv5WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mvn8lSj1E82xNBLws16fmCY59IBuAs3o14WUnPxSdC7eOlB+aNLJi2i/fU05LdxfPiH2Pfti8CEyx/KaGDDzAWGpA3rBkhxc6/ibcTnO2mDLdKQvggMLcRazGsxwnEUr9J4MTiaZUCS1H0BQzqRog1o/Ot/cfbjOhz/NsE1+dIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fXK9nLAM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40ebf373130so20427045e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706116871; x=1706721671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4xiz0GcQG54/BySvte8DcHDS1R9W9I7lbxkZQ/Iv5WA=;
        b=fXK9nLAMsX16J9E/9Qf8l/kbYDzwLwQKvReg3QVxLVWpCGvOK9GO42gMDxq4CJRoWi
         aBf5jMkWE1otqL8yOhAO76nYg+OJ9oDDBHRkt1NVfL3A6kmjRFoplrYN9HjrdblSvARe
         Lf1HxiQSBUW5MSbNX9Gg2XcrYoUI/I0Hho6laYX93Hz8W1vmzLTSrqvBAiWd7ejUt6In
         KM58vJ+ZCYwyGfQD8j1ONeW/9O3blMiByEGgfi1hmK3kidHv1rAAidfwderSTIVhJZhc
         HAZgPsIYqcXvZio2jEV64J82xyg8wvyco/yXTQvJeBLL4ce2DAThhui6MNSaOZefon1f
         1IpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706116871; x=1706721671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xiz0GcQG54/BySvte8DcHDS1R9W9I7lbxkZQ/Iv5WA=;
        b=esHBDiW56pklsh9TV3RtqtQissxRWGS6VJA/Tu5IQQ/dKUjThhoJD6Zb5AxKTIrLHc
         8/xkoZ551VSYimOW/rWF5udSku9/qPUnTwgWjSou4Szj2483goH8K7b3QRkPBOUg8/9q
         y68yDZqaogrVduzmu4p6FmIAAntURIH9cmSqNJrdgFPeWJDHHxtNPsy2qj06FvgYqqEw
         80wnWtFRlc1DWe/wBvF1AmCt9b9gODXZNacgKamXTEtFoTBcaHolYFuNChLmKouFVREg
         vWDpKpaLFcmfhVcp5QA2oLECrRnueJLU9hKYS84GAegI7uiK4f9rgdoQaNNRdmewj4rl
         vziQ==
X-Gm-Message-State: AOJu0YxuGeCGYTnlPEok46r6gQK9DHr7zLU478M7N08avCxI89ZLlBSs
	8c+vWl5doZc37cP5FVv29W2ml4osBNfOkWpSDXPq1zQVXfWOjCXtvOB0wLbdXbQ=
X-Google-Smtp-Source: AGHT+IGAFW4D80dnsAHiW82tmDEk0cyiMsQBq0972I3W5BOphHDe6lKpbk/KrXx73htiztW7fMICCg==
X-Received: by 2002:a05:600c:3d13:b0:40e:c428:4a6b with SMTP id bh19-20020a05600c3d1300b0040ec4284a6bmr889987wmb.13.1706116871447;
        Wed, 24 Jan 2024 09:21:11 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id w3-20020a05600c474300b0040e549c77a1sm279382wmo.32.2024.01.24.09.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 09:21:10 -0800 (PST)
Date: Wed, 24 Jan 2024 17:21:09 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v1 2/4] backlight: hx8357: Move OF table closer to its
 consumer
Message-ID: <20240124172109.GA15685@aspen.lan>
References: <20240114152759.1040563-1-andriy.shevchenko@linux.intel.com>
 <20240114152759.1040563-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240114152759.1040563-3-andriy.shevchenko@linux.intel.com>

On Sun, Jan 14, 2024 at 05:25:09PM +0200, Andy Shevchenko wrote:
> Move OF table near to the user.
>
> While at it, drop comma at terminator entry.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

