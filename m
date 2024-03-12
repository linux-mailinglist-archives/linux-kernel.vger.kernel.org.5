Return-Path: <linux-kernel+bounces-100081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 543C9879186
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD7F7B21E26
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0100378291;
	Tue, 12 Mar 2024 09:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iWiN612H"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782B133994
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710237482; cv=none; b=objimq+iEx+c8pTAW9xVO0vIVHloo4LvDeEX/BUuGRuTR7ilgzrjbGD43JkjLLkN2pzU8r2UQeEBdRpN+3OTbnlv+45/3BBzpAQQVMiq1V3SxmyW4dbnIli8EMIyFhSGT/OI6S6mMP43xBW7DV2gyLAhm2SvtembGeka7/J8kfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710237482; c=relaxed/simple;
	bh=XRrd/mRYiuVNaYDbIbSa1EEqn9i8XS+3pxvuW9JmMSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CseOi/Gc8almSsZ6Y6RPTSAl5RABywqT5xrukEH0FS/IC06IE8HHkNOiYXqUu0lAikTM49zSRpted7sbLt2/Kc2hiyf4DRthcC9H4g7iMohfAhbrO8Vk2iYSexQsxasGpVzD+pPtKoHIoaw72Fas5/WFxG+U3IP284L9jczPgts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iWiN612H; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e99b62e01so1364974f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710237479; x=1710842279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XRrd/mRYiuVNaYDbIbSa1EEqn9i8XS+3pxvuW9JmMSQ=;
        b=iWiN612H4XiEmaR6YxjQmgAQ6InikZD4vddxmqXfcYilphYeoqrJjx2/pnzjoxFbJZ
         2o2cTP0aJs3zRzkeimUCYb0CWYVgZZE8t76Ng3rOO59hAhUfKJyHLZ11xlRWeZ5/yMPC
         JvfL5H+sLKDAs48wZw2w2QErG8tQFx7LWhnkJ7TWT5ZtRbRAaZMInxXKEF8R2wUt5O3a
         N8hHXgF2cb36NqGJEW/4vay/G+A6kMzFm7GKHAA9eNXx/21iL/k3mCYa57lymrAEMUPO
         1c+KoZuNDj7Da2DVl7t2zY6t30V1t1mStV0gcYeFGKZkmlYoNkuqWJsd1KdNSfW3kIgt
         rvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710237479; x=1710842279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRrd/mRYiuVNaYDbIbSa1EEqn9i8XS+3pxvuW9JmMSQ=;
        b=FHjQIk2XNxQ6pP1WGuGlXNafSgfSKTsitSDf4MWWXsZxINLiqUwi9nS+DHMsz5S4Pd
         Bxy2+OnD2MTlU9kUUQCLec6pJrqo9NU2jsSBeFNo7+xxYXCpj2uwF/yymYNLZkM/8EDX
         Wawo/cJIfk41sXSe16KeMFSkGxjZM9xevgdhu+itodTZSDX60DNE9F1EsQBaq8N4w+5z
         RouigkghI/y0gK8ArzhKCNkdZt1CC/ArigcAdTB/iw7vy84aJXbAI30gyCpEnbBqrz5f
         gdwJwBxAzA7J5rxwT3/ShhP9SG+WUgO3RWbJg48d38GYQh0WZ76F5AgTLvpPqfROwoyA
         5LKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc8+MdYhvoC31e7cPImqzhCP8FhVb2KHphxli1ozHStDwipaZ0uuzgAMEjunNbrahr1RktcsHg03mp/IjgbSctDHoxKXN0zkOPInvu
X-Gm-Message-State: AOJu0Yz8gwzxuq6bGNf/UuLrOG3Ir0mi5vmDywSwUXbVQ26W6TEqy9Fy
	8DxPkVedGLSJNIsw40xNC4UkdqFTGV/e+CgQA2bQuQjGPO49WwCgPSY1DVVHz7T6XikR+3fLaUy
	pHHo=
X-Google-Smtp-Source: AGHT+IETA/fhuKCiOQdvs/qQPMu8fwiw5YqR4JFWLLA9lS90bkIdlBJzwgAtJ7p3egiNO9bXfcY3Hw==
X-Received: by 2002:a5d:4306:0:b0:33e:7fcb:c0e with SMTP id h6-20020a5d4306000000b0033e7fcb0c0emr874687wrq.6.1710237478891;
        Tue, 12 Mar 2024 02:57:58 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id y3-20020adff143000000b0033dc3f3d689sm8594544wro.93.2024.03.12.02.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:57:58 -0700 (PDT)
Date: Tue, 12 Mar 2024 09:57:56 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Liuye <liu.yeC@h3c.com>
Cc: "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
	"dianders@chromium.org" <dianders@chromium.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI0=?= =?utf-8?Q?=3A?= [PATCH] kdb:
 Fix the deadlock issue in KDB debugging.
Message-ID: <20240312095756.GB202685@aspen.lan>
References: <20240228025602.3087748-1-liu.yeC@h3c.com>
 <20240228120516.GA22898@aspen.lan>
 <8b41d34adaef4ddcacde2dd00d4e3541@h3c.com>
 <20240301105931.GB5795@aspen.lan>
 <2ea381e7407a49aaa0b08fa7d4ff62d3@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea381e7407a49aaa0b08fa7d4ff62d3@h3c.com>

On Tue, Mar 12, 2024 at 08:37:11AM +0000, Liuye wrote:
> I know that you said schedule_work is not NMI save, which is the first
> issue. Perhaps it can be fixed using irq_work_queue. But even if
> irq_work_queue is used to implement it, there will still be a deadlock
> problem because slave cpu1 still has not released the running queue
> lock of master CPU0.

This doesn't sound right to me. Why do you think CPU1 won't release the
run queue lock?


Daniel.

