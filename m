Return-Path: <linux-kernel+bounces-82896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D603A868B74
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7263D1F254E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A41D13540C;
	Tue, 27 Feb 2024 08:57:51 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8127BAE7;
	Tue, 27 Feb 2024 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024270; cv=none; b=NZ90v3EtHDJwpziKFXQbuSV/1xsgVYBLG5Ihav89aFXsUt4+I3SZnFhFRuv+avftfm4wLTzO5G4S9G0QXigSUnz0oPUa4uBY/12UNDFIAWgr6gA/5caRYx9Xno9YtXMFqQYPwWZIDq10jgxFxsvVW/C7MxAI5ZhUpvzflCN7+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024270; c=relaxed/simple;
	bh=Kp2ifpJ0SNc79LHyMlF9EWLBMbcmEY+PW69cCFFGc5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kcm/SA7i87B+R2J9Cge0FjOrZf9IhGemVRkYm0BBRphJrjxfc+5KZYPeYcEG+1Pyd0lcV2tNhyUfHB50tUCTVoTgpCOI6gWgvzDDqG4m3+xYtB0QFLo05lcetD42tgbw9ZG0kjUyArkd8YtAQ0dQHD5RiAnIJ+cOOg2d3ivoRTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-608c40666e0so28028367b3.2;
        Tue, 27 Feb 2024 00:57:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709024268; x=1709629068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcuIBmP721rI1L1wymdosgxGWLt7Pvpr1hHaQTlwKTE=;
        b=byGgy0tBBiNcWZxusYUwG38A/j534TIgr+tbIXKChy7iEq1/GvYOijATdxCMjNKzu8
         ibTQYFWHzTFeXJxtgLBWIQUhhyZrOpjFPdz+zvKY6W+EmL0oJyxJZUZPK17rCZ9ykAaT
         VTK0fOTyjFqbNskLPBH3dfghSnwR5nl/ilwIqvXuEvatBS/VRkXcHemASJczMkqPAX3G
         BX17HKPuJGc1UwhrzskmkTWDweqgI4IqgUr8WZKibRdCcF2wRxYXADt9e8Rxl5vcIr0k
         uJwdG8FQnEmVev1FNZzplh1+WwVgQC7cM2KuXNOVdTot2rlJscKLxhUJY40IP1yA/8ed
         s0/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFHnZLUQCbMKJdjFL6lWXEd504EEzOgrjoK0AfT1Hh+XSh/q8spVeYjZI/E9lu5Zajon9ysbfg5jEU37az0l/cFUCIv4F6o7rjEHQWpdYoKX0g5hHX9xHL1KBS07F8BsKxhlMTq9aR5Ik/jsQEGaFLvWoEvHJYfQlvJheKVtOZn6dEXC59gGHdIAmUiH/QNUlLzS9tznEZwu5PHMFFx35bk5xq
X-Gm-Message-State: AOJu0Yxek2ki5rfQFtx7O/kZ9sN/tjFM7s0vXdx2aqOe5uXUgjdPmzn+
	OGOzLUxnCVbAgL36iHa23gQEJ0LP/0Knhq7etNXjUR/aZfaPRMHc4nNlOaNKNQY=
X-Google-Smtp-Source: AGHT+IHTOpgvI+j+1DN0AnO0Z4bdGQr6EpGv2DjOu69YeCXi0iYmRq+b99+PuNuAS0H/ZfaSgeZtiQ==
X-Received: by 2002:a81:b385:0:b0:5ff:a9bc:3893 with SMTP id r127-20020a81b385000000b005ffa9bc3893mr1445738ywh.12.1709024267703;
        Tue, 27 Feb 2024 00:57:47 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id w10-20020a0dd40a000000b006077c89b001sm1664164ywd.83.2024.02.27.00.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 00:57:47 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6092149eb55so8724107b3.0;
        Tue, 27 Feb 2024 00:57:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzxBpQ5hk/RlJt/+f6hUSlV+Tce+yNw4xEnewjRmrJg9m7Rl2RHd2ONBlEIXHsUojMpYumetK6AJS2CRhU2WQCS2D02/uZEkVtF50L7EZItJIkAa4pr7/h+8DEXIPYLg63PXiO9MuzE27a6aJrZIXkftMHWDRqXQlR6vqKstOujV9Tz92TrRRPnrKALg/Z/JaPSCoSxDP+Po2qKRtDzu+lkqoq
X-Received: by 2002:a25:6b43:0:b0:dc7:4ba0:9d24 with SMTP id
 o3-20020a256b43000000b00dc74ba09d24mr1357549ybm.59.1709024266977; Tue, 27 Feb
 2024 00:57:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226104653.54877-1-lukas.bulwahn@gmail.com> <43df625f-bd32-4dd9-a960-6d0f5c0304c7@infradead.org>
In-Reply-To: <43df625f-bd32-4dd9-a960-6d0f5c0304c7@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Feb 2024 09:57:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUD94XuE_7UK3TEWbeZ2eMOPimDi-xoo9+43FhY3O2aDA@mail.gmail.com>
Message-ID: <CAMuHMdUD94XuE_7UK3TEWbeZ2eMOPimDi-xoo9+43FhY3O2aDA@mail.gmail.com>
Subject: Re: [PATCH] docs: submit-checklist: structure by category
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Tue, Feb 27, 2024 at 1:41=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
> >   - Concerning checking with tools, checkpatch probably still makes sen=
se;
> >     it pointed out in several places. If sparse and checkstack are real=
ly
> >     the next two tools to point out, I am not so sure about.
>
> I doubt that ckeckstack is important since gcc & clang warn us about
> stack usage.

True, but that would leave you without a tool to get figures when
there is no excess stack usage detected by the compiler.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

