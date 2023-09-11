Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C7279C063
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350945AbjIKVmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbjIKNBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:01:30 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BC2CE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:01:25 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-79536bc6697so162861339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694437285; x=1695042085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vpNZPcx3bjDHiQSM0MkVh372Rmrhu59xNLcZbNnj7uQ=;
        b=QHjDrnYQIX+ME6Itr80hHF04z0PPVnDlAwWiqaBcJW4rkmPC5Nqff1WBvL0visCW63
         zS4rfNYDqAMDZeerkXtgRrP0o3EnbLwci98aeZK77be8BYCODkh5pRmmdMMIa9cASVEM
         CWbme7xi52oW2A0CTwY6vhPAX/s7wioXZTltY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694437285; x=1695042085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpNZPcx3bjDHiQSM0MkVh372Rmrhu59xNLcZbNnj7uQ=;
        b=T78a7x6mL8dHAtNLIYO/96OzUohgf5r8LTKsinVR98IV8YPgS+JXj7sgn/jNKpkzfi
         CVA985iWqEuvPZvGKgw0PiWXeJdhBAyREAtsJs3XfeEGkcAins/mCglfZdkqa2bCnZt8
         jnDtRA0kya15ldU722ZAoQD2lHPJDWYJ5xp9wHnBdpO48ILTpZvTfEZBwX0Yv9Iyh4Tv
         P1+Q0Xz54waCD4eAOTy4VlmmVX/2ikXDfN31qY1J8upbo5k+eZDvt3ioqacxxKXjHV6W
         oQXIOzCSCvAvN6CgwzApPLE10mIu38cfDbUa4R1fFgDBR6R9p8sydAWyTltcj/tJuCu0
         P7+Q==
X-Gm-Message-State: AOJu0YypSOLGK9ValCyAFWozcgByTm774SsW7qvUky4f+0XXGJVZaF0r
        A5/45FbRdG3NtMFP7K6wGJvxM/upw6sJZjXMusU=
X-Google-Smtp-Source: AGHT+IFGzwi1w5oe71D2cbB1u9WZWLs+LMA8N7bKRNCnsIeRjk7c07VTBcGLxjPIPYMtujZqyupEsA==
X-Received: by 2002:a92:d34e:0:b0:348:e9e4:4902 with SMTP id a14-20020a92d34e000000b00348e9e44902mr10477274ilh.0.1694437284827;
        Mon, 11 Sep 2023 06:01:24 -0700 (PDT)
Received: from localhost (110.41.72.34.bc.googleusercontent.com. [34.72.41.110])
        by smtp.gmail.com with UTF8SMTPSA id a24-20020a02ac18000000b00430245071ddsm2153329jao.176.2023.09.11.06.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 06:01:23 -0700 (PDT)
Date:   Mon, 11 Sep 2023 13:01:21 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: misc: onboard_hub: add support for Microchip
 USB2412 USB 2.0 hub
Message-ID: <ZP8PobwGAG+PlLQH@google.com>
References: <20230911-topic-2412_onboard_hub-v1-1-7704181ddfff@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230911-topic-2412_onboard_hub-v1-1-7704181ddfff@wolfvision.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 10:22:38AM +0200, Javier Carrasco wrote:
> The USB2412 is a 2-Port USB 2.0 hub controller that provides a reset pin
> and a single 3v3 powre source, which makes it suitable to be controlled
> by the onboard_hub driver.
> 
> This hub has the same reset timings as USB2514/2517 and the same
> onboard hub specific-data can be reused for USB2412.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Acked-by: Matthias Kaehlcke <mka@chromium.org>
