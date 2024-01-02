Return-Path: <linux-kernel+bounces-14728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 854DA822145
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E691F228D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4F515AD2;
	Tue,  2 Jan 2024 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AaGe6+GI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4B915AC5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dbdabb23e91so4455932276.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704221117; x=1704825917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjVmfRb4lmSQIEbZDNGApWLh10nZ5LL8tfeNBp5q+Ow=;
        b=AaGe6+GIpqLfWKQR+hJLzTSoQKqyDx1LY/611F4Se+sJrQJwf2XBKfSp597WLrDzwM
         FtxW2CELz9lqXRs66sWV3Sdqyyfk1GoN87M/pG0q2cCMVIjHMo6GIuJBOWqwDlHvWjXI
         tlpNseQJFIzVUFPshbzNMXOX+e5ANwYj7LwRGiAxEnkaCkCCtdMODpd+ur6+qzpbwi6d
         Vl6VCFdH8MNfkHdVLtDP/4zpPqY0nxJ1JqyiMUH+YM2Izie313BRPC1O1UEy2076BoTY
         yR/9CL3bu0qow0ivybsKulYkbTrqfkXi3myAs707vJ9n5Sm4xzuXFhKfNXNA7V5SEcW+
         xTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221117; x=1704825917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjVmfRb4lmSQIEbZDNGApWLh10nZ5LL8tfeNBp5q+Ow=;
        b=gEQC8JXYuI8txxhEL4wbruvxZ7vDk1Ui40u+XfQIbp79YK17+4kVIBf8q2hXplVlfL
         nImv2bkyaHMzXPYtbYeBMdvE66+CkvXV1g+GEg406CZc4QKBO+3o34dSl2T8CyFrfDu5
         QZ1xh4NgUXXBe+A6tS1VvC90/H7M0n7YtwIiepaC2nKnD0RYqm/anTy2WpcsUK2o9nrb
         GOvEmyo/m4jbCR9iolohjB5rfNvq+2bphiKgqZFlSXsOq9/CnQ1JBV0GdxrXJ8vupAfO
         wscXHR7rx9Bkrs2IO7QtdkWv0M4cN4qM7PNLvsR9flvu+psc3ztH0yvwNGlog6e9wwjC
         8acw==
X-Gm-Message-State: AOJu0Yw+dsPrq+yEgueS/TDUeATrgZ72pa2OegvPAfj2ZlwyiPBi5Q3X
	SDGpluRRXh+I32dCGYtUyhy6Ds9h5KoBLh5WZLOPNSZ+aa3byA==
X-Google-Smtp-Source: AGHT+IGLuB7cRoNhgCe+Q8pUixsF6gjSJJvEoxyK9Hh+eUGbYV2c2G9Z99y8hRHKLR6/zScsyFW2p6yUKbe0INgeFvY=
X-Received: by 2002:a25:e90c:0:b0:dbd:b59f:217a with SMTP id
 n12-20020a25e90c000000b00dbdb59f217amr5574774ybd.17.1704221116966; Tue, 02
 Jan 2024 10:45:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222235248.576482-1-debug@rivosinc.com> <19703a88d00b6e2d9b6ce2bf911ee34d465b1a11.camel@intel.com>
In-Reply-To: <19703a88d00b6e2d9b6ce2bf911ee34d465b1a11.camel@intel.com>
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 2 Jan 2024 10:45:05 -0800
Message-ID: <CAKC1njRPRV7VOKmzx7xkNV+FNZmoeXhd-yRiLA8Zw4xKSGQEvg@mail.gmail.com>
Subject: Re: [PATCH v1] mm: abstract shadow stack vma behind arch_is_shadow_stack_vma
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 9:50=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Fri, 2023-12-22 at 15:51 -0800, Deepak Gupta wrote:
> > +
> > +static inline bool arch_is_shadow_stack_vma(vm_flags_t vm_flags)
> > +{
> > +       return (vm_flags & VM_SHADOW_STACK) ? true : false;
> > +}
> > +
>
> The bit after the "?" should be unneeded. I would think that patterns
> like:
>
>    bool res =3D val ? true : false;
>
> ...should never be needed for the kernel's current bool typedef. Is
> there some special arch define consideration or something, I'm unaware
> of?
>
> https://www.kernel.org/doc/html/latest/process/coding-style.html#using-bo=
ol

Thanks. Just checked out the link you sent.
Yes it's not needed. Will remove it.

