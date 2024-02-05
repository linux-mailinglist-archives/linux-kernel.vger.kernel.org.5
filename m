Return-Path: <linux-kernel+bounces-52469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3C8849891
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2661B2876E1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB0C18633;
	Mon,  5 Feb 2024 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXIrvdHh"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5250D18638;
	Mon,  5 Feb 2024 11:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131560; cv=none; b=g4yac5VkOqpoRsCSioFQTrkRGC+GrMPHJK/J+os9IbaD32Lutw+h4ufsAxR75DUkivOXD311Qp+hnJhB8pE//qYk42Uz7qAIxtwGu9qkGWd+q38eFiL1H1lpwU7dKr3g//zvlfHH7T+UWp6qL374WLv/7j5EmtQVpivIphds9hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131560; c=relaxed/simple;
	bh=oj1/AIB0p/53I5LNg9tA+Dy0YicJXFzGE49e5n3Ooq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r12CCrZNkzpi1R7pakgiBf+EZmEf+AypLFMHE3+UWhbjH5fFKlRYDJhj9jZyWsj8DB2pcBeMArvTIjWkPuxduy7c7dC3xrLkuuF6kynwleHXguTZW+pjZSXyrtS8mn/+GsMgWCDzJTFzJryuvx8vH2Hq/ZWElyZaUv2qOU0dchw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXIrvdHh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40fc22f372cso32684275e9.1;
        Mon, 05 Feb 2024 03:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707131557; x=1707736357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xquFznELHNkNOnV+v9w20sG0C3zEzg4ceTX537oOIck=;
        b=bXIrvdHhHnzVJQFhfVA6EFpBU7CeL3JNKfj75cIbd931E1bi8aqK9J9DOr3xjwcYUs
         L4AFbaJMfpBH0LxYjQgH9jVrBLkeugOjpi/Wtk5VDkzo6hDegcpfSo5W2dj9A4dBYw+y
         vyAY60B5po1Kw3n09bAaWAPwH69wTFOmwKCtmzs6OzzMmvvyU/IcVvy45k3v+jXn7IXX
         UWZTKjG+0jdRX5tcDyM8mGeTl8jlifl19TB+uT6Z4fEJjCnn7+EvrJV67SFoPLvls3wg
         pOi8ETpXiHuYokWeQFcOBDSBDvlV4qTEY5OlFk4boA0CGjaoqtbjgQb8CEjQTa7LJo2X
         N6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707131557; x=1707736357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xquFznELHNkNOnV+v9w20sG0C3zEzg4ceTX537oOIck=;
        b=tUEkXY5CLWYO5XfoctwmrfvXDPM29tcowzd6YWrdLuw3b7m9KVFHETijxSzm8r0IF0
         ZtaWTuNoTTTCrkUY+/r6VyDfwi2AsKknmVMcWyWfqcTWsXbG0bK3ePcbSkxIHl4BdwvO
         eHfRFIeZ0Eh5WyzDrB2l23LN5+Wh6uJJr61boCVcABIw2pzTTM30xoK3mVCXQOfqwMbE
         JNky0N00GBQ7iuzuHYIW6oRuhAZhkgXkd0fXJkEI6RdKpYCGOC73IWJn4odgK1nwcsnT
         +ZZQf5DvhHQgWwfjJdk/p1h1Uf2lk0Y/i4LlcHig0UJFp3Pei6DVMtDcHWm5U3L4cb1u
         PJrQ==
X-Gm-Message-State: AOJu0Yw78AhjuSmevNemdjnZ3XXsuVNolGXPzM+NstPkmMTUlGsKCZOg
	isjWMHQbLyQfDKdMjBgyQpu43hFaQ4RaYn4okQjB6lSsyshaMcNh
X-Google-Smtp-Source: AGHT+IFmTMwiD3v5wRdF4/W9WdDL2Au7GPEyJntwfmjwdBrDYdJnNuVNgosK6I0r/TG8kB1YGSjSpg==
X-Received: by 2002:a05:600c:3b02:b0:40e:fbc8:401 with SMTP id m2-20020a05600c3b0200b0040efbc80401mr4941264wms.20.1707131557407;
        Mon, 05 Feb 2024 03:12:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXkuffulayl7u4ZnRfFTEOLUuztEaR/B9viO1FY/FWgutGfR7qMFeqiIm5CqRGScVcJNuxSHFIgvNs8gIWdsM3DvkSl8io/v2whoww21PlC9RI60hcRS2FQYf4/IeG6VVumwm3vw76YL4Y4dRFWehIrP4nVIWoAj9pEbg==
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b0040ec8330c8asm8205627wmq.39.2024.02.05.03.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 03:12:37 -0800 (PST)
Date: Mon, 5 Feb 2024 13:12:35 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: andy.shevchenko@gmail.com
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Minjie Du <duminjie@vivo.com>
Subject: Re: [PATCH v2 2/2] spi: fsl-dspi: Unify error messaging in
 dspi_request_dma()
Message-ID: <20240205111235.yrxgvjcbdt3qr6qp@skbuf>
References: <20240204203127.1186621-1-andy.shevchenko@gmail.com>
 <20240204203127.1186621-1-andy.shevchenko@gmail.com>
 <20240204203127.1186621-3-andy.shevchenko@gmail.com>
 <20240204203127.1186621-3-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204203127.1186621-3-andy.shevchenko@gmail.com>
 <20240204203127.1186621-3-andy.shevchenko@gmail.com>

On Sun, Feb 04, 2024 at 10:29:19PM +0200, andy.shevchenko@gmail.com wrote:
> Use dev_err_probe() for all messages in dspi_request_dma() for the sake of
> making them uniform. While at it, fix indentation issue reported by Vladimir
> Oltean.
> 
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

