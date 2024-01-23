Return-Path: <linux-kernel+bounces-35498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA6D839206
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9639E28AB0C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F6A5F861;
	Tue, 23 Jan 2024 15:05:54 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2BC12E5F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022353; cv=none; b=LdnBI7lMpm6ptWElgJClPFCrk2jrkvt0vivlLaJlmWPwwXAncDOUMAobes01Sn2xLb41taOHvKmIPciEwk7xc9cL9mMJkwtpvlF2PptzvvUnnjFmTCCNjygsSAC8IgU9e1WE8NCXi+YG9WyroxUpgEIECTWLXEpM2vJD1okqbEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022353; c=relaxed/simple;
	bh=wvGlVsQRlMzMaGWrgeHCND3JeOnNmKmCHpOURqz56Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amx5Bsclhfnq1w6vqu6LpOBCs6/y3T1k74auyXiqLfp3Cp+B8vBXoToXHyRAkVQv3M24slTpiBcLi9OrQyrYc6F1U8CWf5JWH70Iq1FiXM+q2PKxdqikDWZhvtfM7RAj9QmfjmHpekzW2znv6ic+b7Pg71Uz3oo/tMHR9Sb/ONE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so5178834a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:05:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706022350; x=1706627150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1Hr4uS3fFpYg2vOteF+nJHwgU9ofLyiq0K2GCPAZ3U=;
        b=hU44VnsXVxmS4Bqi1e1FUjqh/aOky34lVadbG7vjvlMNH8hXkQoG1xHmDFBvrdpzVe
         AsfT4Cen2P1zHDqsoFJQ+ZgpoN57sgBCNKIq/fM1NO0yxXY8pD0mUtvKIdidjgq+a28X
         veNjs7X3pTkg/b+sA5y2R6kC9si43tKr4MqPU7FLLcxKrTWzb0Ks9RkFSuFEswpzuC+S
         O28OqjWTCznRKC8mMWJqV2IAG6DcCu3UVRbU2U+uZ8pBddY6K6W1k+pWvCLV74jZY+71
         6C8p2xNeod1sm/cUSwCWrsyQ7AqESS+nd5mqKOrAMHWjWP9+b8kBHzG3bm4X+a3sX/OO
         //TQ==
X-Gm-Message-State: AOJu0Yy9FBI2tmsJFtsQMNFpRZ/HSauSUID6vuUnut3UunSfss2fuz24
	SYWQSEeVpt9A4DTUhMMgOFDzJJONXNJffwnnpRgX/rDkJyzujqwG
X-Google-Smtp-Source: AGHT+IEJCuelrF5HYkEhlcLObygXfEiaQA/TP7/ghDAOkadWYS6fenzKfsyMar6fUp2OhZU8n9xk3A==
X-Received: by 2002:a17:906:1958:b0:a30:84aa:c2f5 with SMTP id b24-20020a170906195800b00a3084aac2f5mr7615eje.56.1706022350059;
        Tue, 23 Jan 2024 07:05:50 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-027.fbsv.net. [2a03:2880:31ff:1b::face:b00c])
        by smtp.gmail.com with ESMTPSA id t15-20020a17090605cf00b00a28aa4871c7sm14338053ejt.205.2024.01.23.07.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:05:49 -0800 (PST)
Date: Tue, 23 Jan 2024 07:05:47 -0800
From: Breno Leitao <leitao@debian.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: mingo@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/bugs: Add a separate config for missing
 mitigation
Message-ID: <Za/Vy2l1VwyI4DKH@gmail.com>
References: <20240118173213.2008115-1-leitao@debian.org>
 <20240118173213.2008115-3-leitao@debian.org>
 <20240122205821.m5dsyi4sc2ghoavd@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122205821.m5dsyi4sc2ghoavd@desk>

On Mon, Jan 22, 2024 at 12:58:21PM -0800, Pawan Gupta wrote:
> On Thu, Jan 18, 2024 at 09:32:12AM -0800, Breno Leitao wrote:
> > +config MITIGATION_RETBLEED
> > +	bool "Mitigate RETBleed hardware bug"
> > +	depends on CPU_SUP_INTEL || (CPU_SUP_AMD && MITIGATION_UNRET_ENTRY)
> 
> Atleast on Intel CPUs, Retbleed mitigation is meaningless without
> spectre-v2 being mitigated, shouldn't this depend on MITIGATION_SPECTRE_V2?

I suppose it is the same for AMD, right?

So, I suppose it should be something as:

	depends on (MITIGATION_SPECTRE_V2 && (CPU_SUP_INTEL || (CPU_SUP_AMD && MITIGATION_UNRET_ENTRY))

Is this better?

Thanks!

