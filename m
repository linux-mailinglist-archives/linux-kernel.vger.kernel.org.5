Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA198123CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442842AbjLNASf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 19:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjLNASd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 19:18:33 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70A9C9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:18:39 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7b71d65021dso2714639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 16:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702513119; x=1703117919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UK0r9pqE3gS6uIIh7g6GkHrJnnAduy/j8HlB4vpg/WI=;
        b=SpSu16HiptAvSuPCo+8FZNXa+Uy1iBODjYZ6AfZeDKEPzeciaxwKpVV06xszI/CMhn
         /GQZTWfUsLGB5DQWYYj+qxccuePmTJCCMbf5XKK5LPNjDLAN7GuRALbftKS2K/mr8Uhg
         HB3/bL0xEA0lmTn829+6W+PmiXpbYSbt95Xc9bMcS5wGo6UZ0mVoqGurbF0smfAQ2MUX
         UQKGx4ePtZCSW1mJ4lKOKi4eKQrjIFvofpMqKabFMtSsdDC5/tpXXqUat0333zNd7Pmc
         SHTbII+JB3SyxrDx7hXXSosLzoXMIDtkvQOaLf9JKf+2YWbkxWKlPW8obi96Y0Rd0WFk
         0mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702513119; x=1703117919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UK0r9pqE3gS6uIIh7g6GkHrJnnAduy/j8HlB4vpg/WI=;
        b=R+XISHd/t37NxPNF9O2PezSewF2+vegk5U1m/vJ843ffFSiN7u4EErglTS3/saQPQI
         bc7T3jIUizxd8I9cLM2PukEFsw/59DPEwMk++IrgwxyaHmCRPxDsUpctDNuhriJLHh6h
         G/U5w0YYZHVzL0pVXHgASzx6su7/sDnWu49nASzqdreSKLj3fC2Z+FF5g+ZBgRROoYNE
         7oBTvWpGiOqAEfXPuPcFrPq1/eVnIae/MI8MKqpoxNSPBFVSJetduB7IOVeFlvwFhjLA
         uftohugH+egnpvuDVsCZAhe6cnmGgShscLv3CyIgFKKMXiRRbcPOUnvElB4u9ou/nyAP
         qHvg==
X-Gm-Message-State: AOJu0Yz491hC/gzSQHFwnQT79ZMfkq59CvIGdD5kMn1SHrGB31pyzVyt
        pRDg01SZcjJjKnL5wMIMUR2xKryrWnJbGw5c3kI=
X-Google-Smtp-Source: AGHT+IG4ZfHaO2lC9YISmdWm26tg0SSsfVW3vnRgOYFaM47aw206U8ol6cL+d8otxvq9aNlNm2nCeTZnzd/jiikBCL0=
X-Received: by 2002:a6b:e81a:0:b0:7b4:2a4e:57b0 with SMTP id
 f26-20020a6be81a000000b007b42a4e57b0mr7965967ioh.11.1702513119140; Wed, 13
 Dec 2023 16:18:39 -0800 (PST)
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-2-896763369d04@bytedance.com> <CAJD7tkZJRgf+502QU_ECVPey0w-5vw_e6HSL+Ay7unetq5gL0A@mail.gmail.com>
In-Reply-To: <CAJD7tkZJRgf+502QU_ECVPey0w-5vw_e6HSL+Ay7unetq5gL0A@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 13 Dec 2023 16:18:28 -0800
Message-ID: <CAKEwX=P4=YbvoRCa5+BB+==f4YL_5-6AaUNUCdH3v2faTx-PYQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/zswap: change dstmem size to one page
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Li <chriscli@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 3:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Dec 12, 2023 at 8:18=E2=80=AFPM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
> >
> > Change the dstmem size from 2 * PAGE_SIZE to only one page since
> > we only need at most one page when compress, and the "dlen" is also
> > PAGE_SIZE in acomp_request_set_params(). If the output size > PAGE_SIZE
> > we don't wanna store the output in zswap anyway.
> >
> > So change it to one page, and delete the stale comment.
>
> I couldn't find the history of why we needed 2 * PAGE_SIZE, it would
> be nice if someone has the context, perhaps one of the maintainers.

It'd be very nice indeed.

>
> One potential reason is that we used to store a zswap header
> containing the swap entry in the compressed page for writeback
> purposes, but we don't do that anymore. Maybe we wanted to be able to
> handle the case where an incompressible page would exceed PAGE_SIZE
> because of that?

It could be hmm. I didn't study the old zswap architecture too much,
but it has been 2 * PAGE_SIZE since the time zswap was first merged
last I checked.
I'm not 100% comfortable ACK-ing the undoing of something that looks
so intentional, but FTR, AFAICT, this looks correct to me.
