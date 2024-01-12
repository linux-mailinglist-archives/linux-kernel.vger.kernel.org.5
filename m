Return-Path: <linux-kernel+bounces-24984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D0482C59F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0AB1F24724
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6EC15AC9;
	Fri, 12 Jan 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuvMqsp0"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267BB15E8E;
	Fri, 12 Jan 2024 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d5a7954b8bso5533235ad.1;
        Fri, 12 Jan 2024 10:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705085598; x=1705690398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=84k2E/jFHGmRPt2TX0Wfbqb1lV5t099ixH2DWzPbXTY=;
        b=GuvMqsp0gsZwDL+b8Ce2D5inphp3ylxd+i1QfmBu2DEum+5B1YnDb1cbj+LEXhdQA5
         VC+GEZb8g9yo5UcBuaZeYz403A8h/wBoFCcFsWLSOKjoKOKzfNIXJp2DsWQDmxVc2TBc
         x6PZtPZrm/qjzl9zvdt4shHP9lEO9Wa3EjrguH7V1zqw/8bk61jljcHyW+JTBhyDj5mG
         7HwhWzmBU7XkVJ8itVsCXNUkh76z1FPRp5l1YKSiqNi1A7IEnaYUXTMsVSX4Gl0YLQOU
         Q3uUinvyIkfR0Q19uui091DF76raMi2m23aS76dqVqvyFA1oShzu0LSAAfr4CQK2fGRC
         XwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705085598; x=1705690398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84k2E/jFHGmRPt2TX0Wfbqb1lV5t099ixH2DWzPbXTY=;
        b=iaAz0unmrBqtbgw6Cyld1pCRrHvXpamXp8r/MnIdqTACSC7hWmfpLPQliAMQz6vXgU
         bHSeSqjVOjNDHY9VlOe+9tPupI6GX7JMTk9G+In5QZdE8JefIygR2SFT54534hRGUXNx
         DZslleWmJymZ6w0RWKO+cdLtkunZoLqx/ju1BYFegr33yD1wHL2RLCgGu+vn7Am0IFVB
         lA+wSEoBJvcMSI9Up4JWpkTIdp4FaPFbB50wYVL7H0NpqGeSmdiSPFYWEyLDkhG3Trvj
         I2HS5iddCtzzDhQW6o9xBfS5d96JgqNaY/0/moexmkFYJv5jHYHs814TXz6gaxx2KjKQ
         RMuQ==
X-Gm-Message-State: AOJu0Yyy648FcHKb1xXhJvelrzFTBfilvY7SMP+sGHSe9em5PE7EyY+6
	A/WqNWEt7x7/ACQuQ/0t4uHFoLp9mW3iyiSs71Y=
X-Google-Smtp-Source: AGHT+IFg4NCjR9gKqEIPMZ/TQOXnEfnqmDJRUIJiD4cqo5huuacha57jJ6vQS/BvEejG+/wUOygIp+m6gQLapXDoa7U=
X-Received: by 2002:a17:90a:eb0a:b0:28e:1eff:241d with SMTP id
 j10-20020a17090aeb0a00b0028e1eff241dmr369026pjz.67.1705085598366; Fri, 12 Jan
 2024 10:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112121844.17580-1-2045gemini@gmail.com> <3bbabf34-1eba-8983-439e-f23e811e80a8@linux.intel.com>
In-Reply-To: <3bbabf34-1eba-8983-439e-f23e811e80a8@linux.intel.com>
From: Gui-Dong Han <2045gemini@gmail.com>
Date: Sat, 13 Jan 2024 02:52:42 +0800
Message-ID: <CAOPYjvZYAxo=-H2eeJ8mHjx4af=TetbtZ_54-iX2cokzEHFeaA@mail.gmail.com>
Subject: Re: [PATCH] serial: core: Fix double fetch in uart_throttle/uart_unthrottle
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, l.sanfilippo@kunbus.com, john.ogness@linutronix.de, 
	tglx@linutronix.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	LKML <linux-kernel@vger.kernel.org>, linux-serial <linux-serial@vger.kernel.org>, 
	baijiaju1990@outlook.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

I apologize for any issues and lack of clarity in my previous patch.
In patch v2, I've revised the fix to use local variables instead of
locks and improved the description to clearly explain the harm and
potential for concurrency.

The patch was developed and tested on linux-next, not Linux 5.17. My
reference to 5.17 was due to a project I'm working on, which involves
kernel static analysis and a comparison with earlier studies that
support up to Linux 5.17. Therefore, I initially ran my tool on 5.17
to filter potential bugs that are still unaddressed in the upstream.
Then I worked on linux-next to develop and test the patch. I
understand this might have caused misunderstandings, and I'll aim for
clearer communication in future submissions.

Thanks,
Han

