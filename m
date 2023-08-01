Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4747876BCEF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjHAStL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjHAStC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:49:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE0E26A3;
        Tue,  1 Aug 2023 11:48:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E1BF61698;
        Tue,  1 Aug 2023 18:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D028DC433CB;
        Tue,  1 Aug 2023 18:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690915736;
        bh=0HZwjU+YwyOL/+JNyvbdqU/UfX43VMTCczQcWWYyUnM=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=ijhk/2lZcW6Mly0MWh9MSwWTRR4WGp9hgUMjgI6qQy9OK5ljw6/L9S0YzrfFKJ/No
         IuRXT2Q0+sxmZmyUfkv7usR2QBN0Q6URdw1t2YbemybspFuoacZCit4BhoSkY6XjmY
         i45WzvXecMJEXNuHE7yLekR+P3dOGLUXiUAez+4J2bQ2A9ameQl7zV+LgyzA0R0BmD
         TWt7pFpJ1aZhrfMiLIypQoJkpSfVNxAXJkVVx0cHaQaQCNhNzGVF38u5+sY4q5nn1r
         RfctOrsqzjWXo6lTSFMvc9FgYKjSDeyWGsSjKB9BQcezXG7fVlR8ims/C1UP/lEYuc
         gMmF9rmz8xGSg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 01 Aug 2023 21:48:50 +0300
Message-Id: <CUHFLMO6MJBP.1AHYJWGAEEEKT@suppilovahvero>
To:     "Huang, Kai" <kai.huang@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Cc:     "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
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
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com> <CUE22P5RYPH3.1K05T2OCK1CN1@seitikki> <64c41aa5ba9ac_a88b29494@dwillia2-xfh.jf.intel.com.notmuch> <CUG9XAK3RNFF.GWCYLXSTWX5E@seitikki> <3ba03a0d0eafc6622eee9e485bd89d22778a7592.camel@intel.com>
In-Reply-To: <3ba03a0d0eafc6622eee9e485bd89d22778a7592.camel@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 1, 2023 at 1:41 AM EEST, Huang, Kai wrote:
> On Mon, 2023-07-31 at 10:09 +0000, Jarkko Sakkinen wrote:
> > > This facility is different, it is just aiming to unify this attestati=
on
> > > report flow. It scales to any driver that can provide the ->auth_new(=
)
> > > operation. I have the sev-guest conversion in this set, and Sathya ha=
s
> > > tested this with tdx-guest. I am hoping Samuel can evaluate it for
> > > cove-guest or whatever that driver ends up being called.
> >=20
> > What about SGX without TDX?
>
> SGX attestation is completely among userspace enclaves, and the existing =
SGX
> userspace stack has fully adopted what is needed to do attestation.  Why =
do we
> need to cover SGX?

I have no answer to that. I'm merely trying to understand what this is.

BR, Jarkko
