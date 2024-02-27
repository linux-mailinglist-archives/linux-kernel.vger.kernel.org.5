Return-Path: <linux-kernel+bounces-83942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7119686A059
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9BD2851C5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679C213A891;
	Tue, 27 Feb 2024 19:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4qjaG13"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF5B2511F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062759; cv=none; b=e0B0mYf2IHbkP4K45NfMifd2PyfY9JLSbpEL8KCmIooJFeQbmZV5WLVsBuXA0JDP3eDbfuYtoUtlOC2OK276oCBMYE41d80Drp0/GFQRj7grMdjgHeaWJCf6c7L2bQ6iR9n6PjqR+oqARcVvt7JA1kNCaE1kRmTz/dJYxdkhzGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062759; c=relaxed/simple;
	bh=NkpgtyhkUYlQd+libVSgyBRF5SshhQknVpyB3eR+xJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaS3vu9QgQ3tno7kEw+oEaGetpBOihRRncskm8KbI+vrMIs+wL+ATxszROnV8QUxlZ00QIsk4r8hI1GZ/ygOqffbZBb2OQ1+P53+7IopywkGCtjLSFhOHmZ6gQ+fyOJTcTSWtKfC6pGMipz5508Fay7oe3q8u2qv9oxitzPdNA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4qjaG13; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36503a4980aso10707125ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709062757; x=1709667557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKYVjvln7WqK9UOeHypkuBAH6upy75SMDhY2R5Rntz8=;
        b=K4qjaG13SbbJykIKdE9bm/wtsevnfJrButRy220Go36YhQctwcoDZLXV3c8BJIxcG3
         AHPzYIjaPFNUNfBp7QPWmGpyLRrvuhh1YWPrL7m1BpOcVGXBo6+bx3vCaPw1kxRR5MQk
         1DW9Yo/h57L0rudI8E/EflmP0fyNBikFYpk+fsGgQXOWNPmu5VEVcnGFzIfwc/CN8zkY
         6jJ5PEi+xcimich+oE2JrDRBteBhaCejmv8IOTwGyDCD79qK/WjBSYR0XSyo/RKbh/Y7
         e4nuZcjJvBpPyBLWzV0TNCTzMnk0EmP/wcSPV9kHk2vddclWjFZrwQGb2+2E1kfz011O
         kw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709062757; x=1709667557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKYVjvln7WqK9UOeHypkuBAH6upy75SMDhY2R5Rntz8=;
        b=NPdUpwPSuBtglIi6txPclVFkBrKWPIne9E2Q4cAMkJXXrgbhFpEG5WzR7PGjT+WRlD
         Jz+krmF1L/4p5SKaxUY1IG92oARLMeRrZe/KDVas/+P3d4w6mbZmKi5wSlNBgag7w2Be
         buKnGfALi59EhQYhnZnQ5ZPU1SSKNH6sfnr5rJzJJzc/kVv4WjwDsGnhsBssvnk+hZYI
         BZAYdGw4fw1TztHMvfVnN6HWW12mfI/uf23d8u23/F0q4TNAquDZgszjvg3RUw661fSF
         1KLNzy+frTWVO3XNacN0WaYw5DEj9SqvQ3lNgT6/HTwS+GUBIs0Ct0MYM+E/fqhjAysK
         hb3A==
X-Forwarded-Encrypted: i=1; AJvYcCV2GycfaWM6x1LnUlWgd3hcScuZTRFbH7LDCxdz22TUxfD9Ndjsm+O4ZmuCJSPz0azL5Y8+iURcZmf2EInvGUPAS6bA0gw24u9ti+A8
X-Gm-Message-State: AOJu0YxUJMg1uwxhSEotKY0sQ/acqQ/njso+6mjskWBQa3OPcIUcp7ol
	HHjCuFdHnqNl89zmRvemouROhNrhzP5dokLx3GokjDMeLUG2X+p3
X-Google-Smtp-Source: AGHT+IEaJ7sW1CfBTNx0YpAQ0dB/DADGQZgLd+DrJBrDTlYIpW/mMqXij0gvOsN0hSkYf/rk66ygIA==
X-Received: by 2002:a92:c688:0:b0:365:2390:931f with SMTP id o8-20020a92c688000000b003652390931fmr11605284ilg.4.1709062757294;
        Tue, 27 Feb 2024 11:39:17 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:8305])
        by smtp.gmail.com with ESMTPSA id o195-20020a62cdcc000000b006e4cf04e501sm262260pfg.13.2024.02.27.11.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 11:39:17 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 27 Feb 2024 09:39:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Allen Pais <apais@linux.microsoft.com>
Cc: jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: Introduce from_work() helper for cleaner
 callback declarations
Message-ID: <Zd46Y8ZeAPug-P94@slm.duckdns.org>
References: <20240227191037.5839-1-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227191037.5839-1-apais@linux.microsoft.com>

On Tue, Feb 27, 2024 at 07:10:37PM +0000, Allen Pais wrote:
> To streamline the transition from tasklets to worqueues, a new helper
> function, from_work(), is introduced. This helper, inspired by existing
> from_() patterns, utilizes container_of() and eliminates the redundancy
> of declaring variable types, leading to more concise and readable code.
> 
> The modified code snippet demonstrates the enhanced clarity achieved
> with from_wq():
> 
>   void callback(struct work_struct *w)
>    {
>      - struct some_data_structure *local = container_of(w,
> 						       struct some_data_structure,
> 						       work);
>      + struct some_data_structure *local = from_work(local, w, work);
> 
> This change aims to facilitate a smoother transition and uphold code
> quality standards.
> 
> Based on:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git disable_work-v3
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>

Applied to wq/for-6.9.

Thanks.

-- 
tejun

