Return-Path: <linux-kernel+bounces-19387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61425826C39
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F2F1F226BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF8514275;
	Mon,  8 Jan 2024 11:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFrUvuu2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F4314263
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 11:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so19707245e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 03:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704712179; x=1705316979; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dCbP19Yuo6zcTY8Lt+3L+c+HrEIBgk2LF5vyBS21+bg=;
        b=kFrUvuu2Rzdgi6OCYN/nbBBP1O7L9XL5ESOJUCWNzvlrVqNksESJpwYFXxpMM4Bps7
         wOkzSHqK5XJaoW1fV5RDN0sL1pYHgml4ZwX8bEWWRbEQNH5YtvgqqVX3F71sgsiQGGXK
         i5gUqGpdoP+JUO28dqLo1aRkdsJHs5TEmLtT4wFge/Kip+TGaVImLmeXty3Jm4YpTs5T
         a5rY3df80Kl9ohVswKlLLZUnX9cKAWL11nd9aOeO0Up2Ow8ZXBvYO90W/zVFQ81LCj+l
         N59935WvwRq/CwLElfV+XinmEAXOiNwREGWZurtK/HTLQdNgDQin1/OFucWql7zdg5lY
         n0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704712179; x=1705316979;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCbP19Yuo6zcTY8Lt+3L+c+HrEIBgk2LF5vyBS21+bg=;
        b=C9xBkiT/2/fueiJ4S/kH5900IhENJ5ok7Bnw2zsqlA/dWNs8Mf730qpHXvj5nyR/HC
         qjgaLE9PQJPqf+suByWWwpaIcQMb1jxWiUjwGH5/kTzjQY1I/W5R2BO9IiQo6KWlQfs3
         Dp9Ur+TIWCOiSI/zKfK45iyZs7acQPxG7wK/jMODnEHy8vOOeUlCQpil3V4jiqbzkPhb
         5iyeKUw704zpaE689q4zJUBNIe8lHdgwfGtxbJuKl/KRwxLr+N2W/dKyLqYEa4pVVIi2
         ywFUsj7ykNmeZK1Bie3VGMk9/ELGkhBpNKzTKYd8K+lnaepkgH3x6+YhSfYSepyJ1aIU
         VsSQ==
X-Gm-Message-State: AOJu0YwPJV1li3Ph+cTLNPXrZY68t8iWgpjYTJrGP0K4bTeSzIVhwVOf
	D2cL/vLubWN6cqreY9QTRlshkB/daGQ=
X-Google-Smtp-Source: AGHT+IGTlk8WabjPz3WeNyz0wn12VXrMc6zU9iBzljVRNr7J4UoNSzDyQ/S3Bn2u5bPB43t/XYDhCQ==
X-Received: by 2002:a05:600c:3eca:b0:40e:44c2:92be with SMTP id ek10-20020a05600c3eca00b0040e44c292bemr968287wmb.143.1704712179538;
        Mon, 08 Jan 2024 03:09:39 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c351100b0040d5f466deesm10585667wmq.38.2024.01.08.03.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 03:09:38 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 12:09:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT PULL] x86/boot changes for v6.8
Message-ID: <ZZvX8fAPmSwiESj4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/boot git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2024-01-08

   # HEAD: 257ca14f4d780e27a0605fd68053d2cc3178a232 x86/boot: Remove redundant initialization of the 'delta' variable in strcmp()

x86/boot changes for v6.8:

 - Ignore NMIs during very early boot, to address kexec crashes

 - Remove redundant initialization in boot/string.c's strcmp()

 Thanks,

	Ingo

------------------>
Colin Ian King (1):
      x86/boot: Remove redundant initialization of the 'delta' variable in strcmp()

Jun'ichi Nomura (1):
      x86/boot: Ignore NMIs during very early boot


 arch/x86/boot/compressed/ident_map_64.c    | 5 +++++
 arch/x86/boot/compressed/idt_64.c          | 1 +
 arch/x86/boot/compressed/idt_handlers_64.S | 1 +
 arch/x86/boot/compressed/misc.h            | 1 +
 arch/x86/boot/string.c                     | 2 +-
 5 files changed, 9 insertions(+), 1 deletion(-)

