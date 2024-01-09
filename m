Return-Path: <linux-kernel+bounces-20955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9398287C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9B41C23B9C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02ABD39AC9;
	Tue,  9 Jan 2024 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="csusGywq"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F1A39AC1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6db0c49e93eso529876b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 06:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1704809404; x=1705414204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pq/dGBHry+bUFK42zIvRKqg915RDTOWS/nNkiEQIoSY=;
        b=csusGywq3XbxDeWTE9T+v8HVIJD9tFEjs9T28NCrWyL8BzuFxDwG9OQsBzo1D/B8TX
         8LMkNnZEa4qll92aROzhuAms5TRdPJ8HEYMqUuPI4kYKF32LSetk2cGTrl49ujGo27iK
         ALECmqM4ax7lbFDagTck86HbaT53MsvSGRJCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704809404; x=1705414204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pq/dGBHry+bUFK42zIvRKqg915RDTOWS/nNkiEQIoSY=;
        b=lrw3MUtOLXe60dSDRH5Y+ha0LtJUxQbZvMZgiaf99U62QxuP1UveNT/qRBflxNAtOm
         hAm7NPMLDZDxt928B4A8n+7vsVA77iYbAvK90D2oOhc4K61itMerQaZSMf05mBdRI+SU
         0B3I3VTvVnJqODMvhm+oVJ/Pt+pXCsQC/jDj0wxt7k9qgp7Z6ze7uaHDSfgquSJcJe1k
         jNBydG+MwNzeDDDgr2Pnne0ewQVblrna9DYfcPIo4MY4V+JA5fnVuT2r47xB3nBdrrfl
         uTD9vPx05QgG0ghpeVVkPNuYVT0sOjr3CqB4BN+g1bp+lWu6h/61P/wofQ2RVjuN+wM3
         pvaQ==
X-Gm-Message-State: AOJu0YwL6UrReYnrDl9c0qh0cpbzHBd4LNncH+y8KCMzcpd/ISOn45zn
	p4e78N8UiBEf396/m4ArEW5R1gK8qo5CXAeGfv6qKM7dhoOWQblWE7J80T1Zy6c=
X-Google-Smtp-Source: AGHT+IGybin4X6fPS7n0pGkPXVq/l7a2ywRmpT2HL/MuiV7RD2yWxQJMYUOqexE68flKre3YDuqEYb0We0t71oH5V7Y=
X-Received: by 2002:aa7:881a:0:b0:6d9:a32b:a27f with SMTP id
 c26-20020aa7881a000000b006d9a32ba27fmr5221136pfo.45.1704809404554; Tue, 09
 Jan 2024 06:10:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108093221.1477020-1-daniel@0x0f.com> <20240108093221.1477020-3-daniel@0x0f.com>
 <CAMuHMdX44A6+BNByuvbCC2gcM5vAipbaGAK7L8Vh8q3tMynBbQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX44A6+BNByuvbCC2gcM5vAipbaGAK7L8Vh8q3tMynBbQ@mail.gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Tue, 9 Jan 2024 23:09:53 +0900
Message-ID: <CAFr9PXn9wqbxToGDkSenW3XTCMPinUg1a9fHrUDQVhRKC6s5TA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] m68k: Fix interrupt stack frames for 68000
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: gerg@linux-m68k.org, fthain@linux-m68k.org, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi All,

Sorry for the spam..

On Mon, 8 Jan 2024 at 18:56, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> I think it would be better to use the classic m68k stack frame.
> That would pave the way for building a single nommu kernel for
> MC680[012346]0 that runs on e.g. any Amiga.
> MC68000 and Coldfire are incompatible anyway.

While looking at how to do this I realised that the addql #2,%sp in
RESTORE_ALL in entry.h will now break the stack frames for those fancy
68010+ users.
So that needs to be #ifdef'd to make it only compile for 68000. I saw
an error email from the next build stuff so I guess the change has
been queued somewhere? If so I should send a fix..
I'm not sure how to actually make that generic without patching the
code at runtime (remove the 68000 specific bit, reserve enough extra
space to rewrite the code..) but it's a macro so not so simple.

Anyhow, and more importantly, it seems like there is another issue in
68000/entry.S that breaks syscalls (especially vfork). After fixing
that I now have a working nommu 68000 system. I'll send a fix for that
too.

Cheers,

Daniel

