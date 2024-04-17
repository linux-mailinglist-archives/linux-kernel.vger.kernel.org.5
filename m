Return-Path: <linux-kernel+bounces-148860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9548A8836
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3141F229BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F4F1482E3;
	Wed, 17 Apr 2024 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICIBVbOJ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB5147C73;
	Wed, 17 Apr 2024 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369289; cv=none; b=BPb5dSn3ozKlzJ07mq0rBTdpdr+PQbFSljebzlT/Sx/ifwxbwAMTggUu7OMc0HpVdeJj4xRgbTq3CdZjtzp0Xw9zpkoDX3CFmYR4kik3EGSCMwEYXXpgWRpcdAL4XzvPVfDx4i4PT64edHj38rREme0ltSjW7Q0DHOrfT8bjv8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369289; c=relaxed/simple;
	bh=/0c7qbugORSRDUT3Tao0AyZsP472TFg1XC0KOJ8XIKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cFzAM4rGDSWpLxMC79Uy/lwl+ypDZejk9Ea7w9RL9KMXQQjY5o+lV1tKJD8tTY53w6VemoNDqC7fO/PI5dCfdIAHbDmAFhptGtJnPUW2u3MHUbXZ9/wXJ2hyOyALCXUmBZVBHdUahXMT8aQ2xXB5Tl6b5iErfrgugF18FMWkffs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICIBVbOJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed054f282aso4373131b3a.0;
        Wed, 17 Apr 2024 08:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713369288; x=1713974088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPsrdMv31Rp+1MDJraOEnQqOhO3h8PTSfrt8iLohWrs=;
        b=ICIBVbOJ+S8JrbS8oBDZEJjACLdd+aLKMFJM9wt4eCxAxndxNgRi4xSjc1PseVGLNI
         3LQ5KsJ9JJ9zjznp9Pu3xknuUXD1kVVxyShd8BNNLXyymztD4lYaVqlKL2IksPcjeuk2
         fh6hXlm9Btt1O7xkuFYU6n69eg6RbmJdT5xnZ3W3KF02VPt4lLXVMWLaKvXNZHtOvGb0
         iu+WD5qryO723XcLC50bFY5mTbmsrMcFjQ9vqGiY1eG0uN+F8QLIZ5iR2YoXhN4v3r34
         Ai29stj/EBXo4owEGc0Cgd3a3XyMjg0axHSzonfj2Ofu2d9BefPjT+3immFL8gKIdJuT
         kUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713369288; x=1713974088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPsrdMv31Rp+1MDJraOEnQqOhO3h8PTSfrt8iLohWrs=;
        b=Ie7gq5fS9EriBal8UfrPn9uXjFd9VYzTab3Ow1ELkyB5vuo5QhlGlws02YNP7bOeLd
         QY0OTTk1hBEbP/h4JCZpoM6VVTiuuBMLTkIMTGRw38pdEmCSJoMJFlmM3uQV897GxF1P
         elg2uushJ7SGNAEboq7hQ/MYzebdIK4dO9iXuyhKxSSlnvDUtSp7clomBYnlWcAha4Qv
         D/3BjUR4RI3RjDbvYpoXFIa3gnvw72zj/uQTBghApw8zP+7aVg9w6Aoz18dzR11ip7wq
         8J+gtdnzNMMx+JS+vlNXz4qcikAb/HXbjcZLhnCjXbgyZLTelQWt3T+2D2UEDF0nFLTE
         o1Vw==
X-Forwarded-Encrypted: i=1; AJvYcCU0VOECl3uIL/Tf0YmKukIz6NYf1CVKnwsnia/kIt70fwzNUDF6AF/iTtResVMtT6jdorCqw00Z/N1HUoe2armjRNb1Wbv1PY38tjCJ2cGYyY5muqEiMm/r9002jp/ToqZe1ccCWVCi
X-Gm-Message-State: AOJu0YyZf+M4ln+TPXiXDK53JH3/jVqyBBOADFCh8Qd2hsmTTLop49xr
	wqPF6w/HdbXMoM0AhECAZzuQ0IuWt/8kX/6zosg0jEN1dR0TFhw4
X-Google-Smtp-Source: AGHT+IG/I5jJESiKZMbj3MkqKSp8f8GJod4j+iEFJdRMX8TKJjReIzCJfALi1V5JNp82LB9aSmhNsw==
X-Received: by 2002:a05:6a20:7483:b0:1a9:da1f:1679 with SMTP id p3-20020a056a20748300b001a9da1f1679mr33140pzd.34.1713369287698;
        Wed, 17 Apr 2024 08:54:47 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.163])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090332cf00b001e555697361sm11600037plr.220.2024.04.17.08.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 08:54:47 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: djwong@kernel.org
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	chandan.babu@oracle.com,
	david@fromorbit.com,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v3 RESEND] xfs: remove redundant batch variables for serialization
Date: Wed, 17 Apr 2024 23:54:38 +0800
Message-Id: <20240417155438.1060996-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240417152713.GX11948@frogsfrogsfrogs>
References: <20240417152713.GX11948@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Apr 2024 08:27:13 -0700, djwong@kernel.org wrote:
> On Wed, Apr 17, 2024 at 08:07:35PM +0800, alexjlzheng@gmail.com wrote:
> > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > 
> > Historically, when generic percpu counters were introduced in xfs for
> > free block counters by commit 0d485ada404b ("xfs: use generic percpu
> > counters for free block counter"), the counters used a custom batch
> > size. In xfs_mod_freecounter(), originally named xfs_mod_fdblocks(),
> > this patch attempted to serialize the program using a smaller batch size
> > as parameter to the addition function as the counter approaches 0.
> > 
> > Commit 8c1903d3081a ("xfs: inode and free block counters need to use
> > __percpu_counter_compare") pointed out the error in commit 0d485ada404b
> > ("xfs: use generic percpu counters for free block counter") mentioned
> > above and said that "Because the counters use a custom batch size, the
> > comparison functions need to be aware of that batch size otherwise the
> > comparison does not work correctly". Then percpu_counter_compare() was
> > replaced with __percpu_counter_compare() with parameter
> > XFS_FDBLOCKS_BATCH.
> > 
> > After commit 8c1903d3081a ("xfs: inode and free block counters need to
> > use __percpu_counter_compare"), the existence of the batch variable is
> > no longer necessary, so this patch is proposed to simplify the code by
> > removing it.
> > 
> > Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > ---
> > Changelog:
> > 
> > v3: Resend for the second time 
> > 
> > v2: https://lore.kernel.org/linux-xfs/20230918043344.890817-1-alexjlzheng@tencent.com/
> > 
> > v1: https://lore.kernel.org/linux-xfs/20230908235713.GP28202@frogsfrogsfrogs/T/#t
> 
> ...you still haven't answered my question from V1: What problem are you
> solving with this patch?

Hi, thank you for your reply. :)

I'm trying to simplify the code. When percpu_counter_add_batch() and
__percpu_counter_compare() use the same batch size, percpu_counter can count
correctly, so there is no need to reduce the batch size to 1, which will cause
unnecessary serialization.

Best regards,
Jinliang Zheng

> 
> --D

