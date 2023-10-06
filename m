Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCE67BB2F2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjJFIVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjJFIU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:20:59 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BEDE9;
        Fri,  6 Oct 2023 01:20:58 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qog4t-0006XM-43; Fri, 06 Oct 2023 10:20:55 +0200
Message-ID: <9ffdce44-c1ca-4587-bcae-4bd1ebb52f61@leemhuis.info>
Date:   Fri, 6 Oct 2023 10:20:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dm crypt: Fix reqsize in crypt_iv_eboiv_gen
Content-Language: en-US, de-DE
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        =?UTF-8?Q?Tatu_Heikkil=C3=A4?= <tatu.heikkila@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Device Mapper <dm-devel@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
References: <f1b8d8f5-2079-537e-9d0f-d58da166fe50@gmail.com>
 <ZR9dEiXhQv-wBVA2@debian.me> <ZR9l446ndB4n1Xl4@gondor.apana.org.au>
 <ZR9wRq7Rkz+LocDX@redhat.com> <ZR9x6ifhd6axh5Ki@gondor.apana.org.au>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZR9x6ifhd6axh5Ki@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1696580458;7dcc8313;
X-HE-SMSGID: 1qog4t-0006XM-43
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.23 04:33, Herbert Xu wrote:
> On Thu, Oct 05, 2023 at 10:26:14PM -0400, Mike Snitzer wrote:

BTW, Herbert, thx for taking care of this quickly!

>> Sure, please do.  Shouldn't your header Cc: stable given that the
>> Fixes commit implies v6.5 needs this fix?
> 
> Sure I'll add it although it will be picked up automatically due
> to the Fixes header.

FWIW, as some people don't know this: that might be the case, but there
is no guarantee, hence it's better to add it:

https://lore.kernel.org/all/2023060703-colony-shakily-3514@gregkh/

>  I'll also fix the reporter's name.

Side note: a Link: or Closes: tag to the report
(https://lore.kernel.org/all/f1b8d8f5-2079-537e-9d0f-d58da166fe50@gmail.com/
) would be nice as well.

Thx again. Ciao, Thorsten
