Return-Path: <linux-kernel+bounces-52732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0FB849C01
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6771C2376B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E470722EF9;
	Mon,  5 Feb 2024 13:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FwI6+fkk"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD7022EE0
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140229; cv=none; b=p3LVa+GORx6AuYLde+1TkvavH99twyPip3TadUn9lYPZ9asoqvv/NfYy2Fi+VTid1MX8vHucm7M6pUCU7Ocysr1LpyRtikXVNQ/I6m5em0KGlBd0Ygmt6uuHHUo0eSRqE+wzK8Fg+lBhMNkMSZjvaNWH7GGv/uwxdk9BBNE03yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140229; c=relaxed/simple;
	bh=fOSFDRKimv2ug0bZCZy4PNZkl8RruJjLYbcI79qt6K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayQOE6/RelTu7JOFdKeSr5krCiFxhER3Fc3hLRklwTp0aBIiGAaatC4KykqVNDCY6zPmrIAcSbK772MovYVcNXsrjwZlu2K94a7ATiDX0NeyH8GtgLsHaDD4PNnSUbioV/xocdUnaoXEn6cEj7+n5d1r+agMErbSMf523IhnUCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FwI6+fkk; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5602500d1a6so2025743a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 05:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707140224; x=1707745024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dhvBPdCRvn2fx27a6ngoUG20w6mdfBMhz1CdhmSbPVM=;
        b=FwI6+fkkYZEvjklRknU6DXSRMsmYvun/rAGakkPyokQ3L3/ELUaILvjvHRHiao8pe1
         v2TWheu7U7NbJbRBQJOmI9tl7byi2xgVgGN0b7rD+bBZbPOAZqxxTY0EPHeZyqfTOTsV
         AvBQokLzb8sxPdW5qXZeN7Ywyo259gCL4zgUTBzqiMT3xPAPUx7oHocNPVWDNoWukibg
         Jkiswh7v6n64/V14VLK9VIscbfBcZmI7mHwjSaDdF4C/ieGz2cRy4zB0I0K0CvMhjIfC
         jYXyeKhaRdpi03QaBhY9PqFG0RddCjXcCbKOEgdUTC9Uree/S+RXo2Tl8qaS+IGxhfpt
         WBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707140224; x=1707745024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhvBPdCRvn2fx27a6ngoUG20w6mdfBMhz1CdhmSbPVM=;
        b=iXyNf6j14g2iBQJPvJUzAf4SoBMspOjrcH96k6eZfcQiwjbZcPAs7HkjxXaCf2gLgH
         IlsJwZQ5JmYVHoRW6LyrSgII55M7ggdRu1q1oCxi5BujRP+iQt2thwRaw+ZbwxqBUnQl
         fAhgzCczre1dwS6bTSuNrSJO3ff5SR9oW/IZFJpdBvdXCu4Kqhffgiq/vyZ1ObrqaKif
         x43v6cFL/0HC67y7aaezTseZFm+Wns/pHbhCCcc32x0oIXY/4x0QVmtR/ePGAEw/lBKR
         V4xjs8tRogryDrE7dmMEiAm06nqNxyPZ9do7lYy9p2vKCt4X8LiE6L0pZx98YFHR160f
         Ec0w==
X-Gm-Message-State: AOJu0YxUS3CCXlS5luzjOFqKD3m2AsNRlDR9wT2q3T3r2kd0yfkE6oAW
	9RCXjisKOCNBYC6sWgKi0bDYej+f8yg5x5OY+J0vDkENSI1wOIXNrCqgdRKlzEU=
X-Google-Smtp-Source: AGHT+IFQjIpuSLDaVihr1fAeiTdUd1YkcJC0Qwa57kAqFLwOw5qPxXGFof2zMQ2wswOhBIEVO4Curw==
X-Received: by 2002:a05:6402:c90:b0:560:9277:80e5 with SMTP id cm16-20020a0564020c9000b00560927780e5mr191763edb.21.1707140224244;
        Mon, 05 Feb 2024 05:37:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWpleoW46IqW890YUCLtdnFwv+xQJHmszP0iVOwBL69TtpmHv4t1KzBGTuvqFXMV8IdHmuuWHcqgMmvc4q+Z0mAmvTVgQqAyng7GsB6Zsl7FKTNm6PxQdf0+ogp5NZltPThrv+Rqma0Igs8VmefyHznN3fKFLLLsAMzGJpRSTc4VEtY6IFjHXbMis2zJZtDMIFTRtqh/dS57xrWDOhHJN95wkj+inD9k6ISVaVg+xDTa3EGNrdxbRCqFfW0+myqMDvf/kaBNBzQq80Po8mGF0uuTQ74M9FRfz+Fm6f7NP0DQ/fb/mYBDzqqezrO8lD4JQajeiQLA4OFT+aMrgcZwDTUtxultQWw3Cym1WTenEt2fU+LvBBhPghurpIqMc/n5CRy2b51Pe5jzY4DBvFIq4a3UibU6YdXmzfS7l3B7eUj+sqKOKbAo8fgOSbzmWDhzvW/OvItjDPiC3i/gx3Q0Mnj5DaUKZ6lemZoB8HWTiW9yQN0ZXZlSBgD4u60rNHe6yLOclgiFgZJ4EVigC0DWo2OUYYUE2UJj0JKi4ilWfc3wd8fVqKBZElKfPiPtlvxHklwS5TaT84ywvUPjPqF6cH7u5ciZRpIPmO25gjc4m2tFRTQzFUW3YAgFyEaxR81t52+Jp2nZtHIGLU8iX0Erk38ZlgXGpkAtFZFwvFHaNvFiVKbRLfXmK2N00rQpn9eV8pdFfX6DaaGLzDVl1YRgvop7+sNe7ZeiqoJsLhbRNSifYH3Z9pLB6/iGsS99qiVGTA0+f6U
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id e21-20020a056402149500b0055f4fbc32ccsm3782761edv.89.2024.02.05.05.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:37:04 -0800 (PST)
Date: Mon, 5 Feb 2024 14:37:02 +0100
From: Petr Mladek <pmladek@suse.com>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	x86@kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>, Darren Hart <dvhart@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v3 2/2] printk: Remove redundant CONFIG_BASE_SMALL
Message-ID: <ZcDkfmDt2XRq5YLA@alley>
References: <20240204232945.1576403-1-yoann.congal@smile.fr>
 <20240204232945.1576403-3-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204232945.1576403-3-yoann.congal@smile.fr>

On Mon 2024-02-05 00:29:45, Yoann Congal wrote:
> CONFIG_BASE_SMALL is currently a type int but is only used as a boolean
> equivalent to !CONFIG_BASE_FULL.
> 
> So, remove it entirely and move every usage to !CONFIG_BASE_FULL:
> Since CONFIG_BASE_FULL is a type bool config,
> CONFIG_BASE_SMALL == 0 becomes  IS_ENABLED(CONFIG_BASE_FULL) and
> CONFIG_BASE_SMALL != 0 becomes !IS_ENABLED(CONFIG_BASE_FULL).
> 
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

