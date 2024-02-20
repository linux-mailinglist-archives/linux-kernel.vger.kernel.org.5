Return-Path: <linux-kernel+bounces-72458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F047085B3BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6758BB23BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7B35B5C8;
	Tue, 20 Feb 2024 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXCgnMRH"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2F05B5BB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708413382; cv=none; b=ijVMcJAJq5YKvkWCSMSDQs2cGQHre/xc2rOF4lbywUXPPum9qc/Y8E3doJ8jK03QxsEAGNyRRy7YukHbnMCkxnlf2Y41eBdJUpGS0dAhrn6P6RxvyqEXZJCMkfJLLGqmR16JSjXRSRTq6Dlip76l6TfTqBKNH5OQhstad8DgkSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708413382; c=relaxed/simple;
	bh=sjSnzcueANrVxDHSiTSIdj8mpFTdy6IKk/WEGATL4Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwbIeg33xaVpFLU9akClskQJ3PBAnwe6Ru4B0svn99i92YpwaUkdrtSKCoCdxkGnF8xQsfGnpfAwarsoeRG6lgVq/LZL0xfW4hKt7+SuSj1vRh4pe7h54PUwaG/TaoGWiVSCL4BZxdBBGYuyxD7oGgal3+3qONwIG/b+H/ms0gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXCgnMRH; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7cedcea89a0so3228275241.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 23:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708413379; x=1709018179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjSnzcueANrVxDHSiTSIdj8mpFTdy6IKk/WEGATL4Hg=;
        b=UXCgnMRHcsSHd8x/dufxf6l1RioRXosQFKGLNSZ3MnwZ1jawvDU8emRsuW+N1bQY+w
         qriQTOGqeOXmsOqAh0zSwpCuFUv7NnWxfzDdNsEj1sr+1xvIIOOCeHq8ENOb3s1cAHby
         AgD3HHz++Xk5NsYPEtE2KZgc4nMree2En3cT98wlp3xQLISsZ7jaI8r0p8uGbLyfx147
         gPFp//ilFRVVbV9y1fBiDxibRJYWC7oUyE0AlGinDSAbY8GGt6SXABE9gQ1VlM3JNfwu
         OAhyWPehyrabas/7bDywUX72SU2uMZHaMPrxm9QlMaB3uBza1UjCq7xikfqrUDYKxtSg
         qRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708413379; x=1709018179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjSnzcueANrVxDHSiTSIdj8mpFTdy6IKk/WEGATL4Hg=;
        b=rglidzqrznHvlrHffZy+d1xZy0FUPME+NrL0oDm33Th2Piy9Z/rn8l4YZFxNO1zJ8j
         S5fRsmQMDkfnEmo3LHFNBSeSY6RaZVFX4vyUCALr6Y+EaN6BE00oo81MQVV/ScgeLw5+
         sdv692sCf14H2KmMfGUe5QqycUL7ZWJnw4P2ZAXP0kK9qKsAp4LjoVqfHk/2iy2eaMXg
         YRPuqi/y+2Q9qvgM9k9fxmiueB3xP2t2VpvuxTP2Yck95cvW1WBwlWTAJAy+OANx1w+E
         R8y8fZhgK8yy03HmLyMQLSxP26z/wd0N1poKTWDgLw8/zlYFX9N5nc95kFzfJedjJmKK
         6AeQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2FqAJzTocERVsk7d8VRSYCqQYQvXsRn5BJ95Jg7WYYCfYHKt7U1jLR0pmJQYxr82EzeeSEhlaFgfcUGkkupt+XVxb3rk4H3WGVuYF
X-Gm-Message-State: AOJu0YzMVzO3QpIWeSpyHRpmg1fSIWy8EPquYyfzlR7rXLa1IqNARxmQ
	/uhTts9Y/rgpKB2HWdk1ze8+6LLjyxC9TLEHrNJ424eIcbGccK9QN62chidV1YRaC24RZtqL7YO
	eAFhu54Ax9h0bIGd8mm7HrW1+VF0=
X-Google-Smtp-Source: AGHT+IF4m3dgoSMmOTM4bk0KoXHGseYv3UMy+OTOQ+OvzblAw7CY3DMgupyPNvuJ3tBg+ruYSxeWUDP5FHgbfoGuQEc=
X-Received: by 2002:a05:6102:3751:b0:470:40f1:a185 with SMTP id
 u17-20020a056102375100b0047040f1a185mr7266227vst.13.1708413379290; Mon, 19
 Feb 2024 23:16:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219141703.3851-1-lipeifeng@oppo.com> <20240219141703.3851-2-lipeifeng@oppo.com>
 <7c648dac-3198-3dba-0a96-34798cfdbd99@oppo.com> <CAGsJ_4xPDUgcYxNu230QC--ZiKV71nJJ+v0LVR7yF1io+TiLdA@mail.gmail.com>
 <8ea640a1-fc2c-a6fa-cf4b-bb8c0b694b4f@oppo.com>
In-Reply-To: <8ea640a1-fc2c-a6fa-cf4b-bb8c0b694b4f@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Feb 2024 20:16:08 +1300
Message-ID: <CAGsJ_4zrctJbGZ6EwTJh5PadG_1Vk09Djw8Vd+hzvorq_DMfig@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/rmap: support folio_referenced to control if
 try_lock in rmap_walk
To: =?UTF-8?B?5p2O5Z+56ZSL?= <lipeifeng@oppo.com>
Cc: akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de, 
	willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	tkjos@google.com, surenb@google.com, gregkh@google.com, v-songbaohua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 5:00=E2=80=AFPM =E6=9D=8E=E5=9F=B9=E9=94=8B <lipeif=
eng@oppo.com> wrote:
>
>
> =E5=9C=A8 2024/2/20 11:01, Barry Song =E5=86=99=E9=81=93:
> > Hi peifeng,
> >
> > On Tue, Feb 20, 2024 at 2:43=E2=80=AFPM =E6=9D=8E=E5=9F=B9=E9=94=8B <li=
peifeng@oppo.com> wrote:
> >> add more experts from Linux and Google.
> >>
> >>
> >> =E5=9C=A8 2024/2/19 22:17, lipeifeng@oppo.com =E5=86=99=E9=81=93:
> >>> From: lipeifeng <lipeifeng@oppo.com>
> >>>
> >>> The patch to support folio_referenced to control the bevavior
> >>> of walk_rmap, which for some thread to hold the lock in rmap_walk
> >>> instead of try_lock when using folio_referenced.
> > please describe what problem the patch is trying to address,
> > and why this modification is needed in commit message.
>
> Hi Barry=EF=BC=9A
>
> 1. the patch is one of the kshrinkd series patches.

this seems like a bad name for the patchset as nobody knows
what is kshrinkd. maybe something like "asynchronously
reclaim contended folios rather than aging them"?

>
> 2. it is to support folio_referenced to control the bevavior of walk_rmap=
,
>
> kshrinkd would call folio_referenced through shrink_folio_list but it
> doesn't
>
> want to try_lock in rmap_walk during folio_referenced.
>
>
> > btw, who is set rw_try_lock to 0, what is the benefit?
>
> Actually, the current situation is that only shrink_folio_list will set
> try_lock to 1=EF=BC=8C

understood, as you don't want contended folios to be skipped
by scanner any more.

>
> while others will be set to 0 that it would wait for rwsem-lock if
> contened in rmap_walk.

ok. other reclamation threads will still skip contended folios.

As discussed, the patchset really needs detailed data to back up.

Thanks
Barry

