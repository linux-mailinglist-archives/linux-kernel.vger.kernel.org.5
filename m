Return-Path: <linux-kernel+bounces-94141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9983D873A7D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E38E1F2C57B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502C05D904;
	Wed,  6 Mar 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQnDNYfg"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097DC80605
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709738129; cv=none; b=HQ0BHuLvyBkrl4Wx9cYGZbo1og/VE7uujtQ4LY0QDT2jhuq0aSwEWDjfdSlalnOKrhHTq0oG0R5wIR0IwDaOLKhbCA4mJpcjeJCdrwBBR1paDQUtNvzD3PS+Q1WgvXEElfDPdmImI3stU1IhgmiuENZU2Wh1p2/9hlqmU0UeH2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709738129; c=relaxed/simple;
	bh=Dn0MRuTSjo4R/exwH69NMcQ1iOfW9L8bYeNoNxJbJrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3Q8p5hibtH917wQCDohlfzxHPvjNo3POstT4Wy0uG7D5L25mp/SfcghP6vfZlkQEH/uzSUbwgTpfu7Oi6dkONnUGhvALdwre6Jt9OkiaSsCC26E6Wv3EcncAzmciTx0atc/7EtP5+dzmHIoo4XTMQ2CCQBfpYnVOwvnOP+EFaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RQnDNYfg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33d146737e6so5439061f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 07:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709738126; x=1710342926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pW2limnGuqov0pOO8NJ+gdd+nSsl0KmJbyeYhkrIipo=;
        b=RQnDNYfgHJhaB3Ba85AKiX5UVkq6sOap0M87xTxZa1WR5aT1CUH6D1Th85Vbhv6Yq/
         r1fnqs0/BGY+jcfuoO2U4tlAi0H5DnKq4mapscVCC/jknrzlkx+XkqqaIJi8Gu7vZT1C
         gh1LnI+/OEu71DXRF+5z5M9WzaAnYej+11IQv7S8MRcY0JSeo+IwRCQIrxjcTLNTV8ok
         qbtYuwMVimil0ocAYlcYS3saXddgB9JJUOlZpfrmnjoDuRvIWAH3vPdDfinCvMCel03r
         kXrY54HPOzIa9zOX04jGQpgqX9BNd7F5su58TMVYDDzgXfNPDj9z4i83loZ6NYaAarwJ
         EzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709738126; x=1710342926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW2limnGuqov0pOO8NJ+gdd+nSsl0KmJbyeYhkrIipo=;
        b=KduMfZO97jKMw5JPnaiv62Pyp+Y8y+ugMu034qYXYM27npo5Bk+B0P6sXVHX5oEETA
         pWVu29yLW5qSE/QaeMs78OpGv0e4VS0fIPbVDUvQMVJ1yItRI49mgrpOIJlMQkrosLHk
         8XuP+301CsI4DRwsgFj/c9kM1i34DMjQvsr05AxwFvj45QvmohXEZ8SefOra45Ylod+r
         5pbGiRiWrL/fg+avNIj5tvQ8kY9OKHngLxY3PAkprnby/buv6Brk7FqeQGJPLXawUjOl
         Xabsm7UAn006Et05l+BgPoCfs0hlLC10o92zG7K3esyGnZPFNJQW+4qMcJHSXyzZGjQJ
         D5HQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw9ENG7XtiPO5LZru8IzAHOFG1o/MGN+YvMGXlngFsqGswi2T+Poe1cxlmbi4jGhkV5HWw0p4/DKv1SAe2/3IcTuihjpLKX9HDmzqC
X-Gm-Message-State: AOJu0YzCE0HvtK1a0TgHv5VvBjDKQd06xfF9ZRbo2jCAm26UXkskD2U/
	wOG9LSijj0Z0WoGClxg48O8uITkkVF1N0wAVXfcmr9Wjd/1tEqIIuyX94pdEDD8=
X-Google-Smtp-Source: AGHT+IFQlmyNZzL4+K2CJVkIAwJpBWnPqgm1lcCu7a5dBExDwS8b0VVZKmonrTsic1ydKvWJzSou2Q==
X-Received: by 2002:a5d:440a:0:b0:33e:52b7:eeae with SMTP id z10-20020a5d440a000000b0033e52b7eeaemr1966097wrq.43.1709738126095;
        Wed, 06 Mar 2024 07:15:26 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id g1-20020adfd1e1000000b0033e3a24f17esm9322023wrd.76.2024.03.06.07.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 07:15:25 -0800 (PST)
Date: Wed, 6 Mar 2024 18:15:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ayaan Mirza Baig <ayaanmirza.788@gmail.com>
Cc: kernel-janitors@vger.kernel.org, ayaanmirza788@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Subject: Improved help text for rtl8712
Message-ID: <55ee3fe0-d80d-4880-a171-33a044e95078@moroto.mountain>
References: <b442a768dd23d9c6fdac6fcc30bc86794e85c8f5.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b442a768dd23d9c6fdac6fcc30bc86794e85c8f5.camel@gmail.com>

Hi Ayaan,

This patch obviously got a bit mangled in transmission as you can see.
Read the first paragraph of Documentation/process/email-clients.rst, but
then do a google search on how to use git send-email.  Send patches to
yourself until you figure it out.

After that use scripts/get_maintainer.pl to create the correct CC list.

On Wed, Mar 06, 2024 at 08:15:35PM +0530, Ayaan Mirza Baig wrote:
> 
> >From df9050d0dff9e4160172dbc910f718c16095fc8d Mon Sep 17 00:00:00 2001
> From: Ayaan Mirza Baig <ayaanmirza.788@gmail.com>
> Date: Wed, 6 Mar 2024 19:53:12 +0530
> 
> Rewrote the help text paragraph for R8712U and R8712_TX_AGGR
> 

The commit message needs to say what wrong with the original help text
and why you are re-writing it.

I suspect that you're re-writing it just to make it longer than the 4 (?)
line minimum.  Don't bother with that.  Checkpatch is overly strict.
People can understand the help text fine even though it's just 3 lines.

regards,
dan carpenter


