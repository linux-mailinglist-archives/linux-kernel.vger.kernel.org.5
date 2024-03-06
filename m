Return-Path: <linux-kernel+bounces-94143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5605A873A81
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119A42817FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CDE1350DB;
	Wed,  6 Mar 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZuIa8ViD"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D7E131742
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738206; cv=none; b=qi7yXG2/mg0iuYNgeN+e2QI+TzPVphVjxSE/dBa3+TrbJIAWtng3tD8dKxh2IiFFxLVJUJIo7zTSE9L6YU8nMQUIm/p6WzWno4i/Emhl1ReMoo511pe15YEtoDS8x4PeR82k2y3tohzj8xl7G/HR2v7XfNwy1S44iwo2e/aygRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738206; c=relaxed/simple;
	bh=o2tehRP8VldR9ITvDj4X6sv+xRh4ood61fpHAeI64Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVtjKauYB+HkgmHPZpUZMq7GSqYSQCGXnSgnD5DkSH8MRqoB/jPOqghs/lJGon4PZbP8Rz1gqUtCI87IzFUWIa/Q1qxK3ERxJIMxO4vYcQldiUV0BemoiVgWJDehd3aymCcYxUuL/0AeL+M8m9mS6WH2nVy2BEdfyotJx9YO8K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZuIa8ViD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41305fe71e8so504065e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709738203; x=1710343003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbMXRNnfQkRZ0edUG1oFzjXLgUZ/yjT9H5O+qEGXIE8=;
        b=ZuIa8ViDGzPmrcVpcldAWHgVd75n1n40I2fWjx4wfM1vyIHovqVBVtxZxMV1Ahn//x
         7BjDETQFjnaPTAR2ybsuhrMx9gIxRH4fVb3ru/ZI6Q1uPKO8ZGo7RYwcIllC1kLVB2AI
         hhsvm+pIPlHybIHUStNo2m9+XwrpfY6ro3b7T6IS7z8f1jgLbG3KlTDIRS2BH3AEPCSU
         qlmX6NgCS6gPZ9IsKIjz5P9VdSPyX8Gx5TG8bYKx8Ic8bign92sNEl/DMqTaqNRArxN5
         rmmuFjoqxchTzuDYWez37eHjrjDfGCMQtD5g8dRrdCL2s6I/jG9i3x/w/MvCH8CO/45/
         RMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709738203; x=1710343003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbMXRNnfQkRZ0edUG1oFzjXLgUZ/yjT9H5O+qEGXIE8=;
        b=YpGVgO6zQ8MrRLuQ+8rLT/6f+LkURivHdq80ZaAr/cOYwGtWJcCstNJMS2/WQOOvoZ
         SovLd2wf0LnZ0MRe+JvjG5seUXcEU1TJ47xbVZGXYtF4gqRYWsAeb9Hi1e768vGobM9v
         bs/9MwgvLSH2ug+4pWg4irxgQKFOpaW/qIWw2472qy+EnzzQXRfQP4HpHDX4IwUlFckX
         RhFeZ9q17D/G+cg1xyTjob3KBiy+L+JxFDJRimbH56a6JGdJkCW/BWtYVLe/G0FRwTrk
         z5m9LlA6v0haVYxtDLWSQZKmtEogu7LWdQ5FHQJvpZs+lgbio+9+WxjbM4d6P8MH0QUm
         +cmw==
X-Forwarded-Encrypted: i=1; AJvYcCW7ec/KZSlfqp4ylsQzmnVcYBojHQkSfg9Znvww2D7vJcyfdGyCvrvjbuJYQ4YTGD/XkpKW4nuIB87REV2wEAlWYo+H08/FPVJX/ozk
X-Gm-Message-State: AOJu0YxDauJ0bfSI+6LQ0c8RxVGWudIQ23lQcqcmPCBbe+G3KhCVCwvm
	//zEAp7ycj1ukli3xgTUIMC2UdTjkbsDG2WEf2pv4otJnytsXttLoWVD19XwSH8=
X-Google-Smtp-Source: AGHT+IE+y9weXx3ygaJfAbwWVfVXS9x+mMOYhnkGQrUGfIQpr92/kiYwK/AqkYsiQIh1zyVWuNITKQ==
X-Received: by 2002:a05:600c:4f15:b0:412:b6b8:b5f1 with SMTP id l21-20020a05600c4f1500b00412b6b8b5f1mr12644187wmq.18.1709738202924;
        Wed, 06 Mar 2024 07:16:42 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id d15-20020a5d644f000000b0033e052be14fsm17775290wrw.98.2024.03.06.07.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:16:42 -0800 (PST)
Date: Wed, 6 Mar 2024 18:16:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ayaan Mirza Baig <ayaanmirza.788@gmail.com>
Cc: kernel-janitors@vger.kernel.org, ayaanmirza788@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Subject: Improved help text for rtl8712
Message-ID: <0eb384a3-5634-453d-b08e-a80db3fb742d@moroto.mountain>
References: <b442a768dd23d9c6fdac6fcc30bc86794e85c8f5.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b442a768dd23d9c6fdac6fcc30bc86794e85c8f5.camel@gmail.com>

Also the subject is wrong.  You left out the subsystem prefix.  It
should be:

Subject: [PATCH] Staging: rtl8712: Improve help text for rtl8712

regards,
dan carpenter


