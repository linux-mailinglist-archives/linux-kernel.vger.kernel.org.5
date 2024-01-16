Return-Path: <linux-kernel+bounces-27667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDEA82F3E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69291F249ED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BBB1CF83;
	Tue, 16 Jan 2024 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2ZZqprn"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918ED1CD21;
	Tue, 16 Jan 2024 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428880; cv=none; b=Jxe+xQOghFsP4qmByNls5v7LWdrsutRmgCFoJ62/QyOtmIOYN7OHm3AXkCgJsfyraLJGO3dqtgY8dAo0IR/PyKmVrTuwKu7gM6ofhOcOo9AqhjJGA1qhSKrTOo3hO5acdTBxoVYYiLw+VXhr03fNuouXppvCwjCwWOxfiehLIkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428880; c=relaxed/simple;
	bh=/8t8aGI0dsmuyvHxpwC8tN1rzHOQ9w1Gua7WMUtjW2w=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQ9r4hKBlkF2rHmTTgOVLxNRyNHUBBP29bpgghkiGXDwIu6p7T8iqhLm3J17Q4AqdrPI+ngFKP9nujT+YFA/bLvkl2ejmtZI8bKrbtnJaRIfStwaPGMaGGwzmgiFMraZunY8cSsh9JsCYa7sduFiTFUHuf+GsghpDhGGJrx2isQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2ZZqprn; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d426ad4433so62064965ad.0;
        Tue, 16 Jan 2024 10:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705428879; x=1706033679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLYtcvGvL/mi4llSElQtiPFZH5wjeerjqPS6bhhaNQk=;
        b=W2ZZqprn25xsX8LeP5sd+769+mQ7eGJvspyHSXg7hcGfHdFuKrP+XZn7oPSnhfAqDf
         Whgju5bl28xEfUAuurXqma/gaQJS4+hdPki1GpZrBodPc1tsW6fonNW7oex1XhGkS25d
         wBDvYFDbYipFJNLX8+jliG/5a0olZ7MxpzqhEw3me06eOBMSMLWWBhBHPTyY8V32rfXM
         Sq9x2jO4QtfkdgjSPGbpfkmVmYmgq1vYdVfaQ4mPsej9kHP45lTg1PdSKe1fXDzTm5br
         0V926PE4Vqf7N9v14fnWcpJkf4UChb/dQhB4AsAgpteeLAxtRjexzXcmAYtcyi+DTcoh
         nLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705428879; x=1706033679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLYtcvGvL/mi4llSElQtiPFZH5wjeerjqPS6bhhaNQk=;
        b=up/bDNTuJBlIuc4XtGuiMLDFj3Spf1Kz69vDpL+EAGykOiCbNKxplKdPy+xZt4qb8i
         FdpokKo9a6RKhm7qsuj5/Td7gtFXFfBT9YOtVbarcMzjdY7aCKGxlqpT2qe44rOZe4yn
         5UA+TUUmH3/xvRJKneJK0P1/49sCYg0P3UiVHB96leP/GvN55C5A6G0v7xiY4SzlYdBT
         JuD1Z/s54IFP9+ckOxc11pbrSbtj5WjywtvDONjIJ9rYNuHSxMEP2UvLiZ/IaoG27fwC
         1edyTajPCtJh4X3xg7VuaBbBYV9n9zQP8/sl9uxeV+grJkL8T7IFUMjg6Ete6Iq45Mav
         08GA==
X-Gm-Message-State: AOJu0Yxyxv+gzWk/mlK/2GKnrEGqli5vrJgsjfPPUMNANGi/iw8XuV8z
	RiDkCX2bc1dsXd67MUWh4EQ=
X-Google-Smtp-Source: AGHT+IH6JhzGVYdHplZcg5wg7Tyj4SwHva3TepBR8qWjhKWXw2ITVqqKOk8t2393Tp/quAQoAg669w==
X-Received: by 2002:a17:902:8505:b0:1d5:e387:2ef8 with SMTP id bj5-20020a170902850500b001d5e3872ef8mr1157058plb.113.1705428878775;
        Tue, 16 Jan 2024 10:14:38 -0800 (PST)
Received: from localhost (dhcp-72-235-13-140.hawaiiantel.net. [72.235.13.140])
        by smtp.gmail.com with ESMTPSA id e18-20020a170902cf5200b001d58ed4c58asm9556708plg.63.2024.01.16.10.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 10:14:38 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Jan 2024 08:14:37 -1000
From: Tejun Heo <tj@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Onkarnarth <onkarnath.1@samsung.com>, frederic@kernel.org,
	quic_neeraju@quicinc.com, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, r.thapliyal@samsung.com,
	maninder1.s@samsung.com, oleg@redhat.com, peterz@infradead.org
Subject: Re: [PATCH 1/1] rcu/sync: remove un-used rcu_sync_enter_start
 function
Message-ID: <ZabHjU45N4H4L9jq@slm.duckdns.org>
References: <CGME20240111092805epcas5p2ebb993010ae31d039e8f9de1e7818f7c@epcas5p2.samsung.com>
 <20240111092722.322454-1-onkarnath.1@samsung.com>
 <de792eee-1f44-48e2-a122-c3ded1645155@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de792eee-1f44-48e2-a122-c3ded1645155@paulmck-laptop>

On Tue, Jan 16, 2024 at 08:50:35AM -0800, Paul E. McKenney wrote:
> On Thu, Jan 11, 2024 at 02:57:22PM +0530, Onkarnarth wrote:
> > From: Onkarnath <onkarnath.1@samsung.com>
> > 
> > With commit '6a010a49b63a ("cgroup: Make !percpu threadgroup_rwsem
> > operations optional")' usage of rcu_sync_enter_start is removed.
> > 
> > So this function can also be removed.
> > 
> > Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> > Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> 
> Adding Oleg, Peter, and Tejun for their thoughts.  Any objections?

Looks good to me. FWIW,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

