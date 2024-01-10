Return-Path: <linux-kernel+bounces-22090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0614829907
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7857A28220E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB6A47A59;
	Wed, 10 Jan 2024 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="HioB4ei+"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553FA4776D;
	Wed, 10 Jan 2024 11:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28c7e30c83fso2615733a91.1;
        Wed, 10 Jan 2024 03:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704886168; x=1705490968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sd9KoMYLeziNK4DDc7cQHmh6PfB06g+zdl70q6cPYIg=;
        b=f1rP7yr3tWhzGDwLAmA9nqhIF//0k96EpX9alVIDLamDElSSTV3UNtvYyDd+mJGsen
         tMomz39JcaytLqrrp+zAn/jPdaHAvrHG1Kks2vuOf3b9FqRThEMgDDZH5wVwYHo28Y9N
         ujO3N6CVdEkg+nXizBlHNJB/lwlGQ7AIORDEr04pOryzLR4XnhyPHqdoDtYZzLjoTCh5
         GWgJb4jU3HEJXDr4InmpeoSc6KvVttLxpnuFRiQueGzwFWN+EQzjlg0SETeZAtfNmC2d
         g2P0MgionfLJkxFIKdl3viwkQbqVXyqQd+Q3Zqs22wWB+Ryt2opDYfEGbrYHNOqvj3xM
         ITPQ==
X-Gm-Message-State: AOJu0YzZ4vlHssYtXYCKp7+PC/KrKziWooSk9i/HZUOndDgaMx8vAHTg
	tbSIdqyhMXOnQO3u0w6mWDE=
X-Google-Smtp-Source: AGHT+IGUaroPt6ao2/Q+kSx/LjIuD93mF78quMxU86dAnctI1ISMFoW3uRBD7N6iSjeIEqnKq9uaDw==
X-Received: by 2002:a17:90a:b883:b0:28c:5b7:87c5 with SMTP id o3-20020a17090ab88300b0028c05b787c5mr411371pjr.2.1704886168502;
        Wed, 10 Jan 2024 03:29:28 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id r7-20020a17090ad40700b00286920600a9sm1283168pju.32.2024.01.10.03.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 03:29:27 -0800 (PST)
Date: Wed, 10 Jan 2024 08:29:26 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1704886166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sd9KoMYLeziNK4DDc7cQHmh6PfB06g+zdl70q6cPYIg=;
	b=HioB4ei+m4iR+RQEiNF+din6hdYrf6xMT6HKSS2BpKdw+CcHDihLB3fyM2aDVCUMvmKHpj
	FJSy8F26WGNT6Gvqoyf2j+Ctss10SrgFfIrHJ3MbwGHlfuPMrDIzy8VgYjU5LH9BB1uqhC
	PSpxWvWPueimV/USCu5ziJTIhgTptIfOkrSKshflZR7Lfh/XndzC2J69yem1AOogCkaNtG
	TVPL5Zl2LenfqSoFR4RcDeJZQg6qYCP4xr9UAXwnFO7SGcEIJ4DMQAcshXlmEOD9dEJ22X
	LQtZ6N0rL/O5VDpbyXTv2KAB94dmd9gznwo4ABAopTYraXooHnhna13lIGK90g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/124] 6.6.11-rc1 review
Message-ID: <4mmnqui4njnmr4lik4jf6iaoi3ykivewytoba4dhydk3qr6juj@2im6qkfei2lv>
References: <20240108150602.976232871@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>

On  8 Jan 16:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.11 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Jan 2024 15:05:35 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

System runs fine, no noticeable regressions.

Linux version 6.6.11-rc1-ktest-gc52463eb66c8 (rbmarliere@debian) (gcc (Debian 13.2.0-9) 13.2.0, GNU ld (GNU Binutils for Debian) 2.41.50.20231227) #1 SMP PREEMPT_DYNAMIC Tue Jan  9 14:26:52 -03 2024

Tested-by: Ricardo B. Marliere <ricardo@marliere.net>

Thanks,
-	Ricardo

