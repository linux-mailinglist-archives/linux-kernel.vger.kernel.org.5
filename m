Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1DF7A1FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbjION3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235281AbjION3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:29:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1038718D;
        Fri, 15 Sep 2023 06:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1694784578;
        bh=lXjvd3TJSQ6cqva6/5eqdL2+87WjyD9vjXEISda8nlY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qScOy0tOOQA6fnha+GtlosxQosWFpa5yzcf4gN/iBxpHFGLtceVHASAO5f8N/A246
         EJF4P1xx5SfWr9sFNEVugnBpmH8/r7dVMPze1lFIHaFYTwADXAG6BpX4iyvYoYSkRG
         oZMXwT0cTcFYnEbbINP7WafKHzB482xLt+zmv2tfk2iAKrPxFogFcN4AwbCFslCS2/
         4iMwrYwffQ/6DzrxZjr5O/AGw4rv7/U7CFa9b4/od9odeGx9ZIkZgf2Hxu1W1YA7Y5
         ry7p9r+oQ8Bl14KOojwwKhVIFYfcyqeyTAbDSM/dOP8psV7P3y8qw5vy2CKuo85pyR
         w3eIK9le5FNyA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RnFR62VCtz4wxd;
        Fri, 15 Sep 2023 23:29:38 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Danny Tsen <dtsen@linux.ibm.com>, linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ltcgcw@linux.vnet.ibm.com, dtsen@us.ibm.com,
        Danny Tsen <dtsen@linux.ibm.com>
Subject: Re: [PATCH v2] crypto: vmx: Improved AES/XTS performance of 6-way
 unrolling for ppc.
In-Reply-To: <20230830134911.179765-1-dtsen@linux.ibm.com>
References: <20230830134911.179765-1-dtsen@linux.ibm.com>
Date:   Fri, 15 Sep 2023 23:29:33 +1000
Message-ID: <8734zf7ef6.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Danny Tsen <dtsen@linux.ibm.com> writes:
> Improve AES/XTS performance of 6-way unrolling for PowerPC up
> to 17% with tcrypt.  This is done by using one instruction,
> vpermxor, to replace xor and vsldoi.
>
> The same changes were applied to OpenSSL code and a pull request was
> submitted.

https://github.com/openssl/openssl/pull/21812

Still unmerged as of today.

cheers
