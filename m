Return-Path: <linux-kernel+bounces-153542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE028ACF6A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF4D283DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5016E1514F5;
	Mon, 22 Apr 2024 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="j4j17g1H"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA6535894
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796219; cv=none; b=p2lZvvRbJ40/f4qiDTvswmbm8P+BofCi3QBuPkbEgRKwLP3VV5umBa/5mEVZO5L+6+pMRuEsLudkGYvcpsVsoJQm4Th5zpZ2mxyYSCgnIUxgy4q+2Q5MYU/j9r5QkzODBiQ60XTkM/3z4zuf6PR6hvN3xUOHfgKpzzqppnq9qSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796219; c=relaxed/simple;
	bh=tXVlXPB/PSJki1/C2jbfu4JVsjrCQd7KwrdY5slbJl8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Cq2rtaI51qI3PAnIgYK7F/j1uph6lepN6JJWBMLssmUxcaywwKVQln9IZwmgtPt93GNDxf4z+SvMdhY8d7MnVnKUdQpkORsW/Js4rislQpRnOJzXDhi7+FvDGfWlYjr4RWVZ10IofNU7pypulai0fL2klWs9pKNG2C4hM8X+pYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=j4j17g1H; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso6345823a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1713796216; x=1714401016; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXVlXPB/PSJki1/C2jbfu4JVsjrCQd7KwrdY5slbJl8=;
        b=j4j17g1H7fCdz+OZydVy0cwDMEF9e6X2lKg/m5B2ysZorrXRghNWxpTt45Ja1fevJe
         TVYn92cAFb3Pz+vSR+CxeD5w6NLRO2OBaBQGz0aBEDLyqB4kBazb+X3R8yW2SdIOlojo
         3KKqW3FZuUwRqPKTjiHPVNluasYimKmgoQxAaTAQf0tI5R3GOWHC5jRDXGkkNq1IcJcy
         WRRi2j6Ht6Z35b2Dt88+jGPv/fGipxWRZhKyV2A6JrkZiObi2teNEb/Vz9tI5GDsnyw5
         2s2iM12bajfL9IaZmE/8LyTQvzjR+fFZ2Aa0ojZr7VXiBzgCIeE7eopPWedwbtKw+omD
         V+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713796216; x=1714401016;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXVlXPB/PSJki1/C2jbfu4JVsjrCQd7KwrdY5slbJl8=;
        b=ipDfs8wd77QV0Xp8Yh34oR5q3VU8j8ToMvBZPJqrRA1HppxwycYk2T+HHC6EkjV8N5
         zIv/a2F6yKt6MtElRHMUF7RRaqo7YBZE9bjXun+pd1ADtAiQbWrNqNE28v+J0G/89WKl
         9521kXCXmejIplkJGoRWFp7sNifL9kNuNE+8LAFy5J5+z6oMJH1sTnuJcVY83jvvk7hk
         MFG0Bf0auOCO87mHGrkW8H+DuTya5kyfCLSRbpGF4XP5ZcD0IeQKV2rjyB6vJoKOp94O
         8ECRCr7NFCmWo79u61AU2Ddxt7PHZc/WIKR99eiTviRwBHNnOoTWQCGU0nAzrXF1OA6v
         vgCA==
X-Forwarded-Encrypted: i=1; AJvYcCUouKp1qOtVJCLqrAxMfMGUgDdkiArDWkka1sPzWCu1rrhH76WK3mMrYDDI/rUNrGVxpC9RTXSkEemY3dm+0Oa1wW0mzAEnHJWveEkh
X-Gm-Message-State: AOJu0Yy83uEniWVCVv75LCR30TzoOZvUBt0oHtOulAk1/MFYOnMOyiyg
	MefkmMUl3d/eFvXzUYgHBSszARdCBPjyWh5eTqJrs4HoDA0+k1YYQzkyVTYnl5E=
X-Google-Smtp-Source: AGHT+IEbqojyvQXmqJAvwwpw4d9QKzh2sZsy8S2+Q0SK1s0wZBZgoKfYw8rOADqD/u+Jkier6TXDAQ==
X-Received: by 2002:a17:907:9448:b0:a58:7298:fdfe with SMTP id dl8-20020a170907944800b00a587298fdfemr408810ejc.53.1713796216287;
        Mon, 22 Apr 2024 07:30:16 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10c6:ce01:7d:af2:ac50:1252])
        by smtp.gmail.com with ESMTPSA id h3-20020a170906260300b00a559965b896sm3197077ejc.202.2024.04.22.07.30.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2024 07:30:15 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] bitops: Change function return types from long to int
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <42e6a510-9000-44a4-b6bf-2bca9cf74d5e@linux.intel.com>
Date: Mon, 22 Apr 2024 16:30:03 +0200
Cc: Arnd Bergmann <arnd@arndb.de>,
 Xiao Wang <xiao.w.wang@intel.com>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Youling Tang <tangyouling@loongson.cn>,
 Tiezhu Yang <yangtiezhu@loongson.cn>,
 Jinyang He <hejinyang@loongson.cn>,
 linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C0856D2E-53FF-45EB-B0F9-D4F836C7222C@toblux.com>
References: <20240420223836.241472-1-thorsten.blum@toblux.com>
 <42e6a510-9000-44a4-b6bf-2bca9cf74d5e@linux.intel.com>
To: =?utf-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 22. Apr 2024, at 09:44, Amadeusz S=C5=82awi=C5=84ski =
<amadeuszx.slawinski@linux.intel.com> wrote:
>=20
> I don't mind the idea, but in the past I've send some patches trying =
to align some arch specific implementations with asm-generic ones. Now =
you are changing only asm-generic implementation and leaving arch =
specific ones untouched (that's probably why you see no size change on =
some of them).

I would submit architecture-specific changes in another patch set to =
keep it
simple and to be able to review each arch separately.=

