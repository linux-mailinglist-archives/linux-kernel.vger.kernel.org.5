Return-Path: <linux-kernel+bounces-29408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A0D830DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A131B21F63
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9E324B2C;
	Wed, 17 Jan 2024 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoTRl9gx"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A3E249F2;
	Wed, 17 Jan 2024 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705522818; cv=none; b=ijde2wumr/Y7VfcEA/KySrLrxv93mplEDSjxMIzgWjkFqfOhDWPEukLiyoEIDeSXA+ZgMenLPbWy4oqnnOcm74Et8fAT5hsHV8E5vvjcEi87JPeHVmP61fM23Ur1EqhOAMD9yEebVPQNo3pv2QgmITuEWesS6N9SuqNV5XmldME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705522818; c=relaxed/simple;
	bh=yU5KYoYcpqhPgvWZkidKsRuW99AW6JOnQpIXjtHc1XE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A0DoHMHqt8//5t1T8aiCP3HJCP8CrUMRdplgNS9jqdeGIXJK91oybzATXNZvG4ZW2OW88WQC5QvlelhBH4BeZW2r55gsoI5ecjl9JyiBH1S6xIZ8zM7sScaB3Gux5h6WFvMH9uA9XI3QN+Su+Xa4ZjreELSRuQI/bBDpMMsly7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoTRl9gx; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6d9b267007fso6816920b3a.3;
        Wed, 17 Jan 2024 12:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705522816; x=1706127616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qtaH76ip/clCvPSFl26veZ3HUaWTqTmbLlQ2wykDAiU=;
        b=CoTRl9gx44TS0L/ZBA/2aiHckWV1bJjQ3KeLWc2saYoaWHaUaX9uoNPw5N/KR0PyPm
         CdFIUPA4yj20mlXvHKh6kgdGMQUk7CdzlUEmOLwpAIITEMHJPdxwV5msm3Bk+EyQ46ym
         x47uJQEvwhLXQFBQE5Uig3w/XF+X00fLjopkL1kTNosW54QOYRMk+dwZ8OzCFcvyUbMV
         vVL5sLNKmt8Mh3oLu5saQZnAXb53yX+BqWF3mJEDlAMLYD5mb0PW2gkVO3JegIwHg9nC
         ROjUwdbwJchiMuwh3SxLSsdbegTD84cldqSxBEWwJD6EXSNcsMqjrPUktu2jJQACxqKE
         Fc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705522816; x=1706127616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qtaH76ip/clCvPSFl26veZ3HUaWTqTmbLlQ2wykDAiU=;
        b=KSKXxROwo/jPJy2PJWXI9lQG5n3j03gFXMFovbhItcatWnJdEqhtL6r/2uvgKcXymu
         TsTaYARwPX+0AoIaxisTEDivl5QgcMW232TJ5OwLG+YykGvKTdkmG7gW0i/lvymqPJbu
         bWPzDpsZVcBRQLM9tSfrKdlQJ5DaN8tjiYrJ9/DRSFjRnooBDHJwOSQcw2+DJ8Lm/Yxe
         qE2SYNEajS5SWu4oBUNv9W2dew+GcMPo0oqIQ5w0C3KhSKmIKTGVinHfTwjdAzH48g1m
         i+9rmtrbs6oqEPx55+MyvR7e5sBbo2BhwgYNgMY+D7eA8CznbOlxmHGI+w1kokcd98db
         eodA==
X-Gm-Message-State: AOJu0Yw8/SQL7H48TCO/6IPOEnyclQF5e9JXYMF3JJyb/r9YQq0JK9I5
	Y0abah/l0F/3tRarlmyYa0w=
X-Google-Smtp-Source: AGHT+IGqhdn4paLmJN9bvMsAaycnDzvpN4ohri/gF9864NhVgIZ7FK5xXhNeslJeM+GOHNEC3DUMmg==
X-Received: by 2002:a05:6a00:2443:b0:6da:7eb5:eed3 with SMTP id d3-20020a056a00244300b006da7eb5eed3mr6100133pfj.5.1705522816081;
        Wed, 17 Jan 2024 12:20:16 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:77ac:1fe8:3f5:523d])
        by smtp.gmail.com with ESMTPSA id u11-20020a056a00098b00b006daed66b540sm1846040pfg.219.2024.01.17.12.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 12:20:15 -0800 (PST)
Date: Wed, 17 Jan 2024 12:20:13 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Luc Van Oostenryck <lucvoo@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] parse: handle __cleanup__ attribute
Message-ID: <Zag2fYsyJDtDR7a6@google.com>
References: <8d596a06-9f25-4d9f-8282-deb2d03a6b0a@moroto.mountain>
 <i4s2gnr6rlq3yhmfiy7lkbsahnaioilksvmx3eocdjfh2434zo@zhxhwwgqpxt2>
 <44e22df1-734e-49c5-b20b-4f4cdbce24a6@suswa.mountain>
 <75ee8bd3-aa80-46dc-9f0c-874a8f4e9d48@suswa.mountain>
 <k6ztyjq24ik24qtsu3aqpipodzgq37i2ko42ag7wzn4t2ryrzf@i4gbxu7kvslt>
 <c3884893-44fe-4622-8e8e-576a0bdff19f@suswa.mountain>
 <troz4beymvsw2m4y4ocghwiidohi4nbj45ry2tfmbekanu2ray@ooravawiynxr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <troz4beymvsw2m4y4ocghwiidohi4nbj45ry2tfmbekanu2ray@ooravawiynxr>

Hi,

On Mon, Dec 18, 2023 at 02:51:32PM +0100, Luc Van Oostenryck wrote:
> On Thu, Dec 14, 2023 at 04:20:20PM +0300, Dan Carpenter wrote:
> > Yep.  Perfect.  Thanks so much!
> 
> Pushed now.

Any chance someone is looking at making context tracking working for
code annotated as __cleanup? We already have a bunch of code using
constructs like:

	...
	guard(spinlock_irqsave)(&gpio_lock);

	if (!test_bit(FLAG_REQUESTED, &desc->flags))
		return NULL;
	...

which resuls in:

$ make C=1 W=1 drivers/gpio/gpiolib.o
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  CC      drivers/gpio/gpiolib.o
  CHECK   drivers/gpio/gpiolib.c
drivers/gpio/gpiolib.c:2359:6: warning: context imbalance in 'gpiochip_dup_line_label' - different lock contexts for basic block

and I expect we'll see more and more of this.

Thanks.

-- 
Dmitry

