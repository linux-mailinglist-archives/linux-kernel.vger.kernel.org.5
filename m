Return-Path: <linux-kernel+bounces-145223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7048A5110
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8661C21E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D3E12BF25;
	Mon, 15 Apr 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW8jandl"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F123C3C;
	Mon, 15 Apr 2024 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186471; cv=none; b=kx3R2/zkNLF6Xp8Ls/b8YYexkOmjEnQeNrVvmPM8jgiDOVjOa+RZHL2y6elEBFdIvEuZk0b0bhJkoIUEcBa6/SxwWKPz6PCOqnpJeiVQZ2ZdikulPLCgUxSN8W96HOVGwx6Y3uk+HkdlJXM/zmnhsre6y+zi7SjEiCWmtOUVoCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186471; c=relaxed/simple;
	bh=gS19U2LMgxHn3tPIc3bABcZslgPlETN1xmO/sEgYmaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdRYpddxJUIvj4HLBAQk/715Q4QyOq3xIon1eDzFEXnUBTEYcNUpE+G5BSuc4vsBUC4/vn/BZcz8xCKzqq4Z4XTEOpDO8foiu7OmcfkaTXnvJBxVAaPrRQjMh6twbgGgkhsRiYhs5Fucvj0uNFX+Uy70S6sooK5UCCpaH+Sc1gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eW8jandl; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d858501412so41222571fa.0;
        Mon, 15 Apr 2024 06:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713186467; x=1713791267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hwGePoglphSQKsda1MrK2Xjwvqfn+atkNdfELksmfIE=;
        b=eW8jandluDEW+mKjUr35XpIh2GTpuzM0aaT3HnRAYFqUFkt0a6CpJrkqqheepKQznu
         TE6XyDQS37nlhlglWYP9RK2dHKw/8esRnzKABL9zjdU3dVmkgHT6+x0YH31T/afSxIWm
         WC7ruEc40g81xcosrxtJFvmZSH7F7IDg/JkP7Wxx2pIyCUAGlOpVds7hJ6QZ6j8wcpUD
         mRHnjOrqlUh4qsn9CdxJD3vmU+aLt/BmOFx8pOsjB/Od0cqQDoeVFpNEoH30bJj0gJXZ
         +rltjlN7025tXDb6S0pEZ2iAcBhVvzhQyFjWiIr3CX7kdb0BNaN5my7A/1MMcYQFV8Xc
         RcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713186467; x=1713791267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwGePoglphSQKsda1MrK2Xjwvqfn+atkNdfELksmfIE=;
        b=BheSPqiam4F7m/lTgpl3BCYrPRDtMQFwaBZE1FY5IDufVNLTBsCIsnK4eY7Yq7YAFB
         zaqvlH13U0SEgr4Q0tLFiLs1/lI0NLgUxKGU04rFW6YglUgj2ii4Fq2eQofCPsa6iA3r
         PTr7UQfgSrYWYxNh6k57VEnqgHt5yl7yUIBjt7jnmbeExxOU6SjoM/exxDVUhtokQbgy
         ruvr56mHi2pMo2+wlZh/cMbnE1M9yTW9bg2crujdO0uP6noJ2kBI7AtgzmV5715U0SOi
         ze/fr53NJhNClW13Id6ydHYU/4qtflCH9lKjpRsSYGzqD/GDH/4qQfMYylEX1qrAbZ6f
         pIjg==
X-Forwarded-Encrypted: i=1; AJvYcCW6p1ZU+q7wA7G5oZlkQPJGJ0eBz7bDsC3A0I7iZNGFGHQCo66WaRhJmOfZOTtZpS7xr1m1vynhBOWctjdCS1fEuNRG25I7+Skyp69Y2oK/TfttiSAOMTai11U76kxmC9eC3iNMLNI0NuM=
X-Gm-Message-State: AOJu0Yy/KUa51EmU3soDW+DvlI/DwKIGhoX8/FJ75yfKGvJQpGSmwyI5
	y943/etjgWGKYMrRZc5zc0rJ6vUYfGnkPcZPxZvtlahyKdf76nbB9Uh6rtvR
X-Google-Smtp-Source: AGHT+IFUjYLI0pxt3uEd45M/nMRETsdb1SHA2TelFeu+jnMcv5/Xl0R3+egbOFtt/zhGomYQOfjOQg==
X-Received: by 2002:a05:651c:33a:b0:2d8:6561:72ca with SMTP id b26-20020a05651c033a00b002d8656172camr5677265ljp.19.1713186467135;
        Mon, 15 Apr 2024 06:07:47 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id r2-20020a2e80c2000000b002d6daf3b41fsm1242411ljg.101.2024.04.15.06.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 06:07:46 -0700 (PDT)
Date: Mon, 15 Apr 2024 16:07:45 +0300
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Nas Chung <nas.chung@chipsnmedia.com>, 
	Jackson Lee <jackson.lee@chipsnmedia.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v4 0/5] Wave515 decoder IP support
Message-ID: <xrz5jdqc5p3u2grxy62xkhwny5dqhyggyzt4hpfwzpinbezbfj@vp5wakv55k74>
References: <20240415100726.19911-1-brnkv.i1@gmail.com>
 <20240415124938.o5j5er7osnb5ohdm@basti-XPS-13-9310>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415124938.o5j5er7osnb5ohdm@basti-XPS-13-9310>

Hi

On Mon, Apr 15, 2024 at 02:49:38PM +0200, Sebastian Fricke wrote:
> Hey Ivan,
> 
> On 15.04.2024 13:07, Ivan Bornyakov wrote:
> > Initial support for Wave515 multi-decoder IP among other refinements.
> > This was tested on FPGA prototype, so wave5_dt_ids[] was not expanded.
> > 
> > fluster score for JCT-VC-HEVC_V1 testsuite with
> > GStreamer-H.265-V4L2-Gst1.0 decoder is 132/147
> > 
> > The issue with Main10 tests is that fluster expects decoded file to be
> > in yuv420p10le format while this driver decodes HEVC Main10 into 8-bit
> > yuv420p. Though result is looks alright to the naked eye, proper
> > decoding into yuv420p10le is to be added.
> > 
> > The rest failed fluster tests are common with Wave521.
> > 
> > ChangeLog:
> >  v1:
> > https://lore.kernel.org/linux-media/20240318144225.30835-1-brnkv.i1@gmail.com/
> >  v2:
> > https://lore.kernel.org/linux-media/20240325064102.9278-1-brnkv.i1@gmail.com/
> >    * drop patch "dt-bindings: media: cnm,wave521c: drop resets restriction"
> >      The only user of Wave5 in mainline is TI K3 boards, thus there is
> >      no real need to alter dt-bindings
> >    * in patch "media: chips-media: wave5: support decoding HEVC Main10 profile"
> >      add check for flag "support_hevc10bit_dec"
> >    * in patch "media: chips-media: wave5: support reset lines" move
> >      reset_control_deassert() out of else branch, add
> >      reset_control_assert() to probe error path.
> >    * rework patch "media: chips-media: wave5: drop "sram-size" DT prop"
> >       - don't move alloc/free form device open/close
> >       - intead of exact configuration of reserved SRAM memory in DT and
> > 	 allocating all of it, allocate all available SRAM memory up to
> > 	 WAVE5_MAX_SRAM_SIZE from whatever pool provided.
> >    * adjust patch "media: chips-media: wave5: support Wave515 decoder"
> >      according to changes in patches
> >      "media: chips-media: wave5: support decoding HEVC Main10 profile" and
> >      "media: chips-media: wave5: drop "sram-size" DT prop"
> >  v3:
> > https://lore.kernel.org/linux-media/20240405164112.24571-1-brnkv.i1@gmail.com/
> >    * reword patch "media: chips-media: wave5: separate irq setup routine"
> >      a bit.
> >    * in patch "media: chips-media: wave5: drop "sram-size" DT prop"
> >       - move MAX_SRAM_SIZE define into match_data->sram_size
> >       - add placeholders for validation that allocated SRAM memory is
> > 	 enough to encode/decode bitstream of given resolution before
> > 	 setting W5_USE_SEC_AXI and W5_CMD_ENC_PIC_USE_SEC_AXI registers
> >       - reword accordingly
> >    * in patch "media: chips-media: wave5: support Wave515 decoder"
> >       - add comments around SRAM memory allocation/freeing about
> > 	 Wave515 specifics
> >       - add comments about BSOPTION_RD_PTR_VALID_FLAG bit in
> > 	 W5_BS_OPTION register
> >       - add W[AVE]521_ prefix to defines, for wich there are W[AVE]515_
> > 	 alternatieves
> >       - add semi-magic Wave515 specific formulas to estimate SRAM usage
> >  v4:
> >    * rebase onto next-20240415, no functional changes
> 
> Sorry for not finding the time for review, I'll work on it asap.

Thanks in advance

> But please don't send a full new series just for a rebase, as that just
> causes noise, I can very well rebase the series myself before a PR
> and if any hard conflicts appear they can be communicated.

Ok, noted. BTW, there was minor conflicts with commit 
"media: chips-media: wave5: Add hrtimer based polling support" wich was
accepted since v3. Next time I'll ask explicitly if I should post
rebased version or not. Apologies for the noise.

> 
> Greetings,
> Sebastian
> 
> > 
> > Ivan Bornyakov (5):
> >  media: chips-media: wave5: support decoding HEVC Main10 profile
> >  media: chips-media: wave5: support reset lines
> >  media: chips-media: wave5: separate irq setup routine
> >  media: chips-media: wave5: drop "sram-size" DT prop
> >  media: chips-media: wave5: support Wave515 decoder
> > 
> > .../platform/chips-media/wave5/wave5-helper.c |   8 +-
> > .../platform/chips-media/wave5/wave5-hw.c     | 395 +++++++++++++-----
> > .../chips-media/wave5/wave5-regdefine.h       |   5 +
> > .../platform/chips-media/wave5/wave5-vdi.c    |  27 +-
> > .../chips-media/wave5/wave5-vpu-dec.c         |  51 ++-
> > .../chips-media/wave5/wave5-vpu-enc.c         |   2 +-
> > .../platform/chips-media/wave5/wave5-vpu.c    |  35 +-
> > .../platform/chips-media/wave5/wave5-vpuapi.h |   3 +
> > .../chips-media/wave5/wave5-vpuconfig.h       |  16 +-
> > .../media/platform/chips-media/wave5/wave5.h  |   6 +
> > 10 files changed, 407 insertions(+), 141 deletions(-)
> > 
> > -- 
> > 2.44.0
> > 

