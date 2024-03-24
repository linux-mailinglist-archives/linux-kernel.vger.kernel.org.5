Return-Path: <linux-kernel+bounces-112550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3405887B6C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9A91F22173
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 02:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C98128FA;
	Sun, 24 Mar 2024 02:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWEnTBrL"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3750181E;
	Sun, 24 Mar 2024 02:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711246697; cv=none; b=Ke2KTxSdPWQnnoejH5Ni2Eo28/sXoXfbBH0/XYI01JLqmIuv7L8pocA0lHnDefK6ET8FNNnjuYFIc08jb4lgm7Z8/E9D/cDXaO6yWuW+NTj51vp0ocvMGttNSqgP3lmOytM409lKC/LhRTJj2bkeoZN+cfLpj65pM1zVIm0Sz+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711246697; c=relaxed/simple;
	bh=yg2Hm/IVogTNhzTU6kYBtYGgvcIfGxbzMCVal4KJTBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGSCj5NiIE+nlC+/C/o4l+msEpKttEnm2B5v1INS4lfpBhnvd0Joltm6luzp7O0/9+16Cu1zF+xg5NLGDW2BLp3mwXumhQSn7Vu4++lo67NJMmpjL/FRybDTw4hRxJRZGAN02KpwiEZhj+EUHcVAzwyR0vTKQkuTrOuomqnfvL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWEnTBrL; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42f52226f9bso14309921cf.3;
        Sat, 23 Mar 2024 19:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711246695; x=1711851495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCmO03+9RwSrIzYMZH8CI854XN/NKy5dCm9nFGp2TmQ=;
        b=NWEnTBrL4GE44uG5IZM46qwETZqc2cMPOyeBvXaX3SibRgKtP/W21lkapksc21p6iL
         BO1BAW/B1Csz/td5htpoBeE3R00XF+gL9fTPTxL/pev5ZFLNc0KbygdNU/iIpWJ0EHtA
         eIWyTl+0o9sjhUh+sCZv3KBIGB4FnwjaE93L7xZTjrvn5X+dCsn6NlGJ/ESzticoAaJE
         jqT5gw8SzoDho/zfAWC6g34Gdk/mNH9KoG0u2EVHV7VmaQ4g1bmtL1yuF5q5Z10a/zQu
         4USbST/bej0bljKmgcK4ZDvCwSwhyLf5lCZgJ1dBWY/sLTVtz0OpToaXTU50A4JvgbVK
         WbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711246695; x=1711851495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCmO03+9RwSrIzYMZH8CI854XN/NKy5dCm9nFGp2TmQ=;
        b=qSGE56Zyc9ZLHJ7gXR+PW7Zyhu6x+JVqBRfvJzfVv4jE8yDue6ZVepwyFkCy2mKKTB
         j5Brs+FpZySv/IU6JwqIq7+dwVBinH/dCrWfzJ6rfLdtx7rQfw+6MP5ZqGPXh0C2KHmH
         yVJDWDchHzyOfBwiuPP1G/uX7hW7jepTtIFKF0HRgvEfKpxN9sSfsV3orM8yt73eRUM+
         CA/SeWRAc+idNhpHzvNjO3Di7kuvyk3MEHlRmwE8QWj1/dMxELQhAWMpu6UB3Ep5L2ad
         z2dcu6K5akC2BdUZT4/V840TtA5xJs0dvuQItMYlPfJ/MhYvTFkGkBDHqBMTkhtut6+l
         YT2A==
X-Forwarded-Encrypted: i=1; AJvYcCV8q7H8jsB675kYUSd/5T1VTLqlTZAK2dTAhEfUOJgFg+pjlbW5C0/H7gMdV/fOGYZm4O/uJBrFG3a1sGTwHPEtD0RXj/WfLrcwxhjNDBu97EVMy0KjudMF4ce+AyJkya66NFKlpgYpGpOnwhpkVXq05t0X7czZmHyfR83ReA==
X-Gm-Message-State: AOJu0YwumM5NZ11hduNeNWJIQuD/HzRlB460To42JEJqBPbP7ebsD1+b
	OFH8g5xfxCN9BOs3eZdIQJrna/2r03geM/tgx/IK4RqJtbyQ6kfF
X-Google-Smtp-Source: AGHT+IGh/jWvNaLRJjSPNs9Rwcwu8fSVukUF2Zz0KdTMlUOdm3xrgN6zskrs7VdYu1qupJisaB0fPw==
X-Received: by 2002:a05:622a:14d1:b0:431:1b29:58e9 with SMTP id u17-20020a05622a14d100b004311b2958e9mr5189035qtx.68.1711246694960;
        Sat, 23 Mar 2024 19:18:14 -0700 (PDT)
Received: from l1441l.lan0.xorvpn.com (pool-98-116-41-146.nycmny.fios.verizon.net. [98.116.41.146])
        by smtp.gmail.com with ESMTPSA id bc13-20020a05622a1ccd00b004309b22265asm1266241qtb.75.2024.03.23.19.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Mar 2024 19:18:14 -0700 (PDT)
From: Daniel Hodges <hodges.daniel.scott@gmail.com>
To: andrew@lunn.ch
Cc: ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	hodges.daniel.scott@gmail.com,
	lee@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	pavel@ucw.cz
Subject: Re: [PATCH 1/3] leds: trigger: legtrig-bpf: Add ledtrig-bpf module
Date: Sat, 23 Mar 2024 22:15:01 -0400
Message-ID: <20240324021811.20794-1-hodges.daniel.scott@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <a9662071-8050-46b7-8416-d440d45bbb52@lunn.ch>
References: <a9662071-8050-46b7-8416-d440d45bbb52@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


> On Fri, Mar 22, 2024 at 10:08:14AM -0400, Daniel Hodges wrote:
> > This patch adds a led trigger that interfaces with the bpf subsystem. It
> > allows for BPF programs to control LED activity through calling bpf
> > kfuncs. This functionality is useful in giving users a physical
> > indication that a BPF program has performed an operation such as
> > handling a packet or probe point.
>
> Don't you want a mechanism to say which LED it should blink? Say you
> have a BPF IR receiver, a BPF kernel scheduler and a BPF firewall. All
> sharing the same LED is probably not what you want. Each probably
> wants its own LED.
>
>       Andrew

Yeah, I think that makes sense. I guess the idea with this patch set was
more or less to show the simple implementation. Since there can be
multiple devices the trigger probably needs a registry of the active
led_classdev names or other id. Alexei mentioned the xt_led which looks
like it is rather similar as well. I can give this another shot, but I
didn't want to go too far down the rabbit hole without getting some
signal on the idea in general.

PS Sorry to folks if I've directly replied to your comments. I'm still in the
process of setting up my email workflow.

- Daniel

