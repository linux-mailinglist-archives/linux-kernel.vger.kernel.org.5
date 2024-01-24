Return-Path: <linux-kernel+bounces-37665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 937B583B353
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED27428846C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492721353EC;
	Wed, 24 Jan 2024 20:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEo9qjfc"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E0E1350C2;
	Wed, 24 Jan 2024 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129515; cv=none; b=s1XXSwrowTDuEQPI4puM7iWhSvkFBAQPOam2bAlNBSb9zmJaPGACGBW1BehPlEtYmoneW+Fjm/iBYqbTx6MVTXgl+gVNeO0z9FGQOsZ0m/Tiy3KWN7nnVnhnyFfhtJVFVflM9exQc/gpfjiyk9iZ2Xg2Wz8lA9vWLpgOFAQjJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129515; c=relaxed/simple;
	bh=YzLAmy8T5+KzhcRUKVCXnk+hL/8R2osLEOkylGRvDO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOzUxAgCRMw+/71UeSBHNHvsIb6POioaoUgQ2wZi2Goanui/yhV68fQf6fNujMxuId3Zf+Y+DaM4+edj1pp8I3po1wTszAriGQ6LgA58PKTwdCnWQ87AnvjP4CxfyU52r18DXKSghvkGkaefNb6dOVnF9zltqlU67d2IZhWdemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEo9qjfc; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7beddc139c4so258568239f.0;
        Wed, 24 Jan 2024 12:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706129513; x=1706734313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQVPErXU290D1mpBNScwazLtfS5510hpywHlBQuGA3w=;
        b=OEo9qjfc+MJ6wAbVT5YswlEPYR8uskf9XSeZSjKevfL9dNNhcDIiDQNLkHEJEk/cfL
         NXKiR+ScxiJRiYie6Fn0iGRt1gdond/BcnJoycYS1nlN7gRAHI8B2LohsSe1LxdTRZ4p
         OKp08LPAIHxNARtKQ2qGmzb45gtj0fosHILfELE95lHAZUEY6ma0WUKsjKYi701DayQT
         HC5TKJ8BY0F5BjMWECHhyNVOzSFIXxeIxDFXgyCXbmJQJXq8D3YdJIrpT0fuQp4qq7jq
         LQG+lzxKzRwQUwEysFEK/vdzcapJuB965OeDD/cWay7YmXk000i8KabD1MKNLfyniq0X
         FGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706129513; x=1706734313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQVPErXU290D1mpBNScwazLtfS5510hpywHlBQuGA3w=;
        b=j4rpU7jaxtNUZB73S7Y8hixuR9kmguVwruokekMxJLQULFMeBCGiH0zLln0A6Uef0a
         VjNhjRyg3vtG3i2wz2n4OHdgg5MvqfAS30CJUjgkih7m0HMNSLW4phieuneTibZEuv5/
         xXoxp+y4pbfPZTe+Tm7CUno/QpB5iPwksVcE+DONKRWVz8fMn4MK0TXyqW6kvQ2lE0Ii
         r5RGxXIexse5Kc0gE7hf0ObsCghSrRofsfQUk8ttnYLnqjGzBg+BF672fGHpyL85BLDh
         k3ellODGd2nUNQH39e9NFFZKINH4kvP4mHz4kikp/Nt0PWGw7wT4jfvr5mNSCjqjnE7d
         3rtQ==
X-Gm-Message-State: AOJu0YzlHATLVNC1aoncp5ltHII3m8fh5H6y7s2/jr56dqb2Y8+CkCVF
	tpeccFmNVByY23aY9OHzpsh0dPJqdivuXxYFSHX2yAxagi/B8jYo
X-Google-Smtp-Source: AGHT+IHjNeWesur/WB2rRojObeX1a+LSe04ratH+e1bBz40qjvSKeqNxLteQ5vzjt/5l3tCMVI0Yfw==
X-Received: by 2002:a5e:a50e:0:b0:7bf:59d5:3b43 with SMTP id 14-20020a5ea50e000000b007bf59d53b43mr27797iog.3.1706129513250;
        Wed, 24 Jan 2024 12:51:53 -0800 (PST)
Received: from fedora-laptop (c-73-127-246-43.hsd1.nm.comcast.net. [73.127.246.43])
        by smtp.gmail.com with ESMTPSA id gs1-20020a0566382d8100b0046e9ad3dbe3sm4136813jab.128.2024.01.24.12.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 12:51:52 -0800 (PST)
Date: Wed, 24 Jan 2024 13:51:49 -0700
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: bcachefs fails to mount loop device on kernel
Message-ID: <20240124205149.GA268968@fedora-laptop>
References: <20240124200032.GA343522@pevik>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124200032.GA343522@pevik>

On Wed, Jan 24, 2024 at 09:00:32PM +0100, Petr Vorel wrote:
> Hi all,
> 
> bcachefs fails to mount loop device on kernel on both 6.7 and 6.8.0-rc1.
> Is mounting loop even supported?
> 
> [...]
>
> bcachefs mount /dev/loop0 /mnt
> => Unknown command mount

What version of the bcachefs CLI tool are you using? Is it distribution
provided or did you build it yourself?

The mount command has been implemented in Rust for a while (since
28f703cc256f "Rust now integrated into bcachefs binary") and if building
without Rust support (BCACHEFS_NO_RUST defined), that command won't be
included in the binary.

In more recent versions of bcachefs-tools, building without Rust is not
supported at all.

I don't think this has anything to do with loop devices specifically.

- Thomas Bertschinger

