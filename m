Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EE578E8B9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241889AbjHaIt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbjHaIt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:49:27 -0400
Received: from icts-p-cavuit-1.kulnet.kuleuven.be (icts-p-cavuit-1.kulnet.kuleuven.be [134.58.240.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378A8CF4;
        Thu, 31 Aug 2023 01:49:23 -0700 (PDT)
X-KULeuven-Envelope-From: jo.vanbulck@cs.kuleuven.be
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 7689A20170.ACE4E
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-ceifnet-smtps-1.kuleuven.be (icts-p-ceifnet-smtps.service.icts.svcd [IPv6:2a02:2c40:0:51:132:242:ac11:16])
        by icts-p-cavuit-1.kulnet.kuleuven.be (Postfix) with ESMTP id 7689A20170;
        Thu, 31 Aug 2023 10:49:21 +0200 (CEST)
BCmilterd-Mark-Subject: no
BCmilterd-Errors: 
BCmilterd-Report: SA-HVU#DKIM_VALID#0.00,SA-HVU#DKIM_VALID_AU#0.00,SA-HVU#DKIM_SIGNED#0.00
X-CAV-Cluster: smtps
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.kuleuven.be;
        s=cav; t=1693471761;
        bh=+Dd9+kl2ngd6SZdzUe+SZnk27FFohb+kVDY1244NPjI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=KJ9+dRNBHEfBHdjx7An4RefVN9Vgu20euJhI/SZz95SNBQ0uSX4vs6G0mMKYJA/63
         C2UPIXRqIVElrU2SE+cllE/CXxGQhV02Fyhbnj7AN/3LJqj/utcpHnYfUns8krG+aX
         OYaADWxRZ/ZqqvjeleGf9C6revCUDO9t8bn/nBpw=
Received: from [IPV6:2a02:1811:d31:8b00:7de6:eac8:3ad6:e6b8] (ptr-82s0fs7jt2487ph2gu0.18120a2.ip6.access.telenet.be [IPv6:2a02:1811:d31:8b00:7de6:eac8:3ad6:e6b8])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by icts-p-ceifnet-smtps-1.kuleuven.be (Postfix) with ESMTPSA id 3C835D4EA0521;
        Thu, 31 Aug 2023 10:49:21 +0200 (CEST)
Message-ID: <ca765c3a-8457-81f0-614d-4165579bf034@cs.kuleuven.be>
Date:   Thu, 31 Aug 2023 10:49:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 02/13] selftests/sgx: Produce static-pie executable for
 test enclave
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20230825133252.9056-1-jo.vanbulck@cs.kuleuven.be>
 <20230825133252.9056-3-jo.vanbulck@cs.kuleuven.be>
 <8eeec322fa4c85749c05dcbc570ac385d8ad88b6.camel@intel.com>
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
In-Reply-To: <8eeec322fa4c85749c05dcbc570ac385d8ad88b6.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.23 12:55, Huang, Kai wrote:> Could you please add the linker 
error (as you mentioned in the v3) to the
> changelog to justify this code change?

Makes sense, done.

> And sigh.. I still don't quite understand why linker complains
> 
> 	lea	(encl_stack)(%rbx), %rax
> 
> because ....
> 
>>   	jmp encl_entry_core
>>   encl_dyn_entry:
>>   	# Entry point for dynamically created TCS page expected to follow
> 
> we have a
> 
> 	lea -1(%rbx), %rax
> 
> right here.
> 
> Can't the compiler/linker just treat it as an immediate just like -1?  :-(

I think the linker complains because with -static-pie -fPIE afaik all 
local symbols need to have RIP-relative addressing "encl_stack(%rip)".

Best,
Jo
