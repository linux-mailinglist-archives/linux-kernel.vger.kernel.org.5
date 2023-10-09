Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546FE7BE243
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377601AbjJIOOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376918AbjJIOOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006548E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696860816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TtAr6vMHSkU1o8N9xFJERXPEAH/eUDbPVOnY1/d3q0M=;
        b=O+60ygEICjNQViaOD+wfaarkAu6PEPJWpVq3f7GIvHghyuIoAg1fxvofr6N8EwaQyFpX2g
        DVloX+Q5I1/WS/VaWJeDE/Ja24GqUqfVETB5bkarVo4zjoIToy76YiMethp4FnoOgRbYNn
        FQBk5NfM1c+Wkz7OrfikfICLnJIOTLE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-1ORgyTEpN9-o7KLkB5trKw-1; Mon, 09 Oct 2023 10:13:15 -0400
X-MC-Unique: 1ORgyTEpN9-o7KLkB5trKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDD5881D787;
        Mon,  9 Oct 2023 14:13:14 +0000 (UTC)
Received: from localhost (unknown [10.72.112.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1498240C6EBF;
        Mon,  9 Oct 2023 14:13:13 +0000 (UTC)
Date:   Mon, 9 Oct 2023 22:13:10 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] x86/tdx: Add kexec support
Message-ID: <ZSQKdrP9VE96eDxg@MiWiFi-R3L-srv>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <ZSNADxBZEDyxEnZ4@MiWiFi-R3L-srv>
 <20231009133655.3aqi4kwx7wtqgqtm@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009133655.3aqi4kwx7wtqgqtm@box.shutemov.name>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/23 at 04:36pm, Kirill A. Shutemov wrote:
> On Mon, Oct 09, 2023 at 07:49:35AM +0800, Baoquan He wrote:
> > On 10/05/23 at 04:13pm, Kirill A. Shutemov wrote:
> > > The patchset adds bits and pieces to get kexec (and crashkernel) work on
> > > TDX guest.
> > > 
> > > They bring kexec support to the point when we can start the new kernel,
> > > but it will only be able to use single CPU. It should be enough to cover
> > > the most common case: crashkernel.
> > 
> > Not sure if this question has been raised and answered in the past. Please
> > forgive my bad memory if it has. The one cpu is fine to kdump kernel most
> > of time, while we enable all CPUs by default when kexec rebooting. And kdump
> > kernel with multiple cpu is allowed too. Wondering if there's plan to
> > support the multiple cpu on TDX in the future.
> 
> Sorry, I didn't update this part of cover letter properly, but the last
> patch of the patchset makes possible to kexec with multiple CPUs and the
> 2nd kernel will see them all. It requires support on BIOS side, otherwise
> we fallback to single CPU kexec.

Oops, I didn't read them carefully. You have mentioned that in the last
paragraph of cover letter. That's a great news, thanks.

