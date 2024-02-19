Return-Path: <linux-kernel+bounces-71921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD6F85AC87
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A11C1B25D64
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E203851026;
	Mon, 19 Feb 2024 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irBcg8XW"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572E047F7D;
	Mon, 19 Feb 2024 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372469; cv=none; b=T8T2FIY6LZWGfvPMMjAA5S5cWZqRYwr5PxGYidGD4XUDv9Q7eSehID/wj7JD3hs+tGtu23//gIq8jKZCrWv2/oXU+cKqSc0mjNbxdnrLhxSg3IYRzEPGqDtpE3rHgbJHUJizZUQ79UYlyPMdSV9l/Ma4ZK/IwUqFtK/hYpn7ZU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372469; c=relaxed/simple;
	bh=ahdS3Zn+QIu0uhv09EiJ8/j1ihnNP5swBR9x0i0/BHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fa+mExaJt3VEbBwxO9VGDRr4AyLPHaWr8exYEAkHLBXZyZaQVuEDlG0i9EBb0/QTYE0yw76jtKLKV512Vu3HQIHIlFF/Ex9vxi9oltp2O2jZLNavkPpe3utmgO+8Bw8HERf3K4aNyE0AdI8YIBBnLRHT95KRaMraxkw503VoYCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irBcg8XW; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-561587ce966so9570508a12.1;
        Mon, 19 Feb 2024 11:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708372466; x=1708977266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPYlqKudaClcKbNFamdeE7+QrC6+8XojTMUekGJ9pw4=;
        b=irBcg8XW029KjWz2g+AR3OYWDTZzbxfWmVqydfZt5f7oMVLjHwsQFF0Piz1PpLps92
         eGMXUq2wEy3gDkDoaVtp18EvlvfHPydaWTKTYg4Q8VvdxhjAdtw02GVoiFTdbTLECak1
         U8fQb21g2Oqug5CkaczFR4PhsZM7YKldEZjyxFiUrIkFQNNGVglzPVe6Cw8hyuIvCecK
         iHnxBSM5W8oHssG+1EtcbUlHgjyW6hSWifN5H93YD6UZOw3PcfCN8ltrPDHk9zibOyev
         HWu3OEE/RZyUJqlm4LgWxQpTV1gcKNWDv9zfTs96+IQ3NC7C0ob0b8t0bCuPB3Jggeu3
         oTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708372466; x=1708977266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPYlqKudaClcKbNFamdeE7+QrC6+8XojTMUekGJ9pw4=;
        b=qbAPXJ0mgAwzV4XJED1g8WDqf5BXH7pnqarIFR5u40QkkC1Oc6kD0Y6HEynGaVI+qD
         n+fUw1VUfJ2UyS87m+eh0SmF78p8VB0XcJ94cV8TLUHZPO6oCm9rGE3zqBbHb/sLeTBB
         hxBZTe3gIhZ6ZKlxr261blihqlh4jlLtrnsE3zix3GATD8kfBDPNuNQgXVSQLbqHb24b
         i2kyamD+L1Ink09I9rBu+pIJ8rM4BkZIGro9HhoAaQO5kV3e6WNOKUrZrBuLKrATl7IL
         ff5RgDMzjA+JMeOt19jNHfW1GkGvpxrJdaOk3sKu4rArKLZDTjCXKFfAzqp7DRFM71vN
         FUFA==
X-Forwarded-Encrypted: i=1; AJvYcCU/ANNcwSWC4eQv13V7rajucpjh79t22YpDbfjVf0FI9KqoiDV6T/LxzDLdyf7CgZW3ERMLMPH2KNYwvqApLfsq1xgM43KeKAlZH6JmYYmqFuuEJUxNwBfaOruaw4/V4ft8EMCU
X-Gm-Message-State: AOJu0YwHZyAjyrfZywAJgnZCtqeHENAS7X4M4L+ILWPazSb7AbTjlE95
	Wx8T9a6Fa4kdzC5ecfhyOf6UBpUPN0W4NwdAtUAkYmaQEb595BsUNCR3zTZjCvY=
X-Google-Smtp-Source: AGHT+IGy17EHv3w5kRGCvBk4IxezGA5nNXlG3sjHaPpclSP5gUQDDuET4mul61ghYdEBQQf2Q15JQQ==
X-Received: by 2002:a05:6402:5207:b0:564:4211:faa3 with SMTP id s7-20020a056402520700b005644211faa3mr5547391edd.1.1708372465382;
        Mon, 19 Feb 2024 11:54:25 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id fi17-20020a056402551100b005612025465asm2964948edb.74.2024.02.19.11.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 11:54:24 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id EF00EBE2EE8; Mon, 19 Feb 2024 20:54:23 +0100 (CET)
Date: Mon, 19 Feb 2024 20:54:23 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Chao Yu <chao@kernel.org>
Cc: Dhya <dhya@picorealm.net>, 1063422@bugs.debian.org,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [regression 6.1.y] f2fs: invalid zstd compress level: 6
Message-ID: <ZdOx73kckFXADcol@eldamar.lan>
References: <170736382774.1975.1861975122613668970.reportbug@tsuga.picorealm.net>
 <ZcU3VCrt9VOpuFUq@eldamar.lan>
 <6d14ea70-ac1c-46f2-af1d-ba34ea0165aa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d14ea70-ac1c-46f2-af1d-ba34ea0165aa@kernel.org>

Hi,

On Mon, Feb 19, 2024 at 10:35:13AM +0800, Chao Yu wrote:
> On 2024/2/9 4:19, Salvatore Bonaccorso wrote:
> > Hi Jaegeuk Kim, Chao Yu,
> > 
> > In Debian the following regression was reported after a Dhya updated
> > to 6.1.76:
> > 
> > On Wed, Feb 07, 2024 at 10:43:47PM -0500, Dhya wrote:
> > > Package: src:linux
> > > Version: 6.1.76-1
> > > Severity: critical
> > > Justification: breaks the whole system
> > > 
> > > Dear Maintainer,
> > > 
> > > After upgrade to linux-image-6.1.0-18-amd64 6.1.76-1 F2FS filesystem
> > > fails to mount rw.  Message in the boot journal:
> > > 
> > >    kernel: F2FS-fs (nvme0n1p6): invalid zstd compress level: 6
> > > 
> > > There was recently an f2fs patch to the 6.1 kernel tree which might be
> > > related: https://www.spinics.net/lists/stable-commits/msg329957.html
> > > 
> > > Was able to recover the system by doing:
> > > 
> > > sudo mount -o remount,rw,relatime,lazytime,background_gc=on,discard,no_heap,user_xattr,inline_xattr,acl,inline_data,inline_dentry,extent_cache,mode=adaptive,active_logs=6,alloc_mode=default,checkpoint_merge,fsync_mode=posix,compress_algorithm=lz4,compress_log_size=2,compress_mode=fs,atgc,discard_unit=block,memory=normal /dev/nvme0n1p6 /
> > > 
> > > under the running bad 6.1.0-18-amd64 kernel, then editing
> > > /etc/default/grub:
> > > 
> > >    GRUB_DEFAULT="Advanced options for Debian GNU/Linux>Debian GNU/Linux, with Linux 6.1.0-17-amd64"
> > > 
> > > and running 'update-grub' and rebooting to boot the 6.1.0-17-amd64
> > > kernel.
> > 
> > The issue is easily reproducible by:
> > 
> > # dd if=/dev/zero of=test.img count=100 bs=1M
> > # mkfs.f2fs -f -O compression,extra_attr ./test.img
> > # mount -t f2fs -o compress_algorithm=zstd:6,compress_chksum,atgc,gc_merge,lazytime ./test.img /mnt
> > 
> > resulting in
> > 
> > [   60.789982] F2FS-fs (loop0): invalid zstd compress level: 6
> 
> Hi Salvatore,
> 
> Can you please try below fixes:
> 
> [PATCH 6.1] f2fs: add helper to check compression level
> https://lore.kernel.org/linux-f2fs-devel/20240212160530.1017205-1-chao@kernel.org

Confirmed that this fixes the reported issue as it was reported to us
in Debian in https://bugs.debian.org/1063422 . Thanks a lot!
(note just tested with the first commit as it landed in 6.1.78 to
confirm the immediate regression).

#regzbot fixed-by: cf3d57ad6ff8b566deba3544b9ad3384781fb604

Regards,
Salvatore

