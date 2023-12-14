Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A42E8129E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbjLNIAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjLNIAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:00:46 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20004CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:00:52 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c48d7a7a7so36098995e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702540850; x=1703145650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejy3KRelhcsFDinti0drGVR8XYlKvUdp2PH4o5vy1dI=;
        b=vGcEnAEI+8BP8wdATUfBYN86Hn2HAw732s67CImWRMuLjobm6B5MXBsMOGV+V0xeMi
         PZLapuaB31damUlenwOteHSYm/5vAsczgwcHlWTkmQcxU/Pmgnl7mPZKMoN8qTZkMh+R
         l7TvvPsyQ8wIptcFhYlG3b5c8BwvFyo45b9U/41CZFZxE6pnqvmbxlxeuFag+3K0xD8Y
         YezBjcgoPQLnNkIIobP6jG8QIi8bighJ5zIp7pN6yYtMmRJAg7VNTnSMj4xH9ve66fqz
         1FaR/O/wHCdSqpuXYUg6qn5kUO6jgFdDMx5mm/GV0pJp0BrDWyJkW+khKvvlLVEnNu/I
         M7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702540850; x=1703145650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejy3KRelhcsFDinti0drGVR8XYlKvUdp2PH4o5vy1dI=;
        b=VSh+fyxjooSLJM0rqWGQ7KLjFWPyppKlJ6lrnf8Z1WoPgNrUILP1N1D2WjFpxzcOC5
         kNoKq5APyvKdP2k/69Iik1odLvWcyGEGPu4eDM7Vp7rwHzMxkt/y5QPIagvF1ENzciUL
         L7uyBlvmnntvbuf/aB/HdK2vKXJVZZbNkcpjMSPRVU+hTemLS0glIaCT4IQs3hoSBCgV
         7sMwoQ2GRuDPyW6+2XL7Ii6hjaf+2xm7Z06fQiSeqVrw/Y+rYJmw8SgJlMd9bqkoQxxY
         k4lLJc4vzCbJYKucAJBcmPLvkaNTm3yrJYWir89VSdjE/+3GDnOHVOgpkNGU/Bh71+6v
         /QjQ==
X-Gm-Message-State: AOJu0YzGSJsO9qgjs6AUBSnHwkfE3OtgTIcSG2k5OUA/5rEHADSWDxot
        oWoPqNo322LaQQ2YN8i7R//0Kg==
X-Google-Smtp-Source: AGHT+IHQ4K6fG5UD2DRg9tvccj9wkjBFMvKHJ+iCR0tna4y5mXqNuX7X6s0KpISgg+aD5zV97RTFNA==
X-Received: by 2002:a05:600c:2257:b0:40c:314c:803e with SMTP id a23-20020a05600c225700b0040c314c803emr5582837wmm.106.1702540850506;
        Thu, 14 Dec 2023 00:00:50 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040b349c91acsm25653160wmo.16.2023.12.14.00.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 00:00:50 -0800 (PST)
Date:   Thu, 14 Dec 2023 11:00:46 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     oe-kbuild@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: arch/riscv/kernel/module.c:639 process_accumulated_relocations()
 error: uninitialized symbol 'curr_type'.
Message-ID: <a46f0c36-8fd2-4a85-880c-eb462d4a837b@suswa.mountain>
References: <d0897fb3-1af8-430b-aa8b-9aa829bad1d7@suswa.mountain>
 <ZXoFhu2TPXgrsInY@ghost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXoFhu2TPXgrsInY@ghost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 11:27:02AM -0800, Charlie Jenkins wrote:
> > 8fd6c5142395a1 Charlie Jenkins 2023-11-01  638  			}
> > 8fd6c5142395a1 Charlie Jenkins 2023-11-01 @639  			reloc_handlers[curr_type].accumulate_handler(
> >                                                                                        ^^^^^^^^^
> > Can the list be empty?  Uninitialized in that case.
> 
> That's a tricky one, the list cannot be empty. Each bucket in the
> bucket_iter is guarunteed to have at least one rel_entry. I can probably
> resolve this by extracting this for loop into a do-while loop.

You can just ignore false positives.  It's not really a fix to change it
to a do-while loop.  I reviewed the do while code before reading this
email and I still wondered about empty lists, but just to hear that it's
not going to be empty is enough.  Just the email was sufficient.

regards,
dan carpenter

