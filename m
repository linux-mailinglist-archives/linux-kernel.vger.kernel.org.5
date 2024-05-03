Return-Path: <linux-kernel+bounces-167801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF628BAF59
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E88C1F23014
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291124EB24;
	Fri,  3 May 2024 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="NFN+tZ4c"
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F156FB8;
	Fri,  3 May 2024 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748532; cv=none; b=msvBhanBQVxPFD6oMOgTJVLksm9WhJPsUhr9L4p5jVMVKbnWdBdiU0sfHOZuR1AZNmtrNY3/xpVT9EgArlAzpMnn1+rifThnPNuORZYx6CEPLcQfy6r5hrThTi869mqeAVsc1lkNwLn9OdxxMlM4xZ4cKR5jiZepQQf3vgYDyLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748532; c=relaxed/simple;
	bh=kjlsgydpWRT0lSn6y6hEQQYaXspmakotMvAkaGT/n6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noowjy5BQOwCerDpmEjKXMAelkS9AqMhjdUZX8DPLL6EFPC7hWoxGX4cUxD3OlnqGq0esm4V1NXh3pJ/vTMbYKl7yWWlyvo0hao2J5NHe3U23sWXZ9nDApUjPF0sOlgLcROsuGUpsD1JNmkZ3JEk7xxhmZy2oO7WVEN79jkGJ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=NFN+tZ4c; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98DD1DB387;
	Fri,  3 May 2024 16:53:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1714747989; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=kjlsgydpWRT0lSn6y6hEQQYaXspmakotMvAkaGT/n6k=;
	b=NFN+tZ4cukKVrWPyk4iPuSDYF2R1vFb5KpkYg7ddPr4T5YT8Yuz9iXxOqmC/fere6ncRvR
	briQs60s2nFGHnlDWAvdxaB9MgczeKOmhvykoTB6nTJPCi4ngguMp879ZhyXkfjUVdZKtn
	pLHQfjbNdSO+I1CpYYoneVWJoBoSTj7qf5Q2WqhcARhiFWOILRAQ0QBqOxdqa95GsQio19
	LD+SfIZea8Jhia4YVDFXlWGLn3xsCuAShwyjxMaC2JXAUxoAUEVo43wYVOyBL3Qunk9riZ
	3l6o2R4uTdUzEOiT4WvDzArmL9P8ZkWDP0+J83zrrNDDkWKbCWOLCl8JfyEhiQ==
Date: Fri, 3 May 2024 16:53:03 +0200
From: Daniel Wagner <wagi@monom.org>
To: Pavel Machek <pavel@denx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	linux-rt-users <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tom Zanussi <tom.zanussi@linux.intel.com>, 
	Clark Williams <williams@redhat.com>
Subject: Re: 4.19-rt in May? Re: [ANNOUNCE] 4.19.269-rt119
Message-ID: <ahybli5jks4jfco7kiuotvukseqvg4vxxnlw522vs22cn5w7ok@qm5nmcskbh3j>
References: <167144069993.3503.13484547425689613996@beryllium.lan>
 <ZjSoeyEnkJPY7ST3@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjSoeyEnkJPY7ST3@duo.ucw.cz>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, May 03, 2024 at 11:03:55AM GMT, Pavel Machek wrote:
> I'd like to do 4.19-cip-rt release "soon". Is there chance to get
> updated -rt tree? Last I see is:

Sorry, got interrupted and didn't finish the last release. I've to fixup
the rebase branch before the next release. I'll see what I can do next week.

