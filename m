Return-Path: <linux-kernel+bounces-123381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7578907A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B17E9B2460F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE4F12FB35;
	Thu, 28 Mar 2024 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq54SIwT"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE240852;
	Thu, 28 Mar 2024 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648432; cv=none; b=EjQ61KdV3SEcI+I0ANmaLYFYVVgm2RLdclW1HqvmA1A7URsNJ/vVvJLbg6UHhRPQeEkO3HphuDi5rkFq8obqcJXKiJAz/vcHnQb1WkHaG4fv0fu+scpVmCUNp0KtVRX3M18xJTxAg3S6lwXrpvc22FwVxi9D/PgqTYwHWNIqM8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648432; c=relaxed/simple;
	bh=5Zvbq6SSDLSVgY2hx7xF+iMbXVGMa05lQvv15AxbGv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaAct6qGBCz06lmCm8gtwqwUUn5pOUHTw35ErktgvqzPVJNiVVlyurB6EWUw+Ck47v0b1phKtPhO0yQV8+d8Y0RW3kZRzfskKU1sCytfsaNCOLdT5ycJKOfbx8X1r22kvR0FrRMO0GrHlHieZQCPigQfdJAIknZ+do8aXTxdj4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aq54SIwT; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1def3340682so11900135ad.1;
        Thu, 28 Mar 2024 10:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711648431; x=1712253231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PkvuiONoAPmS4J3DvPiNOVFVt8Zrpei3L6fZbSR1vK4=;
        b=Aq54SIwTTpKDAz0q7MLrOSCO9fesCJQpFLRMmM+qjW/+64IBA4k16SWlN6+ws+PL/n
         hJugovN5RwK5KEKEc6S3sBWwqkXZneJlMCx1sS4MSsPxeNNyITz+skaJNaAhwB519djc
         Q8khK/tdz1CMFJc3rGgbuu/49hznw8ZDD2P+l1prUgeKFfvkjXSRgpJC1kD7/mLfyjcc
         lbeoVCQGdbFs+4q4fSAoJFIy4lewzmeFpLo0aCSqCpsdJh1xeYIKG1VTQsPHs2e9Nb6r
         QP4Ur0VH4T+JL9ohlWVzkG6iIb7jJDnjqjbIuyK5ypisgCMHSQObLV9TXtlsT1wQ9uLX
         Gaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711648431; x=1712253231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkvuiONoAPmS4J3DvPiNOVFVt8Zrpei3L6fZbSR1vK4=;
        b=YSUYsHYbXcBFfQ3vj3Q8+STMp08XdykutZ4CniMjvTMjCn5AQq6jsqSjuSGdDnZLD1
         Rbov0g76DiV12PVrcJab4g1w2hmueh0l+G8zw1e8qiepSfg5TFHXJyTRYbqy0vuVyJTo
         42XIEv10zuYiUGpZ7mUJNjgik2FaiAML7CtBNaueptD/CpYBEAQwhSO3qjKGLA4HSQPT
         a3ar70o5iwW2XWCMb1LPR5HDOBlBGnIPM5Dv69uRJli0vGb0uTaLVZK4yPtzxVHYIPwK
         u/djr/lUfZEfV2zJDNAYWgyuVxJjxsn91nj52Crr1a4YBAdlIIFXx6mNKdNgt21ozxDP
         8R6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJfWXsDu3D6CQX3ONDzYj8C51LOd3bM6u9Nexv5Ar/c7gkh2xmDWfukuM/OzX5qybxKlkygHJzK2unm/jCD81sa8ibyG4ToLpAnLGC
X-Gm-Message-State: AOJu0YwIgVHyqBwCJIAcOSQotixY3ItrCr/EJXOcRc29K/sSy9PxLLop
	zXnv0lt3vrrpUMH+1k+iXKa+I9kPA7GtW7Aii6HrOLzomtwQrOTeMcOYxT1C
X-Google-Smtp-Source: AGHT+IF/w2JF7Yg+0NBSCWcyatQGo5LuV/VN7nZPG/h/MqUyETB1iCFlW9dVc8z7gEgzhLOX+SGD9g==
X-Received: by 2002:a17:902:eacb:b0:1e2:1027:d0d1 with SMTP id p11-20020a170902eacb00b001e21027d0d1mr156929pld.39.1711648430490;
        Thu, 28 Mar 2024 10:53:50 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:493e:82a3:49f9:d88])
        by smtp.gmail.com with ESMTPSA id n14-20020a170902e54e00b001e0f2dc4165sm1897906plf.60.2024.03.28.10.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 10:53:50 -0700 (PDT)
Date: Thu, 28 Mar 2024 10:53:47 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Frieder Hannenheim <friederhannenheim@riseup.net>,
	Marge Yang <marge.yang@tw.synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input/touchscreen: synaptics_tcm_oncell: add driver
Message-ID: <ZgWuq1bDWNRtrImD@google.com>
References: <20240327214643.7055-1-friederhannenheim@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327214643.7055-1-friederhannenheim@riseup.net>

[ now CCing for real ]

Hi Frieder,

On Wed, Mar 27, 2024 at 10:39:12PM +0100, Frieder Hannenheim wrote:
> This is a bit of a stripped down and partially reworked driver for the
> synaptics_tcm_oncell touchscreen. I based my work off the driver in the
> LineageOS kernel found at
> https://github.com/LineageOS/android_kernel_oneplus_sm8250 branch
> lineage-20. The code was originally written by OnePlus developers but
> I'm not sure how to credit them correctly.

So the first question is: does this device not use Synaptics RMI4
protocol?

I am CCing Marge Yang of Synaptics who may shed some light on the kind
of touch controller this is.

Thanks.

-- 
Dmitry

