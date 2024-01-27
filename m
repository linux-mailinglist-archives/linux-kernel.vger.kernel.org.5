Return-Path: <linux-kernel+bounces-41302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFC883EE90
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B4FB243C5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BD531A82;
	Sat, 27 Jan 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="af6rIh+k"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B256760DC9;
	Sat, 27 Jan 2024 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372463; cv=none; b=V7HG9cD5SUtFI/IppCnZih95SPVbfYtVsE0mQrj1a+jdSty427cTw6WsWDLaB18L3fNCDo5RZSDrOXwcCLRInEM2xFQiwPYsI93ov7OcG2zTwqyvi2CenLcVyQDubhFxeskb5Nrusht6HPZo3xX3aDpHGnHmjT8t34T5g+xgxQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372463; c=relaxed/simple;
	bh=iFbT8NHMRxra73mtvqFlKRnzUGWo0ySIB+769BYYeu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWzUf+jOswhhu0mcnU8MfaIUiSG0P294H0EsXix5pZm4D2yco7yLXOLlilGuzKOIVXqladsBR1INvVKaMfaMUr1IGvwcw0FETDoI41J/wau79jQnf2hs1ahuIaEccFkyySgOKpH6hDxuBRM1e9iBti7ldS10s5yUfndaqOXe/28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=af6rIh+k; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d8a66a2976so13376315ad.2;
        Sat, 27 Jan 2024 08:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706372461; x=1706977261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icnXN0V8tv2OBqSXsA4+SZWf8bHAQn0oQ3LlvvUMVcU=;
        b=af6rIh+kpCthSe8kFrYYUdKlAEw4MPG+C9msyM9PcIgCf9G+uEw/MmM0fTco5yYBfH
         Lq10XeV/fYQq0vtg8l4/VgwxxISrgdR/eEVBibmqCAcr/hFhoke3MKzoyEzVTH5ZWfmh
         axfB6hhc2rp7WiRBN6qRN9E6rhpVjCUqgGhoFtCC2F1OGhBLI3jRJGfyilbNjcFqfntp
         GgB/eyf5jWZFwSZcUBhPTMEA0Dg8WRVN1kELq/gdnn2m0CYKaaF3c5m1PQJ9sAwyHWPA
         HKlr2Er53TlnYzQF755YQz3pgTBjHSrp8oDFipsBqeGyDDq2nPUJN8k4JUUNecpTvtTX
         m1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706372461; x=1706977261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icnXN0V8tv2OBqSXsA4+SZWf8bHAQn0oQ3LlvvUMVcU=;
        b=R7rORtq/fxCfx7uojFbjk3vt7DzA6rDd0zNrzPrWbe0GnDFC2aATd/L+PNCAd45zdA
         rY7Uz4kLnauKnmSqG3ZU2E3f6b6TtyHfrsSzz80xvucRQG7Ktvo9AhhWvr/OhL6zFgfG
         1/MnDWqalFhogUzLqEu3oW0iLEd9L4SsTq2JKlfyNy0u2yk6x8B18ub8Fwl1eEpLAofA
         YrQCz21f2Qqvf30ItuterQGcn4sClcjSTiL5XXWvw38JiNydZESrZJWd9nmlUacinxA3
         EH9GDKXWCJnVcTyFl77csTcxO7l/+f7glGsHzW5dx21ZOKM37yGeCEZcAHPZedhwAfZN
         Vssw==
X-Gm-Message-State: AOJu0Yw4OmRg4tl57cuCnu25zWQ/bS1qNb2MU7zq+tydLPE2mxjci9Sn
	MIF/Rwt+4AeeDi1+CRy9kjF/mIwWUtd+/G9QUwvyd/flEEpN/Ek2
X-Google-Smtp-Source: AGHT+IEzpH2s+FyYQuJQvz8JnKB4KGeivzR2vLXk5na6VyCf61mfIusC1vv98wNn2kkP2u7K1nLGsg==
X-Received: by 2002:a17:902:ea01:b0:1d8:c8e8:11e1 with SMTP id s1-20020a170902ea0100b001d8c8e811e1mr288397plg.111.1706372461097;
        Sat, 27 Jan 2024 08:21:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c3c400b001d717e64f0esm2632893plj.87.2024.01.27.08.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 08:21:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 27 Jan 2024 08:20:59 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Lukasz Majczak <lma@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Radoslaw Biernacki <biernacki@google.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v4 2/3] watchdog: Add ChromeOS EC-based watchdog driver
Message-ID: <1a9330f5-a469-4a46-8dc7-a15b274ff99d@roeck-us.net>
References: <20240126095721.782782-1-lma@chromium.org>
 <20240126095721.782782-3-lma@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126095721.782782-3-lma@chromium.org>

On Fri, Jan 26, 2024 at 09:57:20AM +0000, Lukasz Majczak wrote:
> Embedded Controller (EC) present on Chromebook devices
> can be used as a watchdog.
> Implement a driver to support it.
> 
> Signed-off-by: Lukasz Majczak <lma@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Note that this should have been patch 2/2 (since the last patch
of the series has beel applied and is no longer part of the series).

Thanks,
Guenter

