Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB426776DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 04:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjHJCKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 22:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHJCKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 22:10:30 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1872210DA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 19:10:30 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so308824b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 19:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691633429; x=1692238229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHnppH8OkHE3+a/XnL69tDk6mKlaaFEW6slsoeTV/t4=;
        b=JAfqWE3U8jNNlTcGM/mwc4vGcdo7iZq4rU6vElQtrpc7VfBiz+GxIa9t1PD10V5aJn
         IqfW5QNYs78BJ3Wpd1i+mnZIsGBiaEvuoEQvWNz9GvFAvTCEFCInvqu2MbXnRYBUMtvF
         FLcjHMl8FnuEP2K2/9zocgsKB1aY3E5RJf4mP5EW1kvChgc/0x9rgDwvnOZbGD1yKw1c
         XiE1LfvwZMi3LapcNLMqSlksTuV/1nrsYp/dQP6Gktln6wD5bkrHKoO0eyX4zYetoUFr
         hSKLe8QazoaEeMWcwJPN+r45SM6txTzNCUSgKI+ROEGjZeU+ysCUejrPoNbKZmpUuBzG
         Z81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691633429; x=1692238229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHnppH8OkHE3+a/XnL69tDk6mKlaaFEW6slsoeTV/t4=;
        b=kM9cE6fqrnOzqrpOUlHS+KAzQzPdWdIyekHbgw5jgoQCRcBHRafKLAwZ9DBG46SG+L
         CBQA7X6fk7KjRqjTzsZuDz67rv3Muoc4mu12q+mbgjDHJlrIMIZBy/b0xDFn0cAv1lO1
         G8/ONfQMdeumDzZbobTcpgKhHUXEzjbMt5hghHTBoPAwcOm5WCCGdyeCVQwb4JlbNuoj
         YELUZ5fDyAMd7FXydiCKhoXjHcJI8GawP/8VSgIRTs5IC4TA0pNxeHKlmTuyRFeViGMP
         N3xps0/iA6rPC4yuCup3747cc6d7Mw8tGrw8w2Jp1pu7/wXvOTlNhJrz9geMxZxTJKo1
         nS2w==
X-Gm-Message-State: AOJu0Yz3vLOsIj2NLOahbrM1/H2b1HDZSt1oFCe/yScRIVTib4Yi/0I/
        aOJxLnAkZV6QBTIQt2gjUIpLZvEbJyY=
X-Google-Smtp-Source: AGHT+IFqvlpc/IFhkjVNrtHO+AXON6RNj41vm63XDEqctsSKSr4BgGm2t15oZ9rm2Gk6eZLtco/okA==
X-Received: by 2002:a05:6a00:189c:b0:687:1300:22ff with SMTP id x28-20020a056a00189c00b00687130022ffmr1294241pfh.1.1691633429485;
        Wed, 09 Aug 2023 19:10:29 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id 24-20020aa79218000000b006827c26f148sm256157pfo.195.2023.08.09.19.10.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Aug 2023 19:10:29 -0700 (PDT)
Date:   Thu, 10 Aug 2023 10:20:01 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Ferry Meng <mengferry@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com
Subject: Re: [PATCH] erofs: refine warning messages for data I/Os
Message-ID: <20230810102001.000035ca.zbestahu@gmail.com>
In-Reply-To: <20230809060637.21311-1-mengferry@linux.alibaba.com>
References: <20230809060637.21311-1-mengferry@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Aug 2023 14:06:37 +0800
Ferry Meng <mengferry@linux.alibaba.com> wrote:

erofs: refine warning messages for zdata I/Os

> Don't warn users since -EINTR is returned due to user interruption.
> Also suppress warning messages of readmore.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/zdata.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index de4f12152b62..53820271e538 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1848,15 +1848,10 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
>  
>  		page = erofs_grab_cache_page_nowait(inode->i_mapping, index);
>  		if (page) {
> -			if (PageUptodate(page)) {
> +			if (PageUptodate(page))
>  				unlock_page(page);
> -			} else {
> -				err = z_erofs_do_read_page(f, page);
> -				if (err)
> -					erofs_err(inode->i_sb,
> -						  "readmore error at page %lu @ nid %llu",
> -						  index, EROFS_I(inode)->nid);
> -			}
> +			else
> +				(void)z_erofs_do_read_page(f, page);
>  			put_page(page);
>  		}
>  
> @@ -1885,8 +1880,9 @@ static int z_erofs_read_folio(struct file *file, struct folio *folio)
>  	/* if some compressed cluster ready, need submit them anyway */
>  	z_erofs_runqueue(&f, z_erofs_is_sync_decompress(sbi, 0), false);
>  
> -	if (err)
> -		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
> +	if (err && err != -EINTR)
> +		erofs_err(inode->i_sb, "read error %d @ %lu of nid %llu",
> +			  err, folio->index, EROFS_I(inode)->nid);
>  
>  	erofs_put_metabuf(&f.map.buf);
>  	erofs_release_pages(&f.pagepool);
> @@ -1920,10 +1916,9 @@ static void z_erofs_readahead(struct readahead_control *rac)
>  		head = (void *)page_private(page);
>  
>  		err = z_erofs_do_read_page(&f, page);
> -		if (err)
> -			erofs_err(inode->i_sb,
> -				  "readahead error at page %lu @ nid %llu",
> -				  page->index, EROFS_I(inode)->nid);
> +		if (err && err != -EINTR)
> +			erofs_err(inode->i_sb, "readahead error %d @ %lu of nid %llu",
> +				  err, page->index, EROFS_I(inode)->nid);
>  		put_page(page);
>  	}
>  	z_erofs_pcluster_readmore(&f, rac, false);

