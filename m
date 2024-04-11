Return-Path: <linux-kernel+bounces-140185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD8C8A0C85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57B71F2756B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAB0145342;
	Thu, 11 Apr 2024 09:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsNXjcIs"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9571144D34;
	Thu, 11 Apr 2024 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712828210; cv=none; b=Yrtl4PvEZkOJolhx+x6wZTEezZYK9xRaf4LfdOkSysowmtUIKMyewPmTcqQ6yQCXEnlyknbeFmxFmFmaMGRBKGo3gDi7XaCuCxEW7qea/daphOsNaDSgSBKgbyCXBlJlLCXLRPeNnq05/tafQ2pAeRUQJKgojYzvVXP66c0CiwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712828210; c=relaxed/simple;
	bh=REeRqtaQ2rFSfiCowbECkyQJKI4O8gMscXMzcxayvNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsFUCi/hBy4X+xBmXeQeiH+o1sDh+CyvlsZ5hMKrVLqMjxpwdky3Zr5x2o7MaUlYGtCMBkm1iHB1NE1lXT9VLYZhbd/OBoEO9I6HjRuf1Yd0V/K7psCI7SWd53pGRM4sxUyyqvDfgoQBd2k0Px5QJiFIyeJKWJi6BCNUIICP320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsNXjcIs; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d727074eso7435766e87.0;
        Thu, 11 Apr 2024 02:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712828207; x=1713433007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3M5xqvnR68b34qM9yTb1YB3DFbXI/mKaCv5TejEheiw=;
        b=HsNXjcIsznOMo5BitDuXY7tp/Oluv6zB+z/mCkXjBxbaYNlVgumwlLnWzyBoQNcmUw
         5YkvHPQce1L+VhNV/q5NdmTOusmXhtWuGPQhL2zt5hhiGI0vQ9rfsjm/2DOVb+ndQqQX
         ZftiQn2sFFAIVHplDJY3cFxL5ZaNWShOhrzqwZ9QYmrx4UBXw2SjHoY+wrc4i38nFhl3
         wr+x70JxFDUErn2azd5Rp4NwBm63tlXvZMo7oDHxhfKBmqpC1PjTFqkhTaVBAUSYYpSi
         7v84MqkvXDzO07LIdephDe78VA77dKr5QclP9DRk9di+mg4B3BSTdC20n/cDQPSae9a2
         HUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712828207; x=1713433007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M5xqvnR68b34qM9yTb1YB3DFbXI/mKaCv5TejEheiw=;
        b=iBcbhIR5JwsZNjRqO9/JmHHvXMphhFqOWiZ8x8rpUR0K/smZuceD83g7q4hBgQihXY
         ncxKDOohZdGTQsPWUXy96W7eXUjf6iuYstkluiZ8OaB5y6aS/Zg+xhKrSaDzqTPPbK95
         j3UnPm6Eu+n1ajAmwPdpCeFp4taoY+EAWOfNuk2JYj/YyiGxXN/12c4Uw6Uk0RbFAkbd
         PQAYkiMhIvAJ6rZLVb3vLvLBnKpSMrichdfVd2YsrfBPrJ83KMy6t39mWQ46KqsYhtB1
         5fI6qjwCIk+1WN6/srTXhq7m7Eg68cmyH76x2KW+IGCU+CMdapouWALWRcwZdX4eGsEQ
         v01Q==
X-Forwarded-Encrypted: i=1; AJvYcCXx1cFLFDlXU/sO3mj2Xx4FhYpS/RTwKlyKtLkC/v1ZP8dcsYI/e6qC9gg+Ri/BIFqjk+ZeuB3ozz1nKChxwzUN4kmwlZ9l4P6Bik1DQubvSq0yimR14m+QdoZKDyP6wfvEwQ78AeIpbUk=
X-Gm-Message-State: AOJu0Yx3pZtdX/+r0MIvjB4+QW0bYIoaS3lGPcAq1LO6WYletksF6D9P
	W3wBTRjjDRjU/nmcbf7MAKcvCGJQfRyeqpNBWmpm9pglGpOJXGYD
X-Google-Smtp-Source: AGHT+IEBk4yLGJVnXJIG/b6gsPkg1Rwqcp/DF6rt3pFuZPY5Nk+rF0So3u9vnM+7E5NMc79IEyWd4g==
X-Received: by 2002:a05:6512:2826:b0:516:ea55:324e with SMTP id cf38-20020a056512282600b00516ea55324emr3515441lfb.26.1712828206600;
        Thu, 11 Apr 2024 02:36:46 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id q13-20020ac2514d000000b00515d1dfab34sm159647lfd.81.2024.04.11.02.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 02:36:46 -0700 (PDT)
Date: Thu, 11 Apr 2024 12:36:44 +0300
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>
Cc: Nas Chung <nas.chung@chipsnmedia.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Sebastian Fricke <sebastian.fricke@collabora.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RE: [PATCH v3 0/5] Wave515 decoder IP support
Message-ID: <hxgmjezr77jpa4uw45w2inple7t3zkb3ol4qlpgu3p6znuiil7@24h26cqmm2vm>
References: <20240405164112.24571-1-brnkv.i1@gmail.com>
 <SE1P216MB130385EC5A67C80D9CB61522ED052@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SE1P216MB130385EC5A67C80D9CB61522ED052@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>

Hi

On Thu, Apr 11, 2024 at 08:13:39AM +0000, jackson.lee wrote:
> Hi Ivan
> 
> Can you provide a score for testing a fluster tool so that we can verify the change on your HW?
> 

I did that, didn't I?

> Thanks
> Jackson
> 
> > -----Original Message-----
> > From: Ivan Bornyakov <brnkv.i1@gmail.com>
> > Sent: Saturday, April 6, 2024 1:41 AM
> > To: Nas Chung <nas.chung@chipsnmedia.com>; jackson.lee
> > <jackson.lee@chipsnmedia.com>; Mauro Carvalho Chehab <mchehab@kernel.org>;
> > Philipp Zabel <p.zabel@pengutronix.de>; Sebastian Fricke
> > <sebastian.fricke@collabora.com>
> > Cc: Ivan Bornyakov <brnkv.i1@gmail.com>; linux-media@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: [PATCH v3 0/5] Wave515 decoder IP support
> > 
> > Initial support for Wave515 multi-decoder IP among other refinements.
> > This was tested on FPGA prototype, so wave5_dt_ids[] was not expanded.
> > 
> > fluster score for JCT-VC-HEVC_V1 testsuite with
> > GStreamer-H.265-V4L2-Gst1.0 decoder is 132/147
> > 

Here it is. Above is the score, below is notes about failed tests.

> > The issue with Main10 tests is that fluster expects decoded file to be in
> > yuv420p10le format while this driver decodes HEVC Main10 into 8-bit
> > yuv420p. Though result is looks alright to the naked eye, proper decoding
> > into yuv420p10le is to be added.
> > 
> > The rest failed fluster tests are common with Wave521.
> > 
> > ChangeLog:
> >   v1:
> > https://lore.kernel.org/linux-media/20240318144225.30835-1-
> > brnkv.i1@gmail.com/
> >   v2:
> > https://lore.kernel.org/linux-media/20240325064102.9278-1-
> > brnkv.i1@gmail.com/
> >     * drop patch "dt-bindings: media: cnm,wave521c: drop resets
> > restriction"
> >       The only user of Wave5 in mainline is TI K3 boards, thus there is
> >       no real need to alter dt-bindings
> >     * in patch "media: chips-media: wave5: support decoding HEVC Main10
> > profile"
> >       add check for flag "support_hevc10bit_dec"
> >     * in patch "media: chips-media: wave5: support reset lines" move
> >       reset_control_deassert() out of else branch, add
> >       reset_control_assert() to probe error path.
> >     * rework patch "media: chips-media: wave5: drop "sram-size" DT prop"
> >        - don't move alloc/free form device open/close
> >        - intead of exact configuration of reserved SRAM memory in DT and
> > 	 allocating all of it, allocate all available SRAM memory up to
> > 	 WAVE5_MAX_SRAM_SIZE from whatever pool provided.
> >     * adjust patch "media: chips-media: wave5: support Wave515 decoder"
> >       according to changes in patches
> >       "media: chips-media: wave5: support decoding HEVC Main10 profile" and
> >       "media: chips-media: wave5: drop "sram-size" DT prop"
> >   v3:
> >     * reword patch "media: chips-media: wave5: separate irq setup routine"
> >       a bit.
> >     * in patch "media: chips-media: wave5: drop "sram-size" DT prop"
> >        - move MAX_SRAM_SIZE define into match_data->sram_size
> >        - add placeholders for validation that allocated SRAM memory is
> > 	 enough to encode/decode bitstream of given resolution before
> > 	 setting W5_USE_SEC_AXI and W5_CMD_ENC_PIC_USE_SEC_AXI registers
> >        - reword accordingly
> >     * in patch "media: chips-media: wave5: support Wave515 decoder"
> >        - add comments around SRAM memory allocation/freeing about
> > 	 Wave515 specifics
> >        - add comments about BSOPTION_RD_PTR_VALID_FLAG bit in
> > 	 W5_BS_OPTION register
> >        - add W[AVE]521_ prefix to defines, for wich there are W[AVE]515_
> > 	 alternatieves
> >        - add semi-magic Wave515 specific formulas to estimate SRAM usage
> > 
> > Ivan Bornyakov (5):
> >   media: chips-media: wave5: support decoding HEVC Main10 profile
> >   media: chips-media: wave5: support reset lines
> >   media: chips-media: wave5: separate irq setup routine
> >   media: chips-media: wave5: drop "sram-size" DT prop
> >   media: chips-media: wave5: support Wave515 decoder
> > 
> >  .../platform/chips-media/wave5/wave5-helper.c |   8 +-
> >  .../platform/chips-media/wave5/wave5-hw.c     | 395 +++++++++++++-----
> >  .../chips-media/wave5/wave5-regdefine.h       |   5 +
> >  .../platform/chips-media/wave5/wave5-vdi.c    |  27 +-
> >  .../chips-media/wave5/wave5-vpu-dec.c         |  51 ++-
> >  .../chips-media/wave5/wave5-vpu-enc.c         |   2 +-
> >  .../platform/chips-media/wave5/wave5-vpu.c    |  35 +-
> >  .../platform/chips-media/wave5/wave5-vpuapi.h |   3 +
> >  .../chips-media/wave5/wave5-vpuconfig.h       |  16 +-
> >  .../media/platform/chips-media/wave5/wave5.h  |   6 +
> >  10 files changed, 407 insertions(+), 141 deletions(-)
> > 
> > --
> > 2.44.0
> 

