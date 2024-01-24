Return-Path: <linux-kernel+bounces-37251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C1D83AD4C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DB61C21A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96FD7A734;
	Wed, 24 Jan 2024 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfEifdag"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EDA5384
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110082; cv=none; b=tcaDBmCJPnmHsgQFUF+mbq4WaIGddmIgIyLZEELTnUnUs1vQ4zdqACZQkCsNHzaCe7xmUScaQyAUpzft03vpK33zt4w04lK1lOknAXYoQI6uQxr6cO8Hkm/pSNrozzN2LOFArC3Swef9pQWzUYViAYAeLyo3d0SaeXVbFyFBqnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110082; c=relaxed/simple;
	bh=djKs0TQvAPDhrKH+B4kuwqUT/A1i1mMshNJWMMPN59E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPd7xEgsNaKUeZGiH2QOCWfN/vKnIUO4tcP4/mOSl7eXQkz3Q2XJZyJRwle1+pxDzi+4w9EoE22K3kHm1CAg30wdCuPbKIXPxGLYZa3Sw34A2GfOeq3BXjGpvUvZ9z4OJdocOqG0N1reIrIR6s3GmN1IaOW0qsVz9i8UsCT+4oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfEifdag; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5ffcb478512so28249947b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706110080; x=1706714880; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gxAN85gUI3DtBv5GX7Pwg8/v675qo3nL0TCB7s3sYeo=;
        b=nfEifdagQtD1k4dXIOSTlMPHcW5vb0BK0R5dvVD/wCwqjWTp3rO2dTHa1cNJ8nv0Xv
         hZPyaF8ok+KI3j6uL/S1C20w65ZuDs9SbQ4aOLDGT6eObg2Jqf/SXKmOxKAAEiD/GAcV
         Bx6a7L/5gNcmBdbWawChKrw4TYrxKsfAMtEUE7HPrD9oBBu/tLnqTYZftwXnkl289Q8j
         YTXA1Fz9dd+1U14EzTujZ1fSqqmfE/FCESWl5mnKNB/2/v81RCtpiXERMWDsSJLBEHPl
         8OIni1afmASRemf2YYyp5oH8O1VQnOl92Xg+aNhg6O24PXiq/yHMoXyAAY9HoafjUMcy
         aKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706110080; x=1706714880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxAN85gUI3DtBv5GX7Pwg8/v675qo3nL0TCB7s3sYeo=;
        b=KKd5nB6ajnGgqpQVHqyZTll+jPWzDtwxzLC/L1UO4JPgrPvkiz0v6YzzFhoePbjvuQ
         vQT8ChlS+vFoFzckqHK1aTEPdmabA61R+ODyPue9S7hf2mSw9KLnUoyVQKOhdRKUXCxe
         qnQBgpHd/O0PMitpC/vpiPQbyP89UaJPZ9dlmxS2ja5AMmPpfHvRtwpRkgo2GzJaGQMt
         OdRPaW0VslatpUg5blqIG3msYgzZDkxxxFdbm5z00eBhkjT8DW0oU6Eiudtp9k2OynSh
         ZB5njZvhhz3nEUdIcwQZRMRs+KHEX8iKjfuMM/qd0j/4AznP4hnlKvwAHWRamdhQzRez
         icTw==
X-Gm-Message-State: AOJu0Yzujb/IQOC3FOjUvJTiFfn/iGFeqeS57PO+2CAfOZuAbIJlcyDt
	unxooXirSPOJYaBKpepxUAFHC11fotTIfLE2itSl+IW7MpCePbTOZ8ue7SpM0NQ=
X-Google-Smtp-Source: AGHT+IF+Nrdu9tGDR3beDItGL0E/OCg5dlfhAXrIkzQiMnlkPIfHnj8IoCqnWGxeMxmoNRKEWLNNSQ==
X-Received: by 2002:a81:a251:0:b0:5ed:b2a2:1279 with SMTP id z17-20020a81a251000000b005edb2a21279mr609856ywg.16.1706110079553;
        Wed, 24 Jan 2024 07:27:59 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:abdb:7236:6977:9ab5])
        by smtp.gmail.com with ESMTPSA id l124-20020a0de282000000b005ff9dac3ff0sm652ywe.56.2024.01.24.07.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 07:27:59 -0800 (PST)
Date: Wed, 24 Jan 2024 07:27:58 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Subject: Re: Re: [PATCH 1/3] bits: introduce fixed-type genmasks
Message-ID: <ZbEsfl0tGLY+xJl0@yury-ThinkPad>
References: <20240124050205.3646390-1-lucas.demarchi@intel.com>
 <20240124050205.3646390-2-lucas.demarchi@intel.com>
 <87v87jkvrx.fsf@intel.com>
 <gvkvihpcc45275idrfukjqbvgem767evrux5sx5lnh5hofqemk@ppbkcauitvwb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gvkvihpcc45275idrfukjqbvgem767evrux5sx5lnh5hofqemk@ppbkcauitvwb>

On Wed, Jan 24, 2024 at 08:03:53AM -0600, Lucas De Marchi wrote:
> On Wed, Jan 24, 2024 at 09:58:26AM +0200, Jani Nikula wrote:
> > On Tue, 23 Jan 2024, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> > > From: Yury Norov <yury.norov@gmail.com>
> > > 
> > > Generalize __GENMASK() to support different types, and implement
> > > fixed-types versions of GENMASK() based on it. The fixed-type version
> > > allows more strict checks to the min/max values accepted, which is
> > > useful for defining registers like implemented by i915 and xe drivers
> > > with their REG_GENMASK*() macros.
> > 
> > Mmh, the commit message says the fixed-type version allows more strict
> > checks, but none are actually added. GENMASK_INPUT_CHECK() remains the
> > same.
> > 
> > Compared to the i915 and xe versions, this is more lax now. You could
> > specify GENMASK_U32(63,32) without complaints.
> 
> Doing this on top of the this series:
> 
> -#define   XELPDP_PORT_M2P_COMMAND_TYPE_MASK            REG_GENMASK(30, 27)
> +#define   XELPDP_PORT_M2P_COMMAND_TYPE_MASK            REG_GENMASK(62, 32)
> 
> and I do get a build failure:
> 
> ../drivers/gpu/drm/i915/display/intel_cx0_phy.c: In function ‘__intel_cx0_read_once’:
> ../include/linux/bits.h:41:31: error: left shift count >= width of type [-Werror=shift-count-overflow]
>    41 |          (((t)~0ULL - ((t)(1) << (l)) + 1) & \
>       |                               ^~

I would better include this in commit message to avoid people's
confusion. If it comes to v2, can you please do it and mention that
this trick relies on shift-count-overflow compiler check?
 
Thanks,
Yury

