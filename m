Return-Path: <linux-kernel+bounces-107780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E449880194
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B22F4B2430B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FC88288B;
	Tue, 19 Mar 2024 16:11:19 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AA6823CB;
	Tue, 19 Mar 2024 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864678; cv=none; b=nVw1+z6RG/t1VQ4xw3uUGDolEo2LoR1yjuTz4KG07pdZkL68u8IsTFQaXQHNGyiRXOmM57rh5Kqzb0HH6cfuajhBZVLYTS4rmDj2/HlamwMcQzXXPezAgAdPZ6OoCqNs9h9DdhQGjsejxie95PE6yLuVfUmGiiZbF+T7z22tntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864678; c=relaxed/simple;
	bh=U993M1JRV0FGOsJ7Xah80cxg5qsx0Afxi3HJKSRRq64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsvdQPX5X1f6WXOJfeoTfzD9yvvMO21K14D840bWAwZeV0xH1vx/E2QMSpmjfn56OVGiCMAhagSRUom6O2Fsi3uut8af0J7//WxfmC63ZXtJMwZYPm95FnbHHA0zMvfEeYvNO4bKH5EgHj27liHGl9MEwmz1y8UN1hYCm/Na+OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dd14d8e7026so4683226276.2;
        Tue, 19 Mar 2024 09:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864675; x=1711469475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bT5IxGVGT1/jwRDQQJapGpqLtI5H2MTLx4kQKFPlIA=;
        b=aUjTdfEp7kfnqYNm+P9vxB5egOaM8ZAKb6vz1RSkNsLSo05W6YAWERtXvMqJxYHt/X
         fUhJTJMivOVVGCxIJD2EjEWaAXNvtAjaOjQdJkFtezgytdwidbM4+pY16ZpVWO0NC/qh
         eqF9eGEw0WfhlLqKduEzFbkYXpJIzegY2i6MagJ5uAyVOYNV+GJ/s8YCIWRF6+EPZEui
         1ZMQ8I5XyJl4tYOsRB539sXn1zA1O9b/BNLJUlnhwLBFY4EvAYry6fvxV6rkLpKWjntD
         cw8zHGaf9akIJ2PkmfavdtRof932PZLdRh46tNtd+QExHM3XomMMdqi3blbPO8ZrEdCH
         YcYA==
X-Forwarded-Encrypted: i=1; AJvYcCWDBqeq1tcqvNntg0I40eNqnFSBiU4haqDnthyCsFEzki2FM7UO6Kfg2ucAKWHfFRs4rDO/tYyIq28ty6SBaIkWdPd2GBPRHMOY9XPeD4H7+CdiPqFnt2aWkvnchYieEIiKFxni81Peaw==
X-Gm-Message-State: AOJu0YwVrXkETN4bbAOTGKiQqg49sSv13DHp8ekoFcTDlSXN4Ay+cQ2c
	elNBAXNd/NDrMd1rDAEDR/KkJ1j3spDO1xs339bmGGkhMC9lPGlFhvkq0tZ0rO8=
X-Google-Smtp-Source: AGHT+IGqa3f5sWDPgyvsXo+pKRPE6dKh1PdnVpo7k9OilqmK7Qkr1dV1fSBxAv8VWbGV7FixNm1XNA==
X-Received: by 2002:a05:6902:1b85:b0:dd1:40cf:942b with SMTP id ei5-20020a0569021b8500b00dd140cf942bmr14058809ybb.48.1710864673322;
        Tue, 19 Mar 2024 09:11:13 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id s10-20020a5b074a000000b00dc6c179f536sm2185060ybq.20.2024.03.19.09.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:11:13 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so5171791276.1;
        Tue, 19 Mar 2024 09:11:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVmj2TvNNRE7yUig1FLs0vXBLWmBnTiqIY+IqC2h61tE0zHwAJYVhzCUSjbUNqGY8SYXY34tHT+TgQ+VgI+Mf35pUhBcEtGDcKrSEcVxEv8Uadl5uQXq1wftt8XA95I+wBRwvnuYLoZw==
X-Received: by 2002:a25:dc82:0:b0:db9:9537:2c39 with SMTP id
 y124-20020a25dc82000000b00db995372c39mr12914894ybe.2.1710864672896; Tue, 19
 Mar 2024 09:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48ca5e827ca420bbdbabb1643e2179dc95c9e0b7.1710849638.git.geert@linux-m68k.org>
 <d1a1b0b8-41f1-4ead-b393-d8d2f099b0c4@acm.org>
In-Reply-To: <d1a1b0b8-41f1-4ead-b393-d8d2f099b0c4@acm.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Mar 2024 17:10:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWzD1OR8qj8oHfUgQ9GMtrD8y69G+A+ONdVm0vTCvYe=w@mail.gmail.com>
Message-ID: <CAMuHMdWzD1OR8qj8oHfUgQ9GMtrD8y69G+A+ONdVm0vTCvYe=w@mail.gmail.com>
Subject: Re: [PATCH] scsi: core: Make scsi_lib KUnit tests modular for real
To: Bart Van Assche <bvanassche@acm.org>
Cc: Mike Christie <michael.christie@oracle.com>, 
	"James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hoi Bart,

On Tue, Mar 19, 2024 at 5:03=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
> On 3/19/24 05:02, Geert Uytterhoeven wrote:
> > While SCSI_LIB_KUNIT_TEST is a tristate config symbol, configuring a
> > modular build of this test does not do anything: as the test code is
> > just included by the mid layer code, it only works in the built-in case=
.
> >
> > Fix this by converting the test to a stand-alone module.  This requires
> > exporting scsi_check_passthrough() and adding a MODULE_LICENSE() tag.
>
> I don't like it that scsi_check_passthrough() is exported so that counts
> as a disadvantage of this patch. Why to convert scsi_lib_test into a

Perhaps the exported symbol should be __scsi_check_passthrough(),
to make it clearer this is not meant for general use?

> kernel module? What are the advantages compared to the current approach?
> That information is missing from the patch description.

SCSI_LIB_KUNIT_TEST is already tristate, so the original author must
have meant it to be modular.  Or perhaps he just copied it from
(most/all) other tests ;-)

Anyway, I find it very useful to be able to do "modprobe kunit" and
"modprobe <test>" to run a test when I feel the need to do so.

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

