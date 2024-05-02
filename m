Return-Path: <linux-kernel+bounces-166010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A0E8B94C3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B277F1F22975
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC2DC12C;
	Thu,  2 May 2024 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfhaWgBL"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AD9819;
	Thu,  2 May 2024 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632038; cv=none; b=mFy/ZJ37jxlzcX0pFsMH9FdmZAURHZJesaCPPGJjophH9JHBfLUKLeDHefxDCiIxPiwL+dqJJH84jW78Ab8/e1SojLCB7CjZmMdKBcQRcsr6PyZvoZEGfWcZtmpfbVB3PDa32WyvNY2NJiuxkXY3Cc0gASmdOIYfI2+sgyH7ZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632038; c=relaxed/simple;
	bh=g7O/FTV5aw8TNqO5hGbp9xrYkBTNWiZYjFZk99ZxNA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byqSmz3/9fxR2xJGSwoEBKHxKIdZBn5dWf58dI4QbHqfVNNG/DBerNlfX+62TaIpVR491WKGG8PRsR4ELgM0xGOHhmk4iTnZox5W5eLsz7k1yo+IuRjRV9jRKcWzlqkPGyKtvjhsvrsdZuMLzox22z+Bud88LHQQuQJDGUzI92g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfhaWgBL; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so88205291fa.3;
        Wed, 01 May 2024 23:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714632035; x=1715236835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xZpUqMc1AWGAd42jK4I6d478ur2G3QayWm0JOEMgEho=;
        b=BfhaWgBLC98uT+plnCpwruAQISlXlXftLVVnvODRG62PM26I4cSiqyRvQhaAl7nHKI
         USLD0K7rrvOf+81kOHI3iCJeB5/gvdfdnnNjeyMrHSyU8mIOOEKnTuYly3C6Zz2KGJDR
         el7Sv4Z+MYWgSj2SnTT1CkLvZYN8ODnowCC4hUm37qix2p/+aPiMXnl5BA4hgR8I/7FK
         TA+tMXoLllrmHsE5C+QAw7yycsXtXcneRGjUmvtt7u3rJYjTeWCj7+UNMF377hSWSLdz
         P7WvZpCckg2+ReWan281sPky/3GhbqmIgLzPmtCgfeDYn/WsCowd8pJm+dKicCEBU6qI
         lqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714632035; x=1715236835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZpUqMc1AWGAd42jK4I6d478ur2G3QayWm0JOEMgEho=;
        b=Ynqq2vqzqTiGng+y2Zl6Bzmaxd1rx5/+gGhshDKRKaqWcWY0L4qPm02HB2R8z1wq7y
         W3Jz9jG30K8eYcuBSEG0De/rUah+V0ZMhlH2jlQgShPC70+jgem4ln0lMfOOWKB+mNL0
         44bnJJ9c1ISsQq7BRMUD9IJ7CC/8I4/2NdcZFKQHwCuodt6oM65lPjP29ZyjF8ujQtMV
         EUaE2n2oKKTYpPwAFtPlO17mmcscOkF4i+/uQlum5n7/Rns3Oqz0wmBUE4o3cccB1Z5F
         FYahQmk9T19Mcugh5GKeB7/7A1E1lRlWULaINIlG+tm+URL2x9pjB8igM+2kWqGJhS2Y
         ULvA==
X-Forwarded-Encrypted: i=1; AJvYcCV6+uPHukqxG/jl1CJF40LTrYC1TckCQcn+AnnJxi3gT22rxlJiXBU6UZTFku7XuE4vj0eGxqQTYiq+a8lVSUFsGY4oaJyJRwVAVG8R
X-Gm-Message-State: AOJu0YxeWa0XvuyU+qxL8cvFFMSICDq/cPvpWLL6Q17HpW5dwZxdgfzD
	T8Eo2upmWM+T8urTefCmY8eHhDe6gUR5UXPHokxGNsN0/USFQSz6
X-Google-Smtp-Source: AGHT+IFYYRbix+ExG/nhZbY2F7j2QWgpils/MV+01rQlb/CgTzI2aSH849mq3gF5ni0gLqY0tnfkmQ==
X-Received: by 2002:a2e:b53b:0:b0:2d4:5321:9daf with SMTP id z27-20020a2eb53b000000b002d453219dafmr2748212ljm.44.1714632034621;
        Wed, 01 May 2024 23:40:34 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id a23-20020a2e88d7000000b002d69186df71sm64717ljk.54.2024.05.01.23.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 23:40:34 -0700 (PDT)
Date: Thu, 2 May 2024 09:40:31 +0300
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>, 
	Jackson Lee <jackson.lee@chipsnmedia.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Wave515 decoder IP support
Message-ID: <mwgydgjstvedkatdvopt3wh4imhnzflr7ut3vejgl6fz3vbgzg@x4spldwklrm3>
References: <20240415100726.19911-1-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415100726.19911-1-brnkv.i1@gmail.com>

On Mon, Apr 15, 2024 at 01:07:18PM GMT, Ivan Bornyakov wrote:
> Initial support for Wave515 multi-decoder IP among other refinements.
> This was tested on FPGA prototype, so wave5_dt_ids[] was not expanded.
> 
> fluster score for JCT-VC-HEVC_V1 testsuite with
> GStreamer-H.265-V4L2-Gst1.0 decoder is 132/147
> 
> The issue with Main10 tests is that fluster expects decoded file to be
> in yuv420p10le format while this driver decodes HEVC Main10 into 8-bit
> yuv420p. Though result is looks alright to the naked eye, proper
> decoding into yuv420p10le is to be added.
> 
> The rest failed fluster tests are common with Wave521.
> 
> ChangeLog:
>   v1:
> https://lore.kernel.org/linux-media/20240318144225.30835-1-brnkv.i1@gmail.com/
>   v2:
> https://lore.kernel.org/linux-media/20240325064102.9278-1-brnkv.i1@gmail.com/
>     * drop patch "dt-bindings: media: cnm,wave521c: drop resets restriction"
>       The only user of Wave5 in mainline is TI K3 boards, thus there is
>       no real need to alter dt-bindings
>     * in patch "media: chips-media: wave5: support decoding HEVC Main10 profile"
>       add check for flag "support_hevc10bit_dec"
>     * in patch "media: chips-media: wave5: support reset lines" move
>       reset_control_deassert() out of else branch, add
>       reset_control_assert() to probe error path.
>     * rework patch "media: chips-media: wave5: drop "sram-size" DT prop"
>        - don't move alloc/free form device open/close
>        - intead of exact configuration of reserved SRAM memory in DT and
> 	 allocating all of it, allocate all available SRAM memory up to
> 	 WAVE5_MAX_SRAM_SIZE from whatever pool provided.
>     * adjust patch "media: chips-media: wave5: support Wave515 decoder"
>       according to changes in patches
>       "media: chips-media: wave5: support decoding HEVC Main10 profile" and
>       "media: chips-media: wave5: drop "sram-size" DT prop"
>   v3:
> https://lore.kernel.org/linux-media/20240405164112.24571-1-brnkv.i1@gmail.com/
>     * reword patch "media: chips-media: wave5: separate irq setup routine"
>       a bit.
>     * in patch "media: chips-media: wave5: drop "sram-size" DT prop"
>        - move MAX_SRAM_SIZE define into match_data->sram_size
>        - add placeholders for validation that allocated SRAM memory is
> 	 enough to encode/decode bitstream of given resolution before
> 	 setting W5_USE_SEC_AXI and W5_CMD_ENC_PIC_USE_SEC_AXI registers
>        - reword accordingly
>     * in patch "media: chips-media: wave5: support Wave515 decoder"
>        - add comments around SRAM memory allocation/freeing about
> 	 Wave515 specifics
>        - add comments about BSOPTION_RD_PTR_VALID_FLAG bit in
> 	 W5_BS_OPTION register
>        - add W[AVE]521_ prefix to defines, for wich there are W[AVE]515_
> 	 alternatieves
>        - add semi-magic Wave515 specific formulas to estimate SRAM usage
>   v4:
>     * rebase onto next-20240415, no functional changes
> 
> Ivan Bornyakov (5):
>   media: chips-media: wave5: support decoding HEVC Main10 profile
>   media: chips-media: wave5: support reset lines
>   media: chips-media: wave5: separate irq setup routine
>   media: chips-media: wave5: drop "sram-size" DT prop
>   media: chips-media: wave5: support Wave515 decoder
> 
>  .../platform/chips-media/wave5/wave5-helper.c |   8 +-
>  .../platform/chips-media/wave5/wave5-hw.c     | 395 +++++++++++++-----
>  .../chips-media/wave5/wave5-regdefine.h       |   5 +
>  .../platform/chips-media/wave5/wave5-vdi.c    |  27 +-
>  .../chips-media/wave5/wave5-vpu-dec.c         |  51 ++-
>  .../chips-media/wave5/wave5-vpu-enc.c         |   2 +-
>  .../platform/chips-media/wave5/wave5-vpu.c    |  35 +-
>  .../platform/chips-media/wave5/wave5-vpuapi.h |   3 +
>  .../chips-media/wave5/wave5-vpuconfig.h       |  16 +-
>  .../media/platform/chips-media/wave5/wave5.h  |   6 +
>  10 files changed, 407 insertions(+), 141 deletions(-)
> 
> -- 
> 2.44.0
> 

Friendly ping.

