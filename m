Return-Path: <linux-kernel+bounces-65694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6DF855083
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD911F2AFE5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC37F84A3D;
	Wed, 14 Feb 2024 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MatnQ4pI"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2074A84A5D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932380; cv=none; b=WH9BZmCQ/cPFCX3rgTBhCB0pDV3aaRfFv76InOqHbxCtAmDbWWFTldkFrwbllRLdiolwivIUdLSVEZ0luX8xt0HHN0B9+x7CQMCIPKlctbyvtvtKu8ulcfXz7lYi7e/oaTKXbVoLzp4OBgnLiD7xpZL3YbAFY2SM5eNkKUTnFAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932380; c=relaxed/simple;
	bh=OM0x46JCVVAHrJ5IMUKXDrphSJGApFAK1gqtkAA3Ozw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oq0wT/8VYgpexVHQWMpyOAatgLWFn2LkCNOihRtlpRswXRH+VB2L59xTSlM/s2k3cn62bWQtycAxRXg9eWVMgypvk9EtRG0/rj2bNOBSu6CS8piLIGbgPh882vPZbkczDbRqU0vZoDEu52Wvbe9JpxyDArco/XYR9r8zLQ8ZyZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MatnQ4pI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-411a5a86078so22306235e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707932377; x=1708537177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cr4AUbLb4Tlg5EF++RWRUguumIyFcjXyIqj/taO18zs=;
        b=MatnQ4pI+ecY4RboTEIOJUsR8j+GDPYgLTm3YzMBg4zgqP1gkfwymAznQgZSh2+YCh
         rQblJerp6M0/eNT0Ds3qZOykfrIvaHhtMVRQrNpvjo1yar5SwGwTev/i0mDWH/rCmC03
         ZJuLw8evDFC+Emd0VKYNLc96dwndWX/YxAcBQ6GzJNc+t7rv++urk8sDn0JLDklgefdJ
         JMGHInlB+eLoqi93XD61rzuO+2akfA/cABLQiDQ3JgOZPLn++pZ35Frg0vihTB0tf49U
         +MCGliyBJL6fABNocBHrRK1qnILJna1+BiRcMEwrgbBj35qQHyRMDYinel54BsFnRZYm
         UFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707932377; x=1708537177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cr4AUbLb4Tlg5EF++RWRUguumIyFcjXyIqj/taO18zs=;
        b=SPiRcKF04MfL+pduc++luni7PINMioSnpZYeSppaOe2Az7oavlKjpBt2ceLEzRXlA+
         hlrsJtgRju+PhgRQDIgS5cdA3AO+3JXNWW+llunKxUiI8d2lDZlPwXRTeRYaA+o0kIRY
         pBpGM6lwW/jvuPZB8pchpdC4vKmrubN7tFUB18jnq+2axFWCsYM3y692dHGJ/Ehzspgb
         4fvMoh8dH1A8zNCOWOPv1hq0vLPlswXpx+GQ7DPXGdeJlhyny9mieC2gUMieT5AlDORZ
         WUfrhzEIBD4Vf8iIc2uKp6RLdRZqs5Xp3uhQWDnxX1V+5vpmQe8KAksOEyOVK2C2+xcc
         4LLg==
X-Forwarded-Encrypted: i=1; AJvYcCV7EXNxzoXuzUhI3ZzipniduVF0R1RnBu+jBGVvwuelKYhi6mQFhNTNiUOXES+XZ22z8Q379zBQVEBQ2YBua+Hx1XxAICWdiVad7xSp
X-Gm-Message-State: AOJu0YyyauPbMnaPCrInnweX083mweX5yai0wVRMAmCdVWn/kfcExjD6
	Ney7Yx+DHDozej618R7MJEtvcXXFafvdhiAPN0d17inAalbTmTE=
X-Google-Smtp-Source: AGHT+IGDdtc9GUAQc/7QbVRkFp7Mrah3RSa78EjMWl+SyBzBRV/lk+8FErFam/3EEfQrGEfwDuW+lQ==
X-Received: by 2002:adf:e591:0:b0:33b:63a3:450b with SMTP id l17-20020adfe591000000b0033b63a3450bmr2224153wrm.3.1707932377120;
        Wed, 14 Feb 2024 09:39:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUaDcoUns/VELPIlv7/cXGIsqVDdBkHRXrQgDqL/RL2DECfCKeovdNYV/d1fpJ++INJJ1Boehuzy9t1OyvmwvgYuZGy9Jws0aA4Aup9o5+Y8XTB2Vl8zZKNECY1tFCRDRHBdsmKiykh3jN6FOEWM2VYiXomb/XJX9BjPCk=
Received: from p183 ([46.53.252.131])
        by smtp.gmail.com with ESMTPSA id e30-20020adf9bde000000b0033cf5769ab2sm522263wrc.101.2024.02.14.09.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 09:39:36 -0800 (PST)
Date: Wed, 14 Feb 2024 20:39:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	linux-kernel@vger.kernel.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [RFC] include/linux/make_type.h: Helpers for making u16/u32/u64
 values
Message-ID: <cee345b1-a5aa-41bb-acb7-9b2aaef5bfb5@p183>
References: <ffa107dd-23dd-47e0-b3bb-06c60ca3e2e2@p183>
 <Zcz5GmAtPbdInWJU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zcz5GmAtPbdInWJU@smile.fi.intel.com>

On Wed, Feb 14, 2024 at 07:32:10PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 14, 2024 at 08:20:55PM +0300, Alexey Dobriyan wrote:
> 
> ...
> 
> > Secondly,
> > 
> > 	#define make_u64(hi__, lo__)  ((u64)(hi__) << 32 | (u32)(lo__))
> > 
> > doesn't truncate hi, why?
> 
> Because it's not needed (the whole point AFAIU is to override promotion
> to a _signed_ type (int) and here it makes no difference)?

Well,

	make_u64((u64)-1, 0)

will return (u64)-1 unlike

	make_u16((u64)-1, 0)

which will return 0xff00.
BTW, I'm for truncation, but it should be done everywhere.

Thirdly, there were no users posted.

