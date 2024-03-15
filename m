Return-Path: <linux-kernel+bounces-104692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985F887D26A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A532B2583D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14BB4DA0C;
	Fri, 15 Mar 2024 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUfF8Cko"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08374C637
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522276; cv=none; b=FaJOGsUOg5sUYfVTwb/cEgn5wMisXLqXD7zHFgReDS3VOVVhJrJ+LnwKZiMiFq6r4kAkThuRXFx1URjIWRERxUql8Z2gMct0par3Wm4VsqMecmsEnVZ30qAtZaC3Py5VbRjyF6BaWgmbKhpFeU43JyMqWI6CP1kcasVraKpVkUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522276; c=relaxed/simple;
	bh=31Eem6k0p+zMuW1D6/xbgv2q+n+2sawV1sLU3/qFjwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCCDTgWKe1SWCxZmdb7nJxdJBcz+0GGztfCWOmgfCnWA+Ue23hromolgq0fp4U4VmVgGjTuPK8TAaV2pSwS/qzIIvl89/8GQNzl47HLjjclX2wJolN6msMx0CQ8UTCVkseg8m0NSL2IqbsTXtnTFjm67pMmS0ursTDJW7oSL5lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUfF8Cko; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36649b5bee6so3361195ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710522274; x=1711127074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/n1xeNQpebl3jFBaZdpI0WmhzQF4Mfu0SPL7B6gS+uc=;
        b=hUfF8CkozVu3/2bkYNoJq5HaT9IG/QADG0nkMGLfGOlcdKsykFvsS4hGABz4Uy6Qi8
         QWQayvb0rq2KPX/QMUF8cUkag3FKvbb2psAXZqRBr5dCbwwpJnHGL6kD4ixXwHezIpsY
         YsVGOOGXiNMkDi+rHL6kiTA5AyRZxHnRvEmCcEDvz8iO7W1W7+B7JYoO7jut3w6rKYow
         YCBpZhIVAKngOqSKGCM5WGHaWsDZ1EZ+AdJtvD31z3pHoEQNw9P2PJ/0IMOgrsrV0hsl
         MoWEoB0utWrcT7pilRqoLHsDvaut4fVVoa453jwb60gyME6/mkWmHyvDUOoz6/91d1LO
         WJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710522274; x=1711127074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/n1xeNQpebl3jFBaZdpI0WmhzQF4Mfu0SPL7B6gS+uc=;
        b=lZI3CfYyLFmI30p9Hp2im9gcxYEHF/fEgPVpNQsC7esMhXEbFdCOxWZX5FPCOc31RF
         3LWcXEb12pBOmBwIlgMd6Tl/R9kApLqMZEd6PkIos/quGycyCUKTKZPkblPnb959nN+n
         pkFkVcx0zv6J+XZFyZRtZ24UCdwbtVAO9ygPJxoXWz//qyDhCyMb6EWqgQYJIFobZw0H
         CRuwN0eYZb8HMm0QA+V8otIoK5Dc9MX8Q2OwNm4MyYutjCWZp6wCFNHo1EsilCsEuUKD
         dVv6vMDHQ93m1ZwUHJpnEhj8eKFCIlMwLwaq5ekVpKybiD/Kh6VXzbLGAN7v0vAxwhU8
         ApCA==
X-Gm-Message-State: AOJu0Ywz9Caxxbfu8On5EhS71F7cgUvT+kRyJriNrllqwlSvxkfGY9LW
	iGqSWnI4TfIxHmYGolmm5WCuCjCInORpz3lzzODs/BHu1MwHahbhzYc0sWvDsa8kkH1YUdbvU0s
	Eldfz35QXcRBnrusKh1sjzXdgMFA=
X-Google-Smtp-Source: AGHT+IH/KL10XdpRmB8frmXIW3tEVSZhML+fAWX/lU2MVkOetCkgih0H39jek47xGPKD8uWSnh6NEBUcxn27OvXiy48=
X-Received: by 2002:a05:6e02:1c0b:b0:365:fe09:6431 with SMTP id
 l11-20020a056e021c0b00b00365fe096431mr3617938ilh.3.1710522273700; Fri, 15 Mar
 2024 10:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315091434.10622-1-dmitrii.bundin.a@gmail.com> <CAADnVQ+o9WQNdY2iApYMN=KnKSxnKGb6NcYzYkDD9V36Di6bCw@mail.gmail.com>
In-Reply-To: <CAADnVQ+o9WQNdY2iApYMN=KnKSxnKGb6NcYzYkDD9V36Di6bCw@mail.gmail.com>
From: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Date: Fri, 15 Mar 2024 20:04:22 +0300
Message-ID: <CANXV_XwaPOOYuAsveVbfNU4tFbw30rkX3AKrBdKzrNNsUxer+Q@mail.gmail.com>
Subject: Re: [PATCH] tools/resolve_btfids: Include linux/types.h
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	Viktor Malik <vmalik@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 6:41=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> No one reported this, though lots of people
> are building resolve_btfids that uses this header
> as part of the kernel build.

GCC version 7.5.0, GNU Make 4.1
Steps to reproduce:
1. Check out the commit e5eb28f6d1afebed4bb7d740a797d0390bd3a357
2. cd tools/bpf/resolve_btfids/
3. make

The steps above produces the following error messages (similar error
output truncated for clarity):

In file included from main.c:73:0:
/linux/tools/include/linux/btf_ids.h:7:2: error: unknown type name =E2=80=
=98u32=E2=80=99
  u32 cnt;
  ^~~

The other sources including <linux/btf_ids.h> usually includes
(directly or indirectly) <linux/types.h> before which is not the case
for tools/bpf/resolve_btfids/main.c. So that looks reasonable to me to
bring all the required type definitions into scope explicitly in
linux/btf_ids.h. Any thoughts on this?

