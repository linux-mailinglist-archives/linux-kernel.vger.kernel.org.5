Return-Path: <linux-kernel+bounces-32114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B0F8356AA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1962AB21168
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BE137147;
	Sun, 21 Jan 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qOErVZSP"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA9B34CD5
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705854745; cv=none; b=uPtzXGEiKALAJOrF22ATY6mAJk1rX5NJWKFfC2cYwAE4VuTJYy0fzQf9pxVdXQvFEq1DOe9ae5FO+fflgOZO32+yIJpSLwNySdWLo2k5x1/Geie57+74LQsBGwUZBciAWafMycn437lfqdLYkGRD2KBUKaSLEEURV1H6LZ7oBh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705854745; c=relaxed/simple;
	bh=8zEE9I8VVQtetaFadHdll6t6LLZXEd7fe7Zr2BRIELs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6QG/IeN/cekxi95eRabcUkul1RPKzf4Dr/hSkpJKpp+5m7Lq9uPI8/AaMfIVSrlsVSYUr4wXry2kspk0CBU09f44A9NXlQMaCcrMJLyC78DhEZxUuCRmnOU3yx0v1IFL4YpbyP5P7ZRU20Rdj7pihI5C8fIr6yP7q/rzcXzbDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qOErVZSP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so27195625e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 08:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705854741; x=1706459541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldc2CrIv74PboBZE+DvH0Rjv81zlMWieF3D03B91UUY=;
        b=qOErVZSPKLUNx92mhxNXInBshfhNFEF/6L3tuykE0HlfQVu8efYBfHZ/R0fMyapbVL
         YiAw8LHdyOcAETNk9uv6015iUZC+6vi5FB06es2vBDNDgZiiCm1Kb6ahFK4Mbvyepmps
         hM/hznHb24Dw3Jh1qX8r/nkLQwbH1epUIZg5S4vvO5DstRgOoMNcDW1RMLTln1Yb3frL
         Bol0UDTdwQp6w3TwojjQvPzEZHKV+nXx2pg6qhh4JdGtQXwYXsbui6nz/bjbJYjCiS8R
         o2VjLvab4KD2BXw7ftqsIPVQd5Kan9rFA2pCJdGVVRPmdeKei+at+hKJWpco343f68Cr
         q/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705854741; x=1706459541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldc2CrIv74PboBZE+DvH0Rjv81zlMWieF3D03B91UUY=;
        b=FnZJ6HTUXl+b7NUWTP1ova/GmVvUClYOXGmjfrngidGwRueNRsHDlfT5SWE/xSIrVC
         zdL9Vb8U6/5yyiIurPtxtFDXqFGTkG4tuHXOrHLJHZxJ8UxAbKa1rH73RCqm22EDvrIE
         9uir7XvA53xVdb9fzKcQJQd9Vhmcw/OF0tyEnMXyAArGTwTApCrV1kSu5agskL9KYHTU
         zPdBtX7TIWWEhyECcpx1GfRbw/nxFwILE9V6L/ST1Ss4unzKtO+r45vFQZ8kXZ0Y9gCE
         2btfUdqdvbZw8W0jaS6FapWyYcntt5AU4t97rv50wF8LGlQJ0avcdI7UudK5w2lXHdmK
         m5pQ==
X-Gm-Message-State: AOJu0Yw//e/cADJLG0I4b49UBZeFnWU2Sy4+iSp6U6DNyvIk+VzjR7p+
	K4L9HUDR/8tYvJ7DDxCIt6S8YR28l/iHDaHw2sqN75HB+7vcosKqvzq9Vva7pY0=
X-Google-Smtp-Source: AGHT+IGmjRdjijNnHR6sxxLbWx7HcuoCkDaDCqnI3nsn1Cgffmcz0c9w3kSC/IpmrXGVNhMYbpfFnA==
X-Received: by 2002:a05:600c:1913:b0:40e:4271:69ea with SMTP id j19-20020a05600c191300b0040e427169eamr1641380wmq.12.1705854741105;
        Sun, 21 Jan 2024 08:32:21 -0800 (PST)
Received: from vermeer (lfbn-mon-1-1176-165.w90-113.abo.wanadoo.fr. [90.113.119.165])
        by smtp.gmail.com with ESMTPSA id fa6-20020a05600c518600b0040e861ad5d2sm18158109wmb.0.2024.01.21.08.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 08:32:20 -0800 (PST)
Date: Sun, 21 Jan 2024 17:31:48 +0100
From: Samuel Ortiz <sameo@rivosinc.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
Message-ID: <Za1G9I+tYuIL9ser@vermeer>
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240114223532.290550-4-sameo@rivosinc.com>
 <1bbf8d3e-aa94-48c7-a1e4-76f9eefc4af7@linux.intel.com>
 <65a72c305291f_3b8e29484@dwillia2-xfh.jf.intel.com.notmuch>
 <5539c533-37b2-4b12-a5c5-056881cf8e3c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5539c533-37b2-4b12-a5c5-056881cf8e3c@linux.intel.com>

On Tue, Jan 16, 2024 at 07:35:30PM -0800, Kuppuswamy Sathyanarayanan wrote:
> 
> On 1/16/24 5:24 PM, Dan Williams wrote:
> > Kuppuswamy Sathyanarayanan wrote:
> >> On 1/14/24 2:35 PM, Samuel Ortiz wrote:
> >>> Many user space and internal kernel subsystems (e.g. the Linux IMA)
> >>> expect a Root of Trust for Storage (RTS) that allows for extending
> >>> and reading measurement registers that are compatible with the TCG TPM
> >>> PCRs layout, e.g. a TPM. In order to allow those components to
> >>> alternatively use a platform TSM as their RTS, a TVM could map the
> >>> available RTMRs to one or more TCG TPM PCRs. Once configured, those PCR
> >>> to RTMR mappings give the kernel TSM layer all the necessary information
> >>> to be a RTS for e.g. the Linux IMA or any other components that expects
> >>> a TCG compliant TPM PCRs layout.
> >>>
> >>> TPM PCR mappings are configured through configfs:
> >>>
> >>> // Create and configure 2 RTMRs
> >>> mkdir /sys/kernel/config/tsm/rtmrs/rtmr0
> >>> mkdir /sys/kernel/config/tsm/rtmrs/rtmr1
> >>> echo 0 > /sys/kernel/config/tsm/rtmrs/rtmr0/index
> >>> echo 1 > /sys/kernel/config/tsm/rtmrs/rtmr1/index
> >>>
> >>> // Map RTMR 0 to PCRs 4, 5, 6, 7 and 8
> >>> echo 4-8 > /sys/kernel/config/tsm/rtmrs/rtmr0/tcg_map
> >>>
> >>> // Map RTMR 1 to PCRs 16, 17 and 18
> >>> echo 16-18 > /sys/kernel/config/tsm/rtmrs/rtmr1/tcg_map
> >> Any information on how this mapping will be used by TPM or IMA ?
> >>
> >> RTMR to PCR mapping is fixed by design, right? If yes, why allow
> >> user to configure it. We can let vendor drivers to configure it, right?
> > I assume the "vendor driver", that publishes the RTMR to the tsm-core,
> > has no idea whether they will be used for PCR emulation, or not. The TPM
> > proxy layer sitting on top of this would know the mapping of which RTMRs
> > are recording a transcript of which PCR extend events. 
> 
> My thinking is, since this mapping is ARCH-specific information
> and fixed by design, it makes more sense to hide this detail in the
> vendor driver than letting userspace configure it. If we allow users to
> configure it, there is a chance for incorrect mapping.

I think I agree with the fact that letting users configure that mapping
may be error prone. But I'm not sure this is an architecture specific
mapping, but rather a platform specific one. I'd expect the guest firmware
to provide it through e.g. the MapPcrToMrIndex EFI CC protocol.

So I agree I should remove the user interface for setting that mapping,
and pass it from the provider capabilities instead. It is then up to the
provider to choose how it'd build that information (hard coded, from
EFI, etc).

> Regarding the TPM proxy, I am still not clear how it is going to use
> this mapping. If we want to provide TPM like feature, it needs a
> special kernel TPM driver, right? Even if we enable TPM support
> with RTMR, I assume it can only support pcr_extend().

Extend and read, yes.

> Other TPM
> features should be disabled. If yes, since we already have this ABI
> for measurement extension, why again support it via TPM or did
> I misunderstand the use case.

I am not sure the TPM compatibility is always needed, but for subsystems
(like e.g. IMA) that look for a TPM as their root of trust for storage,
providing the extend+read ABI and the PCR mapping should be sufficient.

Cheers,
Samuel.


