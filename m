Return-Path: <linux-kernel+bounces-22365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF02C829CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785951F22C50
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE344B5BF;
	Wed, 10 Jan 2024 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVyAMoLU"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D2D4BA80;
	Wed, 10 Jan 2024 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6dac225bf42so2099138b3a.0;
        Wed, 10 Jan 2024 06:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704897275; x=1705502075; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OLSXUeHHdbGB54dJbMp+HtxPkk5bxitC1akHZcc8oAI=;
        b=aVyAMoLUvinISDxvBqv984KZ7sEHOQcbX+vxZpuzZjbxgtNJKypJzd22aLv8ByCCwz
         TUz52EC4dgQyD7UYPKFjJRzJGEAME8Y9eeqlL/JgonIrhyLAL9kf2+OyGh8nuTMzQh04
         8hXK4XqFlc/WXC5jbhs+s7VdZtxSE/Rn8tmi2zrJ/y66qimt+MOqsp6gctedepAAjcpL
         UlMfyMgBNWJUZKN2MLBEbSnNpfyXYqPkRP02q8HeVjQHaamGc7gFUEPy9JypcUVlmaWs
         9QJ5rpzWdzgLaMq/5smsyZcMyAhAryRllPyHc+tGopDnbMJUk0EYte0isc5ULFEqXKhz
         r/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704897275; x=1705502075;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OLSXUeHHdbGB54dJbMp+HtxPkk5bxitC1akHZcc8oAI=;
        b=HQdm1Igy+bn3a2j91M1vq+zYoRN6UaWCoI/mjKmExJuA/zlOOSkRIkTqKRfGb04ka7
         lqZGFHDs4IACzlzBoz2OBsp/4I8F+w5p3iw4+UJNybHhzs5fgefUI+z2cVxSLrO3tc8F
         QWQu/2dId1r6zZ1xUfMqxHAFUdvJxizobC3KLoAoe5cxZXIZRftHiH6rjX/9Z+MRkEI5
         /x550tLhYQc2ZqX1wyl77l4srNEULlwqWrQ6pfQdKsSguboIvtCZ3SmKoMSoG06u9dpp
         WBfQIzPs96KKwsFE9XOR/v/9Ads0jupgvoL/BJobm69TbyqOIyKs/vaIzQniOZbgbQUZ
         ej5w==
X-Gm-Message-State: AOJu0Yz5jKa7E5UBTQ35gLTrrXD02YVjmiuNHDsjwuVYDj6QiYrdwkAV
	E0hp1iGhGsmWTKW6vcaJg28=
X-Google-Smtp-Source: AGHT+IH/Z8GrTZZI/D8kRzf5K8QuLLbXOltYoq27idbxz/Z8mJYGyqttDo2JTOhDH+KezBNmwh9WyQ==
X-Received: by 2002:a17:90a:c78a:b0:28d:70b5:fafb with SMTP id gn10-20020a17090ac78a00b0028d70b5fafbmr691179pjb.32.1704897275361;
        Wed, 10 Jan 2024 06:34:35 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id ds16-20020a17090b08d000b0028dadd8b688sm1622878pjb.52.2024.01.10.06.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 06:34:34 -0800 (PST)
Date: Wed, 10 Jan 2024 22:34:28 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Phil Howard <phil@gadgetoid.com>, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
	brgl@bgdev.pl, andy@kernel.org, corbet@lwn.net
Subject: Re: [PATCH 1/7] Documentation: gpio: add chardev userspace API
 documentation
Message-ID: <20240110143428.GA47193@rigel>
References: <20240109135952.77458-1-warthog618@gmail.com>
 <20240109135952.77458-2-warthog618@gmail.com>
 <CA+kSVo_347gS+w_7ZXFDi9qDtT1aw15qoWRJZAVSkfbHShz7kQ@mail.gmail.com>
 <20240110130158.GA28045@rigel>
 <CACRpkdY9yXknHVQMq09Ep_y_Hk6iOkNqDS8icAKFW+fLDdwi-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdY9yXknHVQMq09Ep_y_Hk6iOkNqDS8icAKFW+fLDdwi-Q@mail.gmail.com>

On Wed, Jan 10, 2024 at 03:27:50PM +0100, Linus Walleij wrote:
> On Wed, Jan 10, 2024 at 2:02 PM Kent Gibson <warthog618@gmail.com> wrote:
> > On Wed, Jan 10, 2024 at 11:40:34AM +0000, Phil Howard wrote:
>
> > > You catch more flies with honey than with vinegar, so I'd probably soften to:
> > >
> > > Before abusing userspace APIs to bitbash drivers for your hardware you should
> > > read Documentation/driver-api/gpio/drivers-on-gpio.rst to see if your device has
> > > an existing kernel driver. If not, please consider contributing one.
> > >
> >
> > The note is is a rewording of a section of the existing sysfs documentation:
> >
> >     DO NOT ABUSE SYSFS TO CONTROL HARDWARE THAT HAS PROPER KERNEL DRIVERS.
> >     PLEASE READ THE DOCUMENT AT Subsystem drivers using GPIO TO AVOID REINVENTING
> >     KERNEL WHEELS IN USERSPACE. I MEAN IT. REALLY.
> >
> > So I've already toned down the vineger.
>
> I wrote that and I recognized the strong wording.
>
> I have come with great regret to the conclusion that it is better to
> shout like this,
> note that the sentence is not directed to any specific person and that means
> it is more OK to be harsh. It is not feedback to anyone, it is black-and-yellow
> warning tape to not go into this dangerous area.
>
> I like the current wording.
>

Can you clarify which current wording?
Are you ok with the proposed chardev wording, or should I be more
closely following the sysfs?

Cheers,
Kent.

