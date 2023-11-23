Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0D07F6211
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345940AbjKWOxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345953AbjKWOxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:53:04 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F13D5A;
        Thu, 23 Nov 2023 06:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1700751185;
        bh=kh8MN+tohcYad5prvT/b0FWzLXPRU8fWPeJHBzGWwvc=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=WBAil4xUcYdR4k7+silgIJWW/sui/d8QxHDvGmYlsyNgS4GLXMoirr7t3Dwr+PDxC
         H4+kc6UuZBOxSLAOVO23jmoenQ13e5PHr3sTGFt9Eq4Ln000dLvyQOW+tdI08nCn9Y
         ZcbGWDYho5XGDOt9dsEhnYzFCPHXIkYLSRk57KKk=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B31BF1281379;
        Thu, 23 Nov 2023 09:53:05 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Ozg8Q6Lac-23; Thu, 23 Nov 2023 09:53:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1700751185;
        bh=kh8MN+tohcYad5prvT/b0FWzLXPRU8fWPeJHBzGWwvc=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=WBAil4xUcYdR4k7+silgIJWW/sui/d8QxHDvGmYlsyNgS4GLXMoirr7t3Dwr+PDxC
         H4+kc6UuZBOxSLAOVO23jmoenQ13e5PHr3sTGFt9Eq4Ln000dLvyQOW+tdI08nCn9Y
         ZcbGWDYho5XGDOt9dsEhnYzFCPHXIkYLSRk57KKk=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 9D90212809DB;
        Thu, 23 Nov 2023 09:53:04 -0500 (EST)
Message-ID: <164a4d4434e77ba1b65624a081799a073a3aced7.camel@HansenPartnership.com>
Subject: Re: Fwd: sign-file.c:149:17: warning: implicit declaration of
 function =?UTF-8?Q?=E2=80=98ENGINE=5Fload=5Fbuiltin=5Fengines=E2=80=99?=
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dennis Clarke <dclarke@blastwave.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Kernel Keyrings <keyrings@vger.kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 23 Nov 2023 09:53:02 -0500
In-Reply-To: <e110cfff-08f9-4bbc-6b69-0d67ae6562b6@blastwave.org>
References: <1fca50c4-6d7b-4c9b-bcea-4df17e2c2e7e@gmail.com>
         <e110cfff-08f9-4bbc-6b69-0d67ae6562b6@blastwave.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-11-17 at 00:34 -0500, Dennis Clarke wrote:
> On 11/16/23 18:41, Bagas Sanjaya wrote:
> > Hi,
> > 
> > I notice a bug report on Bugzilla [1]. Quoting from it:
> > 
> <snip>
> > > Not related to
> > > https://bugzilla.kernel.org/show_bug.cgi?id=215750 but I *feel*
> > > that this code needs a hug.
> > 
> > See Bugzilla for the full thread.
> > 
> > AFAIK, this looks like a bug when the kernel is compiled against
> > custom (non-system) version of OpenSSL library.
> > 
> 
> I do not know what you could possibly mean. There is nothing "custom"
> about OpenSSL. For that matter the gcc compiler I am using was also
> built by me. Works fine. The sign-file.c source compiles fine.

This has all the hallmarks of an openssl compiled without engine
support; is the symbol OPENSSL_NO_ENGINE set?  And which distro did you
get this library from?

James

