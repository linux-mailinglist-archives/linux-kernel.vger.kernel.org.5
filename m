Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289B27EF6D5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjKQROm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjKQROk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:14:40 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C189ED68;
        Fri, 17 Nov 2023 09:14:37 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc4f777ab9so20134795ad.0;
        Fri, 17 Nov 2023 09:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700241277; x=1700846077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGZUaKOJRdyWP7pxv9QIEEEy3UleECj1oeD0EVWLMQY=;
        b=joKmaB4cY0pGMi8xI15XSOr5y/a7PUWT4ez7WNJ5JFBWf3XCXajERVhkw/cAQ6dJdU
         UhKQhjuCZBEblwz+sPiiwB1BDul09PHYc1/98p9+6yLqeqKXXFFNDH3hUy3tsSH4w4qk
         y8KXyjTV3hK145kYJmdCTmIGtcRZ0bkbK8+OwjSGL8M0I1q49LMzN2SP1m886POdot4i
         8zOsBDmnP1tx+VB0BgRHkluObjAbmpCgDZmLV0nZb93IXXiTeGbdzMTfjeCTyRyzS8C9
         5J5xk87YJeOb2o9v5tfSxx4RQ7Fuw9cnMdRKowi4octoCd2xnuvfa+CF1HU7z0eMFJXq
         9i5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700241277; x=1700846077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGZUaKOJRdyWP7pxv9QIEEEy3UleECj1oeD0EVWLMQY=;
        b=HmXwPwHFn2xixL4rUWyfsv6KlHq+Goi5hyDboP9axHp6bAva4abA+t4hzdj+KNorhq
         E+dGFOOKSY+QhfhARg2R53FPINWExrB0ueZRvuwPPfyXgyKx5iUThvH6BZrHvcupD+gS
         n9Oq4nA5OwpuRGX5rgap6muP9AugpSV4mLhSrFJ9tPCXP4EtKmsr7KdidzTufJbMW72J
         jzSkM+nghIxGy4La1Na4MMJsQBwXOSy1lUbPPYBot57RmN70BNOqMoNkNdezCKznyZGX
         5MtAo0bDNPx2fxuQgzFL3jrhzDLhPkzYM6P2bXsKe18SJgKdc3kDUNs45dAs94wvwmXm
         iglg==
X-Gm-Message-State: AOJu0Yzgm92ec6F8c/kK5GbN8y0GwGt1fsO6xz3SBh2a8A4iw9rHcUv7
        AFge2vHghQ56pIInRcpFfCE=
X-Google-Smtp-Source: AGHT+IGv9Lkol91PF/y9EHJ6I3OSGN5inZGroOzTgDanN6s9TC2fdLqN/JJEbWVSRzA68F+zaaowfQ==
X-Received: by 2002:a17:902:7d87:b0:1cc:17e6:5da8 with SMTP id a7-20020a1709027d8700b001cc17e65da8mr279769plm.10.1700241277078;
        Fri, 17 Nov 2023 09:14:37 -0800 (PST)
Received: from debian (c-71-202-158-162.hsd1.ca.comcast.net. [71.202.158.162])
        by smtp.gmail.com with ESMTPSA id jl21-20020a170903135500b001ce5b92a62dsm1595764plb.128.2023.11.17.09.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 09:14:36 -0800 (PST)
From:   fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date:   Fri, 17 Nov 2023 09:14:16 -0800
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fan Ni <nifan.cxl@gmail.com>
Subject: Re: [PATCH] cxl/cdat: Free correct buffer on checksum error
Message-ID: <ZVefaOr8YvCsTfJa@debian>
References: <20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 04:03:29PM -0800, Ira Weiny wrote:
> The new 6.7-rc1 kernel now checks the checksum on CDAT data.  While
> using a branch of Fan's DCD qemu work (and specifying DCD devices), the
> following splat was observed.
> 
> 	WARNING: CPU: 1 PID: 1384 at drivers/base/devres.c:1064 devm_kfree+0x4f/0x60
> 	...
> 	RIP: 0010:devm_kfree+0x4f/0x60
> 	...
>  	? devm_kfree+0x4f/0x60
>  	read_cdat_data+0x1a0/0x2a0 [cxl_core]
>  	cxl_port_probe+0xdf/0x200 [cxl_port]
> 	...
> 
> The issue in qemu is still unknown but the spat is a straight forward
> bug in the CDAT checksum processing code.  Use a CDAT buffer variable to
> ensure the devm_free() works correctly on error.
> 
> Cc: jonathan.cameron@huawei.com
> Cc: Fan Ni <nifan.cxl@gmail.com>
> Fixes: 670e4e88f3b1 ("cxl: Add checksum verification to CDAT from CXL")
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---

Good catch.

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/pci.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index eff20e83d0a6..5aaa0b36c42a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -620,7 +620,7 @@ void read_cdat_data(struct cxl_port *port)
>  	struct pci_dev *pdev = NULL;
>  	struct cxl_memdev *cxlmd;
>  	size_t cdat_length;
> -	void *cdat_table;
> +	void *cdat_table, *cdat_buf;
>  	int rc;
>  
>  	if (is_cxl_memdev(uport)) {
> @@ -651,16 +651,16 @@ void read_cdat_data(struct cxl_port *port)
>  		return;
>  	}
>  
> -	cdat_table = devm_kzalloc(dev, cdat_length + sizeof(__le32),
> +	cdat_buf = devm_kzalloc(dev, cdat_length + sizeof(__le32),
>  				  GFP_KERNEL);
> -	if (!cdat_table)
> +	if (!cdat_buf)
>  		return;
>  
> -	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_table, &cdat_length);
> +	rc = cxl_cdat_read_table(dev, cdat_doe, cdat_buf, &cdat_length);
>  	if (rc)
>  		goto err;
>  
> -	cdat_table = cdat_table + sizeof(__le32);
> +	cdat_table = cdat_buf + sizeof(__le32);
>  	if (cdat_checksum(cdat_table, cdat_length))
>  		goto err;
>  
> @@ -670,7 +670,7 @@ void read_cdat_data(struct cxl_port *port)
>  
>  err:
>  	/* Don't leave table data allocated on error */
> -	devm_kfree(dev, cdat_table);
> +	devm_kfree(dev, cdat_buf);
>  	dev_err(dev, "Failed to read/validate CDAT.\n");
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> 
> ---
> base-commit: 7475e51b87969e01a6812eac713a1c8310372e8a
> change-id: 20231116-fix-cdat-devm-free-b47d32b4b833
> 
> Best regards,
> -- 
> Ira Weiny <ira.weiny@intel.com>
> 
