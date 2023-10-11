Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE62D7C54F5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjJKNJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjJKNJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:09:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD38A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:09:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697029785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ukHBjWe9BEjJdhdsHoBpWRY0IShWSvasiVUT5USEBB0=;
        b=EtPW3gLphi22K401ncNlj+K3wTaYGCDyMJUwYDsNAx8NAPEnKsEOIVG6JGN7LJPnBiAuxY
        erUbjx0uUQHQojZ5YULHBxypqmKxS44DksQWMVkxKLJyyx6440qdwAWicJ+ivMpiCetY8P
        S4U1NwQbAwTKA5pXnNu6hNzi0LYi5khxIskM0vn0ra7QIEPP2OKp0eUwQGrkih912a3MTJ
        q/zs7qmN+klRS9wzeKPVXU+UZPBjGgVKYdBkjFcRT488BTOn83bjD4/XNXV0r2ST/M7+i0
        dN7hIKDcL1b7Jk6Nqhh62Fn78/E262XYAu8IxOAj/ARAm+r3mkPupMtXiiJPfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697029785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ukHBjWe9BEjJdhdsHoBpWRY0IShWSvasiVUT5USEBB0=;
        b=tqca0/uvwz2DGA34PwCnpcObQzD0u+u480E5bj3LsbusevevC0OfpZdCdHvaSoLZTaEbPX
        gt8XUM5WwX0AHADQ==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 03/13] cpu/hotplug, x86/acpi: Disable CPU hotplug for
 ACPI MADT wakeup
In-Reply-To: <20231005131402.14611-4-kirill.shutemov@linux.intel.com>
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-4-kirill.shutemov@linux.intel.com>
Date:   Wed, 11 Oct 2023 15:09:45 +0200
Message-ID: <87fs2hl2zq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05 2023 at 16:13, Kirill A. Shutemov wrote:
>  
> +	/* Disable CPU onlining/offlining */

That's not what the function does.

> +	cpu_hotplug_not_supported();

Thanks,

        tglx
