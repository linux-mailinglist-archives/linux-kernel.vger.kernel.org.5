Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A65A7706DC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjHDRMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjHDRMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:12:14 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328BE3C25;
        Fri,  4 Aug 2023 10:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691169130;
        bh=k/zttB4T2CScg/JHkOSPHBwHh+YE9cWs+BwYyqLser4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=f9JvpJ3sVW4hPdpdMkW4G4H1qY0MpkDXtZ0kkXJLBYf0bDQlpQXP2PrpRVwO/wyeR
         V3KDEaKYOk+4l4rD7s26qs/AH6aCmJxFWUQduLByK+kWstN0O052ISCkVqiIaCIbnG
         3ue1706uRljJyiQxRS7volAr5dsgXsw7w75kz5ak=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 7BF151280EA0;
        Fri,  4 Aug 2023 13:12:10 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id fzGcu-YakGz3; Fri,  4 Aug 2023 13:12:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1691169130;
        bh=k/zttB4T2CScg/JHkOSPHBwHh+YE9cWs+BwYyqLser4=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=f9JvpJ3sVW4hPdpdMkW4G4H1qY0MpkDXtZ0kkXJLBYf0bDQlpQXP2PrpRVwO/wyeR
         V3KDEaKYOk+4l4rD7s26qs/AH6aCmJxFWUQduLByK+kWstN0O052ISCkVqiIaCIbnG
         3ue1706uRljJyiQxRS7volAr5dsgXsw7w75kz5ak=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 387A512804B6;
        Fri,  4 Aug 2023 13:12:09 -0400 (EDT)
Message-ID: <35071cffb4acb117f1b4be2807c40792734bff89.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/4] keys: Introduce tsm keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Gonda <pgonda@google.com>, dhowells@redhat.com,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, peterz@infradead.org,
        linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 04 Aug 2023 13:12:07 -0400
In-Reply-To: <CAAH4kHaq0q0jGmpxskapo2J+oeWWBXuDd7RfgppO31+gnPSL6w@mail.gmail.com>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
         <169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com>
         <CAMkAt6ot9zyUL9Ub-qYq+d9v-6rTft4ea2mUxp3o1s3GVFq7nw@mail.gmail.com>
         <CUHEL5OD3UR8.FRBWNF6MTP1Y@suppilovahvero>
         <64cc650233ef9_782a329489@dwillia2-xfh.jf.intel.com.notmuch>
         <CAAH4kHY_SjTdh55NBWn1KURCdjJUDM7nhi_gLpUhKKbRsVjX4Q@mail.gmail.com>
         <66161ce56ec783d1ec452a50b80b120bec8b56e8.camel@HansenPartnership.com>
         <CAAH4kHaq0q0jGmpxskapo2J+oeWWBXuDd7RfgppO31+gnPSL6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-04 at 10:07 -0700, Dionna Amalie Glaze wrote:
> > 
> > Just on this one, it's already specified in the latest SVSM doc:
> > 
> > https://lore.kernel.org/linux-coco/a2f31400-9e1c-c12a-ad7f-ea0265a12068@amd.com/
> > 
> > The Service Attestation Data on page 36-37.  It says TPMT_PUBLIC of
> > the
> > EK.  However, what it doesn't say is *which* EK.  I already sent in
> > a
> > comment saying it should be the TCG template for the P-256 curve
> > EK.
> > 
> > So asking the SVSM to give you the attestation report for the VTPM
> > service binds the EK of the vTPM.
> > 
> 
> Yes, thanks. It sounds like you have to ask the SVSM to certify the
> EK separately from asking the TPM for a quote.

That's right.

>  We can't rely entirely on the TPM API and avoid a sev-guest device
> for talking to the SVSM.

Yes, you have to make a SVSM service attestation call initially to
validate the vTPM.

>  Or are you saying the SVSM attestation report will get encoded in
> the x.509 EK certificate that the TPM API returns, such as the report
> is in a cert extension? I'm less clear on how TPM software would
> interpret the Issuer of that cert.

There is no certificate.  It's more like the Google Cloud: the SVSM
vTPM has no EK cert, so you have to ask something else for validation
of the EK, in this case a service attestation quote from the SVSM which
confirms the binding of the current SVSM to the EK and then you use
that EK pub to verify the vTPM.

There's already experimental work to get this supported in Keylime, but
doing it properly involves making the registrar EK validation mechanism
pluggable.

James

