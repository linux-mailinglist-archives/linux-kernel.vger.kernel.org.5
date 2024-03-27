Return-Path: <linux-kernel+bounces-120326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED31B88D5CA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4141C24823
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665F3125C0;
	Wed, 27 Mar 2024 05:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwM7MVjc"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1213DAC14;
	Wed, 27 Mar 2024 05:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711516663; cv=none; b=E9YpVc0MplUh7oor/4rIQfWU0CIZjJNbln14YE5uYzoXRZ34qbW/QW21z7oadnNjcXFWxF8i5VzbLHTvaMiKZ4tB8CppFjm0vbvRvBHGWAG6UZnm9nw0Fc2hiEJeOtwyhGFPg3o/CebtXljSo70ewD7OagwzVUYOKikMP0+pjTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711516663; c=relaxed/simple;
	bh=4riwaZTrjtC5kVDX3WEdO9qoYzGpgy3W1V3CwdcjKDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUWZ4cbVI6CTKw5jmiE6jzIhH85EsydA/b+PxhkV9MElrflxr36gGpxOIPaGY3EF0hbWM03PwdxC+GXm8YWxxMIf2W0OWt0y+7jOd/RJEO6/oonjpdhUJdez+q7zDltcdFH/e8YU4NNPVOslaAD4DvplBtEAkUVx7jpNzvxvwXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwM7MVjc; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-229bd1776dcso2544636fac.0;
        Tue, 26 Mar 2024 22:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711516661; x=1712121461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4riwaZTrjtC5kVDX3WEdO9qoYzGpgy3W1V3CwdcjKDw=;
        b=hwM7MVjcScCVkUnctASgPg3i9sPEHZD7lXwhit9BfsGOzH3DtxJ2Fhxb2sSHPPyafv
         HZS+vF3Jvg2Cx39ZhDQE5lW4Q3kOM3GJAbTyo1OSj3bpSbHU1vIQ+fnEvFOKq4zNwfjR
         +2EO9QmvGuZv1FE2eQak0c+URhGXhhpyIS2Gf0ek/k8oI9eCAYdavI+jZKVKSSPcyXKx
         7IrDbl5XmK4KH0Me8SBN18e1HnbEW0eZmVDMQx60FX68wSYVP6OkgkLAb8swlnQJhpU4
         SU9qwujP1IdJSD4seX0yUmfIBUtxjgIJurmj1hu4uvdNRHg0to+f7Byu5VpDg4MzWc2h
         CBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711516661; x=1712121461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4riwaZTrjtC5kVDX3WEdO9qoYzGpgy3W1V3CwdcjKDw=;
        b=ka6DbanLKSjH7V8S1m4sxG0inYM1LiU7F1MN4DzQKIo+y9DBtszytdDolXWqUZBCiQ
         ovR1cAfZ+JA6wap8fGIH58x6b0eRIZbqphLQDwe51G8f9f4KdiSpGiHy2nTiuxJCjxT6
         ujQlTtbsBzHjD+q6tjofjYY2eT+MKvZGHrvrayiJNY6JssABmV4NlyL0uaRgw8MnEEt8
         c93jWFmXjeTbGLPotgYyTyBPdDzhY+RMbvGfBhxDN7gPF3cGBVYGXXEQ/ynXZiMcv2Bd
         uIsmiE66GGweeH51kANZwOoGHM0ryixOl3J4OrTCXzTFzKmKMZ98XCack3DQ2mlnzgsL
         xwuw==
X-Forwarded-Encrypted: i=1; AJvYcCWNqfgy7/dehf91Mc+afnbc0yQ6tScxbkgoZVn6kMSI11itFVYaE2mOywh8oVStYGjzQP8gv+XxwOxqCwRr0HgQg4Ns38rfaRgHqHRN85QfqZ9Xw1PW3S1rnWdIcgyqczwYi7IKR7PyZNt9JMynjyrGdU8TBE3s/mpGiyYHYPl4N2hLRPmUaw==
X-Gm-Message-State: AOJu0Yxi4XVxjPGj2wG9yXnFQ6S/v+6eqijYce62oLkBamo8iBhfF1VD
	cJX9krAWtxYTjEit5/9eW587o5edrUst7rCiIUp+HaBCMBUSy9mB0t6kDiNGegziyGn30uBGxJ9
	HI7gn5PxXmkYCJ/7tMJxySzX/T7w=
X-Google-Smtp-Source: AGHT+IET+KpDpFsXH1vZPq1nm9mFae1IJte1812WIdulNEGf93QkoKnilIyxMU1roZlztJpUo4rlwE19CsPfYLJEkfI=
X-Received: by 2002:a05:6870:d38d:b0:21f:d3b5:bd02 with SMTP id
 k13-20020a056870d38d00b0021fd3b5bd02mr159760oag.31.1711516661488; Tue, 26 Mar
 2024 22:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326120107.13442-1-animeshagarwal28@gmail.com> <20240326-spectrum-talon-0fc977c32c5c@spud>
In-Reply-To: <20240326-spectrum-talon-0fc977c32c5c@spud>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Wed, 27 Mar 2024 10:47:30 +0530
Message-ID: <CAE3Oz8237mYOcDuJFOH+7HJ0sLG=hT__F2aTsr4r8Jr3V-c-Xg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: crypto: ti,omap-sham: Convert to dtschema
To: Conor Dooley <conor@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 11:50=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:

> Is there really only one value possible here?

There aren't any ti,hwmod properties with value other than "sham" at
least in arch/arm/boot/dts/ti/omap for this module.

> Also, the convention is to put vendor properties like this after more
> common properties like reg, interrupts etc.

Thanks for letting me know I'll change it.

Thanks and Regards
Animesh Agarwal

