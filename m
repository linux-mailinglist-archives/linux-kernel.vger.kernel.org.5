Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB90177D515
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 23:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbjHOVZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 17:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239682AbjHOVY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 17:24:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B521FF7;
        Tue, 15 Aug 2023 14:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=9pJ1wsbY2UxG0wbqwgeXOXq9L+padpO7VJkSq7iIKMg=; b=lTvomQ+3NtqWYsDTJa6XhmN+pj
        Yrxo/ZehIL5ueAcVKlOY8RFN7d17KY69uuutCBNDw0vQgeI9h2mCq6Uh+WdwuulOwHz2LIjPS9QEw
        aDvHLOet4GfhmkUBAmUYW48qj+Qu2LlAcZ7mANWElD77z1wkugb0K/0g9wki5JUHjjFrQI1T6mqog
        YPpwtDoUvgIyDzp4ZzekagnbAE6OZQ1lUcd1laq575pD5ThzSEjZBxLn6RHxuCdR20zLNyGrF6wb3
        Lr1emFh4Z7U8r/SkjUMvvhnGjRqq2fDZJQa8egJ/QECn4L58ytMbqxCUS0xgQlXrF7S1zBDNGeqX9
        C6R5ZqxA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qW1Wd-002Xn5-0b;
        Tue, 15 Aug 2023 21:24:27 +0000
Message-ID: <dee677dc-65cc-976e-09dd-88abf7477582@infradead.org>
Date:   Tue, 15 Aug 2023 14:24:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: linux-next: Tree for Aug 15
 (drivers/media/pci/intel/ivsc/mei_ace.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        Wentong Wu <wentong.wu@intel.com>,
        Zhifeng Wang <zhifeng.wang@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20230815214610.0b097d68@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230815214610.0b097d68@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/23 04:46, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230809:
> 

on i386, when CONFIG_ACPI is not set:

../drivers/media/pci/intel/ivsc/mei_ace.c: In function 'mei_ace_post_probe_work':
../drivers/media/pci/intel/ivsc/mei_ace.c:454:9: error: implicit declaration of function 'acpi_dev_clear_dependencies' [-Werror=implicit-function-declaration]
  454 |         acpi_dev_clear_dependencies(adev);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~


-- 
~Randy
