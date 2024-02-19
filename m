Return-Path: <linux-kernel+bounces-70630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D00D1859A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 01:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790E51F21291
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 00:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E8C7E8;
	Mon, 19 Feb 2024 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzCK3bkZ"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0835F37A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708304290; cv=none; b=bW3mEG/H3jCQuN+pxQh5byZdRaJuqmx1+pGC7IGSpe84iXfFC4LzuQFNkN2i/i4QqO1VY/7R1KO/7kioKF9LPE6fNUOzvreCCeZc+u467joYTSUspZYCrYIyE0IHpqH4o1HZSkUwpPeiA5/aXY9flkVZ1lus/bfb0FKbBMLFx3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708304290; c=relaxed/simple;
	bh=lpnq5AG7RknmRp13Z1V/TvMoNqZe9kTyc7u9Zp4lP4Q=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=K70+2fyAgXbDwacQeC3mqxeiZ4p9tmZLBVXD0Av1/wzzIySTayn0+xkdO4+XBW6xJ+n6zW0vQRlFm1fLZREsGaC5Fm+2qx3lp6gILDqVFtV1cbg5Z5xai7GQh0oYFmFyCDfz4qNk5/2r9B9im00y9XIoj+azwaNvZYwGzeu9mQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzCK3bkZ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso6067015a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 16:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708304287; x=1708909087; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpnq5AG7RknmRp13Z1V/TvMoNqZe9kTyc7u9Zp4lP4Q=;
        b=kzCK3bkZGcAQJRkgQDEmgmwMAVroTl95xMQcmagbdiS9fiN4NhBQD0lD1gCM9HLYOp
         W8w7xpEXmVvxEOCNpZPXiyjzhR/qmaSlfurW5UwD7XwQXb2HmcMl5evyAoSvdmeFe0KI
         PRgOsFGNmGp6vATe7qqG4MOjAL+yQWVSVJFbTgV7vMDomrw7K4UjO5AQVIALx44RntA6
         5rNvdRjYfa3Kl3CY9JU+BTgNbX2c9JF6S61Ew0VLhB2tT1d4zK/zBLzNa7YCjMnvN2E9
         +jpb/YI0A1gk4ZK5ijG9PqnxlAWTbTu520bmoWpHXjP1PGBr8bksJE16lSEUJKAWpSQ4
         UoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708304287; x=1708909087;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lpnq5AG7RknmRp13Z1V/TvMoNqZe9kTyc7u9Zp4lP4Q=;
        b=N1iD6j2h5Adgh9KbGrz7HHXTv/PpTAiNiu2pF/cTGyIAKVoqzg313756JRQRw5ScsO
         fw9u1QswnXluE8a+EmR/2bEKWn6XW/T9kn8HoxvAIemjJT8IPHDd1GiDPsNU5qzE3epj
         PeBdzk4YmoqiOdicd7mWsvt1KvAukaWKl91MBOz7hNvAwctKzRT858INZW0CRTSmYMZj
         qZAiLYpl8aMCW4ywgEwejYu6KQMGoR5jNqAORQZV1nDZBrWeM0ecqwgnFzFN1WUnYnfA
         N/XjPXudR+9mTLxSD9MvcziXs2TwavEyMonDTHSVCmHd2qcYwPb+0nJuAhIimx2Q/ijk
         YuNg==
X-Gm-Message-State: AOJu0YyKbhHXgFMADNQRrVYayDnDTcYPavVyH7GoWpBHIGlf3rSllrNs
	oJBbJaE9j2LA0hs+tewXiL5Eex32uAVCMui6HLn0ZxOiRw5rG23peJ4/8Tnc
X-Google-Smtp-Source: AGHT+IEPGBqvpGTrW8ZgzsjkFbYGWW07NbcxW1MH2hNpua8cWDSDaVR48dxeUC2hE0a1bp1YPGZ4bA==
X-Received: by 2002:aa7:dd11:0:b0:563:e9c9:add4 with SMTP id i17-20020aa7dd11000000b00563e9c9add4mr5265269edv.34.1708304286870;
        Sun, 18 Feb 2024 16:58:06 -0800 (PST)
Received: from [185.222.58.100] ([185.222.58.100])
        by smtp.gmail.com with ESMTPSA id g14-20020a056402428e00b005642bcfed99sm1696918edc.23.2024.02.18.16.58.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Feb 2024 16:58:06 -0800 (PST)
From: Sarenaa Fuller <zdndaba99@gmail.com>
X-Google-Original-From: Sarenaa Fuller <castillom551@outlook.com>
Message-ID: <3a9c6547ea72d6c5b6aa1a559c82fadd334775a8f7afb5882c5a470a90bcb158@mx.google.com>
Reply-To: sarenaa.fuller@outlook.com
To: linux-kernel@vger.kernel.org
Subject: Acoustic Instrument
Date: Mon, 19 Feb 2024 01:58:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I'm giving out my late husband's Yamaha Baby Grand Piano to any passionate instrument lover. Let me know if you are interested or have someone who would like to have the instrument.

Thanks,
Sarenaa Fuller

