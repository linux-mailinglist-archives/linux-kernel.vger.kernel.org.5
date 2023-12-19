Return-Path: <linux-kernel+bounces-5957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C848A819229
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860F628770F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADB33D0AE;
	Tue, 19 Dec 2023 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLRTltt/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5DF3D0A2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 21:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cd5cdba609so3860807a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703020794; x=1703625594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXbTc4Gy/r09/08lo99KiIQ8BjOLq2PAuFNDugWTr8s=;
        b=KLRTltt/wgNGdXOEMwiw4fVj2ZBixP/GGfZXgf5QgxDYqAx0ih/eTnf2nMS47L0F4z
         xMDxpETblJv9wtl+gLGUwb4bP7P9hg6DxXecCTHnVc/pQ0hutCIZPMuQVNfqedP3mUvp
         P2KpqUu6+jZKalbAf23osTptdvh8r35kNHfGLW8OED4bH3EE9TkRCVzAzsmsLi1KcgQ3
         jPR24Blado73p8NReL/cAxuFHzl/BSQPHIfDMQIgaT4AoiuPF6QBqz6O0itk+VH7VD/V
         Aypm3qnGTYtnGmI29hBYWSGjoo4nF1euTVMl/ey67lM/Y75+1BDwF8LC1iYPoZmvlcoh
         7aCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703020794; x=1703625594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXbTc4Gy/r09/08lo99KiIQ8BjOLq2PAuFNDugWTr8s=;
        b=X4BixwTK8dIzQdq05wHM0VOjD+BIzfv5Dep6M5D/LaxSjoQOrSJNUZUKzzcwxehO1P
         nbeQaZmN2Gm2gWuTJlLW6+U70nrxNsqPyHzQfRz+ewwQobmQATnxBUBlVkhci079kh/1
         qXYUvYAGLT+8egJdPU0iTtzsIA8d0OuGpSPHbysiX/QxnpmUHvvge/dLt7ofud9U9aGh
         cDRTNeLojyryNUv0UOZHzkS4Wi5SepSp/Wgb2ST47f2UR2oCUttLIKXCcsLe4sMAsIUR
         d5V1b2MFMCvAJy8sGN4W3R0N3HdVAGDDM+3tSlzq5XspE1O8ecW/RPN2RMma/tTX8RE/
         J9ag==
X-Gm-Message-State: AOJu0YxSp2jdRV+ViiVmbFUpP6eOTE0ySIEh3Cr3BgFvff3SRTb5wfnH
	CChrG5fP/tnSs3mKvdnPkIS5Yh4kieg6gkJ1T08=
X-Google-Smtp-Source: AGHT+IHRQDZ4rbp/lXzXpWXEGFIGz+HS66p3frlV+Z5mCdldu+jipaFTBEr6PzShohW6AvBTwcNoqh6urC7bdOnxgek=
X-Received: by 2002:a17:90a:458c:b0:286:6cc1:780c with SMTP id
 v12-20020a17090a458c00b002866cc1780cmr13606746pjg.79.1703020794204; Tue, 19
 Dec 2023 13:19:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1702514411.git.andreyknvl@google.com> <88fc85e2a8cca03f2bfcae76100d1a3d54eac840.1702514411.git.andreyknvl@google.com>
 <CANpmjNMNhPOBHr_5iyfP9Lo_tOUiG_bpVnS-RkfrP3JccW3yqg@mail.gmail.com>
In-Reply-To: <CANpmjNMNhPOBHr_5iyfP9Lo_tOUiG_bpVnS-RkfrP3JccW3yqg@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 19 Dec 2023 22:19:43 +0100
Message-ID: <CA+fCnZfK9XZnLeVd_Qtc5UKBze_2pUVg_XPfqMiADSUx7FajqA@mail.gmail.com>
Subject: Re: [PATCH -v2 mm 2/4] kasan: handle concurrent kasan_record_aux_stack
 calls
To: Marco Elver <elver@google.com>
Cc: andrey.konovalov@linux.dev, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>, 
	syzbot+186b55175d8360728234@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 9:35=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> >  #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> > @@ -249,6 +250,7 @@ struct kasan_global {
> >  struct kasan_alloc_meta {
> >         struct kasan_track alloc_track;
> >         /* Free track is stored in kasan_free_meta. */
> > +       spinlock_t aux_lock;
>
> This needs to be raw_spinlock, because
> kasan_record_aux_stack_noalloc() can be called from non-sleepable
> contexts (otherwise lockdep will complain for RT kernels).

Right, will fix in v3. Thank you!

