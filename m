Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BEC75BC07
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 03:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjGUB4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 21:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGUB4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 21:56:34 -0400
Received: from out-54.mta0.migadu.com (out-54.mta0.migadu.com [IPv6:2001:41d0:1004:224b::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E639C270B;
        Thu, 20 Jul 2023 18:56:32 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689904589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V9xzmr/d2IKBxXzSTTNBuI1FHVZ5ZZJ/JXVFqjqdjOE=;
        b=OYjShRuZxV8Y0Z7cVXsAqeuM94VqiBwWsu1rSmvrg76erAxQHqby2QDGa+eVAQqh+BMK+D
        UkH3oUHWzYlGmPqFrGFXgeNjDrECYNiK4Q6Paxpp/X1IymcrkjpTMNsmcuXNdJd3ymFt2K
        I8eURhKyVsefGlj0SUNO9ZibjPQDgps=
Date:   Fri, 21 Jul 2023 01:56:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <e2c15ec828daf2c1d4277e78859698929efe86b0@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v3] dma-contiguous: support numa CMA for specified node
To:     "=?utf-8?B?UGV0ciBUZXNhxZnDrWs=?=" <petr@tesarici.cz>,
        "Christoph Hellwig" <hch@lst.de>
Cc:     corbet@lwn.net, m.szyprowski@samsung.com, robin.murphy@arm.com,
        akpm@linux-foundation.org, paulmck@kernel.org,
        catalin.marinas@arm.com, rdunlap@infradead.org,
        peterz@infradead.org, rostedt@goodmis.org, kim.phillips@amd.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, linux-mm@kvack.org
In-Reply-To: <20230720142712.295834d0@meshulam.tesarici.cz>
References: <20230720142712.295834d0@meshulam.tesarici.cz>
 <20230720082517.GA7057@lst.de> <20230712074758.1133272-1-yajun.deng@linux.dev>
 <25942dafbc7f52488a30c807b6322109539442cf@linux.dev>
 <20230720115408.GA13114@lst.de>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

July 20, 2023 at 8:27 PM, "Petr Tesa=C5=99=C3=ADk" <petr@tesarici.cz> wro=
te:


>=20
>=20V Thu, 20 Jul 2023 13:54:08 +0200
> Christoph Hellwig <hch@lst.de> naps=C3=A1no:
>=20
>=20>=20
>=20> On Thu, Jul 20, 2023 at 08:47:37AM +0000, Yajun Deng wrote:
> >  It's based on linux-next tree.
> >=20=20
>=20>  This patch should be after my other patch in linux-next tree.
> >  a960925a6b23("dma-contiguous: support per-numa CMA for all architect=
ures").=20
>=20>=20=20
>=20>  Where did this land?
> >=20
>=20
> Well... in the linux-next tree:
>=20
>=20https://www.kernel.org/doc/man-pages/linux-next.html
>=20
>=20>=20
>=20> dma patches really should be going through the DMA tree..
> >=20
>=20
> Indeed. The other patch was also sent to the iommu ML back in May. It's
> the thread where we were looking for Barry Song's current email address=
.
>

Thanks. This link shows what happened at that time:
https://lore.kernel.org/all/20230512094210.141540-1-yajun.deng@linux.dev/=
T/#u
=20
>=20Petr T
>
