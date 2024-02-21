Return-Path: <linux-kernel+bounces-73982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE0985CE5F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE36281F94
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA542837A;
	Wed, 21 Feb 2024 02:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYo3xyh8"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63623883A
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484099; cv=none; b=qOuv2/+61g82iJ07yTk96twnN/z732NY3vJAikppcelmaIDnk/DEFpYo6F6CmfGOszlGOCpMrL1706cWolahUSjd+2X1ClK0UtP9/rVa+Lb43p329RgFAAf8H6ln6uW7XIG7/UZsjCEUJKNfJBFozYVj0c7jTtaOJZKv00fAjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484099; c=relaxed/simple;
	bh=YBKD/G9CSyDPbKp+1m1vo+5byl0sayVwUT7MMT1YTxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cG/ijhITOpEz/544P/097KEDaRtUPYkMhDakwHe0DuUvqlUL2BfmvZrQF873k+c7ApUJ0H8nXDArxjpJz6qP15U0SPjFXdQfgaLK3qHkilzDbiU0wFoXBJlftAOov/FprBqwK4xvrmkidXkBnGGDfDA+uw21eB9yi3rqfAYBTEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYo3xyh8; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so5193908a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708484097; x=1709088897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwE0MS/64X25Z/y4hbsuz3KSPQ9sE/Fa1smXc6Z3G+U=;
        b=PYo3xyh8CKboar8flZJxJ9NbikUbet/LIQeNOm1Gjs3ULlrKBLLxPfllJ2EvmNtlmi
         fg6b0unAW5qV+Lnsk6oS+CKFAXNi4h6O14n7WJ7Dw2kAH8yL862wUyJQpn6J1brB1PpH
         bj+aJq3/quj85/dRhTJC1KwEdfbNBryE5ssF1b/SKf8aSWY70ioFjLZU2jIW9qtFnvXK
         tdXLY/HhYcHX4zobEIrmVID5RWo6OsM7lW+WJanDoMr1ZgFWvKN//BxHO/huw2xTRecU
         /MH/lmQctSShbjJK7H40gHdIUOEd6OS+riA5iCGsCg1vOHZYrP2dCKI2sGfAIMx14V1v
         0kcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708484097; x=1709088897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwE0MS/64X25Z/y4hbsuz3KSPQ9sE/Fa1smXc6Z3G+U=;
        b=LkMDet+d/diCaOnbXvPF4NNB4eQNanPbyqFx2pPTM5gtJfn7qx3eSatbW6h2jqxWmc
         mhXU9qfjltMjAIH7dT3VyyLvoq4vDjVxfjc5qOwNifI3xA2x0aww00/rvKIPW7YXtJJV
         HPhReTEXL5LVwk8VtzWVQ3B1cPMpHB7zxy+kDMU68VD90Fruj6QmUAzyoTroDAm322+O
         L88SNPaFJP17vgogdjMAhB9TjNT0qQhdcNRzbgZyp3Cppani6NB5cR2eNWUSRJlotVUu
         PrH0CEHR/GtjAOB1bjmf+wS0ixOQ9B4lsCGjQCoypytaSlpxYswQasaMB7HXSEkn4gns
         x8fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj3g+ylHLpY8sBG7Q161XvIFfqK7fvIngYF8gqNUG5ce5WqVTRmvhZaG5xTB+Yc43hjxL4bqkUuu8T/+MXOYSM4BpwCDtkUYEm2xXY
X-Gm-Message-State: AOJu0YzwobmJAoJCsr4tha976blJFnPmgza7jQEyRyTSw9ZMyK33skBj
	ozgf3vI/5UqFCYlQweaPqmMzdMOchOSVFNw0DdHipg93o914MWQnHBOdSDZu2MwlNR/n1i39C/f
	Ugs0oyc6ZDxcaM0EcaqBzslcQmZk573ctAsU=
X-Google-Smtp-Source: AGHT+IEVlwZM9BHLcCDwIIywPoDLeNXsCdSezy3RFANnjV+6XZ7hnvwyMyrTczp2CZz7dz5MiwRK5EcFz1yc8JkP0iI=
X-Received: by 2002:a17:90a:9c3:b0:299:32ee:a426 with SMTP id
 61-20020a17090a09c300b0029932eea426mr10736380pjo.32.1708484097600; Tue, 20
 Feb 2024 18:54:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216180559.208276-1-tj@kernel.org> <20240216180559.208276-13-tj@kernel.org>
 <CAJhGHyCOgrU9TC9o97LpvAEL2p+Dgt=uN0mo01Gr7HadVSD-Ag@mail.gmail.com> <ZdTxisk3zp_eXDVb@slm.duckdns.org>
In-Reply-To: <ZdTxisk3zp_eXDVb@slm.duckdns.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 21 Feb 2024 10:54:46 +0800
Message-ID: <CAJhGHyCvk=uqcjjf-=L64ig2m00qdEuRLSvc0qiJm_SftGqunQ@mail.gmail.com>
Subject: Re: [PATCH 12/17] workqueue: Implement disable/enable for (delayed)
 work items
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, 
	allen.lkml@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 2:38=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Feb 20, 2024 at 03:22:26PM +0800, Lai Jiangshan wrote:
> > > - A work item carries 10bit disable count in work->data while not que=
ued.
> > >   The access to the count is synchronized by the PENDING bit like all=
 other
> > >   parts of work->data.
> >
> > It is 16bit disable count in the code.
>
> Fixed.
>
> > It misses the same handling  at queue_work_node() and queue_rcu_work().
>
> Oops, fixed queued_work_node() but I don't think the latter is an issue
> given that calling work interface functions in the embedded work is not
> supported and rcu_work can't even be canceled.

Hello, Tejun

I think it is better to have the same handling (checking disable count)
in queue_rcu_work().

1) code is consistent with other queuing code
2) known state: no work item is queued with disable count > 0
3) catch wrong usages: some complaining code can be added when adding the c=
heck.

Adding checking and complaining in the code is as important as
adding a comment stating rcu work is not allowed to be disabled/canceled.

>
> I'm not quite sure flush_delayed_work() is safe. Will think more about th=
at.

I think the code successfully deleting the timer not only owns the pending =
bit
but also ensures the disable count is zero.

Thanks
Lai

