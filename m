Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4557D276C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 02:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjJWAPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 20:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJWAPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 20:15:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD967DA
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 17:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=+QXW/l6GkCEO8D4EwdYyKAqEk28eghzvFAVTvAvZF5g=; b=hcbSXnXqeWW1irVX7N5dX/ISVb
        jFrvwjCWJo/msjtkE65jcKPY7fem7jeo1SvNHmE6PxqbVOWVNLPvpcKIXNgG2jFW3Xq1xmV94valg
        4PehOdTNosR1SJKsY0UYsuHmfYXHgm04yPY11RaBwcO8nd0JLSpUXLTN30aCwwHLoomY3lMnN2aiq
        v5biazOcKoPt58H41lLlIgtZqS4WINw7WztZ0IUBF4E+gCXlgUrbc9vwJvqcrMtvcGRIl8YIhzqfP
        Fjwg+jfTybul8eogGzSRuDe2QFz1bNfbStptuYZVw8yuJnNz1ecBzLcrCltUVRHIM+Lv80zLw6+jp
        v044kyRw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1quiaz-0065eE-1m;
        Mon, 23 Oct 2023 00:15:01 +0000
Message-ID: <6675c47a-d258-41ae-b506-88d7ae74b551@infradead.org>
Date:   Sun, 22 Oct 2023 17:14:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How can I add "busybox sh" as init during boot of the custom
 kernel?
Content-Language: en-US
To:     gmssixty gmssixty <gmssixty@gmail.com>,
        linux-kernel@vger.kernel.org
References: <CAOx-CDUwV0d0+2UdZW+vdUcjwAg2+Hanf1-iNSYFRWOW2yQugg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAOx-CDUwV0d0+2UdZW+vdUcjwAg2+Hanf1-iNSYFRWOW2yQugg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/23 16:56, gmssixty gmssixty wrote:
> How can I add "busybox sh" as init during boot of the custom kernel? I
> have compiled the kernel and put the bzImage in /dev/sda3 (/mnt/sda3).
> Booted that kernel. After booting, I got a message to set the init
> process. I have put the busybox in /bin. Now I want to add this
> "busybox sh" as an init process. How can I do this?
> 
> Note that, I did not install any other software in that /dev/sda3
> (/mnt/sda3). I have only bzImage and busybox.

from Documentation/admin-guide/kernel-parameters.txt:
(or https://docs.kernel.org/admin-guide/kernel-parameters.html)

	init=		[KNL]
			Format: <full_path>
			Run specified binary instead of /sbin/init as init
			process.

-- 
~Randy
