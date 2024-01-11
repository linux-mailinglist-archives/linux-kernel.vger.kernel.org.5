Return-Path: <linux-kernel+bounces-23450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5CD82ACE9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029A01C217CB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B1314F8A;
	Thu, 11 Jan 2024 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EU56OfHg"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4CA14F7E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-336788cb261so4314306f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 03:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704971314; x=1705576114; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eArl0J9snWFjvLCA1JVy+E9ET+56tJ7DzHvCP0XQ1Wc=;
        b=EU56OfHg0pkgCZfP60AlsFvNEEkoLYpP9ihaIt4OOn9kk+gXDWt8YQ26CwTGBIRid8
         lcewUgKfdx+YAToN1VCWYH2YxjYLBJ/hkeyi/z2WUX0N1025KV+a/eY7bWSR/eAUx0IV
         T1CVYbyEyvn/027qq85zlexi20i5tYz2z+4DkNWTrdF9x0KjOIj37e+llVDwBlFx8J3m
         LVF450Mee3g8geVFrVTuS1VCTWIO707jIn+p+fITtW5VnYiHfTVUbzp9ukYuGnlZEedF
         fqcgkw++zT/slQcq1HrbyHazuwG87tsrRR0+yN9XAGRSqwVB2Bk0OABOgofLxoXx+ID4
         nirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704971314; x=1705576114;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eArl0J9snWFjvLCA1JVy+E9ET+56tJ7DzHvCP0XQ1Wc=;
        b=XsaRQaqe5n38GMR+cmZN3S/MVuI0VmhLyTPJyCgVVLH3JZswif2PRZ3TrGHfmDtzel
         WTMKJNLnk9S6U79E/j5h5kAIrM1XFz1ioVhMLx5SwgM6r1MvzKCUPIK6outPDEcosDXL
         m/2z7ks0PRG0BNHATOaFGaRwxxf1XZv2Esmcz6r4gj4pDjkWUWqQ/7fLdlRFxbCCYJ95
         O8iWSYaWCtvoNv/vOJaHSQtxKiQdLc/YmMDEajK85ER1+MZaX3T5sVV6zUQxBXtjXYgU
         6bnzx44cHjnqOfMi1dsMGN04/qxyokM3Y9Eu1N9gD2KoiD8E5jN/o+OLZa0KBhlDyKnZ
         PjkQ==
X-Gm-Message-State: AOJu0YwlbJ8H6OfSLeOmks4GsBzk49wT7KDhg5saBRnqQdPNzOgisztH
	W7AYFOwV9SSM7ey1NZUEDIYZI9H2u+MZQw==
X-Google-Smtp-Source: AGHT+IHfFKoFfGh7YmCJPyTu7SyByoVFSI5Uvj/YzPFv6C8CPJZFRzH7fC/fg07E6Op5W/QrWqaA0w==
X-Received: by 2002:adf:ea8c:0:b0:337:2aa3:ac85 with SMTP id s12-20020adfea8c000000b003372aa3ac85mr486203wrm.117.1704971314057;
        Thu, 11 Jan 2024 03:08:34 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d688c000000b0033718210dd3sm929700wru.103.2024.01.11.03.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 03:08:33 -0800 (PST)
Date: Thu, 11 Jan 2024 14:08:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Pranav Athreya <pranavsubbu@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Forest Bond <forest@alittletooquiet.net>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: Remove extra blank lines between code
 blocks
Message-ID: <8988f86a-f850-49a4-b7ac-ae363a7898d4@moroto.mountain>
References: <20240111070652.71717-1-pranavsubbu@gmail.com>
 <2024011144-silica-viral-9e79@gregkh>
 <CAP1Lp88vEZJtd69Njf9uZ5VXypwZ-5vLdBHf2xoLSpqmeyEQiA@mail.gmail.com>
 <CAP1Lp8-CP-uELVam=18oADOEvL_13wXkTyDLHKbjQe1ZyxiG9g@mail.gmail.com>
 <2024011144-sinister-baking-952d@gregkh>
 <CAP1Lp89zshQW_s0eLJjekr5tyc3XLaPnh2VGFrNDHTA7GT51ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP1Lp89zshQW_s0eLJjekr5tyc3XLaPnh2VGFrNDHTA7GT51ZQ@mail.gmail.com>

On Thu, Jan 11, 2024 at 03:38:16PM +0530, Pranav Athreya wrote:
> On Thu, Jan 11, 2024 at 2:57 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > Yes, please read the kernel documentation for how to submit a new
> > version of a patch.
> 
> Reading the docs now and will send the patch right after. My sincere
> apologies for the top posting.

I have a blog about how to send a v2 patch.  (v3 patch now I guess).

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter


