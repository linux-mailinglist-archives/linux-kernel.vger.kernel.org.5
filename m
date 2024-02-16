Return-Path: <linux-kernel+bounces-69217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E578585DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2E828619D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C61135403;
	Fri, 16 Feb 2024 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyN9wsc3"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8651D1353EB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708109827; cv=none; b=ZM67KfY3lldJQWovldqvXqMDf3twww6LrwSMcLoOnwQTj0USmjf/qMLOqWJh0a4MgtzQ6QfZ2JLO5FkUZWYO/ukZaIuoyU7P7XZlEU/3lNcTzhYwOZNKeukTk2PYkAeABh+8tDwCCNjys8JJLRDr5GedsnKo1vbNcBXlzjRw9Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708109827; c=relaxed/simple;
	bh=l9JKNXsGgl+5ALfSxq+n1VvEOspwFMPsXu/ejisaShs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UhCq8TWDSSkhq1yNfe1Dg7Th5Z7aP+eImxvzgxTuAHFxFBz5LNDj7aKaYeWlDBq/IbKPVRAuR2ZoxVnXOSK520+XaWKFO4iRoOnHioy92qn78Nq3yPr0XSzHGScBSORRIIp4kjTjZsCB70R2DvhrZMLlGMxUrO8+qQ7VBrpVt5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyN9wsc3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4125295ff94so4943585e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708109824; x=1708714624; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=71+hn3sPLzDBg76ykl+MFKmJ+0AprM+862scgSVNgVo=;
        b=JyN9wsc3vF8NCpL4UauHsBRMsWWPvSv+CON0rZG3bvYsDBHfIfFgRSyTG5CS5P/er9
         Z/5moRr05X3uAjlteCGJCPG36VGSCd3NRQ2QqE3Z2AlBG5S8ls3Romi6WAZdvJ/7lEwc
         lDcmqQiN0Hye6B+j0YXHy8cSsq9O3cHPUSeR+X9pBSJJd3jPu2mq1e+yMlHWI55dWcnC
         P0I8p8u7eFXnENbIxOvK9B8gqv47+3ENQJDEj8e35kgYfy0Gwfbb7LQiNyY5OEx5t46s
         gyrLZmYVqo/vaB3HmbeAaQZEwsC0TjXhQtaITqh9v01Fwa3cwXxdtSPan36jr3XMq5wy
         7Adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708109824; x=1708714624;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71+hn3sPLzDBg76ykl+MFKmJ+0AprM+862scgSVNgVo=;
        b=oUS03hrvcCdwKdgITywDXK+p5PQlGUhjytz1E+BfyMhmFShUxXb4hM+8yfvpLeGFym
         MVHGotOnMoCLpgeWmD6ndUatmZzREEBynAyM4sZX7cdGwi2z6kOlP4OGdRDQroE0zsMs
         AUc2LrUaSWysogTBKSXkou4oTVJQIVKkOoRKusOGZ7o48YQBC8C+xD2twNH+lsNog/Zn
         tS1d26XmkKwwcXxUrCQWUGmIJZG6FK/mBPpca0G0VkA3vYd6WSSfi9Qi/Stlry+CtEV6
         WK+J+6tUUUOgNehu8MiIlHHOFFwIivx1t99LDvrbeuhgxyAojjwDyXqQA5VVvB32WSjH
         1Xcw==
X-Forwarded-Encrypted: i=1; AJvYcCXCdUtCn177O6OL65Y3gKLRwgL7mMtzib3Jh1VqJl+nuHi+nU0umsWMEN5eDBAHqMBzph2iZjARFtqryledVakiwiwZ159slmDAwb4x
X-Gm-Message-State: AOJu0YydWlCSgA1s2wA5tRYWwuW6aQRizqq1bwoGhHDZFKSWi4OCRbdQ
	djYI6F+of9Ihg5Sxgc2LXFkD9uYyu+Hw9quWpPCxg3d0gIyE9n4=
X-Google-Smtp-Source: AGHT+IFjFwPF2z2t0JL30v/119lGZvL0DcFB3MoX7WANe8NcJ0mh+jIp0RwDc1R0KVwvPvKSyhq+oA==
X-Received: by 2002:a05:600c:35d0:b0:411:d715:c0f1 with SMTP id r16-20020a05600c35d000b00411d715c0f1mr4411612wmq.7.1708109823546;
        Fri, 16 Feb 2024 10:57:03 -0800 (PST)
Received: from p183 ([46.53.252.171])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c19cc00b0041061f094a2sm3113097wmq.11.2024.02.16.10.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:57:03 -0800 (PST)
Date: Fri, 16 Feb 2024 21:57:01 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Imran Khan <imran.f.khan@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] connector/cn_proc: make comm length as TASK_COMM_LEN.
Message-ID: <bbc2522f-b69e-497b-9153-f421d0e87b00@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> --- a/include/uapi/linux/cn_proc.h
> +++ b/include/uapi/linux/cn_proc.h
> @@ -136,7 +136,7 @@ struct proc_event {
>  		struct comm_proc_event {
>  			__kernel_pid_t process_pid;
>  			__kernel_pid_t process_tgid;
> -			char           comm[16];
> +			char           comm[TASK_COMM_LEN];
>  		} comm;

No, 16 must remain 16.

This is ABI header, and TASK_COMM_LEN is in sched.h which is NOT ABI
header. This breaks compilation for everyone using it outside of kernel.

TASK_COMM_LEN is probably fixed at this point by countless trace events
but still... unless you've moving TASK_COMM_LEN to uapi/ too, this is
wrong.

