Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3797A5630
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjIRX0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjIRX0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:26:30 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F9A99
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:26:24 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76dc7b0da9fso306627285a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695079584; x=1695684384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oAEtx1s5KODmNlfwZDRx/5fDgP/BvGwuP+6p/LeySyc=;
        b=DwZfbqTC7AvXz9ZXkivsv5q/c7I19qi/wfaxefQ+g8okYQYGKQGrNEfO19t7bVJBXT
         qFv0gjob3n2cQSBv8ULRwUCgkSqIH0+6qkC6TbOLczROI2o/pAcgYsA6Dd/PwL+u570v
         eI90iUK89OBcsznOnuy6tFTqjTNcRjnFeKYkLI+T7YOHlpF8/wzuUecf8cUKfE5m3OC7
         nyiKJKE6a0WslmYAqv407a0EaWAUjoVfvkNPHadJG7/YTnOxI2LfqojBziqHMXTwNPAE
         ZUU5EOOXY7fY/RC0uqkRTJygBjpHpQIGJWgxYIhq4oH+gQX5eDdpNbPVD+eHxef9nVLq
         T6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695079584; x=1695684384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAEtx1s5KODmNlfwZDRx/5fDgP/BvGwuP+6p/LeySyc=;
        b=JQr1AoSi9Q/UELJFaUXz4cay1kHC11WWhI9k60uBqeVgmU9/RcM/U/qMOhIwesJPIY
         RyxBPhGRiEWVNQLWkjAiVdL7VM5o4sc4jDRqV38li9zS3ynwzn8aGPr9kQRwZrtnKo/7
         ROTtT/iR26R02513DIfFRqd+kC+EHb9NO0yA9VSc149HqAJ+xeGHm6hhETkyHZ/0DGFK
         SQNOm6hh8k2zlOu1ePWT78H+8BA0nDPwyuVN3+721W6eWYqN1xdQfhXhrA72PJRfs4o/
         3q9i2C9aB/fk2Y8MH+fzvNMlKPV70bPpArvQBGF2V+QaKLKfGUkfxOKuOuiJAIhdjAZZ
         vkAw==
X-Gm-Message-State: AOJu0YxVilntve+v//8bE18HDvNs1wYoUdP7/pNpDVWxaQ5scQz5OBus
        UDTAm7oj6QbYhZJdNsm797svkQ==
X-Google-Smtp-Source: AGHT+IEXRIdmJQWyD0S5IhYq/RPfPN15fkMe6wTPmqLT8+ltrjCiLknrpDQvIt75XWrfMAomw0TJ5Q==
X-Received: by 2002:a0c:e493:0:b0:658:2a3b:4a1f with SMTP id n19-20020a0ce493000000b006582a3b4a1fmr2642260qvl.22.1695079583965;
        Mon, 18 Sep 2023 16:26:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id u11-20020a0cec8b000000b00641899958efsm3617260qvo.130.2023.09.18.16.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 16:26:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qiNdG-0007o0-U7;
        Mon, 18 Sep 2023 20:26:22 -0300
Date:   Mon, 18 Sep 2023 20:26:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: document
 mmu_notifier_invalidate_range_start_nonblock()
Message-ID: <20230918232622.GN13795@ziepe.ca>
References: <20230918201832.265108-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918201832.265108-1-jannh@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 10:18:32PM +0200, Jann Horn wrote:
> Document what mmu_notifier_invalidate_range_start_nonblock() is for.
> Also add a __must_check annotation to signal that callers must bail out if
> a notifier vetoes the operation.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  include/linux/mmu_notifier.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
