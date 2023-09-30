Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDEC7B4245
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjI3Qm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjI3Qm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:42:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D564C6;
        Sat, 30 Sep 2023 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=GagtNB5oKru/R0xh6c+JiiKDjGrtTBxS9g+mKoBaTJI=; b=bNAEK2992/2avcolWoSxOBEQBZ
        AVQslNEHtFYtaXseYWP7N6aLDNOLIS/sBcu05HrmCXd0iWmiWYcka5Rk9+ZhpSwviXXsEXWdh6XW3
        6hKQhT6p1bedNgXLbvhKfHDMapt9lVm0K1GyVdKDusq24qZHDqrRXRQ2cSjw0QxlOy8luN7X8K6CQ
        BTfB8hbiW/b/+mgUBVni4ZbQ/Q3kXRdsAC0y30Chcf3LiKRB49cVYSp2MtLmXPAjkeuPFskmXsHiH
        4tj/YoK21+8U4NTI239jKlqq8kNChBeQtLUAXOzjxExOj4fdgm9CpfCfvk9fG49ioAQl/S8D8Zooo
        KIEBkGEw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qmd3C-009qhm-0J;
        Sat, 30 Sep 2023 16:42:42 +0000
Message-ID: <a30164d2-a527-415a-b264-7f284a5266ab@infradead.org>
Date:   Sat, 30 Sep 2023 09:42:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fixed documentation warning about duplicate symbol
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Abhinav <singhabhinav9051571833@gmail.com>
Cc:     stern@rowland.harvard.edu, benjamin.tissoires@redhat.com,
        mathias.nyman@linux.intel.com, hdegoede@redhat.com,
        hadess@hadess.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20230930123449.1170359-1-singhabhinav9051571833@gmail.com>
 <2023093020-discern-dispersed-7dbe@gregkh>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2023093020-discern-dispersed-7dbe@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/23 06:31, Greg KH wrote:
> On Sat, Sep 30, 2023 at 06:04:49PM +0530, Abhinav wrote:
>> Compiling the documentation in html gives a warning about duplicate symbol
>> because same name is used for function usb_string(...) and 
>> also for the struct usb_string.Also having a different name can
>> be helpful while searching or debugging the code.
>>
>> Renaming the function usb_string(...) to utf16le_to_utf8(...) fixes 
>> this warning.Reason for choosing this name because 
>> this is what the function description says it is doing.
> 
> Odd trailing spaces, why?
> 
> Anyway, sorry, but that's a horrible function name for a usb core
> function, especially just for a documentation warning?  Surely the
> documentation tools can determine the difference between a structure
> name and a function name?  This can't be the only place this has ever
> happened, right?
> 
> Try fixing the documentation tools instead?

Yes, this is a known Sphinx issue (i.e., not in scripts/kernel-doc).

There was an email thread about this on linux-doc last year:

https://lore.kernel.org/linux-doc/564cbd05-8788-9223-1ecc-59e7fc41b46a@gmail.com/

It looks like this particular issue has patch(es) available but they are
moving very slowly.

-- 
~Randy
