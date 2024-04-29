Return-Path: <linux-kernel+bounces-161854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA528B5249
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31989B207EF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F07E1427E;
	Mon, 29 Apr 2024 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wtv8N/W0"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2526B8472;
	Mon, 29 Apr 2024 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375490; cv=none; b=F3nu8NlrPU1LvJXcc8elzQrL4rwq9AnfminumfK4C9JSbOr6mjinWz9Sk99RjkKW+M7352duvh4P+eg5sHQaJ+tKcbMOvro497Fd0Mq046zNGesSOpAJ9ulVVzNtrlMNVmeYIeSQpP0ZlGVRIIFIuob4D2fJFuWgFyXsM+A9l6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375490; c=relaxed/simple;
	bh=tVNT6VbdBFtQAczG1sbEjWoUdI1HyWaEhUhOoVRw9uE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=thA3aiFsUcwLu1Jc4g5gq8xjszHGdYeTY1bUFfo6bca/Z+AkY3+jecr4EYjxYT/AG/Viz/JPZ75Qj2KqgLVzjDyGDu7ekwk+tV0g4+/o+Ja9wcwvP7bBpVl2KTasX7EniGGlPIhTSUNiA5MZB+pYRocDM4a3f3qKgh9DCA4M/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wtv8N/W0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41bf1b96aeaso8712705e9.3;
        Mon, 29 Apr 2024 00:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714375487; x=1714980287; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tVNT6VbdBFtQAczG1sbEjWoUdI1HyWaEhUhOoVRw9uE=;
        b=Wtv8N/W0siFiVD+cASyprf9tI72fm43T6SdmzWCrVdhPwPLDuimQY6PNKXtlqQZ4CC
         ff79hpf4YJ8F0+eo5K02k7Qq3BGn1pkrfu14s0/C+OlpWu+oBFLt7C47PI5wcJePx92W
         Sn2zXfllErUc3ND2TcuGSvPusTQ2fDoGODeK+23ypheQN2Ft70cWcBMhMYMUT5ACLBY6
         H9XITXfkkn46E3DhnJgDZnWHu4xOulrMwhfTiNpa4hH4N3yquBCYLrvVUzuG9EYcQBmT
         pbrGP5a8ddj/h2h2wEKMgchnf4YURf4wxKPkRV3JUjA5HJro7eBNwFXyI69rM/lG0gD9
         pItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714375487; x=1714980287;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVNT6VbdBFtQAczG1sbEjWoUdI1HyWaEhUhOoVRw9uE=;
        b=bNCMLKT95+V0jKTqcSWtkSZ04wSvciIRA70L0KPm7MgBZZ8OwR9Sm4N2gE09rxM0QZ
         Vol9RMeA8WMt0KGd335sw/eBsc0h1CeOnhVS62Dai3FK8me8m3XFfQZJFymNoSQl0U21
         tx6lbw9/vPj8mO+CE+2Kv03k/EgcpCrxd31wAqZE+w+fssk1nAp1008IN8ynDDHo26mU
         gPRLOW0M46acZrO4xkwt/zO7zNnOX+j1vGffXjNwQbW5RsgyRkB/jxE1WMdNVSChHKR9
         xDyG5+pS+wNXAUyrkjN9p57duBa4m77ZB2EkFqrQtumcAwq8mHeqX68X3ythT3HEZVKq
         wLUg==
X-Forwarded-Encrypted: i=1; AJvYcCUzraqE0vltG3elhF28nVWBAYW8Mv8/9iL21OKHqW9jaX8ktgopVBVu3uO+ROAjVtYaXnnjJWYjrk/tJUjUWA3uYBefe643e8nuQYdh
X-Gm-Message-State: AOJu0Yx8c7mTpC5cf4iXKE5Ud5LXHZJIUDN/Mamkhox9fjrr4E8EHp5W
	IwQ4NTAh+oZDpUe5BrM3gxLwRf3+J9Jj0RBxzqOfgDHFF4EEbZmO
X-Google-Smtp-Source: AGHT+IFAYkxjdJ3rEJlMSje+bXXPZJ35xi+hbv414bwaq/zTqiEhu3YMKeRNZ2oPLeHb1SfZPnXNsg==
X-Received: by 2002:a05:600c:358e:b0:41a:be63:afbc with SMTP id p14-20020a05600c358e00b0041abe63afbcmr6006255wmq.28.1714375487277;
        Mon, 29 Apr 2024 00:24:47 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c4f1000b0041a1fee2854sm29535191wmq.17.2024.04.29.00.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 00:24:47 -0700 (PDT)
Message-ID: <3f8880a7c7bf6be0458ce2ec2deedeb505c4427f.camel@gmail.com>
Subject: Re: [PATCH 0/3] iio: adc: ad799x: Fix warning generated by
 checkpatch
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: ogustavo@usp.br, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 29 Apr 2024 09:28:25 +0200
In-Reply-To: <20240428194326.2836387-1-ogustavo@usp.br>
References: <20240428194326.2836387-1-ogustavo@usp.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-04-28 at 16:43 -0300, ogustavo@usp.br wrote:
> From: Gustavo Rodrigues <ogustavo@usp.br>
>=20
> Clean code of iio:adc:ad799x to cease warning messages pointed by
> checkpatch. These include proper variable declaration 'unsigned' to=20
> 'unsigned int', add blank line and use of octal permission instead of=20
> symbolic.
>=20
> Gustavo (3):
> =C2=A0 iio: adc: ad799x: change 'unsigned' to 'unsigned int' declaration
> =C2=A0 iio: adc: ad799x.c: add blank line to avoid warning messages
> =C2=A0 iio: adc: ad799x: Prefer to use octal permission instead of symbol=
ic
>=20
> =C2=A0drivers/iio/adc/ad799x.c | 7 ++++---
> =C2=A01 file changed, 4 insertions(+), 3 deletions(-)
>=20

Patches look good. Just one note... It seems Marcelo gave some feedback on =
a
previous iterations so it looks like this should have been marked as v2?

Anyways,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>


