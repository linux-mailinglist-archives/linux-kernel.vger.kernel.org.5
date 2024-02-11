Return-Path: <linux-kernel+bounces-60780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC92850954
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7961C20F43
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5445A7A4;
	Sun, 11 Feb 2024 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j63qDuSn"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91301E506;
	Sun, 11 Feb 2024 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707656073; cv=none; b=VYSFKHg9tReL+v8tl1/gL3uXLFmL9BJHWvYOSvZaBHU9MofkIjjuu3LewOhpih5vrHgvd4Mv6xdAn8tM29AfzGQWsP8exDihTipKCs+nJemvXBJ13mPhc3nZEPuXpB20cM8T0G5fKN9ybfdOH/cxc4EpmmueEBIi2/McZXAfTKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707656073; c=relaxed/simple;
	bh=C+XQXwDD9N8THlo39OomPFlzmvWu4gIgQwLvf2U+jCc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:Subject:MIME-Version:
	 Content-Type; b=W3k7iCJdcqY509MuG08oD1m9m95pN3fr0BXFe+BH7Va4pr91C9D3PHFgAc3FPd0JurHOqPNOf9xdjSbgb951TnzxTo2++5ZREDYBJpQ1yduv5ToMBvrL2+rvTTw4Xpw/g9lMXLnNiiuja/Xp7Jr+4Ib2+rHTI75KYHVsbFXE+Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j63qDuSn; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cddc5455aeso1672066a12.1;
        Sun, 11 Feb 2024 04:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707656071; x=1708260871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+XQXwDD9N8THlo39OomPFlzmvWu4gIgQwLvf2U+jCc=;
        b=j63qDuSnVUCw6eQMZLFHni/B0vwSKfJLfXTFb3Q46iffr1O1wrKX1ayueeHMQBvRJt
         Kn+4qjgft1k2MITt2+ncRn07w4fKhmw/q9GbNN2b8cwXBiirWTLld7vCQscamRpAhewM
         rv8Yk+vjbjVSMyAZOmgsCmwyG82XwRkTyPAJ6qoViRIIC89xgb5udPNIp9+544c8A2tW
         25O8UZD1TdkYsnafHANRySyM3OrPLs+DXgScXUesTAL1lVv3zoeNJJjg7zbYCY14r5t+
         k27JM65R0ToflLcxKpQAHA8S1+7/t6TiYMeuLAMwHhCREXuUawRtEtSi4YWTdMDCMtd3
         H+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707656071; x=1708260871;
        h=content-transfer-encoding:mime-version:subject:in-reply-to
         :message-id:cc:to:from:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C+XQXwDD9N8THlo39OomPFlzmvWu4gIgQwLvf2U+jCc=;
        b=VFs5Ap/WpiBFGo0tUFtpkpFX1taXu5dOXJrwMmVcVRTNO9FMAGE/jiFjJvaU0gfMiL
         Lll1DuxljCi3PHACw0237mmaPVg9woeCBuCE4AUnyE12idQfwyrSqvuYIDZnMWDJeMqg
         KkYZMQ1iAbMqOpBoEe+Li0l3ICKKmAxZHcCy8wxht0IP8LZHZniKlG701QED7rTge9Zm
         rlclBc0IAxKp7Et/c2n6OSCRHqKXmomRm272tlPKe1P63OfMst+xjEFv1XuKc0SwMiOV
         2UKYarWRaKZ3irfNhtFuycz4NwIKBC2OY4Gccq4XESaJGJWQwQT2ftYTbuZQsAQ4IP7H
         4v3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDGvlCRfVofStDUasRip1vI7Bsi97lnMd1WdIAvrldPNPkxWS3850FyTky+kPU3Lf3tfWeyR9ZLaxLmRoRlh8oAe6O4WuKFlQiSZ0pVmJidjzngoOZtyD3e0D/zClACTWQyouLAPcOjIvUJ9xTEwLwYRnKpTqVov8qWPKXERA2wTW2
X-Gm-Message-State: AOJu0YxPi2d/ENrAQrr3LwSXF/TGyJR35ORovpIA6LZqKLvO6cI3StPy
	7DWCtPa51Q2o1nvyX3aXt5/9156T7lXAXe4wYcMO2qetYcPF2s3O
X-Google-Smtp-Source: AGHT+IEx1P+gJ/HEVuA6gr921gTOXVlkSkMwk8B77f7YKCvdF4xrlA6DRHKgxZEuCTaD0dpvKYOlsg==
X-Received: by 2002:a05:6a20:d707:b0:19e:3c4e:d0f8 with SMTP id iz7-20020a056a20d70700b0019e3c4ed0f8mr3281418pzb.32.1707656071274;
        Sun, 11 Feb 2024 04:54:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWY5o7/De9dzWdddJ0uWaxsYvSfYmI93GrIZshPkMOg98hR2Ewgh+N8tlMIWon2t5WKBja2k6RzOgapRhA67+YmgWLNIYMgdSz3l7Aq43EMQnQvgQN9LWrcsMXZehIMOZLpxSc+75AFa/3IyfQGVrsNLSDLS3mBZzDO/yz/rNj/DnyrxEFSBI/cuA4S+gV61zQ9HVVbyZN1mPK1uxw02WUyfab1OzprjNy39YS5oH4alMyq9+Hms1eLApdyraw68L1Ex3dgr5ACAreM3mNLo5KRlp/08l0sWATZV+UT3zkW4t/3HTFu4fo=
Received: from [127.0.0.1] ([106.221.237.147])
        by smtp.gmail.com with ESMTPSA id ja15-20020a170902efcf00b001d9fc6cb5f2sm4280038plb.203.2024.02.11.04.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 04:54:30 -0800 (PST)
Date: Sun, 11 Feb 2024 18:24:24 +0530 (GMT+05:30)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: gregkh@linuxfoundation.org
Cc: corbet@lwn.net, linux-doc@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	shresthprasad7@gmail.com, skhan@linuxfoundation.org
Message-ID: <74d67b62-6fa4-4218-b51f-f0d33f19c422@gmail.com>
In-Reply-To: <2024021159-banner-dramatic-af88@gregkh>
Subject: Re: [PATCH] Fix malformed table error in gadget-testing.rst
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <74d67b62-6fa4-4218-b51f-f0d33f19c422@gmail.com>

I see, sorry about that. I will try some other way to fix the error.

Also, as mentioned in this thread: https://lore.kernel.org/all/877cjqa5le.fsf@meer.lwn.net/ has the patch already been applied, fixing the issue?

Regards,
Shresth

