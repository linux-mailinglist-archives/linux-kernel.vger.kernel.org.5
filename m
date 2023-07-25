Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40265762039
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 19:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjGYRcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 13:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjGYRcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 13:32:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8247026A2;
        Tue, 25 Jul 2023 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=huYoQw/VsEdrryOXoPwzfkMHdWCe1iNxFEa9sxkfcOM=; b=XGd4cWPy+ck0qamKi1HoaQ3V4J
        cAg8PCJdLaOAS8I1hdDZlIms71DvfnTT2+K0iXzmhCE8z1d3x6xAalmEOG2NLbjOmoEQCf3LVg/Br
        qhkqDMeC7h6og0JHEzpU79ZvSSSQJXBRpKHCXC81i7DrB9yCaTYJRl7dn4Y/GMQ7068cbKfAMOsU5
        jCG4WDwx9ZQEg6JHiRy9Wu1fw2LSs86Gnc+UYHa16LcDk9ybV9kY0aI3va9Ab7JTrP5uLJWAEEOyf
        8aY5DVnk7YcRgJ5V8hTRugrH9D1/HSsOS2GLeyny/sxp+cTkpNAo8qxEloL9KJe0fax+soT4WDnbz
        S0hNStOw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOLt2-008AIf-0R;
        Tue, 25 Jul 2023 17:31:52 +0000
Message-ID: <5da2379c-4ec1-9bbf-bc94-2e1dbb7344f2@infradead.org>
Date:   Tue, 25 Jul 2023 10:31:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Documentation: devices.txt: reconcile serial/ucc_uart
 minor numers
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Timur Tabi <timur@kernel.org>,
        Kumar Gala <galak@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <20230724063341.28198-1-rdunlap@infradead.org>
 <2023072544-cloning-footsie-65e0@gregkh>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2023072544-cloning-footsie-65e0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/23 10:27, Greg Kroah-Hartman wrote:
> On Sun, Jul 23, 2023 at 11:33:41PM -0700, Randy Dunlap wrote:
>> Reconcile devices.txt with serial/ucc_uart.c regarding device number
>> assignments. ucc_uart.c supports 4 ports and uses minor devnums
>> 46-49, so update devices.txt with that info.
>> Then update ucc_uart.c's reference to the location of the devices.txt
>> list in the kernel source tree.
>>
>> Fixes: d7584ed2b994 ("[POWERPC] qe-uart: add support for Freescale QUICCEngine UART")
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Timur Tabi <timur@kernel.org>
>> Cc: Kumar Gala <galak@kernel.crashing.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jiri Slaby <jirislaby@kernel.org>
>> Cc: linux-serial@vger.kernel.org
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> ---
>>  Documentation/admin-guide/devices.txt |    2 +-
>>  drivers/tty/serial/ucc_uart.c         |    2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Very nice, thanks for catching this, I'll go queue it up.
> 
> Actually, how did you notice this?  I don't think the devices.txt file
> is up to date at all anymore, and odds are, other things are wrong in it
> too.

I accidentally! saw some reference to lanana.org in the kernel source code
and just grepped for that and saw this...

-- 
~Randy
