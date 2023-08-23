Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211D778586B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbjHWM7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbjHWM7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:59:04 -0400
Received: from icts-p-cavspool-1.kulnet.kuleuven.be (icts-p-cavspool-1.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EE01705;
        Wed, 23 Aug 2023 05:58:12 -0700 (PDT)
Received: from icts-p-cavuit-4.kulnet.kuleuven.be (icts-p-cavuit-4.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:134])
        by icts-p-cavspool-1.kulnet.kuleuven.be (Postfix) with ESMTP id 69E0C2952;
        Wed, 23 Aug 2023 14:58:07 +0200 (CEST)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 1E13151.AF512
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:132:242:ac11:16])
        by icts-p-cavuit-4.kulnet.kuleuven.be (Postfix) with ESMTP id 1E13151;
        Wed, 23 Aug 2023 14:57:46 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_SIGNED#0.00,SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1692795466;
        bh=XLJ9oEsCm2dJliTwA4R+B1kkN/Uf4BYwyIvpoBcqa6M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=g9mTYT4UR2iae7hS7IBjMyDVHORonS5LI6IQFx2ZIGq+60PKq5dRnljL7U3UAfKb9
         g8dEEn2BpCFGqhAqRKBkNhI9C3tL+km6lmynYeAkR1I5MH3ThdP4zWIr76IXDkpdBx
         xdr1UTr59+qOj9A8iut3jH0tWvwLDzqMn25AXgiE=
Received: from [IPV6:2a02:1811:d31:8b00:6a8c:3ab2:9886:5378] (ptr-82s0fs797m4gxnd4pko.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:6a8c:3ab2:9886:5378])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id D6034D4EBA1A7;
        Wed, 23 Aug 2023 14:57:45 +0200 (CEST)
Message-ID: <819a5450-127b-ecd2-ac01-c58e848fba1d@cs.kuleuven.be>
Date:   Wed, 23 Aug 2023 14:57:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 9/9] selftests/sgx: Specify freestanding environment
 for enclave compilation
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, kai.huang@intel.com,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com
References: <20230819094332.8535-1-jo.vanbulck@cs.kuleuven.be>
 <20230819094332.8535-10-jo.vanbulck@cs.kuleuven.be>
 <CUYZSZWSDUHC.2QB1Z9GD76HF6@suppilovahvero>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <CUYZSZWSDUHC.2QB1Z9GD76HF6@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.23 12:14, Jarkko Sakkinen wrote:
> Do you still need nostdfiles and nostartfiles with freestanding?

Thanks, good question. I tested that compiling with only -ffreestanding 
yields:

/* snipped */
/usr/local/bin/ld: 
/usr/lib/gcc/x86_64-linux-gnu/9/../../../x86_64-linux-gnu/rcrt1.o: in 
function `_start':
(.text+0x24): undefined reference to `main'
/* snipped */

So we definitely still need -nostartfiles to prevent the compiler/linker 
from introducing the standard system startup functions. However, in my 
understanding, -nostdlib (which is what I assume you mean with 
nostdfiles) already implies the individual options -nodefaultlibs and 
-nostartfiles.

Thus, we definitely still need -nostartfiles and I'm not 100% sure we 
don't need -nostdlib (though it compiles fine for me with only 
-nostartfiles). Gcc only specifies:

-ffreestanding
Assert that compilation targets a freestanding environment.  This 
implies -fno-builtin. A freestanding environment is one in which the 
standard library may not exist, and program startup may not necessarily 
be at "main".

Bottom line: I suggest to keep -nostdlib to be sure and remove 
-nostartfiles (as it is redundant). I'll include this in the next  patch 
iteration.

Best,
Jo

