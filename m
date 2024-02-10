Return-Path: <linux-kernel+bounces-60242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A0B8501D6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C301F29F33
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4EC442C;
	Sat, 10 Feb 2024 01:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlIwYez/"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D828A2114;
	Sat, 10 Feb 2024 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707529548; cv=none; b=d4ERJSs7QrZwAIRT0D+gga3rPDQcvt3/o4HiER/fPJ90ltg2t+nShX4tHfQuoayITs8XWej0HQ2Vb909EqhKTi3HDFXOfaN7haGLN1BsQbG4Ehecxoe8mwUkhm89jbcXWe1etRyMYgw6H6udnAcCdkhL1E+f0r6aFrnk1kg/PIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707529548; c=relaxed/simple;
	bh=2yfvd+UOHE9k/whi9aCvesy2TCSIkYl20+/09zmCEro=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nr46huJDLh2KEHeSkdQBYmqRStkys3MUBE+t0z2mnc6Up4xkQTDOQcNxKUWzlKPG6yoPM1vWwVEW0hSGBipqiQlnq2oSYOwYv0idVVmYmZei9EwFafYiGjidWFUcdK90Qk/ntA9FSRoPIMSStxES4GORSbAZIwMb8Ak2DKbpdxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlIwYez/; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d0512f6e32so20645501fa.1;
        Fri, 09 Feb 2024 17:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707529545; x=1708134345; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4wHnI+G2KlCxMV8YeoXbiNTjvO50wKmVlXFN7Oe6Ys0=;
        b=JlIwYez/ab2GxIrEdk/ggc2hXq8dybquFkmx6YQmXidFkWknnRJfLFL29heiaCUzJe
         YsyKs8d7FfgCSWAkLYOwWpU9IC+j0iLUcj3jeAJTqQamBFSzOlt7h5Wd82O4BTTwuKUQ
         mhcKD6A6n5dxxJQWIvHVqpknWDZFyL1JSNHbW4+0w/aR58n2Mb/cg0QHN12x6sy35C12
         9zzZEziL9QCrm1Or0U4UWwNAhOL7RYqF05IwlGfq5LwlZNf6rf7Zo1e0Ygak86GBCx8a
         fHzLgpfY/umV8gGojkvFhWx6nMd0KC8TvWpWIKtoml9mU6kdQ5fJfz35VaZQzCl9Yg5Z
         FweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707529545; x=1708134345;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wHnI+G2KlCxMV8YeoXbiNTjvO50wKmVlXFN7Oe6Ys0=;
        b=vbpjLS1ZGPpdeqz7PQyY7VBdRhf8P9whnP4lPQETFU0ZoX14fLTNhattZ38xlQTq/t
         At5Fx3TaGBpfudaX4W4w1ogAVYW6tmyxGr/obbrDzZyfBGQgjDKQPal2CXMeKeX4eyQn
         WfAQK1tDOLBmSMxrd71DTa2Tpr/U89Jq+KL5Bt6Cp7m6IFMu/4D+Z0o3YEInE+btvQUv
         cMBQ5F+2YBpcrNO86ubEA7JgKm9VWrUe/bM/UEYTwGcb/Xg9S0mAqE8X9bxbWuHwyoEe
         o5y5i+bQm65nyoIGSxIotxye26WpcdMDLXsMoi69zX5WoMatJcnuAQ7kfbfML4KXXMv0
         6haQ==
X-Gm-Message-State: AOJu0YzwXI05XqslBcTxhTkDEpTwGPjBXPJeCFvGihZxxI7XHwZHgSP0
	a7bZJE3WZeALCt8tSYtVn/P0DDl/OxES8pOUkECgn6lCAx3vsQ2PEb2ZYuoxk8sk8fPL52jt4+4
	gJRBWG3V0TXwNgCWT4UlkTfhBNNKkfM935iGDGg==
X-Google-Smtp-Source: AGHT+IE9fuBzla98nLgvABcO1uL+Qyv3kwu+7GCThsKpowKw6y3w6tVIO/HFVEWPq2tRQKUYf4YL/SzcbhrvTVJp4Pk=
X-Received: by 2002:a05:651c:220d:b0:2d0:ae3d:d393 with SMTP id
 y13-20020a05651c220d00b002d0ae3dd393mr502521ljq.1.1707529544518; Fri, 09 Feb
 2024 17:45:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Fri, 9 Feb 2024 19:45:31 -0600
Message-ID: <CAH2r5mtdu3ng8E7e3h5iLYA+hcMQNjF+iwiAzh3xNw1dTnBydQ@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: CIFS <linux-cifs@vger.kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please pull the following changes since commit
54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.8-rc3-ksmbd-server-fixes

for you to fetch changes up to 108a020c64434fed4b69762879d78cd24088b4c7:

  ksmbd: free aux buffer if ksmbd_iov_pin_rsp_read fails (2024-02-07
20:23:37 -0600)

----------------------------------------------------------------
Two small ksmbd server fixes:
- one for a memory leak
- the other a minor kernel-doc fix

----------------------------------------------------------------
Fedor Pchelkin (1):
      ksmbd: free aux buffer if ksmbd_iov_pin_rsp_read fails

Yang Li (1):
      ksmbd: Add kernel-doc for ksmbd_extract_sharename() function

 fs/smb/server/misc.c    | 1 +
 fs/smb/server/smb2pdu.c | 8 ++++++--

-- 
Thanks,

Steve

