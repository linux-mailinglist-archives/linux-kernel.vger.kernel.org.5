Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AD477063D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjHDQqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjHDQqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:46:15 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A45A46B2;
        Fri,  4 Aug 2023 09:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691167571;
        bh=0yfjbmOQ+REYZtNteufkayqRW7eIiIL04EP9auZ+Q2g=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=cuFMIwvw/3I+GVupCiRBVy7adfCSFtuaO7dpnolQvfQICOZcHyvRIN7yKcDkt4nAr
         DfdV9stamQazk0G4HCsUvOXX9oOcHWQYttB3CQhmOd3uudfLIView5+sn/aaDZLFm8
         g3M4wzy7kIqJkQqlthE/Qd6+AxANzS/XoZMVAcx4=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6B95F1281D1D;
        Fri,  4 Aug 2023 12:46:11 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ctA5lkaDfDdb; Fri,  4 Aug 2023 12:46:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691167571;
        bh=0yfjbmOQ+REYZtNteufkayqRW7eIiIL04EP9auZ+Q2g=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=cuFMIwvw/3I+GVupCiRBVy7adfCSFtuaO7dpnolQvfQICOZcHyvRIN7yKcDkt4nAr
         DfdV9stamQazk0G4HCsUvOXX9oOcHWQYttB3CQhmOd3uudfLIView5+sn/aaDZLFm8
         g3M4wzy7kIqJkQqlthE/Qd6+AxANzS/XoZMVAcx4=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0F1BE1281747;
        Fri,  4 Aug 2023 12:46:09 -0400 (EDT)
Message-ID: <66161ce56ec783d1ec452a50b80b120bec8b56e8.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/4] keys: Introduce tsm keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Gonda <pgonda@google.com>, dhowells@redhat.com,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, peterz@infradead.org,
        linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 04 Aug 2023 12:46:08 -0400
In-Reply-To: <CAAH4kHY_SjTdh55NBWn1KURCdjJUDM7nhi_gLpUhKKbRsVjX4Q@mail.gmail.com>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
         <169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com>
         <CAMkAt6ot9zyUL9Ub-qYq+d9v-6rTft4ea2mUxp3o1s3GVFq7nw@mail.gmail.com>
         <CUHEL5OD3UR8.FRBWNF6MTP1Y@suppilovahvero>
         <64cc650233ef9_782a329489@dwillia2-xfh.jf.intel.com.notmuch>
         <CAAH4kHY_SjTdh55NBWn1KURCdjJUDM7nhi_gLpUhKKbRsVjX4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-04 at 09:37 -0700, Dionna Amalie Glaze wrote:
[...]
> 
> The coming addition of the SVSM to further isolate the guest and
> provide extra "security devices" is also something to be aware of.
> There will be a vTPM protocol and a new type of attestation that's
> rooted to VMPL0 while Linux is still in VMPL3. I don't think this
> will make sev-guest an unnecessary device though, since it's still
> undecided how the TPM hierarchy can bind itself to the hardware in a
> non-adhoc manner: there's no "attested TPM" spec to have something
> between the null hierarchy and the more persistent attestation key
> hierarchy. And TCG isn't in the business of specifying how to
> virtualize the TPM technology, so we might have to manually link the
> two together by getting the tpm quote and then doing a further
> binding operation with the sev-guest device.

Just on this one, it's already specified in the latest SVSM doc:

https://lore.kernel.org/linux-coco/a2f31400-9e1c-c12a-ad7f-ea0265a12068@amd.com/

The Service Attestation Data on page 36-37.  It says TPMT_PUBLIC of the
EK.  However, what it doesn't say is *which* EK.  I already sent in a
comment saying it should be the TCG template for the P-256 curve EK.

So asking the SVSM to give you the attestation report for the VTPM
service binds the EK of the vTPM.

James

