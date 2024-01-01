Return-Path: <linux-kernel+bounces-13928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F858214F2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 19:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31B71C20E0E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B667BCA43;
	Mon,  1 Jan 2024 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="sHQxvYRD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC74CC8EE
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbd1fab03cso3071338b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 10:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704132884; x=1704737684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RbKb+Ssey02t/EjSEFx36sx2rnp4+NFSDQiVDQTJ2g=;
        b=sHQxvYRDfUWt2PQTe1Ex3obVPKvfT3N7G6cFZNgR/JpeF+aYtCNe4kJuyya8LbtlaV
         pgTwiCDQkmRrqlp4wqIH1wYc79EGWz/v/w2am5bgtPw+0dF+dNw2dp+pJ7uAvxCo/YKM
         opUGcPkwpY1pBmr79au0b9GdqeStDOKJIqe+vN/DC9OhrCgqMYfAw60kOub+WGzIC2nh
         xBIpKGWpcJezGypuLv2uAzAsLcI76C3t0iMeA3IJEOzBlUjJf6fDNmAXa61Jc7yZDg8h
         F3POfoyf3/8GWQYBRU57rObfkOl0+B7+GW6p6ubMwR5QMuzqfV5Xc89fmNVhgincNCLb
         2UHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704132884; x=1704737684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RbKb+Ssey02t/EjSEFx36sx2rnp4+NFSDQiVDQTJ2g=;
        b=R0U1ouiredQDvOE7VfnHqWP849pLYuupEhUHXcwOlqzc88UeZa4Jm1e/u6iYEY4ZcW
         wFBnnuGeAKOAOiaNYRi6SjE6o3naGWGPJObfawJNIs/UglpzhuA9/LuL9lMAs7vZ0/mR
         fhLvzKWl4Se5FsXyLlfy/58jgs/ybHyYejDsg3716r55usdyceNAKiKt0feL6VCwOJHw
         S7nfYIAQ3IwZ8S2qio1wUnKaDasa2kRE7H9pKY8HsHv87+MjbRl+Hq0bFTSBgkrIQqg5
         z8kRmml0QjAdUHe62HIS6xA7B4AsK4K6NoLhTCqVzna7/EFbKZnV2JDUvg6Ch0/godtl
         2mXg==
X-Gm-Message-State: AOJu0Yy3ntb24PufW8za3HETFJqFGabGOmvGvqlZNYTmnvZFemJpy1X/
	bLs129dVBeh47qDPRBl1myIFAjcw9gKqWg==
X-Google-Smtp-Source: AGHT+IFGe/SVgUx8wqoEmP9kgAuUxnfl6a77Ua3dKecNfiDTHuUXFt0Eo0igJA3P8vcpyL+g3J40hQ==
X-Received: by 2002:a05:6808:23d2:b0:3bb:c394:fd52 with SMTP id bq18-20020a05680823d200b003bbc394fd52mr11468601oib.105.1704132883889;
        Mon, 01 Jan 2024 10:14:43 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id a23-20020a62bd17000000b006da19433468sm7706526pff.61.2024.01.01.10.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 10:14:43 -0800 (PST)
Date: Mon, 1 Jan 2024 10:14:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, Anjali Kulkarni
 <anjali.k.kulkarni@oracle.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] netlink: Move an assignment for the variable
 =?UTF-8?B?4oCcc2vigJ0=?= in __netlink_kernel_create()
Message-ID: <20240101101441.2af52a45@hermes.local>
In-Reply-To: <223a61e9-f826-4f37-b514-ca6ed53b1269@web.de>
References: <90679f69-951c-47b3-b86f-75fd9fde3da3@web.de>
	<223a61e9-f826-4f37-b514-ca6ed53b1269@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 31 Dec 2023 18:44:13 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 31 Dec 2023 17:36:50 +0100
>=20
> Move one assignment for the variable =E2=80=9Csk=E2=80=9D closer to the p=
lace
> where this pointer is used.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

NAK
Useless churn of source code.
If compiler will do this kind of optimization itself.

