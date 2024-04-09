Return-Path: <linux-kernel+bounces-136404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B657B89D3AF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43B9FB2236A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDB57E0F2;
	Tue,  9 Apr 2024 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qh0+Ccw5"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38174EB41
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649639; cv=none; b=Ur/VkmlFp+BDdSVNFItvLB1udR8cdZsJns9OBqS/za5NQJAjG7RlQYRo4zHcY8P8+xjUPdCs/QZyNaCG+bgxr0MA9kMS9iDh6fdhhHtWI13AOeKOrWyELO+c9VkXD1chNNPorm0XTXbZ6n1oDht41+xzAtkAMJwpMXLGUG3Y++k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649639; c=relaxed/simple;
	bh=avVXALww2VwZ9gN38ctn3234RAy9lcjvts1P4UvCWU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS4Zoi2f2gVfu/4/PCV3HBoohh/xTCNONarlsle+RNY24G6kP3xeEpo+ejV47UOBnm4JIg4cHh5Yk1A4w3NCzS7UG0a7FRNd9XuFbIsC5l0AfqnRxno+kfUNgu/fJfTZTCM8Hy3TiHLSd0vvxDO8oDI6En1sKGueqXhe1VaIEQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qh0+Ccw5; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e448d6f9cso1401697a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 01:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712649636; x=1713254436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ONlMZGZ9RPYiJA+pih4//jtldRttSyww/CoJiXseC8=;
        b=Qh0+Ccw5fnZ6kW4s1b1CPUhsNvQzvO9KwqlOJIDd3gI2dMVPv97UlaABlG6qsc9jVe
         rBgBQwpna5xVB4NHuAWOqWRV6fQR7E7Exx2DLexOffPjSPKzdBi56a4oZ9OJzqdNzV8T
         tBcJEUolvbyPYYjSrdai5sMPQMZRjVn8lLB70w5aLRNekbpIcND6zXp6Fo7AA+SJqHTZ
         7Iigl2IvvUvx/oPHtL955EQU10LAMmyP6EqbSYglcvuyy+MTYKuwn3nlMHB7gFRz+0gD
         hxlCFMnbhwzuDIbTur05hE3A2FI2MzqXk2RckOqKN2Gp7JzGGiT+HaTS1gIaXAt1ye8P
         Y4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712649636; x=1713254436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ONlMZGZ9RPYiJA+pih4//jtldRttSyww/CoJiXseC8=;
        b=DN5mP29tq7wjfWZySWcdNhb8UV5haeJrATdXQPjtDMz/x0pJmu7Mo3CH78aXe/2Kie
         mB7OLPsMVSYfLu+0XsjVHhkWe9qb8m3ZEIY8mByiMRBiIjWBYSqMc1jnr+YCcuxDmy5B
         3Hbjr2zdULz1XAOQ/5seaO4in2kYqgwgpBtlGVzkTcKcnx1j2DZ9T/1Vlq4ub82/LD67
         471X0MCpQzA13vNuDLTNIUgsJFoXTBEapSvlm2q7OEeWOxGsnrcxSLzE6IfWxwKSqXyX
         Bn1AbPIRZE89/+93EmfRj3B3Zbc7TJzsbAwAH+1IZUOUJ+PmSnNCy5f82PDIgyTfsw8G
         DD/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlsV0ZQROOA27MKaQjnRb34tJv/zluEGD5Sc4if/XsIwMx1n6UQzoT2mK/pGsefYMu0/tWyhuYmGVPX6cCwdtZ2A7qc4SIU/yZPknl
X-Gm-Message-State: AOJu0YwaS5e63P5QqCH6hIkVLcK3eMCPTirJneQF3JBgZtqYYGdBWpB4
	hq+XRvCcnjyWESQGYATHZqU0Rm00FKu9NFkBLfP4RCOC1/Ciw3zes0NdbUe1dWw=
X-Google-Smtp-Source: AGHT+IGxEblWAkIcMvVn/67TittUpAQ5r3yIpuR2HIFYIIXkYrL/8PqoXuJ527K8Niw97U0bA6lP0A==
X-Received: by 2002:a17:907:8690:b0:a4e:2600:3fb6 with SMTP id qa16-20020a170907869000b00a4e26003fb6mr4485405ejc.62.1712649635877;
        Tue, 09 Apr 2024 01:00:35 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id dm14-20020a170907948e00b00a4e24d259edsm5289480ejc.167.2024.04.09.01.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 01:00:35 -0700 (PDT)
Date: Tue, 9 Apr 2024 11:00:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jackson Chui <jacksonchui.qwerty@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] staging: greybus: Replace gcam macros with direct dev
 log calls
Message-ID: <f851a212-4bb0-42ca-91c4-1ee44ea9ef4c@moroto.mountain>
References: <ZhRzWNiak1qOdJLL@jc-ubuntu-dev-korn-1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhRzWNiak1qOdJLL@jc-ubuntu-dev-korn-1>

On Mon, Apr 08, 2024 at 03:44:40PM -0700, Jackson Chui wrote:
> Reported by checkpatch:
> 
> CHECK: Macro argument 'gcam' may be better as '(gcam)' to avoid
> precedence issues
> 
> Inline standard calls to 'dev_*' kernel logging functions, in favor
> of 'gcam_*' macros, to clear up gcam-related logging.
> 
> Signed-off-by: Jackson Chui <jacksonchui.qwerty@gmail.com>

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


