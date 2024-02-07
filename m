Return-Path: <linux-kernel+bounces-57047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0D184D348
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F031F23C55
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDA78615A;
	Wed,  7 Feb 2024 20:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="OBGXfrz7"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4629776039
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 20:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339288; cv=none; b=LpVEfSBGAvam/dych3h0nHrj5jW3uWV3MFaH0MEYXflt6FTS5+AKqR4IKJhlLsLj1fsm0CO6zvED4FLIUM8f8CTVdEYOy3DAjjtmJgl0hvKyPsMrLtLhVuNm0ACchD1SKqBhlLfgXBCQCsmGmDUlYBVTUzKCHWllbYlRAP1oPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339288; c=relaxed/simple;
	bh=0ODhUkbCs76NCTBzAROMQnicuP+Us/3Ez5rJrhqcSRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPEvXG00tmykQ5isZr89c2OGshxQzjQUE1qqJGt0Hw9dcwBGWvjugclB9QbfGX1Pdyp7c8A1g615XOTg1av9H6k47ug2EUAN50zXXTgsuADeatPYJYrT9WoacPlobo4BEJRzPUrCCRu1ODIKflXppn01YntGW9Rf7S9IKWcaJj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=OBGXfrz7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d751bc0c15so11108235ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 12:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707339286; x=1707944086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IPDZFDAr8m25erMC4/CtO31Vk29YNq1SvAgfgiB0850=;
        b=OBGXfrz7jluC1QYtEFUDIOMh4bl72xiyuZxlNUsR40fSeCTRsK3vVXv7KySmS8AM8l
         OfiErWa6yvSIGVsGjBOQ+Ww+ZDYWZggFRYMHvkiNgp/daf3OfmIITF9mQ2t02XsEZvoO
         ExeDo6qlc4ibbPVXjpWMJnIJDhHQwSXQZOntvCPZ4tMP+wMMsPe9o2Hs44lptGfxqnXL
         OuYdAHTvvtopiMmYeojmPD3xRB00JO/Ab9dKvNaPHqCuMHJSXhincRqCIoXCkOg7S1GC
         HG9+ATap0BZ5x+EW5BsHkpYQaxLVqigvx6DKQ3Q+/CRb0AeSJuXHboxtZ6LY8Yp2cYM8
         N9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707339286; x=1707944086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPDZFDAr8m25erMC4/CtO31Vk29YNq1SvAgfgiB0850=;
        b=T/mKu2JGYOmPtXgNoqIvQAbZE29S2Vwupr/ha3lbcuEMwlvg5gFpMGnr0/XgtkRCoi
         ydhoirnzNb8qqpKJHHTxk8hrRy73gO4V9MpAKFN2gREXCJWbMmmShx87QryOZ+HlUQpp
         8y/VIAm8HRqBUiUFsv6vYYTBP2XQLjVATuY9IY/y5pa9b2g6gaasICSK9tDD+jLF/clb
         CJgXg2IwXcBTXMDLXDpriOJUCBgEDjoB3AjOn/uSGVObytQhXdKztH5n13dA1+G1NfTW
         MxYB3doyEbQj25ImXB+1YLKdnLMJPvu0npnLVhWlcchmKs7vdQyzzB9F2sHME67CTQiK
         ZZDA==
X-Gm-Message-State: AOJu0YxTj6YbAZ8FysGrMR6e07DCygaJdJvOxb+hBMzryDlSDj35vpoy
	bnohXVPrT4RrqKl8NiP4Q/02Ror3xfL2vNpAvp1aw+pXSYWBDvfHust9t+nmwik=
X-Google-Smtp-Source: AGHT+IF0hSUbjTyX8vY/HtWs256VfTt8IqeYpEfabo6eDnTdMzdlYcYDvRiNMpi6/fhdOt9rauBXOg==
X-Received: by 2002:a17:903:124a:b0:1d5:c08e:52eb with SMTP id u10-20020a170903124a00b001d5c08e52ebmr6449495plh.65.1707339286546;
        Wed, 07 Feb 2024 12:54:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQOAy9vIa9qhh3Ig25rCrS55e2XpLLhzxcjIEV5WlSysLiAEEB/jCZiCEpXYVRszsWfZT/JAlPlwf4Rk2lJk3LKz1qnCvf75iaSmbRlN2KX99xK77EkK3AKdmZLJ53Kjlfc6aS5w+VMb+9IDCJ8VwtLkDYy6flKO5oZKrgGBzW5nwPSDNLZppTIkfGbLhstBflJ5QwihOfEkqs0epEkVJdx/XKPRuKMbaZ9Ot765hx/VqZ2a7uC6SMe+0=
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902d04c00b001d9c1d8a401sm1884646pll.191.2024.02.07.12.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 12:54:46 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rXowN-003QdQ-0t;
	Thu, 08 Feb 2024 07:54:43 +1100
Date: Thu, 8 Feb 2024 07:54:43 +1100
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+0260338e3eff65854d1f@syzkaller.appspotmail.com>
Cc: chandan.babu@oracle.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] INFO: task hung in xfs_inodegc_flush
Message-ID: <ZcPuE4FL9bUu8h0Q@dread.disaster.area>
References: <00000000000088268a0610c6b3ae@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000088268a0610c6b3ae@google.com>

On Wed, Feb 07, 2024 at 12:44:21AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    076d56d74f17 Add linux-next specific files for 20240202
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=173b568fe80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=428086ff1c010d9f
> dashboard link: https://syzkaller.appspot.com/bug?extid=0260338e3eff65854d1f
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148b3c9fe80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13811004180000
....
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title

#syz fix: workqueue: Fix pwq->nr_in_flight corruption in try_to_grab_pending()


-- 
Dave Chinner
david@fromorbit.com

