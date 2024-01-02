Return-Path: <linux-kernel+bounces-14259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C504E821A22
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 411B6B21A6B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB6ADF4F;
	Tue,  2 Jan 2024 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="O2Ph709A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B122DDBC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foundries.io
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3368d1c7b23so8106224f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 02:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1704192070; x=1704796870; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2MAPFTi+4S5JKfd2/tApv6PVoH1Mz3Cadap0S8Gv4lM=;
        b=O2Ph709AGEi4GDcY94/DqfXTX6VBkzrzyrCy6twkIMiZ/aPFYR9eRA759Hl9C8RQ3e
         qRPjvKrylJJRUdewRLYxc4zccixsM2P16LaDqjERrwC62hgtWyFS12EljKfn3qc9s2hU
         u6fIpXZl+z/GKLtwsnY8V/7FqCXrq2TsQxEKQrYmdDghA87op0fYNtY0njCbdaxTR8Nr
         nTV0Cu+4S3sUXrF65JITjIrv463kUp+h8iB5UWx+CGGP+gmfLcOv/wPkXiUY1hPSzg6J
         ywdaZEHJaS1Y8zyrIi9vNIMMRIHCMMgire3ZsnYQ0SL3oJnW9JEfJWzJal0+g5MrgJdY
         RYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704192070; x=1704796870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MAPFTi+4S5JKfd2/tApv6PVoH1Mz3Cadap0S8Gv4lM=;
        b=Q6uit1DyhFdLInRWBeVNZCbm10l13goTzhBnMHFllBE4t/R8cxcMFGP5c/Gsjgl93r
         tgrWzQ2ggISSWFYA9d4HJnxpcL6DLF0SVeoeaHCoTHppj08zZAymelUVtjNavMn316fM
         puCvrjbzg9ZxkCs395zLPIAaUh+O9ADzevGoyUfwE75OMUWm9gvi38XrfFde4HiGRpxk
         VFxZOjRk/7wmtgZcIKzdLya4C5K5JosWz5G1upt95vscajDW2v4Bg/cknZjU1UuRLOaZ
         nB20re1Ug2LX498i2reXSn4oNa6aDfGUb4q1vR+BoFW1ZBaUurAjAC2lg7CcOperHZKy
         jy9w==
X-Gm-Message-State: AOJu0Ywgm7fzln089lZHbhUd42DxbCTsjFrzf2bLr5n+/aQcIJpAMjPN
	BSUZEYhXJzTZq9X42RFJ5arXInoa4VcPRQ==
X-Google-Smtp-Source: AGHT+IGRdbBJpMBVIUdY41oJKUR9S3ADStW53prFLTDwSdYjXW1RIsTNb/k5Rrws8JiTmSIIqXhOiw==
X-Received: by 2002:a5d:52cd:0:b0:336:c9ac:3518 with SMTP id r13-20020a5d52cd000000b00336c9ac3518mr5467756wrv.106.1704192070425;
        Tue, 02 Jan 2024 02:41:10 -0800 (PST)
Received: from trax (96.red-79-144-190.dynamicip.rima-tde.net. [79.144.190.96])
        by smtp.gmail.com with ESMTPSA id q17-20020adfcd91000000b003362d0eefd3sm27946268wrj.20.2024.01.02.02.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 02:41:09 -0800 (PST)
From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date: Tue, 2 Jan 2024 11:41:08 +0100
To: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc: Avri Altman <Avri.Altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"christian.loehle@arm.com" <christian.loehle@arm.com>,
	"jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"beanhuo@micron.com" <beanhuo@micron.com>,
	"yibin.ding@unisoc.com" <yibin.ding@unisoc.com>,
	"victor.shih@genesyslogic.com.tw" <victor.shih@genesyslogic.com.tw>,
	"asuk4.q@gmail.com" <asuk4.q@gmail.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"yangyingliang@huawei.com" <yangyingliang@huawei.com>,
	"yebin10@huawei.com" <yebin10@huawei.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Message-ID: <ZZPoRPxdWXuT+cEo@trax>
References: <20231204150111.3320071-1-jorge@foundries.io>
 <f83933d3-6426-425c-903e-abbd2691e84a@intel.com>
 <DM6PR04MB6575A30D162378E82B4D7DDEFC84A@DM6PR04MB6575.namprd04.prod.outlook.com>
 <ZXBGTxS7sUSILtLs@trax>
 <ZXbBhjZIn5sj6EYO@trax>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXbBhjZIn5sj6EYO@trax>

On 11/12/23 09:00:06, Jorge Ramirez-Ortiz, Foundries wrote:
> On 06/12/23 11:00:47, Jorge Ramirez-Ortiz, Foundries wrote:
> > On 06/12/23 07:02:43, Avri Altman wrote:
> > > >
> > > > On 4/12/23 17:01, Jorge Ramirez-Ortiz wrote:
> > > > > Requesting a retune before switching to the RPMB partition has been
> > > > > observed to cause CRC errors on the RPMB reads (-EILSEQ).
> > > >
> > > > There are still 2 concerns:
> > > > 1) We don't really know the root cause.  Have you determined if here are
> > > > CRC errors in the main partition also?
> >
> > right, and I don't disagree with that.
> >
> > As a test I created a 4GB file from /dev/random which I then copied
> > several times (dd if= ....)
> >
> > root@uz3cg-dwg-sec:/sys/kernel/debug/mmc0# cat err_stats
> > # Command Timeout Occurred:      0
> > # Command CRC Errors Occurred:   0
> > # Data Timeout Occurred:         0
> > # Data CRC Errors Occurred:      0
> > # Auto-Cmd Error Occurred:       0
> > # ADMA Error Occurred:   0
> > # Tuning Error Occurred:         0
> > # CMDQ RED Errors:       0
> > # CMDQ GCE Errors:       0
> > # CMDQ ICCE Errors:      0
> > # Request Timedout:      0
> > # CMDQ Request Timedout:         0
> > # ICE Config Errors:     0
> > # Controller Timedout errors:    0
> > # Unexpected IRQ errors:         0
> >
> > However as soon as I access RPMB and fails (it takes just a few tries) I see:
> >
> > I/TC: RPMB: Using generated key
> > [   86.902118] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
> > E/TC:? 0
> > E/TC:? 0 TA panicked with code 0xffff0000
> > E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
> > E/LD:   arch: aarch64
> > E/LD:  region  0: va 0xc0004000 pa 0x7e200000 size 0x002000 flags rw-s (ldelf)
> > E/LD:  region  1: va 0xc0006000 pa 0x7e202000 size 0x008000 flags r-xs (ldelf)
> > E/LD:  region  2: va 0xc000e000 pa 0x7e20a000 size 0x001000 flags rw-s (ldelf)
> > E/LD:  region  3: va 0xc000f000 pa 0x7e20b000 size 0x004000 flags rw-s (ldelf)
> > E/LD:  region  4: va 0xc0013000 pa 0x7e20f000 size 0x001000 flags r--s
> > E/LD:  region  5: va 0xc0014000 pa 0x7e22c000 size 0x005000 flags rw-s (stack)
> > E/LD:  region  6: va 0xc0019000 pa 0x818ea9ba8 size 0x002000 flags rw-- (param)
> > E/LD:  region  7: va 0xc001b000 pa 0x818e97ba8 size 0x001000 flags rw-- (param)
> > E/LD:  region  8: va 0xc004f000 pa 0x00001000 size 0x014000 flags r-xs [0]
> > E/LD:  region  9: va 0xc0063000 pa 0x00015000 size 0x008000 flags rw-s [0]
> > E/LD:   [0] 22250a54-0bf1-48fe-8002-7b20f1c9c9b1 @ 0xc004f000
> > E/LD:  Call stack:
> > E/LD:   0xc0051a14
> > E/LD:   0xc004f31c
> > E/LD:   0xc0052d40
> > E/LD:   0xc004f624
> >
> > root@uz3cg-dwg-sec:/var/rootdirs/home/fio# cat /sys/kernel/debug/mmc0/err_stats
> > # Command Timeout Occurred:      0
> > # Command CRC Errors Occurred:   0
> > # Data Timeout Occurred:         0
> > # Data CRC Errors Occurred:      1
> > # Auto-Cmd Error Occurred:       0
> > # ADMA Error Occurred:   0
> > # Tuning Error Occurred:         0
> > # CMDQ RED Errors:       0
> > # CMDQ GCE Errors:       0
> > # CMDQ ICCE Errors:      0
> > # Request Timedout:      0
> > # CMDQ Request Timedout:         0
> > # ICE Config Errors:     0
> > # Controller Timedout errors:    0
> > # Unexpected IRQ errors:         0
> >
> > > > 2) Forcing this on everyone
> > > >
> > > > The original idea was that because re-tuning cannot be done in RPMB, the
> > > > need to re-rune in RPMB could be avoided by always re-tuning before
> > > > switching to RPMB and then switching straight back. IIRC re-tuning should
> > > > guarantee at least 4MB more I/O without issue.
> > > Performance is hardly an issue in the context of RPMB access -
> > > For most cases it’s a single frame.
> >
> > Yes, the security use case typically stores hashes, variables
> > (bootcount, upgrade_available, versions, that sort of thing) and
> > certificates in RPMB.
> >
> > Since you mentioned, I am seeing that tuning before switching to RPMB
> > has an impact on performance. As a practical test, just reading a 6 byte
> > variable incurs in 50ms penalty in kernel space due to the need to
> > retune 5 times. Not great since the request is coming from a Trusted
> > Application via OP-TEE through the supplicant meaning this TEE thread
> > (they are statically allocated CFG_NUM_THREADS) will be reserved for
> > quite a bit of time.
> >
> > Roughly:
> > TA --> OP-TEE (core) --> TEE-supplicant --> Kernel (>50ms) --> OP-TEE --> TA
>
> To add more detail to the timing above, when using RPMB, OP-TEE stores
> the secure filesystem on RPMB as well, so accessing one of the variables
> stored in the filesystem consists on a number (~5) of individual RPMB
> requests (each one forcing a retune, each retune taking around 10ms).

Adrian, please could you comment on the above.

The current code is a performance drag for systems that implement their
secure filesystems on RPMB (i.e: OP-TEE) causing each read operation (of
variables consisting of a few bytes stored in such a filesystem) to
perform 5 consecutive retune requests.

I am just thinking whether the original use case that forces a call to
retune prior to processing the RPMB request remains valid.

Independently of the fact that not doing so fixes the problem I was
working on - and with the information I have - I dont think RPMB is
generally used to store larger files (maybe you have more information
about the average use case? are you aware of systems using RPMB to store
binaries or images?)

I still I have to execute the test you shared some weeks ago. Bit of a
pain to NFS boot this system...will try to do it this week.

TIA

>
> BTW, I also tried delaying the timing between those consecutive retunes
> (up to 1 second), but the issue still persisted.
>
> >
> > Adrian, I couldn't find the original performance justification for
> > enabling this feature globally. At which point do you think it becomes
> > beneficial to retune before accessing RPMB?
>
> How should we proceed with this patch then? can it be merged as I
> proposed? should I rewrite it differently? not sure what is next
>
> TIA
> Jorge

