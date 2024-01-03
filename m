Return-Path: <linux-kernel+bounces-15203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F43E82284D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207A01C22F90
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A74179B1;
	Wed,  3 Jan 2024 06:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmtqBEIU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319A517998;
	Wed,  3 Jan 2024 06:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5ea3a721024so14633667b3.1;
        Tue, 02 Jan 2024 22:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704262740; x=1704867540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdZd9FKU5uknJ79LRTb9iEU//CciNHZyx0SVdXO9d9I=;
        b=QmtqBEIUhQ5gpBqut7QBnfq+AX0oejSq7yTsu3zEzOKSGdEEXYNv985p//kQdW/s5u
         7iZUTPQ8KapbL0dpfRKXbUr+4YKW3gkRMXDeeusoSP8vhTo3quZ5R6uEYCtllIbm94Eq
         sIYERrd4LM86sMPoLrlDgM/DyZsUzy+pu5fftrLeK7ffKVdapl6cYXjdBlLqJaAgD3EN
         7MGKCste5Z1cwEYz5qiKgJ+MFEL/5beCgmWPnrNrxEeujubHQSnJfqZz3b+D/JkrP580
         w+CYCyBhTQV0baymWTlijSPTv+JQN7lii4cF+4IAiQ//oOuIP9d0JpCt75EO4UQ3qIoN
         uiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704262740; x=1704867540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdZd9FKU5uknJ79LRTb9iEU//CciNHZyx0SVdXO9d9I=;
        b=KH+N9CLY4CczMqSmQVvOCAZD+Ib0U/aJTl9kqfpqiU047+7qRPbqP5mpja6UGICYUr
         cBZX5Xg+FpPEmazRazKhI+dLQzXgemRhrkfXJwlwFFVWKRP+JWpr8DtjxAwX7nZu5tSh
         eIfKIzXcfTQdqUKn62Kss288X5XMgeaC2HoR64jBVkRKZBpvqgqbtvm+eKu/oJwxExoE
         hMNRp3aB+SD1AQ00Q8hCmmN2iu0N9c0yqE8LeehJVrvS3IvYIZIsW+pr5SJjTBSvAGMv
         ueqm3x/RHbucIFIe4c4m68nqDo0v06qLYsc94U26/AKIUPytQDKzEslFWFlk9bE9BDOQ
         Llxg==
X-Gm-Message-State: AOJu0YwDXNaDZcwiHR6AcfFMi01QmbZbEU00fKh3Y6ZQc6r8U59ER76g
	d9z4Gozh3AkHu5ndFULFrK1vqHIQ9a19B9g8gioIMXeldqY=
X-Google-Smtp-Source: AGHT+IEIXeu9HSBQzFHxVZ9hQpzXoBwdwRe2qF7QTxxcLb7knkOrHT0xgO+k6e51XcOd2spumACkVhg4NcR3IIYGUNw=
X-Received: by 2002:a25:734b:0:b0:dbd:c479:b6b7 with SMTP id
 o72-20020a25734b000000b00dbdc479b6b7mr16999725ybc.0.1704262740227; Tue, 02
 Jan 2024 22:19:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPnZJGDcNwPLbzC99qNQ+bRMwxPU-Z0xe=TD6DWQU=0MNyeftA@mail.gmail.com>
 <d4b227de-d609-aef2-888b-203dbcf06707@landley.net> <CAPnZJGBeV-E_AN8GnTfkaJvRtBmCeMYYCt+O0XMsc3kDULRuKg@mail.gmail.com>
 <fb776d99-1956-4e1b-9afc-84f27ca40f46@linux.ibm.com> <0879141d-462c-7e94-7c87-7a5b5422b8ed@landley.net>
 <e32077de-b159-4a7b-89a3-e1925239142f@linux.ibm.com> <fcb45898-0699-878f-0656-f570607fbed4@landley.net>
 <CAPnZJGBdwSBeKUK-An8n-eDJdrrA-rnKPMX16cFDfwx8wxQiwA@mail.gmail.com> <93564d28-5c56-6c8e-3052-0171c2bef43b@landley.net>
In-Reply-To: <93564d28-5c56-6c8e-3052-0171c2bef43b@landley.net>
From: Askar Safin <safinaskar@gmail.com>
Date: Wed, 3 Jan 2024 09:18:24 +0300
Message-ID: <CAPnZJGBDK=61U15VTnnRzSXxxhPMutrjqMX9-Oq8CKZaqOo0RA@mail.gmail.com>
Subject: Re: [PATCH v3] rootfs: Fix support for rootfstype= when root= is given
To: Rob Landley <rob@landley.net>
Cc: Stefan Berger <stefanb@linux.ibm.com>, gregkh@linuxfoundation.org, 
	initramfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 1, 2024 at 8:42=E2=80=AFPM Rob Landley <rob@landley.net> wrote:
> You all know your use case(s) better than I do, and I may not
> have understood your attempt to communicate it to me.
I don't have any personal use cases at all. I proposed rdrootfstype=3D
by aesthetic reasons.

--=20
Askar Safin

