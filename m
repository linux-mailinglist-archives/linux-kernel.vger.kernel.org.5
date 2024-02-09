Return-Path: <linux-kernel+bounces-59849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF3B84FC7E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E96051C259FE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788CD8286E;
	Fri,  9 Feb 2024 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aYciGQNZ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6746280BF2
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505213; cv=none; b=ngBURcU9Fa77Cb9eaaa/blz8zupUF4XbCm0dhZi2gsK9KYc2uS6NhSz8B88C2re/gnmeX9pElmjTfwFx1GjV613nFUPJq1y74AeQ9nRbeLKXTL4qgsOSYLfmezFPpZf3o47Ndt5AAHHLh/m4XzM22kdTQOuEu9ZnOyxgkm6D4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505213; c=relaxed/simple;
	bh=/xxA9aj9+moZRyZEhdH5ivAhhjreVAvaHdT1JeQN6l8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E8tnx+gd+cBuPXGIcs2hvU9Dcr94KWF1v+90RogXZYHdNHQEqLs8THi6sVy1HlP/qvHWmLN4U8MBk+Xmm9M2vh30MLnpZyBRnbTbs7NAvjjF8DHR8YbMdq3DGi6SJxDy/jZvWeUf7tep/vXZIlOSGTeveR77prnab9+BMopJfgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYciGQNZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269b172so3050097276.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 11:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707505211; x=1708110011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8N2lymSXP7FC6HVuiyphIGsQpdTBuCsjr2jpaDS1PFU=;
        b=aYciGQNZemh4mD9W/6DUgVrI6hBdMA9cxErYqkpFwLDOkpNZ5ARsvSle+p2hOh0XCc
         rFW6WtBfhlBdfG+3osYVScXGyUmZAMEL9q6dHJgwUgGxwBmwNA0WeFUheFXGo33Hicfe
         5rWdD0N7io6lq5fE72FVT3ZKPYblOU9JSlH3Rc30H//dnaxCIf7SomyCmQYBRBOY63pv
         ni8UDBQZCt4GzC1IKt4YDTTi6dT5ngxvdq7KxWVZVs1Ok403v8XL5m4hruooDLqxcqUA
         vp8M4DHtDYmd2JCxkSmaCl1Pud++cCGkqOqJeWTxOF4sckMXvn/IK28bOjo1TdwWmIKX
         Q/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707505211; x=1708110011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8N2lymSXP7FC6HVuiyphIGsQpdTBuCsjr2jpaDS1PFU=;
        b=iQLf+p1+UeqZHGflqPpKyUfOqjyZuBeQuAt5Z3DUBN40wmMLzR2YWbU4Uj4jIvwWEz
         g85+ZmFzqzAwYRM4m3scAX81oqOYJR+N9Crgr4MwENewzGXnT2hSd1FUZYmNgG388iv1
         mOjbDjLdE0w1/W5muBAfWhMWRSK6b12LLvNejPoPDesxvK7JE1JxgaZylTpiw2Eb1xvp
         srkPSxBClrggpnHob9IP/98BquSPuxkstg0WcFPyKwAECWuOOryWGdKXRXzKJ5mvoCSa
         xo7KMEHQQbT0hD+D04Dk7i/avQYXN0h3u8Jwf3sheysv6/l9U7+csN7J10JpqJXaSQRh
         XGHA==
X-Forwarded-Encrypted: i=1; AJvYcCVPRcfXbM+fHFFlp4QB88ywDX0K9mjdH3Lj7Q8PGH6KTjmTWOZew/sV22nuZDYe9Kg1T2VhkkO4KYe+STNfpjNOps4z+gAXDF2blo8h
X-Gm-Message-State: AOJu0YxpKJQ7WKCySMKf7q8KeD3B9fOSygZVJKWbUy/MgcryXGErPebx
	ygdSL/Bq+Y+LKD26WzWMjXWNvEMOyqakpKCGHIo/5F+XOFth+t0q4tCmH4cgcURYIQ==
X-Google-Smtp-Source: AGHT+IH5Q0IlUbPlUBMLY7u08YFFuSOUvpr1JP/Ap/gH8ZtyZ66trBmIwIQNGyH5+xgLUW2XPLj1khQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1002:b0:dc6:e884:2342 with SMTP id
 w2-20020a056902100200b00dc6e8842342mr1088ybt.5.1707505211418; Fri, 09 Feb
 2024 11:00:11 -0800 (PST)
Date: Fri, 9 Feb 2024 11:00:09 -0800
In-Reply-To: <3htegzrugq4xwlizizsaku6g2pzwhndcnxxxmji4fvblisiuro@icvcsa3mky3w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ngc7klapduckb67tsymb3blu2wlmdsjo4pa4gbaivgxezbwzxp@v7akqu7gbwl4>
 <ZcV1GgitdBUIcKJT@google.com> <3htegzrugq4xwlizizsaku6g2pzwhndcnxxxmji4fvblisiuro@icvcsa3mky3w>
Message-ID: <ZcZ2ObDxRwZ-hKLb@google.com>
Subject: Re: [PATCH] net: remove check before __cgroup_bpf_run_filter_skb
From: Stanislav Fomichev <sdf@google.com>
To: Oliver Crumrine <ozlinuxc@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, thinker.li@gmail.com
Content-Type: text/plain; charset="utf-8"

On 02/08, Oliver Crumrine wrote:
> On Thu, Feb 08, 2024 at 04:43:06PM -0800, Stanislav Fomichev wrote:
> > The check is here to make sure we only run this hook on non-req sockets.
> > Dropping it would mean we'd be running the hook on the listeners
> > instead. I don't think we want that.
> 
> You are correct that we don't want to run the code on listeners. However
> the check for that is in the function this macro calls,
> __cgroup_bpf_run_filter_skb (the check is on line 1367 of
> kernel/bpf/cgroup.c, for 6.8.0-rc3). The check doesn't need to be done
> twice, so it can be removed in this macro. 

Maybe we should instead remove "(!sk || !sk_fullsock(sk))" check from
__cgroup_bpf_run_filter_skb? BPF_CGROUP_RUN_PROG_INET_EGRESS makes
care of all those corner conditions. We just need to add those checks to
BPF_CGROUP_RUN_PROG_INET_INGRESS.

Let me also CC Kui-Feng, he was touching this part recently in commit
223f5f79f2ce ("bpf, net: Check skb ownership against full socket.").

