Return-Path: <linux-kernel+bounces-124286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8111B891514
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BDF3287B56
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BCE48787;
	Fri, 29 Mar 2024 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEiJ/gTp"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196963EA62;
	Fri, 29 Mar 2024 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711700144; cv=none; b=f5myAdWB/c74UW7WptiTAQm7PQJ/CgOe6/q4b8KxYP3oAExCzj8XxloM688icdCmc2wv85lv9LCv3UkAGcQkrF6MDDRAyppbFpL6rMLxL4Y8KkL3XAOZaHLAAD4dL/W4vzSTF4WaZkJxSi7EBGcqo8Erjwh9CrkNIIHPmuMrhdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711700144; c=relaxed/simple;
	bh=6n/QVOvkQ4BcV96xx2uONvGMr6jJ/2/o9PowaWsduw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gc5tMJOslEAJlpHg+XTZBdB4e6ldcBm+FTiXwUczEFqmC1GOKLlmkg62gbDDdNeL//HabS3lAiC4t07M4GgE2pmZSkzhFJY0nVXpZWF6WJPhVr0VbSVo3+N0iBi0itnf/NpZSQruiYFlqu8Ht1xSIXa17EgAoV6IXXKy8VN8H/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEiJ/gTp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4e0e3ef357so233797266b.2;
        Fri, 29 Mar 2024 01:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711700141; x=1712304941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aSYngHOh0xu8jyBiYodXCsYFEDRn/f5k50FDMhmEvE=;
        b=DEiJ/gTpxIsUoztm6/1oN0NztqRwGDrsU2YA7GEGVwzN8mzdeKJMAgmP0TXZcGvjBy
         nZhTtgrmre3Zg/+0uX/w/zgLG0aa2tOD21VxHaaSBygi5ypjx/inTEkQWhKL89rNayDn
         102T6MD7jDTibIDmY7NMwS0rHaoPxtC1Izp65fLHMauSc2ZXSFnY+w5npo9Z6EWiTiYz
         rVDeO2zuTZTNqCJmYYZFbiplEgZIpIyzciok7C02dAsN2yrdX37OlNX3ClruM3jQL0vI
         m+YwdlVK3E+vbi3aF6LukaegnVseY36UF+CleFBQ0gvXY9qDIKdwUtjLaE9SLplZKXjg
         2KiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711700141; x=1712304941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7aSYngHOh0xu8jyBiYodXCsYFEDRn/f5k50FDMhmEvE=;
        b=bWDmIdm7MuR34D6ysjjkjox3cIf/A57LyDs15ddzInMQn1hrrAm68rYD3aTSzfxVJM
         eGfig+7ZuXqCo8M4FA4eb0b73/IUkUZvYR9oDACncya5/ZjgU88Uk8BasQpwkWnMR8W5
         2c0ieeguho1DkRII82+pnHuiUJodIZLz5UKbiFD528Px9jLB4kFtPRGPdki+1f/p76b/
         21E3mvwajOSsn+38O4uI3IAsGxYSea/X6szwCUwUeWxQ976MS82NM//vZyG12G30AsR4
         6gU4gky9V7iogIqkHPUgPG9YQD7kbX2aAB/ns+dGmuEtxtK0vS9wcBb40kikbwuqj6mU
         96XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUATIMPqb348lQTAIZjmKJG4DWowk70/+C9scu6XAhp75/NZZXE8U7oExHbeYAcrmmtjpDoNotFXmih1Zy2AkmlJQtsGhoqeTp22+Ai/+8vwbbe+XlIA96Q/+qIJYaoSqlxKZ92
X-Gm-Message-State: AOJu0YyRzbHPXMBDgssAPEtte5+zG5LX6p6HP8ROmD2biRvlnp+b7sYr
	Hpd8KstMh+a8Ywqu1j7OORpHgd4tsVCyuI+CbqglAMRYKxvGSF4S
X-Google-Smtp-Source: AGHT+IEELZMCPR3A1dINqt8iO9RCrhHrkwiQEaavtjQTwB8Qqz2UuU9+b2g9bBKGsznMcY8kdwE8BQ==
X-Received: by 2002:a17:906:39d1:b0:a46:e0ab:40ff with SMTP id i17-20020a17090639d100b00a46e0ab40ffmr1193488eje.35.1711700140971;
        Fri, 29 Mar 2024 01:15:40 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906501200b00a474d2d87efsm1646696ejj.139.2024.03.29.01.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 01:15:40 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 29 Mar 2024 09:15:38 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Pavin Joseph <me@pavinjoseph.com>
Cc: Steve Wahl <steve.wahl@hpe.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	stable@vger.kernel.org, Eric Hagberg <ehagberg@gmail.com>,
	Simon Horman <horms@verge.net.au>,
	Eric Biederman <ebiederm@xmission.com>,
	Dave Young <dyoung@redhat.com>, Sarah Brofeldt <srhb@dbc.dk>,
	Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4] x86/mm/ident_map: On UV systems, use gbpages only
 where full GB page should be mapped.
Message-ID: <ZgZ4qlbncvxhboQ0@gmail.com>
References: <20240328160614.1838496-1-steve.wahl@hpe.com>
 <ZgZqhWoRZoq5tJoU@gmail.com>
 <47302624-6466-41a7-85db-f6872d58a4d2@pavinjoseph.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47302624-6466-41a7-85db-f6872d58a4d2@pavinjoseph.com>


* Pavin Joseph <me@pavinjoseph.com> wrote:

> On 3/29/24 12:45, Ingo Molnar wrote:
> > Does the 'nogbpages' kernel command line option fail on these systems
> > even outside of kexec (ie. regular boot), or only in combination with
> > kexec?
> 
> Original reporter here, using nogbpages allows for normal bootup, but 
> kexec fails with it on my two similar systems.

Just to clarify, we have the following 3 upstream (and soon to be upstream) versions:

 v1: pre-d794734c9bbf kernels
 v2: d794734c9bbf x86/mm/ident_map: Use gbpages only where full GB page should be mapped.
 v3: c567f2948f57 Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."

Where v1 and v3 ought to be the same in behavior.

So how does the failure matrix look like on your systems? Is my 
understanding accurate:


           regular boot  | regular kexec | nogbpages boot | nogbpages kexec boot
 ------------------------|---------------------------------------------------
 v1:       OK            | OK            | OK             | FAIL
 v2:       OK            | FAIL          | FAIL           | FAIL

?

Thanks,

	Ingo

