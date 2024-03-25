Return-Path: <linux-kernel+bounces-117466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3263388ABBA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60E2290241
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1221F138494;
	Mon, 25 Mar 2024 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BToT6GQf"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF846E616;
	Mon, 25 Mar 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384082; cv=none; b=HY4rB/4wSmZFbYMCgb6shMQ494dTuoNh1peUCO5X9ix6gWHtLVD4tAdj+W+7QOP8BWSIp6u4GuE3H/IIeo68wNmY2JsaBPlUHl9QHZmx8xynWjgILhzIRvYhMsY1nw5E7kLQG3H2+A/0SmwDL3KkUTJK9BaMH+g2RVXQfyW+MHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384082; c=relaxed/simple;
	bh=6mn2FvSYkgFc6XYTjD9ZiVPlMB51oRoY4HH3pWGAepU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdyBcHQ2IDbyyitkd8+MIjI918y1XTDJs42UNU4YFjHqykoB6QZVIvKm4uG7xHAkSeX4Yj2aZ/f8mnu0iSfhSDhqBz3/k7irGdg3lOzqZFRp5tHrfKhBMlcIOKS+Kw0EV50PKFnaG+sFqtia70ORd4IPz3WYleHcIgK55a93zik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BToT6GQf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1deffa23bb9so33909075ad.2;
        Mon, 25 Mar 2024 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711384080; x=1711988880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tN5WS51yrKWWcpHyuIs4khR2cHTcKKjIU0K5+UlVPXc=;
        b=BToT6GQfPbrShThnuKyCzI37EbxHQBVScUVNRsCGBvAo/LWpq0zr22ytP4VZ6stcPY
         aBg1Nrgyar3YXlr2061F1t4OmRhRj75h/1M8RaRw7b/iXrQ6Nz1kMDaLTJnRmQl++5B6
         FnsLXEKr/xu6nlJ2acIAO6SlQs5CRabgJ8KKep461oJchXHSU0eZ66Y5MLebPCrQfQ0Y
         /49Qlw3JBZpXlIsMW+Idcc5bDEY166CIS4L2UPkMPRo7BwVbexG/kBeQ2FHkTxkW/yJP
         c4bcNwnCacBcl5zytiBKLxcGRdc+31uAIUXNq2sc3j1brVFov5JtuaxC9OQXemqsyQ8s
         bidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384080; x=1711988880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tN5WS51yrKWWcpHyuIs4khR2cHTcKKjIU0K5+UlVPXc=;
        b=CD/rEQhKpZr1oMOGPYU0OqjW47lWyVp8FhO+mmV4dwNKryUyrALhtaqOV4AZRgfa0o
         4kNKj1hmbi+XaHOMnGiE+nlsUb+n1HYbFyU00sIRXLAUyAZanbslubLAFcdqZ1mWRO1I
         J0LpEpRfbhTYXJZlOhq3Z/krNSXxqsyDQXPjMejDZ3NQVDYasfhz6jKNcYHMAogiAndz
         DjymXM2YeA5mQqFd20+bVApGr+7m98Z1x8ikjQq/A7DkuGA4bPnfJQHgNA9EZJkRHmit
         v2OBeuToF++Ddw4Qa0uc3hhyKfRfAGb4R1WjR4qVdE59MHyU8Sm5x7UpFaGtckQ3TY8z
         Bmjw==
X-Forwarded-Encrypted: i=1; AJvYcCUVhRzeTp/OiFwQLaVSow3VGPn1+uDgTyf3/66ii5YzLE56T5BBB+DihBZY759sXqBdWS9cu80jgT81xy/UDZiz/ftrakTOZUHiIq+9vdLQf/f7asYoLXiA8WSV+8CB1jNrT88UOatAsqM=
X-Gm-Message-State: AOJu0YywF21nbf1c8LkVN9AZvR2laZXMUxtAORuK7pvCrr46MKGB8y1r
	VcupeSMtIt/pqSIdtsP3nxrX2AdHo4D7LWjS0slsa+IOSwMNlB2xpl6+LAhG
X-Google-Smtp-Source: AGHT+IHHJRnxF4rA+CbQGRIrQizjg9dDg1KUm+o6R8fqow2e47mVKg732nNFoQUGxnf1z2Vnz1/G5w==
X-Received: by 2002:a17:903:298c:b0:1dd:6263:62d4 with SMTP id lm12-20020a170903298c00b001dd626362d4mr9577752plb.3.1711384080257;
        Mon, 25 Mar 2024 09:28:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902784700b001def758b7d0sm4969755pln.127.2024.03.25.09.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 09:27:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 25 Mar 2024 09:27:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Radu Sabau <radu.sabau@analog.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH v1 1/1] hwmon: pmbus: adp1050: Don't use "proxy" headers
Message-ID: <52430ff2-5262-41a9-aa1b-bbe7e2ebd6b7@roeck-us.net>
References: <20240325124156.3036266-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325124156.3036266-1-andriy.shevchenko@linux.intel.com>

On Mon, Mar 25, 2024 at 02:41:56PM +0200, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied.

Thanks,
Guenter

