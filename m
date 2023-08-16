Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319A177DAE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242307AbjHPHGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjHPHFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:05:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF151FC7;
        Wed, 16 Aug 2023 00:05:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5234b80e9b6so8388079a12.2;
        Wed, 16 Aug 2023 00:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692169541; x=1692774341;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F66b+WiJQhWCTNUtmQ9U4s1ZL0iS1ZKW40DQdZOBThE=;
        b=b5lPwvMoj1h9j6WMG6K31IBv4RI9KiOaY/V08NKgB/bIM1UmIBVMIUzS/jrI3rF5dR
         qZm0JCP4GSODAY52ZnKMCGQMiNJjpOCdhnac9hZUTpEAQjWHdRZYf5QFFhpoze/x/hZ5
         c5/bFVbbigvDPdjuAUWeg3qEB1BpduYhI4cJ/2GOsXDWzP3iTRx3dGZeT2BVTjBCv0N+
         UiSne26Aw6zuoyjvLF5c/Za4hZ4MyFufRLiUaOtLc7wgpC2UjBTYi6cX8K+JRTgHCM4o
         ENaZ5RE8jp+w/r+j132CXNNyCDJe08RFLfkz19aMQlIQNQe9af2yJF/GiurtLfRpXfNt
         3SDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692169541; x=1692774341;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F66b+WiJQhWCTNUtmQ9U4s1ZL0iS1ZKW40DQdZOBThE=;
        b=c1rFFVh5Kx0Vl/6vxgW6bPLwh/8XtHGFPA7F7K6SPgia93J2UZGPcJJsolUFpVpBFa
         CLNZzNKxhR5rCxcD5ey+VcMT+I/NaJ1tZ/6QVpa4n1mDXjIbt06xuBDrodcBr619G2pE
         dVym64A0nOT1YcHKHMGJEZjW37Xt6BO0DJq+4ESIIShVL75XMtbCXhsikqICwelbAl2B
         eaFLZNN4PrMdP31n7SGE+g3rvf+PJLvuFvnfnZTyHdONsdIBw3pCmbpD0W/VLWAlZ5t7
         Rwt4mI4ZaQ4iW893DUqO5v24i+sT8vG58X7siGNAIMPDjtwV7zMdIpe7fFSoZ3PAezjW
         VaRA==
X-Gm-Message-State: AOJu0YzHzXTKgmVbLzujHgI4FDlwQJPZ1USE2qM5yTe3uLc5yn00Magu
        cVydD51vUTZLbUsyxt/zGjBMjz0JY3SUSUvF
X-Google-Smtp-Source: AGHT+IHoFbVhtpG8pq/iUfBdydWXnasjtRZUXNg+G1N4Vi93Y4/LUy/Hl4bX9yJDD+lB9vM3kz5Hqg==
X-Received: by 2002:a17:906:200a:b0:99b:f820:5d0e with SMTP id 10-20020a170906200a00b0099bf8205d0emr957729ejo.25.1692169540896;
        Wed, 16 Aug 2023 00:05:40 -0700 (PDT)
Received: from akanner-r14. ([77.222.24.45])
        by smtp.gmail.com with ESMTPSA id vr2-20020a170906bfe200b00988b8ff849csm8053175ejb.108.2023.08.16.00.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 00:05:40 -0700 (PDT)
Message-ID: <64dc7544.170a0220.90098.7253@mx.google.com>
X-Google-Original-Message-ID: <ZNx1FFzoIiLYRLHq@akanner-r14.>
Date:   Wed, 16 Aug 2023 10:05:33 +0300
From:   Andrew Kanner <andrew.kanner@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 0/1] netlabel: KMSAN warning
References: <20230815205917.1504837-1-andrew.kanner@gmail.com>
 <CAHC9VhRRcMQhbobpGZy0ha3saOJ4Ke1CCnExKSJq1E2jXCU3NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRRcMQhbobpGZy0ha3saOJ4Ke1CCnExKSJq1E2jXCU3NQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 06:27:43PM -0400, Paul Moore wrote:
> 
> I think the answer is going to depend on the particular "bug" and the
> patch required to resolve it.  In this particular case I think the
> patch is okay so I went ahead and merged it, although I did remove the
> "Fixes" tag as the current code isn't broken.
> 
> In general, if a test tool dumps an error or warning for something
> under security/ and you aren't sure if it's valid or if we need to
> resolve it upstream, you can always send us an email and ask what to
> do :)
> 
> -- 
> paul-moore.com

Thanks, Paul.
I got the idea.

-- 
Andrew Kanner
