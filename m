Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F7B78B13B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjH1M76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjH1M71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:59:27 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801AB11C;
        Mon, 28 Aug 2023 05:59:23 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37SCxC0v008198;
        Mon, 28 Aug 2023 07:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693227552;
        bh=RGaXn3WZuuecRsYHVTXM26hoG7JPsA33rXGA8BjFj30=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=bdL+G4KXYUuv1tiFM5tmY0CRJyEWuqGKuDO4gFD6rK8erWHPL5Fqwf79cVXB016+a
         A4RpIKnwksmv+aYXgOrE0FGMEc1TAz9pkSZkmDSO9vBFyB98QV/R2uzOUEvGkun/cI
         S01Cj4c7CTrgm7GrCPNH/ZI8VNKIEUnWZ99wHRZk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37SCxCBb015942
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Aug 2023 07:59:12 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Aug 2023 07:59:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Aug 2023 07:59:12 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37SCxClt038571;
        Mon, 28 Aug 2023 07:59:12 -0500
Date:   Mon, 28 Aug 2023 07:59:12 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <bpf@vger.kernel.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
        Neha Francis <n-francis@ti.com>
Subject: Re: [PATCH 1/2] Documentation: sphinx: Add sphinx-prompt
Message-ID: <20230828125912.hndmzfkof23zxpxl@tidings>
References: <20230824182107.3702766-1-nm@ti.com>
 <20230824182107.3702766-2-nm@ti.com>
 <87h6om4u6o.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87h6om4u6o.fsf@meer.lwn.net>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On 16:46-20230825, Jonathan Corbet wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
> > Sphinx-prompt[1] helps bring-in '.. prompt::' option that allows a
> > better rendered documentation, yet be able to copy paste without
> > picking up the prompt from the rendered documentation.
> >
> > [1] https://pypi.org/project/sphinx-prompt/
> > Link: https://lore.kernel.org/all/87fs48rgto.fsf@baylibre.com/
> > Suggested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> > Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > I would have added Reported-by for Simon, since he reported the issue in
> > the first place.. but it was for the u-boot documentation, so skipping
> > here.
> >
> >  Documentation/conf.py                 | 2 +-
> >  Documentation/sphinx/requirements.txt | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> So it would sure be nice for the changelog to say what this actually
> does.

All this does is to bring in a better rendered documentation when
published in html format.
https://youtu.be/ItjdVa59jjE shows how the "copy-paste" functionality is
improved.

If you could recommend changes, I'd be glad to incorporate the same.

> 
> This appears to add a build dependency for the docs; we can't just add
> that without updating the documentation, adjusting
> scripts/sphinx-pre-install, and so on.

I had checked scripts/shinx-pre-install and that picks up
Documentation/sphinx/requirements.txt and installs the dependencies
from there using pip. Am I missing something?

Same thing with Documentation/doc-guide/sphinx.rst

Am I missing something?

> 
> But, beyond that, this extension goes entirely counter to the idea that
> the plain-text files are the primary form of documentation; it adds
> clutter and makes those files less readable.  We can do that when the

Are you sure this is going against the readable text documentation? If
anything it reduces the clutter and allows the text doc to be
copy-paste-able as well.

https://lore.kernel.org/all/20230824182107.3702766-3-nm@ti.com/

As you see from the diffstat:
 1 file changed, 10 insertions(+), 10 deletions(-)

Nothing extra added. What kind of clutter are you suggesting we added
with the change?

prompt:: bash $ is clearly readable that this is prompt documentation
in fact, dropping the "$" in the example logs, one can easily copy paste
the documentation from rst files as well.

> benefit is sufficient, but I'm pretty far from convinced that this is
> the case here.  Certainly the case hasn't been made in the changelog.
> What *is* the benefit of making this change?

Let me know *how* I can improve (note: I am not a native English
speaker, so, I'd appreciate any suggestions to make the argument clear
in the changelog). Intent here is to help make the rendered html
documentation that we publish in docs.kernel.org such as
https://docs.kernel.org/bpf/libbpf/libbpf_build.html better usable.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
