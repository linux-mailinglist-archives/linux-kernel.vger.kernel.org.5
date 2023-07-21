Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617DC75BF4D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjGUHFH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jul 2023 03:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjGUHFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:05:03 -0400
Received: from frasgout12.his.huawei.com (ecs-14-137-139-154.compute.hwclouds-dns.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9757A270B;
        Fri, 21 Jul 2023 00:05:01 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4R6gFz4FnMz9xtVW;
        Fri, 21 Jul 2023 14:51:51 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAn3ELoLbpkla7NBA--.21454S2;
        Fri, 21 Jul 2023 08:04:22 +0100 (CET)
Message-ID: <21cd4127cee2d920ffab7576e9a6359ec0988b8d.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH v3 0/9] KEYS: Introduce user asymmetric keys and
 signatures
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, pbrobinson@gmail.com,
        zbyszek@in.waw.pl, wiktor@metacode.biz,
        devel@lists.sequoia-pgp.org, gnupg-devel@gnupg.org,
        ebiggers@kernel.org, Jason@zx2c4.com, mail@maciej.szmigiero.name,
        antony@vennard.ch, konstantin@linuxfoundation.org,
        James.Bottomley@HansenPartnership.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 21 Jul 2023 09:04:04 +0200
In-Reply-To: <CU76KX3XPZN9.V9GU2ZZKVKO@suppilovahvero>
References: <20230720153247.3755856-1-roberto.sassu@huaweicloud.com>
         <CU76KX3XPZN9.V9GU2ZZKVKO@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-CM-TRANSID: GxC2BwAn3ELoLbpkla7NBA--.21454S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF47Zry8XF1DXF48KFWrGrg_yoW8uF13pa
        yrKr93GFyktw1fAr9rJw4qy3y5Cwn3Jw45G3s8t3yFvw4YgFyIvryfK3WYgFZ0kws3Wryj
        vrW3Wry7Xa98Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAkuxUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBF1jj5DBXwAAs-
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-07-20 at 20:38 +0300, Jarkko Sakkinen wrote:
> On Thu Jul 20, 2023 at 6:32 PM EEST, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Define a new TLV-based format for keys and signatures, aiming to store and
> 
> "type-length-value (TLV) based"

Ok.

> > use in the kernel the crypto material from other unsupported formats
> > (e.g. PGP).
> 
> Where's the motivation part and where is this defined?

Ah, thanks for the reminder. Will add it in the next version.

The motivations are:

- Avoid adding complex parsers in the kernel that might introduce
  vulnerabilities
- Avoid adding support for key and signature formats that some consider
  weak

That was basically the summary of the review of my attempt to add
support for PGP keys and signatures in the kernel.

This patch set adds support for only one format, which other formats
are converted from.

This is useful for the mere extraction of crypto material, and use it
with the kernel crypto API.

If there is a trust relationships between the original keys, converting
keys would lose the ability to verify that trust relationship.


Example

Suppose that there is a PGP key in the built-in keyring, and that
signed another PGP key.

If I want to add the second PGP key to the secondary keyring, I would
have to verify the signature of that key with the first key.

But the signature is on a PGP packet, so if the kernel verifies that
signature it would have also to ensure that the public key extracted
from the signed packet is the same as the converted key.

Originally I thought that we could do the conversion in a fully
isolated user space process (trustworthy User Mode Driver), so that
there is the guarantee that the key has not been modified during the
conversion. However, since it is difficult to achieve perfect
isolation, that approach has been put on hold.

So, at the moment, verifying trust with user asymmetric keys is not
possible, but this is not a problem with my use case, as a Linux
distributions can embed in the kernel all their (converted) public keys
directly usable for signature verification.

Thanks

Roberto

