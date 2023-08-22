Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8499D784D20
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjHVXD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjHVXD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:03:26 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB589CFC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 16:03:23 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MN37QE124768;
        Tue, 22 Aug 2023 18:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692745387;
        bh=0gA1MR79BJQRg8K7EKeDg6Dd5h5T7QEd1fH9TRofIAc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=lV/jqZPt6abVWADYXK20CuLKDxcCgFEjEUZncZzMu6MPqRkgymdaot5p1p2nNSWiv
         029eamOGl1HvRDkJk8fcLE05Y4jl3bI1ufgtqy54Ud91a/T+GkYHB31lYtEBNAw23w
         ETeCBIKMMrm5wj9RAFxhXsJfzzF3cvqNJFyowXGc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MN37BD061046
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Aug 2023 18:03:07 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 18:03:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 18:03:07 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MN37FL016222;
        Tue, 22 Aug 2023 18:03:07 -0500
Date:   Tue, 22 Aug 2023 18:03:07 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: keystone: Drop unused includes
Message-ID: <20230822230307.hps2zhd3acdjy7r3@emptiness>
References: <20230717225610.3214029-1-robh@kernel.org>
 <169028492642.1718138.9430735746671016845.b4-ty@ti.com>
 <CAL_JsqKAuLJwBiKjLFd03C89ZRr0P+URyOh3t-7oqKv3vQzBdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKAuLJwBiKjLFd03C89ZRr0P+URyOh3t-7oqKv3vQzBdw@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:28-20230822, Rob Herring wrote:
> On Tue, Jul 25, 2023 at 6:35 AM Nishanth Menon <nm@ti.com> wrote:
> >
> > Hi Rob Herring,
> >
> > On Mon, 17 Jul 2023 16:56:09 -0600, Rob Herring wrote:
> > > Several includes are not needed, so drop them.
> > >
> > > of_platform.h is not needed, but it implicitly includes platform_device.h
> > > (for now) which is needed.
> > >
> > >
> >
> > I have applied the following to branch ti-keystone-next on [1].
> > Thank you!
> >
> > [1/1] ARM: keystone: Drop unused includes
> >       commit: 630c191b3396c6aaccab1234f8834848a2c42e8a
> 
> Did you really? Doesn't look like this is in linux-next.

Seems to have been there for a while?

https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git/log/?h=ti-keystone-next

https://patchwork.kernel.org/project/linux-soc/patch/20230814160702.6l2fcujbx33eogap@junction/

$ git tag --contains 630c191b3396c6aaccab1234f8834848a2c42e8a
next-20230801
next-20230802
next-20230804
next-20230807
next-20230808
next-20230809
next-20230816
next-20230817
next-20230818
next-20230821
next-20230822
ti-keystone-soc-for-v6.6


Did I miss something?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
