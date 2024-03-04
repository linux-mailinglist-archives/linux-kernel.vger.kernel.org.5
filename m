Return-Path: <linux-kernel+bounces-91202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91CB870B26
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F0F31C212FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6417A156;
	Mon,  4 Mar 2024 20:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnygYk1H"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667AC6166B;
	Mon,  4 Mar 2024 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709582754; cv=none; b=gHdqSs/QIJB1N/FsSa9ipwKrlkoi6PiEI9ehxHlIyFrig+mfNvMQC4J8YlWFk1k1xNf0owgKMn4uJpXejzdwzcLOOK5vZX3CQ3kvUTRTGrVKntNnyW1EuM8rAm6yL7Q8rgtu4VMah4vE6CM4dplZy62v2ri6VkxiFkYD6uPbciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709582754; c=relaxed/simple;
	bh=iMdMJ0vvnQb1h/UXT5wB8lZOpsQlAB+MW7AAw/jng5c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SP0wFg5FuFQEtUJXiZWaY14SxjG90OCbVbdsLVv/O/CDiPBepgVpybCAXgkSumwzEqXFY8Hc9KzhpR0m5kCkQ4C2KMbCv06WgCE0gjJsjmXkXzujz1lK/qqHID/6whkRGUImbBISFpD0ze9GN6wYcl/vRl5Q2j15VmX18ZqDrV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnygYk1H; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d6f26ff33so3115783f8f.0;
        Mon, 04 Mar 2024 12:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709582751; x=1710187551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HawQEXDSyEBqL1ql8Xm/nnKDwwbKN+qxgEIT65dkbso=;
        b=lnygYk1HE0FPv4UJpilO+AgdentAwwuw/AuFjs02A45/J6FIeg2Zpsb5cGzrIgPTST
         tMMWsWcCL8E0xz03Kj9ghT52938WrZVmT4icgpLZOFxXFIUVHdg5QBW4DL1ftY9BjduS
         95dn9dIK+04Bk7GYe+g6HM/uFRXuY2uYAl2URA28t+Z9jjCgyAKh9A4VOamv1pXG97/h
         gIsMHtE8zjp5PdstpkZWePrrPuR4ISCacM/eF5ppbI5ohzdWm9hafKAiW18/MliW1Wc4
         oFcP7qh9DTGSJL5foQT1vWrWDxq+tEde7KecVlZXZqTDM3IuYNT6exTkS98Pvju7KuFX
         mn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709582751; x=1710187551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HawQEXDSyEBqL1ql8Xm/nnKDwwbKN+qxgEIT65dkbso=;
        b=IehpIixWbwYgBzxflzQHoshawicL2Xv6BiidnVZZmSr1bSEMqGCYPsbSvmfoxotJPF
         B4ylsGmp9Fl/oOpkRX7sHcslor+WwJqi3nZJy/Unf7O+5YE+Rb0LKeoBKxAR386NyCRY
         RQqRgq2CWvawv+lCun8OpNixunme6P33PmJbZZZxdTl5gKh2TughFQ6hSWD5fgrUGkd4
         kNgH3b7nSkbbbyVYsPoMh5HM8M26AViSDZHTP9DOW4QiK4utwHQNMO4KPc2gyPyL7YUh
         cdMO8Nw9q4ShSDUAHw57kUYDzQ1O3ltDi5k801r0zTd75XABe7bl1T3931b7zXcz6FE/
         G1oA==
X-Forwarded-Encrypted: i=1; AJvYcCW6SDPHxy/f9EfdpAr7aOtwfldIo8q/Ns8iegEGp4VWT9p+6HZhlGwxfMT8VikABvlAa7Wb7eKwgZAXtc3irHvjFo57jkctKln2tHbzCSpDAvitK+BFKJiUBu35cN9BADrKmSEhTsFD
X-Gm-Message-State: AOJu0YwACfbOR3d9Nf6wuNV6R9BIEI9YRos+X3b23QIzgVu4PFEYkP5s
	2S4qXFyqN/DX7xZ202jcc/sGPgjZrfmBHwRQnE0W1Y3+Z/byIusy
X-Google-Smtp-Source: AGHT+IFdbVYrFneEPTlg/PGS0MBaeXeaKkAz1qX2LUcggCw+TLuG7R63upKzJR7KCIWVeKXvUGwfUg==
X-Received: by 2002:adf:e784:0:b0:33d:9eef:4f25 with SMTP id n4-20020adfe784000000b0033d9eef4f25mr6307275wrm.51.1709582750381;
        Mon, 04 Mar 2024 12:05:50 -0800 (PST)
Received: from vamoiridPC ([2a04:ee41:82:7577:d458:fb5d:c4e5:fb19])
        by smtp.gmail.com with ESMTPSA id a13-20020a1709066d4d00b00a44256373afsm5180455ejt.200.2024.03.04.12.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:05:49 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 4 Mar 2024 21:05:47 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, ang.iglesiasg@gmail.com, mazziesaccount@gmail.com,
	ak@it-klinger.de, petre.rodan@subdimension.ro, phil@raspberrypi.com,
	579lpy@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: pressure: Add triggered buffer support for
 BMP280 driver
Message-ID: <20240304200547.GA10314@vamoiridPC>
References: <20240303165300.468011-1-vassilisamir@gmail.com>
 <20240303165300.468011-5-vassilisamir@gmail.com>
 <ZeW15Q2juyQuTw5q@smile.fi.intel.com>
 <20240304190838.GA4431@vamoiridPC>
 <ZeYegxEF521ixMTs@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeYegxEF521ixMTs@smile.fi.intel.com>

On Mon, Mar 04, 2024 at 09:18:27PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 04, 2024 at 08:08:38PM +0100, Vasileios Amoiridis wrote:
> > On Mon, Mar 04, 2024 at 01:52:05PM +0200, Andy Shevchenko wrote:
> > > On Sun, Mar 03, 2024 at 05:53:00PM +0100, Vasileios Amoiridis wrote:
> 
> ...
> 
> > > > +	struct {
> > > > +		s32 temperature;
> > > > +		u32 pressure;
> > > > +		u32 humidity;
> > > 
> > > > +		s64 timestamp;
> > > 
> > > Shouldn't this be aligned properly?
> > 
> > I saw that in some drivers it was added and in some it was not. What is the
> > difference of aligning just the timestamp of the kernel?
> 
> You can count yourself. With provided structure as above there is a high
> probability of misaligned timeout field. The latter has to be aligned on
> 8 bytes.
> 

I was unaware, but now I am not. Thank you very much for the feedback.
> > > > +	} iio_buffer;
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

