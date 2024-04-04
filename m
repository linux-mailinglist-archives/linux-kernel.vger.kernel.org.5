Return-Path: <linux-kernel+bounces-131039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C53989824A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7611C211B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443A15B208;
	Thu,  4 Apr 2024 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="a4tz1Cif"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D9E59158
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712216115; cv=none; b=KGkV6vQAUjKvdaZzv+Pur2y3l0Srz77Cd98EaRK1OvBoCzyWLcZ6f5p8mo53rDc6xcqDzNNFL4rb+ineAe8bsz4A0Wtifi1EC/JYaw92A+B5LlF2Ot9YAmFe/ENRCV6/IRUTIhdevorJHrXQNvC0HguWHHh2QlpgdmMvjcpk2ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712216115; c=relaxed/simple;
	bh=vWKvMG5nll0mvlIt/xmKLo6WV+d8fUQ4sGFwg8zKV6k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JvxKrpp6eeEBn2O3ZxB/aOrdZI6xJA/7HI4BQuBYGRyvFS9Q7pGJOK4j/Zu82HM7L0CHvM6HjYQrEE/1xLpXaSPg449973PKRfZhk5sNENk2h8cd5ISWANJMa8YQKvgs5MeJVCS1cACyOXGFQZTD3j5wO83C6RLh2d1INquuIWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=a4tz1Cif; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e0f359240so792090a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 00:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712216112; x=1712820912; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWKvMG5nll0mvlIt/xmKLo6WV+d8fUQ4sGFwg8zKV6k=;
        b=a4tz1CifqAJOpiTLxDuz3qXRR4A1T8Rkl5B2MjuvzXA7qi10gV2h8rDBaKrf2ilRPE
         aY9Ny54mjgDHqXG5FmSQmcUEHm/YA/OimcMTM1lHWkYGhx9TqvjhDwU+CTvyhsTTvI5O
         sTrmKP+ueaWnkxvIv+OIzqA220vzEq7N0sJBlnQwri0ahZ7vwljKzLCTi4hAzg+P7LP9
         rCuIN76EpSsUarpgatNqdy5TLW9w8iJYcq4M3GjDXbdbcKb+OYdOCTUcWDVNoy5TNP1k
         dbyBEBDJRkhZoBldWpVdfz+FHUR9HmgwVinoOdzCdme5IIyPiXzVLXb8s1djvXTw5V8c
         IU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712216112; x=1712820912;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vWKvMG5nll0mvlIt/xmKLo6WV+d8fUQ4sGFwg8zKV6k=;
        b=kq881K9LCavOBvKgXDXrFoLNGnnvjIRbOh0Yxy+1ZgHUQzxopOMxNAZoVmhw1anGlA
         AZqLSKUxngQ1o35vnuZGEj7Y3GcPxxtYSlntnIZroFo0Oy+IfLP1hWBcGQ5gmrStgAy+
         jM1BElC0J6kgMYS2+J09zWld+xlgFvJeeIaJrwJQd5wwBFIdQ1tyMG4+60/QlSbjqA6d
         mlwhUSL6isHkn70b2828SlD1mF/RoUKoWHeEvaUQ2rrKKJVrPCv8BafVQAnqMkLBfw4i
         CsNjctN0inG7wUsYZOm82w91rllqJbQf0O/rFU0VPhF3Z/2WbvPqMw7mAQu/7ucfGLY3
         tJtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXORp7fVxwgWvogwZ31LipcTJX7N0yaIOdkDcUUvemaMx+U0+XlOD45FUsUNjvU3O8/MlEUyOWXk4i+QPqP+jIzAPTKQZooW/3BMtcj
X-Gm-Message-State: AOJu0YxIUnZC1gX8gb4ZkRq//20cd4qYeskIAl4Ky14RUM64uH5LOPAQ
	DT2LHGMuDgJHaykeEqEqZoCgYDeYikdT46/DdjysWXNifJhsCycwubqr9IVVTSY=
X-Google-Smtp-Source: AGHT+IEs49zMfmH2sVmwNlmROvRsDtq87Gu5eHxnW8hC6UVJYcainOOIhzAYAuHs2emnZEAbAd9Mcg==
X-Received: by 2002:a17:906:dc1:b0:a4f:a291:cca2 with SMTP id p1-20020a1709060dc100b00a4fa291cca2mr902396eji.31.1712216112153;
        Thu, 04 Apr 2024 00:35:12 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10c6:ce01:4985:35a2:f58b:acb7])
        by smtp.gmail.com with ESMTPSA id i15-20020a170906090f00b00a4e5866448bsm5695791ejd.155.2024.04.04.00.35.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2024 00:35:11 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH] tty: xtensa/iss: Use umin() to fix Coccinelle warning
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <fba2102e-aefc-4be4-905a-57061c1f8cce@kernel.org>
Date: Thu, 4 Apr 2024 09:35:00 +0200
Cc: Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BE4C9D9E-195A-4997-B04D-CC85C6EFDA6F@toblux.com>
References: <20240403234729.175168-2-thorsten.blum@toblux.com>
 <fba2102e-aefc-4be4-905a-57061c1f8cce@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 4. Apr 2024, at 07:05, Jiri Slaby <jirislaby@kernel.org> wrote:
>=20
> The cast to unsigned (ie. umin()) is now not necessary. You should =
have used min() as was suggested, right?

Yes, umin() was only necessary before I casted len from int to size_t.

I'll submit a v2 shortly.

Thanks,
Thorsten=

