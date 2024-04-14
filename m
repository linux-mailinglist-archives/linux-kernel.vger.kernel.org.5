Return-Path: <linux-kernel+bounces-144131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201668A422E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BD72822C1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316A93D0D9;
	Sun, 14 Apr 2024 12:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rEaIVKRV"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D290C23B1
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 12:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713096082; cv=none; b=W/ycVvDF+ptdIXpKNd8nrGx18F49Z0lsuzzEbq1Sv2w5EAWCl+aJgEo07FHhoOW1vkvjXSLgx5K+ikK1anGIPYmCHEPz7eCmPpHOUvR1cXONoKeUwPT4ClxN1QwOvIneLpBdifUqht/r1NN9/WrXQHrbQ204qZpqw2Z71v2d0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713096082; c=relaxed/simple;
	bh=F45wyCH/yvtLsraLaFA1Cm7IOhcG0+SPVbdow795DSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecGetnwvatVDlbjqPVlbIgvOGkuYlv8a+gsVMDeZ9ajzH0f9GODi9/NSSwazthacAtssMlSu2Y6WwOkU4LVyLLqw13jAMcHcUwbcIRungVfV7mFpIrmB4+1tLWF5239TOh1pTg6V97++KsLJnLkEmq2S+ylNkaWDSkvh8r6Bt7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rEaIVKRV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a524ecaf215so100777366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 05:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713096078; x=1713700878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o3xLXUr9vcEfv0klzxRfEpsHKjTa9YKhPpRmE4GTk+M=;
        b=rEaIVKRVe0I88uO3WNXYVC4+786cmiSwuCsuZ88Yf967e66tT5mId1k2p4rZOvKzpd
         9sPDzl2yH39jdBQVSQjg6u1M61uCXDprRpYBF2E9Sf21LSdWtD0A7iPUJ/PEaYNv+DAB
         nqvoO2eVadpQZGOxx2djCpb7Im9MioM3ik0L4PjsovBmKL8YRaHgiS1r0SU/XsEmTdd5
         xK+qx92pMWufdyMKL7tyt2YxPuH14MIRpOVZJJARt+CvrsAFJp/s5F5hzWy27CosiSCI
         NDGaiXeyszKVNyfj+3f7X+hIZH6EIKsYgftJVD4dI2EOP7Rid4jzhXfzExMS4ZkkHfoY
         NcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713096078; x=1713700878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3xLXUr9vcEfv0klzxRfEpsHKjTa9YKhPpRmE4GTk+M=;
        b=uCG4IQLeJeuB4PAZvwgzL2MMBCf4bg/ys5x55zol8CGbwuJO3rq2EjIwQpo/fOE3zD
         P85V0OSdsB138B8G4aODQRisgYa220WsrIYxW9OPvBEwD3/2VAWezJDBLJuULJ4f+117
         YvCgXmsqx3HUC51GhP/Picqh1ieys1ChI1q4c3Oz4Gedu9h44tnM1FuReLBvTsPS6X3d
         dwucsURnrUqg7l7IWM6OWNCtOL2PSBfATYa8UU7yY6eRSGOQHgQ+AlgyxteJkBP1q6Oq
         wrUbVj6s/BCKy6KZg+yWsy8xmVLYUPzyonZGL2AOKjzZ4hYcYi4lUIB1taCbW/uwGcdp
         4MRw==
X-Forwarded-Encrypted: i=1; AJvYcCXbYD8a9i5LdPloaChrluCFHMHRBssvlZd0MFS3SL41aZfUnexID4iaIAV2wzhHXxneDZocoW1AWGb6A+BU3auo0i2PYfMeRmntn3BN
X-Gm-Message-State: AOJu0Ywk3665RYdNE7OHJUDz195kU6KCAiMQjNBWWvb3flpcTrSQpE8w
	mxgzMeBg93mshQ7/cOfGGh8U/XF5/cFrumDp8pwz7FIrUcDv6BwLznrrWCiXEhVI+arnXYJLNVe
	d
X-Google-Smtp-Source: AGHT+IE4l8NuWRi3LGRbcaEm/pf7jfykdhFqopERDMjXIqAiTZanPEmTOGy0Y2lumPxAHYbI1bGh5g==
X-Received: by 2002:a17:907:72d6:b0:a46:f9c2:f059 with SMTP id du22-20020a17090772d600b00a46f9c2f059mr6026141ejc.22.1713096078015;
        Sun, 14 Apr 2024 05:01:18 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id gf15-20020a170906e20f00b00a46d2e9fd73sm4118761ejb.222.2024.04.14.05.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 05:01:17 -0700 (PDT)
Date: Sun, 14 Apr 2024 15:01:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: sumadhura kalyan <opensourcecond@gmail.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	gregkh@linuxfoundation.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: vc04_services: Reformatted code according to
 Kernel Documents.
Message-ID: <a3c1d471-849b-4d4d-8657-4ad73493fca2@moroto.mountain>
References: <20240414115106.105946-1-opensourcecond@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414115106.105946-1-opensourcecond@gmail.com>

The subject is too vague.

On Sun, Apr 14, 2024 at 05:21:06PM +0530, sumadhura kalyan wrote:
> Issue found by checkpatch
  ^^^^^^^^^^^^^^^^^^^^^^^^^
What issue?

A better commit message would be:

==================
Subject: [PATCH v3] staging: vc04_services: re-align function parameters

Checkpatch complains that:

CHECK: Lines should not end with a '('
#45: FILE: drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.h:45:
+typedef void (*vchiq_mmal_buffer_cb)(

Re-align the function parameters to make checkpatch happy.
================

> 
> Signed-off-by: sumadhura kalyan <opensourcecond@gmail.com>
                 ^         ^
You should make these capital letters...  It's supposed to look formal
like you're signing a legal document.

regards,
dan carpenter


