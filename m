Return-Path: <linux-kernel+bounces-38779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E6483C5E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09051C216AC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0A873171;
	Thu, 25 Jan 2024 14:53:16 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013096EB40;
	Thu, 25 Jan 2024 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194396; cv=none; b=H8DkctgKXihFmi3D3atHuFjmvsrQHNO+NISXF4NaQUgmgt62xQ/au1TeMjhpQ8Kd8Bznj44QZI16DahiwJ8g/qV/DLRKBsScXvon9WgO+gyncN+1OrUEgwpMOKHwLCLJYteiUcqC5cVogYHaFl2fmFwibTqWEEtzBhJG/3JIQaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194396; c=relaxed/simple;
	bh=3uSFORm+NFJIaKgGhUS5gQlxDc7loFxDIbD+E9Thsyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaVhWuf0iFnu/bJDWR4GsqdIzOiVWszgyUJw8a6iQ2BwgBQ53eatLUmjAcoxb7jYMRaVlmAsu61tyLfm3LVntLi4MN8X1nwIurQjFj6QhhgoHYUvvsk3oHjUJDISKwjSGYKRiRJIH0ObCR48ri7DxGX7xzN2dX3T09h+nZFPj4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55cca88b6a5so1514845a12.1;
        Thu, 25 Jan 2024 06:53:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194393; x=1706799193;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lyfaok12kIVQjeqkbUbkn4FUJHSodtXCSV8k7NDVHNU=;
        b=Haf3oSF6cDTBGJZsh0VvgLVlUH39VZTp8RiZ9Y8Etq1hIFz9Jsqk2tKaKYOGIQjNm+
         JerY7v0gq7kywkKBMpSxIuaalI92EBdybbTp02r6gvZ21TITCFbVAlC58DkroRdbBTyC
         7d/rhc59mv+aPTsY+qFD7p7hyNbFvgghOAGMNWSQm1shTbg9wH2BW5nfWeOm+xDfecOi
         VtIZFgtkAqWv39zniQ5ElA86/Fjuvc4NqRMd5u7SYgjfx0H+c4QXZS5HRg0d9FE3JKkf
         YiOMZwZH2RQ3SCkpD4zlN1pFKbcA1/g+gYvqRkDw6IKbmMj6p6zYQfP5nrATjZSaIU4L
         OfTw==
X-Gm-Message-State: AOJu0YzSYdiTWB8s0Wx9M9vrBbpbiNEtGvYGX/06jEvg1MrJ5EWQCRwB
	CQeMrHv9OQY1DmYsvi6XqTYTUc5XXrrHKHvYYaZr6Vm6OZlPDRbV
X-Google-Smtp-Source: AGHT+IGwAsXqPD6/CjAcTquFtiVBDFk906Hyu/tZbMab8wS+o/AWuPUHK9NqdQ3Nd5PXlTFoLDghVQ==
X-Received: by 2002:a17:906:3ca:b0:a28:5901:70dd with SMTP id c10-20020a17090603ca00b00a28590170ddmr578443eja.17.1706194393023;
        Thu, 25 Jan 2024 06:53:13 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-014.fbsv.net. [2a03:2880:31ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id cm2-20020a170907938200b00a2cc5199dd0sm1102509ejc.135.2024.01.25.06.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:53:12 -0800 (PST)
Date: Thu, 25 Jan 2024 06:53:10 -0800
From: Breno Leitao <leitao@debian.org>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>, gospo@broadcom.com,
	"open list:BROADCOM BNXT_EN 50 GIGABIT ETHERNET DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] bnxt_en: Make PTP timestamp HWRM more silent
Message-ID: <ZbJ11qxfmOfRseJO@gmail.com>
References: <20240125134104.2045573-1-leitao@debian.org>
 <CALs4sv2U+3uu1Nz0Sf9_Ya6YKxK09WU=QH4VmO94FjC3iWX3rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALs4sv2U+3uu1Nz0Sf9_Ya6YKxK09WU=QH4VmO94FjC3iWX3rA@mail.gmail.com>

On Thu, Jan 25, 2024 at 08:03:18PM +0530, Pavan Chebbi wrote:
> On Thu, Jan 25, 2024 at 7:11 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > commit 056bce63c469 ("bnxt_en: Make PTP TX timestamp HWRM query silent")
> > changed a netdev_err() to netdev_WARN_ONCE().
> >
> > netdev_WARN_ONCE() is it generates a kernel WARNING, which is bad, for
> > the following reasons:
> >
> >  * You do not a kernel warning if the firmware queries are late
> >  * In busy networks, timestamp query failures fairly regularly
> >  * A WARNING message doesn't bring much value, since the code path
> > is clear.
> > (This was discussed in-depth in [1])
> >
> > Transform the netdev_WARN_ONCE() into a netdev_warn_once(), and print a
> > more well-behaved message, instead of a full WARN().
> >
> >         bnxt_en 0000:67:00.0 eth0: TS query for TX timer failed rc = fffffff5
> >
> > [1] Link: https://lore.kernel.org/all/ZbDj%2FFI4EJezcfd1@gmail.com/
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> LGTM, however, you may still need to add a proper fixes tag.

Thanks. I didn't include a fix tag because it is not a fix per se, but,
I can easily send a v2 if this is needed.

