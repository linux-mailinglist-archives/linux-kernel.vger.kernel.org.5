Return-Path: <linux-kernel+bounces-40100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B70183DA50
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C999B2913F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C632E1B5B1;
	Fri, 26 Jan 2024 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3dPaX1k"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95E51AACB;
	Fri, 26 Jan 2024 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706273546; cv=none; b=E22ewFTHnqiv2p76w8CB5CC/dB0VQjxRxUalJj1YZQw9VXTxcNV/eezL4HwCNYOnBSKg2lIZhiO3t0+BWqT4Mk7fIHAJan8CGDkkwV6eI3etMry3H50HcNMdUe6EUJqbyvfr0FMNlKBdS6fYoEL3FBvrvAFYiGqkK5pxSGXz3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706273546; c=relaxed/simple;
	bh=5GztzeRJ7QonXydbXi0LYB9tRSovYETdbDIFz1v4Qmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ECQBWKVFVisRP7HfE/iCddW0ljlVkFbUSSeiZFmIflBd3FfaCcwMRT6ON/3N1XCuiaZrplKHYQhkIJGVwSZWgtpp6x9KiwgD09VEHpenniR/zua60xAQ/lOJmw0QZKwK8ILQr1hVsjTuhdpoO1vs4c8keqNXP7o3hGXDJTE5yYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3dPaX1k; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc223463ee4so512969276.2;
        Fri, 26 Jan 2024 04:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706273543; x=1706878343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GztzeRJ7QonXydbXi0LYB9tRSovYETdbDIFz1v4Qmw=;
        b=X3dPaX1kU5zaWUFcAcAOVCIcookzalkK12TyPx6VDWOTpVGUPB/gE/2lrcSEDL7xpF
         7grJ+gosUiJi8mM22t/bKossMnUVoWUF+LeB/KT7RWFD4yfPjUVb473EinXw8p18G63e
         h2nOYcHDBf/ny5gbw+TUHW8wInox5pze0AwAdV3P2sysQBTEJ0LPAq372INPRxbX8pwF
         V+Bk6LfktsNcLEXQh8fn11pHUz2RYcrpLGLKgp/O/DQuqZzuHuY/2zvgGvfAPIDCPlSE
         VtpjcrOp5YrGd17T0h00b60k1jFFplfIKWbMTom4rClPHu2C631nfF4Qxr0vGEtAGL/E
         3Fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706273543; x=1706878343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GztzeRJ7QonXydbXi0LYB9tRSovYETdbDIFz1v4Qmw=;
        b=BeD21kViSbaEtS+qLEhKEdgwKs6fGVbOPCahGKBtO5cCl/Z8tERR0UWsYYnR/OzSEf
         Kbf/TfBRShTNMHTV6C9K1M1/LiRFsdVgOGEz8B1tAeWNhLgfOS+5VEYxwSctJAXqM29i
         ND8976FHFbMSI4IQwLld9p4QdpBcZEWX36g0fDSp1ur/waPC6rfBhRN1XpHPp87rH2y2
         G/Is1jyAdk2TOpNZYOM7/GgtGC51KN69bL54DFXrrxUi2kocGaug/j/16MR0OUy1/cXd
         n5nVQoYbgErqwXSRsTzOvs3pQPTNV2sOOJFs7u0SUjOSxLs9ntzUy5GbTH8nEn+KGTSr
         Jv/g==
X-Gm-Message-State: AOJu0Yx6A6XIsJmdaWXrThazTILHsSbxyVOTWdCH/nhs2uuDVmrxlBuu
	t7pawZ1cz8/1CnpA2wjTd3G9FW4U9nMNSD7Qrix+nxJIAb+aTpo34KWgq/Ge4d2SDZ0tzitqwmR
	XYfS5sQMOoLYSE/0gwkPc650Outjn0VCpc1GDaSedlZk=
X-Google-Smtp-Source: AGHT+IHDUz3d4JvNDFrSYoB+OTb7JyrHZFIFiZZTWGcIVjetZDWCyRBa0ecedY7Ar33Ir88A6iXAXmaWFCnMv/QwZK0=
X-Received: by 2002:a5b:f09:0:b0:dc6:3610:c344 with SMTP id
 x9-20020a5b0f09000000b00dc63610c344mr899970ybr.13.1706273543622; Fri, 26 Jan
 2024 04:52:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118120347.61817-1-ioworker0@gmail.com> <CAK1f24=TfJvsDCEesaTa8rGP7ay62p6UiJem=XWnpFa9yfSA3A@mail.gmail.com>
 <CAK1f24nS8MEA3wcS4za-uSp7ZBxvd+xqMRf8-u=m5uCvTs8yJQ@mail.gmail.com> <CAK1f24kOYDOw26ov5TVpAyNP13hCjm=cDo4rooOTPDuv8L6Pnw@mail.gmail.com>
In-Reply-To: <CAK1f24kOYDOw26ov5TVpAyNP13hCjm=cDo4rooOTPDuv8L6Pnw@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 26 Jan 2024 20:52:12 +0800
Message-ID: <CAK1f24n0152CmPghBLQ7225=rwEuP6mMdBybWZz7heTLzemBqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: add MADV_F_COLLAPSE_LIGHT to process_madvise()
To: akpm@linux-foundation.org, Michal Hocko <mhocko@suse.com>, 
	"Zach O'Keefe" <zokeefe@google.com>, Yang Shi <shy828301@gmail.com>, 
	David Hildenbrand <david@redhat.com>
Cc: songmuchun@bytedance.com, peterx@redhat.com, mknyszek@google.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 6:15=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wr=
ote:
[...]
> > If the kernel supports a more relaxed (opportunistic)
> > MADV_COLLAPSE, we will modify the THP settings as follows:
> >
> > echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
> > echo madvise >/sys/kernel/mm/transparent_hugepage/defrag
>
> The correct THP settings should be:
> echo always >/sys/kernel/mm/transparent_hugepage/enabled
> echo madvise >/sys/kernel/mm/transparent_hugepage/defrag
>

Apologize for the confusion in my previous email.

The third type of requirements prefers not to use huge pages at all.
The correct THP settings should be:
echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
echo defer+madvise >/sys/kernel/mm/transparent_hugepage/defrag

> >
> > Then, we will use process_madvise(MADV_COLLAPSE, xx_relaxed_flag)
> > to address the requirements of the second type.
[...]

