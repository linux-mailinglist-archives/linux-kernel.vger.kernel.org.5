Return-Path: <linux-kernel+bounces-73499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4986D85C388
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F394D1F229AF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C94378B64;
	Tue, 20 Feb 2024 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQd5iT9a"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED36C78693;
	Tue, 20 Feb 2024 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453144; cv=none; b=TAOUwjBf+b16KMYq2K+RImCtx9HLq7jHB/UvAuAKLxN7SBjRodHkBjnXTFvHuA7G9ntaQa/UTVDnix3sApuVMaq1JHNbcqImED0/qelcElG2DXdZXJGdXihzPjZevxKZuSM+61wNPiwnQcfK0sFJPE9QOZHMly6xenjkYbJnhIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453144; c=relaxed/simple;
	bh=PvYo74uoWhD41ohw8yNS2GUG6/U1gKH18FXvHsCmIKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDwwHqpY31H+L84jHn1xz9mp88oOiyDlgXI1IzCYYgFYe7aa6mEMANg+TS36rIZ8VVwfmW4njB3ukqudXY/7w8AC54UQQTGaLUXjCRgwhYBDnYuez5rRCsw9VyatyA90+qth2nMCcjnV3MW6tGZg3wg3PhPYA67PvvGCO4yehI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQd5iT9a; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e471caaa71so1239708b3a.2;
        Tue, 20 Feb 2024 10:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708453142; x=1709057942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFTpHAv0pmcOCj6fTcaqcOduTWlWxRQydUJGeHzrVhA=;
        b=gQd5iT9acfCqGPOwI2HsPvERlOItk+chb9lEMLI9kz3jRL+Nol+I+ke8yq2Ila6PKH
         IAK45mLOgttviJ/inxu2PKdNXHvX/DnkYjiWwZKep8tE0aNpvidq7eC9YMptoX44LpSa
         XrfHbvmEJRq/IgXFyJZ+oV1WmZ5gWoAOrcT3aCIVb2U3eZ8jzPcuhEw3F1IuA3Y+KGYq
         1u6QaY4eAhhbBwYV+B/x8a2nqwD8acQ+rKTRFezoD9e1QcYpLVXN6SdcKEAPZ3A3Z0Nb
         90yKFGxa/5LDI90vrgNAXfDxlN6J1IOUoL9/Pg5+5xYOcrI/gTnZjZRorEvYIOIWLcdv
         4GmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708453142; x=1709057942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFTpHAv0pmcOCj6fTcaqcOduTWlWxRQydUJGeHzrVhA=;
        b=vSqhDxyrw/Viei237C/yRue9anMo5rLTRUwwV0PLXrqW+H4k1hTpBsmipH5Ys2MPek
         hMZMcrbyo46LEHl1J0Yzoz+DO10SALtAs0S218O8axkwYISE8iKNwimWZ1IV3gv4vNJD
         DfHWFIhWOl9LHvA9oAypHMeMitwQuLnX812wJjIjOMhZuQ8tomYF3AAH5I8q/msS0JRX
         v7kRp1GDtTMybXCNDHRQxdPfHns0FpoQvruOKn8eOAdvcnZ6/2xnTU9VM8zdsxNIfatq
         KoXC8vCSTIU58BRXqM8S+NKRRaS3uR86b/c2jagIBlk5m5CdGR3rC2toDtLO0wpYjo2Q
         SDog==
X-Forwarded-Encrypted: i=1; AJvYcCWuL/rkonYQGJcgcwq7ViZxrBuB00+ebAh5XHfMPnTuuWyB0i9Zvs4ovN+/zVtvo7Pin+YFITPZcvifJY26C6vfuIYke6TP7wtqHq7s5YEmpPanqLaKZrb46HSPqZhfsYfZfwXSMOuzrMKVluyyWUw+6dI3hG8Q3lxe3ejko9pM
X-Gm-Message-State: AOJu0YyBaZURL0iYCKUGvvw9igJMoDXeOumAqjRHAw0NKUwp6m1H8ble
	2EXvF7IBsF0IqcjXAnisa3Cu9Btm1yfGUMavool7xoYzrKGgt2Ns
X-Google-Smtp-Source: AGHT+IHctzEbCJ0zIC/W29fqRusdFNSQJRt7P7ntp+/eb2LVdwQ/FleSZOrJXKKIk+UeThHSav1Bbg==
X-Received: by 2002:a05:6a20:c890:b0:19b:a07a:344d with SMTP id hb16-20020a056a20c89000b0019ba07a344dmr15658884pzb.7.1708453142076;
        Tue, 20 Feb 2024 10:19:02 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id r8-20020a62e408000000b006e3a4766c7esm5984542pfh.68.2024.02.20.10.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:19:01 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 20 Feb 2024 08:19:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: mpatocka@redhat.com, linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev, msnitzer@redhat.com, ignat@cloudflare.com,
	damien.lemoal@wdc.com, bob.liu@oracle.com, houtao1@huawei.com,
	peterz@infradead.org, mingo@kernel.org, netdev@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	mchehab@kernel.org
Subject: Re: [PATCH 5/8] usb: core: hcd: Convert from tasklet to BH workqueue
Message-ID: <ZdTtFFRC7dmiS2wL@slm.duckdns.org>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-6-tj@kernel.org>
 <bckroyio6l2nt54refuord4pm6mqylt3adx6z2bg6iczxkbnyk@bb5447rqahj5>
 <CAHk-=whqae-+7Q7wbtnEj7YmR8vsx6skTj6j-srV2Fz7cBZ2ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whqae-+7Q7wbtnEj7YmR8vsx6skTj6j-srV2Fz7cBZ2ag@mail.gmail.com>

Hello,

On Tue, Feb 20, 2024 at 09:55:30AM -0800, Linus Torvalds wrote:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
> refs/heads/for-6.9-bh-conversions
> 
> although it's possible that Tejun has a newer version in some other
> branch. Tejun - maybe point Mauro at something he can try out if you
> have updated the conversion since?

Just pushed out the following branch for testing.

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.9-bh-conversions-test

It's the same branch but combined with the current linus#master to avoid the
rc1 wonkiness.

Thanks.

-- 
tejun

