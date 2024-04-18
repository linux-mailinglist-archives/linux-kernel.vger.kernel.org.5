Return-Path: <linux-kernel+bounces-149427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042118A90FA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B5C282816
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAA13BBD4;
	Thu, 18 Apr 2024 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASVVbVwz"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F5D6138
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713406050; cv=none; b=q2lIkUww2Fy+GmUAD6FaqFJReyEefuCN0UojoaKUIGcs4YA89pz6yGtO6tTHEPKII13ptE1NmDfqUysu6jm3Za82GZymKNNj1pgYEr8rlqUW0WBySNZSZgNCyR61yWoB7hrFisFoyQo6G2GhEvYtsczobDXC5UV4MV3IR3axIE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713406050; c=relaxed/simple;
	bh=+KEGnBcOMKQg1e6jhwZpTqi+bVvKRdapHRMb2dM0wtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJYyN/c9afp9VkVESA7pKVnvhMZpkEfkvpvhX2SG9l4HeLUBUMEIajlinTnL4wX/U9pqUdgkA6ss1G4K5cNjoPMGXNFShmegfQFF6cjq0cLtpp/MC6u4GItymtASLzPGgTJ8zS4txygTYqc1HNb7NFtHKJW+8oCFmIaezViU0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASVVbVwz; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-22fa18566adso206099fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 19:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713406048; x=1714010848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0cZvLjNhi5psGTi/M7oTNlbzmf7LpqbmTlYFheoOKB8=;
        b=ASVVbVwzZ4sx9/Jkpm3Lqw5y3aFM+/HOAkx93baMcwocGvZdYMGS77yneIcjgMtLH3
         XDKj4/XdLceJxgsdm9eHMlaxawLzWsEQ2OdV+a2byzqwA5LLFjDfZZb9ODX32brssK0S
         Nplfaz63D42ERia5GcnzL+7kcHju4nNjY/LaXCMaZlAh73EAxn+kiA0nfShwEVqFjj8S
         NPc0U2D06IZr/UqRAnjkBQnMzwjEJTtgnG1GrDpgW4Ni3QLmDnpr78JEDt3eMvMpW4BN
         GcfDr7j3Rp5vDmYbXLp7MT1lkq0dTo0W61zmAmUf9xGFHBlV9/d+uX7pi2n6ZX7eQuSn
         EdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713406048; x=1714010848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cZvLjNhi5psGTi/M7oTNlbzmf7LpqbmTlYFheoOKB8=;
        b=SyFa8aPj3kaLLrxM2QCaiEpX04UCyruy38UUKQZ5E6RSA4cbNUiZVNBnuXVpGNGfry
         zn4I6hD1CY5hae1ZMBblO3UJlEGx4l2MXz4U+L6ycgKTqerlnCIVrBPwa4j4l/v3EC9S
         HCu6R0jH8dYEtywNtXdS8/krfo81rc02NBDIp2+3/rKei5b1Gx/cvKPnl0fWA35yH9qJ
         bHTlfcOz5oIpnBRA6Cq6MQkWUlFOibt9FZhrNnmYTD4cHWMp/fQOIV3wpmDgnd7SFsXg
         2SOawbsEL+BLzovEMa6kL88jUJLz0a9GKyDmy3RKYR0qZSQXt1Jl02MLg/WfwMvm+oh0
         eCxA==
X-Forwarded-Encrypted: i=1; AJvYcCULBdNTELDXFCbdWGZtf7dhsUSLA6Yo0NceXCUAOUZPtLOOg0BxuBU8oWbMgapMbus4gtqVWJmcBFt15Q2aUsI4uBwTCNWcMhvU9jzM
X-Gm-Message-State: AOJu0YydUdEQMWAPX0n4CLTPHFcNTHRl9VjskCrAfIbMsmvGJnlOS8es
	o1bbnh0nHQ8hBopd2MLNZsWRbv8RI33j+LkvQkTfxfXVN2EszzA5
X-Google-Smtp-Source: AGHT+IHkRREgGYfHbnLerfWwG1l/nPL22jRK5el/rJ7qosjGL2kgjZfx5vUtE7jmFBUVX7TkEjKdJw==
X-Received: by 2002:a05:6870:610c:b0:22a:6c9a:ece8 with SMTP id s12-20020a056870610c00b0022a6c9aece8mr1783850oae.21.1713406048246;
        Wed, 17 Apr 2024 19:07:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id kq12-20020a056a004b0c00b006e6c81b6055sm356551pfb.6.2024.04.17.19.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 19:07:27 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Apr 2024 16:07:26 -1000
From: Tejun Heo <tj@kernel.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Bjorn Andersson <andersson@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bug 218665 - nohz_full=0 prevents kernel from booting
Message-ID: <ZiCAXq-jS1Z6vgCK@slm.duckdns.org>
References: <5be248c6-cdda-4d2e-8fae-30fc2cc124c0@leemhuis.info>
 <enqg6mcuhvff7gujjbapdiclicl3z6f2vnggcsg65pexipyr3o@4men5fhyt3vb>
 <28c84b3b-f68f-4f45-8da1-9c3f9a342509@leemhuis.info>
 <7kugx5ivbplwwrcq5zp37djtpakl55b3pfy36gpbsbcx43dpcs@uheu6iv7gm7h>
 <81149f18-0132-4ace-8c71-1b75790a88e4@leemhuis.info>
 <Zh8H_vG2dQLOjoIB@slm.duckdns.org>
 <51942e58-a5a3-4dcd-80c1-6735c7b5cc1e@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51942e58-a5a3-4dcd-80c1-6735c7b5cc1e@leemhuis.info>

Hello, Thorsten.

On Wed, Apr 17, 2024 at 07:48:33AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> > Can you elaborate why Bjorn's case is different?
> 
> Well "not booting at all when using 'nohz_full=0'"[as reported two
> times] and "I start neovim, send SIGSTOP (i.e. ^Z) to it, start another
> neovim instance and upon sending SIGSTOP to that instance all of
> userspace locks up - 100% reproducible."[while no 'nohz_full=0' in use]
> at least on the first sight to and outsider sound a lot like different
> problems to me -- but of course that impression might be wrong and you
> know better about these things.

You are right. That is very different.

> > I was assuming it was the
> > same problem and that Oleg's fixes would address the issue.
> 
> Bjorn, could you give it a try?

Yeah, I'm curious whether it's just a different symptom of the same problem.

Thanks.

-- 
tejun

