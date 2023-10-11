Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDF87C5DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbjJKT4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjJKT4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:56:42 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D2CE94;
        Wed, 11 Oct 2023 12:56:41 -0700 (PDT)
Received: from [10.192.9.210] (unknown [167.220.81.210])
        by linux.microsoft.com (Postfix) with ESMTPSA id 988F920B74C0;
        Wed, 11 Oct 2023 12:56:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 988F920B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697054200;
        bh=TBZdQQUltpuV9HyLOh65oqRuciUQw/90/g0T1N3ig58=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZyVqHMVfdzF1nHDzGIyQs8vM2aDPTwCds7lZxmqJqjCOERCi0zfxlsR1mjY6tx/mY
         3bDqV/Y/TqlTdddJjx62dNjea5bYxAji++z/ZLwt3bu0K7pssZR6JHCjRuYRZAkigi
         /B3Rix3JpJCc271GhTucwh8yg626j8LAl5b4ZiJ0=
Message-ID: <42a5c36d-8b65-418f-9826-2808ab49d67a@linux.microsoft.com>
Date:   Wed, 11 Oct 2023 12:56:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi: Use access_width over register_width for system
 memory accesses
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230925180552.76071-1-jarredwhite@linux.microsoft.com>
 <CAJZ5v0iHJcZzF=hGLRH+tT6uqCrfHbLw_KJD5dSRRTrsbeVMUQ@mail.gmail.com>
From:   Jarred White <jarredwhite@linux.microsoft.com>
In-Reply-To: <CAJZ5v0iHJcZzF=hGLRH+tT6uqCrfHbLw_KJD5dSRRTrsbeVMUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/2023 11:50 AM, Rafael J. Wysocki wrote:
 > On Mon, Sep 25, 2023 at 8:06 PM Jarred White
 > <jarredwhite@linux.microsoft.com> wrote:
 >> To align with ACPI 6.3+, since bit_width can be any 8-bit value, we 
cannot
 >> depend on it being always on a clean 8b boundary. Instead, use 
access_width
 >> to determine the size and use the offset and width to shift and mask the
 >> bit swe want to read/write out. Make sure to add a check for system 
memory
 >> since pcc redefines the access_width to subspace id.
 > This is fine, but what if there are systems in the field where
 > bit_width is invalid, but they just happen to work because of the way
 > it is currently handled?
For the kernel coding style issues, I will clean up for the v2 patch.

On the invalid bit_width for systems out there in the field, do you have 
any suggestions on how to handle this particular scenario? Would it be 
appropriate to add a kernel parameter flag that can revert back to the 
previous implementation?

P.S. Sorry for the HTML email.


Thanks,
Jarred
