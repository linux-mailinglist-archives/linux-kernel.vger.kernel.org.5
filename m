Return-Path: <linux-kernel+bounces-140745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F014C8A18B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26DC0B2A419
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C0F2BD1C;
	Thu, 11 Apr 2024 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U5YRkVIs"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704C115E85
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849142; cv=none; b=Svf7NOEd3CWENxWbm/VtY2TwGDt1qRU6641qmI5Ua9bOkHmvxYbKglC+8lXuvgpOUthWrqU4Yjxz6sSAFV/gBdZCPR42KYC6b86f5u59cVZFDmcwrpB2dhKekUiI9F0xkHTzNbj/LHp9SK/RLfjq5MkEZM/g82IY0vb+BkKJ4Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849142; c=relaxed/simple;
	bh=S0tSkli8JleHY8iE9O2afY6bV3mjLC/eVHPCMEho8Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fsk8dbQetVKEZBqNSFDZFsL+Gt03+iASl0FOywurA2Q9YqqIyJN0YtvnW4OBe6k5Rc5EHAmIxjR+P11an5li0ZD1eu3KWmhvNcf1LpOY9/DWY6/1/sTSqmgvxkMoXuyACWxym+ujcVM/UjI1pDwa7CXIq1qxI4CSLqY+ldHH09g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U5YRkVIs; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51a1c8d931so791401266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712849138; x=1713453938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CABfqMACNUngHNLxS+WM0hHJ1yaxWLelGbJxYjHioD0=;
        b=U5YRkVIsfjsdxYrqviqFldW3aGgJpxI95Xx9WtuZtRE4oGNUou/5vryJRC9Fm9mbWI
         0oW0BHPWPWBNjOdKKZtlJlPuSTA7JCxqdpogQMFdoBWF1OD3kPk3rs7hdHqbvgvZDg0g
         FPiIFMNvhw/PbASOX8xkWBMy8iKmqHbZbXdnniQgC1etonGUdgwPRRGtUD4z+eu6vlgb
         Hnq5Ee+6VznM1khG44NboOAIt8kYqj5Q2zDb+onyXfL4pNnVpUZMlB7sfzDCSNFLZ1Ss
         C8s8Fb2FJ1eVCLip9agNb+b1Vd0rUZFWc6akd2nrOheBpdsw0oUWp/Fy5ElLUlEqV/k0
         LcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849138; x=1713453938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CABfqMACNUngHNLxS+WM0hHJ1yaxWLelGbJxYjHioD0=;
        b=OCiBKeAg1My5ApVERSlrcInT3QjjRbzwrfvVonMZo8n/jRL/x5HtuK+M1KIkpc7t0A
         umGNTZMNLX/wLvyvAyGk4U15O9DgZIK9hMmujjAyR70c6dM93p73Tkb6EQ2BvoCkwqtl
         a26RRppNuqa8WhJZ6fXdV8BLG//hG3wjPK9PMXd9PUU5+gu4rnP1Wc+FjJyVT41xfrNT
         UZNmSMZ5HqEqdOiup14VuLRME8biH420G8xLaySfQ34BwAHprs56q/GCqcYeI63jy2wI
         /RCnX1580ew493/vMpEnCuU6hhnVrMvmqC68UI/kCXRkLigwherW8gRkLi6kimClLYnw
         u8jg==
X-Forwarded-Encrypted: i=1; AJvYcCVrz3AVz5Iwx9uE+igEWIpfjKFKzCinDQKXbxeyQuyfT+vYCltLk3HrTZk4W7rkqxJh6Ny1fP6naJM/L8CVRbidfv44B9k++1qqHoJu
X-Gm-Message-State: AOJu0YxbIajbuubVEp1dRTjsENN8nKMbC0Lsbf2QC/Y0Rc1d7qwpO8ch
	QkTDa6AdOgROIGdMYY9OPKnIfdhDjkBuA0aPNVcrmLs+bA/XfgvQCp8NHIjf/mA=
X-Google-Smtp-Source: AGHT+IEEewk7llSPmgrxe/7mA2rySV/OUDonUpYE2d0l2M0z39pI2HKiyjdOd8AbAw/PCbmxmW//Bg==
X-Received: by 2002:a17:906:4f06:b0:a52:3d1:6769 with SMTP id t6-20020a1709064f0600b00a5203d16769mr44591eju.14.1712849137563;
        Thu, 11 Apr 2024 08:25:37 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id r3-20020a170906350300b00a522c69f28asm225076eja.216.2024.04.11.08.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:25:36 -0700 (PDT)
Date: Thu, 11 Apr 2024 18:25:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	speakup@linux-speakup.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-afs@lists.infradead.org, ecryptfs@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-arch@vger.kernel.org,
	io-uring@vger.kernel.org, cocci@inria.fr,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] treewide: Fix common grammar mistake "the the"
Message-ID: <0bd7ccc2-4d8c-455b-a6c2-972ebe1fcb08@moroto.mountain>
References: <20240411150437.496153-4-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411150437.496153-4-thorsten.blum@toblux.com>

On Thu, Apr 11, 2024 at 05:04:40PM +0200, Thorsten Blum wrote:
> Use `find . -type f -exec sed -i 's/\<the the\>/the/g' {} +` to find all
> occurrences of "the the" and replace them with a single "the".
> 
> Changes only comments and documentation - no code changes.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---

It's tricky to know which tree a patch like this would go through.  We
used to have a trivial tree for this stuff but I guess that didn't work.
It's possible that it could go through linux-doc, but probably it has to
go as a set of patches through each of the trees in the CC list.

regards,
dan carpenter


