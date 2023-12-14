Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CF58139FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjLNSay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbjLNSav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:30:51 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E3C10E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:30:57 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a1db99cd1b2so1091300166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702578655; x=1703183455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0isHYCiVxibANo8wxo3LG8B7bIVEbLb07RnvwdIrmw=;
        b=p3YT405/v5n574k2njC7i9lCzfplElKudeRMDTToPb8fe3k9/PKxdnKXiJNO+ErhYN
         WAEXaNgwkxkLxMnQMw8M9TQ0HW6h3DTJv9d9R/LbvRWafDVQfqsBT3FtXeeyjiojrT1D
         ojndw8TiAXSbU/Ydw3wqkr5mIPkBYsVPdIZ69/rWw7SumdcdmBw3kvn3zyDo3r19yWjr
         90ofbtCLJe5nvf1mvZ9syNwFEn75Jf7VsLffRRdTCPaQfyRJ/qLQNGmydZI6Kh/agfTs
         I1WZ2KNsZ3wrhhceGPAc9QtRS5MgCMGsMbr/RZaKbtJ8/+gtARB2EgX9Po5GnywKbIec
         2aUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702578655; x=1703183455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0isHYCiVxibANo8wxo3LG8B7bIVEbLb07RnvwdIrmw=;
        b=TV6PkW6eQZHxkn4iQhLlViqb0Y/TAMDud0+BNof+S+WUJ2F+fzPKEM1bufO913H4oD
         blswDcGuBtUndJl4di8co8hR+UQKUEgontAWbU597EAeLNSvXQllywYEBCTwRUN39xTZ
         kmqooVOi+j84ERTsihBmElPQufroKiH1NEadceW5VCQnVmTvPX0Ws+/XN1kpjcjY4JFZ
         aQo3j/DnOmH2I2Vk58tCACKbLMzLXqXfjGi5LQgjPukOfsrhrWsF8ewznn98V0bZ8Lhr
         BLts4qIS5qb4/a2FFml21wRAWdOmYYiUSUx9gKUqaDdMbP91h5YQY9c+BfFlTdfRGf+G
         O9KA==
X-Gm-Message-State: AOJu0YyHmbP4FeKTSxjx7N+cQWkcPI7W+6Cf/p4/J7q3DENj8AmpNGcT
        jPXXVx3pI1xwW77MiQZ6wIkW0pdQc9IlH5sjRfxbRA==
X-Google-Smtp-Source: AGHT+IEUFszL8h/1cdpd9DMqyYZ2SF8nRyLs+ah6p9bPeu0mJPZbAx73R3QqYlfZITvOOycY5HkSxfeE6o+Az18O0ew=
X-Received: by 2002:a17:907:6d07:b0:9fd:ab4:5859 with SMTP id
 sa7-20020a1709076d0700b009fd0ab45859mr4569015ejc.66.1702578655351; Thu, 14
 Dec 2023 10:30:55 -0800 (PST)
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-2-896763369d04@bytedance.com> <CAJD7tkZJRgf+502QU_ECVPey0w-5vw_e6HSL+Ay7unetq5gL0A@mail.gmail.com>
 <CAKEwX=P4=YbvoRCa5+BB+==f4YL_5-6AaUNUCdH3v2faTx-PYQ@mail.gmail.com>
 <cb558f85-4f9b-4eb9-b60c-9b609075920d@bytedance.com> <CAJD7tkY_fe9SeTxOSVmYHNgi2tKvZ+EoM15KifJihF_Zn_LqDg@mail.gmail.com>
 <7a8c77b0-c78c-427d-9545-2b328c7dc727@bytedance.com>
In-Reply-To: <7a8c77b0-c78c-427d-9545-2b328c7dc727@bytedance.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 14 Dec 2023 10:30:19 -0800
Message-ID: <CAJD7tkba0O=Qfc-yuq6BNfYbrebmBy2NzywGmogdQmRwoS06dw@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/zswap: change dstmem size to one page
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Nhat Pham <nphamcs@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Li <chriscli@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 5:57=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2023/12/14 21:37, Yosry Ahmed wrote:
> > On Thu, Dec 14, 2023 at 5:33=E2=80=AFAM Chengming Zhou
> > <zhouchengming@bytedance.com> wrote:
> >>
> >> On 2023/12/14 08:18, Nhat Pham wrote:
> >>> On Wed, Dec 13, 2023 at 3:34=E2=80=AFPM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> >>>>
> >>>> On Tue, Dec 12, 2023 at 8:18=E2=80=AFPM Chengming Zhou
> >>>> <zhouchengming@bytedance.com> wrote:
> >>>>>
> >>>>> Change the dstmem size from 2 * PAGE_SIZE to only one page since
> >>>>> we only need at most one page when compress, and the "dlen" is also
> >>>>> PAGE_SIZE in acomp_request_set_params(). If the output size > PAGE_=
SIZE
> >>>>> we don't wanna store the output in zswap anyway.
> >>>>>
> >>>>> So change it to one page, and delete the stale comment.
> >>>>
> >>>> I couldn't find the history of why we needed 2 * PAGE_SIZE, it would
> >>>> be nice if someone has the context, perhaps one of the maintainers.
> >>>
> >>> It'd be very nice indeed.
> >>>
> >>>>
> >>>> One potential reason is that we used to store a zswap header
> >>>> containing the swap entry in the compressed page for writeback
> >>>> purposes, but we don't do that anymore. Maybe we wanted to be able t=
o
> >>>> handle the case where an incompressible page would exceed PAGE_SIZE
> >>>> because of that?
> >>>
> >>> It could be hmm. I didn't study the old zswap architecture too much,
> >>> but it has been 2 * PAGE_SIZE since the time zswap was first merged
> >>> last I checked.
> >>> I'm not 100% comfortable ACK-ing the undoing of something that looks
> >>> so intentional, but FTR, AFAICT, this looks correct to me.
> >>
> >> Right, there is no any history about the reason why we needed 2 pages.
> >> But obviously only one page is needed from the current code and no any
> >> problem found in the kernel build stress testing.
> >
> > Could you try manually stressing the compression with data that
> > doesn't compress at all (i.e. dlen =3D=3D PAGE_SIZE)? I want to make su=
re
> > that this case is specifically handled. I think using data from
> > /dev/random will do that but please double check that dlen =3D=3D
> > PAGE_SIZE.
>
> I just did the same kernel build testing, indeed there are a few cases
> that output dlen =3D=3D PAGE_SIZE.
>
> bpftrace -e 'k:zpool_malloc {@[(uint32)arg1=3D=3D4096]=3Dcount()}'
>
> @[1]: 2
> @[0]: 12011430

That's very useful information, thanks for testing that. Please
include this in the commit log. Please also include the fact that we
used to store a zswap header with the compressed page but don't do
that anymore, which *may* be the reason why this was needed back then.

I still want someone who knows the history to Ack this, but FWIW it
looks correct to me, so low-key:
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
