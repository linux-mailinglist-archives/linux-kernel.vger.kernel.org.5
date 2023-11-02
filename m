Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B1F7DEE17
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjKBIT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjKBITZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:19:25 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F70128
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 01:19:18 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7D10B3FA95
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698913157;
        bh=xOlOPXtFC14sPmMq/gNPsGSMRG8MAsaEPYDXA9iMskI=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=XFM8ZEbdjREn5zcnQZEiu0vvjMll9NoZtOFl/83AzBJIvhf9woTmKljMjI6o7PgJv
         9OcFh1DgP7WzT+NtoZF2mvicXBARgVv7/SImHhg39JCRNwZ+jj6F+OxksQbQ53Qy18
         IlmBQWS3e6CGpKMKk20XhNCIyvCt4GfMnFx9sUv4tD/HsF5tOFmCFzM4/hCUZkrVLU
         K5Uf3Kxzi5Ah9uFQ0qW40VyNiNMOxBaVuqfupd72IwQmD1wCZEwH9qwVwHOVqcYT4O
         DzDzghjT3M0L1RGaHCLVpsimWol5pCWXhrfuat6qqcppkkgDPJi+8iDGqVB3XYhuz+
         YaqU88uj+sS7g==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9d2ab03a586so42428266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 01:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698913156; x=1699517956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOlOPXtFC14sPmMq/gNPsGSMRG8MAsaEPYDXA9iMskI=;
        b=IC/7YAvSJ9TB9QvUAwt5jvZtO+ujNF61x596kVt+Ak4bFP+/g0I3Z8eumnlbURsgOk
         0JUOtSUE0DZFq7b+RiGjY4+64mGY6fUbVOYIDcIMihGvtltwcNoYmRMnuvQ+HauPaaDU
         zfjew4U7TlFxG6N+r2CQZAAMP+axxz19vTNjhCmOSJ9R2/WGao2urr4Xn2UTmLrTEZrx
         DNNcSQ68JlKuAKOsj5tr+6+cwLYFYraNwF00c34DnKp1LBzaxFcX2iyWWqfMJdnYvYQy
         DUNWGv38bCtTcVUXdKuJquY29t0iTCH+ahxOxCTRvY9Zk2pT920h5KLB3hBnbBZahMm4
         6rXQ==
X-Gm-Message-State: AOJu0Ywp3i7rz3T6QfHppYSHMxNyvxxFZKsMTc4tnKGqIhozAnz+qvyx
        iDvzukwgawAOMYRKN0q5y6ITyUfXhurN+oBVlkOEZzdFCfBca0f1PjgnhQpTSRQHQlMV9bYSLWT
        Edmtlrzg8BXziCWy5zQG40C4SRwcBgfl8k3FJLseQdR+DL/Rbdw==
X-Received: by 2002:a17:906:1915:b0:9bd:a73a:7a0a with SMTP id a21-20020a170906191500b009bda73a7a0amr2841631eje.58.1698913156302;
        Thu, 02 Nov 2023 01:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHH7IwIDgeKMPODTE0ZBXQTLEF6du+DVJY7/Nuswo3vcdrTQrgwmSzdl0XspVexrQnCQ+rxQ==
X-Received: by 2002:a17:906:1915:b0:9bd:a73a:7a0a with SMTP id a21-20020a170906191500b009bda73a7a0amr2841622eje.58.1698913155904;
        Thu, 02 Nov 2023 01:19:15 -0700 (PDT)
Received: from localhost (host-79-33-130-95.retail.telecomitalia.it. [79.33.130.95])
        by smtp.gmail.com with ESMTPSA id pv21-20020a170907209500b0099c53c4407dsm824959ejb.78.2023.11.02.01.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 01:19:15 -0700 (PDT)
Date:   Thu, 2 Nov 2023 09:19:14 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-modules@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        zhumao001@208suo.com, yangtiezhu@loongson.cn, ojeda@kernel.org
Subject: Re: [GIT PULL] Modules changes for v6.7-rc1
Message-ID: <ZUNbgnCEXC92GLZm@gpd>
References: <ZUKxT1CL9/0Dn6NE@bombadil.infradead.org>
 <CAHk-=whFXNYXG2ES8HdoaMC=O4bakMXGZezmoqA3SXwn4xJUPQ@mail.gmail.com>
 <CAHk-=wi=goCaTm6ZOKzm_ztky9ZT-vuGDWv39vVdtQT+oW=zEg@mail.gmail.com>
 <ZUNPy/sMRxdo+o2w@gpd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUNPy/sMRxdo+o2w@gpd>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 08:29:17AM +0100, Andrea Righi wrote:
> On Wed, Nov 01, 2023 at 09:21:09PM -1000, Linus Torvalds wrote:
> > On Wed, 1 Nov 2023 at 21:02, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > kmalloc() isn't just about "use physically contiguous allocations".
> > > It's also more memory-efficient, and a *lot* faster than vmalloc(),
> > > which has to play VM tricks.
> > 
> > I've pulled this, but I think you should do something like the
> > attached (UNTESTED!) patch.
> > 
> >                 Linus
> 
> Looks good to me, I'll give it a try ASAP.
> 
> -Andrea

Just tested this both with zstd and gzip module compression, all good.

You can add my:

Tested-by: Andrea Righi <andrea.righi@canonical.com>

Or if you need a proper paperwork:

--

From: Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH] module/decompress: use kvmalloc() consistently

We consistently switched from kmalloc() to vmalloc() in module
decompression to prevent potential memory allocation failures with large
modules, however vmalloc() is not as memory-efficient and fast as
kmalloc().

Since we don't know in general the size of the workspace required by the
decompression algorithm, it is more reasonable to use kvmalloc()
consistently, also considering that we don't have special memory
requirements here.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Tested-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 kernel/module/decompress.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
index 4156d59be440..474e68f0f063 100644
--- a/kernel/module/decompress.c
+++ b/kernel/module/decompress.c
@@ -100,7 +100,7 @@ static ssize_t module_gzip_decompress(struct load_info *info,
 	s.next_in = buf + gzip_hdr_len;
 	s.avail_in = size - gzip_hdr_len;
 
-	s.workspace = vmalloc(zlib_inflate_workspacesize());
+	s.workspace = kvmalloc(zlib_inflate_workspacesize(), GFP_KERNEL);
 	if (!s.workspace)
 		return -ENOMEM;
 
@@ -138,7 +138,7 @@ static ssize_t module_gzip_decompress(struct load_info *info,
 out_inflate_end:
 	zlib_inflateEnd(&s);
 out:
-	vfree(s.workspace);
+	kvfree(s.workspace);
 	return retval;
 }
 #elif defined(CONFIG_MODULE_COMPRESS_XZ)
@@ -241,7 +241,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
 	}
 
 	wksp_size = zstd_dstream_workspace_bound(header.windowSize);
-	wksp = vmalloc(wksp_size);
+	wksp = kvmalloc(wksp_size, GFP_KERNEL);
 	if (!wksp) {
 		retval = -ENOMEM;
 		goto out;
@@ -284,7 +284,7 @@ static ssize_t module_zstd_decompress(struct load_info *info,
 	retval = new_size;
 
  out:
-	vfree(wksp);
+	kvfree(wksp);
 	return retval;
 }
 #else
-- 
2.40.1

