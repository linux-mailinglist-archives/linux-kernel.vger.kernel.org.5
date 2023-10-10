Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6229E7BF4D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442582AbjJJHvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442608AbjJJHvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:51:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2CEA4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:51:37 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50305abe5f0so7148495e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696924296; x=1697529096; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kJcWNo/8KJ51ax88QJfvPgCGs+4edXiaLsPmHPPvA7A=;
        b=rxzLlnzdrOcrTACjsMQJyAj7l6DvY/sEcCTADMfB/lU2ew2mcYnLeLwBad7E6zT2Jp
         PVwP55Wbp6vUac0W65EDo2dmYjbDz19oS26XHOgpSkDblNChOG8vq4943vjhv7sjMxnA
         ELxihkV1YlyV0bDdPx4r3bJPIALJ2GDikshC7iTqLnhUbkkyeZwGsvsnWeeTj/96G2Xm
         vQ26hO0Q558ut4GZs4dkvzqgZvQzTj0Om36p88jEmZzV+rxRzBixAT8N2/nMW4+pw/fL
         4fwiHEhSzcW5cZSeXGeCDC/fUzCzIrvSNo+s54quaHVTsKRNCMjOhaOWsADbBJi3/eSm
         UR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696924296; x=1697529096;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJcWNo/8KJ51ax88QJfvPgCGs+4edXiaLsPmHPPvA7A=;
        b=iUa3Auqzch8uyIvzgpRiFzu2dfbnj8MY46LIfO8BDNXwBvFPcXNFIwyNFpky9//iZa
         7GU3KAfJ5pvizjTZXT1Y1xeLMvYpsj7doK/cfrX1gjuQRlsEeTyExlQUPxMzVQ7x5N9J
         ulRhWUoBt4smtm4GB9Ut2xo6qTKclCd0+8wA93tYDkgFGTZO/jUoFJEsSOG9YDuLd8vQ
         LOpbgSilKXxtfi3q5upawaYWlNH/HgQUsuNy1wAEcPwXl6CaxTQQQ9LDLwPe8QGUAh+E
         jOcyRRxh71zqInVTjFbKc8Ku6zorr8LEyorKbPjFHAswJCrP1MpufZTtNTJcNwDfG+bl
         +XSg==
X-Gm-Message-State: AOJu0YyvfsEI5Ueaf7T+On/bw5UhVX5J90FdOFkS5AjjCdb4CQYjqm9k
        70gya0VDROylhls2Xt0dEUpzsA==
X-Google-Smtp-Source: AGHT+IHtqLHYfIcwgaVbaqexLs+zoWCH5Qmn/1pLpFUPQWX4ZuHxth1Fvpbhs5GXKf1ycBqkA3XEvg==
X-Received: by 2002:a05:6512:60f:b0:4fe:94a1:da84 with SMTP id b15-20020a056512060f00b004fe94a1da84mr13917473lfe.5.1696924296104;
        Tue, 10 Oct 2023 00:51:36 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c3b9000b0040684abb623sm15716967wms.24.2023.10.10.00.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 00:51:35 -0700 (PDT)
Date:   Tue, 10 Oct 2023 10:51:32 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/9p/xattr.c: avoid format-overflow warning
Message-ID: <56aa4f09-8f61-48f3-9836-687bf852b03a@kadam.mountain>
References: <20231008060138.517057-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231008060138.517057-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 02:01:39PM +0800, Su Hui wrote:
> with gcc and W=1 option, there's a warning like this:
> 
> In file included from fs/9p/xattr.c:12:
> In function ‘v9fs_xattr_get’,
>     inlined from ‘v9fs_listxattr’ at fs/9p/xattr.c:142:9:
> include/net/9p/9p.h:55:2: error: ‘%s’ directive argument is null
> [-Werror=format-overflow=]
>    55 |  _p9_debug(level, __func__, fmt, ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> use "" replace NULL to silence this warning.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  fs/9p/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
> index e00cf8109b3f..d995ee080835 100644
> --- a/fs/9p/xattr.c
> +++ b/fs/9p/xattr.c
> @@ -139,7 +139,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
>  
>  ssize_t v9fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
>  {
> -	return v9fs_xattr_get(dentry, NULL, buffer, buffer_size);
> +	return v9fs_xattr_get(dentry, "", buffer, buffer_size);

I'm pretty uncomfortable with this patch...  This code is 13 years old
so it can't be too huge of a problem.  We're doing this for the printks,
but now they're going to look weird first of all.

Old: "file = (null)"
New: "file = "

But also this must have some other effects on runtime right?

regards,
dan carpenter

