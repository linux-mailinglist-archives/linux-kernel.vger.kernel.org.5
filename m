Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C145E7680EC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 20:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjG2SR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 14:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjG2SRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 14:17:24 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2A52723;
        Sat, 29 Jul 2023 11:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1690654641;
        bh=h5IfinV0go2IJt6uz9MUW3cuAh/IHb80AxpLJZogiEA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=r9ACkFQJbUkVzN2cXL4f5hHR2nJvxeh1m6dsqEk6p49m5mkyejozaDoB5abuVpTue
         RWpUHOaHrjTshCNLUBjF3Pu4n38tdgoahXYxhPAOPlGEbKF3rzk+bCaTR/yAd6hvX3
         /GaKZ8OaAmjYY3k9XUI6zQT1tQ2TUKXJ3UL4EeFQ=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 36D7B1281747;
        Sat, 29 Jul 2023 14:17:21 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id cMMexv2ufveb; Sat, 29 Jul 2023 14:17:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1690654641;
        bh=h5IfinV0go2IJt6uz9MUW3cuAh/IHb80AxpLJZogiEA=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=r9ACkFQJbUkVzN2cXL4f5hHR2nJvxeh1m6dsqEk6p49m5mkyejozaDoB5abuVpTue
         RWpUHOaHrjTshCNLUBjF3Pu4n38tdgoahXYxhPAOPlGEbKF3rzk+bCaTR/yAd6hvX3
         /GaKZ8OaAmjYY3k9XUI6zQT1tQ2TUKXJ3UL4EeFQ=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BE7A01281269;
        Sat, 29 Jul 2023 14:17:19 -0400 (EDT)
Message-ID: <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dan Williams <dan.j.williams@intel.com>, dhowells@redhat.com
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 29 Jul 2023 14:17:18 -0400
In-Reply-To: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-28 at 12:30 -0700, Dan Williams wrote:
> The bulk of the justification for this patch kit is in "[PATCH 1/4]
> keys: Introduce tsm keys". The short summary is that the current
> approach of adding new char devs and new ioctls, for what amounts to
> the same functionality with minor formatting differences across
> vendors, is untenable. Common concepts and the community benefit from
> common infrastructure.

I agree with this, but ...

> Use Keys to build common infrastructure for confidential computing
> attestation report blobs, convert sevguest to use it (leaving the
> deprecation question alone for now), and pave the way for tdx-guest
> and the eventual risc-v equivalent to use it in lieu of new ioctls.
> 
> The sevguest conversion is only compile-tested.
> 
> This submission is To:David since he needs to sign-off on the idea of
> a new Keys type, the rest is up to the confidential-computing driver
> maintainers to adopt.

So why is this a keys subsystem thing?  The keys in question cannot be
used to do any key operations.  It looks like a transport layer for
attestation reports rather than anything key like.

To give an analogy with the TPM: We do have a TPM interface to keys
because it can be used for things like sealing (TPM stores a symmetric
key) and even asymmetric operations (although TPM key support for that
in 1.2 was just removed).  However, in direct analogy with confidential
computing: the TPM does have an attestation interface: TPM2_Quote and
TPM2_Certify (among others) which is deliberately *not* wired in to the
keys subsystem because the outputs are intended for external verifiers.

If the goal is to unify the interface for transporting attestation
reports, why not pull the attestation ioctls out of sevguest into
something common?

I also don't see in your interface where the nonce goes?  Most
attestation reports combine the report output with a user supplied
nonce which gets added to the report signature to defend against
replay.

Finally, I can see the logic in using this to do key release, because
the external relying entity usually wishes to transport secrets into
the enclave, but the currently developing use case for that seems to be
to use a confidential guest vTPM because then we can use the existing
TPM disk key interfaces.  Inventing something completely new isn't
going to fly because all consumers have to be updated to use it (even
though keys is a common interface, using key payloads isn't ... plus
the systemd TPM disk encryption key doesn't even use kernel keys, it
unwraps in userspace).

James

