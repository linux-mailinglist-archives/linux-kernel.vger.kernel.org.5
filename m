Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4625B762B11
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjGZGDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjGZGDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:03:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFB8170D;
        Tue, 25 Jul 2023 23:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=cwe5zzwRb5EKV9jO3R5+pCg8hvrOiH5a2qZVK2S0qoU=; b=2+UrVu/c0K9uK/BvWp0qpmyyM3
        dQAVabbWkPOxh7MWftSZCkn2uDt2haDboO1NImshw1m9hRlpdI35uOCyQV0B8YBGWBUjVhkGUSw6H
        uiy1uVKMJevXzX+QNL61MKkGgJA3CIgFi1G12vInGU02ezIw3GPGbzC98Myf4ugGiNr163/6Vjdcj
        ld1Msus2nAhuorS1ijCMFILSATGOYaDSiPbM7O3/INhelCJYwOi8U/gj/mBnnDXqSuQKfQxXDkHIu
        n0Oi63j7TzNVgBYuLv1lmMBSEIqzJWK7/GUf6g4oRbkHRWtUOREUQbIWxhcTy7tRuRCQrKxGQJ2gV
        /FlnMpeA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOXbx-009FO2-1x;
        Wed, 26 Jul 2023 06:03:01 +0000
Message-ID: <26d59f6e-cc29-bcf4-d113-34c93804dea8@infradead.org>
Date:   Tue, 25 Jul 2023 23:03:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] rework top page and organize toc on the sidebar
Content-Language: en-US
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION PROCESS" <workflows@vger.kernel.org>
References: <20230724193118.2204673-1-costa.shul@redhat.com>
 <87ila9atuk.fsf@meer.lwn.net>
 <CADDUTFzKCrrBT=46F-08_EGrwMxVniDOgdkVr-DhGFTzS3DxOg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CADDUTFzKCrrBT=46F-08_EGrwMxVniDOgdkVr-DhGFTzS3DxOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/23 22:55, Costa Shulyupin wrote:
>> This patch is somewhat difficult to apply, as a result of:
>>> Content-Type: text/plain; charset=true
> 
> This is caused by em dash in the context line:
> The following manuals are written for *users* of the kernel — those who are
> 
> I haven't found how to fix it. Are there any tips?

Fix the email header or fix the em dash?

Did you use 'git send-email' for the patch? It seems to handle
UTF/UCS charsets AFAIK.

OTOH, any decent text editor can change the em dash to one or
two hyphens. (which I prefer)

cheers.
-- 
~Randy
