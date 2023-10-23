Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7BD7D41BD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjJWVc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJWVc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:32:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746AC97;
        Mon, 23 Oct 2023 14:32:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48C4C433C7;
        Mon, 23 Oct 2023 21:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698096746;
        bh=046BbSnuuWdcYPSzolRwZTbVs8gPcYCCdAkG0ebMAvU=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=qeAqI6S9asg0wCthFJZpfapBLLZDaeGI0JNWpoIYMLfrYU/+kLJAdgCs1+MyZV45G
         tshZD/TmBAsC5W9wtsNjqt65oUsIXKGvBCHYKra5ftuzB8Ll4k5A6oBOchLGWb2qth
         LMPdaQQAjDBqRVOFSbZUoxp8vhwMUWUNxSSF3ULGnO/1MCwL6YcXZ10kge7oSNxaQu
         ID3bJ3/jvZ4MVwX3biR4WSlP2PtbkBAcloaDqRRJln34sRZqayFaYpQPphbjwBtR9b
         +l00z+C4qGPcN5YApWL6U8wJhOQShW+XBu6V1rGJBzrqjQnsCLxQG/WN4+gDp+G0Z0
         297o4scJAgX9g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 24 Oct 2023 00:32:22 +0300
Message-Id: <CWG522A78YHD.37CO0T9F3FVXB@suppilovahvero>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v7 00/13] selftests/sgx: Fix compilation errors
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jo Van Bulck" <jo.vanbulck@kuleuven.be>,
        "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jo Van Bulck" <jo.vanbulck@cs.kuleuven.be>
X-Mailer: aerc 0.15.2
References: <20231005153854.25566-1-jo.vanbulck@cs.kuleuven.be>
 <119aaa2820be5dc58144e74574cfaa7777f79604.camel@intel.com>
 <f2726c67-87f7-409a-9ac2-e845249348cc@cs.kuleuven.be>
 <7e729488e2f841f384b719d0509a4f78f491d477.camel@kernel.org>
 <be63771f-080e-4832-955e-13f5b06b2010@kuleuven.be>
In-Reply-To: <be63771f-080e-4832-955e-13f5b06b2010@kuleuven.be>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Oct 13, 2023 at 2:45 PM EEST, Jo Van Bulck wrote:
> On 10.10.23 11:44, Jarkko Sakkinen wrote:
> > Folks (sorry for top posting): I've now taken my old NUC7 out of the
> > dust and tested the series :-)
> >=20
> > Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Thanks for testing this Jarkko! Not sure on next steps, do you want me=20
> to re-post the series with the Tested-by tag for all commits or will you=
=20
> add that? Let me know if something from my side is needed.

Dave, can you pick these patches to the x86 tree with my tested-by
added? Sorry for latency. It is flu season in Finland and I've been
functional varying last week because of that.

> > Off-topic: I wish both Intel and AMD straighten up and deliver some "ho=
me friendly" development hardware for the  latest stuff. Just my
> > stance but the biggest quality risk I see in both TDX and SNP is that
> > the patches are made by an enterprise and reviewed (properly) *only*
> > by other huge enterprises.
>
> Yes, I totally agree on this. It is really unfortunate that things like=
=20
> SGX are not (anymore) available on home consumer hardware and you have=20
> to buy expensive servers for this, which also change every new CPU=20
> generation. Having some kind of "developer boards" like is more the case=
=20
> in embedded systems would be a great and very welcome evolution, if only=
=20
> it were to happen..
>
> > I skim status of both from time to time but yeah not much attachment
> > or motivation to do more than that as you either need a cloud access
> > or partnership with Intel or AMD. "Indie" style seems to be disliked
> > these days... You can extrapolate from this that there must be a bunch
> > of maintainers around the Linux kernel that feel the same. Not saying
> > that particularly my contribution would be that important.
> >=20
> > Sort of even if let's say Intel would provide me a partner access I
> > might not be that interested because I prefer my own (physical)
> > computers.
>
> I also understand this and share the concern. FWIW for some things=20
> (e.g., uarch attack research) remote access does also not really hold up=
=20
> to bare-metal access IMO.
>
> Best,
> Jo

BR, Jarkko
