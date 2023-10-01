Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87E87B48F4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 19:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235242AbjJARmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 13:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjJARmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 13:42:35 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCC2E1
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 10:42:32 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C17435C2ACD;
        Sun,  1 Oct 2023 13:42:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 01 Oct 2023 13:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1696182149; x=1696268549; bh=69
        v6fzzEznhsP+iYQxrU1Qq2W/AMcZ2L6Dp2+ptqLDY=; b=QDs6lArr2g+oCTGhI4
        FdS3EHjTfKDRZa/1CPclSEzeK029nE16Xxh2uGtS0QwwJEpz/j0rui8KdK2mqFHi
        cx8wdu0PF7ZBglgtvDU0Ur6x52aIobahN28iwIm93MCreXzYLG1ACS52gvWg5SdZ
        Mt0R51mSkQcdtGkByDL+BqXZrN6H4uOBRCBcW+dFirgWvdmtf+GJKIBBdKnWs9AU
        +CoOfVa5OmKbpLnxeWeHRxjUzUN88bVq7PNQFdIahGz8IinZxtVm1DzV3hsjNeH6
        pKa8fTiHG65092UOk440d8UI+moWyGUqZPbTZzzKAwfb30wuz/qA0ZVyjGPONoOW
        RUEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696182149; x=1696268549; bh=69v6fzzEznhsP
        +iYQxrU1Qq2W/AMcZ2L6Dp2+ptqLDY=; b=Mlk+mgvQQ5xKnM8ipa+N1OsHr584x
        DM0JT67JB/JJaW/xeEZODjBlnwnfXU1BAzwfsihy3jVjvsm3NrRNzPUyWTjPu6yV
        BmdBYwHe0dEh9KgFvrbWITxivNpgWJ3FHFYJnjllswi+RAo1ohIEBwA/0tCdRp4u
        rUfJ0iPzBFv/Yo2wFhf/FhMJZKStdm3Ara5ddobIcUZ5SLzXPSIKCqcegSLa6bHF
        n/U/X2VCc5viot16M4xsAxsscw0YWfvEHu70ZslCsza0z9zlLEPhTRB1jzZUwkxv
        FZK9m/gGqpckjcM8cGJ2lDo2fSOgj5dzyGhsUdX4QTcjCyywdyCj4oBpg==
X-ME-Sender: <xms:hK8ZZQLHtYx2bRRLUVYDYEV_v1yFBhj_exF4A7b9cXxGZPYv8HWVBA>
    <xme:hK8ZZQKk_7PgridJq7Hh1RHpqyWasLnKTZx8wFfx03rXjlM3F1UjWKlOI5l7qDN6L
    4U_ODFLYFiUOx9EUGk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddvgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:hK8ZZQv5ajbSCyXlf7J99Uubnohs_NO9XkLNXBB0p8Cz1ZZ61bvBPA>
    <xmx:hK8ZZdZXU6zYICKNRjTOh_8GXpEzmMTm3uQZyCAflTwSp9eqYgXevQ>
    <xmx:hK8ZZXZu8gkOFOSVIzZ3L7FiwItZpJc904BE43ZuG3zoTqWaVuzMwQ>
    <xmx:ha8ZZfJ7bEuYq9Fq9AzxEPP9Ae3Qgl5HbWN009_l748vV3R3mfaEZQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B273EB60089; Sun,  1 Oct 2023 13:42:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-958-g1b1b911df8-fm-20230927.002-g1b1b911d
MIME-Version: 1.0
Message-Id: <fdb95a6d-8b54-475c-90c3-8a391161bb66@app.fastmail.com>
In-Reply-To: <cover.1696174961.git.lstoakes@gmail.com>
References: <cover.1696174961.git.lstoakes@gmail.com>
Date:   Sun, 01 Oct 2023 13:39:33 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lorenzo Stoakes" <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>
Cc:     "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Jiri Olsa" <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "Ian Rogers" <irogers@google.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Richard Cochran" <richardcochran@gmail.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        "John Hubbard" <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/4] various improvements to the GUP interface
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 1, 2023, at 12:00, Lorenzo Stoakes wrote:
> A series of fixes to simplify and improve the GUP interface with an eye to
> providing groundwork to future improvements:-
>
> * __access_remote_vm() and access_remote_vm() are functionally identical,
>   so make the former static such that in future we can potentially change
>   the external-facing implementation details of this function.
>
> * Extend is_valid_gup_args() to cover the missing FOLL_TOUCH case, and
>   simplify things by defining INTERNAL_GUP_FLAGS to check against.
>
> * Adjust __get_user_pages_locked() to explicitly treat a failure to pin any
>   pages as an error in all circumstances other than FOLL_NOWAIT being
>   specified, bringing it in line with the nommu implementation of this
>   function.
>
> * (With many thanks to Arnd who suggested this in the first instance)
>   Update get_user_page_vma_remote() to explicitly only return a page or an
>   error, simplifying the interface and avoiding the questionable
>   IS_ERR_OR_NULL() pattern.
>
> Lorenzo Stoakes (4):
>   mm: make __access_remote_vm() static
>   mm/gup: explicitly define and check internal GUP flags, disallow
>     FOLL_TOUCH
>   mm/gup: make failure to pin an error if FOLL_NOWAIT not specified
>   mm/gup: adapt get_user_page_vma_remote() to never return NULL

I don't normally review mm patches, but I had a look since it was
started by my earlier feedback. It all looks good to me, very nice
cleanup!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
