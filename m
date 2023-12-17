Return-Path: <linux-kernel+bounces-2559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B719815ED1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076FB1F20F39
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F74328C9;
	Sun, 17 Dec 2023 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeEisazM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96C1E4A6
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702814142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lMhXOzCGjIkOyucikWchP2GXTVEI4ULzcQxVu60/41w=;
	b=SeEisazMUC8tBbijABo6wFb/+c1s+WwQUu0fkyVrHQmzyU8XF3Q+1yeR41UjrbRYTUKcwe
	Yi6/o3dObOsj2fEU4ZtHX+hO/zqJZZAyIgtbNJ82ciITksVDRQaGqUYaA+ugRS4VHMkfly
	SLzcBJxAbAkoO8LQjBS4ikwnJL+y0Bk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-MKc1GYshNPKpSGAKpxKcsw-1; Sun,
 17 Dec 2023 06:55:37 -0500
X-MC-Unique: MKc1GYshNPKpSGAKpxKcsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62C291C05AA8;
	Sun, 17 Dec 2023 11:55:36 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E706C15968;
	Sun, 17 Dec 2023 11:55:35 +0000 (UTC)
Date: Sun, 17 Dec 2023 19:55:32 +0800
From: Baoquan He <bhe@redhat.com>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v5 0/3] Some bug fixes and cleanups related to kexec
Message-ID: <ZX7htAE5rQJpEBxu@MiWiFi-R3L-srv>
References: <20231217033528.303333-1-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217033528.303333-1-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 12/17/23 at 11:35am, Yuntao Wang wrote:
> This series includes some bug fixes and cleanups for kexec.
> 
> This v5 series introduces no changes to any patches. I just reorganize the
> patches and repost them.

LGTM, thx.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Yuntao Wang (3):
>   kexec: modify the meaning of the end parameter in
>     kimage_is_destination_range()
>   kexec_file: fix incorrect temp_start value in
>     locate_mem_hole_top_down()
>   x86/kexec: use pr_err() instead of pr_debug() when an error occurs
> 
>  arch/x86/kernel/kexec-bzimage64.c | 2 +-
>  kernel/kexec_core.c               | 8 ++++----
>  kernel/kexec_file.c               | 4 ++--
>  mm/highmem.c                      | 2 --
>  4 files changed, 7 insertions(+), 9 deletions(-)
> 
> -- 
> 2.43.0
> 


