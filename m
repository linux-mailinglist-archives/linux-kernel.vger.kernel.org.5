Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1D57DD621
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 19:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjJaSgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 14:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjJaSgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 14:36:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C3BDF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 11:36:39 -0700 (PDT)
Received: from [192.168.68.129] (unknown [177.98.22.188])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: koike)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 40A916607389;
        Tue, 31 Oct 2023 18:36:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698777398;
        bh=bUwJOj01a4F8gGzxLfRaZfqDlFCfc4iAzypRSVm5Q3U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JFCB+FclQIACx9J7Wc5X+zW/xibfhO0kxYSoAyRYSEYnCd31gWhBma3xI0IWg4xOj
         0jqWXPyJtT/OhWC1nzSeNEVyQkYnM0BUoijbTTWqo5zadMq1IBmDidMYcFy/tYAXwD
         axmnMFCmt8lT0QleQb3rvN/eTO53Uk/iUq5b1rFwjdO0ltmSDCct8OFAozw4EZYaqc
         TgbpAX/noA10DNs4PlBoU/0OOk8RynLvlVHagr0xWFI1MvnjV32pTxfORFTYlgxbQL
         46nSxH6pmDaPomFTXZhFZMq8I0sLn7/h3GiPI1Vt1u/UgQI2uN8A/4KofX0xoDs+l3
         nijDPrOK42HLw==
Message-ID: <318c568f-c813-4d16-b577-28f37cde92c7@collabora.com>
Date:   Tue, 31 Oct 2023 15:36:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Resend] Fix line Length
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     Daniel Stone <daniels@collabora.com>,
        Linux Outreachy <outreachy@lists.linux.dev>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nick Terrell <terrelln@fb.com>,
        Linux DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dorine Tipo <dorine.a.tipo@gmail.com>
References: <20231029144312.5895-1-dorine.a.tipo@gmail.com>
 <alpine.DEB.2.22.394.2310291610030.3136@hadrien> <ZT7v39jG4WTxPYjm@debian.me>
 <alpine.DEB.2.22.394.2310300712310.3533@hadrien>
 <3f1fdfa2-e30b-42c6-b290-bb02283b3589@gmail.com>
Content-Language: en-US
From:   Helen Koike <helen.koike@collabora.com>
In-Reply-To: <3f1fdfa2-e30b-42c6-b290-bb02283b3589@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/10/2023 08:36, Bagas Sanjaya wrote:
> On 30/10/2023 13:12, Julia Lawall wrote:
>>
>>
>> On Mon, 30 Oct 2023, Bagas Sanjaya wrote:
>>
>>> Hi Julia,
>>>
>>> The submitter touched one of CI scripts for the DRM subsystem. To test
>>> this patch, there must be a way to run these scripts locally (which
>>> may requires non-trivial setup).

Instructions to test it is on the docs:

https://docs.kernel.org/gpu/automated_testing.html?highlight=drm+ci#how-to-enable-automated-testing-on-your-tree

>>>
>>> Cc'ed DRM maintainers.
>>
>> There is a DRM outreachy project.  I think that motivated this patch.

Yes :)

>>
> 
> OK, thanks!
> 


Thanks
Helen
