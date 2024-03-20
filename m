Return-Path: <linux-kernel+bounces-109169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACC08815A8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469112825E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EED654FB7;
	Wed, 20 Mar 2024 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="VkiZxpiK"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E7F55C1A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952215; cv=none; b=ABkNepDCl8NrEfmiENWelmZH+Zd621hGaZH/7Wi8dOvCup4b+03MsuscxHfkUKpMieStNdpg7kdUroGhgplmOVBRJ/bZseTWDsTdlUyCuxBKaFa2JWXsXmjbSYMSgw+nl0DO/S8yaJcsCWye1lHFXc5S0LiE8mbwDZGtzwAeluc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952215; c=relaxed/simple;
	bh=fUUFMvg12Muu5FflNc842GDP64XjwobWVbannxmzVAw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bHdcOkQVbGyRTKs1DA+mZRs4Zca9pF4szajG6EwrYQ2q5xtp7NiX+cb8wQeSUM5WrATNcMy3XgcWHYx/hFQy87Blm5SPoPOKE8slf/oMPvWyt9swmXyFMmx+RQg34GvCv+jxRkSs7wN5qcccbzt5Xtc85VmVjDu1WXf4dzsc1mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=VkiZxpiK; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5688eaf1165so10128857a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1710952212; x=1711557012; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0X7F8ZndwwFM/qfksRMIkR+4ps9Ffpk0s/ETQfTpx4=;
        b=VkiZxpiKnV7DiLonc0jWIvzjHVMD2FIER6xNVrZG/JCvzoRxdRoTbp3jTdT9M0kzKJ
         gh/SJwThnWy58MuA5r3vGieFzjpTnqsKrzYqKpNvZquaopg72p/x/wnlufLR/WUJSP0f
         4Opc0kOGvks1UWuIv4M4Iy10Dw7nneqbGZ/ZtRrv1sR9bo0x1t2B+Z+Npn/uGYP6d/YM
         VzjXxO0IE83+TQndLHdmPhJgAIaqT3E2+lZ0aJ70KIn+Mt6JjD55D/zwpqAYIcGxj7DD
         rO9NZ/rcDDsBz5VHuyVJ/3HHlgIa1Wzgth5ozLSL787u6cvghnhS/oQFJ24kPBgqSfS7
         B9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710952212; x=1711557012;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0X7F8ZndwwFM/qfksRMIkR+4ps9Ffpk0s/ETQfTpx4=;
        b=E42xW8ZS/tpp7uEum1swtuD/fdKAe0Da6MVM47eWUC3Tg5r9GNfGzk6cAyQvm1Gz/V
         pcR6rwS7HggntOJAbg8dVDqSpT9/qaJcVuABLM74/2qRySMC1/verSdQiG1S3CP38FH3
         9FaHqAmaSj6Vy01pQIN7MikvTOAKP4UZ8x0vv5olQQ3ovzGsy9dEstiEpuDD3FNL0kN4
         0tu4Rx+ytPJPodqWY96KZEy3imNYOUzjJ4E/WBDQgNlD/hRvBi+/jpcSOu5MYUTccEAb
         H/MbMJMuRwJv4LC6i65VerhNeE4OuKrQAyq5yYl3PK4D0vzboH6XMyLsOIz2g1dPoexs
         HdYg==
X-Forwarded-Encrypted: i=1; AJvYcCUtJYC2VBBlKmRjQRz2PB+Y2ooyM+TGKKn8UjOey8ncCL2Tq/tFWXHGSn2yZkJC5Qg1hCta3Y2PJWUvpDhNEEJMV941AZaMbeNt4SEs
X-Gm-Message-State: AOJu0YxrcQhNIoVJuJgx1DXwQgDltTa6zVb5j6gBSU+r7lxWujXs5ZpI
	EcClxKxYt8Q9gADs5+UmcSXeyiC1TWC12+qGYYnI21IJbuflZv+XWXyof+Arks0=
X-Google-Smtp-Source: AGHT+IHsoD21j6ESUUF1khZHhnTDSCPP4x5//7u0Ai/223kW4lGWbdm1Xxg/oXN0xx9+KTFi4A1uuw==
X-Received: by 2002:a17:906:264e:b0:a46:c11d:dd05 with SMTP id i14-20020a170906264e00b00a46c11ddd05mr4621131ejc.57.1710952212367;
        Wed, 20 Mar 2024 09:30:12 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10c6:ce01:6198:fd02:45af:2ca2])
        by smtp.gmail.com with ESMTPSA id vi2-20020a170907d40200b00a45c8b6e965sm7471416ejc.3.2024.03.20.09.30.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2024 09:30:12 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] tracing: Explicitly cast divisor to fix Coccinelle
 warning
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <EAA3D15D-F96D-48AC-B9C0-B2290E1B38AA@toblux.com>
Date: Wed, 20 Mar 2024 17:30:00 +0100
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E5A47C3-E9DD-4FD2-BDC4-BED67EF791F2@toblux.com>
References: <20240318105243.117911-2-thorsten.blum@toblux.com>
 <20240320192715.22eeeba84c0fd3a8c2353c79@kernel.org>
 <EAA3D15D-F96D-48AC-B9C0-B2290E1B38AA@toblux.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 20. Mar 2024, at 16:01, Thorsten Blum <thorsten.blum@toblux.com> =
wrote:
>=20
> Coccinelle also finds this one, but please ignore this patch as I just =
realized
> this was already fixed in another patch of mine from February.
>=20
> Sorry for the inconvenience.
>=20
> Link: =
https://lore.kernel.org/linux-kernel/20240225164507.232942-2-thorsten.blum=
@toblux.com/

Actually, I will submit a new patch to revert

	delta =3D div64_u64(delta, bm_cnt);

back to

	do_div(delta, bm_cnt);

but this time include an explicit cast to u32

	do_div(delta, (u32)bm_cnt);

to remove the Coccinelle warning reported by do_div.cocci and to improve
performance.

The do_div() macro does a 64-by-32 division which is faster than the =
64-by-64=20
division done by div64_u64(). Casting the divisor bm_cnt to u32 is safe =
since=20
we return early from trace_do_benchmark() if bm_cnt > UINT_MAX =
(something I=20
missed in d6cb38e10810).

This approach is already used when calculating the standard deviation:

	do_div(stddev, (u32)bm_cnt);
	do_div(stddev, (u32)bm_cnt - 1);

Thanks,
Thorsten=

