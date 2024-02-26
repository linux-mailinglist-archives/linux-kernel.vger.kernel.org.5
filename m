Return-Path: <linux-kernel+bounces-82330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812D58682D7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166F928E7F3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EE5131756;
	Mon, 26 Feb 2024 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="a/5yuU3X"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9214712C7F6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 21:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982304; cv=none; b=O4Vwh+/iFbCqEhP9WRtBkDMJpCIO1UiseGfPUhqRFxgPDSJVSjVKeTSKd1IsBDwiD8+my2B49U7ZS65MMTlbSSODzmK8LDNnkGnltfUjpmJTd0CKtuyFE9OdEK32C6Q/JouZtNi8JbcJDrHXg0p2+IXYi3HY5HFEBUuvM36yxIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982304; c=relaxed/simple;
	bh=eaIp+fx10BWGs+4xS6PS0LUQ/7o+RRQRSzDpSW83ah4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcMsJHV6FBfIaKElS7oEMmqVex+Z/kd4ovL0UHPczNlx8ZXKx7dvBhrBW0VzOj/wYe9XxQkAeJfSG07hOrfR8MkPc4Ik+cvaJdxCwDxY+G57gTpGQ2gnSJfSTyt/GQEkpQvYrJuIa/m8diaHP+XzHp6r9ew6A8+9H80OuvPBmCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=a/5yuU3X; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dca3951ad9so12933585ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1708982302; x=1709587102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I9bpXPsVA2dblkxjM286LakoqzaJhRDzLGBOQQdyQhQ=;
        b=a/5yuU3XTKNhRHnA1h5/96avhI9D7bcCM+PMtBGSEoo6fkYz9n7pN+iVQtN9yqMRWB
         t2gJc2NlJ0Tcnsjjupc6g7qIatR52QxiPDLqk+zyslJKPV+N/eKS1OLhUrOawQcuZHFv
         eWxm08Sk2F9ulhVVMpbVXhS4ge6O+PEvREgr7Qmof302Jh0ocq/ye9I74yL7cagphs9p
         44IhjO/udqgVt1vygaciNe7QMSJjAcjkLX1znxvt2AA8tB7JT9fLTekq1dHES70Cbh4J
         4RX1V3T22NcbUJmZqqDW/on3MmpF9tjtgzi66jfLk+u/5mUQZpd4838i1D5TOtOR3rrl
         3WZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708982302; x=1709587102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9bpXPsVA2dblkxjM286LakoqzaJhRDzLGBOQQdyQhQ=;
        b=kj/hyIV/1QUmaZ11DwZH5jSkN8HJzo1kip8cwPEKPXuC5jBa6HI9TqFg+tWaCEnfAt
         R9h1D8SoBWObu8AS1TmspI1og9/XFs7UXqHsUfcYTk+HRbgNv2G3C0N21VBFDwBI4zld
         Bx+WErSXmaD1i/6pzNUqdlZ51yZpl0bMvrC5S3JVcjIuVtLW4HP1tWk0YGunaxGhDKHZ
         1Q3g5I+MFE8UN5RTX5z1aVNRAu17/uxIB51zmNUbTrX6fv3c1pLZ2P97t3J/HQEgiv30
         ynTOg5Gymaj2+swUD1uuxuqTBzKqLqIWh0E1wVukvNzBGz+tjSoGE6Hs5/sy67gGgzl0
         7pzg==
X-Forwarded-Encrypted: i=1; AJvYcCU7eRE7xnAy3+LFMYPw8E7UUfVStPdBy51Hf/tziAvpHi2+IYls/b6YF3ofqbZqPPAusJhTtQIQ7cPFycHv+7HWS/t6wuuzVj/QLlJT
X-Gm-Message-State: AOJu0YwXAtLbgCBAWrq2pBTCzfBKRzOwx7VWzASXmma3FSRIDxpGwYVg
	quJ7YlR9sqj7r89bo4x1TxNz0HX7JmZkExAp5ldsSYPKCTzcF2V+b31GudSK4KE=
X-Google-Smtp-Source: AGHT+IEaS3503yij5SnTzXRX9ma5fz0nrIGs9M8iQXzfkpIF9Fk1rga0qUb/2ASG3WoYZeBci0kbFg==
X-Received: by 2002:a17:903:32c6:b0:1dc:b3bb:480a with SMTP id i6-20020a17090332c600b001dcb3bb480amr1448955plr.49.1708982301931;
        Mon, 26 Feb 2024 13:18:21 -0800 (PST)
Received: from dread.disaster.area (pa49-181-247-196.pa.nsw.optusnet.com.au. [49.181.247.196])
        by smtp.gmail.com with ESMTPSA id y11-20020a170902d64b00b001db94bead0asm127599plh.193.2024.02.26.13.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 13:18:21 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1reiMc-00Bv0s-2p;
	Tue, 27 Feb 2024 08:18:18 +1100
Date: Tue, 27 Feb 2024 08:18:18 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, chandan.babu@oracle.com,
	akpm@linux-foundation.org, mcgrof@kernel.org, ziy@nvidia.com,
	hare@suse.de, djwong@kernel.org, gost.dev@samsung.com,
	linux-mm@kvack.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 13/13] xfs: enable block size larger than page size
 support
Message-ID: <Zd0AGgE6nP9BUS5O@dread.disaster.area>
References: <20240226094936.2677493-1-kernel@pankajraghav.com>
 <20240226094936.2677493-14-kernel@pankajraghav.com>
 <ZdyRhpViddO9TKDs@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdyRhpViddO9TKDs@casper.infradead.org>

On Mon, Feb 26, 2024 at 01:26:30PM +0000, Matthew Wilcox wrote:
> On Mon, Feb 26, 2024 at 10:49:36AM +0100, Pankaj Raghav (Samsung) wrote:
> > @@ -1625,16 +1625,10 @@ xfs_fs_fill_super(
> >  		goto out_free_sb;
> >  	}
> >  
> > -	/*
> > -	 * Until this is fixed only page-sized or smaller data blocks work.
> > -	 */
> >  	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
> >  		xfs_warn(mp,
> > -		"File system with blocksize %d bytes. "
> > -		"Only pagesize (%ld) or less will currently work.",
> > -				mp->m_sb.sb_blocksize, PAGE_SIZE);
> > -		error = -ENOSYS;
> > -		goto out_free_sb;
> > +"EXPERIMENTAL: Filesystem with Large Block Size (%d bytes) enabled.",
> > +			mp->m_sb.sb_blocksize);
> 
> WARN seems a little high for this.  xfs_notice() or xfs_info() would
> seem more appropriate:

Nope, warning level is correct and consistent with what we've used
for these experimental warnings.

	xfs_warn(mp, "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");

i.e. A message that says "Expect things not to work correctly in
your filesystem" is definitely worth warning level meddaging.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

