Return-Path: <linux-kernel+bounces-13020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C3581FE83
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F2F1F2116E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 09:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C32810A1B;
	Fri, 29 Dec 2023 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuN15BmV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F35B10A00
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28c467446f0so2570361a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 01:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703841267; x=1704446067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tt8D9UgoK3KzeqONo14OqSpjYQOH1MQ3gtZAY7SE4tg=;
        b=JuN15BmVmJGNGTnF6KfEzNiwXTG/v7MkshieT+9nmpVZlLyRy/Agg0zEeLzPhDW04m
         hD0JNmRKjFri7StU4Sxwe8PLXibl2snRudFmYVg6fho0yD5hv8eP415M2m2oiqusnTt9
         VScKgf/rNu3hwIld/7kK1jf0dUuFVvcXfOP+iQDvlLup1HS872JmZWJOuEnm3GwoDc1M
         J+h+HBW1IP7cFQkX7M9HazvDU4RK7w1WK7v52nNOVu/OT11TpYm19VP97JOv4NpD9x6A
         VDWvqaosolB/GN6BhFPa+4Ii64TmMUejqbYKIOceqWerI+WW7dmNzkQB3eOz+LVzsNep
         tAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703841267; x=1704446067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tt8D9UgoK3KzeqONo14OqSpjYQOH1MQ3gtZAY7SE4tg=;
        b=u7Te6CWrvrb4EjYepTLtXCzAZv+ugdPFSEXxwaSr89ea1cYbi9o51r2h4BuSHrrmzF
         xHrugTl7LmlUyp3eLl0BjOEBIawTScSVFLhgyQHhQkBxTPpfpvJo7HW4a8ucYkV4SllE
         p/VXHl+Gsh3otCVHRyakD3pExTv8bycSjmT5u/cuULyZroL/xuLFcvgHlFOTyAz9aMyu
         hDoE7HFkH2wOvJ5zd5/zn3GpOr2C+CYp5VNoZfZzsOtsx5qpFmnjkgXcyj8iIEkZ7go3
         op6glp5mILd46qmLYRilXfnGf2lurtbd8hUi/ULqdwvKjTWdybuCGk72kLdh4KLPhPc4
         xvpg==
X-Gm-Message-State: AOJu0YzQF280WzLHT4OONXMDrZfLePx8DZ7IOzAHf+JY7qinvi74aHNZ
	O3aEOsJkr2Y//Po7yEcpt0E=
X-Google-Smtp-Source: AGHT+IEZ838tozMYjlK0PCh25R/pYW3GrunI4ENZNYc3nrSEh8TJxknHGGUxuzKftAzeT8heJGFFNQ==
X-Received: by 2002:a17:90b:3781:b0:28b:d31d:bca5 with SMTP id mz1-20020a17090b378100b0028bd31dbca5mr14941702pjb.32.1703841266690;
        Fri, 29 Dec 2023 01:14:26 -0800 (PST)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090aec8400b0028bdc73edfcsm16806029pjy.12.2023.12.29.01.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 01:14:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 29 Dec 2023 18:14:22 +0900
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: convert kernfs_idr_lock to an irq safe raw
 spinlock
Message-ID: <ZY6N7pX4voA6OPbh@mtj.duckdns.org>
References: <20231229074916.53547-1-andrea.righi@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229074916.53547-1-andrea.righi@canonical.com>

On Fri, Dec 29, 2023 at 08:49:16AM +0100, Andrea Righi wrote:
> bpf_cgroup_from_id() is basically a wrapper to cgroup_get_from_id(),
> that is relying on kernfs to determine the right cgroup associated to
> the target id.
> 
> As a kfunc, it has the potential to be attached to any function through
> BPF, particularly in contexts where certain locks are held.
> 
> However, kernfs is not using an irq safe spinlock for kernfs_idr_lock,
> that means any kernfs function that is acquiring this lock can be
> interrupted and potentially hit bpf_cgroup_from_id() in the process,
> triggering a deadlock.
> 
> For example, it is really easy to trigger a lockdep splat between
> kernfs_idr_lock and rq->_lock, attaching a small BPF program to
> __set_cpus_allowed_ptr_locked() that just calls bpf_cgroup_from_id():
...
> Fixes: 332ea1f697be ("bpf: Add bpf_cgroup_from_id() kfunc")
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>

Acked-by: Tejun Heo <tj@kernel.org>

As an immediate fix, this looks great. In the longer term, it probably would
make sense to make that idr RCU protected so that lookup path doesn't have
to worry about locking order.

Thanks.

-- 
tejun

