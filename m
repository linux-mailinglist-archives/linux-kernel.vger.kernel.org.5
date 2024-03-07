Return-Path: <linux-kernel+bounces-95925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9962C875508
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9B6B20AAD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3B2130E21;
	Thu,  7 Mar 2024 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7kqBOCz"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B17130AD7;
	Thu,  7 Mar 2024 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831986; cv=none; b=IXylt/pxChkBm9CyFoRhiG7InN2Itncn40FNNSSGRTx6WLkLuxWoDTgb1bJRE9kQWXemxXmhJxk8aLp4yzuwFtXKbrQYv26++ax2wY3noqu4xszXRPh0wNL9RRdM9CT5s8gaOWm76pjLD2fExNmH6q4i9g2pwS500k+0VT40VLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831986; c=relaxed/simple;
	bh=H4bD+dUV3U31Y6uSHKD7pEgNk64+g4AzzHDsO0LuDiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baVzncCwVK95FuUZXYnlpE2hPf8da3jLMuy5xuC1uJjSnbeZLv0rWMzBkC9mEZadjy9gM8ISlH7wvOJvzGOlIlaI73UECGpXhSOHU7+dvKD0ZC6ZXQLm9dP1fm5L6pJvh4WdShfABluo6D1HWyVS76gWTfXihHpXI3Z0yAxYQr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7kqBOCz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dd3bdb6e9eso8355565ad.3;
        Thu, 07 Mar 2024 09:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709831984; x=1710436784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANZKvRuKEyk1DbIC8r+j6UA/ZQWjgMtuId0iZKV/RPY=;
        b=M7kqBOCzUhRDt3LYlJEBzKc1TOtEMumeX4diDCt5YyBtlzOKTF7m1SHx/grvKBrsO6
         f+dveaWuj7bQ0BkBOBoLZb9P1G/4yVwSuXXQG+2LzzaE0VvyfzpbiUbw8g3ZE2O9SN/+
         taueVrUx8gXr1fXqn+Y+MTXrhtipYT27Ab24CmjA4x+Lz+Yuzn1cYlrvxVxA8nyTPi9x
         bijDgw4u/qyuqVY2P1Dz4DPkzhDMm002lViliR9SBXcIk9r7NmLMGIIsU7y5gpavdyGO
         g/XVhV/QYLJYMQ54Kzdi8usM1++u9xxwjkdwg/tTxWSnbH7mwlCz0RhjftuZSRvCz6Xp
         sbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709831984; x=1710436784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANZKvRuKEyk1DbIC8r+j6UA/ZQWjgMtuId0iZKV/RPY=;
        b=Ow0tuLdxbraqT0NsgI+MDfM1sQR7rlcvtg83NRBiUddN2DzLpxU4HDvxtfVizuk+sx
         Hu+aR0JJtwrtg9VL9TNmVBy4yMQoSNTzS6vK8q4ryelRv0SyWVVxVu/Xhtvd0aVhPt6y
         WsNb1xF0jZJHEsDfIjAmLu7gaeQJgHDJ3iI2YnOq2z8kF6oQPcGZ71HFg15UkP0EvDUA
         VBrhT9GZjjB6h5dNFqk1e+Fyg8zmZy1wxNBRfp8mfwwcwKqXjZak/HXTuVdzuoSJzqru
         XryDoMsqYYTjoi84vcXsXismVycCmde1U8FpO7KYorC5pN158hCsGPMIZCO3adF275XH
         dJWA==
X-Forwarded-Encrypted: i=1; AJvYcCWFHGXABsNaOwc2ifLO2YLMrEl5Plg/orQTlzw6uZYRhL0JGLhkgCxSqyaFRhO726wti2SHCgwfRwcuvdbTkA5Kap+egCFUK3inDoyNmcIEerA1XO2zIGyobUQjEr6ijQwPAxaaqPJJssE+zJxibCq9roVo7XICppYwQQLfJ1LFjao=
X-Gm-Message-State: AOJu0YwsQSHm8wgWmdQfVg45MxFk/K1c6peQ/Y1KGOupOBqt87v3DHrJ
	CQ2V3pIjbT0TlfQIUTCFu/EqRS+b32PgfZHJBOb+qOaFsJAAxbZCvYBN2TBM
X-Google-Smtp-Source: AGHT+IFos/XYvn4pB+sK/6cL2Y948dHXQlJpLckBVtmirW9ysYevsP99gOTZsPgHAYJgQptZYTgINQ==
X-Received: by 2002:a17:903:2341:b0:1dc:b3ba:40aa with SMTP id c1-20020a170903234100b001dcb3ba40aamr9700353plh.47.1709831983749;
        Thu, 07 Mar 2024 09:19:43 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902784500b001dcdf24e32csm14466846pln.111.2024.03.07.09.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 09:19:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 7 Mar 2024 09:19:41 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Josua Mayer <josua@solid-run.com>
Cc: Jean Delvare <jdelvare@suse.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Rabeeh Khoury <rabeeh@solid-run.com>
Subject: Re: [PATCH] hwmon: (amc6821) add of_match table
Message-ID: <534a40d5-df07-466c-a27d-030c5bf93070@roeck-us.net>
References: <20240307-amc6821-of-match-v1-1-5f40464a3110@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307-amc6821-of-match-v1-1-5f40464a3110@solid-run.com>

On Thu, Mar 07, 2024 at 12:06:58PM +0100, Josua Mayer wrote:
> Add of_match table for "ti,amc6821" compatible string.
> This fixes automatic driver loading by userspace when using device-tree,
> and if built as a module like major linux distributions do.
> 
> While devices probe just fine with i2c_device_id table, userspace can't
> match the "ti,amc6821" compatible string from dt with the plain
> "amc6821" device id. COnsequently kernel module ca not be loaded.

Applied, after cleaning up the last sentence above.

Guenter

