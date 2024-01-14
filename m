Return-Path: <linux-kernel+bounces-25412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1104E82CFEC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 08:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81229B21DB3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 07:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15601876;
	Sun, 14 Jan 2024 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luOi+0/5"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967561854
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 07:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36066190a99so38911965ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 23:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705216713; x=1705821513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfOY4hqiuCt9vvQdw+q0DGwlOUMbwjspM6TDeMSz84Q=;
        b=luOi+0/5yzDZoWNNO4wpriLI6P2dmRLOuU8yP4DmutoVdzhBsSRxakbDp9hAvdkN02
         9SQfV1C2Mruw0N+SNUiksFY/+7Xy0T2w80s0I86pPwsgYVT+N2UyoQOmIQoFACj4iUE5
         F28kyEVwNT2BerxyFxLdOUqnfPTxGvH27aAoZcRrKms9RpVj8+iMIsqIoc6dro3GDq0T
         CDNqj2EkMNGVl0quEgPEykQg4XuuNrAHg3IyDjnZdy2vWX8g2tsc3jzBvKh3YAwOUwV2
         rbdz+YPkmOosDtP943XzTsxesL3BlDXLTg2aY1TBccpshvl80kFEubV1DWWVmHWMQjBa
         CHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705216713; x=1705821513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfOY4hqiuCt9vvQdw+q0DGwlOUMbwjspM6TDeMSz84Q=;
        b=AmQFJAFodyNANobfGvfFr4wm4R9kLuErHIuqt2XtLCC946PAL9KJ+u9y+wKVPS6fnt
         7CdYO3AmMYMXsA6Rmwl6u+L57AMS8Lx+6Ew1xDZVR0+SHMt8E03KOAMBfyCyBavDVLPF
         PXNqHPg8a3fycUCanmGlXWI9eR+p6aMpgn1ZrVkDR1PwWXC6s8E45ca2yUp4lXUCxJUp
         ng+2DIzyMER+OvSscWafBkVDSaBDbw7aCQA6+PT0HY8OOSywKKZpd0hUviJMzk6D3fCI
         ddKklb0a6CMva1p4F5Y0JAnczsJzZCOyiWqlz/P6BV0cV3LaIgFYRAIi6890TN7h6zRQ
         5CdQ==
X-Gm-Message-State: AOJu0Yy85dMlZGlejQjV5/bJSLnp16oNdh2oJMrDsUgZ20OszxhfpCe9
	K+QeiBEYftmS7rHObgnkQ+tMRAJhQqMok9On
X-Google-Smtp-Source: AGHT+IH89Ue0mEG16bVI0Uxlq9NOSdM42keewy/S73kshmAMlNO6CA0Ezeff/2053Y11e/Vuk6J0nw==
X-Received: by 2002:a6b:f90a:0:b0:7be:dc94:766a with SMTP id j10-20020a6bf90a000000b007bedc94766amr5059898iog.0.1705216713583;
        Sat, 13 Jan 2024 23:18:33 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id mf3-20020a170902fc8300b001d075e847d5sm5690600plb.44.2024.01.13.23.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 23:18:33 -0800 (PST)
Date: Sun, 14 Jan 2024 15:18:27 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, Yue Hu <huyue2@coolpad.com>,
 bugreport@ubisectech.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] erofs: fix inconsistent per-file compression format
Message-ID: <20240114151827.000069d6.zbestahu@gmail.com>
In-Reply-To: <20240113150602.1471050-1-hsiangkao@linux.alibaba.com>
References: <20231227050633.1507448-1-hsiangkao@linux.alibaba.com>
	<20240113150602.1471050-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jan 2024 23:06:02 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> EROFS can select compression algorithms on a per-file basis, and each
> per-file compression algorithm needs to be marked in the on-disk
> superblock for initialization.
> 
> However, syzkaller can generate inconsistent crafted images that use
> an unsupported algorithmtype for specific inodes, e.g. use MicroLZMA
> algorithmtype even it's not set in `sbi->available_compr_algs`.  This
> can lead to an unexpected "BUG: kernel NULL pointer dereference" if
> the corresponding decompressor isn't built-in.
> 
> Fix this by checking against `sbi->available_compr_algs` for each
> m_algorithmformat request.  Incorrect !erofs_sb_has_compr_cfgs preset
> bitmap is now fixed together since it was harmless previously.
> 
> Reported-by: <bugreport@ubisectech.com>
> Fixes: 8f89926290c4 ("erofs: get compression algorithms directly on mapping")
> Fixes: 622ceaddb764 ("erofs: lzma compression support")
> Reviewed-by: Yue Hu <huyue2@coolpad.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

LGTM.

Reviewed-by: Yue Hu <huyue2@coolpad.com>

