Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8E27EEAC8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 02:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345641AbjKQBkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 20:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345623AbjKQBki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 20:40:38 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D398DD67
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 17:40:30 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc53d0030fso11356105ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 17:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700185230; x=1700790030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KdUhvf6uMJk9zg+Z4ww8VDFiHMblZPGDtWn4+l8E2zI=;
        b=AzXsu9z/ADmkoT7E9FK3ex4eX9tgklHrZSGDkOAS8knIhQXVqy84MUzV3xYPDafC3Y
         FRRKkLs1ddI7Exz6DgaIQeUY8KrV+CE1io1wFdYjVl92jiEhPirtFgxaLgthSZvIHuyH
         XcNk/xulk5YidRcxzZqt0Vpb68+/3JLGS+hVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700185230; x=1700790030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdUhvf6uMJk9zg+Z4ww8VDFiHMblZPGDtWn4+l8E2zI=;
        b=gY9p2lYt0VWYPzIGAnzyIh4326cbPR5+GFaaMGbIsgDA55i/K41tUrHml60wqyFgCc
         gFfOfGElEWAxi4FdXMacCkd5Vn4voaPx0W+dpgNiDvDa32EOXpDXZtjvE98NJQrHXBhJ
         J/lvSjB89T3PJhsNaBPvyhk/+DwdkVx7/NY0UW+FsmoqMG2luHj5n7i7reC07gZ8vLa6
         vmtxgJVkc1rnmGEjxMWstDcYguQMoEsIjR8D4FaiIMUsVV0RZzJGgBe1AqKROBAO93b0
         GARAnpCwqNKpgyeZjoZYYiPyuyhwEtXkOhfnXQezKRAYAHJrC51fxpzJYxKQI9fclo9s
         MaZg==
X-Gm-Message-State: AOJu0YzXDHG4gxm5PB+0tPLydcdrpIP47GmSvLp5yPIF6aBGCo++sVLz
        AnsSSROSIEYU/aXeo7grGRJUyA==
X-Google-Smtp-Source: AGHT+IEAWjSLmY8fKGIF5DGI4e00HXeKS8hMbY9rGDsRUt4LOo1UrGq1dcgWQkT2abHuWX0y0FVdKw==
X-Received: by 2002:a17:902:cec1:b0:1cc:52b5:8df8 with SMTP id d1-20020a170902cec100b001cc52b58df8mr5319744plg.26.1700185230327;
        Thu, 16 Nov 2023 17:40:30 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e5d200b001b8b2a6c4a4sm300234plf.172.2023.11.16.17.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 17:40:29 -0800 (PST)
Date:   Fri, 17 Nov 2023 10:40:25 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] checkpatch: do not require an empty line before error
 injection
Message-ID: <20231117014025.GC1325348@google.com>
References: <20231109075147.2779461-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109075147.2779461-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/11/09 16:51), Sergey Senozhatsky wrote:
> 
> ALLOW_ERROR_INJECTION macro (just like EXPORT_SYMBOL) can immediately
> follow a function it annotates.

Gentle ping.

[..]
> @@ -4054,7 +4054,7 @@ sub process {
>  		if ($prevline =~ /^[\+ ]};?\s*$/ &&
>  		    $line =~ /^\+/ &&
>  		    !($line =~ /^\+\s*$/ ||
> -		      $line =~ /^\+\s*(?:EXPORT_SYMBOL|early_param)/ ||
> +		      $line =~ /^\+\s*(?:EXPORT_SYMBOL|early_param|ALLOW_ERROR_INJECTION)/ ||
>  		      $line =~ /^\+\s*MODULE_/i ||
>  		      $line =~ /^\+\s*\#\s*(?:end|elif|else)/ ||
>  		      $line =~ /^\+[a-z_]*init/ ||
> -- 
> 2.42.0.869.gea05f2083d-goog
> 
