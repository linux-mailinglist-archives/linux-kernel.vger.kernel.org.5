Return-Path: <linux-kernel+bounces-138273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5114189EF12
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 971CEB21767
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFF9156865;
	Wed, 10 Apr 2024 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMFOBT6x"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07209125CD;
	Wed, 10 Apr 2024 09:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742370; cv=none; b=YOymUHFXrQNcfD2aBGKxJ5FmMQPCiBS/G/gBvZ0gf4CwL1WncWugOV6YiLox98SdAEyDdcz25wS5ejVZ2vT1e/7BFrZS49V2Ge91c/rL1XKK009ZhFoH1Iy1iu2tekNcBacQw85xUIxyTllR4XkizKKPrfSL9cubYXLZeNubl9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742370; c=relaxed/simple;
	bh=2Q+KRTHpRgdRUsUD7FxZmGhMQwfpvVD7f1DhqQpdJSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yeb/cr2aSoECa+193f50G+gZbQPflyGWWdtwGRplqo/+7uRyyVf/V/bWgCNGvPtXrheGaVYc8xFwA0E5nA9k/kBVr8ix5HaApqBSIBUQSUbKKvUC1JKK+oZN3mfMa4r7af6lyVvm4EdC3nOkCf7h1yEL4bhkz65XCjRZHbeamxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMFOBT6x; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56bdf81706aso8668653a12.2;
        Wed, 10 Apr 2024 02:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712742367; x=1713347167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Q+KRTHpRgdRUsUD7FxZmGhMQwfpvVD7f1DhqQpdJSk=;
        b=nMFOBT6xMub3+Uhz1NeIKvQb4C0fHwt2HvIfz6T2vnOuHGPv/ZMpwHm5KamC86N+3j
         NLsXQOJSCjNyXjbQd5zbaVdg6FoiCpxoRAT+iSgeZHWOaewj2wMcjEAA8t5Mm9bUUF2c
         8bqe0lbLiSF304g5Pa4xO9FYouK8gV7rVFhOf4yVtdzCERpq7Hs48sgD52rQrtH2h2jq
         ms/FaMpGWrTNZsGKROO72JYr7oy9xPzUHkkygxp+ZSqLtatUtK6hRnDTQxsazjooSk/u
         ub6N6bw9S/DW4cFBXmZH1etpf9PTCIfnWGzYUuPOrS6t8EoI7LDcT2MytLnbxIS4jQSB
         ny7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712742367; x=1713347167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Q+KRTHpRgdRUsUD7FxZmGhMQwfpvVD7f1DhqQpdJSk=;
        b=ZsxTaJbGZPcKJm3nbw6e/8DQ15h/q0tHwiZfewb4u4/RHUXL2YU3lDyStTaAomHuzs
         cKD3rKZnDfgqUh+OrJ8TCG5n6A9xUCoe9QV9/3+O2ZPC+Yb280Yqr1ROYtdUo4MXTsCh
         dlrq0XPFlG4e5VqQEQPu+4WJ/X6OLsOngixo2SQMzq5jPetQyyCK32Xl3Qi1PaSlRxsC
         1y/xImsKzdx0z3ob1Tgb0PbPiJAfiVC7lVeP7GLeKmLn2EpootT8bOuncg3vTznwCkPX
         TWLbqGgBtgIxsM+mwqfSAxmna62eJ9LK0syh/FKj3utAT5mzaG129/dfKSLElcyPHkSH
         AWvw==
X-Forwarded-Encrypted: i=1; AJvYcCWY94Cvq1kNadSdqZxIKdL8K0OhqS8HmWf7UUe2+4ceIxeZMWr8J01pys5WKcO0CvoHTw+jaqT3BwBclveJZIhD8E4y4mFncjB0gbNFvqkODXhsv0m5dASLFNDDC3lQK35YSZUErE9z
X-Gm-Message-State: AOJu0Yy1p9ci1f84cxI+3Xc91KH8gVx4XUm/GergNR5bGGt6fVCe6wv2
	hdM1rdxarYeCSegT1L1UntHQK6Qjzc7PiIeWrO7sEYg4VNpcXTuy
X-Google-Smtp-Source: AGHT+IGWl6bnDupDikFXTK6BY6vxUeZtVZq0+rKCvusjW/N/joJZ4+thYc4Ul5yN3JS0TSPZzg6spw==
X-Received: by 2002:a17:907:9496:b0:a51:d0e6:57ff with SMTP id dm22-20020a170907949600b00a51d0e657ffmr1533222ejc.45.1712742366938;
        Wed, 10 Apr 2024 02:46:06 -0700 (PDT)
Received: from foxbook (acgm220.neoplus.adsl.tpnet.pl. [83.9.240.220])
        by smtp.gmail.com with ESMTPSA id dr19-20020a170907721300b00a4a33cfe593sm6729694ejc.39.2024.04.10.02.46.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 Apr 2024 02:46:06 -0700 (PDT)
Date: Wed, 10 Apr 2024 11:46:01 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Mathias Nyman
 <mathias.nyman@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-usb@vger.kernel.org, Niklas Neronin <niklas.neronin@linux.intel.com>
Subject: Re: xhci_hcd 0000:00:14.0: ERROR Transfer event TRB DMA ptr not
 part of current TD ep_index 1 comp_code 1
Message-ID: <20240410114601.0e25a46d@foxbook>
In-Reply-To: <82113c7d-0405-ba11-94d9-5673593cec50@linux.intel.com>
References: <58bca6f2-797a-4e20-a476-2294309afdd5@molgen.mpg.de>
	<20240405113247.743e34b2@foxbook>
	<7090d3af-18ce-40e1-8ac2-bf18152e5c4a@molgen.mpg.de>
	<20240406183659.3daf4fa0@foxbook>
	<c57f2116-8c42-44fb-9c32-6115ad88f914@molgen.mpg.de>
	<20240407142542.036fb02f@foxbook>
	<1f64af9a-0618-a7da-4acc-f043b6580308@linux.intel.com>
	<20240408210541.771253ff@foxbook>
	<82113c7d-0405-ba11-94d9-5673593cec50@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> Driver can cope with these extra events, but if this is common we
> should probably handle it silently and not concern users with that
> ERROR message.

The error message in itself is harmless, it means the driver gets an
event it doesn't know how to handle and ignores it. Further events are
processed normally (in this specific case).

What's problematic is that the controller is apparently still working
on a TD which the driver considers to be finished already. The driver
can overwrite the TD and reuse its data buffer for other transfers,
while the hardware may still need the original TD for proper operation
and, if we are very unlucky, could attempt DMA to/from the data buffer,
causing data corruption or information leak to a malicious USB dongle.

For all we know, Paul's buggy chipset may not only be confirming the
transfer twice, but really performing it twice for some stupid reason.


> We are actually at the moment looking at improving handle_tx_event()
> with Niklas (cc), and will take this into consideration.

Given the number of bugs so far, maybe it would make sense to count
transfer ring slots of the last completed TD as still "in use" until
the next TD is known to at least begin executing.

Unfortunately, "quarantining" URB data buffers in similar manner would
be harder AFAIK.

I recently found one more bug of this kind: the Etron EJ168 controller
produces two events for failed single-TRB isochronous IN transfers -
one event indicating the failure, and then a "success". The full extent
of the bug (does it affect OUT or non-isoch, what happens on multi-TRB)
is unknown because the controller is very prone to crashing under my
workloads, which doesn't help debugging.

Regards,
Michal

