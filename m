Return-Path: <linux-kernel+bounces-12335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A716781F394
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19DA4B21668
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4029310E6;
	Thu, 28 Dec 2023 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq9M79R1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF36EA5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9bba6d773so2019884b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 17:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703727001; x=1704331801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYb21apCi1TYD3rMtdP8WfHi0WzC/HMdru5c9HRlZNs=;
        b=Mq9M79R1S5uveF9cEpUAL55FJUSy5DOsJKUzOmSuYaMNWZsWSsy05aPm05amiE/yal
         e0daDXDtrCRPDkoHffJMKcPwwCzqKFhna2TnE+8njgU7iGYjtSU5riPfGc1DdNyuNfXj
         HfHovPyw3gHNITs+bvNnxyJVmKxenF3SpSuVDAC5IqYuyrUBeww+Byh6ICm+wDuAlapp
         2gmAbogkFWnRBir6Nhi3LM8HnvlPhhjs/RdxTHjZlU/iO0LHROal676dX6ARahudiqTL
         cQ36+l9HBacVMWAJN+FNeXWqijlFf8KcgWhXHyG1kf3h8tWg3ZZHnCWkCcEwT/pn15fz
         0DOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727001; x=1704331801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYb21apCi1TYD3rMtdP8WfHi0WzC/HMdru5c9HRlZNs=;
        b=qMdGYYKA7cPYIR30fz7YElqk5fEEKrN7BCgFmTdxyMnu6++Y46XeL1wI6EMkpnRtOG
         +T2iuljfDXHk78LCo/j0r/5zVA0ksY3kzpbNoiMa/sLpeoIsM8Hj2Yq18HoIOnD7AHkP
         hv0Ad2vuIzky0TVSUaaMFgQ5dEfEvv5nVzPqn53UY6JsNgWrTgv1c2tNi8qvKrc5TJph
         Qg6TnBCiFHqFbkuhumxzugBWahSUAK6kUItwkxx9Wc6b4YnwxEMEUl6k6LCLbBkgVN7s
         QmAqWtfyA6JacOEnjG1xLwvZd/+Ln3Py8R2+kkIGSzhq8ALd7hijJ6CWtX6JBEX2QaSG
         TaBw==
X-Gm-Message-State: AOJu0YykIdrMe/gQVikW6JsxKmnLWWyJT0Ke1qO5Zf1RfjP9X0NX9F1M
	Rj4cAg27j/5cMrFHFzXNwnP3rql8Qs4=
X-Google-Smtp-Source: AGHT+IFbwB5dYoCPShoUyN3gGBDHW/MhdQB64NzIhSh+zHEfXxD0LEkN8r+nG2buvhbqQoqF+96dtg==
X-Received: by 2002:a62:a50b:0:b0:6d9:d5a7:9ca9 with SMTP id v11-20020a62a50b000000b006d9d5a79ca9mr3972819pfm.0.1703727001425;
        Wed, 27 Dec 2023 17:30:01 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id x31-20020a056a00189f00b006d96bb5db5esm6393059pfh.96.2023.12.27.17.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:30:01 -0800 (PST)
Date: Thu, 28 Dec 2023 09:29:55 +0800
From: Yue Hu <zbestahu@gmail.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org,
 syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com, LKML
 <linux-kernel@vger.kernel.org>, huyue2@coolpad.com
Subject: Re: [PATCH] erofs: avoid debugging output for (de)compressed data
Message-ID: <20231228092955.00000520.zbestahu@gmail.com>
In-Reply-To: <20231227151903.2900413-1-hsiangkao@linux.alibaba.com>
References: <000000000000321c24060d7cfa1c@google.com>
	<20231227151903.2900413-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Dec 2023 23:19:03 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Syzbot reported a KMSAN warning,
> erofs: (device loop0): z_erofs_lz4_decompress_mem: failed to decompress -12 in[46, 4050] out[917]
> =====================================================
> BUG: KMSAN: uninit-value in hex_dump_to_buffer+0xae9/0x10f0 lib/hexdump.c:194
>   ..
>   print_hex_dump+0x13d/0x3e0 lib/hexdump.c:276
>   z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:252 [inline]
>   z_erofs_lz4_decompress+0x257e/0x2a70 fs/erofs/decompressor.c:311
>   z_erofs_decompress_pcluster fs/erofs/zdata.c:1290 [inline]
>   z_erofs_decompress_queue+0x338c/0x6460 fs/erofs/zdata.c:1372
>   z_erofs_runqueue+0x36cd/0x3830
>   z_erofs_read_folio+0x435/0x810 fs/erofs/zdata.c:1843
> 
> The root cause is that the printed decompressed buffer may be filled
> incompletely due to decompression failure.  Since they were once only
> used for debugging, get rid of them now.
> 
> Reported-by: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/r/000000000000321c24060d7cfa1c@google.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

