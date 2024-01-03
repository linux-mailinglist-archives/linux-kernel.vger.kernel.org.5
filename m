Return-Path: <linux-kernel+bounces-15332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48904822A34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D80EB231BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53291862A;
	Wed,  3 Jan 2024 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="R3fwunVT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5DF18626
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foundries.io
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d5f40ce04so56636045e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 01:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1704273645; x=1704878445; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QaFoN/jrgLx0tAxN9/O+jklrUdQXJQRgijDTkOtoZpU=;
        b=R3fwunVTlNHugGOSzFZiFfPZG0pPkGrEFFwQbvawU01YiNyX4KJy41SbirLdcoqXPO
         rXJrkvz+Pi1QioqO9hNXfCbAU4dPKFCQ+4/BIJNUgUlgfXl5a32dZuRUEpzO2c4Cj80R
         eXgFGBgrkekIHJZb5LYSlKGj9otWAmpfBqh1PXQEdNrMNTF0r1R8cz07gMu+xDkc4gUb
         pf8O+lkp3qyfcyBOs2jQB2rMp84fK3bkLiBhBWMtS6Kzm43fM5zugq53E3G/5x6aANd2
         9FHK3kWn6e2faLPhETM5y2u/DO8kRrc/9orFUDTR0JFFdkLRb3jtNzprsNKAis7+nXoO
         7CAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704273645; x=1704878445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaFoN/jrgLx0tAxN9/O+jklrUdQXJQRgijDTkOtoZpU=;
        b=sSsmomlhMXejDhGZAlUsn4BzzLDhMDSeV0/411YakKUuareuIra3x3OCQnq2W4Zsvd
         cxAAe53l48/IiZRnmRss0nshrEniWDMz5znHlLHJJp4EWk96ojDSMskJTIDGW8QWz2tE
         /pW1ZIxFN3lHtfXHPRA8q2lypUICrCD2rwi6izdUt6YBFnzVlj20jKie/FrsN9OU97eV
         2c3KvOkrF7oRVd3b1X6HsD6ZHLLL8e3Lit0A4d3ZbI9i54soJqxUbwQNLlMK9pq70+Rg
         ht5UIvMy+zVaDQ0c7ZmxFnTUebG9MAvTAINgEWWYSB7G5Tbn9KNo1YuQzR3gkUJtmaGy
         c+Yg==
X-Gm-Message-State: AOJu0YxXci/B3snByFCOIESZyj21kVg6vnFyWVvUEbzUqBQeYY073nF3
	Voyxjdb+GcPG0PpVUNaiMSm28TnFaKM6HQ==
X-Google-Smtp-Source: AGHT+IHiBz/L4Qtu3Jhubv2tPR2oIpN1xMVHZRndxbxeJpPbMBfUrDGa5MHFTCOK8JLCYDjZFIMwLw==
X-Received: by 2002:a05:600c:4f4d:b0:40d:5b34:18b4 with SMTP id m13-20020a05600c4f4d00b0040d5b3418b4mr6077742wmq.91.1704273645100;
        Wed, 03 Jan 2024 01:20:45 -0800 (PST)
Received: from trux (96.red-79-144-190.dynamicip.rima-tde.net. [79.144.190.96])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b0040d87100733sm1687878wmj.39.2024.01.03.01.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 01:20:44 -0800 (PST)
From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date: Wed, 3 Jan 2024 10:20:43 +0100
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
	Avri Altman <Avri.Altman@wdc.com>,
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
Message-ID: <ZZUm68tU9zHsC+X+@trux>
References: <20231204150111.3320071-1-jorge@foundries.io>
 <f83933d3-6426-425c-903e-abbd2691e84a@intel.com>
 <DM6PR04MB6575A30D162378E82B4D7DDEFC84A@DM6PR04MB6575.namprd04.prod.outlook.com>
 <ZXBGTxS7sUSILtLs@trax>
 <ZXbBhjZIn5sj6EYO@trax>
 <ZZPoRPxdWXuT+cEo@trax>
 <b88eca08-7f20-4287-802c-ae1c8e3cd5cf@intel.com>
 <ZZSH1ykwP45fZaLh@trax>
 <d1fac554-4a51-409e-bc52-100a6bb4f5dd@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1fac554-4a51-409e-bc52-100a6bb4f5dd@intel.com>

On 03/01/24 10:03:38, Adrian Hunter wrote:
> Thanks for doing that!  That seems to explain the mystery.
>
> You could hack the test to get an idea of how many successful
> iterations there are before getting an error.
>
> For SDHCI, one difference between tuning and re-tuning is the
> setting of bit-7 "Sampling Clock Select" of "Host Control 2 Register".
> It is initially 0 and then set to 1 after the successful tuning.
> Essentially, leaving it set to 1 is meant to speed up the re-tuning.
> You could try setting it to zero instead, and see if that helps.
> e.g.
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c79f73459915..714d8cc39709 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2732,6 +2732,7 @@ void sdhci_start_tuning(struct sdhci_host *host)
>  	ctrl |= SDHCI_CTRL_EXEC_TUNING;
>  	if (host->quirks2 & SDHCI_QUIRK2_TUNING_WORK_AROUND)
>  		ctrl |= SDHCI_CTRL_TUNED_CLK;
> +	ctrl &= ~SDHCI_CTRL_TUNED_CLK;
>  	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>
>  	/*
>


Yes with that change, the re-tuning reliability test does pass.

root@uz3cg-dwg-sec:/sys/kernel/debug/mmc0#  echo 52 > /sys/kernel/debug/mmc0/mmc0\:0001/test
[  237.833585] mmc0: Starting tests of card mmc0:0001...
[  237.838759] mmc0: Test case 52. Re-tuning reliability...
[  267.845403] mmc0: Result: OK
[  267.848365] mmc0: Tests completed.


Unfortunately I still see the error when looping on RPMB reads.

For instance with this test script
 $ while true; do rpmb_read m4hash; usleep 300; done

I can see the error triggering on the serial port after a minute or so.
[  151.682907] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84

Causing OP-TEE to panic since the RPMB read returns an error
E/TC:? 0
E/TC:? 0 TA panicked with code 0xffff0000
E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
E/LD:   arch: aarch64
[...]

if anything else springs to your mind I am happy to test of course - there are
so many tunnables in this subsystem that experience is this area has exponential
value (and I dont have much).

Would it make sense if re-tuning requests are rejected unless a minimum number
of jiffies have passed? should I try that as a change?

or maybe delay a bit longer the RPMB access after a retune request?

