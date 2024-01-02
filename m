Return-Path: <linux-kernel+bounces-14730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3B982214A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 19:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD681F2360F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E38D16408;
	Tue,  2 Jan 2024 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wEsup0WT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C41F16406
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dbe344a6cf4so3125714276.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 10:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704221147; x=1704825947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ngka6IT40Fw6PoiMJ+TM3W9xIUBetuAjqymyxWt43Pc=;
        b=wEsup0WTpXI0F2LiUc5qKRse4K4X65otA8XAv1189+RAKxSVPEFlAYxCpmkNuiXzXB
         9r8znPOz/Ix2leACPPQNt2cGwNYKA6iUbRg+CH51SQYhWZt1mFpY9Vpj5ZX1KTLunNiZ
         ZyZCKOkt4Fu2iSGv7T/6QHGtkV4rhHN7ryukMbU2ZqLJ45IF3MlP+01l2rw9kbtbvOSS
         8BjSrJT/aJze8B0EAbG2+Y/bFk3wxCTQSKkECQS3lZIv9R1NKzx89vXmk0eIJeFF9/l4
         YxEdTAJ6+VMpHdGHjyRpNXTU1ldXsRASvKpt289JrFYdjf7w4xPEtNrdinubvOsnLEdD
         ETkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704221147; x=1704825947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ngka6IT40Fw6PoiMJ+TM3W9xIUBetuAjqymyxWt43Pc=;
        b=Ta47Er6LVOvPFz3b1we5bWJJsIy+/jkFmCOpSunsQo1USVC0feuRAcUHSfk50v0JMJ
         rjfKf7Rlfi4H7HeDAZfEaW7KPoEC5UquXRbBX+rH5FXB7BTdfLjVdM6thldGvIVMRTnz
         dM8CrNpB/vlm52GuYSPxqX0Tl2f+aFbM+iEH+QH+3azqvnbu5K2kJoVA7azZXZ9hcEGw
         L5qWaJ+e9K8iQGW3olc4/YdKPEVroJssqtS8NVSCMvceT0+9eCtACToanxBNFLhunTOu
         Q07bJyDJ56KuycjcRlstyVo4S6/RByPz7bIqo6frtJQUevaL2vadiQi77Zll3dY0KO73
         Dd1Q==
X-Gm-Message-State: AOJu0Yxldh1nP7DPWaoNYBGiwtPVlxMcVeYkLU0HvXLnOcT15vZZL2+z
	uuOj341sPX81RA/g0rS4Cmth18P1DdxwW9Dplcy+8Df/GIlzhw==
X-Google-Smtp-Source: AGHT+IHiRLTu8sWrYtFmtBguckCV+Ulk2qk99ABhH+DBNV/zPcXEoA9AyWxcQNOARAquyuBqDpnbvL8uY/t0TU3Db/8=
X-Received: by 2002:a25:6992:0:b0:dbc:fdd7:e78d with SMTP id
 e140-20020a256992000000b00dbcfdd7e78dmr9440179ybc.28.1704221146972; Tue, 02
 Jan 2024 10:45:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222235248.576482-1-debug@rivosinc.com> <20231227134514.13629032c39decdf1dddcc75@linux-foundation.org>
 <ZZQWE0wFdtHP-3dh@kernel.org>
In-Reply-To: <ZZQWE0wFdtHP-3dh@kernel.org>
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 2 Jan 2024 10:45:36 -0800
Message-ID: <CAKC1njQGqUPc2O+iVcRWMRRPYi0WM+kDgzCQaY_-SNsJJQsHww@mail.gmail.com>
Subject: Re: [PATCH v1] mm: abstract shadow stack vma behind arch_is_shadow_stack_vma
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, rick.p.edgecombe@intel.com, 
	broonie@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 5:57=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> On Wed, Dec 27, 2023 at 01:45:14PM -0800, Andrew Morton wrote:
> > On Fri, 22 Dec 2023 15:51:04 -0800 Deepak Gupta <debug@rivosinc.com> wr=
ote:
> >
> > > x86 has used VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) to encode shad=
ow
> > > stack VMA. VM_SHADOW_STACK is thus not possible on 32bit. Some arches=
 may
> > > need a way to encode shadow stack on 32bit and 64bit both and they ma=
y
> > > encode this information differently in VMAs.
> >
> > Is such a patch in the pipeline?  Otherwise we're making a change that
> > serves no purpose.
> >
> > > This patch changes checks of VM_SHADOW_STACK flag in generic code to =
call
> > > to a function `arch_is_shadow_stack_vma` which will return true if ar=
ch
> > > supports shadow stack and vma is shadow stack else stub returns false=
.
> > >
> > > ...
> > >
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -352,8 +352,21 @@ extern unsigned int kobjsize(const void *objp);
> > >   * for more details on the guard size.
> > >   */
> > >  # define VM_SHADOW_STACK   VM_HIGH_ARCH_5
> > > +
> > > +static inline bool arch_is_shadow_stack_vma(vm_flags_t vm_flags)
> > > +{
> > > +   return (vm_flags & VM_SHADOW_STACK) ? true : false;
> > > +}
> >
> > The naming seems a little wrong.  I'd expect it to take a vma* arg.
> > Maybe just drop the "_vma"?
>
> I'd suggest to use vma_is_shadow_stack() to make it inline with other
> vma_is_*() tests.

Noted. Thanks

>
> --
> Sincerely yours,
> Mike.

