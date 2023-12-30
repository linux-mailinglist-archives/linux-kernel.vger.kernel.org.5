Return-Path: <linux-kernel+bounces-13309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB6F82034E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 03:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765A9B212DC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 02:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B377010F7;
	Sat, 30 Dec 2023 02:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKbZqOT/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD69F2561;
	Sat, 30 Dec 2023 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-20418dd34e3so1050659fac.0;
        Fri, 29 Dec 2023 18:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703902280; x=1704507080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5wftXdqHpDvs+q+yb5THIKCqGwLclpSQRrWfFRqk28=;
        b=HKbZqOT/MxXdbVfi1u6GFJ0ahvygwDTKaVIxdmzwlk/g8a0eC2w1+4WJNdOdCkQ5s7
         dWP7nNwZ651CnW2quPie2U/0zgTkPbTSDwYF7HYs5XgkLKARPXahAzxRQC6lKiTBr+Aq
         mJOZu8JDaefkNBJWAFh8tHV10yNjvsfb72dN47NkYxA6S49umY641IKSZFqcIgauoMkN
         lr1v6PVL+fJk/uzd5SMF16dA9laIGq3Td5DpjWOp0fg8TwtULficTFgwD/GSwre++ATU
         t2VzhdY2fjjLkESWk2pzev65ZMXe2aYAUyuy1doSRAEwBPh6HsM96xAcbo7JcGQzbIka
         3jVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703902280; x=1704507080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k5wftXdqHpDvs+q+yb5THIKCqGwLclpSQRrWfFRqk28=;
        b=e5Fa0GR73r4CTyo9GNUQn0s61N+z2tjz+D8FK6rTC1eBXPOUR157y1N5MPy/8jF9NA
         Kxo/mYV4nxPA9zSDgZ4e5Xt7Y8rgR9h7shLynfU4Q4w7FjZnvg9i9JtWItsVdx2KMkz2
         KHOnbA6jS+nxP01F0H+5Ra0Dc2d0mQMzRtHPxtznPxAlHurgimFUiX53YwIHftRVU6A+
         Z2lK1OfVb1BETcTkw5r23wjpSTO7CIJD/TVG1aNvsaApaO7ZXIKErI2ghDHTex7hPpDx
         f39TUw6UWvJ1bxl3wdoM1bC8RPGIGd8fBE8Uvm75OMwuT+60ZuaQKTJ5QLQyNUQi41hG
         Ghww==
X-Gm-Message-State: AOJu0YwBaAakQH+f9+rWw0a9y7HwM9+AHcOucKq2XEpUfH9eaTbkx+6f
	7OAf0Qlezx+NO5rNhSQ/DJBqau1NbV1VnleU6RQ=
X-Google-Smtp-Source: AGHT+IG/qybA/I8o25nAh8hJqu/W9NF7WUkJOQB5UOkpbnmx9vn2Wif1uCwTsXOKTRHlbKby96Kx3mcIA+GxJ0tMqKY=
X-Received: by 2002:a05:6830:2b13:b0:6dc:6a7:857d with SMTP id
 l19-20020a0568302b1300b006dc06a7857dmr8677192otv.1.1703902279837; Fri, 29 Dec
 2023 18:11:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPnZJGDcNwPLbzC99qNQ+bRMwxPU-Z0xe=TD6DWQU=0MNyeftA@mail.gmail.com>
 <d4b227de-d609-aef2-888b-203dbcf06707@landley.net> <CAPnZJGBeV-E_AN8GnTfkaJvRtBmCeMYYCt+O0XMsc3kDULRuKg@mail.gmail.com>
 <fb776d99-1956-4e1b-9afc-84f27ca40f46@linux.ibm.com> <0879141d-462c-7e94-7c87-7a5b5422b8ed@landley.net>
In-Reply-To: <0879141d-462c-7e94-7c87-7a5b5422b8ed@landley.net>
From: Askar Safin <safinaskar@gmail.com>
Date: Sat, 30 Dec 2023 05:10:41 +0300
Message-ID: <CAPnZJGB64bWV9_p3mi_Bu_vfqhhy98oGpqjfhnMJQm8e112uyA@mail.gmail.com>
Subject: Re: [PATCH v3] rootfs: Fix support for rootfstype= when root= is given
To: Rob Landley <rob@landley.net>
Cc: Stefan Berger <stefanb@linux.ibm.com>, gregkh@linuxfoundation.org, 
	initramfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 9:29=E2=80=AFPM Rob Landley <rob@landley.net> wrote=
:
> >> Rob, do you agree? Stefan, do you agree? Then I will write a patch,
>
> I think it's a bad idea.
Okay, I agree.

--=20
Askar Safin

