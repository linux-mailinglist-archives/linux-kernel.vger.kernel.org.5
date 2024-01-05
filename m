Return-Path: <linux-kernel+bounces-18218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8A1825A21
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02E5284E09
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4830735891;
	Fri,  5 Jan 2024 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5WCXUV5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1373526E;
	Fri,  5 Jan 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-20451ecbb80so791201fac.2;
        Fri, 05 Jan 2024 10:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704479410; x=1705084210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DOGk97fr88vkauVvriKz/y0vgADMyzdF5fmnXEAejc=;
        b=M5WCXUV5n04KA7tgC9bO/i0sSGDFoDIdJv8aO3NruUGHwBIly9aoroDImwv0Ozr3x/
         2SJCImpwU00AjHm3SHObApBsSrKM8ZhSuQAMuuEniwX4x/aink6NoxMbpg9nPidA8Z/8
         OjD9587guVcxCYH/8PR+NE8eucDUL/Jbw4PLZlhpzOh5VhgU7UmZ4NnVD3bOn5XFh46U
         EUkVA4d/ytW3DDHUiX76X5UcDJMRScWZALdDGax+81IWdOqbMP71ZrO8F99rn4t+8fPN
         e9Pwm4IRJOFoyiFR4yDE8pIZz5MDuVNrw8H5oHf9lUBTtrXUaZvJozFnufUwsSPgd2mC
         2DAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704479410; x=1705084210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DOGk97fr88vkauVvriKz/y0vgADMyzdF5fmnXEAejc=;
        b=Vy7Xxt4f5GNLEVuXRmVKvaVZuHN9wa1HVf4CKk5fRJTy5HOFhg1ImCzMItieO88IMc
         6aMiMv60j428yE1maeX7oQTYBvTfrDlKBthup8gFKepawDNWXo7B5HZn+MXafXOVXkFT
         +OwXpKwE/A9JIqnlzNX4L4wPMZKvIsMs+wFQ75aVLq30IQIClJmPWuONWnHGjEm3RrvI
         yLA98VlPG8FyneBa+DUV99yN9Wqalfcn3kojELLkXem7ctrUHLuKlqB3CitFsvMhhta0
         jIuHiJUNL+ENE1cJ/J+voa+L0QYRYmWWPqooRvbq09N8IGWbW6F/zydViVBxyGbUjMhH
         Alew==
X-Gm-Message-State: AOJu0Yx1U7RHo33WKgLwtIQa8avi0wTUS46TrzbavDJzaIPLIEJZkPHJ
	HBfU4gD+S6ovxrhpfk3Tqlqzi5bg7pAUuoyKwLM=
X-Google-Smtp-Source: AGHT+IFihwckRwPj1sYEoQgYUkLurfzSpN6Kl5Q5syPOkuXTGfqkOp23qHjavxZpVoH/bnWn8Rsqc1uG1SHu6/wsMbw=
X-Received: by 2002:a05:6870:9f01:b0:203:7035:8a83 with SMTP id
 xl1-20020a0568709f0100b0020370358a83mr2710796oab.85.1704479410108; Fri, 05
 Jan 2024 10:30:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <566ABCD9.1060404@users.sourceforge.net> <8d614254-1cba-0379-cf84-52ad9bd9f3a7@users.sourceforge.net>
 <e90eea03-d7e4-4c0b-88c6-749e3528d4a3@web.de>
In-Reply-To: <e90eea03-d7e4-4c0b-88c6-749e3528d4a3@web.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Jan 2024 13:29:58 -0500
Message-ID: <CADnq5_N_pQr+UfbO8OZ0tEXRQkQB6A7kbZtv4+Ag75GTkgvxRQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm/amdgpu: Fine-tuning for several function implementations
To: Markus Elfring <Markus.Elfring@web.de>
Cc: dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Chunming Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Monk Liu <Monk.Liu@amd.com>, 
	Tom St Denis <tom.stdenis@amd.com>, kernel-janitors@vger.kernel.org, 
	Julia Lawall <julia.lawall@lip6.fr>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 1:15=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> > Date: Sun, 18 Sep 2016 18:38:48 +0200
> >
> > Some update suggestions were taken into account
> > from static source code analysis.
> >
> > Markus Elfring (5):
> >   Use kmalloc_array() in amdgpu_debugfs_gca_config_read()
> >   Improve determination of sizes in two functions
> >   Rename a jump label in amdgpu_debugfs_regs_read()
> >   Rename a jump label in amdgpu_device_init()
> >   Adjust checks for null pointers in nine functions
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 68 +++++++++++++++-------=
--------
> >  1 file changed, 33 insertions(+), 35 deletions(-)
>
> Is this patch series still in review queues?

Doesn't look like I ever received it.  Can you resend?

Alex

>
> Regards,
> Markus

