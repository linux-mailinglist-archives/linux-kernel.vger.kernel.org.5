Return-Path: <linux-kernel+bounces-105237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C421C87DAEA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E154E1C20C91
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2A91BC53;
	Sat, 16 Mar 2024 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="legv67f+"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0388118EA1
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710608234; cv=none; b=bEBoV+NPVLoQNbcmYkD0VNEutGzKGFvXnGOir+1RIAlBup8uFCx9cb7xTcgYWrZ1b1OXNeqqd7hrbMZ8pC1hYByvhQHi8mv8xemTrOjPRHH1V2HiIycGMCh5DagOXxKWtdmYI+MSVAJB7yN3m/XeQKfw1iBU3D+9j5oaEtaHOuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710608234; c=relaxed/simple;
	bh=UmM1o6Eia63YbuZbWwh5bslZrP3T2HNZxhcV/27Jif4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=KjCoxeepSHpn9MOGXWDhiq96VRZKsEtbxdzkOhPIcZnD7x6PwSGMJj+7gwLlCBTjJZVVOXyqTrvI/N89p3LgxeHI+NiA3N2GxNH8k90BAw4G1oez2n8/nzvKs6Iyi6R4M1+++LU0dMu5gsDbLRQs/B8EzeWYkflRYNSNawaBzks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=legv67f+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e6f69e850bso1877670b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710608232; x=1711213032; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmM1o6Eia63YbuZbWwh5bslZrP3T2HNZxhcV/27Jif4=;
        b=legv67f+lJOMC7C+KnewIyYvEJEjM6aTMrpvQLiSvqoBtKbQ2Oxxicr2IOoKus7mBL
         qzHHi8ayNbOnvs9OGNd+IZVJq1Kv5KbfMsQnsMseEOvT13M4oa4tjHDpKwWxtq9nU9kX
         7gPawEJasmsJjTjVhKEUyE3IKfBaDTf1ysGuPkW51OIaR7RHare5JV/9uYGIj1n/apjj
         R7yqyuLBYHBv8VqjErhnRuZGjwmUOGnfr+5PlhMVhDW2DcWQGwMIkwDmSCbdL5nmTnfW
         9E7Xrd+wzx7NscBl+MrxhPrBM9poZSiQf/V/1+bCqrP/oYA7RpDxK2emiufXvF/U4+D/
         kbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710608232; x=1711213032;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmM1o6Eia63YbuZbWwh5bslZrP3T2HNZxhcV/27Jif4=;
        b=dHNBOCp9W7YdT3Vr1UEay8l8FFBGEmyzeqCAhoauN9dnWeXpmfrlEL55wLB2khbDWe
         RTmGJelNtsTpW5f1ipQ0JEU2Om4AboOv6sYETj1r/j4XBJAk4uIVEJgWIqieiqIlfBJl
         w4/rFcaRvS6+VmGWlWJVTZptfqCBPtyswy49ilmjd8iNankMHCAdWyse4fwgwIfMuLds
         0/IuCJPk9TAsTA4cNaSr6CZXgMtYmj5sfi9knN4pWeR1PzmYth/JTA8M3UesLs1gXscS
         nePd+I7Z0lz0pF3QSGjNIPVMda9EPRaPB3ngrhlmGEBSw1vR2hwCo/kywhLj8HWbfX9v
         iqHQ==
X-Gm-Message-State: AOJu0YzTY4y9mZP6nx0ZlRN64WTAVfblg1PFP8pl9pzSU5YatScwtLiG
	1f6eSV/m72bLSbvB2egp3XGNkD9j8ijpgejYSAOGbCMBXng0v91F
X-Google-Smtp-Source: AGHT+IHAV7+cvC9OK6NtWAmoepLFablSk5Qd5ISb0Evg8QF8oJm7ozetGcr3PIFdYTnWshF1PM7JqQ==
X-Received: by 2002:a05:6a00:22cf:b0:6e7:294:977c with SMTP id f15-20020a056a0022cf00b006e70294977cmr4949290pfj.18.1710608232182;
        Sat, 16 Mar 2024 09:57:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gu23-20020a056a004e5700b006e6b41511fdsm5350139pfb.94.2024.03.16.09.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 09:57:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c0ac9b5e-986c-4fad-b263-b5a55c096996@roeck-us.net>
Date: Sat, 16 Mar 2024 09:57:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: DRI mailing list <dri-devel@lists.freedesktop.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Daniel Diaz <daniel.diaz@linaro.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Reporting (or not reporting) drm test build failures
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

recently there was a suggestion that drm build tests on architectures
such as xtensa should not happen or not be reported. The current mainline
kernel experiences a number of drm related build failures.

Building csky:allmodconfig ... failed
--------------
Error log:
ERROR: modpost: "__udivdi3" [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undefined!
make[3]: [scripts/Makefile.modpost:145: Module.symvers] Error 1 (ignored)

[ also seen with xtensa]

Building mips:allmodconfig ... failed
--------------
Error log:
drivers/gpu/drm/xe/xe_lrc.c:100: error: "END" redefined

I really don't want to waste people's time if reporting such problems
is considered noise/nuisance. Is there some guidance available explaining
which architectures and/or platforms are "fair game" for drm build tests,
or, better, which platforms/architectures should explicitly _not_ build
test the drm subsystem ?

Thanks,
Guenter

