Return-Path: <linux-kernel+bounces-110881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E0D886528
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1791B23318
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4B6AD5C;
	Fri, 22 Mar 2024 02:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="b3vqPaUq"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B95C8C15
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073889; cv=none; b=jNQY4KnsSvjwvNiN1gfMlEQWcc2gQMnyHDWjO9kvRPwrbs5IjgZH/cmhCuy7iR5yU3U/FD/Caulo5gc1BI0tAfyXP5Vnbzg/9NhOA1OElcoSE7YMIr5r0vVEF6czz7nKWIjx4dS/my7uno4/k5GQ6po3hxZUjys9Kxj8A0Eabdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073889; c=relaxed/simple;
	bh=okMxw21g5ErPlSKWeHdG3qWKEX0bS7jcuyxPtq7fbow=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=lbfche20JBlIKy2Ivjz4FCMG4RXpJ0vjAnTSxZPc4FechYVJGRXS/X2kRBWWCJ1DHoog4ljmaM1+qDnErdXCPHrgyQLKZvZmhEMwZYuZx7ExEZITRMwyA0VgvFhcSYzg10YROTJdRddpw+z/w2npAwwTQLCJChCdgCjVSSyuPCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=b3vqPaUq; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-430ccb3d65eso12082141cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 19:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1711073886; x=1711678686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gmzu/tiA+wS1NVvzFexpqs83DytKPN0o3wMDhT4Zkik=;
        b=b3vqPaUqgxIYWkOEm5Jgr9zzFY2xeIeqFmqIWMp+PNea0izXm/9AFV76KjefaRZtnk
         W7lOl1u5qtArx0uYcAgh7C3gV5keee5ztrIFIvmqWBqDU58CFG4c52FREav9jWMnwzKP
         qyTcSKmDMV5jpe2NFFIsw/2DXQqYb05H4o5A/g7kcp3G6wDRinDWsw6PBb5T/MuGeWLY
         a7v9Ot296iZwuljC4IxrHhUGrC+fLKPN9bmXg04Mprpzgr5imh2Oq0s8sUqmuULhJg7m
         NXTqUz/b8QRLbncZ+81ea2EOIFs5rmun/fo9HP6yKHFq0YSgHfwa2mDlJiBeFHb89ECW
         XrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711073886; x=1711678686;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gmzu/tiA+wS1NVvzFexpqs83DytKPN0o3wMDhT4Zkik=;
        b=Sl146BJtmUr7ZjZsu776zw4KBHeLf+7hOrtOZTiAgas9Mmcn2ZiBdMNuFY6UiWo/dg
         Y0mhQzyGb0Z3yTj8AXAtCUTg2m2Jd0RI78hqQAv+Oh/+GB51VbV9P5EAfhVtQSA0w6k9
         AqOUOl7gycjeiskk+xVVDUU9+QBiLOEBv+950FW2+6j0yOV7mVgFBhxEwM7XfNgrIIrj
         tOc+tmK+m93K3gF33437a3Q5bKZ0ITejY+F8PHPgbA5O6PYZ3BlmxcmdLCPVXK8hA9S+
         KduY42zm02DAVwWcGZLkn7e9YGchQVqZRaH3nQwUDdImtGQmq1r5swYcRzr8utwr3yQR
         Ot7w==
X-Gm-Message-State: AOJu0YzYVI7N8iTDCRi7o11KnvrGw6YxWNEjkIzn0N5po1biIYNxdMHO
	MvZekClNr9AmhFgTiWP2Xqp/2wLZVN9kBiad/sXOSkawfvSeT8wr5SI2jp+X6F9lFqqgsmpABJ9
	+
X-Google-Smtp-Source: AGHT+IGo2KkRpEpH0s6zMyPR+I0a2w2mAG9OV5ZW0444Xf0w3nwPQWwFn/u8EaOQg0zgGEkfIaM1kA==
X-Received: by 2002:a05:622a:4e04:b0:431:3069:4601 with SMTP id dh4-20020a05622a4e0400b0043130694601mr405161qtb.6.1711073886370;
        Thu, 21 Mar 2024 19:18:06 -0700 (PDT)
Received: from [192.168.0.51] (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id bv8-20020a05622a0a0800b00430d8e11bebsm463840qtb.64.2024.03.21.19.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 19:18:06 -0700 (PDT)
Message-ID: <7c9b4c27-e179-c136-e327-4c467ece81a2@draconx.ca>
Date: Thu, 21 Mar 2024 22:18:05 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: PROBLEM: Linux 6.8 build failure in sun ffb driver (regression)
Content-Language: en-US
From: Nick Bowler <nbowler@draconx.ca>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 regressions@lists.linux.dev
References: <5bc21364-41da-a339-676e-5bb0f4faebfb@draconx.ca>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <5bc21364-41da-a339-676e-5bb0f4faebfb@draconx.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I bisected this build failure to the following commit:

  commit 8813e86f6d82a7931446c3cbc5d596f77d0f1ba6
  Author: Thomas Zimmermann <tzimmermann@suse.de>
  Date:   Mon Nov 27 14:16:01 2023 +0100

      fbdev: Remove default file-I/O implementations

If I revert this commit on top of 6.8, the build is successful.

On 2024-03-21 21:00, Nick Bowler wrote:
> Hi,
> 
> Linux 6.8 (and 6.8.1) are failing to build for me:
> 
>   LD      .tmp_vmlinux.kallsyms1
> sparc64-unknown-linux-gnu-ld: drivers/video/fbdev/ffb.o:(.rodata+0x270): undefined reference to `fb_io_read'
> sparc64-unknown-linux-gnu-ld: drivers/video/fbdev/ffb.o:(.rodata+0x278): undefined reference to `fb_io_write'
> make[3]: *** [/home/nbowler/misc/linux/scripts/Makefile.vmlinux:37: vmlinux] Error 1
> 
> This problem does not occur when building Linux 6.7 which builds successfully.
> 
> Kernel .config attached (gzipped).
> 
> Please let me know if you need any more info.
> 
> Thanks,
>   Nick

