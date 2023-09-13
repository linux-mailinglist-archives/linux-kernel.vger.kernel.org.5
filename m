Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502E079F254
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjIMTpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjIMTpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:45:30 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1754F9B;
        Wed, 13 Sep 2023 12:45:26 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 020C3C0F9A;
        Wed, 13 Sep 2023 19:45:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a273.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 798FFC08C3;
        Wed, 13 Sep 2023 19:45:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1694634324; a=rsa-sha256;
        cv=none;
        b=WEJGQ8JeXgDgigOb7Zb1nsZ3vsqBgwMWGZhzdqlsc0RZ+WOaGogL4Ey+CeuRM/XXZjyGM1
        G6ozkzwiYz5p4S24qBuwtQi4WqLFKlG/FXN2zQHYwdyHX7QWDYsQTEJH5CyZPp6U8kqxwV
        fKHA1phWW/u7bplee/aRjSsk7Jdrr9YsTT5OGVgRtyrmc/dSicdHB2On67TqiuUDjmLxdV
        LIYomqpZUugpj7q1T3k4KQyAJZHkRkh9dgiJNL6EHtFc4Q4Bu+ESYzLm9f0h5cV+jf6L5U
        RdoQseT0bYK1KzjSWgA3EubOGQymxY30RAzOiaRZNs1sejWaC6Nvz9okemH6og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1694634324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=t/4S28WbLLUM6kEPRkt99xCgd02PMnu1Es+2h6o9n6A=;
        b=HoMwFZaeVNoDJzRhxrXBIqIK6fQ3qxh6uE8jKuEmJCkAlVS07MYJQ599a3kaIs/j14of1p
        p+lRoFsYbCnlseMFQ5J+Uho75nL/9sBM6TJOVaLzxR8bV1rXklKt1MU57O7AIjGhMDBxf0
        dchwmYnL0IcNJ0f4cCU9DTIz8pw7mFEMXJUnzdCIliYGthqtKBGBZFMf1+DGB2SBplcDwJ
        VCNKhHSYASqyH5ZWCqkDqwkApxUcqTNPVf7KdJFfaPGrwZlvP9t3Et1K2qQw7t4rsz6aVT
        gFFe4cD8opA7VhCTLxb0bjlpS1UB/uojN+0bR0hqgJTM3oLr0O245nnCXCwcPg==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-5s46g;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-White-Gusty: 29f3b477372f4be8_1694634324802_2187681599
X-MC-Loop-Signature: 1694634324802:530843640
X-MC-Ingress-Time: 1694634324801
Received: from pdx1-sub0-mail-a273.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.115.138.83 (trex/6.9.1);
        Wed, 13 Sep 2023 19:45:24 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a273.dreamhost.com (Postfix) with ESMTPSA id 4Rm9sb6GVgz36;
        Wed, 13 Sep 2023 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1694634324;
        bh=TRCLQlF2VO6s7nPtH5xn3QeQY4pWXTBPoW22AeYXlQo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=V5ULnT0j8eDK0AOQbPCphfs36EIssoN2AA4BRb04c1LcF5ohNPAqfwN2fw3AaBQFA
         hbEjKIzc4YFi76VEDdCsJFqgPn9i6ZrWsy7Kh1A/5eHXI+Df592I6xLcpJ0d4MkW4O
         Dik0v6lYyGQOCj8G9SvgyPFeGSorZCxu2WCSnek5RuGIkXK58JZT+h0oZk5ti0P6Ue
         ogiDoyrkmefSiBlBJ34tHhoGa+4IOC7AVu8rSRTYqNTyhT8te71Nf5wF+qgCD8lhlw
         ua2+pIN9/mcnCLHnjBi4b/UFyaQRES/IzpOQlDuVrEpkCxLgD/9d76zvSS/c+jmnZX
         sBWdoEz109sHQ==
Date:   Wed, 13 Sep 2023 12:45:15 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/mbox: Fix CEL logic for poison and security commands
Message-ID: <madfnttjnm5spfc3jxnvcvcwccdz2q4yqqjsz7hiey7mqy3jfi@4siu67gqsp6f>
References: <20230903-cxl-cel-fix-v1-1-e260c9467be3@intel.com>
 <6500e8a179440_12747294a3@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6500e8a179440_12747294a3@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2023, Dan Williams wrote:

>Ira Weiny wrote:
>> The following debug output was observed while testing CXL
>>
>> cxl_core:cxl_walk_cel:721: cxl_mock_mem cxl_mem.0: Opcode 0x4300 unsupported by driver
>>
>> opcode 0x4300 (Get Poison) is supported by the driver and the mock
>> device supports it.  The logic should be checking that the opcode is
>> both not poison and not security.
>>
>> Fix the logic to allow poison and security commands.
>>
>> Fixes: ad64f5952ce3 ("cxl/memdev: Only show sanitize sysfs files when supported")
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>> ---
>>  drivers/cxl/core/mbox.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index ca60bb8114f2..b315bdab9197 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -716,8 +716,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>>  		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
>>  		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
>>
>> -		if (!cmd && (!cxl_is_poison_command(opcode) ||
>> -			     !cxl_is_security_command(opcode))) {
>> +		if (!cmd && !cxl_is_poison_command(opcode) &&
>> +		    !cxl_is_security_command(opcode)) {
>
>Given that this is going to be a recurring pattern to add optional
>command support, I am not a fan of continuing to expand this boolean
>algebra eye exam.
>
>How about the following to only do the validation check and enabling in
>one place:

Agreed.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

... this also is a reminder of the need for regression testing/CI.

Thanks,
Davidlohr
