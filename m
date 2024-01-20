Return-Path: <linux-kernel+bounces-31845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5FF833565
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 17:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E26B1F23EE9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 16:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD68125DA;
	Sat, 20 Jan 2024 16:59:20 +0000 (UTC)
Received: from herc.mirbsd.org (bonn.mirbsd.org [217.91.129.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EB811CB8;
	Sat, 20 Jan 2024 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.91.129.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705769960; cv=none; b=QEtMxh3f+qzRr3n1d4PbIooXqMI3w+vfY9uAJ108SC/RJzyvKAh4iLodKyC/QQOLgXRLu4H9mVWPhRrdvFEyhJh8BtOgAbb+9cAWpnUfBb9rRAcJFgND+LI8FBTdR2MmdGsgCSpEcVYdzwYsjkzUR5aKlK2RCxM34lVzJB3wX1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705769960; c=relaxed/simple;
	bh=mcgaKURmL9F6jjTf6Z9hy0c8RLlgbiLypHejja7LIp0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MFXQItjQbK0f8ZwZNVp4NujbDVy/5OalJu5bUWIx29MyBlXIBT2hTNCl1fdDn2S+ZV085lfuU73wpTUmr07Agxb7FqSplgPn3GmHRtB5EHRpDA0orUt86Y2uNLlyZOlkgiVUbuHI7Wq2dn75yogXXIgOIbTErtEXUEYULEK0lxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=217.91.129.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
	by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 40KGrTrJ002418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 20 Jan 2024 16:53:36 GMT
Date: Sat, 20 Jan 2024 16:53:28 +0000 (UTC)
From: Thorsten Glaser <tg@debian.org>
X-X-Sender: tg@herc.mirbsd.org
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, rostedt@goodmis.org,
        torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, jpoimboe@redhat.com,
        alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: Re: [PATCH 1/2] x86: Remove dynamic NOP selection
In-Reply-To: <CE53F232-3D2D-4910-94B4-A4304F5990C7@zytor.com>
Message-ID: <Pine.BSM.4.64L.2401201652490.29203@herc.mirbsd.org>
References: <20210312113253.305040674@infradead.org> <20210312115749.065275711@infradead.org>
 <Pine.BSM.4.64L.2401200654480.19429@herc.mirbsd.org>
 <CE53F232-3D2D-4910-94B4-A4304F5990C7@zytor.com>
Content-Language: de-Zsym-DE-1901-u-em-text-rg-denw-tz-utc, en-Zsym-GB-u-cu-eur-em-text-fw-mon-hc-h23-ms-metric-mu-celsius-rg-denw-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

H. Peter Anvin dixit:

>%eiz was something that binutils used to put in when disassembling
>certain redundant encodings with SIB at some point.

Ah, fair enough. Maybe this could be added as one more line in
the comment or something.

Thanks,
//mirabilos
--=20
15:41=E2=8E=9C<Lo-lan-do:#fusionforge> Somebody write a testsuite for hello=
world :-)

