Return-Path: <linux-kernel+bounces-128893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2508C89618E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE57E2850FD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B73D8C07;
	Wed,  3 Apr 2024 00:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ld+e1Y/n"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC79FC0C;
	Wed,  3 Apr 2024 00:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712104717; cv=none; b=j5mOPWSDiFPhQ5K8NEqnycg9Y6cQwWLrqkD4w6ag56ogGwLhacGORQMHgnZoGxL+ByAZR7OUEo6L1057wt3T2hrk9sYnep/oNjQRZjXG+kBqmmg863IEaKsCtU5MLDk8m9gfw3uVYJcsZhRLWoYv/eP/F0edRpqdbECKaULoFMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712104717; c=relaxed/simple;
	bh=/pKOQn0YGMSiKq2vjXjO1upFSxAXfJ2XljqSMDWwXFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V//YZAV03Qmr5jLPsyS8arGWoYB85eEe2DRgzElTgABD27tA2rg4q0fgafIpa/a9n2Z8WFIL+Xw9lCEk4xRLLL3hcibbDMT3DpoSuytstQ7gY9g3CDZbZ1/tLcqm+kE72Y3ePEOjVzSh4CPxxrUMRP2BJmfMM5e/1wJlQyupLis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ld+e1Y/n; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ea80de0e97so4141586b3a.2;
        Tue, 02 Apr 2024 17:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712104715; x=1712709515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDuEkbhuZ4nhCQYseid5ymqn/qQ8r9+nK29T23SV1sY=;
        b=Ld+e1Y/nG0OwlFfWnzB92al3CbTudCasDe9eanch1vWToiaV5nj2Y0WHsuoY55DHuz
         Ki+tBKfkROPdYNQBGKfhmrOU5l8OOrWPR5g1u4PTSFPY4+M+o4UpD1UfqV7xKJFVhd1w
         ccLQqsXyBRaDWBg20Kf1C1AuAOrYrCXmmu4J20mgWDIbLvJ/ZLMbpVmSJiCWWDnYL3Wi
         54z+mAn77R24ORxcAv/Y6TMojJh5ZvUnj+i5c5utdE4iwn+YVMHT9UAGfAmGsxLElkTM
         aID4dvexc/2acaAqbTNxri4WOSgv9AFsJxO5dOxbAtPHyMYkX+xkc3NADZwdTe9rhX4J
         eunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712104715; x=1712709515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDuEkbhuZ4nhCQYseid5ymqn/qQ8r9+nK29T23SV1sY=;
        b=XTYKHoQRoyEMM+lDcwQchOjxEJTNngEtEeiHOeZxcWV4LWnty862Rzzpl9tSPpev+k
         zxcyl4ntOvOluvzHr+fBLQ5436lTp08jtjmRAXpmYUHliOPVWdkHQZBhkrOq1LWY6Ga+
         iGDy5heKMPOR0bzXxACelEv6RfZZQzT1PloVjS4SOR4y9T4AtHv0wZvWFjkIlUo+dgb7
         /Gcniyfr7CybzSFbY4OOOD4RjXq3qpGk6O3bAxBv2LuxQLncSwNZgHF5OZ7sC2JzrrZ9
         ez3hTtrug10y73wX1Ee7YvL5pHJ4VkNJZyX0h8H03hkDpgIs60G1uLh8/0nnXJ3XZ5gc
         n+Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXhU6Wa5BSuvUq7BuPUGoY72WnVYdVVF+VaN8B9CmHBPl+fMrRWXzKTgDCsho3UtK86BWHdKZDKVMVCVofEOlDoN4CnA8L2od280gdTZtffP8J02LiOdk2pe4Ab0hqHGr1MXv4n
X-Gm-Message-State: AOJu0YxUkRsWiJHUaDRSqwj1+DcGMf4q760KKHuktKppSVEXOp+7+GAR
	YuDwpI60G4FJ86Q3WjZQrjtZ5Cy5UY3jyU565al84KeBGuziWccG
X-Google-Smtp-Source: AGHT+IHjjD8qHS6NjcI14QZRJH1hz7B35xujdQGn9UV521z1FTa9DUmnqoHtIBZ7Dm9Fy8byf/AduA==
X-Received: by 2002:a05:6a21:999f:b0:1a7:1c5:4746 with SMTP id ve31-20020a056a21999f00b001a701c54746mr1875347pzb.1.1712104715190;
        Tue, 02 Apr 2024 17:38:35 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id j23-20020aa78d17000000b006e681769ee0sm10817731pfe.145.2024.04.02.17.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 17:38:34 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 2 Apr 2024 14:38:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Hibernate stuck after recent kernel/workqueue.c changes in
 Stable 6.6.23
Message-ID: <ZgylCe48FuOKNWtM@slm.duckdns.org>
References: <ce4c2f67-c298-48a0-87a3-f933d646c73b@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce4c2f67-c298-48a0-87a3-f933d646c73b@leemhuis.info>

Hello,

On Tue, Apr 02, 2024 at 10:08:11AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi stable team, there is a report that the recent backport of
> 5797b1c18919cd ("workqueue: Implement system-wide nr_active enforcement
> for unbound workqueues") [from Tejun] to 6.6.y (as 5a70baec2294) broke
> hibernate for a user. 6.6.24-rc1 did not fix this problem; reverting the
> culprit does.
> 
> > With kernel 6.6.23 hibernating usually hangs here: the display stays
> > on but the mouse pointer does not move and the keyboard does not work.
> > But SysRq REISUB does reboot. Sometimes it seems to hibernate: the
> > computer powers down and can be waked up and the previous display comes
> > visible, but it is stuck there.
> 
> See https://bugzilla.kernel.org/show_bug.cgi?id=218658 for details.
> Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
> not CCed them in mails like this.
> 
> Side note: there is a mainline report about problems due to
> 5797b1c18919cd ("workqueue: Implement system-wide nr_active enforcement
> for unbound workqueues") as well, but it's about "nohz_full=0 prevents
> kernel from booting":
> https://bugzilla.kernel.org/show_bug.cgi?id=218665; will forward that
> separately to Tejun.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

Sorry about late reply but that commit is not for -stable. It does fix an
undesirable behavior from an earlier commit, so it has the Fixes tag but it
has a series of dependencies that need to be backported together which would
be far too invasive for -stable, thus no Cc: stable. I didn't know a Fixes
tag automatically triggers backport to -stable. I will keep that in mind for
future.

Thanks.

-- 
tejun

