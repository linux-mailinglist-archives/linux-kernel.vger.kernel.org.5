Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10466767676
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbjG1Tko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbjG1Tkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:40:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CEE422C;
        Fri, 28 Jul 2023 12:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2368B621DF;
        Fri, 28 Jul 2023 19:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453DBC433C9;
        Fri, 28 Jul 2023 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690573231;
        bh=qJSSXg7Vv8HfsIe6IzeuukyvrA8LHNwx15c3kihE4MY=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=u02bMwQYkSQgP5ED1FN0HqlsYwUM4SznWO+fxaXJvlcV7S5o+37OM8TrjoODwoxn2
         /2cSmEOn7JTnOSKFb7iBplxH6p+ZVAXJrp63KXeO4A67sr7XBP/ckvW4Gi8PsJrZ7i
         NNU0RH7/DrS9tq3aT27rNYkzYkPjojU9+iau3j+ASB/LgkcbG/2FCzSBt3CS1QIAYW
         YGXUkgOYqzbsKltBsbO3rPGuWZRb7dZ2cGdieLUoa1xnIWmnkA+sFARiropO2fooaN
         0H5bVmOw9ribjWF/PXMlV89rkzIe8iLrPZxyQ9yexIG9i+87ddJH7fwdnne642pk5c
         XS1eDId1tA63w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 28 Jul 2023 19:40:27 +0000
Message-Id: <CUE26Z3BST2Z.3OTO2IP6Y5PFV@seitikki>
Cc:     "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Dionna Amalie Glaze" <dionnaglaze@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Samuel Ortiz" <sameo@rivosinc.com>, <peterz@infradead.org>,
        <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] keys: Introduce tsm keys
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Dan Williams" <dan.j.williams@intel.com>, <dhowells@redhat.com>
X-Mailer: aerc 0.14.0
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com> <169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jul 28, 2023 at 7:30 PM UTC, Dan Williams wrote:
> One of the common operations of a TSM (Trusted Security Module) is to
> provide a way for a TVM (confidential computing guest execution
> environment) to take a measurement of its run state and use that with a
> key-exchange protocol to establish a shared secret with a third-party /
> remote attestation agent. The concept is common across TSMs, but the

This is obfuscated "white paper" alike language.

I have no idea what TSM's and TVM's are and I do not want to know. Even
confidential computing is useless buzzword in the context of providing
a key type for attestation.

I would replace "tsm" with "attestation".

BR, Jarkko
