Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227117D1112
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377429AbjJTN50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377405AbjJTN5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:57:24 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2448FD55
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:57:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so1184193a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697810241; x=1698415041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBEOcHttaIcP/pxR3LNkSah4DuVLoNv+g8kB+GAwIHU=;
        b=WQ7bkNPN4sMRlqOT+c7seM+fMuJFPrXJfz53yTT//0ci+WEV64RGQAzNWwMf/2Lsqb
         eCRvHDUjMAqV0DGcSoWawXwm22MgRDb+wom6TIbsBq/HbzV6Om4CBQogyjS7jclGPKLr
         Gdjx9A7r+posdNQR9M5DVR9C8qeV8ANp75DmW8plEHecuf+BSp6MyMvIRlVuTmzlWxa/
         tyV6+Ye9/iWXa3kfn7sTx2LOEGKhzBWl76knDaQ2w019FnP/k+aanKpffROOxMA9Zg0m
         KpRLrkE1IAa8i0KwTNvPNa6LmO2tdiwrMUZaESo/PXFfK3KvY9XQKg5NGErH5qV0w28M
         7C0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697810241; x=1698415041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBEOcHttaIcP/pxR3LNkSah4DuVLoNv+g8kB+GAwIHU=;
        b=Axl/F59HrcQZ1iIpaO/YN8LXKWeM54ufH2qTIHslLuvglClmVXu8x2FUDuLKdbSM1m
         VuAcI5leMWGmr44Q7m2Gjl90Xq+BSM+cFzcZl21vlj7IF83zvG88a5pvrm69XhthRMAd
         WsCCiX2lOMv3AeH99Y53ORQa+nBoSWRz3DDh+y/jsALP13RHI9I+w0M4StdLJW627dZ1
         LD3N1pLHwKlzEysLHRsk+2iMJ0ZNlwvQXTWUVuv0+t+Z3kuWiHDYx2KF76v2TFdCUv1g
         hFK083U+kiVKlX6wnIAfiGq66JAiwcKOyTTpxB9yQgpppFoxNyJttldNpYz7flv8Vmuf
         n9tA==
X-Gm-Message-State: AOJu0YwoPHg8SsSKaWDKu9Z1pILlak+cQgDa7VQQjCq/zrEhcmkb2ahp
        JOrts8SsgFQjJb1gbKyADbyncguaIml/d3NNoVcmSg==
X-Google-Smtp-Source: AGHT+IGP32Vs6LhSO5Q+dFeyM+jo7MvJ9Do6f3Utqc/r3xR+RomnORAiVakOBNSyJSpezxCesfkyCNRViMFSh/IfRdQ=
X-Received: by 2002:a50:d795:0:b0:53e:467c:33f1 with SMTP id
 w21-20020a50d795000000b0053e467c33f1mr1740179edi.8.1697810241480; Fri, 20 Oct
 2023 06:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697779681.git.yan@cloudflare.com> <e721c615e22fc4d3d53bfa230d5d71462ae9c9a8.1697779681.git.yan@cloudflare.com>
 <CANn89iKU6-htPJh3YwvDEDhnVtkXgPOE+2rvzWCbKCpU25kbDw@mail.gmail.com>
 <CAO3-PbqtEPQro4wsQbaD-UbF-2RpxsVKVvs3M0X10-oE7K1LXA@mail.gmail.com>
 <CANn89iK6WE1MUdHKfNcEf=uhKXustwQ-mtC5_toVAkz=VFctgQ@mail.gmail.com> <20231020100055.GC9493@breakpoint.cc>
In-Reply-To: <20231020100055.GC9493@breakpoint.cc>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Fri, 20 Oct 2023 08:57:10 -0500
Message-ID: <CAO3-Pbo0N75vWNb0dtCS_47B+yM_y=m1_wjY3xS4cu_GRCw-=Q@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/3] ipv6: remove dst_allfrag test on ipv6 output
To:     Florian Westphal <fw@strlen.de>
Cc:     Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexander H Duyck <alexander.duyck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 5:01=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Eric Dumazet <edumazet@google.com> wrote:
> > I also noticed that iproute2 was not supporting RTAX_FEATURE_ALLFRAG,
> > so we might kill it completely ?
>
> Yes, I intentionally did not expose it in iproute2.
>
> Lets remove ALLFRAG.

I will do that in V4 later today to completely clean it up then.
Always cheerful to delete code!

Yan
