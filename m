Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBC37F1187
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjKTLPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjKTLPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:15:11 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28F0D45
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:15:02 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c50906f941so57615541fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700478901; x=1701083701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8vipKU/tRzejLbedW+j/59TWOsRAP5UuAA6FEDfq9U=;
        b=kQurFkkniRftMbmUR5OOopyI0zH4OnwYHwkAQx7RH+cyOFl2nOaBl8MFvmcXKKjlVl
         +H5SnvjJi6S9p5hvmnp9t1W3NCmxm/MEuVetdJZeff4BLE6PHa0nTFcmhjaCsbUREYJi
         Il2o8A9UmGHNPZDW+ElKzTbm/G57NwngXakQQWKze+276faVVZVF3Ih6q2U+yeWJBqiW
         JAJhcrc9AobSoEP83vSqhzZYuFURgl+ZyH/JvGV8Bq5OBDDJJR7jh7GFd2OHzoNjM9dj
         Drk4SkoocZprf6EF1iZoBFbj/XBxuzdqXwtYVc9t7mTt7Yo1D3G98kOmVg0RwcDcrmKS
         PXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700478901; x=1701083701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8vipKU/tRzejLbedW+j/59TWOsRAP5UuAA6FEDfq9U=;
        b=OvOv/k7uJPDXUBa1nKoRmboxpAVO0rF4UpA1mYZBPOyEBVX1wpHEjUlijLd/szl1QD
         bUE3F7d2/QZhmQSwN00wbRxZ7Ex4KJZknQSShkTm8pvGrXZNWWCtuzELQmZcz+xsqSbE
         4NfTpf0odpytnCWD+7RDzlnfNrtr3//Q234UUiqIb1AKrA3acX0ARvVgLE3tbk26EimU
         FjIcRKDDhCL0lEP38a1mC3Wr7H2+Nj8AoeJPTgECYjfOR57Z/X1ooGe5xu6SM7N9gTqg
         +ayYkOB44Veie729xUzHwVpvj9sQcN1AsAV4KFhGNIaIRyJewXWqikUv4tyeEfEjeVTv
         27GA==
X-Gm-Message-State: AOJu0YwOdD3Gx1du+2mJGzUZY8k6c+UTXkQgQ1my/+alzKzd3dOp2pOO
        QjTizhNMTOVLo3Uie3KiMCRYCbFcSpkdzPaJsI4=
X-Google-Smtp-Source: AGHT+IEjlD/Fc2y5vKhdps+4ygOi3gQc2izP3YexgPJBkpav4zKlgl5VJRx2mf4jas6iyYu4TMyMwi2fwQv+RMPPf7g=
X-Received: by 2002:a2e:7307:0:b0:2c8:721c:6912 with SMTP id
 o7-20020a2e7307000000b002c8721c6912mr4184743ljc.37.1700478900861; Mon, 20 Nov
 2023 03:15:00 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-17-ryncsn@gmail.com>
 <ZVp6Lt0socttCB9+@casper.infradead.org>
In-Reply-To: <ZVp6Lt0socttCB9+@casper.infradead.org>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Mon, 20 Nov 2023 19:14:42 +0800
Message-ID: <CAMgjq7Aq22AbFC9pWLnwSGDtofu4t9Ew3GrKPHgWtRJcAtoV3A@mail.gmail.com>
Subject: Re: [PATCH 16/24] mm/swap: reduce scope of get_swap_device in swapin path
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
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

Matthew Wilcox <willy@infradead.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=80 05:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Nov 20, 2023 at 03:47:32AM +0800, Kairui Song wrote:
> >       page =3D swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
> >                               vmf, &cache_result);
> > -     if (page) {
> > +     if (PTR_ERR(page) =3D=3D -EBUSY) {
>
>         if (page =3D=3D ERR_PTR(-EBUSY)) {
>

Thanks, I'll fix this.
