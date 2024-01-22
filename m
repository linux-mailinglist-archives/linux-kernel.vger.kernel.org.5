Return-Path: <linux-kernel+bounces-33137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AADC836511
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55361F265F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AEA3D39F;
	Mon, 22 Jan 2024 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0spzsIQ"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBAB3D0D8;
	Mon, 22 Jan 2024 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932337; cv=none; b=N/ZLeoRyz+n3um1csaUB18Omdjc5/uyEqN5tOauywHuP+IBlwIerf+d80nfdwc5J/PaDlB7yk1e+fFlWDHge6jCRurveaLjNxDlLSas7Z5G1URiFvbIWCA7gaiLVl4KMmu1V3YWMU95lmoYgcRm80vu5XW/pUQn8AUf04HkUFQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932337; c=relaxed/simple;
	bh=KaNcnxhfIYK75oE3sF3lp/jlWP1epffWoG1yh7Ao1VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuwSpRzQDFj0XRk7nHZi3Q6RL2WqzyqCguYWQcx8NQNdL0oQ+6Ka+kqTUsQAmk5G6g7JOhmJJ5SzFU93vhOMsMxEuBX+cux8k/CMgwnjKw9Cfp/F4ztwqP4Y8emDCJ9BTXh/8ixMvz275QBTC5/mXyDWWUJ0WENpHhOW2r0jm5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0spzsIQ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2350117a12.3;
        Mon, 22 Jan 2024 06:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705932335; x=1706537135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6LiWlQV6quOOKCE6KvxcGJUO8hIT2RKaEXrOFhVC9AA=;
        b=b0spzsIQgnxDrwOIHrYM6PoQvd3IxbPzlqAIcYP2G0d3Av+4TXWjMtLg1Xvag8BrL+
         5QJ5W5+IAWR/ccopriKOYfYg5/HFY31crxnS8IMroqzXj3a0NOrXkryP+ZKc1S4kt23d
         G5EyUU0i9DfUX0QHElfPgTAi+7b0rF+ugV7Z5aTS9E6Jl2m7Qi2rWoew8EhcYpBc7MLn
         71ijd68eWqQaEgAF+kgrHj3G+EfJJFdwj7yDX6/QA6eC0uPPJ9aLpFjST8dNNnfN7XWr
         a5rzY5unER9HRmriuTbxSstvh+CiELgKHI9T27C3kUMHz05mjWqpxkvTn99Qw4Jo6Z4J
         LKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705932335; x=1706537135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LiWlQV6quOOKCE6KvxcGJUO8hIT2RKaEXrOFhVC9AA=;
        b=WONvo1niVqN7YHxWCr3Na/fJxRPrlCfV4ulFoB1fRY3H8l0/YJzfkzArrzaZxNSILK
         GOcCQlLd/kxChyxLZZ/RD08wrAymk3T0LCJBSfD/3jcBcizBzRFsF2Obzp5OE1fnAcXR
         nlTXtt8g/Rr1VhUp8K5xrpiCovJ7MLGVsPieTyS3PdzR77OeibGjJq/LdRAIJsN9CScp
         j4WbHWtRH63ESmo+euVwJJqvr0UzNn1gizP9JylVfUl7bfMVlvgTEVwFSNu4I641J1kH
         uBy1U641xbtj1TIfCfexVpz0IMOBW3JcGEwlNTFsR5tZPN1XAI4ojk3MFhMhK6x+pnOU
         0mgg==
X-Gm-Message-State: AOJu0YxOMqYjCc9cgtS1w6ilcHb7tB+bx4BwIm+RhV6sZqgMT9WpKGGz
	XunLjx8HwOXXxePXXnSugPfXf985O0Q8BccJkTZwODdX+wwj5t8F
X-Google-Smtp-Source: AGHT+IH5aY9gOQaOMrxvOMP1oEb6UMQOZZRwCy9gaTTXYpW9sj1XBiB/7Av2hbQGV1HMkBs304RUeA==
X-Received: by 2002:a05:6a20:daa1:b0:19c:4bd4:520b with SMTP id iy33-20020a056a20daa100b0019c4bd4520bmr1228299pzb.44.1705932335510;
        Mon, 22 Jan 2024 06:05:35 -0800 (PST)
Received: from mail.google.com ([38.181.79.249])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b006dae568baedsm9591196pfn.24.2024.01.22.06.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 06:05:34 -0800 (PST)
Date: Mon, 22 Jan 2024 22:05:27 +0800
From: Changbin Du <changbin.du@gmail.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: Changbin Du <changbin.du@huawei.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Thomas Richter <tmricht@linux.ibm.com>, changbin.du@gmail.com,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v4 3/5] perf: script: add field 'disasm' to display
 mnemonic instructions
Message-ID: <20240122140527.36j2jcd6abdbtlgm@mail.google.com>
References: <20240119104856.3617986-1-changbin.du@huawei.com>
 <20240119104856.3617986-4-changbin.du@huawei.com>
 <e840bd05-a9e0-4463-8597-b67c7627809b@intel.com>
 <20240120074009.zmywqj6irtedivqk@M910t>
 <e8e5ea25-326b-4565-b0e8-1583b09dba65@intel.com>
 <20240122104646.oqa7jnmd6ed2dzdw@M910t>
 <Za5wluB2NckwNF0S@tassilo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za5wluB2NckwNF0S@tassilo>

On Mon, Jan 22, 2024 at 05:41:42AM -0800, Andi Kleen wrote:
> > > >>
> > > > Updated as:
> > > > 
> > > > 	When doing instruction trace decoding, insn, disasm and insnlen give the
> > > > 	instruction bytes, disassembled instructions and the instruction length
> > > > 	of the current instruction respectively.
> > > 
> > > I wondered about mentioning that disasm needs perf to be compiled with
> > > disassembler support, but with a permissive license it seems likely
> > > that libcapstone support would generally be built into perf, so that
> > > should be fine.
> > > 
> > Yes, libcapstone has a permissive license. It's available on most Linux distros.
> 
> What I've seen in the past is that people who build perf from source
> often miss installing all the build the dependencies because perf continues
> without an error. Make sure that if that happens and someone uses the option
> there is a clear message that points to the build process.
>

Currently, perf build will show libcapstone available status at the beginning
of build and prompt user how to install it, as other dependencies do.

> -Andi

-- 
Cheers,
Changbin Du

