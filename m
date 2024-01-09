Return-Path: <linux-kernel+bounces-20491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B907827FA4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF5B9B2675D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1109B664;
	Tue,  9 Jan 2024 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oQXa4Vov"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CAB9455
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33687627ad0so2421563f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 23:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704786224; x=1705391024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dtqvmt2LlI2/NxoW9oV+Gr8OtAnzTTpRonCDnUCu5xU=;
        b=oQXa4VovSg3Utgrx/8p3Zm5j7s/F7swuKYaxGbmiuQIAlKETMZgVumIMj04qpbt5hs
         ybCvrpep0kIFa8uErNJlkRlo4XYodxPKq6jE43s1dRhd7Fs5KAq2ZhUWRH73jEfBkFwP
         EP2d62yDCLiCPPasndc4wuFIUsHN4JJZzNo5XkzQUeimg9XRMZIMo5aZJFld2/iHrZUU
         JXSsQdsGbpH4az2rGr38KciyAecu74TsW+zLqML9dDLgV0RMRNhkm0HpXNgO9WA3wp5w
         SUIBrealh2B/HsLuA6G3q+QTg9dMpT3SBlnyRs3Cn7zZLX0kmPCDGAME5buyKuEorZRV
         VWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704786224; x=1705391024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dtqvmt2LlI2/NxoW9oV+Gr8OtAnzTTpRonCDnUCu5xU=;
        b=LAb2w2rX80FEJubPhpK4IV61t8J/k0M37/i3LOPkSJYR9mNp30DfBggipCkNaU+l7j
         SutpWZnvlknyydK71ifIlvqannch9QDNrgw06rIUclq+pRCBCEq1irlHWlorZNI/k51D
         xb1SM9XW4yYTQ97FpA9NUJMaMYGaF7YlkyJs7S4Zv9Bik5/WdWrRYJyTEGdzn10Vk+lI
         DgVq2lj/Y+Iq274FuGTZ8Q8LsIkR2RKOldXG+apuCBN+mSiSDZukkps4gecJ/T+0DYEi
         gjM2D+/2sJ9o6g3Ej+MxeWWcsIFQYiViGivIoerhxYdyZlYKNwxPfeuzjOjh5Yms//I8
         wqaQ==
X-Gm-Message-State: AOJu0Yx9AevPOV4482PRIW0UBmJrDK0Hbzt4ANfR71nkLe4OR3JL5aiB
	M0K3RV/WRCwS/Ww72fTFwl8A9JLBuRsFgQ==
X-Google-Smtp-Source: AGHT+IG7Nk2aL/69dtQY6CrepYPAGA02tI1+qyjVIE5/xP6gbGJ3UPA3RAF5aLXklp4kBcxPPTlwSA==
X-Received: by 2002:a05:6000:d86:b0:337:453f:4afe with SMTP id dv6-20020a0560000d8600b00337453f4afemr277953wrb.26.1704786223794;
        Mon, 08 Jan 2024 23:43:43 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id h10-20020adff4ca000000b0033668b27f8fsm1639974wrp.4.2024.01.08.23.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 23:43:43 -0800 (PST)
Date: Tue, 9 Jan 2024 10:43:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gary Rookard <garyrookard@fastmail.org>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] staging: rtl8192e: rename variable is40MHz
Message-ID: <2273e640-0e30-468f-804f-c5699e5225dc@moroto.mountain>
References: <20240108032233.4280-1-garyrookard@fastmail.org>
 <20240108032233.4280-2-garyrookard@fastmail.org>
 <897a8bb4-a1d7-46ab-96cf-fd5ba447d2d8@moroto.mountain>
 <87edesvtrx.fsf@fastmail.org>
 <62836460ae502097ca8307bcee85a5ae3634e1acc74af843ffc466c28d1a0b95@mu.id>
 <871qarcmzt.fsf@fastmail.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qarcmzt.fsf@fastmail.org>

On Mon, Jan 08, 2024 at 08:25:55PM -0500, Gary Rookard wrote:
> >>> This should be is_40MHz.  It's metric.  M means Mega.  m means milli.
> >>>
> >>> regards,
> >>> dan carpenter
> >> --
> >> Okay, stupid me didin't give it to much thought that way,
> >> ...wow there's more that way then just mine
> >> Good catch!
> >> Regards,
> >> Gary
> --
> There's only mine that I can find, I'll fix them up
> and resubmit them.
> 

Thanks for this and for looking at the surrounding code as well.

regards,
dan carpenter


