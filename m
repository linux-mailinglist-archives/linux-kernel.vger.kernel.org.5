Return-Path: <linux-kernel+bounces-37262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02C583AD6E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F733B23906
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263AD7A73B;
	Wed, 24 Jan 2024 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDrySAk1"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC0B40C1B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 15:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706110435; cv=none; b=Z7R3AbBQ1TzEIvq4QUzotql/FJd6sQwpJ5vE1unAKAMbJI+AS06M5NxakhwcZhMZAOQ93o/532ak3tqE2AqPaApaAMxcjeQb0vg6S4P4293o1RhBvM11twPN75sF0iqCjrPNtW7SXw9RibjQqRfsQtF6YFmxGa1M3fy7rwWqCMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706110435; c=relaxed/simple;
	bh=TCNxtB333piEg8FONxiPrbu3zbb+RD/WcvnF5gMRDbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=blBjCTStK2XoB0kF2Aj4sOaRfZvo+UGnj+FIchLMoyg196bmKRfmJzr6+q/Oz6tHg05FDKrza4Ea7yQ4lxB+v/fVcHOvv48FtkHH35Pd3m+YW5mO+wmn/80On2WKV9rjngCq+duNYvZhh5R/oSzCk8czHi704HOc0R9i8cPI8aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDrySAk1; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5ff828b93f0so50123807b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706110433; x=1706715233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sF+OHxguRNODCvdH55DenpgBbXkSJhRqehOviUia52g=;
        b=jDrySAk1iO8fz1Gq8sYgFy8qUveLTuKa142H7pQpZ6LhRifyDPN2Iq1PVBmx4SJSXu
         Kgukt/JZ77cEs2ny2sVGHH1Dz3v4JfTNTNFxPTGJhJYx/Km+yPFeDw0SdF9XjA+Lmlg7
         MBdF9luTj5JZtm5c4Fwwh+l6j+AQMib3Ld/lducWs8225L/vAOOf+cYoOBV9hOAc2XPM
         +sH0P20qOfrI1VUvi7jkSp5Mj3cL7JmncaSrD9YU1FxUl0d71rzyzrdKBZU2A11Frswy
         xcLrbnYnlTKxZobxq1ToWK0gL2wTFXTXNVCpdOu2hFfxc6XJXOLM1DmBi86qHIrwbjUQ
         LzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706110433; x=1706715233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sF+OHxguRNODCvdH55DenpgBbXkSJhRqehOviUia52g=;
        b=G3BqcwQRJ8d72/+uvMeflA+aCjd2TztjZ5Fl6qmFImeGWs/uOsodVY1srKDWwc1t/L
         IG16QmESAvZ/vU45LTeENvOI+VDTKHurGcyHqGrDX37VFHBbcRWkuTNRDNI1vKHqgUxK
         RvU1eBHCgGpLaVQil1Mi0nsMO8nnh2CE6ow/3vyC49KIgDWUsv8Kz9drknfa9YcQXwvU
         NbuL0QPofzT4dqLoaS8ydXf69lCcOOzcoDaaMyzOHGWBrdIVSY6SYlSLRLjmLCUR3SC0
         h7cwSBc7KMMH/nzQ14f/tI19u04tCMyMSklPGR6aYaf8nFCgO2Xj3gCtHrAUlM7b41Fb
         TRYw==
X-Gm-Message-State: AOJu0YwfvdfCUszPgeCP/jIQxx4m4ZmcKMMPyaCYe+HFWaGF5S4FJhTA
	P+UKF8HuhAoiEZECcWe3fYk8jQrOJrm+cnx19VdDMYby8U4T1MG6byeaKOrgqR62Bgak/peoHS0
	Q+U+2MghIWIos0I4b0BfpswEmhfc=
X-Google-Smtp-Source: AGHT+IGUS9tuxVIMX25dmxiV7fTiY5eFrs8jLOCRBDlqb/bOIj6etzQYJ1BCdRIcGim1usEdGT+9uK42wTpI2OLXkW4=
X-Received: by 2002:a81:9c47:0:b0:5e8:75e2:9345 with SMTP id
 n7-20020a819c47000000b005e875e29345mr911645ywa.60.1706110433055; Wed, 24 Jan
 2024 07:33:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9twKBmO2Svky-zeP+KS8qWHFj9zrgeBqW9y__tUwcAYZhw@mail.gmail.com>
 <2faccc1a-7fdd-499b-aa0a-bd54f4068f3e@suse.cz> <CAOVeLGRxXfs4wxSmB2ULZS72NvJkWQvZyPRz0rAmQyFtL39ekw@mail.gmail.com>
In-Reply-To: <CAOVeLGRxXfs4wxSmB2ULZS72NvJkWQvZyPRz0rAmQyFtL39ekw@mail.gmail.com>
From: Donald Carr <sirspudd@gmail.com>
Date: Wed, 24 Jan 2024 07:33:42 -0800
Message-ID: <CAOVeLGSczkyhj61T8SZc2cK1Cjy2izV6URVa2422kcfy8ONYFw@mail.gmail.com>
Subject: Re: [git pull] drm for 6.8
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Dave Airlie <airlied@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 7:31=E2=80=AFAM Donald Carr <sirspudd@gmail.com> wr=
ote:
> I am experiencing the exact same symptoms; sddm (on weston) starts
> perfectly, launching a KDE wayland session freezes at various points
> (leading to plenty of premature celebration), but normally on the
> handoff from sddm to kde (replete with terminal cursor on screen)
>
> Working perfectly as of the end of 6.7 final release, broken as of 6.8 rc=
1.
> Sometimes sddm can be successfully restarted via ssh, other times
> restarting sddm is slow and fails to complete.

This is against the Renoir GPU on the 7950x, but also reproduces
consistently on my 7900 xtx.

Yours sincerely,
Donald

--=20
-------------------------------
 =C2=B0v=C2=B0  Donald Carr
/(_)\ Chaos Reins
^ ^   http://chaos-reins.com/

