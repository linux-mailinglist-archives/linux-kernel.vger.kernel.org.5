Return-Path: <linux-kernel+bounces-97429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C322876A56
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9AE6284EF1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AB350A9D;
	Fri,  8 Mar 2024 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uYVPMkco";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kgJrC8C8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDD740861;
	Fri,  8 Mar 2024 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709920752; cv=none; b=usmVDfjYSIaZkT2Nf3+ofnV486rmG/0HJEAOXUsv+/YlzYl+QJLH3OHOhyl0is3iUY4TW0VWw12NG+hxtZb7l7hV2/oVfpOClhJtMWfs1e8cze38vNJeJaGxTRRcag4Axfl9cWFUtYzLMvqVrlHUGUBBnd9RleL6dDTqCzTS9Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709920752; c=relaxed/simple;
	bh=v9TVEwaCU3ggziH+Z09sETdzhB/jIVSJH7mxb1N2tlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tqn3YWB7odf93LnU0IsxbFMBRRlKZ+rn4iDrQdFfJtMOKOcl47YK+NNiiXE2nzOhH31fCYHTmEpJ8xJTJdkmpAF8e8RNMrKbbbWYw3I8Gp0aeqdsUtCHE0iAtUWcblz6oUJ6v1pLJ6/GZqyASqRXfsHOnHboZOsJLDrv9NxSA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uYVPMkco; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kgJrC8C8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 8 Mar 2024 18:59:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709920749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9TVEwaCU3ggziH+Z09sETdzhB/jIVSJH7mxb1N2tlc=;
	b=uYVPMkco1a/d/xnyB59EiVy7KjV5lYesQqdxZVaA0xTHP1mX7bsPEyV3TBKV/E1R6nH0cw
	mAgASTLx4MOirhWlVXQ+VVjdxUsqU6X+ze/lCa829LXdKMwrsYX61I6ozF2N/IlGmwKwF8
	VdMWJLgNP3jLaotDaM4UJPyDJe60ED4xvUy8n1rYzNiSg+ZuiAKWAXkj7+cZj7hflh2ga3
	1itlh6HebgMMHUHJ3SRkU0gMF56iKYzp/D81Jy2f4S6BUcf/upF+3+OMS2tqK3wKVYQrLV
	mv88ivLGAXaTj17TijMLBcCPdsoLXLRG8TSzgAjJ/AIEmSU9MX2C1ZaFFdv2xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709920749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9TVEwaCU3ggziH+Z09sETdzhB/jIVSJH7mxb1N2tlc=;
	b=kgJrC8C8rz7FUVeCewk24+rB5Gec0JHU2EjgBQiGTHLOAsMvoEVhc1os8tkGVetnwa6G2x
	BflBJ5NYkm4QOBBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mike Galbraith <efault@gmx.de>, Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>, linux-rt-users@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Alessandro Carminati <acarmina@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Artem Savkov <asavkov@redhat.com>
Subject: Re: 'perf test sigtrap' failing on PREEMPT_RT_FULL
Message-ID: <20240308175907.Stc5UU3y@linutronix.de>
References: <ZdZOYnIkjqkyfo5P@x1>
 <ZeiZWjRUmXszp0CN@x1>
 <20240306165443.5AKJ403t@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240306165443.5AKJ403t@linutronix.de>

On 2024-03-06 17:54:45 [+0100], To Arnaldo Carvalho de Melo wrote:
> Not sure what the best course of action is here but based on what I
> learned last time you reported this I think we need delayed signals=E2=80=
=A6
> Let me look into this. We had it and then removed it because we had no
> users of it at some point but probably nobody took perf into account.

=3D> https://lore.kernel.org/20240308175810.2894694-1-bigeasy@linutronix.de

> - Arnaldo

Sebastian

