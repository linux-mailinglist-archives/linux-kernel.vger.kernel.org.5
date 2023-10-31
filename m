Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CE87DC500
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 04:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbjJaDvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 23:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjJaDvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 23:51:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C701B3;
        Mon, 30 Oct 2023 20:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=NcJE+muHCTM+F5ydwVKCzS7huTyeARslBg0+emRqTPI=; b=DqA3DiLEz4btMtwydEToDoDcBW
        pJpoRs+uF5ciYUtRW88W3duync7qDFpXA6gR5jc6RJHo1DZG3s8u6EzwtyP7hFSFOB4JZxP7LWcHC
        jn0fP3AgSKb8pfUZqRjht9L6tHphFHyFjAyuG2feUTkPKMeXJ+f4+HayiCLkGnKtnBxDGJ70X2OFN
        pWW7ttkPqVBoh4LTszRABbWARW77Vo4uQbxQpj8tj91QsyVoa9ID38zRtHe46XOMcNzL0bQoR322Y
        6681g3cy6ZTKg1O3U+QmV6+RNN/9p90fNNcUt1ZnIBFNTVvjsKK9pGAp89NvN86qKvjGbLusnbic3
        KHOsrx3A==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qxfmV-004UOn-0j;
        Tue, 31 Oct 2023 03:51:07 +0000
Message-ID: <842a0d64-279d-4052-a243-95fee608ea76@infradead.org>
Date:   Mon, 30 Oct 2023 20:51:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Gaps in logs while using usb-serial as a console
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     ariel marcovitch <arielmarcovitch@gmail.com>, johan@kernel.org,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAFGKuwoFUaXMsOOWJNBenQDG6+syt80Z9pvQQK1XSZFztC2_SQ@mail.gmail.com>
 <2023103052-unpeeled-calibrate-ae48@gregkh>
 <CAFGKuwp7JH8H9vjz8iJ24R9TRW0GDE-O96VBAG4L8X4DhTabXg@mail.gmail.com>
 <2023103003-defection-recess-cf49@gregkh>
 <968c62ca-0ef2-4bf1-a17b-a6d88d5e2e20@rowland.harvard.edu>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <968c62ca-0ef2-4bf1-a17b-a6d88d5e2e20@rowland.harvard.edu>
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



On 10/30/23 07:19, Alan Stern wrote:
> On Mon, Oct 30, 2023 at 09:30:15AM +0100, Greg KH wrote:
>> On Mon, Oct 30, 2023 at 10:15:30AM +0200, ariel marcovitch wrote:
>>>> Please realize that usb-serial console was the result of me loosing a
>>>> drunken bet.  It's amazing it works at all.  For "fake" devices like
>>> LOL your drunken bet was quite helpful to some people
>>> Because modern PCs come without a serial port, I wanted to use it to
>>> see early logs on my crashing kernel without having to use printk
>>> delay and things like that.
>>> I'm curious as to how kernel people debug PCs in general...
>>
>> We use a usb debug port connection (it's a special cable).

For EHCI it is a special cable. For XHCI you can use a special cable but
it is not required. (I saw a few people on LKML say that a normal data cable
works so I tested it and it does work.)

But if you want the special cable (for XHCI), this one works:
  https://www.datapro.net/products/usb-3-0-super-speed-a-a-debugging-cable.html

So I tested with both the special debug cable and a normal A-A data cable,
both with satisfactory results.

> Sometimes people use netconsole (see 
> Documentation/networking/netconsole.rst).  I don't know how common it is 
> nowadays, and it may not be quite as reliable as a debug port device, 
> but it should still work.  And it doesn't require special hardware.

It would be great if netconsole worked with wifi and not wired (ethernet).

-- 
~Randy
