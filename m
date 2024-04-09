Return-Path: <linux-kernel+bounces-136705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C975189D746
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47812B231B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1C084D02;
	Tue,  9 Apr 2024 10:51:56 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF541EB46;
	Tue,  9 Apr 2024 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712659916; cv=none; b=fAnRa79gXvOiXyWhkvXGZW+OxrS+6YCnsl5mLKD+7MVDHA+b0jRXd/cmiUToO4QIKtAgDwngSvRS11lojzUVZdtCGCpR2U4hXW2p8r4+iCjsUf7abgxGyRyk+C8bnAOr0iWfktjAFwHM0glN3F0NElYO8hiRbdlCD3FHDBgc35M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712659916; c=relaxed/simple;
	bh=J6BA9/3XJpuAa/jgWFFMWWa01R4APTaJ4ZKMe05arAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs1KuuOF3G09s6CpivmDJcs/7NPsS8Eb7H7/lnYdlUOPRJ0xRxk4EUeaXvIuTQnVumwL4y36xLzV5xcHTmyfLe2IdmbPCevPCe2twWHmVgnUjsbEEr5u5lrsBGEr2sf68ADAcLJ1nJz/pTAS6V3+jYp3+C+moTTrIU0cPGQbEz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e6f4ee104so1179839a12.2;
        Tue, 09 Apr 2024 03:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712659913; x=1713264713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D18zsKfXH63dj1S3Q8K0FBC8WrKFJn4nZwjzqAFKe8U=;
        b=liy3PnNhLS9A4HDA0ODcwn3CcGxjBQa/TfJyoVTbtBiGLgN5xqLdq86IpzGVB7TNeS
         YqZ7Ikg5X1N7zvt8FOJjnKY4fcmCXo/sjBD22bBDNECodv5DGL01Eh2EeXqgFx/pLaIB
         nhuC5Sj0Wci1C8SgFmwd+N0zwIqvo7NTg6Yq7GP839eFjomLPV9eWdz3aXmN4prb+SlU
         w6UXmgTR4+35fF3woG+pVZHf8VrCx0i7F8YPzuZVBiVv9tBzsnwq1d+Q/ZhsML0tjPqC
         cO5xVndgLTi5LGyY04LikSg1KlO58sHKGCwP9hvboBg2HoW27lA2AWJTbGlwz0J6uMhZ
         SZpw==
X-Forwarded-Encrypted: i=1; AJvYcCUFrxjT1s3X1z8uk/LRtT9H31pKDzFwWY1euLXuFbzfvsCjwjwZRLw4MK8t2ZXGZXomwg5FeVSJ1mDcjLUUI6RXE38TZ5clG3C8dqn3urN76Ght639G+fprsVwoxgY5YvYGQS0IK+E0EaXHy4zqgkre3tOaYxpo9K50zLN+2TtbFWJlS6c=
X-Gm-Message-State: AOJu0YxpPvjPjfuZ/wMDxFqdYVrnDUiiAlj0S3t75dBQd0HKts8ThYGT
	mGmqMtRHH2jz5Qj530KJ2RPZFJ3dULzCTKPPPPc8JuvOi2m2qgom
X-Google-Smtp-Source: AGHT+IE0kN/ATp0XtOHlpEkNGSfsAHzZLZV+Ki8bifnpSHDIQZARfBa9Mlhn4h+hE0pT/2GjSI89Zg==
X-Received: by 2002:a50:ab5a:0:b0:56e:2d0c:6ed6 with SMTP id t26-20020a50ab5a000000b0056e2d0c6ed6mr6313316edc.41.1712659912586;
        Tue, 09 Apr 2024 03:51:52 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id ij6-20020a056402158600b0056ddd9427d2sm5179868edb.58.2024.04.09.03.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:51:52 -0700 (PDT)
Date: Tue, 9 Apr 2024 03:51:50 -0700
From: Breno Leitao <leitao@debian.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: kuba@kernel.org, ath11k@lists.infradead.org, ath10k@lists.infradead.org,
	linux-wireless@vger.kernel.org, imitsyanko@quantenna.com,
	geomatsi@gmail.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] wifi: Un-embed ath10k and ath11k dummy netdev
Message-ID: <ZhUdxpnC+nMkNp+U@gmail.com>
References: <20240405122123.4156104-1-leitao@debian.org>
 <87y19r264m.fsf@kernel.org>
 <ZhPyRHHlVot+a8Xq@gmail.com>
 <87pluz24ap.fsf@kernel.org>
 <ZhRGo3I57rXxsMV/@gmail.com>
 <87edbe26qe.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edbe26qe.fsf@kernel.org>

On Tue, Apr 09, 2024 at 01:03:21PM +0300, Kalle Valo wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
> >> > Reading the issue, I am afraid that freeing netdev explicitly
> >> > (free_netdev()) might not be the best approach at the exit path.
> >> >
> >> > I would like to try to leverage the ->needs_free_netdev netdev
> >> > mechanism to do the clean-up, if that makes sense. I've updated the
> >> > ath11k patch, and I am curious if that is what we want.
> >> >
> >> > Would you mind testing a net patch I have, please?
> >> >
> >> >   https://github.com/leitao/linux/tree/wireless-dummy_v2
> >> 
> >> I tested this again with my WCN6855 hw2.0 x86 test box on this commit:
> >> 
> >> a87674ac820e wifi: ath11k: allocate dummy net_device dynamically
> >> 
> >> It passes my tests and doesn't crash, but I see this kmemleak warning a
> >> lot:
> >
> > Thanks Kalle, that was helpful. The device is not being clean-up
> > automatically.
> >
> > Chatting with Jakub, he suggested coming back to the original approach,
> > but, adding a additional patch, at the free_netdev().
> >
> > Would you mind running another test, please?
> >
> > 	https://github.com/leitao/linux/tree/wireless-dummy_v3
> >
> > The branch above is basically the original branch (as in this patch
> > series), with this additional patch:
> >
> > 	Author: Breno Leitao <leitao@debian.org>
> > 	Date:   Mon Apr 8 11:37:32 2024 -0700
> >
> > 	    net: free_netdev: exit earlier if dummy
> 
> I tested with the same ath11k hardware and this one passes all my
> (simple) ath11k tests, no issues found. I used this commit:
> 
> 1c10aebaa8ce net: free_netdev: exit earlier if dummy

Thank you so much for the test.

I will respin a v2 of this patchset with the additional patch included.

