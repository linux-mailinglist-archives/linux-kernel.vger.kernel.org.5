Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E1575FA91
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjGXPS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjGXPSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:18:46 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE746137
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:18:45 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6897D7DA;
        Mon, 24 Jul 2023 15:18:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6897D7DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1690211924; bh=xZw/H+LWeED7vti6M1J3qcQxd7Om4IJ0vRJRFLOH1vQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=bU2UQDwpcdRJhpYxPFt0Wmzaxd7SCooKgCnpi6JtbEyNxRrc4utYR2XkeK2APeZoD
         c6qV2hrfaodOkquynb7gFzcu6LzwqlqXsvyxn4+dAPTxzTRN4yZdxp0X4hEoGSaAgu
         ZqIiGGM9Q2sRlcgsyQcvMSj8oiMQShP5ihug6ZFOz7KLO390hVUZeTXMavDEgOA+TZ
         ayKtd0JmDvbLIFshISAoIm/3jXywArpR4DHLCRMYj8Ie8Xg6FaQySI2mILVcOmhHO2
         ++5mVt8z5egrXZ1QaNuiWfz8MTiHJx8Lctn2rR8tgVayO5r5kKYAKTeC+TbMRRv6KC
         IVxvh3X9fAveg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: build warning after merge of the sound-asoc tree
In-Reply-To: <ZL6AWGiabBGyU3Dq@smile.fi.intel.com>
References: <20230713121627.17990c86@canb.auug.org.au>
 <ZK/ruOD4QFPQ3Q5q@smile.fi.intel.com>
 <ZK/w5LFanElxZazG@smile.fi.intel.com>
 <ZLES/6iNcmR7H+f7@smile.fi.intel.com>
 <20230724135858.3c1abb01@canb.auug.org.au>
 <ZL410jAw2ksuBx56@smile.fi.intel.com>
 <cbff36d5-cde7-43bd-b0d5-ede8950fd885@sirena.org.uk>
 <ZL53HkIWuE4byo+R@smile.fi.intel.com>
 <43862e72-eeb2-4670-8cd6-0e334044583d@sirena.org.uk>
 <ZL6AWGiabBGyU3Dq@smile.fi.intel.com>
Date:   Mon, 24 Jul 2023 09:18:43 -0600
Message-ID: <87zg3lbang.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> +Cc: Jon
>
> On Mon, Jul 24, 2023 at 02:11:00PM +0100, Mark Brown wrote:
>> On Mon, Jul 24, 2023 at 04:05:34PM +0300, Andy Shevchenko wrote:
>> > On Mon, Jul 24, 2023 at 01:36:53PM +0100, Mark Brown wrote:
>> 
>> > > Jon's usually fairly responsive, perhaps there's something worrying
>> > > there,
>> 
>> > Hmm... maybe my understanding of the :export: is wrong? Or what do you suggest?
>> 
>> I have no idea what any of that is doing.  I'm hoping Jon does.
>
> Okay, so far we are waiting for his reply...

Sorry, it took me a bit to reconstruct why I hadn't applied this .. the
simple fact is that it doesn't apply to docs-next.
include/linux/int_log.h doesn't exist in mainline, so the kernel-doc
directive to include from it doesn't either.  All of that is introduced
in linux-next ... so the fix really needs to take the same path that the
rest of the changes did.

I guess I'd just assumed that was going to happen and didn't reply,
apologies for that.

Feel free to add:

Acked-by: Jonathan Corbet <corbet@lwn.net>

if you feel so inclined.

Thanks,

jon
