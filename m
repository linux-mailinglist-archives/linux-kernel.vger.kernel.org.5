Return-Path: <linux-kernel+bounces-25208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F2382CA57
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 08:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7371F23A58
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 07:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C6018046;
	Sat, 13 Jan 2024 07:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o289cWW8"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84A912E56
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 07:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-67ff241c2bcso45343716d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 23:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705129519; x=1705734319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GqUVJ8s7EGwnf8VW2qN30KaMR9GjPb0OJdm4xU8DVmE=;
        b=o289cWW8aNxAKsdsbqumdVPwhE2vleIrcKu9YwaWzWJTXxR2BN30pi9gTTCPhvpw0E
         QPp2eM+ppILjGs/huoeth7SKWJvGO+rNJstbSaFtqhzBrW916WDAFoLClStwpqw9C9l5
         53/StuPRbHuIMoByk9mG+TG0B7MtTqo+BKqmQOoclDR1xdKmgoqXt2FMUcbl0cSqOWNf
         iCi0XQbC8MU+MnTs+fKthnb5qkliqVMQJNDoVIXH4VHSETxIeszsYKZz1uQFY9IYGM4K
         etJ3XFDvTPP1F+r1UPVjsUyBrhp2WUxj7NKMrUHJN53xpCKLmu119KZPtJWRAOuCGX10
         n4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705129519; x=1705734319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqUVJ8s7EGwnf8VW2qN30KaMR9GjPb0OJdm4xU8DVmE=;
        b=RCtceJGLcACYu2HEr3bdI6Pzi3uJJQbAQCilAgLpeDD+1yN4yh5RNNEL6jxsOH/W2p
         EfghdZ2DEHLRdaXzamCtrFTrhAiJhrFgQ2FgdCslyLZrdmigCS1hWoy6lYAOzd3MgUVE
         JkwPzM2MJVk2HINoqsgtknnyviSQWQpeMet26xcBPHRDi/yC0G2IYGOTwtK9pXmD9JFa
         an2hOpT0gR8oKStJpl8dD27V0Y8O3/3gzLNls+E1bwcQp07zsoHMPcVWA3pkD7KBHy7/
         1qCCaXUcyIwyMH+Q+QUbZGm1StlLyLuNVREVxzCapn5ypTtIJPnfv3Y+X8HHikZMLCmF
         m0Pw==
X-Gm-Message-State: AOJu0YxGy/YDxa08h4CnyUrqZWlS9ZihQ7R/qfkdLBjOLK5VYOfGf+4g
	ILLvvl1L5TFJnmSdmgKcPHemvZ38Ih1e/4BZdOmubS193TUGCA==
X-Google-Smtp-Source: AGHT+IFc0y2uSmt7xB6X4CM/6iYzv7XLzqDXm1OMDLNeYk0eIgGxUlMEo1QaTfdT2BHiqR6aEvzb2Y8BVfmQGNWecLs=
X-Received: by 2002:ad4:5be2:0:b0:681:3b95:cedd with SMTP id
 k2-20020ad45be2000000b006813b95ceddmr2122750qvc.59.1705129519531; Fri, 12 Jan
 2024 23:05:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYu1hB2OMf0EFrt_86OE=0Ug3y6nQd3=OZeEeM1jp3P92g@mail.gmail.com>
 <11a31e09-2e11-43a4-8995-ae70c5bef8bf@kernel.org>
In-Reply-To: <11a31e09-2e11-43a4-8995-ae70c5bef8bf@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 13 Jan 2024 12:35:08 +0530
Message-ID: <CA+G9fYthC3qsH8ey=j3RvCr4-0zp1S3Ysr5QvY6SptorHpju1g@mail.gmail.com>
Subject: Re: scsi: block: ioprio: Clean up interface definition -
 ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>, LTP List <ltp@lists.linux.it>, 
	Linux Regressions <regressions@lists.linux.dev>, lkft-triage@lists.linaro.org, 
	open list <linux-kernel@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>, 
	Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Niklas Cassel <niklas.cassel@wdc.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jan 2024 at 10:49, Damien Le Moal <dlemoal@kernel.org> wrote:
>
> On 1/12/24 14:15, Naresh Kamboju wrote:
> > The LTP test 'iopri_set03' fails on all the devices.
> > It fails on linux kernel >= v6.5. ( on Debian rootfs ).
> > Test fail confirmed on LTP release 20230929 and 20230516.
> >
> > Test failed log:
> > ------------
> > tst_test.c:1690: TINFO: LTP version: 20230929
> > tst_test.c:1574: TINFO: Timeout per run is 0h 05m 00s
> > ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
> > ioprio_set03.c:48: TINFO: tested illegal priority with class NONE
> > ioprio_set03.c:51: TPASS: returned correct error for wrong prio: EINVAL (22)
> >
> > Investigation:
> > ----------
> > Bisecting this test between kernel v6.4 and v6.5 shows patch
> > eca2040972b4 ("scsi: block: ioprio: Clean up interface definition")
> > as the first faulty commit.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> This is fixed in LTP. Please update your LTP setup to avoid this issue.

Please point me to the fixed commit id.

I have the latest LTP release test results as ioprio_set03 has failed.

ioprio_set03.c:40: TFAIL: ioprio_set IOPRIO_CLASS_BE prio 8 should not work
LTP Version: 20230929-258-gec0a8f18b
on Debian rootfs.

Links:
 - https://qa-reports.linaro.org/lkft/ltp-master/build/v6.6.10_20230929-258-gec0a8f18b/testrun/22035919/suite/ltp-syscalls/test/ioprio_set03/history/
 - https://qa-reports.linaro.org/lkft/ltp-master/build/v6.6.10_20230929-258-gec0a8f18b/testrun/22035919/suite/ltp-syscalls/test/ioprio_set03/details/

- Naresh

