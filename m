Return-Path: <linux-kernel+bounces-21938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B838296E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46241F27D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC3B3F8FE;
	Wed, 10 Jan 2024 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wSi1/29a"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F257C3F8D9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-557bbcaa4c0so5869a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 02:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704881120; x=1705485920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaZfM1Dg8uBm0qMs8eSMEvNSG8LVqsuI0hg4ZPiM02M=;
        b=wSi1/29asj4RZjyPULcH4wNuBznNx2p5uuhlgpGSERVo8DQM4aswRUCzPrEfwl41pz
         GoLEqDwllxvt3B9oltI26qxE1hpMEOUm3wOAwSPU8VTZVn4HiOQE6hE8N5gPcNfe0RVz
         fWDcloh8ry9yB9j6UUjjLgFtKU0XYJi7BXlFvBtk19DUuSPX8lZ75o92A+pYrdOFDM2C
         r1b2lh3REd37Njd+p0sdcWCztIUyUDYl3g1axyplNRRW08IGGMgBxmSY+JIYbQnsdWqd
         FwFqFAwPwajdezG6r061laIzMXivK/yY2z86i95fp7GjnLL1wt0dYrl/Y5xW1G2wIo5j
         G1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704881120; x=1705485920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaZfM1Dg8uBm0qMs8eSMEvNSG8LVqsuI0hg4ZPiM02M=;
        b=c5l0QquA+bu4WxwTO4OGSUasH+H43RhY+Ku0jEGFwvjl/JMJOR86BR3NoVwHzGA/aM
         DjvoZeh6Vbzpvx8Vp77IS7TL8VeoCTGvoPbkWZxUKMu77bcXVX5vEuGYTILEk9MPjW/S
         HTnXlGwdqHQVlKBO7cmNMSmHG7dtctqjPtglIoUaJFofjgwdMEzs5P66Gh1x9w70BN5V
         76P3OPvtBSzcD4s3mAv4AqstVIN4LGe80OxcZ4wd6Owk5YZRo7m7M2bEgBy6UORmtbYS
         truyApZ2qGbhBqipF8EqAM9a2X3R8Vc4NbEYkS98oSCOejf9r2AdZB/sMdMz0gv23xwM
         JD1Q==
X-Gm-Message-State: AOJu0Yy9r1EZZwomaOUMuV1ICZSYrjI8b5mg3FA6vhGUl9hGdX1M1hwd
	7dv1TL4KQ3P8Fdli3yo+yiB5HnpAAHpflaFHVPFzEPhzpENx
X-Google-Smtp-Source: AGHT+IFXS1mnv33K25U11r/UWu2bQc69J940L7PG9jFV/rM28HGzQs+0tNlTaGiVj4SycXMLq/fX8dtzG67FgjezkOg=
X-Received: by 2002:a50:a40a:0:b0:554:53d0:23f1 with SMTP id
 u10-20020a50a40a000000b0055453d023f1mr178409edb.0.1704881120025; Wed, 10 Jan
 2024 02:05:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110084703.2708053-1-zhongbin@bytedance.com>
In-Reply-To: <20240110084703.2708053-1-zhongbin@bytedance.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jan 2024 11:05:06 +0100
Message-ID: <CANn89iK+tOVB=9TDAP57+C5O6bo5=1Xfd5rgxp6oB86StgmT3g@mail.gmail.com>
Subject: Re: [PATCH net] af_unix: Avoid a wakeup if data has been not arrived
To: Bin Zhong <zhongbin@bytedance.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com, 
	alexander@mihalicyn.com, dhowells@redhat.com, john.fastabend@gmail.com, 
	daan.j.demeyer@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liubo.0617@bytedance.com, 
	zhangjinshan.smile@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 9:47=E2=80=AFAM Bin Zhong <zhongbin@bytedance.com> =
wrote:
>
> In the following scenarios, unnecessary wake-up may occur.
> When a thread sends a piece of data and then immediately
> calls recv to wait for the server's data, the server, upon
> receiving this thread's data, calls back unix_write_space
> to wake up this thread.
>
> Therefore, add the filtering conditions of EPOLLIN and
> EPOLLERR in the callback function of the waiting queue in
> the unix_stream_data_wait function to reduce unnecessary
> wake-ups.

This is net-next material, and net-next is currently closed.

Also, I would rather re-use receiver_wake_function(), no need to copy paste=
 it.

Thanks !

