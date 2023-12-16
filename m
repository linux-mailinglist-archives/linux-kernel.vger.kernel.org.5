Return-Path: <linux-kernel+bounces-1937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A587681561C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450C51F2584A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5798139E;
	Sat, 16 Dec 2023 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSU3evic"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAFB1116
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 01:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6da4893142aso1025472a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 17:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702691661; x=1703296461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuZFf9TLsyeNevfCqjs6eOOovm2u77pXZ45scIzaN/o=;
        b=CSU3evicqHnggpJkmAtYwlqE8rztZ5W8aJT0aRv3pHQKFUkQdT9nRfroPHrXyI01+6
         rH+o7K78WHMrujhLw/gdulHyVHhf78dy/VVMv2iL4KbPjdlM3uWUra2TdviIoP11zz75
         5duhBq5CD6vQmHxn8YTYgwMt/tIx9ZQZSDKoDXgtGDunCDNP0OqyTCVVnv4uDElm6CaY
         QYePPSMXtyvkaPldQQdw9Zv8PtOyb34f2MpKRSo4Pvw8ZbZDQi3BqFWFmoxo8e3kMPbw
         ZBOdBgIUDdXJpM9Izpfupr1m5NPWOtLdmMwslXTRWESO7TZHwxRfivp5a37Sj80bMxDf
         /jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702691661; x=1703296461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuZFf9TLsyeNevfCqjs6eOOovm2u77pXZ45scIzaN/o=;
        b=UPtoJ9oBJGpS6qoSc5Kku7d70nj1k5nn6Q2QXHnxiY1LoqhCN1oqMOeVo7RlRylHIN
         3H3gCSGG/PZPMTX4uDxiU/MRXhHrIkNjxQkE10KC9XNOIEvH2aZuLo7U2uJWQ4OwPgcV
         qj9KGkDMteqzMDbZKzAS3YGVuj6u1kXXUOWtFZYD+isge/QAUasxQJ8VJ9At7d0g2YZS
         aYHyQNoPPBcQfzl9CBklRo6cm/XMWNRg4tBtvn0C7rj3Vw5Z7L6rWm1KabSjNUife162
         TNX+MUF+hh0ECAQAnvROauabnWuyzOdahgN3E2atPbs8LizO5ohBjTEKEN9XbFHOc6v4
         onvg==
X-Gm-Message-State: AOJu0YzOrjp+Nde1xeykCPYndPOoxdsecYdmwHCqP/xxAxDKHLIr4kG8
	ZxQxBHT4NQLzTPxGHlr6sq4=
X-Google-Smtp-Source: AGHT+IElHsdK7kzoxwrGczqS5sCy0MkNGAofEJaLn4q6en4gr5qW5GYlKqZQN6W7pju0prltPwBSIg==
X-Received: by 2002:a05:6808:14c4:b0:3b8:b402:74de with SMTP id f4-20020a05680814c400b003b8b40274demr16249503oiw.32.1702691660867;
        Fri, 15 Dec 2023 17:54:20 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a19ca00b0028ad9d801e3sm203558pjj.46.2023.12.15.17.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 17:54:20 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: bhe@redhat.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dyoung@redhat.com,
	eric.devolder@oracle.com,
	hbathini@linux.ibm.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	lijiang@redhat.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	seanjc@google.com,
	sourabhjain@linux.ibm.com,
	tglx@linutronix.de,
	tiwai@suse.de,
	vgoyal@redhat.com,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()
Date: Sat, 16 Dec 2023 09:54:10 +0800
Message-ID: <20231216015410.188924-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZXxtfpXpuFXLd+ge@MiWiFi-R3L-srv>
References: <ZXxtfpXpuFXLd+ge@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 Dec 2023 23:15:10 +0800, Baoquan He wrote:
> On 12/15/23 at 12:38am, Yuntao Wang wrote:
> > The purpose of crash_exclude_mem_range() is to remove all memory ranges
> > that overlap with [mstart-mend]. However, the current logic only removes
> > the first overlapping memory range.
> > 
> > Commit a2e9a95d2190 ("kexec: Improve & fix crash_exclude_mem_range() to
> > handle overlapping ranges") attempted to address this issue, but it did not
> > fix all error cases.
> 
> Hmm, this is a specific function for kdump kernel loading. So far it's
> sufficiently meet demands. Say so because we only need to exclude
> crashk_res and crashk_low_res when constructing elfcorehdr. region
> crashk_res/crashk_low_res are digged out from system RAM region. That's
> why the break is taken in the for loop in the current code. X86 needs
> exclude low 1M, the low 1M could span several system RAM regions because
> BIOS under low 1M reserved some spaces. And the elfcorehdr exluding from
> crashkernel region taken in x86 is also a splitting.
> 
> Generally speaking, crashk_res/crashk_low_res is inside a big chunk of
> continuous region. On x86, low 1M spans several complete region on x86,
> elfcorehdr region is inside continuous crashk_res region.
> 
> You can see why crash_exclude_mem_range() looks like now it is. This patch
> makes crash_exclude_mem_range() be a generic region removing function. I do
> see the memmove can improve code readbility, while I have concern about the
> while loop.
> 
> Imagine we have a crashkernel region 256M reserved under 4G, say [2G, 2G+256M].
> Then after excluding the 256M from a region, it should stop. But now, this patch
> will make it continue scanning. Not sure if it's all in my mind.

Hi Baoquan,

Thank you for such a detailed reply. Now I finally understand why the code is
written this way.

However, if we can guarantee its correctness, wouldn't it be better to use the
generic region removing logic? At least it is more concise and clear, and other
people reading this code for the first time wouldn't get confused like me.

As for your concern about the while loop, I think it wouldn't affect performance
much because the total number of loops is small.

Sincerely,
Yuntao

