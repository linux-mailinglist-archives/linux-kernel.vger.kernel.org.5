Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDE87E6E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbjKIQEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjKIQEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:04:45 -0500
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F3C35AA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:04:43 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699545881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kECW9OddzxxCKHOr2o5L82R+nIpt0hBsTlQ6qqcrjVc=;
        b=BuzGpLn0iKFVj8pnSx/KY/DhQSSlB3uV2Pme5w/zuCJ7oNLowILkpKT8uWCNiZil1sLeoT
        Uk4/7iqIK5DdJCzKz8FE6b1AseGRGEVuCX9QkehfS4o3uJCg+LzgS1N486n9b7K3/rwIwC
        vZ6t7+5dgD0YIV83EQJ3j8L26d2iAQY=
Date:   Thu, 09 Nov 2023 16:04:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   jeff.xie@linux.dev
Message-ID: <58d4f340549dd69a5d605c1526ceceb035b3cc98@linux.dev>
TLS-Required: No
Subject: Re: [RFC][PATCH 1/4] mm, page_owner: add folio allocate post callback
 for struct page_owner to make the owner clearer
To:     "Matthew Wilcox" <willy@infradead.org>,
        "Jeff Xie" <xiehuan09@gmail.com>
Cc:     akpm@linux-foundation.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        chensong_2000@189.cn
In-Reply-To: <ZUz8kTx1eNQkkbFc@casper.infradead.org>
References: <ZUz8kTx1eNQkkbFc@casper.infradead.org>
 <20231109032521.392217-1-jeff.xie@linux.dev>
 <20231109032521.392217-2-jeff.xie@linux.dev>
 <ZUzl0U++a5fRpCQm@casper.infradead.org>
 <CAEr6+EB5q3ksmgYruOVngiwf6KJcrzABchd=Osyk0MiVDGQyQQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

November 9, 2023 at 11:36 PM, "Matthew Wilcox" <willy@infradead.org> wrot=
e:


>=20
>=20On Thu, Nov 09, 2023 at 11:25:18PM +0800, Jeff Xie wrote:
>=20
>=20>=20
>=20> From the perspective of a folio, it cannot obtain information about
> >  all the situations in which folios are allocated.
> >  If we want to determine whether a folio is related to vmalloc or
> >  kernel_stack or the other memory allocation process,
> >  using just a folio parameter is not sufficient. To achieve this goal=
,
> >  we can add a callback function to provide more extensibility and
> >  information.
> >=20
>=20
> But we want that anyway (or at least I do). You're right that vmalloc
> pages are not marked as being vmalloc pages and don't contain the
> information about which vmalloc area they belong to. I've talked about
> ways we can add that information to folios in the past, but I have a lo=
t
> of other projects I'm working on. Are you interested in doing that?
>

Certainly, I'm willing to give it a try. If a folio can include vmalloc i=
nformation
or more information, this is great. I may need to understand the backgrou=
nd of why
you proposed this method in the past.

--
Jeff Xie
