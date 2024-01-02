Return-Path: <linux-kernel+bounces-14459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C67FC821D4B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C4C1C222E1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EAD14F9C;
	Tue,  2 Jan 2024 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r40Mf/JQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73414AB6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d76923ec4so33209105e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 06:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704204221; x=1704809021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6jx4kCirWEKyRJhRB+hSiaSLY7KMEDa3xsSh/eHvycU=;
        b=r40Mf/JQ8+S9anS0pEeiVcybfeGVCYdlQc6lmRl02KSPCvVbP82gGDkmJ4hNOXYLxV
         p5cFAjatbjLmRQFD61ElP0Dy7QDZeWNhyE+HmcB47801L+bz2YodaCmfxIg8PzLe7Tkf
         4hgPu+njE8Dup8uUKhviNERAEg+VB6aNjy2Lqs7Z/cEiyhXKvtdozU+vD8zolBIiuI0G
         /w7K+6nBYQAaK7sf1qptFSfU/XRxoemRC7SK07i9Kh0ECv/yKsSd5qNdbyHQDJ2TDhhH
         wUo+ZU6bofGlkF+E8GgnjpfUiG3shUxdoKLN9uBV0esjmMeWrqA2/M0i1KtOXxiPUyb+
         1KLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204221; x=1704809021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jx4kCirWEKyRJhRB+hSiaSLY7KMEDa3xsSh/eHvycU=;
        b=ibI7/xHaWhEiHUJsk98aaa70mQrJ+trmX3jub6+CDvcSsfJc3chrQTYM4iUnZDABcL
         mI9F2VWfL4UnbeqCJKgzw3OL6Ow/HpKWM8mh5Fe9yhKZ8EjdCmW6mN1r3YGN/JGAXtA+
         tCVZXvQE/I8xe1imRTKbxninSn0UrwSRiMLpsUuBt4ItWK3GHMFeP93M5mjqEdABm/0f
         EBAV6tLw91Eax9BdYGv27bFl9GTOdSNJbYHSYjHrTUDCJy1hY9MTC3WmRyz2wmozLoBm
         oWHwSCZjhAuCrpv50mXJN2YQ8WGMb2fNztqgwxwyTtpsXQrcMmYn05n4soxIwPKKFBqq
         7Z/A==
X-Gm-Message-State: AOJu0Yw+Np4ndkeEvDJJbrxlMc6MIa9otuaVn35i1aV0yJsTnOgQa+FP
	2fLorXHLJq62YtVDFLOdOHTlVLjRP01Zew==
X-Google-Smtp-Source: AGHT+IGWYIKvLFu7hD6N6JHD2l27CY/uzIzKJYH+mrqppO697Hszjxa8CpubpAtiUgM0X6ER68IsQA==
X-Received: by 2002:a05:600c:538e:b0:40d:7a8e:3476 with SMTP id hg14-20020a05600c538e00b0040d7a8e3476mr3382517wmb.20.1704204221326;
        Tue, 02 Jan 2024 06:03:41 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600c46d100b0040d802a7619sm13969451wmo.38.2024.01.02.06.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:03:41 -0800 (PST)
Date: Tue, 2 Jan 2024 16:24:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nathan DSilva <expitau@gmail.com>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	tdavies@darkphysics.net, error27@gmail.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192e: Add blank line after declarations
Message-ID: <556cb2ae-4402-4f69-ba41-fa212deb2c78@suswa.mountain>
References: <ZXvevJ2vEEQ92rau@oatmeal.darkphysics>
 <20231215152918.532037-1-expitau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215152918.532037-1-expitau@gmail.com>

Also send the v3 as a new thread.  See my blog for more details?

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch

regards,
dan carpenter



