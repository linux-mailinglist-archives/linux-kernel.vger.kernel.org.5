Return-Path: <linux-kernel+bounces-29458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16C9830E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9ED1B2530E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1B525575;
	Wed, 17 Jan 2024 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FH3Bd3LU"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626862555E;
	Wed, 17 Jan 2024 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705526534; cv=none; b=oXJ2VYX/q828DKkUO0ragoGvwboomAtPwHfKXzo9IcO5TNlhGVnYEr+Ym3ZJ1c+tFVTdB/q8sQspJYq8pSVKXJU3PU0LO6T6gDAe3sG9VQV5fJxtUu7CqrIMzrkcx9DlIwpP0cyJ/UFtl7RBTjGFFzBmmZeOM5+JbVbWEln4JRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705526534; c=relaxed/simple;
	bh=yMkH94Ava2a4mww+PKl7IpOY9qBSnxvwZkloI7X+mec=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRR012do0/rUyRB7ok4OPnzquHcKLXo7c9bqi5qXCepPNSdwZ14oN8ZcaUShshluyfmdbYS9rwESQN/Ntjxd8uiZvqcq9DoVxM5WUCh2yPHrMcWHGmEFkakbYycX1VNmhLZBlrPKEu+mp7OZuNKxHMsgH/fDqgavXvyFeuMZmG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FH3Bd3LU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6db05618c1fso8531469b3a.1;
        Wed, 17 Jan 2024 13:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705526532; x=1706131332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tq9A9p4mjdvLUr/wyRPb+SJucP0ZkwW9g+4pOi/DUHw=;
        b=FH3Bd3LU2FBYy8ylsB8XouDTZH7IXEzJ9x+1A9FQVvzhV16umxVaHyJGqB155P7J/p
         /uNNO+oYGQAd8Lf1X5a84FKJAwxszHxanwgjzoX4ee6KW+etxqihYzFz47tkjoGjhNxJ
         M84qoJQTlsfGdfnyu1pnTydRMDYnaDmDayWC8Z8+m6b8SeYuirvRYta4L8agtcRuQrq8
         uV0sOud5CxP0/F9m1hyZvKfCmMYgkgIY5K6WnwY/rTOI6pTwEwg23b3J2lEgafNpx2XD
         IU2BReqxrJdknUImsW/cocSD7n6uvmnz3JpiwAwfsN+psBDO2OAfe0m/Vo1Cj2MoRHmV
         5OyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705526532; x=1706131332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tq9A9p4mjdvLUr/wyRPb+SJucP0ZkwW9g+4pOi/DUHw=;
        b=acmAmJXkt7LSZrIJIwyx7afKxJSii+4ADFz/ArFMHpUZL/8AmY9xWIs9q7FeGtJ27Y
         tZLi0Qqmdfhf0+Uv03GRq2UpZjhsX+PsuQAyEoEIp3o8n2zzRS1JSXDheXuYHs813Zua
         QQC+z9h66MJP2iUxjZiFbmKYWDchRP65HnVg82QduTjFL7dlWpbo8ueZYHR4YMv8H27v
         XyTcG1pGbZg4yEtJ414UelCtu8fWws8TtxNT5gqzA3KlVn64S3N5OrELb5NKiZV96uIL
         dn69g/cI5NkFad4iJPxARwS7ll4WrIkIlY7fG/o5tAbDNhH/W4QU2SJVJTk2nuRLQWvN
         fCfA==
X-Gm-Message-State: AOJu0YzhA6mDQAh1fl4WmWAYL/Bwy7RhYy5sCUgSC2R05TzZ1gqyVIt0
	PfOGJvX3nLwnx3vM9klWya7Hcp5uNkM=
X-Google-Smtp-Source: AGHT+IGEssHsQ1t9F5Y149UbF51eBtJqZ30w8cNTuV8VGsjjbaZXHzf6zMxvbx8D5lVJExhWQwaMVw==
X-Received: by 2002:a05:6a00:1a8a:b0:6d9:ecbc:14e7 with SMTP id e10-20020a056a001a8a00b006d9ecbc14e7mr12195183pfv.55.1705526532639;
        Wed, 17 Jan 2024 13:22:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b25-20020aa78719000000b006d998c11eddsm1915796pfo.62.2024.01.17.13.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 13:22:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 17 Jan 2024 13:22:11 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: ina2xx: Add label property
Message-ID: <8185bfe5-b660-402a-a094-69f90e02fa8f@roeck-us.net>
References: <6f3c57d08984c1978569d3918cb38eb295c0c67d.1703077926.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f3c57d08984c1978569d3918cb38eb295c0c67d.1703077926.git.michal.simek@amd.com>

On Wed, Dec 20, 2023 at 02:12:13PM +0100, Michal Simek wrote:
> Add a label property to allow a custom name to be used for identifying
> a device on the board. This is useful when multiple devices are present on
> the same board. Similar change was done by commit ffae65fb1ae4
> ("dt-bindings: spi: spi-cadence: Add label property").
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied.

Guenter

