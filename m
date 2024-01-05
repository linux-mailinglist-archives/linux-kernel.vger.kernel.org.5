Return-Path: <linux-kernel+bounces-17612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE117825031
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D132284597
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B321224C3;
	Fri,  5 Jan 2024 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries.io header.i=@foundries.io header.b="i+isjrXW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114C07E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foundries.io
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3368ae75082so160235f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 00:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google; t=1704444590; x=1705049390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=reHGhYuAGKcqAhGeJnWgN4NgEOHejYDl2w91uwuMMDY=;
        b=i+isjrXW1BWOOyDQ69eyuHNn34tJNHXAKRTzaE/vqCfve7sXt7TnOWi32h6If6DRij
         CUJxhL0a6e/lYX+6qTzCnWvIMK9VBRkvMkNwDTq6q6cNuJ3U25/95LnDKjlIv4wT2Rqm
         XfC5bL3bIybzszsofRfOtYo8jt7sFfFm/adf6SqjWl84I4lux6p2hc56YD+j1iU5+dI1
         TVaNRJIr59XBitwEBgSZV45ikvoEfEOIyXt2ZTXn4Nl8xr0Z+rqreb80JnsVlcopo5xc
         TsYzcN4MEOm9Qw43IjtNonqBB+2QTCdV1XH1TKjkrBMU7Qx+XbmIeFllOk0o5fQtTpUP
         AK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704444590; x=1705049390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reHGhYuAGKcqAhGeJnWgN4NgEOHejYDl2w91uwuMMDY=;
        b=Gz84CtkbWJT751jLvSN8gq5b8ZyQxz+C/OA9lCWAqKeOheIBXGnnVvmFHKpqKUF55C
         a+ZhL+JqFbN5+fGmIddg3rgcwPd5X1M5KTphIJ4UdmXOpkUZca5nxz2kQtHxFacihUXk
         gw76dQuw1Q5hJt5r+dh17X9pWUyOF1izuX+bHI6JSBeWY6jHGwD0KAQBb2J/dKwkC6Vj
         rOpl5ykR2kZtUw6lpBXoUDt3rlWSK7cmc4PRZZnOH30d3Bzwr14zPTwbUcOkY7ThWJnX
         o1mCRcOcDonuK2p0PWn/zzYVeYGqnIZzGJ1dcQ2bg7F0PfxGBRrZPMCvtz4CEYHOWGN3
         lYVA==
X-Gm-Message-State: AOJu0YwJ1B6MGuaXhfJjuCiSsdgyEiDnvDGRkh/Ae+bx8mJpm2NNDnzR
	fOHpNxxvEq478NL8ZxTVYDzV6hd4pCvsDA==
X-Google-Smtp-Source: AGHT+IHfTU7QurLJjtMbnGCgFvuGMUV2a3bX0a00tqPcADj7+g59IMqBXOOCg/CPVrHhjMx0hy97Eg==
X-Received: by 2002:adf:a31c:0:b0:336:d24d:3c76 with SMTP id c28-20020adfa31c000000b00336d24d3c76mr797899wrb.28.1704444590133;
        Fri, 05 Jan 2024 00:49:50 -0800 (PST)
Received: from trux (96.red-79-144-190.dynamicip.rima-tde.net. [79.144.190.96])
        by smtp.gmail.com with ESMTPSA id o7-20020adfeac7000000b003372818f4ddsm1002760wrn.0.2024.01.05.00.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 00:49:49 -0800 (PST)
From: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date: Fri, 5 Jan 2024 09:49:48 +0100
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
	Avri Altman <Avri.Altman@wdc.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	michal.simek@amd.com, neal.frager@amd.com,
	sai.krishna.potthuri@amd.com,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: rpmb: do not force a retune before RPMB switch
Message-ID: <ZZfCrLr5isWF/bwN@trux>
References: <f83933d3-6426-425c-903e-abbd2691e84a@intel.com>
 <DM6PR04MB6575A30D162378E82B4D7DDEFC84A@DM6PR04MB6575.namprd04.prod.outlook.com>
 <ZXBGTxS7sUSILtLs@trax>
 <ZXbBhjZIn5sj6EYO@trax>
 <ZZPoRPxdWXuT+cEo@trax>
 <b88eca08-7f20-4287-802c-ae1c8e3cd5cf@intel.com>
 <ZZSH1ykwP45fZaLh@trax>
 <d1fac554-4a51-409e-bc52-100a6bb4f5dd@intel.com>
 <ZZUm68tU9zHsC+X+@trux>
 <29dc26a4-b95c-42d5-94f8-fbd23c589eaa@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29dc26a4-b95c-42d5-94f8-fbd23c589eaa@intel.com>

On 04/01/24 20:34:09, Adrian Hunter wrote:
> On 3/01/24 11:20, Jorge Ramirez-Ortiz, Foundries wrote:
> > On 03/01/24 10:03:38, Adrian Hunter wrote:
> >> Thanks for doing that!  That seems to explain the mystery.
> >>
> >> You could hack the test to get an idea of how many successful
> >> iterations there are before getting an error.
> >>
> >> For SDHCI, one difference between tuning and re-tuning is the
> >> setting of bit-7 "Sampling Clock Select" of "Host Control 2 Register".
> >> It is initially 0 and then set to 1 after the successful tuning.
> >> Essentially, leaving it set to 1 is meant to speed up the re-tuning.
> >> You could try setting it to zero instead, and see if that helps.
> >> e.g.
> >>
> >> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >> index c79f73459915..714d8cc39709 100644
> >> --- a/drivers/mmc/host/sdhci.c
> >> +++ b/drivers/mmc/host/sdhci.c
> >> @@ -2732,6 +2732,7 @@ void sdhci_start_tuning(struct sdhci_host *host)
> >>  	ctrl |= SDHCI_CTRL_EXEC_TUNING;
> >>  	if (host->quirks2 & SDHCI_QUIRK2_TUNING_WORK_AROUND)
> >>  		ctrl |= SDHCI_CTRL_TUNED_CLK;
> >> +	ctrl &= ~SDHCI_CTRL_TUNED_CLK;
> >>  	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> >>
> >>  	/*
> >>
> >
> >
> > Yes with that change, the re-tuning reliability test does pass.
> >
> > root@uz3cg-dwg-sec:/sys/kernel/debug/mmc0#  echo 52 > /sys/kernel/debug/mmc0/mmc0\:0001/test
> > [  237.833585] mmc0: Starting tests of card mmc0:0001...
> > [  237.838759] mmc0: Test case 52. Re-tuning reliability...
> > [  267.845403] mmc0: Result: OK
> > [  267.848365] mmc0: Tests completed.
> >
> >
> > Unfortunately I still see the error when looping on RPMB reads.
> >
> > For instance with this test script
> >  $ while true; do rpmb_read m4hash; usleep 300; done
> >
> > I can see the error triggering on the serial port after a minute or so.
> > [  151.682907] sdhci-arasan ff160000.mmc: __mmc_blk_ioctl_cmd: data error -84
> >
> > Causing OP-TEE to panic since the RPMB read returns an error
> > E/TC:? 0
> > E/TC:? 0 TA panicked with code 0xffff0000
> > E/LD:  Status of TA 22250a54-0bf1-48fe-8002-7b20f1c9c9b1
> > E/LD:   arch: aarch64
> > [...]
> >
> > if anything else springs to your mind I am happy to test of course - there are
> > so many tunnables in this subsystem that experience is this area has exponential
> > value (and I dont have much).
> >
> > Would it make sense if re-tuning requests are rejected unless a minimum number
> > of jiffies have passed? should I try that as a change?
> >
> > or maybe delay a bit longer the RPMB access after a retune request?
>
> It seems re-tuning is not working properly, so ideally the
> SoC vendor / driver implementer would provide a solution.


Makes sense to me too. I am copying Michal on the DL.


>
> There is also mmc_doing_retune() which could be used to skip
> tuning execution entirely in the case of re-tuning.
>

