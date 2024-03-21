Return-Path: <linux-kernel+bounces-109658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 974E2881C1F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D5A1F2239D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427D533994;
	Thu, 21 Mar 2024 05:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1rz0ccC"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67C82DF9C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710999184; cv=none; b=qyWC0bOq+G34kv7Je7i2XPuPChdXf3VSCAGN45nTmePPZ52gKFpFERZiE8Gu5JgrF3wcKTdMh+SyBMkGj7NhnCginVIWQEWnmtA9mcc+tSuIgXFzOja3PZqNShtiC6zLHJfMotXKRaVx2pMxFSGmMI6zoqyFjWI3zy4LFn179uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710999184; c=relaxed/simple;
	bh=APhaJyz0eNl0QLfcA/wbbgGPP4h1JOszmjto8p08kRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPCqhm9fqs8GdxDeWmslLPPYbX18IflJ03DzmnyLGQbZIoAIXy0AjIhG8txQqgHnK2RGhbgPw8QJ9U17TM/Cbm/crbpBp7gx+I4gBpYwu8vRDfCGFXZ7jr232Z7SSO1PqNmG45Nb6429gIaUS6bU8Jt9g3WaeO2Xu2I+qg29UOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K1rz0ccC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4146e5c719bso4329715e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 22:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710999181; x=1711603981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SdPjP84IZic2EoAFg94q9ioTBhoCVfACUPr9otSbXhM=;
        b=K1rz0ccCNf2L/mf04e1SGgmcX6fGIcteASA9OP0ga3FE5spvlfDsrolPG/oPa/jowd
         2MYT54fK6/KcKmppB0vlf/gV4voMrTLgnklX6cbIhNkxbu7UqOzAPqXw8doczduUgyuA
         i9Flk4yArUlhkPsoS7pc5FqpaJJ5hTyJUZF3NJ6LOgTuE7MA1bfwi0wgmvon0mUfz8GR
         Y3qlR5MuYmTlgc/ZQpBmA3rkqZBnP2VIGernZXg6o1eo2b405L5qTq/Tj6znlkWXvDmu
         S0gyY8oeXFBNnRU3kJXvQhqGoJjk4YP0b3HstLd9pUD8EwCYBKumSDVhABLhy5NtrYvp
         RZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710999181; x=1711603981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdPjP84IZic2EoAFg94q9ioTBhoCVfACUPr9otSbXhM=;
        b=Q/CqgemgOwO/d52FwXNzIssYTc0Mo6WCJr57K/aZj3PyVhv7CnjyNaLk3ZQVkMZaMx
         kdTHG/Wx5vnh6rJMDdcvxCY5y/YxC3zkck47qYQCxtU1B58qR6Du7XY+/M/zagHFPnxa
         d4uwVuA4zrGuFbI1crRTTLh3bi5Qja8vEZCguDlfMvkP6+x6CKqAPP6T080YpPC2/Uhe
         BDCT6OO+WeQ4E1K0P8SGe5/d8vSEG3H9uN+ZghqXDIWu/bmtI/slPzjRVulUb4CpkL3h
         wqObwoh5WmDuNXp31XD2yUb1fmz20X2g6Kolf0fzguZCdWrfyeAnPlLBWNbrYW5vcxXz
         q00w==
X-Forwarded-Encrypted: i=1; AJvYcCWIBZVc4eSOvCpknaDlbbtommW+Q/1BgPPQSs1Tu8ejuLz3Acp4vKcjUx6WyK1Ck9Ode8i4uW1MGCK3WE1Nub0g+enn3isPmK2fjWs2
X-Gm-Message-State: AOJu0YxZ6pbzMQoQimpiYgBvDNOpmchkELi1tH1Pt7CrefmxSHpw4DLw
	z1Di9ZUfMRlZ6ExT8gmC8xtyfpJGcVuTOn/dJ174KmPZ1NNz1oYIA1M+f0Atj0g=
X-Google-Smtp-Source: AGHT+IGhp5Hb9VQ974bSDizDdPObUDCk5Nhc6/DIgkVg99Ur3u8VPRK/UjnQ8mHgTnedB/bk/ZjLQw==
X-Received: by 2002:a7b:cb91:0:b0:413:ee37:20e0 with SMTP id m17-20020a7bcb91000000b00413ee3720e0mr2763020wmi.9.1710999180930;
        Wed, 20 Mar 2024 22:33:00 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b00414659ba8c2sm4342626wmo.37.2024.03.20.22.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 22:33:00 -0700 (PDT)
Date: Thu, 21 Mar 2024 08:32:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8712: Fix line length exceeding 100 columns
Message-ID: <7392cba8-37e8-4165-b56d-6581ecac21c7@moroto.mountain>
References: <Zfs2u95QOKHAiR1B@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfs2u95QOKHAiR1B@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Thu, Mar 21, 2024 at 12:49:23AM +0530, Ayush Tiwari wrote:
> Split the argument list of the kthread_run function call across two
> lines to address the checkpatch warning "line length exceeds 100
> columns".
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---

This patch is fine, but you forgot to mark it as v3...  We're really
particular about that kind of thing for outreachy patches.  Try again.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter


