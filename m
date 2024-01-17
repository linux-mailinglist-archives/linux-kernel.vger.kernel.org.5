Return-Path: <linux-kernel+bounces-29173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D53830A08
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88F2CB239D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C21321A16;
	Wed, 17 Jan 2024 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehvX45cL"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8260121A0A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705506651; cv=none; b=sv9L0B790ivGZHPlMp2GUsUDoWoNlYxgFQULFOsqZBhXDWDSBNO9S+JQwwl8Mft8UXT9b4shkwW4PIbkmiC13W66VTbBr4AjnK48D1rcwdpkOO965JkEM0INfMtMvFz16SghppClErMHMfTYQ2+HodP2I1Q0rVK0ZI9xoNbJn38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705506651; c=relaxed/simple;
	bh=xSYpslgPqu0ADS1KRiqylr9PV+jhOYwPpXOXvMIDDhg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=q31Lrxv1eAoFPfLgdnI+05qf5QhryFqxBuQFLiXQw0HGOzlmzkuLlNrMNqevK2a0cJ1sW4tpj4bsOaSu0tDW4Z1WCKaqe5s8nUoXl9Gta9UMkvo0vR6SpKSqCyKWIdhIOfsPg4q3jz6hJ4qdYFrd79Bme8f4gUFlROz0dq2PmUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehvX45cL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-557678c50feso2860705a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705506648; x=1706111448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSYpslgPqu0ADS1KRiqylr9PV+jhOYwPpXOXvMIDDhg=;
        b=ehvX45cLWKuXJy+hA0VE10qA2/2w4kq1EXADRNUMJJ5ANDd+M36bdVs2EgV7sw4XNA
         qXxH4asul2HGqiIT9XOmwI6WRKvJTfpVNDxFb385DrJzWPt8Y3rernVInFvRbbD47jPj
         cvycaaDUN9xiEEDH5XVFv9aWi+9SN31/lVSk/ahoVNyb5L/l6JadBOkUuPOWdWiwoeA3
         HzMBzN3HMjsn3FKuml5Qi/E2GGHnh4mfsZu0zGeDb5hVs5tN/Bwgplo8NVWyxSXbwwEo
         PZ06YB+Kl08zBbvrpEGNrJt3QGHKFRLr0cxICCOhPstTMfgOaL9S6gXwbYqpkSkn/FCb
         LPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705506648; x=1706111448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSYpslgPqu0ADS1KRiqylr9PV+jhOYwPpXOXvMIDDhg=;
        b=WFuY31Yqh+NXGLP+XVshZwNRHMoA4mkzc/ybILhxslNwI3j7vr9Dy/cuza5bxYGHeo
         e0cnDLo55SGpk+kdlKgAqpwkucGsfrzkfNVkWBmc3WfAAsNVA8li7OT8nRZ4V6ZH8yke
         gmLQj08shTz1RYAFo+KMY9LrhcHvCaR5WgRD5Ylqfpn2EeWyIFrBTEGj6lTKJkhSVUlZ
         3y3gusIDKjUavO4IN8pj2bcXd0r5WyKZQ/jxSnPbib3QXnjQlBFr6IkG9NHwTzySytp5
         zxDcdQ/IeooOnrHZqbYCebMRAr0fhETSdySox17pz0A/t5aaavSaPSadPvtKFpP0kH4w
         3Olg==
X-Gm-Message-State: AOJu0Yzeuo3wz2h7PgTwOWjUm9UVbJZ3Bhw+f20uTCxO5ohm/ia+UnPU
	1Zbtp64e4EMa2YjJ64MhxCJwojuuXhCod+c3gNg=
X-Google-Smtp-Source: AGHT+IH+mfJ19/KktxfluLxfE5mB/RmmM9caU/WPO9DJMztL3Aa/mXpZ2vFGvUOTe6Z4CcxTCWzNBMhYWWpR3qysM6U=
X-Received: by 2002:a05:6402:22d3:b0:559:c036:8456 with SMTP id
 dm19-20020a05640222d300b00559c0368456mr2375075edb.4.1705506647486; Wed, 17
 Jan 2024 07:50:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+uifjNcZbb6=9-o9_cWCMyXRFZPHhyvWS2mys-YhfP9gaJ75w@mail.gmail.com>
 <97843013-7e06-449c-8418-3890657b2e26@redhat.com>
In-Reply-To: <97843013-7e06-449c-8418-3890657b2e26@redhat.com>
From: Karim Manaouil <kmanaouil.dev@gmail.com>
Date: Wed, 17 Jan 2024 15:50:35 +0000
Message-ID: <CA+uifjNw0W=EaUHbhq_CN8uOj0H_Yfu9JKSL1=EH6dnYkN3-ng@mail.gmail.com>
Subject: Re: Debug: mm: meminfo reports 222GiB of AnonPages but sum of RSS in
 ps is barely 400MiB
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 2:15=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:

> Maybe we have something call mmget(mm) but never mmput(mm)? Are you
> running any OOT drivers or "special" hw?

That's exactly the reason! I was writing some code to count the number
of empty page tables in the system
at any given point in time. I called get_task_mm(), but I forgot to
call mmput() after that, and thus
the memory was never released.

I should have double checked, but thanks to your remark I immediately
recognised the issue and fixed it
(maybe I should have posted the code as well and mentioned that in my
original email).

--
Cheer
Karim

