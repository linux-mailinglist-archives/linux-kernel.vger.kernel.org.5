Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940297A6239
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjISMLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjISML3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:11:29 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9B111A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:11:22 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76dbe786527so339363285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695125481; x=1695730281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aoyU9rzOy2BlH5KRJkQm4RzvdmE5afgsiRMrXPWn1pU=;
        b=gLpB6zQbJshv3krQTRKex0GrNT3IPA9krHe5nJXqUtt+YFJtVyUc1/cd2loBixvrwg
         UGj8l9NZ+uSieALoansEOT5DXd4E6pc+WFXRXgc+70U1LO1ubzl7azIhWY0hdiKChbCg
         ABGXqbX/aevuG9BY+OEgreUKLIjUKLlNjfeRDqI5/5lYkqNbInJLkTbOxOGWyeS6LZfI
         9p2FUyoVEWd5sLDc5pRgR/ySl1MIJ+gNF3h/7ykY/JO3F0iLEjWK+66Gc8pNhN+ixs3q
         eE8F/vrW5ZWNe3B2J1oMYGUfhIIY8wSWHoNipt1XbP+WP76ATw9zBaTBeWYgZAmgz4Ci
         0Z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695125481; x=1695730281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoyU9rzOy2BlH5KRJkQm4RzvdmE5afgsiRMrXPWn1pU=;
        b=ANfTWX7MgTImEcAmH9yOwpXZASZ51BBIw2uKKziF/u4w2xDQhRp06aziSptIYGtXxx
         kJuMKLYw3Wr4GnlBtATSK8J9bu/oybQVQVPYHWv1Q70enhm6+cGiXXDUF1vttYy6gRe7
         H+RFHYmfreJXfj+u+dCllJ+Y53Kkfx3JYrv8h4ZA4hblJqPs9/O2u+Au3NRljYPRjdFD
         fUJ2bxKhvIVr16qHBy6d6svqfWdZxNZrEF67hsuh7tz0897U1hiw+v/6Gto3E5KNmkn5
         b2a6qr7SSxPheP2vlc9AIIA6DSCr9brTRJSJswA4vXc4HM86ulxKjiF1bInMwd/yWyYS
         uDTg==
X-Gm-Message-State: AOJu0YwFKB9r0pYwmSrMc/+Q27DX1y27MJr7B2drXvL4Pelx8CdaHKEd
        gxiMJ8tLTLGVLkDkj7+G7ri0Ng==
X-Google-Smtp-Source: AGHT+IHVTs08d8NaR/JqyVVIELGCXA1MekrWnfCHt/Y23q2QJTj4sfAfOGSXAGhdaB90Vcbx/q+Srw==
X-Received: by 2002:a05:620a:e07:b0:773:ad9b:4c81 with SMTP id y7-20020a05620a0e0700b00773ad9b4c81mr8836359qkm.23.1695125481742;
        Tue, 19 Sep 2023 05:11:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id g27-20020a05620a13db00b0076cdc3b5beasm3909448qkl.86.2023.09.19.05.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 05:11:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qiZZW-000EC9-OI;
        Tue, 19 Sep 2023 09:11:18 -0300
Date:   Tue, 19 Sep 2023 09:11:18 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     GuokaiXu <xuguokai@ucas.com.cn>
Cc:     kevin.tian@intel.com, shuah@kernel.org, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tools/testing/selftests/iommu:Fixed spelling errors
 in comments
Message-ID: <20230919121118.GS13795@ziepe.ca>
References: <31680D47D9533D91+20230904023236.GA12494@xgk8823>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31680D47D9533D91+20230904023236.GA12494@xgk8823>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 10:32:36AM +0800, GuokaiXu wrote:
> From c4e404036e0a7ffcaedc5760bee234713ccfe4a4 Mon Sep 17 00:00:00 2001
> From: GuokaiXu <xuguokai@ucas.com.cn>
> Date: Mon, 4 Sep 2023 10:18:04 +0800
> Subject: [PATCH 1/1] Fix the spelling errors in comments
> 
> Signed-off-by: GuokaiXu <xuguokai@ucas.com.cn>
> ---
>  tools/testing/selftests/iommu/iommufd.c          | 2 +-
>  tools/testing/selftests/iommu/iommufd_fail_nth.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
