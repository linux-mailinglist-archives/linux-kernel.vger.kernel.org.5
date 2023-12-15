Return-Path: <linux-kernel+bounces-403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F9281409D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C041F22AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DA56AB9;
	Fri, 15 Dec 2023 03:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BL9fG1Vi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B636AA1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702610874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LwL29/cvUYFmPMFizthvB5mbwWT7pj5mVWcUZ0VQ95E=;
	b=BL9fG1ViaydqQIMV3SFv7dcwApRPNy+mp3oJbuShgrWUUN41sclF4QYUmNM8HgYgOQXQYA
	sf2ENn5s97ehDrIeazOhderrS828jjSZ6jMOCjTawbqopdd+k7GYVTp96PZtlSEQElx8QS
	Ggb0Ob2XP+7omMh5L8AEFGgeW1VGJjQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-YCg3eLfLP4ybHpWIskAtsg-1; Thu, 14 Dec 2023 22:27:48 -0500
X-MC-Unique: YCg3eLfLP4ybHpWIskAtsg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD7A6101A555;
	Fri, 15 Dec 2023 03:27:47 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ACB4140C6EB9;
	Fri, 15 Dec 2023 03:27:46 +0000 (UTC)
Date: Fri, 15 Dec 2023 11:27:43 +0800
From: Baoquan He <bhe@redhat.com>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Takashi Iwai <tiwai@suse.de>, Lianbo Jiang <lijiang@redhat.com>
Subject: Re: [PATCH 1/3] x86/crash: remove the unused image parameter from
 prepare_elf_headers()
Message-ID: <ZXvHrx9ODn1yW9hf@MiWiFi-R3L-srv>
References: <20231214163842.129139-1-ytcoode@gmail.com>
 <20231214163842.129139-2-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214163842.129139-2-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 12/15/23 at 12:38am, Yuntao Wang wrote:
> The image parameter is no longer in use, remove it. Also, tidy up the code
> formatting.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
>  arch/x86/kernel/crash.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index c92d88680dbf..792231a56d11 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -198,8 +198,8 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
>  }
>  
>  /* Prepare elf headers. Return addr and size */
> -static int prepare_elf_headers(struct kimage *image, void **addr,
> -					unsigned long *sz, unsigned long *nr_mem_ranges)
> +static int prepare_elf_headers(void **addr, unsigned long *sz,
> +			       unsigned long *nr_mem_ranges)
>  {
>  	struct crash_mem *cmem;
>  	int ret;
> @@ -221,7 +221,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
>  	*nr_mem_ranges = cmem->nr_ranges;
>  
>  	/* By default prepare 64bit headers */
> -	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
> +	ret = crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
>  
>  out:
>  	vfree(cmem);
> @@ -349,7 +349,7 @@ int crash_load_segments(struct kimage *image)
>  				  .buf_max = ULONG_MAX, .top_down = false };
>  
>  	/* Prepare elf headers and add a segment */
> -	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz, &pnum);
> +	ret = prepare_elf_headers(&kbuf.buffer, &kbuf.bufsz, &pnum);
>  	if (ret)
>  		return ret;
>  
> @@ -452,7 +452,7 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
>  	 * Create the new elfcorehdr reflecting the changes to CPU and/or
>  	 * memory resources.
>  	 */
> -	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
> +	if (prepare_elf_headers(&elfbuf, &elfsz, &nr_mem_ranges)) {
>  		pr_err("unable to create new elfcorehdr");
>  		goto out;
>  	}
> -- 
> 2.43.0
> 


