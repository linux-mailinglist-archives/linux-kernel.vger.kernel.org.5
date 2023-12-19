Return-Path: <linux-kernel+bounces-4617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20283817FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1131C22A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F255749F;
	Tue, 19 Dec 2023 02:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVp2ouTD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364CE6FAD;
	Tue, 19 Dec 2023 02:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28b6ea19368so1925915a91.1;
        Mon, 18 Dec 2023 18:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702954251; x=1703559051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b6KMMB/HsazvvB+R5aNcKj6sbn+ODriqkPfyxArm1ds=;
        b=ZVp2ouTDDkWlZK1WnUTctZ6P09xg0xEEpqsAI/MhzpiwdxNzl0dXlxC+4znxP9EDvq
         ximgasFVpcjm5p1OrNxhJNrbuzeh8xuBoowG63oN46Niof8ciWT/ynxUcBnkHzz4WZ6o
         2Ynx/YFNVHwOfCDkw/J2vFLCoNqj+L8gv36+CEvKb1486owxfje2XNfn8tDzqSqIJmpD
         5tfsstNv5R92ns7i3RoxydqgUMADUYnZg36X94F06tk5RkoT0dSZWJzg39EEMLzdyP9N
         BFV2wahk1iKuczT4LUTz+wPWhYPHvteOp6nawv3UXxwhGZ9znkDO3A8EY2lU0QaRn9Ji
         CEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702954251; x=1703559051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6KMMB/HsazvvB+R5aNcKj6sbn+ODriqkPfyxArm1ds=;
        b=SQQYQ5sx9kOzn3ait4ghxsRKYxlNxuvj998NwdAdj0GDUKtzNbimHz37eJg/z9jPSK
         JkHEv4FKEL88rt9Gs8Nqp5ZnxR6V5gQWsXA7MMtkwjEtU0uetqEvf3xdUJ3ir0lXBag/
         B/cKaIhZH+TihyAiQFgaPZYTxIj4HOjBnwbLIcRtpv60NSTgpqZEUwpUfrPk/3D6aRio
         aAX1F0Miln82pOudHygqoeLDSFLt5FSDPWtJbdf9aFSR4SImkgC5THLFG99yftx2kef5
         Wb+yG/dVpTH07Ns4kfGg18WzLmlIScbS3JFTcckslpu1EoPYqO0vy+nkss3YigZP1lhG
         zQrQ==
X-Gm-Message-State: AOJu0YyHBE3U+Qd3B2nMKyvewPKEtbOm/LGshWHkSAs48nIwrTE8U5oH
	062OF/+0wd8f+y3rinxz1sU=
X-Google-Smtp-Source: AGHT+IE+lwry5NghZCyWmAqCQ2YE92qagSNsqtV0PaWtRYxGPjp7bhyPfdCAmxV43mYiQ5yU6PAe/A==
X-Received: by 2002:a17:902:7ec8:b0:1d0:8cbf:39db with SMTP id p8-20020a1709027ec800b001d08cbf39dbmr15255381plb.88.1702954251261;
        Mon, 18 Dec 2023 18:50:51 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:e0f5:2344:80e4:a1fc])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903245200b001d34126d64dsm3950852pls.222.2023.12.18.18.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 18:50:51 -0800 (PST)
Date: Mon, 18 Dec 2023 18:50:48 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Antonios Salios <antonios@mwa.re>, Arnd Bergmann <arnd@arndb.de>,
	Deepa Dinamani <deepa.kernel@gmail.com>
Cc: rydberg@bitmath.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Henrik Weinstock <jan@mwa.re>,
	Lukas =?iso-8859-1?Q?J=FCnger?= <lukas@mwa.re>
Subject: Re: element sizes in input_event struct on riscv32
Message-ID: <ZYEFCHBC75rjCE0n@google.com>
References: <c812ea74dd02d1baf85dc6fb32701e103984d25d.camel@mwa.re>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c812ea74dd02d1baf85dc6fb32701e103984d25d.camel@mwa.re>

Hi Antonious,

On Thu, Dec 14, 2023 at 11:11:18AM +0100, Antonios Salios wrote:
> Hi all.
> 
> I'm having trouble getting evdev to run in a simulated Buildroot
> environment on riscv32. Evtest (and the x11 driver) seems to be
> receiving garbage data from input devices.
> 
> Analyzing the input_event struct shows that the kernel uses 32-bit (aka
> __kernel_ulong_t) values for __sec & __usec.
> Evtest on the other hand interprets these variables as 64-bit time_t
> values in a timeval struct, resulting in a mismatch between the kernel
> and userspace.
> 
> What would be the correct size for these values on a 32-bit
> architecture that uses 64-bit time_t values?

I think there is misunderstanding - we do not have *2* 64-bit values on
32-but architectures. Here is what was done:

commit 152194fe9c3f03232b9c0d0264793a7fa4af82f8
Author: Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sun Jan 7 17:44:42 2018 -0800

    Input: extend usable life of event timestamps to 2106 on 32 bit systems

    The input events use struct timeval to store event time, unfortunately
    this structure is not y2038 safe and is being replaced in kernel with
    y2038 safe structures.

    Because of ABI concerns we can not change the size or the layout of
    structure input_event, so we opt to re-interpreting the 'seconds' part
    of timestamp as an unsigned value, effectively doubling the range of
    values, to year 2106.

    Newer glibc that has support for 32 bit applications to use 64 bit
    time_t supplies __USE_TIME_BITS64 define [1], that we can use to present
    the userspace with updated input_event layout. The updated layout will
    cause the compile time breakage, alerting applications and distributions
    maintainers to the issue. Existing 32 binaries will continue working
    without any changes until 2038.

    Ultimately userspace applications should switch to using monotonic or
    boot time clocks, as realtime clock is not very well suited for input
    event timestamps as it can go backwards (see a80b83b7b8 "Input: evdev -
    add CLOCK_BOOTTIME support" by by John Stultz). With monotonic clock the
    practical range of reported times will always fit into the pair of 32
    bit values, as we do not expect any system to stay up for a hundred
    years without a single reboot.

    [1] https://sourceware.org/glibc/wiki/Y2038ProofnessDesign

I'll let Arnd and Deepa to comment further.

Thanks.

-- 
Dmitry

