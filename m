Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF307CFEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346010AbjJSPyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjJSPyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:54:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2B0106;
        Thu, 19 Oct 2023 08:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=LdbJgaTYB+ZQzgKSi+h2BV1oX12pf85anp/pR6Dc1x8=; b=EEp+yTP/MyV92d3H4Uv7r33BJc
        3pQNxEz2pYnLMSP0eCNq8yHP1+4qX+p808UfIn4Tab8IQj6v6o4kMkpOXylZbc0PwKq868rjX8cPE
        2aD6zm8pw7YKXUHcb+6S+UyPKVblooWl1CmQD77psgFG801AhON7wbv6pVHHKiDoncS5+NREQx7p8
        D/dcg6rKId20UgDQ7TrlqAlkMWyEgPdRKd9SMswGKLCg5McyxHyCWRPVQllkXAtksAf76Qbyxnh+5
        +iughfFkCJFAez+jkRliGf12gg68sJuEKZBvCRZyBGefRm/PVRvI5HGtOlxpXwS8OpJfeQFfd8VbG
        Z0cFR4+A==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qtVLQ-000GFV-0r;
        Thu, 19 Oct 2023 15:53:56 +0000
Message-ID: <4c6991b1-0016-4a4a-9bf5-34481fd63a3c@infradead.org>
Date:   Thu, 19 Oct 2023 08:53:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sh: bios: Revive earlyprintk support
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1697708489.git.geert+renesas@glider.be>
 <c40972dfec3dcc6719808d5df388857360262878.1697708489.git.geert+renesas@glider.be>
 <d0c6044f-11e0-4f00-b7e6-eaf1e72f17a5@infradead.org>
 <f432f363a97bc3e179db2c33c4b2f74027f8016b.camel@physik.fu-berlin.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <f432f363a97bc3e179db2c33c4b2f74027f8016b.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/23 08:51, John Paul Adrian Glaubitz wrote:
> Hello!
> 
> On Thu, 2023-10-19 at 08:48 -0700, Randy Dunlap wrote:
>>> +config EARLY_PRINTK
>>> +	bool "Early printk"
>>> +	depends on SH_STANDARD_BIOS
>>> +	help
>>> +	  Say Y here to redirect kernel printk messages to the serial port
>>> +	  used by the SH-IPL bootloader, starting very early in the boot
>>> +	  process and ending when the kernel's serial console is initialised.
>>> +	  This option is only useful while porting the kernel to a new machine,
>>
>> Can we expect to see new machine ports using arch/sh/ ?
> 
> There is J-Core which is new open source hardware based on arch/sh.

OK, thanks.

-- 
~Randy
