Return-Path: <linux-kernel+bounces-121836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE5A88EE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0B21C2C86D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FB914F9C4;
	Wed, 27 Mar 2024 18:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpCaTPYd"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A457339A0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564593; cv=none; b=NIozsb5bZ4qffwH/JFKCNqL/egbz5qDnI5ekXeSryp0bcDC/pgaiCHzQFJGYbcGCglOSenQ1b25q86w7t7/KJ/GDNWf07CLzbmNeOS/MEVtyk+bDavCxqs35W+syHGk89AswyTAxe6IS0+QHhafAcRq8HQSIOR9Qr5XO1WBMxFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564593; c=relaxed/simple;
	bh=0ydah2ypjm7l/uB1xaTPLJQXv0RyHSLmdCIFaBW8gVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqaXaGNG2aF6XDZ1WXooGqT1606Ph15ssgNcvFmCfhW+oTK+DKuM0tTY6r31xzZLf1/JATgD+TABYovsmp1m9v/npTQ6dErCGijdugjHuRiJeuGj47T9t0ahUI9exCLsVYouQFnwRTSHcUSsM3v9ujJ5HsuPk2uQca2cItq3/0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpCaTPYd; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so35807a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 11:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711564591; x=1712169391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChskCpaa5hrgVplzQRHccVrjf859v/wAPiRilaHxkUE=;
        b=NpCaTPYdYDUTD4LJddSsxmz36X831p9c/qrr1lQol9kyjVU3zRCJUFHScHlgFee30e
         xCx2taZ1aA6qlIdnu1XlN1p7bpi8enFqzVAxAeMmqc0aUnSXjanmy3y8USmb8TV2pyq4
         D+/24eOslu1Io0k755x0M90/RL11BMTxEhnelfml4wbjFdEAjUUvbVENPz9R59eVX126
         5cly72Q6xbx4RhURl0suC+4jpkJxiIXQWSBufHlobn/SBrCu7HQW6vePHZnQYquv/K9n
         NaWw0MchKRNEeC+bRtH4z6ySNNR8y65eyLznT0uWAtlXHwGPxTd/Zg/ww3iaaqeZlP5T
         zb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711564591; x=1712169391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChskCpaa5hrgVplzQRHccVrjf859v/wAPiRilaHxkUE=;
        b=o20MKl/xe0MxFvM6Q9tXtJhgdEEq7IXTdtPnNB8NYsOIt92zR5SwzDpaac+s5OmX2z
         E5NoeFXEQos7JOxgefRva3mAZOhHXfSocvNuVPI5eHhK8BVM/X2FaN6/IqeHkkWOZnbY
         hIXb2kWKQj8ywJ2NS6PbKkzN+GE+OKSxYfGTa4yj8zdUyEBGJTsaxbI7e3YrkG9sBIrq
         zDQzH9ZaXiJKJBxz02ZjHKlBuWJVXFBtjzDO4MyxsPISgdi0TqqQSm6gh59VNVjkpuxT
         hJDIGSbKWpXjvE1mLGQ7FZhMBpUnxMFEgdcR6KoA8U+5ExcSZZ1RvJDCmTSte1AwXP2Q
         5iLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5j9ibWMbSGcsKrKPlci0sCWQkXubQOFcol8p5YQcKGa3c9wCEcOj95VKrHxEILVbYdIqZ+AsyrcEBXsl9xtQz9FWlrLMo8I+HcbBE
X-Gm-Message-State: AOJu0YyjtB2lNCNjQvLmxRl7Helj5LyVe4jheWCu+ZPOZTYUOmf/Jn2d
	agW9a9IufKZkbisQgX469wrqglsopsLEwG2uTGUgRPUEBUYgEwbS
X-Google-Smtp-Source: AGHT+IFRhkOxDDjnoTztruE+BN4Lmahx4RCU49PQLJ5QJNGO1bBbV/Qi3Q9LC8qK9mGsZy0gDP/BEw==
X-Received: by 2002:a17:90a:de17:b0:29b:8926:c161 with SMTP id m23-20020a17090ade1700b0029b8926c161mr457567pjv.19.1711564590759;
        Wed, 27 Mar 2024 11:36:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id nd3-20020a17090b4cc300b002a0544b81d6sm2068643pjb.35.2024.03.27.11.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:36:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Mar 2024 11:36:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com
Subject: Re: [PATCH v2] cpu: mark cpu_possible_mask as __ro_after_init
Message-ID: <7c5dd81f-46ee-43a7-8359-f713a027386d@roeck-us.net>
References: <41cd78af-92a3-4f23-8c7a-4316a04a66d8@p183>
 <11d7a34f-909b-4923-a15f-d32015463c35@p183>
 <20240327181053.0000481d@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327181053.0000481d@Huawei.com>

On Wed, Mar 27, 2024 at 06:10:53PM +0000, Jonathan Cameron wrote:
> On Thu, 22 Feb 2024 14:19:35 +0300
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > cpu_possible_mask is by definition "cpus which could be hotplugged without
> > reboot". It's a property which is fixed after kernel enumerates hardware
> > configuration.
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> Causes a crash in this path (via CPU HP testing on qemu)
> Pretending to be an AMD Genoa, but I doubt that matters.
> 

Can you send me the configuration, qemu command line, and commands
executed ? I'd like to add that to my test setup if possible.

Thanks,
Guenter

