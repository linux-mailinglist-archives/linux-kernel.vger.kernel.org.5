Return-Path: <linux-kernel+bounces-13924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB478214E8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 19:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6B11C20DB9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 18:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02F0C146;
	Mon,  1 Jan 2024 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Les3QTOH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA2ABA3C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d9af1f52bcso1901081b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 10:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704132744; x=1704737544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yfcinmzu3fGAHYO60etHbYExmH51CIjL4/eAucUWHkA=;
        b=Les3QTOHWak7mFcH9qiRuvPciyV+VyctLxpjyx9kGtuM+8bLbvLlkC0GivJdgBZ9Lw
         p8nESOO4PTQYdNTmoXrSvxKr2xW+SCEByqzS6l3XzdD9oPZ6NXubwMGfGImwfXj3zF/v
         MmMt8Z3Em6YmZ25EW67Cjg5cDs+1LUPNRaEc+jplMfG2SKJ/RLWBTlEEtKTYjFeqlebG
         9KCXrQx7M6lGhB3bnqVtl5IWpsibU/7HhhwDt5u1AsdGEMKpLcG9x56XSWC5PyHgiBVJ
         GWInuQsa9tpXTifrlkqsqvnwTR0ALXJUwV79WD1QTCiKiMg/05vTn1K2KdSauOwH1eAl
         5WFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704132744; x=1704737544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yfcinmzu3fGAHYO60etHbYExmH51CIjL4/eAucUWHkA=;
        b=B4+MD5Mzj6T/ZiZHPbtJyPjiQeqHG9+94CuTtBydFGn2SqWyT9mgbBHlWUhvOxe/ey
         9YzK9K3QGKnY9m7MNoU82cQpBzQ2IHVHDVa6oF0ZPodC2JkpzNfppBzy140zDv4Cko8t
         1RQgS4WeL2rt0+EPB5zAufZXe/bTBi0j3cXGuN9X6CY3XzypPftbfUhGuQJLthOozFOF
         +4HXLRWidvxkAR3J5veWW+9BynoVJ3aJEY/6QK+RJekdj43burgcnd5AJbikspk0DfnM
         CwX0pXAOfBhIiE3xNDs13AcXY/1/LHZ6DkwOzkuEUPCPaAuiBVjlKgl3S2w+YBO/EO2a
         SvJA==
X-Gm-Message-State: AOJu0Yw0iCOMSDhtjYQljIepnoOjKh0rkvtTvHKgTlrJBY+Nrc3fiMNG
	6GkxN756MQITswZnZOyMv73Wmb/oqx7Shg==
X-Google-Smtp-Source: AGHT+IHWr79IDfGUgn0Of4gsM+Z/TLPclGPF4NChQ8ZT1YIYFxNFQk6DXwGn7K/+2nGo///akLy5zw==
X-Received: by 2002:a05:6a20:9185:b0:197:2f2d:acf1 with SMTP id v5-20020a056a20918500b001972f2dacf1mr158354pzd.10.1704132744068;
        Mon, 01 Jan 2024 10:12:24 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b001d0cd351baesm20338723plf.13.2024.01.01.10.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 10:12:23 -0800 (PST)
Date: Mon, 1 Jan 2024 10:12:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: packet: Improve exception handling in fanout_add()
Message-ID: <20240101101221.73276d5d@hermes.local>
In-Reply-To: <a69fce11-68c2-446c-9da8-b959bb3ba70f@web.de>
References: <828bb442-29d0-4bb8-b90d-f200bdd4faf6@web.de>
	<6591e0fcb089f_21410c2946c@willemb.c.googlers.com.notmuch>
	<a69fce11-68c2-446c-9da8-b959bb3ba70f@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Jan 2024 10:46:45 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> > It is fine to call kfree with a possible NULL pointer: =20
> =E2=80=A6
> > 	 * If @object is NULL, no operation is performed.
> > 	 */
> > 	void kfree(const void *object) =20
>=20
> Such a function call triggers an input parameter validation
> with a corresponding immediate return, doesn't it?
> Do you find such data processing really helpful for the desired error/exc=
eption handling?

If you look at the existing coccinelle script there is even one
to remove unnecessary checks for null before calling kfree.

