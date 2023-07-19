Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758F97597E1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjGSOPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGSOPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:15:01 -0400
Received: from mail.mu-ori.me (mail.mu-ori.me [185.189.151.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E0E8E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mu-ori.me; s=mail;
        t=1689776097; bh=doNjO7tcmPpSniKVYRZT9aC7RhafZEp+ejgyn2bsXBs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P1ie332sv1gK4C/Q4hs1rLR6bO4+i9QSli7ORBHcITaSZwd08kKhbFhCME6iqIm03
         zyx1cp2PbTtsTZFWZ5FhsIs1K85sSTCVvrZ9ZwuXdzFfuhg2ZcwMOzr+NuxwLhkHqv
         Y6yKf9kpC/sVth7VZ9FW3kncIhPmKmTBfXDRFQs8PzxyawHcV3fTpJEx1FxGegzAeU
         RdQT8ePtjlh0GnHU+HdURatZMg0Dj8o1KBzqSt7OThw+/YffFOZbopFy/+17W70HCL
         7/7i5SIpbn2IY6cBDna2EqR6WXwxSK7piq7OquOCfQdvEB8JHPwsL0HhyX7dG9xgwr
         g7Pc0ojeB0rvg==
Received: from webm.mu-ori.me (localhost [127.0.0.1])
        by mail.mu-ori.me (Postfix) with ESMTPSA id 3ADBB628ED;
        Wed, 19 Jul 2023 14:14:57 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 14:14:57 +0000
From:   "Drew B." <subs@mu-ori.me>
To:     David Laight <David.Laight@aculab.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Misbehavior with setsockopt timeval structure with -fpack-struct
 enabled
In-Reply-To: <8049a5598fe54002851b2224ada58209@AcuMS.aculab.com>
References: <559f4003c263a7aaa873cbc80947cc57@mu-ori.me>
 <8049a5598fe54002851b2224ada58209@AcuMS.aculab.com>
Message-ID: <41150408e841274d792ef0a905ee1c52@mu-ori.me>
X-Sender: subs@mu-ori.me
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David!
Thanks for your answer. Just to feed my curiosity, why? Of course I 
could use:
#pragma pack(1, push)
...
#pragma pack(pop)
to pack only what is needed, but in the first place I was thinking about 
keeping as much free memory as possible (to make things optimized). And 
keep other things intact, but is it not a good practice placing 
-fpack-struct into compile-time params?

Kind regards,
Drew.

On 2023-07-19 13:36, David Laight wrote:
> ...
>> with -fpack-struct enabled,
> 
> Don't even think of enabling that.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, 
> MK1 1PT, UK
> Registration No: 1397386 (Wales)
