Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B23A76BBDF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjHASBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjHASBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:01:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AA010E;
        Tue,  1 Aug 2023 11:01:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 688CB61646;
        Tue,  1 Aug 2023 18:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE69BC433CA;
        Tue,  1 Aug 2023 18:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690912877;
        bh=4zPd/AhBmLS/qewQ1xI4eHmekkdxZX+mL0LwK6ccCG8=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=KKeZohGI1kDCR2bDYUuTAxvNkhkZGEOD4+Y1x9a7ikI9YC7gdu8OF4nprsxvsqUuO
         +CbL1iqDwilwa+YGfz7ssZMvMdJ+D1C5SIxfPnlMX0BAumiTTieHR1xY6ia4xmH6Kq
         +R13tuM8Dh9Kq+UacCOgHjUuc/J53ry7riD6PgEo+nqZgcRNOZNtXyUhD8pqRGGDpl
         +hfNR2w82Ue6EGmF6x+su0D4E25K0uImf4zsiJGutD2jIqN6avlCMw5/H6FyEZAqPN
         XDDSrJrEC9YkIXfSS1DdMBfl6N3piH3Zi2MgsXn+hSgzA7WGX59qHd51+VzQDrbf4v
         fwL3LjmZrzO+g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 01 Aug 2023 21:01:12 +0300
Message-Id: <CUHEL5OD3UR8.FRBWNF6MTP1Y@suppilovahvero>
Cc:     <dhowells@redhat.com>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Dionna Amalie Glaze" <dionnaglaze@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Samuel Ortiz" <sameo@rivosinc.com>, <peterz@infradead.org>,
        <linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] keys: Introduce tsm keys
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Peter Gonda" <pgonda@google.com>,
        "Dan Williams" <dan.j.williams@intel.com>
X-Mailer: aerc 0.14.0
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com> <169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com> <CAMkAt6ot9zyUL9Ub-qYq+d9v-6rTft4ea2mUxp3o1s3GVFq7nw@mail.gmail.com>
In-Reply-To: <CAMkAt6ot9zyUL9Ub-qYq+d9v-6rTft4ea2mUxp3o1s3GVFq7nw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jul 31, 2023 at 7:33 PM EEST, Peter Gonda wrote:
> What is the purpose of this report? What does it prove to whom? I'm a
> bit confused because it doesn't seem like there is an ability for a
> remote party to participate in a challenge and response to introduce
> any freshness into this protocol.
>
> Also shouldn't the report have a little more context into the key we
> are signing? For instance what type of public key is this? And what is
> its purpose? In your example this isn't even a valid public key.

Yeah, I agree.

It is pretty hard to even evaluate whether this should be in kernel or
could handled by the user space (perhaps with something less intrusive
added to the kernel).

With cover letter starting with not one but two three letter acronyms
that are not common vocabulary is already a red flag for me at least.

A lot more clarity is needed on what the heck this thing is anyway.

BR, Jarkko
