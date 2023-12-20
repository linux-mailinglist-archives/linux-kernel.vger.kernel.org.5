Return-Path: <linux-kernel+bounces-6718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E0C819C88
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7401F2780B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DBD20332;
	Wed, 20 Dec 2023 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKWCssLa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680F3200CD;
	Wed, 20 Dec 2023 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cc6c028229so43404211fa.2;
        Wed, 20 Dec 2023 02:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703067409; x=1703672209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bLKRTJeioS1VJHFUkfG9Q5dLKyrk/O35ucZ3AmopT1Q=;
        b=FKWCssLazh2R5cM9K/mvoMObYWEKANpuJ0ROfs8eT3bV9iOSHCQcbYNuErkBRKRZ8h
         J2nnkTOGf9FWyiggMZM/nOHbmduPQ6J7gj/n6vBmPzYxCcLQN0f3tiGUX55SVPgmtEUP
         13s3yFgCpwCOokZr18XiVtLZLghpvJAJiIol43mbM2hPNWNMSO1QWnfEKkBRln2yn20r
         LoNjw5H34kS4ng6bePZaYilDl98H7z9704Er7yehxwc+WyLk7YrS/h9tBWvwQXH9LIYy
         VjfBsNVMvDjeEaogwQIymtcPBsh89Z5VCIjBSm5GqZtdejuYlfv9Hi5mB5CXicWKRx0x
         hy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703067409; x=1703672209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLKRTJeioS1VJHFUkfG9Q5dLKyrk/O35ucZ3AmopT1Q=;
        b=HnjKWLfsDwstiBn4lbBxAxX79C/fXG5AFZkyuWYOKNsdRdCmdTuVQVaOjMvReYXa4r
         90EW054x6YJ6ex5st/mzYqk6uYN76qEmfULA2yTkAvyoUizpEyvuAIoGFh2BfVNODlQD
         30PbqpuZIzFPPQ5ZXaz7qzCEPTwrZ4TXVMIMdEljWNakxBSAvfKpO1UK84DiMbTHKnLx
         ByFjp11HAI8lUhVqTA6LlVB7tfEqSWdBqnklYST+hXQZsmWBF+YnG72TzqWGwqySO8mF
         gUuPjeHOlw2CaA/Z9sWC4MxCxnwkpnV/xiKqwuo1npnK2zImgPjOviNdc2oGlTh7ODf5
         QAvw==
X-Gm-Message-State: AOJu0YyAW9hdGRoYahW/Tx+cRJPhvK+O6+bPWPYpTqCsf4oYUqs9NSoI
	sikxeK842a2VhYu963+Ijiw=
X-Google-Smtp-Source: AGHT+IHCZlNDtZtitEkz2UcUatuFck1SyzrZg9lQ8IXaxY+RgMr2UPGpuNdSzAnA/KqTHyQWaAE7jg==
X-Received: by 2002:a05:651c:1a09:b0:2cc:6cde:ba5 with SMTP id by9-20020a05651c1a0900b002cc6cde0ba5mr2796613ljb.19.1703067409131;
        Wed, 20 Dec 2023 02:16:49 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id bz24-20020a05651c0c9800b002cc75dcde4bsm988474ljb.23.2023.12.20.02.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 02:16:48 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22) with ESMTP id 3BKAGj7A016312;
	Wed, 20 Dec 2023 13:16:46 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 3BKAGhdk016311;
	Wed, 20 Dec 2023 13:16:43 +0300
Date: Wed, 20 Dec 2023 13:16:43 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Hector Martin <marcan@marcan.st>
Cc: Arend van Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, Daniel Berlin <dberlin@dberlin.org>,
        linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
Message-ID: <ZYK/C3LzK8LMOjER@home.paul.comp>
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>

Hey Hector,

On Tue, Nov 07, 2023 at 03:05:31PM +0900, Hector Martin wrote:
> Using the WSEC command instead of sae_password seems to be the supported
> mechanism on newer firmware, and also how the brcmdhd driver does it.
> 
> According to user reports [1], the sae_password codepath doesn't actually
> work on machines with Cypress chips anyway, so no harm in removing it.

I'm sorry to disappoint you but I've just tested this patch on a
"Pinebook Pro" which has AP6255 module and it broke WPA3 Personal.

No error messages are emitted to the kernel log, just iwctl saying it
can't establish connection.

This is using "Cypress" firmware from the Linux firmware tree [0]
renamed to "brcmfmac43455-sdio.bin" which has the following features
(extracted from last two lines):

43455c0-roml/43455_sdio-pno-aoe-pktfilter-pktctx-wfds-mfp-dfsradar-wowlpf-idsup-idauth-noclminc-clm_min-obss-obssdump-swdiv-gtkoe-roamprof-txbf-ve-sae-dpp-sr-okc-bpd Version: 7.45.234 (4ca95bb CY) CRC: 212e223d Date: Thu 2021-04-15 03:06:00 PDT Ucode Ver: 1043.2161 FWID 01-996384e2
DVID 01-1fda2915


This module is used on many SBCs, including some RaspberryPi
boards. The reason RaspberryPi owners complain about lack of WPA3
Personal support is that most of them are using obscure downstream
distros which ship brcmfmac firmware from somewhere else rather than
the Linux firmware tree, so they lack the "sae" feature. Another is
that it only works with iwd while default is wpa_supplicant.

So far all known reports of those who tried the right firmware on
RaspberryPi boards confirm WPA3 Personal was working with iwd [1].


I'll be happy to do more testing if needed. Thank you very much for
your hard and insightful work!


[0] https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/cypress/cyfmac43455-sdio.bin
[1] https://github.com/raspberrypi/linux/issues/4718#issuecomment-1279951709

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com

