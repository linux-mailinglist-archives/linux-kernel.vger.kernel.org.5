Return-Path: <linux-kernel+bounces-140498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A4B8A1574
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FF0284CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4156F145FFA;
	Thu, 11 Apr 2024 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGv1JiG+"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15AA14BFB4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712841873; cv=none; b=fMuRUOYEMoBHz4Lx0lKRg/hLYvb4GXvbqqvkNhw6cHzl0KKmCB/94j2vUq9KJLfbyp5Pe5i2JK0bnFSw0+k0ex3QjZwBqXfuByQgdrYURhZd8Hqa6nmx499fgoSUwAzS8KbVB9uv4O68Lsc4zun0hMdJBCdiS763xVWMvQS3WRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712841873; c=relaxed/simple;
	bh=6AY+MhgizkgOhIC+iJqAT45UnLhe61L7WgN4TAFZoMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu+h/tQUvm89UMskisd/RQrt8E7pJxhOMRYq+DX69SU4aF5ndTUMqM4PsO2OwZN8hD5neR/ZuCjAklMb8JkJD1Qxxb1Iy82W6WiLO+eiBBAZcRLIb1khwAgsGwLywv54XxTZP9QbVOzpzGfn8vWuHpeLxfSUdGaUumSRjbLyJXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGv1JiG+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56fe7dc7f58so586027a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712841870; x=1713446670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbrCLN/o3uLqGtj2Srsmto4A+87xT0bJjv93ZpQuVUU=;
        b=TGv1JiG+1OMslMY/vhoweIDcsMFtxFOHXqi7rdk+/hymoSO5Q7BOxhSaq06Nj6+1Oj
         05GSD2Jqx679aq6DEJIpNbwkOOWVYEE/k63tsCUvM452ZmnuxOVKPrQjuv+0p2lq9Ga0
         4k/1NHoGA1376sJQ2FDzVDMGTW5hJJgY1fbDMUwr5huMdsy4qc61gOE3AT9nMt063EyG
         DHQgVlVFd7r8QX1tauq+e1jbmv2AGZxknxQp9DODVk9PpjN0YQVPHDvF7FlZ/fb9l3ki
         fV4ZuNfAADRF4KvBE2EYkG+H26XlfobSBWqf6oA7fLf8f236gmEDimcdE6C2gncyO6aZ
         iP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712841870; x=1713446670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbrCLN/o3uLqGtj2Srsmto4A+87xT0bJjv93ZpQuVUU=;
        b=oPZPjczPlyNGOVyS1lurBGlYrVenwoYJEvg8LSwzb4oxm83dL5B0Qfc2PMIT0eLYQZ
         D7y679qFS1X3doSFalhYa5uwz1WHnDfns594YOENdxVrujhScE+npcbGqYd1OhQljTtS
         FY+KunNssDmYNKhWPY3eBvR+k+YiPIBmmGVNGSYmbjs2wHToviamtXpvvmu9rgNdkk6i
         Lp+5otMNVQuV4aNRAZxN63/aj78s/81SmHJpZtIzCe+nUW1GPaf+va4FRWSPBxeIMtNm
         ogHhGa6BWRsg3HF4aIJdt5GchWcc+svOCYYxBx7FMeNKCKWtYPmGiG9JQa6pwqEcc1lT
         o6PQ==
X-Gm-Message-State: AOJu0Yyk+kCbf2U8AI+BdQwS0AcwuiIXvVZUd82dIi0RC8uidyAQbG7o
	9s5jbwsRwQgogf4Ky/aCeNk6YudLOC0lKhO5cMy1HZiRnGymXJGQ
X-Google-Smtp-Source: AGHT+IEWO6rlNZJJWSOz1DeS6iHgsXjXVJsvSa+JDk24CFCZTNGcEuAcFIVmMe+05nzpQtUYl2GAdA==
X-Received: by 2002:a17:906:3088:b0:a46:cef3:4aba with SMTP id 8-20020a170906308800b00a46cef34abamr3525583ejv.75.1712841869613;
        Thu, 11 Apr 2024 06:24:29 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id jw24-20020a170906e95800b00a51adace6ebsm756318ejb.79.2024.04.11.06.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 06:24:28 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 11 Apr 2024 15:24:26 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 2/2] locking/pvqspinlock: Use try_cmpxchg() in
 qspinlock_paravirt.h
Message-ID: <Zhfkinpp92Ja6Orl@gmail.com>
References: <20240325140943.815051-1-ubizjak@gmail.com>
 <20240325140943.815051-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325140943.815051-2-ubizjak@gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> -	locked = cmpxchg_release(&lock->locked, _Q_LOCKED_VAL, 0);
> -	if (likely(locked == _Q_LOCKED_VAL))
> +	if (try_cmpxchg_release(&lock->locked, &locked, 0);
>  		return;                                   ^------------ ???

This doesn't appear to be a particularly well-tested patch. ;-)

Thanks,

	Ingo

