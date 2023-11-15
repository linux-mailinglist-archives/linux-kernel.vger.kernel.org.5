Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B138D7ED607
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbjKOV1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjKOV1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:27:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3121E127;
        Wed, 15 Nov 2023 13:27:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC37C433C7;
        Wed, 15 Nov 2023 21:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700083631;
        bh=Jt1L1aPAah1jOyoVMf4tYtUHoQebBZuGPlZfdj8gZNk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=lmUYwucwDYjCWJh4fp5Zyn8GaxpDDah3MxtpIDt7EoMqZZw+0f5drxETILL2PMD+U
         W4Ju5wknmTZ0T46AvHNrj41zcnr1mLh123dzcnTLz6IEiNr/A4axU2BA+kVPFiMyS7
         T4z55U+smK6AsNG2SuPDGTxPwSa2Ne7v/Av1kV3/dabFztQiIUnmLQh34fkYVa6s5O
         5Rv0G30ys718VrVImy8Vj9XU+oa1CJ2FE4jMgGo/H1xm6ttgeO74fzHzLeWNUcqR3T
         Jq9PfWDuXtOjH4VyTQMEYL/ZgBEsTlYwdt8VTGMu0UGcY9P01scw1EZRyKZQxhg0nH
         9jyjvO+xH+80Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 15 Nov 2023 23:27:08 +0200
Message-Id: <CWZPCL3WPNIC.DUVAB7WXWHFL@kernel.org>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Dave Hansen" <dave.hansen@intel.com>,
        "Jo Van Bulck" <jo.vanbulck@kuleuven.be>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 00/13] selftests/sgx: Fix compilation errors
X-Mailer: aerc 0.15.2
References: <20231005153854.25566-1-jo.vanbulck@cs.kuleuven.be>
 <119aaa2820be5dc58144e74574cfaa7777f79604.camel@intel.com>
 <f2726c67-87f7-409a-9ac2-e845249348cc@cs.kuleuven.be>
 <7e729488e2f841f384b719d0509a4f78f491d477.camel@kernel.org>
 <be63771f-080e-4832-955e-13f5b06b2010@kuleuven.be>
 <CWG522A78YHD.37CO0T9F3FVXB@suppilovahvero>
 <55d6aa33-4ffd-4a0c-a449-63b136f5a1a9@kuleuven.be>
 <4163a276-895b-418d-aab3-5f4d8da69230@intel.com>
In-Reply-To: <4163a276-895b-418d-aab3-5f4d8da69230@intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Nov 8, 2023 at 10:46 PM EET, Dave Hansen wrote:
> On 11/8/23 12:31, Jo Van Bulck wrote:
> > Just a kind follow-up: from what I can see, this series has not been
> > merged into the x86/sgx branch of tip yet (assuming that's where it
> > should go next)?
> >=20
> > Apologies if I've overlooked anything, and please let me know if there'=
s
> > something on my end that can help!
>
> Yes, you've missed something.  For your reading pleasure:
>
> https://www.kernel.org/doc/html/latest/process/2.Process.html?highlight=
=3Dmerge%20window
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
>
> I honestly didn't even think about applying this until Jarkko said
> something on 23rd.  By that point, it was far too late for it to get
> sorted out for 6.7.  So, that puts it in the next merge window.
> Specifically:
>
> 	The release candidate -rc1 is the starting point for new
> 	patches to be applied which are targeted for the next merge
> 	window.
>
> So wait for the next -rc1, and you'll hopefully see your series get merge=
d.

OK, great, thank you Dave.

BR, Jarkko
