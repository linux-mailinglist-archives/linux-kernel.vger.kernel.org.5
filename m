Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5D581349E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573768AbjLNPXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573774AbjLNPXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:23:00 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA66181;
        Thu, 14 Dec 2023 07:23:07 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-28b0016d989so964678a91.1;
        Thu, 14 Dec 2023 07:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702567387; x=1703172187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ohq2TqyeCp7vALWI2lnBhc2DS++39eptkisQfLH66MU=;
        b=adlxYrNloCruW6m0g9Jvz/b0MaBi3M4vvMe4BXK6LsFnHJ0u+FOLGUVDsTXwk+rLeu
         aGgPZd3ujf9CDL8sJ/Opc9GIVpaodIlvtBO5NoCesid3MY+ncNg0jtrlU4jQaZIzXrW9
         OWe5g3RlEnFwzEIRKMjJW12deVvXqJnpqD1mt64XpMPbuzUGF9++OJfpTwZLM/r9Cy7x
         PiPi0m1/ysUSRNrMvkTpVxuiTu5To5eTmB13Km3YfrvwZ9UdZvJsKH0CSC+OI3qzAx+M
         UvxjcoZsoa0zId2LU3rKAsEolo0Oe+y7nIQL4lZorMhZiHObA+lNJhgObkMZIwQU3xH9
         ETng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702567387; x=1703172187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ohq2TqyeCp7vALWI2lnBhc2DS++39eptkisQfLH66MU=;
        b=W3jbPc1zjePagFYJ1mS8G9Q1+jGQHKiwlxblEwBQVzJi5ql2jVYG51ptfdxRWA8pbM
         kAA7Pjty6rSjz1DLz2ayA5HoWcbBhshf0PI1bQ6FLQHaweYCZPf2vdcECyporle+sMHf
         CxuQW8p20BKcTh1856NdEEpm1KcSJ0+nkWFcwMaJQz7EnocTU1ZN/wuYKcEbZtVLdP2+
         Ii8ha9GfvoXciU8i3vRuvXIq98PEHDlIho3A6yf/Pn12u4PNDYOUTejG1uW/WivOzLp3
         c8rQpS90iPp6hqGSBqHhxN4M+9yuvpaDqSEX1g9cHpTOqxGNrf+KY/jKVhcbnaEWDa2F
         ZPJg==
X-Gm-Message-State: AOJu0YzruoP+F6aNKcR9cnNrXFT5wi4cnF+fz48XFEdYMcdeCkdRUzzE
        2I/LaIk1+gnhR9HE2EOTq9LF0ZqI4LU=
X-Google-Smtp-Source: AGHT+IGD+rRvReMP6h2SdpAYoybvnIr/ZhP8lpc4PfPaVQm+NxJKk3LyWFOMGt+1LL0zWTlEfF2VAA==
X-Received: by 2002:a17:90a:eac1:b0:28b:1d62:bfe with SMTP id ev1-20020a17090aeac100b0028b1d620bfemr263811pjb.43.1702567386644;
        Thu, 14 Dec 2023 07:23:06 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id nb11-20020a17090b35cb00b0028017a2a8fasm13412214pjb.3.2023.12.14.07.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:23:06 -0800 (PST)
Date:   Thu, 14 Dec 2023 23:23:01 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Subject: Re: [PATCH v2 5/5] gpiolib: cdev: improve documentation of get/set
 values
Message-ID: <ZXsd1Uhzg328Zdsy@rigel>
References: <20231214095814.132400-1-warthog618@gmail.com>
 <20231214095814.132400-6-warthog618@gmail.com>
 <ZXsbZOEjpTN_8oZQ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXsbZOEjpTN_8oZQ@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 05:12:36PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 14, 2023 at 05:58:14PM +0800, Kent Gibson wrote:
> > Add documentation of the algorithm used to perform scatter/gather
> > of the requested lines and values in linereq_get_values() and
> > linereq_set_values_unlocked() to improve maintainability.
>
> I believe this is based on the old discussion in the thread where I proposed
> the patch to convert this (unreadable in my opinion) code to use bitmap APIs.
>

I believe you are correct - that the code is unreadable in your
opinion.  And I noted that you were the origin of this change in the
cover letter.

I'm not usually comforable with this level of hand holding, but I made
an exception in your case.

Cheers,
Kent.
