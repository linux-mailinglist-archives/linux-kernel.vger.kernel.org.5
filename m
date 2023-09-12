Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997E479D71A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjILRDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjILRDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:03:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3B610D9;
        Tue, 12 Sep 2023 10:03:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4D0C433C7;
        Tue, 12 Sep 2023 17:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694538210;
        bh=2W640/p1T0Aq9kmII2hkn+rYKZ5SpA1fs1dP8heOBVE=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=twQH/1qGdGnYrPhAdtFIYKDpnDu0YDSj0/qE7BHTojiV8GgXeZR/OyC2APe4CIAbW
         ZpPz1wvm5p05LuOgwADE9jSJNlHv/2QAZJO28c/sHoCv/Avp9hRLKak4J+n4NKG7bd
         b39QcSIcLmrAa2Lh42SaS7GwEmcILv8OQHVWRq2bmZyzR0p/gAPkrwfjh922twekwN
         JandcIUmRGgcut1LkoNcI2u841cYPADh/i7aBtJiDE35QwEu8gLV6O3ymP8r5rpCFl
         EV8lbxUqAalMECxcFncPDxyxx/+R+gtwP0O2QhbDdj8OZY+vbfXDty88nWvfEZkDHJ
         b6Sc7H2rU2FbQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 20:03:26 +0300
Message-Id: <CVH3NT4ZIBNS.22HFUP0WCDY26@suppilovahvero>
Subject: Re: [PATCH] integrity: powerpc: Do not select CA_MACHINE_KEYRING
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Nayna" <nayna@linux.vnet.ibm.com>,
        =?utf-8?q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        <linux-integrity@vger.kernel.org>
Cc:     "Mimi Zohar" <zohar@linux.ibm.com>,
        "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "joeyli" <jlee@suse.com>,
        "Eric Snowberg" <eric.snowberg@oracle.com>,
        "Nayna Jain" <nayna@linux.ibm.com>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
X-Mailer: aerc 0.14.0
References: <20230907165224.32256-1-msuchanek@suse.de>
 <20230907173232.GD8826@kitsune.suse.cz>
 <92e23f29-1a16-54da-48d1-59186158e923@linux.vnet.ibm.com>
In-Reply-To: <92e23f29-1a16-54da-48d1-59186158e923@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 12, 2023 at 6:39 AM EEST, Nayna wrote:
>
> On 9/7/23 13:32, Michal Such=C3=A1nek wrote:
> > Adding more CC's from the original patch, looks like get_maintainers is
> > not that great for this file.
> >
> > On Thu, Sep 07, 2023 at 06:52:19PM +0200, Michal Suchanek wrote:
> >> No other platform needs CA_MACHINE_KEYRING, either.
> >>
> >> This is policy that should be decided by the administrator, not Kconfi=
g
> >> dependencies.
>
> We certainly agree that flexibility is important. However, in this case,=
=20
> this also implies that we are expecting system admins to be security=20
> experts. As per our understanding, CA based infrastructure(PKI) is the=20
> standard to be followed and not the policy decision. And we can only=20
> speak for Power.

In the end this is dictating policy for no compelling reason, and
that is the bottom line here, not playing a mind game what type of
expertise a sysadmin might or might not have.

BR, Jarkko
