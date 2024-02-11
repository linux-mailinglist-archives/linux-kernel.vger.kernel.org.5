Return-Path: <linux-kernel+bounces-60977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6FD850C19
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005FD1C20D90
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE80171D8;
	Sun, 11 Feb 2024 23:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFN1Wlx1"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5DC14010
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707692811; cv=none; b=XInjLH7yLs0BFOt0wmzujGrSeWBuSkgwG+Jf6mtM1cDSFrW+qHA4SbqIk8rB0DBANKCGRR6IMiZvdnRqrc535HPYFGD8ogpfMJwN/OOJ17mnVEesouHxHfOV8TkjjVjO7m3t2l/+BLtPhpGlmPaD9ZHWSQfHYAm+8j2cIGOKGmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707692811; c=relaxed/simple;
	bh=jtcobRYgNI43bB+fM74E7FhkB3DFmGQyjnJ4YWHpRps=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JgOdS8eds6a27Gt65H0Bxqt1dPY34Sc0xR6vQ9i72HV8Eyx+Tk/2jVyWb1BwS5XU2mjizpUsowsWZl/KtAxmlaZbyPgCR4KbidWxqKGxl09WyPTvvkeNoU6JsiM16ECX+g4iYa77vfsw4HELSUjVbAiwG2L2AVFd8YKwosNp8D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFN1Wlx1; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e02597a0afso1862008b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707692809; x=1708297609; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gCuySXt9kRwqpI/wQDtgRgdqYmihUz1Tr8Gz7e8ppCU=;
        b=LFN1Wlx1fcjnAAv5VEB9zbyO7LgBUAWHU7uMd550+75d7GPzXICvwRTCjBqhf3sOtx
         2+eCgUxrDAV23Rie5itCnIhqiV8T4naJMiswqAGzKkNK6TqjEq3sQYxr4yENtuP8kCOC
         wV1POixnXPoiRNbZM9a2lufNcIc2PBBfz8wCoq7c+SWJwG2PCx9qH598NedfbMlf+x4n
         yvVpGKOctDrMBIF2ZgBvoptNuZAd+KPsrkpoeF07D/0e5dJnWEUSDrbctRzb5Wsj5lC8
         fJ0D8OawO6mP5OwiDUo8mviSu2Hb1t6vaDdNOf0nVQlrRWoJmq5Q6e/8iL991lHZW/Ei
         eoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707692809; x=1708297609;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCuySXt9kRwqpI/wQDtgRgdqYmihUz1Tr8Gz7e8ppCU=;
        b=kV8HVedpghDLAJdhfvL7r+AXSxjDzvnszBUdNfwfFaV4ySMplY9oTVhAjham5QkP86
         rcBHskwZoKBLvg0aE+RWAiCjzBjl5DUYD6bocFOb3jp3ezSFQwp7p2A8GKtn7w0gGGNx
         V1tNBa70OIRiNN8+YcAVFMlFoaOLsVLApFfElrA9XsYs2Zpoe01tukQIz8syiKWMJWao
         1jv5hqOh8/dedPj1bLUgSuOHTD5OipQPJmiNrbVuxjtfqBv4Xj27aferxAXYDgihBWZM
         VwMVocOHtjUw6JurC09jUzqbt/QvnCk52lRIsYcIbmVcTAtKjKomkAr9tVk9JQtVtO9G
         33UA==
X-Forwarded-Encrypted: i=1; AJvYcCVif+ZDBCH9IaC3RME93uHDzqlnl1W5TOeC2bkF6GQ1YyK/RxeijfV/Gv3liJJRb6I0VhLgAylwWR3FNKDwP7IhPpiE0yZ87L1DyGHW
X-Gm-Message-State: AOJu0YykOVR2edNMxbYmkOlmi0u2VXh0/Q7x1PsYVRHzxlFRJ1nJoujl
	ms79p98MNSQAdH2vrqfj7lMZMgPSoT0aXww5jy0bjjTcRR7/nZ3O2ydkxM8v
X-Google-Smtp-Source: AGHT+IGkF8iwmZ1C8WoWCat6qIp7VV/d/IlBX+mHEslKVgouuWxghIkjljZ6xvgkKzYvt6IBsvriug==
X-Received: by 2002:a05:6a20:9f43:b0:19e:a9e6:c05 with SMTP id ml3-20020a056a209f4300b0019ea9e60c05mr8085896pzb.43.1707692809151;
        Sun, 11 Feb 2024 15:06:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdHbC8J0Ps8b93WpG2q46cOzDyD7bkya8gbU0f2Y98KE+iz2Oe1i3VYX5LqtUpL2lKDFcRRs0WElDBoDX+XbHug3oYlk3MCOp9dIeC
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b30-20020a63715e000000b005cfbec9f8b4sm5564967pgn.54.2024.02.11.15.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:06:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 11 Feb 2024 15:06:46 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: stackinit unit test failures on m68k
Message-ID: <a0d10d50-2720-4ecd-a2c6-c2c5e5aeee65@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Geert,

I see the following stackinit unit test failures on m68k when running
the q800 emulation.

    # test_char_array_zero: ASSERTION FAILED at lib/stackinit_kunit.c:333
    Expected stackinit_range_contains(fill_start, fill_size, target_start, target_size) to be true, but is false
stack fill missed target!? (fill 16 wide, target offset by -12)

    # test_char_array_none: ASSERTION FAILED at lib/stackinit_kunit.c:343
    Expected stackinit_range_contains(fill_start, fill_size, target_start, target_size) to be true, but is false
stack fill missed target!? (fill 16 wide, target offset by -12)

Do you happen to know if this a problem with the test, with m68k, or maybe
with the configuration ? My configuration is based on mac_defconfig with
various test options enabled. I use gcc 11.4 to build the image. I tried
with qemu v8.1 and v8.2.

Thanks,
Guenter

