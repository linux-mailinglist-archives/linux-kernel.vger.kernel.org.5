Return-Path: <linux-kernel+bounces-29986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD007831645
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7171C21F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471E720305;
	Thu, 18 Jan 2024 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhH+pNpY"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD6B29A2;
	Thu, 18 Jan 2024 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571752; cv=none; b=NnFCVV43fF9yBNl87Jok9EMqFuZePCqlH7/KOzdeSE4G7Z0Y7Kx4Mus2BE3JQj3lEP+GWrzeQIDEFBFvwDWQHXXReVmYs/xBBAcTG3hXnV3eigL8+gIO5pe5WzkmMkeKeoOCBqDKPS9SvmH1y8VTYOJPzdZhXela7+Yy+h1zhdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571752; c=relaxed/simple;
	bh=FmtxJ1/Uk8uKGZ1IhBGuuuJVOGfB4FaSQCyPA4KP4YI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K7Em4VwUDsmWEHuYO5byALb2hHITnJVSSkQdhqEMuEdPfcIdicXHVpmkDdQR8DqA3Ukk58fZwxBPqITbrIJCp7OW/N1vC/kPI9VUC21nI9T/PJcjzvwrHDuRrWRtgFhaYmCd52PyLe7O9z3SIJfRjOr+infQhVEKQmc0Qfgf7uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhH+pNpY; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6da6b0eb2d4so6534170b3a.1;
        Thu, 18 Jan 2024 01:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705571747; x=1706176547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=35MgUySkivZiu3Aq5AqtYwsVQJ4Uq1MrdaE+7l+zuec=;
        b=FhH+pNpYKZqCuVF9GBY/NWlLqJztXxl0mW3gA7jSVYJKal48UVus9KWoGRk/y6Tb6M
         KSltvtq8pc0V7TrOwIXMYEOBuMMSKohJOPqaaPULh2WCLDavFbCiDG5/naz2wKl+CJbm
         LiWaJEmKg1xMT+XS0coOmRNTB0n7ch62oxb3TvUQDaMJcjw0zd8Sxdd83m0Bt9nkdKqb
         ZDaLDH1V8UwHooy5MILzASqWDSiD4M+2ZjaRduymoTHPwEb9K3l6CXBN7kLKMsNXOwTP
         VnquEtrT0sA7AFZmlscuhlehWdNSJkaDfDOyNkoXQrQa22fKnZZaSn1j7HHywL+SDlSk
         RPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705571747; x=1706176547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35MgUySkivZiu3Aq5AqtYwsVQJ4Uq1MrdaE+7l+zuec=;
        b=VibfyP5e7mH/q2e6YuQioAaPhEKqt9UcTxzKpoSS8KGBtQYORT3LOx1oLY+i0m9OOu
         6iHlw25Glry7/MhHwnpqEng5l0yR/zC9FEWhCVvbBL0ORAnKlYlAC3Rs7hilKUVSRq0m
         Bn2Ccz8Q3IyFA9qu2SfVksPKSM17C7fBWogX24rmDwasET3X1+jyowEN2J9SCCF7nPY9
         ZaSIl7i7bBZVcudkjd+4W0wZ31arG2OEmnbAM+jypxoqcF7O+qmRMBGUAkKrQ9uMMIkY
         Lh2N2WIIAlRqk3KldFYpxsUqTiE1yO8IiArwhZ+kC3jKMFByEK/1f6PNR97oCtmmAQzK
         Gu9g==
X-Gm-Message-State: AOJu0YwC8ypAcV+/tBswmvegSi4pNyRuE1Bd2r74hhDj5kMNqaW38JiR
	7LzpcAoccbQv3DpWLbd5GdnS8E/jHWrKr6dXopaRCvApVe33l5Zk
X-Google-Smtp-Source: AGHT+IHkoE7cNPQHqsxto7dcjxGewqmRATl7Mep6ZTuTs9J1gjrq8mcOHXgE2lkTxR4/2yaacNUEbQ==
X-Received: by 2002:a05:6a21:3a47:b0:19a:5d53:e76b with SMTP id zu7-20020a056a213a4700b0019a5d53e76bmr508394pzb.41.1705571746882;
        Thu, 18 Jan 2024 01:55:46 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a28-20020aa78e9c000000b006d9bdc0f765sm2901519pfr.53.2024.01.18.01.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 01:55:46 -0800 (PST)
Date: Thu, 18 Jan 2024 17:55:41 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+a9400cabb1d784e49abf@syzkaller.appspotmail.com
Subject: Re: [PATCH net] ipv6: mcast: fix data-race in ipv6_mc_down /
 mld_ifc_work
Message-ID: <Zaj1nZRBkWaDfo-e@Laptop-X1>
References: <20240117172102.12001-1-n.zhandarovich@fintech.ru>
 <ZaiQs6yTY7XuS06i@Laptop-X1>
 <bac390f1-ef6d-317f-a5e1-1c0c5e4e4535@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bac390f1-ef6d-317f-a5e1-1c0c5e4e4535@gmail.com>

On Thu, Jan 18, 2024 at 04:24:52PM +0900, Taehee Yoo wrote:
> > I saw mld_process_v1() also cancel these works when changing to v1 mode.
> > Should we also add lock there?
> 
> I think mld_process_v1() doesn't have a problem.
> Because mld_process_v1() is always called under mc_lock by mld_query_work().
> 
> mld_query_work()
>    mutex_lock(&idev->mc_lock);
>     __mld_query_work();
>        mld_process_v1();
>    mutex_unlock(&idev->mc_lock);

Thanks for this info, then this works for me.

Hangbin

