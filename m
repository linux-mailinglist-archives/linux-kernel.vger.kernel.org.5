Return-Path: <linux-kernel+bounces-35943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04667839901
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991A51F2D460
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0EF86ACB;
	Tue, 23 Jan 2024 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRKm9Ker"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A70186AC2
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036217; cv=none; b=AA9X9iYtPENFaDJbEL0r1X5ldJbx0TucqXrB8UvdZrYFil3NgVsVJCenmX92DKy7HZKV2BxEMxrzXZS9qCgpUUVQOBsGaQjfEpdNGL8aUPl9b5wnwY2dB0sKZ8PQJA09CdrjaOJvHXUYpKk2wTz35DSLdGYkd8kbYBv1LqqL8pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036217; c=relaxed/simple;
	bh=QLm5Vz8qFoYEruw2+K1bab8WvC1tLQXi6xVjT0Rm/5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K84i0C+l9EXclzl42/gTORzHS6ofI1nmhDtEa31HfweSsPJGG3zeP1I0rUHpe+Leggf7YKbYd7uqbXYy2HClNdRNTIYytEmWB+V89bi9k3LlFYSjHJ/WcRN0e6abF6bL5G8QB+Nx2JXA2egIaE2/S5N6kQ8ueYoLdMuz7uqA6W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRKm9Ker; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d72f71f222so16595125ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706036215; x=1706641015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VTYRquoHREccZxR1itO9s8RbRgXaZi6R4whUcjVcHgk=;
        b=GRKm9KerLKiU4QSfDr+rjM/UPYeJ+RT6FbSn/z2oF0PJtML5i1NA/oJFAxzO9LVkfq
         EDW8/viC7drrvMqsXVrGR2iKmgjdsNFJEAYqIMZsl//tPE4pvswToCT4NCPyzichof5/
         R6TwZsDFArSH1H8d4N2QDCzqMnZ6pytrecA68rv61ELkyCDB2SXFG70eMUvtsZj+NwyF
         udXiIDliUxafYU1AYQbj+Q/H6kEDEJuG6elxKDobgYje7JvM4teqv2kt2WK7OuN75TrH
         X9IZAgfziP8/N/dWjAs4Danu5a/v1T9KBENg0tFB8+eO4/nLkOG20DbbKDxEtUw2U5ou
         O8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036215; x=1706641015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTYRquoHREccZxR1itO9s8RbRgXaZi6R4whUcjVcHgk=;
        b=gk9kF/aSm9xpANubK5tjAzso6KlWoFnkIx246Ra7DVDls26/AFQe7ElxkF1vc8bnCT
         Rwed8iELr+2zJlvvTtAA34I+Ly79UvbMY0MelxKprEWTykCYeyRrvBW2e0fzLvCR8FD1
         3RZZmraGLH57vyaEqfUqfOsks6NSCj1/jOMaKJG1g9Q/MRB+YNuHF6tl+x/jlNu3EgFR
         ByYs/WjorXTqRIQlJnmzNrHo+6Bvmo4uF8ZLGgnuo1nqYfzQZlSpicaB55a1acP+9r0G
         gAw0tPZQWrp3a80YAgYZel7xjC67nzwD8zvC9zScXNWmi7ZIFtlsGAuHwAGkq8oj4jcF
         kspw==
X-Gm-Message-State: AOJu0YwMmSugmk81dWt+QmyVdA6ghHcGgOgAewO2XkUt8uhKo+vDPEPb
	b5ngAdZD3SAdXeINHVa3PSMc7CXY9DNsKRNmFMvs6mjMuD+BO/M7
X-Google-Smtp-Source: AGHT+IEMZj6K6HqsppprbY9criGaawvzXF5rp8HE28WO86V+oLIy+dJRj/61X2cyQM/T2T+v7vQiIg==
X-Received: by 2002:a17:902:e543:b0:1d4:2a95:ec2a with SMTP id n3-20020a170902e54300b001d42a95ec2amr4497836plf.0.1706036215262;
        Tue, 23 Jan 2024 10:56:55 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id s21-20020a17090330d500b001d6fbaaeb56sm7017528plc.145.2024.01.23.10.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 10:56:54 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 23 Jan 2024 08:56:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Joe Mario <jmario@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mark power efficient workqueue as unbounded if nohz_full
 enabled
Message-ID: <ZbAL9WBNkKuaZjHj@slm.duckdns.org>
References: <ZaqbP0QmVPAQTbYA@tpad>
 <ZasMfA-v1YykDA1i@slm.duckdns.org>
 <Za56EiAI9D5S8NuT@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za56EiAI9D5S8NuT@tpad>

Hello, Marcelo.

On Mon, Jan 22, 2024 at 11:22:10AM -0300, Marcelo Tosatti wrote:
> About the performance difference (of running locally VS running
> remotely), can you list a few performance sensitive work queues 
> (where per-CPU execution makes a significant difference).

Unfortunately, I have no idea. It goes way back and I'm not sure anyone
actually tested the difference in a long time. We'd have to dig through
history to gather some context, set up a benchmark which exercises the path
heavily and see whether the difference is still there.

> Because i suppose it would be safe (from a performance regression
> perspective) to move all delayed works to housekeeping CPUs.

Yeah, replacing power_efficient with unbound should be safe.

> And also, being more extreme, why not an option to mark all workqueues
> as unbounded (or perhaps userspace control of bounding, even for 
> workqueues marked as "per-CPU").

There are correctness issues with per-cpu workqueues - e.g. accessing local
atomic counters, cpu states and what not. Also, many per-cpu users already
know that the cpu is hot as they're queueing on the local CPU. I'm not
against moving more users towards unbound workqueues but that'd have be done
case by case unfortunately.

Thanks.

-- 
tejun

