Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0958A75F362
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjGXKdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjGXKdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:33:41 -0400
Received: from icts-p-cavuit-2.kulnet.kuleuven.be (icts-p-cavuit-2.kulnet.kuleuven.be [134.58.240.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4B2119;
        Mon, 24 Jul 2023 03:33:31 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 54F1320062.A6DE3
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-0.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:143:242:ac11:20])
        by icts-p-cavuit-2.kulnet.kuleuven.be (Postfix) with ESMTP id 54F1320062;
        Mon, 24 Jul 2023 12:33:28 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1690194808;
        bh=iEWM/U7XJeC7LTrkw7I5xQFeOhyqNfXeOcVNZvirnxg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Z1OufVE0PeubQFzjUurD9ZPdK+YNUuZ/7pfs49Zd+64KW+dbXJIaCcMqtwaaO9ezN
         9w4FffcaKWh006fZtrQWe5UD4HcOeW7Z77gdq2E4Fr1JdwzqcTSZLP4F+q/99Lrj0b
         CRuJCBacFTYeW28gnDjMaeJrwKeNULH4wYNt2qcY=
Received: from [192.33.197.126] (eduroam-269-1-126.epfl.ch [192.33.197.126])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-0.kuleuven.be (Postfix) with ESMTPSA id 0E40CD4E6AF08;
        Mon, 24 Jul 2023 12:33:28 +0200 (CEST)
Message-ID: <1805e583-6986-79ff-36b1-7b71e32e6eb0@cs.kuleuven.be>
Date:   Mon, 24 Jul 2023 12:33:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/4] selftests/sgx: Harden test enclave
To:     Dave Hansen <dave.hansen@intel.com>, jarkko@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com
References: <20230720221623.9530-1-jo.vanbulck@cs.kuleuven.be>
 <da0cfb1e-e347-f7f2-ac72-aec0ee0d867d@intel.com>
Content-Language: en-US
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <da0cfb1e-e347-f7f2-ac72-aec0ee0d867d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.07.23 02:24, Dave Hansen wrote:
> I wholeheartedly agree with the desire to spin up enclaves without the
> overhead or complexity of the SDK.  I think I'm the one that asked for
> this test enclave in the first place.  There *IS* a gap here.  Those who
> care about SGX would be wise to close this gap in _some_ way.
> 
> But I don't think the kernel should be the place this is done.  The
> kernel should not be hosting a real-world (userspace) SGX reference
> implementation.

Okay, makes sense.

> I'd fully support if you'd like to take the selftest code, fork it, and
> maintain it.  The SGX ecosystem would be better off if such a project
> existed.  If I can help here in some way like (trying to) release the
> SGX selftest under a different license, please let me know.

Thank you! I agree this would benefit the SGX ecosystem and I'll go 
ahead with further developing such a standalone fork when I find time 
probably in the next month or so. For future reference, in case people 
end up reading this discussion thread, I created a placeholder (atm 
emtpy) repo here:

https://github.com/jovanbulck/bare-sgx

Re licensing: no need to re-license, I think GPL would be the best 
license for such a project anyway.

> The only patches I want for the kernel are to make the test enclave more
> *obviously* insecure.

Makes sense. I'll see if I can create a new proposed minimal patch in 
this spirit (e.g., removing existing register cleansing and adding an 
explicit comment) to take away any misguided impression that the test 
enclave would be a representative example of secure code and make its 
real purpose clearer.

> So, it's a NAK from me for this series.  I won't support merging this
> into the kernel.  But at the same time, I'm very sympathetic to your
> cause, and I do appreciate your effort here.

Thank you, appreciated!
