Return-Path: <linux-kernel+bounces-97921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DADD98771A5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 15:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AC4281BBD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AF94085B;
	Sat,  9 Mar 2024 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEdfjgJz"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAE179DB;
	Sat,  9 Mar 2024 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709994939; cv=none; b=rk/zkWtPfPD8eYwtvh7gMQRy7ShcyE5d9LIEU9sUI7e3vAIciCL2c1LMRDw2Igfshqp+noXlOXVTVtELv10Y2JkAQ8chMm6pdk1SkA1BjJSAu3JV7lkHP2bTLFd3oJIQe8wy/1Arr4BODBO0U4s1dWmwFQz4cGKOq/vX7VcMZrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709994939; c=relaxed/simple;
	bh=mSza4iOytjVLxXi6SLmDuhaU2hR2OR/H38250DvmSe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+Ndy6XzGzA7Ow2q/L6WoSQYGntrxEry+FPLdIsMoHNcrd27qpS291fSGh7VMREaePRC+MG9fdOFTK2bCOGZzIcNLk5GYvLm1DDwxeQKtvGM0WbRfpNhKdNCYNljXNnBPGEuiOfi/uB1TM1m7Ry7p+Hm/MPtnMZN4szmutPBmBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEdfjgJz; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cdbc42f5efso977814a12.0;
        Sat, 09 Mar 2024 06:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709994937; x=1710599737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGeJHmUEIM47cK5w9juU4FyPz0ck0NABGFt8OlE9jyE=;
        b=MEdfjgJz4FtqOrpy2J8x8xmGIYFL8r0ZDk6n4o3WieO0IHzTryUTxQT6iCtslpvBX4
         m1kH3VSBl1UBGnVogWN2bUr3+4SUvcYHbiA0AZgUSduJuwXwxf3pARBSvWE2tUFFVS5i
         bN1Al/KX61l7J13dVUxxgNSzs/dofwar8Ia6CJPd4sAYii/tHvBz79BeEw1cgsgONbjC
         NrIGdwcoGDr+ckxPV/w6+R4GTq5oCIHOJoHbuA1HBTn/oD7zFarplZEpGGc8AMfPpvi0
         5nIYbMXPG1i4yAzdxusGPeAWl58Oe6J8hxYELNI2Ygrhs/9X0lQYPh1etnpVrlGmzRJk
         Y0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709994937; x=1710599737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGeJHmUEIM47cK5w9juU4FyPz0ck0NABGFt8OlE9jyE=;
        b=fE5gl/5PVRXuqV5OyVJB8HHic2JttrZAgDwX4OOGNMjuAidZRdeatG26QcJ64xsMoj
         /bHRHVdlAqpgva9RI8N/3pZUQbrEBl/mGSSM9zA7t99An+N+8mOEANOT4gqnAJ1YoCAt
         Tv8GSx/kHv55QPenDEFMPDvdqHh1eAT/E4DayWysmUqZW8Oomdy8hu7iiKm2hdnCKHlH
         30K/Hrlh1vyD8tUdGCy+y81qm964FZ9VI1HWmowqDURX0KLbJ23ZFib4UsTKg5N4gU46
         I1fMjOWyHLVPeZ9mxQCysdvCp3R2Ow/PVgn8OYMEZ/48H3wnqD1pcmglKPaYpAMgxknI
         Nljw==
X-Forwarded-Encrypted: i=1; AJvYcCV/zf0uBSNll0TTQHdkEHbb+zYhTXhSqgc5qZjolk2ufxXX3aHx3SwKmLNCw8hgq2rH6fytTohAEppP9Qp3k5BXjYZGpMu8UZdDECBePA10cXYhvUg0BED2Cwqir0q2UCtWDar2JZPw0Eg4G/to7bM2Ulx0M4S9zTYQh1B74MfoN9f7Rg==
X-Gm-Message-State: AOJu0Yw0Fz2YtFfA3IpkEJV0VpziCzKgUcJI+Nivubwy9VRn4vdUlxDN
	amd6hbTIjTc2prmZ2QbOySfj5Z73RAnY9qKoQeMxP31KG458mlinyPYm0+gLQG4Fx4Dq/FFk3Al
	PKW11UqwIvGLa+5FSbSuj0QiI/S0=
X-Google-Smtp-Source: AGHT+IHl9mwhNM09rCVBv6EiNhdw8kU/qp3+kPYyETGkNPMYN4XuZapUQZzMikj41LcRoyuMQ5t3VWlMOBB+Fp0BT/s=
X-Received: by 2002:a05:6a20:438d:b0:1a1:85ef:8bba with SMTP id
 i13-20020a056a20438d00b001a185ef8bbamr3226640pzl.0.1709994937552; Sat, 09 Mar
 2024 06:35:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <81e42a64-03c5-4372-914d-9f2df517dcf7@linaro.org> <20240309134810.352428-1-animeshagarwal28@gmail.com>
In-Reply-To: <20240309134810.352428-1-animeshagarwal28@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Mar 2024 11:35:26 -0300
Message-ID: <CAOMZO5BBWmbKBJQS48R6Lfa4ua=vhdseHd0vSC+t+OOZ3QHHUg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: imx-pata: Convert to dtschema
To: Animesh <animeshagarwal28@gmail.com>
Cc: dlemoal@kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, linux-ide@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 9, 2024 at 10:48=E2=80=AFAM Animesh <animeshagarwal28@gmail.com=
> wrote:

> +properties:
> +  compatible:
> +    contains:
> +      const: fsl,imx27-pata

You haven't documented fsl,imx51-pata.

> +examples:
> +  - |
> +    pata: pata@83fe0000 {
> +        compatible =3D "fsl,imx51-pata", "fsl,imx27-pata";

but it is present here...

