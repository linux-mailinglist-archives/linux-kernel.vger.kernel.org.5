Return-Path: <linux-kernel+bounces-75137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A893985E3BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB281C22715
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5469082D9E;
	Wed, 21 Feb 2024 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6tuaSvc"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8E082D6B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534177; cv=none; b=btL2ALZkt2HzNSSrUfo5dnNNipSwfiTNKp4/9LbOxMY5Spv5xcfRo5hJ3Msl8UeJmvHy3n3rs09xDN8crmZhwR7i7U3EJmMi4BhrdRZDByu+1+vrmLV9pEr+IoZZivreHYTyGz+IIoORyObHA5yNJQsFUapxjiimxU5RZ4IkJgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534177; c=relaxed/simple;
	bh=buIZwIkqE14JxpgXNB/mnqOwiVrdeBEvFEjIp3BlXaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=As78DcBxFV0FfrDsh/u7vnN3A4RMqQdPJrAITwAyw2f8xIKvUd8L98pnD2cQ4sKD3DlZcFC4582KKFOyxZZ6dpTCzfH3haevhDdCsMQJ86lgjhp+Rf4lXW6dRHaqwYzqJPPf9JDSmpRmmSCOQkpa13yYuwOHeAdZxeRfmBOvc3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6tuaSvc; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso6623651276.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708534175; x=1709138975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7DFQDZc2t2UqTzC+tGr7AXfCBBtBVxZhziymIpi1W4=;
        b=P6tuaSvc5GyxIAWOfgf+Kv4J7YyJ5gyS1l73MFCokNRDCoSPAKA/z1k8Nol5qcSIcF
         IoRaH/Jk8YBXq0AzAYD+qsDfR0JS7TFyLI96hpfLowwbqLfbHFPuUu3AP3+ptKiNkbs/
         J2zikEpU/Q87NhZYz4YrEr9SlaKOmwh00lbb6N/C7U15W9OXxJrZYcQn4npQ/EYjHzPs
         7sYhkW+h13bgE5Hl426vkdJXQbUm9K2kAPLgk6U4rHdw0gB3fd/lJLy4AWMJv54v1g83
         78rvEW9BUjLHnrfM7n3yXv7tIQkz+3e2esDTGB3OPeKVD2CznuqXJLPQb3OuO1qa+wma
         mS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708534175; x=1709138975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7DFQDZc2t2UqTzC+tGr7AXfCBBtBVxZhziymIpi1W4=;
        b=g6qOmRnRtV1BoQLEwBKilWsERr7WE9OVw8n+iJjnq+hQ2pUNsEYlvVRwkVb/YmNd83
         usEgsVZ5JHrQ3zKMOQI72JJUiFrsyIYu6xbIx3lGMaokD4TUKCmQbxL77j9x5cEotCHq
         CsfHk7GXgT0/B2YBDnCUovoo5WMo/ymPH7n0ipkykrSfmGQglf/iiEB2/uPdKgX+5isr
         mJsLNbzVgclIqjylEODZ04E0TqjnpIoowdUaddCIFnNL0QQAMD5ZSkss3g0x4JSMuk8I
         jURMcD4I317s9aIfyaTSG6VuXCt8cXmiBRfbIF1LAhsF2oOoghrqurrgXPiiLHjTHXgK
         fifw==
X-Forwarded-Encrypted: i=1; AJvYcCVOFiPDKX0ns53KSZXmqbes+5HdNYbM4x5bPy2mSnWtyUQNBvnQWYD5KkgKxFlpRy6KimR+8NVO9pEkNILqUpX3mWBl6K5a6rti/0F0
X-Gm-Message-State: AOJu0Ywk6OBxRIKSIh/xPo2chjNK9gXtG56qyO0p/oQcIIUgmGfEnpsI
	xgEsp+F0x2wkfXEkEtu4Gw+Mmey++NgnaEQ4PawNBKLZptKVYZtM42U4D4Kx54CGh/pj61O+dYf
	1wqxGxS0b2rL7NbMzdl5gMUqsat4=
X-Google-Smtp-Source: AGHT+IH7+elu+0mtSRdBVbREWBEpZZtDDuKz0/jM/S5iPdGbP9NoFfxKFcp7qBJeMtcGNZPdKV5x2Ilr04mEKMcZj9c=
X-Received: by 2002:a0d:d602:0:b0:607:782e:fe12 with SMTP id
 y2-20020a0dd602000000b00607782efe12mr21487087ywd.34.1708534175176; Wed, 21
 Feb 2024 08:49:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220231424.126600-1-vishal.moola@gmail.com>
 <20240220231424.126600-2-vishal.moola@gmail.com> <ZdVvzu5OrdUoxc-O@casper.infradead.org>
In-Reply-To: <ZdVvzu5OrdUoxc-O@casper.infradead.org>
From: Vishal Moola <vishal.moola@gmail.com>
Date: Wed, 21 Feb 2024 08:49:24 -0800
Message-ID: <CAOzc2py2PEV9V6WFpgyYkHxpYUk84i40+USFPMiXOV=R090VaQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/memory: Change vmf_anon_prepare() to be non-static
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, muchun.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 7:36=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Feb 20, 2024 at 03:14:22PM -0800, Vishal Moola (Oracle) wrote:
> > In order to handle hugetlb faults under the VMA lock, hugetlb can use
> > vmf_anon_prepare() to ensure we can safely prepare an anon_vma. Change
> > it to be a non-static function so it can be used within hugetlb as well=
.
>
> I think the prototype for this should probably live in mm/internal.h?

That does make more sense, I'll move it for v2.

> > +++ b/include/linux/hugetlb.h
> > @@ -272,6 +272,7 @@ void hugetlb_vma_unlock_write(struct vm_area_struct=
 *vma);
> >  int hugetlb_vma_trylock_write(struct vm_area_struct *vma);
> >  void hugetlb_vma_assert_locked(struct vm_area_struct *vma);
> >  void hugetlb_vma_lock_release(struct kref *kref);
> > +vm_fault_t vmf_anon_prepare(struct vm_fault *vmf);
> >
> >  int pmd_huge(pmd_t pmd);
> >  int pud_huge(pud_t pud);
> >

