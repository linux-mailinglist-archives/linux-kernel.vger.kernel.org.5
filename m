Return-Path: <linux-kernel+bounces-34755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B97BB838725
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2141F246EB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B854F8AD;
	Tue, 23 Jan 2024 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRKnHnkl"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6914F880
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990306; cv=none; b=Z36yvhWXDN90lUUco36VrN9S3gCUjkErwuXoxR6Mb6em+iQExytYD0RPSg6oIQLpHbOW1AmKjENAT998dbx96V/S66t9WS7sP/xcwNUVkOvzyBBCCXy6csYd4CG9xvlDHWzZvcZSANIPigbs7qPwqDzyME0hgbrpDcRTm3+yfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990306; c=relaxed/simple;
	bh=CN9XP3IqMW/054i/SszfD8BegSj621QjpufQVB9yQaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qNhHkwWHAYob+07LkAu77JgnchtN7MmgQT9Q3Ds53FCqNkshaRdnM886zEl5d6Mk+/iRlWLx6bXe7X5OG1JAYWfcFsw6zoMfpw484Zp8kpv4SW4R7FwlYrcFKpqKDdM/2DGoCKk/zwcuGIOYIPsW7WbECcp6UG3JlTOtNAm7O+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mRKnHnkl; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-595b208a050so2446205eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705990304; x=1706595104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ohXdSRWKpjp/SSHD5uSCqu3QqGgmhGSWzWcMPZ6VRxw=;
        b=mRKnHnklKFUemg4aOxXYjyGWTrQH/3qD8zcCSSXfoE1B2cYIvm+igDGaowY9BlUM0h
         am0WaTWle50a5c8t/DvazxDFGQNXQf41oN3pGLly7GC58lS3LqHn2GVB2ld4efBuFpDQ
         1iroC8oFUkLfGsazNAzGIgfUfHt4qQrECVbUZ0M+BPaxgw6K7FO8/XiR/xqbh3CZABxE
         k9F1LaKTmxuLux0qSKBHKIwovYHjXp4z6MzAuys2Ffd7BQc9fAIROVJpchmffqd7rJ07
         UQulMGM0YcumWXdwi2ws3cIlo5nhfIKqI/fKccPh9Xp355IUe16X3SAP53w5NmAttUIZ
         cR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705990304; x=1706595104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ohXdSRWKpjp/SSHD5uSCqu3QqGgmhGSWzWcMPZ6VRxw=;
        b=CIQs2uW65Xbo6zfiUXAtPIvPNQGrXX8/Fzm9/1yiNoQIRuE6kYG8SMtZR+N/noJnqZ
         MA35Pzs/u+RregLTM5xk653ubf819theoG8ETNk7getEvBTNjP3bSQeP9JluKd/5zREi
         sxkCCNlqE3mPEhjeOXFDDwmxFvH08oOR4pEj9xExdyB+TATGKPTSJwS6E49KscbmDvsG
         /w9fGNSf1mCd3t/vOsZzffLnkIoBYO+WU0fYRs/fvPBbdz+r4+B65SBerL2fvs+XWCMD
         2Ih3ee/CRlkIWYoHIDwiub9+o8v0/SMhZJhPRdcNHsUTyx2nUOIkNWd3H6+diowG9dKU
         kMFA==
X-Gm-Message-State: AOJu0YwnhfFrjG9B+Q6ZBu/EOA5lI+vrDlRtPOepp2XSCs7A9Cdv2cvj
	DE9hDMMGKx+aaEYWydcN0XEfVboPvx4Qfh0Cm9n/9+bplFLDlHAhnxq7n6HpwkU=
X-Google-Smtp-Source: AGHT+IGqPA4W4P/ONndrUy91FyDVi6kg8yuFS7ylNJFUz04/g7/KgZtnfvrHv/8TfrRxG0FJuuas0A==
X-Received: by 2002:a05:6358:52cc:b0:172:e227:bfd9 with SMTP id z12-20020a05635852cc00b00172e227bfd9mr3703228rwz.42.1705990303944;
        Mon, 22 Jan 2024 22:11:43 -0800 (PST)
Received: from localhost ([122.172.81.83])
        by smtp.gmail.com with ESMTPSA id r11-20020a056a00216b00b006dbce4a2136sm5191749pff.142.2024.01.22.22.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:11:43 -0800 (PST)
Date: Tue, 23 Jan 2024 11:41:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Erick Archer <erick.archer@gmx.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Hu Haowen <2023002089@link.tyut.edu.cn>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: power: Use kcalloc() instead of
 kzalloc()
Message-ID: <20240123061141.k5wf6r6gn3w7qk24@vireshk-i7>
References: <20240121104344.5001-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121104344.5001-1-erick.archer@gmx.com>

On 21-01-24, 11:43, Erick Archer wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, in the example code use the purpose specific kcalloc() function
> instead of the argument size * count in the kzalloc() function.
> 
> At the same time, modify the translations accordingly.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

Applied. Thanks.

-- 
viresh

