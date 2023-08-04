Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91617705CF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjHDQUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHDQU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE34170F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691165979;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=Onl29uqYKQczYTkd1xGh14ew9gorV8noJaPJyrbKPr0=;
        b=iWvYqIwxVq4UcF1a3G2oZPoGKpqsJmDKkMbKrJejZUUK7k7eBACGltnd5S4M8P0Zqb3x7P
        Kw7nqfvrjPA2SUKQFQtUiPlzVuHf87gfIT+RZx1TnE2sXP/HH4lnYM0uXJ/5c4JDGndRgo
        KdImHhSc/Qf0xG3vC2CqRYBHEIC8VbI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-K9vtuh7SNyya7lbxdn1nIw-1; Fri, 04 Aug 2023 12:19:36 -0400
X-MC-Unique: K9vtuh7SNyya7lbxdn1nIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0888280D59E;
        Fri,  4 Aug 2023 16:19:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A59A9200A7CA;
        Fri,  4 Aug 2023 16:19:32 +0000 (UTC)
Date:   Fri, 4 Aug 2023 17:19:30 +0100
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Message-ID: <ZM0lEvYJ+5IgybLT@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
 <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
 <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
 <6dec442c64faf2fecd21bcc77e4a6350e88948b9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6dec442c64faf2fecd21bcc77e4a6350e88948b9.camel@intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 11:45:12AM +0000, Huang, Kai wrote:
> The IOCTL vs /sysfs isn't discussed.
> 
> For instance, after rough thinking, why is the IOCTL better than below approach
> using /sysfs?
> 
> echo <REPORTDATA> > /sys/kernel/coco/tdx/attest/reportdata
> cat /sys/kernel/coco/tdx/attest/tdreport
> 
> Each "echo <REPORTDATA>" to '/sys/.../reportdata' triggers the driver to call
> TDCALL to get the TDREPORT, which is available at '/sys/.../tdreport'.

What would you suggest as behaviour with multiple processes writing
into 'reportdata' and trying to read from 'tdreport' in parallel ?
Splitting input and output across separate files removes any
transactional relationship between input and output. This approach
feels like it could easily result in buggy behaviour from concurrent
application usage, which would not be an issue with ioctl()

Also note, there needs to be scope for more than 1 input and 1 output
data items. For SNP guests, the VMPL is a input, and if fetching a
VMPL 0 report from under SVSM [1], an optional service GUID is needed.
With SVSM, there are three distinct output data blobs - attestation
report, services manifest and certificate data.

With regards,
Daniel

[1] https://www.amd.com/system/files/TechDocs/58019_1.00.pdf
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

