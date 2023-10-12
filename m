Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561B07C785F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 23:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442831AbjJLVG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 17:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442643AbjJLVG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 17:06:56 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AADA9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 14:06:53 -0700 (PDT)
Received: from [IPV6:2601:646:9a00:1821:7c45:267e:5aad:82e7] ([IPv6:2601:646:9a00:1821:7c45:267e:5aad:82e7])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 39CL5pvr1848458
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 12 Oct 2023 14:05:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 39CL5pvr1848458
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023091101; t=1697144752;
        bh=ysnLFQZInQJMkyXvu4T440l0cKiHTOm5vno6/SZClRU=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=AHDJzDUSaTGeTjCUadg3ZNnOjmq8H9Y1SN0oUYx7EgqWknIFbRo7RTL8IF8AyMoBN
         o2LqlZzHuVcFFxWmyfvMqXe8Q3oJ+Xfm1sAOUd1S498wB0fpdRb+dGGWjThtwf1aPk
         uI6N7Jx8GDd10wtIytif9OsRMEY63Ur1nFKx5lrHLATbcdfjRccs1Kn2Z1IrjkAHOG
         vLwRVNuubYTYXqjPSB/ppZgNEWChRLQuFKHMKLkEk/FWao8pykF5tIFcQfwBkcaYM3
         oECpqgNucwQlQ6+agy7vQpP+M006/oI3B0Fm3c08A4wuWZi5p+LyHdln2LsXSpeG2a
         /DrNIikWMSVkA==
Message-ID: <19a92ce0-742b-4bb4-8564-1e20a4dcf2c0@zytor.com>
Date:   Thu, 12 Oct 2023 14:05:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] x86/percpu: Use explicit segment registers in
 lib/cmpxchg{8,16}b_emu.S
Content-Language: en-US
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20231012161237.114733-1-ubizjak@gmail.com>
 <20231012161237.114733-2-ubizjak@gmail.com>
 <E2A4E3BD-10C1-43F7-AD6D-1037C7106F8B@zytor.com>
In-Reply-To: <E2A4E3BD-10C1-43F7-AD6D-1037C7106F8B@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/23 14:02, H. Peter Anvin wrote:>
> %fs??
 >

Nevermind, I forgot that we changed from %gs to %fs on i386 at some 
point in the now-distant past.

	-hpa
