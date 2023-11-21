Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AE27F2919
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjKUJmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjKUJmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:42:43 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12025E3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:42:39 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4083ac51d8aso23708935e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700559757; x=1701164557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OFo9KPKmFK7WqzXwym/48RniSRgiZpvp+lNPOreiEFY=;
        b=j65JvBpUptIHNcFEhAJk0iFw6YMB730lUNSU9RxlEP0jEFmP9/m78yBxi9CptNHyI2
         62NtSsp4FiK+8/0GyOigt13rEnQuog5Cjqxw0fDWqIMtmvxZWDb+C+jHrOr6NWLZjBTZ
         X+ayrigretPeRDNHhFjEqO1d18RUxYdIQPzI8cY4UuFJ9Ztq2rIadHNlIxmUOtDS7oyb
         iN18O12T8i143rbyMg3KaAtZRwuCMCa/gqYDx6ibFkkd2hPKrNKQCwkNcZIJYLmSY0HM
         9HEkYaU46h28Db6nBvhFy57dqX8Mo6w/4S/CUKI1rpuIBU/1tACtLqjq3PjaTQ/bwDkx
         HwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700559757; x=1701164557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFo9KPKmFK7WqzXwym/48RniSRgiZpvp+lNPOreiEFY=;
        b=hy4chuRvx4Nz+K1t9gQ0QQQ1eqXu7sQ32oJ1hAXharku0dHb0WZuvJ6n/QeDbjjOK6
         R9ZtxbKCiHaSDVry25wlJ/x7wAYgArtttjo9ZZDkM3PBWQxF7X75eHISj4n0p+VANNFl
         skO0snt+hq3kmI32jHgZ7X9sxmWmjlNUwpIzYSYYgqa1woZB7R4zvJciUqfH2fyIZbrB
         RzwNqcY99lOSdWC9Frk+BAncEaMcs5xn7VqjDgMMZZygDArx7PwCIWNefYmS/u1AViu5
         AaO7EaHvaprIYj6RbOWXOyqK6W1o8iRiFc3A2uXxQ1sJ3vpYoEVpM5QBRwuvOQkm05pF
         kZfg==
X-Gm-Message-State: AOJu0YzUvAf10EcHKJfNOK1M0BHpSyeDAOtsoyt950gM7loG3j2k9ANQ
        wiRaNlezFGcyhkHGIHHhNRsPSg==
X-Google-Smtp-Source: AGHT+IHIyVqWoNqJSzyFRtD//B41b3mRhSXS014z/c9urGhK0lZKNPRhwj0Rcm/ITAjDFfTbjoZB3g==
X-Received: by 2002:a7b:c342:0:b0:40a:4a7d:606b with SMTP id l2-20020a7bc342000000b0040a4a7d606bmr8053233wmj.40.1700559757371;
        Tue, 21 Nov 2023 01:42:37 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b0040588d85b3asm20872413wmq.15.2023.11.21.01.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 01:42:37 -0800 (PST)
Date:   Tue, 21 Nov 2023 04:42:33 -0500
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc:     ivan.orlov0322@gmail.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        mathieu.desnoyers@efficios.com, shuah@kernel.org
Subject: Re: [PATCH v1] selftests/media_tests: fix a resource leak
Message-ID: <a0cdd2a9-08db-4b9e-aba4-7837df7fd2eb@suswa.mountain>
References: <71465605-7179-4281-8ec8-80f741e78038@suswa.mountain>
 <20231121093238.5376-1-zhujun2@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121093238.5376-1-zhujun2@cmss.chinamobile.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 01:32:38AM -0800, Zhu Jun wrote:
> From: zhujun2 <zhujun2@cmss.chinamobile.com>
> 
> The opened file should be closed in main(), otherwise resource
> leak will occur that this problem was discovered by code reading
> 
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> ---
> 
> Hi Dan Carpenter 
> 	
> 	I believe that the Linux kernel code is sacred and should strictly adhere to C code conventions
> 

*sigh*.  You do you, I guess.  This patch is pointless but I don't care
whether it's merged or not.

regards,
dan carpenter
