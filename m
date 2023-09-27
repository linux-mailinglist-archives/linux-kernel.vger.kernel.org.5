Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D487AF809
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 04:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjI0CN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 22:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235276AbjI0CL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 22:11:27 -0400
Received: from out-192.mta1.migadu.com (out-192.mta1.migadu.com [IPv6:2001:41d0:203:375::c0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2BDCC2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 17:12:15 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695773533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JRPegJkrTPDsS4qpBA4kcSEnQZZ4tu9fP+T8S6NR8oA=;
        b=uK1eoeKsZreYiT8whydILzxqvLTk4ajvdNXadcAwRFF2MY6iwSCQQZaz3N/YU72U0h3aue
        8YcYdUqoJ1syiF3dVyuNRXrw/ME+jH7AOVNSnuJ4MVpiEvA88l3Vr6rlhHLBBq4CVvyVox
        L5AJnuUKlXzCv3wkuwKIPKVzu3drn/M=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
Mime-Version: 1.0
Subject: Re: [PATCH] mm/hugetlb: replace page_ref_freeze() with folio_ref_freeze() in hugetlb_folio_init_vmemmap()
Date:   Wed, 27 Sep 2023 08:11:39 +0800
Message-Id: <CB30072F-5EDA-4495-B25C-9C719AF80E38@linux.dev>
References: <20230926174433.81241-1-sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org,
        usama.arif@bytedance.com
In-Reply-To: <20230926174433.81241-1-sidhartha.kumar@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 27, 2023, at 01:45, Sidhartha Kumar <sidhartha.kumar@oracle.com> wr=
ote:
>=20
> =EF=BB=BF
> No functional difference, folio_ref_freeze() is currently a wrapper for
> page_ref_freeze().
>=20
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>=20

Thanks=
