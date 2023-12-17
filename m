Return-Path: <linux-kernel+bounces-2826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D20C5816281
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDDE1F21B7F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4223E49F74;
	Sun, 17 Dec 2023 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWHm5WXk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5FC495E1
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4258ca2ee9dso7187401cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 13:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702849176; x=1703453976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3m+jVYqp6EcLXJ5MZmOR+viJOCSvxMGKIzUXoWZT6+4=;
        b=MWHm5WXkRxWChIUQ5NUrGLcppt9XjUGQNQd3D4KIRWbZA1RZIF0L4iC+Iwe3dMExon
         mt6GPe7cCForUid7NHD81NpoMM3zdPMvCXN37ZWoQ6Regk58gTv2+ac/VUtrDTTf7tXb
         NLVGsO7bM2oXY6qUxmSEdT97Qbzn5IVeEIA1+Hkuqt5T6vijVRMRDpf3hdor9/4WD+jp
         Q+pNU4Uf51rDc3eboOKWhk9aRc154jy4s/kWNCmKBhAj/jIxBfJwr13RRvv/eJA0vpfj
         Q2ftc3mC61Ekwll6hdRNXpTwzimPxTc6hQjQho2hpj1tM6ia02giSarEADnuWRawYUlf
         sNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702849176; x=1703453976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3m+jVYqp6EcLXJ5MZmOR+viJOCSvxMGKIzUXoWZT6+4=;
        b=jhqKBYn6ErPVkTJWDDIeiWxzrqufDFc/5j/7mzOJr6Dyoo4JcNtk3hh2n5lFSYDrmW
         zYblcefwbTY1Z4Zqe0UJWfP8NG+Yu+BGZsTc+JcO6HqI51WRxOeULLE0qJTpIP4egyxQ
         uihvNn7C0GHJ59TOElem7yqimrf4GwRhQ0cK1l8oHicrI3nJX3njCFHGOtspJFwdzzZl
         uR6Z5bSJ/5RnVYZ55GsiioqKFPsBqrBEYO+xmwxOA7zsOpA5ZQ4ihpfShYkCwp1Yjiya
         4JN6MU6j56RIqMEmHboEyiF3uLvvM/qsNhp+wBF2bc6iOdQNSIwpgdBriyFFXY0Jxtep
         MPsQ==
X-Gm-Message-State: AOJu0YyvqcrwgXkrwrigf9nTYPP0kL8C7mUz94cIpnh1V8MraqLfurNT
	5ZX9PTaEgeShvwqNIl+iIW5OtDxpm4kr8mlmbLk=
X-Google-Smtp-Source: AGHT+IGwtlG0iYeuePZ8xUWo+zC56EnNODNKOb/8LKp9UBeZ8RrgL2+kY3r7chk8zMGQcxxG2CcbKZdqmnp8p9LKCDQ=
X-Received: by 2002:ad4:5228:0:b0:67a:a601:ce4 with SMTP id
 r8-20020ad45228000000b0067aa6010ce4mr27159450qvq.6.1702849175956; Sun, 17 Dec
 2023 13:39:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
 <886c29fc-0b0c-4f7c-a2fa-f015a2b51fa3@amd.com>
In-Reply-To: <886c29fc-0b0c-4f7c-a2fa-f015a2b51fa3@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 18 Dec 2023 02:39:25 +0500
Message-ID: <CABXGCsNY2aR93pX0AtWUZ1v0QLj3ANoDmS13HCcdN-c4htHbtg@mail.gmail.com>
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: alvin.lee2@amd.com, hersenxs.wu@amd.com, daniel.wheeler@amd.com, 
	"Deucher, Alexander" <alexander.deucher@amd.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 9:14=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.co=
m> wrote:
>
> Can you try the following patch with old fw (version 0x07002100 should
> be fine)?: https://patchwork.freedesktop.org/patch/572298/
>

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com> on 7900XTX hardw=
are.

Can I ask?
What does SubVP actually do?
I read on Phoronix that this is new feature of DCN 3.2 hardware
https://www.phoronix.com/news/AMDGPU-Linux-6.5-Improvements
But I didn't notice that anything began to work better after enabling
this feature.
On the contrary, my kernel logs began to become overgrown with
unpleasant errors.
See here: https://gitlab.freedesktop.org/drm/amd/-/issues/2796
I bisected this issue and bisect heads me to commit
299004271cbf0315da327c4bd67aec3e7041cb32 which enables SubVP high
refresh rate.
But without SubVP I also had 120Hz and 4K. So I ask again what is the
profit of SubVP?

--=20
Best Regards,
Mike Gavrilov.

