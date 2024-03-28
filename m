Return-Path: <linux-kernel+bounces-122603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7D788FA4A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01531C29550
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E46F50A97;
	Thu, 28 Mar 2024 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzatqInD"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0925C4F616;
	Thu, 28 Mar 2024 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615864; cv=none; b=WEd6xzudX7rnueMq88zYVB7Bd7wA9DM+godUpVeEqi3fFTGOmPGEElsRztvHyHmzVByOxF6gsY/gtfwdnfkt7MVN7iRASn1TS+yd3Bo5onyoxSjt7QG1sNGVK9TP+hcdeQtx71aiL7j+KX7TsWpCc+0Sw8xhAPnhBjr0pj2omtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615864; c=relaxed/simple;
	bh=9e3XkaK6tteQhjKw13sR8xkpi2tSyICL1hHgfWKvrYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pw892f/C0c11QSJ9qVj+8hSWw+0aqu4JXCnVg5G2ynCShnnUZRqrd00g+kIppxkHpMGn1Vw95Lug0yrf3dLvnCSiQIRW9CbUVX6H2uQVIM2hAIK/CRCZRCdaM31JItnXeFhUshQ2F+vL98Sql6vfKiajMV/y7RoSfg8OaEc6SNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzatqInD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a474c4faf5eso72356066b.2;
        Thu, 28 Mar 2024 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711615861; x=1712220661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9e3XkaK6tteQhjKw13sR8xkpi2tSyICL1hHgfWKvrYs=;
        b=DzatqInD7MMWIy1ZLCUqJVvlSmSRcYC5ks5gcyKaXEmNcIlipTVGU1yfZYvmQ1idXv
         fGpIH6zN6jiA2kCsw68RqnOILnsEsIPse7WrswbxNqDACDGBhfquzvQ6Fss94K00OjMZ
         nfUGSzgtO2BTRZfabGi3pSLR0KDYt0JA0lAFbdoO501hOvHZ+1ScYAI9m3ScF/MFEg2G
         l/eNha0JpCj1ETPMckepES4/ZWxTe6si4+rw+szt8gYswf1MFDYHQdoYfmeoNrJOSTY2
         tsHvVo6b9DvnH/cYpgwf9utW/giudXZ24rmOh2OAvB44JsZffHL1KcMvwvwMDs8ltscl
         NnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711615861; x=1712220661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9e3XkaK6tteQhjKw13sR8xkpi2tSyICL1hHgfWKvrYs=;
        b=NPbdLw3VHEZuCGhTbUD8Aet8YADnCkh1xBNEhVdQtK6VJZ6EYPWF93BPbKkqJi8Lfu
         c/UN9H2ESHjxN2ytfKFTaVrrZivcAEHaAT/vmsFEJpAXBB5VLzNBQn0qmq751CvbGEOD
         VR6N0Sp+yDPS/AdQtMv/i8FAzkE4jUMZhbqKS6Tp44U0SUX1cAjUFbdiTxTOs2y7WyE4
         B+DIOeqNWUEgpiqV6gb/KvCKzLrAQAxF7vZenEu+7R6/+O9A7n6HFkIw/57DOwK0spNN
         9wWpPVuiQtuGV5j3DGvToR23s5Ko1LmLe6xGjJV4OaVgTa2lqsGohj6+LfUfAvclD1ab
         zr3g==
X-Forwarded-Encrypted: i=1; AJvYcCU6tz1Um8MIuo1fvm8Wja7uKoetAsl8uJU0FGYk4xHt/Ps1fA7Sqm/1HuiDSwgsrgXvbjGLUXPGWBQHvEfF0T8F5CxT41/dxGBnCN8r
X-Gm-Message-State: AOJu0Yyt+uwKGPhmaq+tQcZIIDNHSHm1e/7iiiafpZ+YUcF7n4ghA6AK
	um/QEZ9UATyVN2krnFliUVNfd3g0fsBYWMzgR6BQ1yLt8HdhEoE4JcPV2ssoIKNv+iy/M8+sCN/
	twipXWjqgCmRkh5V0DvR5dgn77tA=
X-Google-Smtp-Source: AGHT+IHHNooGUn6g+M5ebsJC3IomxxH+wRI5eXvV3spYj/fK1WjeiI08Cs0p44A5YropMtkM6QXV0e/yBSa0pXfsU8U=
X-Received: by 2002:a17:907:174b:b0:a46:b809:4b22 with SMTP id
 lf11-20020a170907174b00b00a46b8094b22mr1281570ejc.45.1711615861085; Thu, 28
 Mar 2024 01:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327215208.649020-1-andy.shevchenko@gmail.com> <a2362908-feab-416c-b5ae-13d560089ee6@gmx.de>
In-Reply-To: <a2362908-feab-416c-b5ae-13d560089ee6@gmx.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 28 Mar 2024 10:50:24 +0200
Message-ID: <CAHp75VcnsxanOpP+v+EFqpO1TLXyuz1_55Qvttrib9=T1Y1Y+Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] platform/x86: quickstart: Miscellaneous improvements
To: Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 1:35=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
> Am 27.03.24 um 22:52 schrieb Andy Shevchenko:

..

> > -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

> that is the reason for removing this?

Yes, it's a dead code. Likely the cargo cult line was copied from
another driver.

--=20
With Best Regards,
Andy Shevchenko

