Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906137C8E93
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjJMUyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjJMUyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:54:14 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966B9BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:54:13 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3af957bd7e9so1534587b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697230453; x=1697835253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BsUG3OJFKfAwdiYFB8OR66/JkgVTe1Lq1ToS7wZeEaE=;
        b=cHq/lgkvB4fI91kVzKTvWcCHxNtWzwSwCgyd3zEBDkEQqaw93yL6Aa/rpwcy/7NcK0
         T+OhrrI7cWjyofEP8La9GSYCP+JrPRmF3p0YZf9IpDlw1YnqGcvqTJE2Fc90Srqd++Gw
         5O/OCVQ9q/02Q6af8buyeOiPLghE/Kt/vD0LfU+cNhnvTGW2ZjcsB/xf03UIps1BBEU/
         bmcqCZ1GlC/IHoV1Zd5ptyU/aAQzKU/tYMe3nVvLlqe6MnB7Y29IaRTby7LRm7cDW8pH
         OnRlZcYZjnAiNu19S4ugdzExODDyxCtAbdJWmHBGMFcSFmwQkArOtoEc2TCw8fKT3XXo
         R6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697230453; x=1697835253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsUG3OJFKfAwdiYFB8OR66/JkgVTe1Lq1ToS7wZeEaE=;
        b=ZPuBwkahlT+2oHvsbdQ4IpQCT2ydo+F+aKy08TrPlsEng6mVmxj9U+cK402hAN0CFN
         zIDEL5Hqo+4SQF42YxgHFzSw1FPGSBQN1/emO/xJmHk4giyrJDpYFLPp5ahiy2XB3PiB
         CgazdGvXb2tkB7dADjzeVecLXBAVNKvBFSASYJZkzXnpb8Yl4kCgHsVxflJJZAEyfbX/
         vji4mYKKZROdc6DkARhD+Z76qdI8YONG8zUZtRohcl5Xe49IzyjH5ttOdxvdsAntSXLC
         sHuYg0Mu/zGmknNuSRbwk0qPkfE6A4w7PEG+zV7lG6e08/ATACghfsBmpefjE8nTNcnC
         4pKw==
X-Gm-Message-State: AOJu0YxVoyho4W2TnRqBuRv+bReRZq3auGJXga8yU+vgjRzUD5u96F8q
        Xy9LO8IxV3pR0R1gsRtSVALdYHTC40w=
X-Google-Smtp-Source: AGHT+IGKLpAIEOAuS2XOozg05Lvih06SKvxc4Gqi8dCnksOp+6vphWTKlAi+iGxkhEdu4h5AnSRhQg==
X-Received: by 2002:aca:280b:0:b0:3ae:1cd9:8e0 with SMTP id 11-20020aca280b000000b003ae1cd908e0mr27374738oix.39.1697230452884;
        Fri, 13 Oct 2023 13:54:12 -0700 (PDT)
Received: from dhcp-10-159-238-251.vpn.oracle.com ([2606:b400:8301:1041::16])
        by smtp.gmail.com with ESMTPSA id bf40-20020a056808192800b003ae31900048sm889207oib.44.2023.10.13.13.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 13:54:12 -0700 (PDT)
Date:   Fri, 13 Oct 2023 13:54:08 -0700
From:   Vishal Moola <vishal.moola@gmail.com>
To:     Hyesoo Yu <hyesoo.yu@samsung.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: check the order of compound page event
 when the order is 0
Message-ID: <ZSmucNWBMj/mNVeE@dhcp-10-159-238-251.vpn.oracle.com>
References: <CGME20231012012153epcas2p34b8e9e8a898ace8d50411cadf937ef5d@epcas2p3.samsung.com>
 <20231012011106.2425309-1-hyesoo.yu@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012011106.2425309-1-hyesoo.yu@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:11:06AM +0900, Hyesoo Yu wrote:
> For compound pages, the head sets the PG_head flag and
> the tail sets the compound_head to indicate the head page.
> If a user allocates a compound page and frees it with a different
> order, the compound page information will not be properly
> initialized. To detect this problem, compound_page(page) and
> the order are compared, but it is not checked when the order is 0.
> That error should be checked regardless of the order.

I believe all compound pages are order >= 1, so this error can't occur
when the order is 0.
