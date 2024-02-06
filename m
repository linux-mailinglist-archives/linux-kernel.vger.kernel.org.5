Return-Path: <linux-kernel+bounces-55340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3239A84BB6D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E681F23EE3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4071A79C4;
	Tue,  6 Feb 2024 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwKAhd4b"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3177D6FA9
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238365; cv=none; b=fXZzQ+kUTae1CbSzlMaHqwdIZpGKQftKeMYlxD/QpoCPLbWzL8zHKAfXk9sq/ud0sTZXZ+QXt3aLEawS+pDMXBS0Wg6GqWaXyhQdpEWtoeQ+QFBATGFUlAbJWxXDDZVLQWLqOQOOyPdLNALcNZfzkRt75bXzM5B9YnsHAjDduYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238365; c=relaxed/simple;
	bh=M17DyXxA9h+gAdMOT2GQn/4tz+2TTN03DWXf+rY+jl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlXyYA763uILCfymRnjcf2JghQa8/877URq9oY1H977l6XdxYD5QblyhdQKOLRpoVX1zAAml4FchMBFW481coGxWiK2a/EpB81V+U6tcPJR/lD0YAorb9ZKAhC1tMZLIMeyEf7ynKt43PA2UMpeje0AofCJ6z/d9q6F9pxz6IUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwKAhd4b; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-295cfe8f199so3454410a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 08:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707238363; x=1707843163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jeWa0KI2MTr9acDXrh7GXSP9/6rmXWXStrnTLhLDMyM=;
        b=ZwKAhd4bRGiDH1FujdarNCzHaav2VYVG2WE4tzbHZB9gnJTHeF1TUVqS4yLzjRswTI
         q58804L60lay+FqDA45KK30NW+bcdjmH9RkTFdvDwoqI8G8e4wEaPCEOsD5jxr1MahM1
         ODRxSIeaFDyBRP+4iNzP+JvXTzI9DhkF0PsfNWpouF1/+zBklllryGeF3agpaTk5kXPk
         t0ewWneg/cpoOjP5fs+DlLFdTuPGN5dLMZwRC4aUQ4hj3rdZTYV9bRMGCJcyRoNhxh63
         fClnbOUt2XZfr/YLdl8SxpqeBR+v+JZloTeAxGZ6CFJE9GXK8hBk/6x1C19gN6Ojobg8
         vLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707238363; x=1707843163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeWa0KI2MTr9acDXrh7GXSP9/6rmXWXStrnTLhLDMyM=;
        b=WhSC4E8GCI8fdBLV6jZcnieReNijQZ6HyowF77S9SbMHcWzRH7KHFvMRq6d4+/YIRw
         AbBns/Jua2W2Z1j04U7bBWVXVYlzzV4tfi/qTUItfErCXe+V18vGH4fYZ+Xuj4SIWD1+
         tUmHlBZiJ02430PuZHsqzYjXVyf8TzPJmVXbx7wSR0UtPSewj19KiXj3oCIdsJapDGUp
         Ni1MKqjJDM8md0KlZlTe919XDmRn2BPF1EiwTR0X+sS/3eCnG0NEps9znKev8WuLiZ6y
         E2c0f6SzxJSj67clORk6snk9y0RtI6jrdqbfcFNtN4jCim5xSH7LUPaAvBw2Z7HuuUOI
         KrtQ==
X-Gm-Message-State: AOJu0YzhftYNICrYSs5lex/udxTbOeORHhB3m9EZ4agPvhnL18vyxggM
	Q6PjjGya5nDl+Oo1i8eP4eY3ji4k2rAbK8lVKB9f/LDo6KkdFugD
X-Google-Smtp-Source: AGHT+IHcoprxRWZ2BYYcHjn1WYayU28m8joibShfvLAXTNj6ixXOfxSIpI3nTfurU6Qt3vK3eqEINQ==
X-Received: by 2002:a17:90a:ea8a:b0:296:40c1:d7dc with SMTP id h10-20020a17090aea8a00b0029640c1d7dcmr95218pjz.19.1707238363272;
        Tue, 06 Feb 2024 08:52:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDUCJGJev2Mx4X2hjR8/naSYqi3j02WNs/3NZwtoAvqP3mzHOJv3OgcsLxWxBKie8fn9L31N0vLRUR+dRrdoaqeB1q8K4bfyiiFzoynclXNtzp1BWhStCzQ+7xXlWFfUt9EUUdReF1dW/jatrOjMzSILgXs1q++Jsp7IAaJK3DqCADAEj9lYnNicudBpN1ZnECBFPvwBah38d8O6l9F+gje/9w+iWI+CMTwv2wmzpqldZsPqPP4WHZERVxcR1/97Q=
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id hg21-20020a17090b301500b002965eb051e7sm1882781pjb.53.2024.02.06.08.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:52:42 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 6 Feb 2024 06:52:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Yunlong Xing <yunlong.xing@unisoc.com>
Cc: jiangshanlai@gmail.com, yunlong.xing23@gmail.com,
	linux-kernel@vger.kernel.org, hongyu.jin@unisoc.com,
	zhiguo.niu@unisoc.com, zhengxu.zhang@unisoc.com
Subject: Re: [PATCH] workqueue: Fix pool->nr_running type back to atomic
Message-ID: <ZcJj2dUUyAY_7XFS@slm.duckdns.org>
References: <20240206080024.2373490-1-yunlong.xing@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206080024.2373490-1-yunlong.xing@unisoc.com>

Hello,

On Tue, Feb 06, 2024 at 04:00:24PM +0800, Yunlong Xing wrote:
> In CPU-hotplug test, when plug the core, set_cpus_allowed_ptr() restoring
> the cpus_mask of the per-cpu worker may fail, the cpus_mask of the worker
> remain wq_unbound_cpumask until the core hotpluged next time. so, workers
> in the same per-cpu pool can run concurrently and change nr_running at the
>  same time, atomic problem occur.

How would set_cpus_allowed_ptr() fail? That should trigger WARN_ON, right?
If set_cpus_allowed_ptr() fails, nr_running getting desynchronized is only a
part of the problem. We will end up running per-cpu work items which must
execute on the same CPU on foreign CPUs.

Thanks.

-- 
tejun

