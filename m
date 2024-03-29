Return-Path: <linux-kernel+bounces-124222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B52589140B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB90B23051
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292E93FE27;
	Fri, 29 Mar 2024 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5cLUHyK"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D261B33CCC;
	Fri, 29 Mar 2024 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711696524; cv=none; b=CQPWGj4gTJY1j6zsURVgSV9q8UOy6vCOe7nwgOPWaZ+knZetcf7umNejlVHJWF42RLOHSz5t8ykhzqM9Z6L+QwZ/GaLETH+22DpLHcGlc6wD3r0TjjUak8/+oFEooUSxoWJIqPEY+G1Mfpnm86i3s/byxA9uSdZo+u8ES4TmeQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711696524; c=relaxed/simple;
	bh=vcBZF75PvdSN87wejsi7pX6QTEy6uXjLbXwwfZFg3Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3Hjt6z+YPScPnfhV9akejUaJq1WnXQX1xLSINAn+e4DDyyX4hec32nIjZjhUytJnpJjOCz3Cr80JTT1maILdWY7CuO0fyiICpOYIbXeMGTkK1rO5as034ZzYHPx9QmAOiTybg+m2MzjSbvNZhCyQwxN8b/mBCJ8h/uX7I3nuAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5cLUHyK; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so4648950a12.1;
        Fri, 29 Mar 2024 00:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711696521; x=1712301321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mozfWZbRnnqWKHe9tnc7q0wOVsOmikcudgvgpeew1+E=;
        b=L5cLUHyKmOCGoBuiVuBONQS6/s6X03KM5eyFMbkZio5EjTMD/irf9oO2tThDtxSjTV
         +b6+IeCR63Fi3PcQVjVbmL8JxXdUpprIbpriIZnFql/KnzWQF7oQD9mE8dUbY1Tvsgzb
         CMV/7drs6iQjxFLjWBI9BHe+/fTohY3CfyCvWloFsBGMLAr+Y/NDE00sitj5fPEm4thi
         5inKjvkgkMPOJVTpeMDN8s+WaLSF4ylsdfzr+sC7jTfWMgCX+xw0XFhbDyu4bR1PFDZu
         X+6bYak1MkhocVnAbrmara4k96F7iov4C35MfihsEDvxWH/gDuLHcfk4i4KEkdqsGfjM
         nsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711696521; x=1712301321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mozfWZbRnnqWKHe9tnc7q0wOVsOmikcudgvgpeew1+E=;
        b=eeMRNxO8wfchjfAxFtFpxDrji1/mlNIrN7xhqpuKaZ+i/ZvLZpZ+K2NT+N3EGevDWY
         kdN5T5GovpQ4izVMWbd4Tx/ZPGf0dTSx5H2eFChAKoz/VNJ36vpFTDpHdkb4qEpN3791
         SuKvPp/drdCX17BoYRHuGnJf0z0PxM5oYXex/zQ/5IxLnGYonfgOOQ46DgruTsHhGP7f
         d0ykxCXf3A8ZqlEYWivMUGiGl4Mh48MUsPD+T8+VPHXoGewsc9Tn0vE9Vsf6MgfMjpTG
         xLvKmJwFIW8dwhydCIDtzMp+zB1i8fPeWJH8CHx+8YpSqv+HX6v2HPRSxraGICrId1j2
         xaBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+d/p0NmumbJumfbUxE4Ub8pmF2Yr6nhw7sYw95hPjPKywdOVBkWNzkRnRKL7vKyBtdglBlwAqmgff+oo0LtvPRiPtjhOGTfSG0qxa4G2XJ58vluOaDRR5GGqB7zDknN0sLb5n
X-Gm-Message-State: AOJu0Yxav7rxMbpR3eVb1IN+0by8QyswwkQD5c924v7OusyJ9RJJED1d
	eHxTDvjLTvR8h1MCtsfZqBPm18hwpNOrBDWnS4jJCP9X3aGea7FmZawTU4RM1bQ=
X-Google-Smtp-Source: AGHT+IFhRkjxogRTyF/K3aWBTa/zm6XcSZhhLZnndCssQDKYDtq+qxbh6p75jpjUxX89xLoNA/e6vw==
X-Received: by 2002:a50:8e1b:0:b0:568:b0f4:fe69 with SMTP id 27-20020a508e1b000000b00568b0f4fe69mr4049605edw.12.1711696520810;
        Fri, 29 Mar 2024 00:15:20 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id ew12-20020a056402538c00b0056a033fa007sm1675741edb.64.2024.03.29.00.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:15:20 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 29 Mar 2024 08:15:17 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Pavin Joseph <me@pavinjoseph.com>, stable@vger.kernel.org,
	Eric Hagberg <ehagberg@gmail.com>,
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
Message-ID: <ZgZqhWoRZoq5tJoU@gmail.com>
References: <20240328160614.1838496-1-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328160614.1838496-1-steve.wahl@hpe.com>


* Steve Wahl <steve.wahl@hpe.com> wrote:

> When ident_pud_init() uses only gbpages to create identity maps, large
> ranges of addresses not actually requested can be included in the
> resulting table; a 4K request will map a full GB.  On UV systems, this
> ends up including regions that will cause hardware to halt the system
> if accessed (these are marked "reserved" by BIOS).  Even processor
> speculation into these regions is enough to trigger the system halt.
> And MTRRs cannot be used to restrict this speculation, there are not
> enough MTRRs to cover all the reserved regions.

Nor should MTRRs be (ab-)used for this really.

> The fix for that would be to only use gbpages when map creation 
> requests include the full GB page of space, and falling back to using 
> smaller 2M pages when only portions of a GB page are included in the 
> request.
> 
> But on some other systems, possibly due to buggy bios, that solution 
> leaves some areas out of the identity map that are needed for kexec 
> to succeed.  It is believed that these areas are not marked properly 
> for map_acpi_tables() in arch/x86/kernel/machine_kexec_64.c to catch 
> and map them.  The nogbpages kernel command line option also causes 
> these systems to fail even without these changes.

Does the 'nogbpages' kernel command line option fail on these systems 
even outside of kexec (ie. regular boot), or only in combination with 
kexec?

Thanks,

	Ingo

