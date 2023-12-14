Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9868131BF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573367AbjLNNht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573357AbjLNNhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:37:47 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A5D11D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:37:53 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54ba86ae133so7630121a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702561071; x=1703165871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qpsCecMI674kIGB2yl4i2Rc7RNuAwCEXk0ILp0KVNA=;
        b=MWmvigwvAhlh/2AWx3GVIkLfZywI7HgBLvZls3qq1Ho05L/+2T3JpOUH7+k/ofkgWG
         sIc4jDvkbm0AjePLsNn2F0S7FmL80yb2HYla+vOYGDL+7AFXXJ2Y1Q1qxBfdgx8lr/x9
         NFVwTm0sgNDw8X+YcFemZfGmT+FG1eBBZQnuvWAtVnvOeSkM9ujzEdRB97E5hdIUfxT6
         vTYb8zw+faNsWov4bs+fsxZNNNQBFLuN7yX6FQXO16NdSCJrJCmQ/0l76vCm4nA2tYnR
         Wsmamg5mLYWV3lYp/FDkEXZbmxIYm6m419fJo5nv3hjObR9a5mb5WwE4FEPeOO2xS0Ry
         p7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702561071; x=1703165871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qpsCecMI674kIGB2yl4i2Rc7RNuAwCEXk0ILp0KVNA=;
        b=IhpI/zIr0J1S0F0yvw4/NxwHNkPCFLxoHoZY5vEaj2jWU59zGGX8TulLPfFjFoiBc1
         B4XM+chlRYU/nvE4YdkYIo3FocxyfDpsxd2euY97PBjl0g1Sk7wBG4KdNGdJAKFyyEFz
         wcQ2Bx0LnJ3ypYwzmJFFhCKQ23+XSzIZ5MJarsRk12UZCQLeuslx6UPCrI2RNa3Gu7IH
         wDd/5k6fLM2k3ULplPcPdPX7f6kEA75bFxAGqZnF8EO2FDTyinVebOtJ7OBBYh/vaexS
         iTN5lnrbd3qjairSyDPP9OQv+6w2FHLnKL+vUyXwScZGjMfFHrugRKWDyjmIjBgKjZ1Y
         zwEQ==
X-Gm-Message-State: AOJu0YznkBtd9i7f7DEIMBxRplaXN2UKkqoKQvqrREoODd0Pue8Jiz+W
        vhmvjjGrWPNKAPh8iB8PKDgWH7hzYX9x/QcvCaEwGw==
X-Google-Smtp-Source: AGHT+IEsHTxTDKk3j72JpEvGQnVhw4kxW5sPOoIr/jWmG65tKcRKn9FWFPI+f8iYvmv8TRwmKPQe69DNRcF1e2V/Zdk=
X-Received: by 2002:a17:906:2207:b0:a1f:9f16:2cfd with SMTP id
 s7-20020a170906220700b00a1f9f162cfdmr4013910ejs.63.1702561071220; Thu, 14 Dec
 2023 05:37:51 -0800 (PST)
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-2-896763369d04@bytedance.com> <CAJD7tkZJRgf+502QU_ECVPey0w-5vw_e6HSL+Ay7unetq5gL0A@mail.gmail.com>
 <CAKEwX=P4=YbvoRCa5+BB+==f4YL_5-6AaUNUCdH3v2faTx-PYQ@mail.gmail.com> <cb558f85-4f9b-4eb9-b60c-9b609075920d@bytedance.com>
In-Reply-To: <cb558f85-4f9b-4eb9-b60c-9b609075920d@bytedance.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 14 Dec 2023 05:37:15 -0800
Message-ID: <CAJD7tkY_fe9SeTxOSVmYHNgi2tKvZ+EoM15KifJihF_Zn_LqDg@mail.gmail.com>
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

On Thu, Dec 14, 2023 at 5:33=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2023/12/14 08:18, Nhat Pham wrote:
> > On Wed, Dec 13, 2023 at 3:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> >>
> >> On Tue, Dec 12, 2023 at 8:18=E2=80=AFPM Chengming Zhou
> >> <zhouchengming@bytedance.com> wrote:
> >>>
> >>> Change the dstmem size from 2 * PAGE_SIZE to only one page since
> >>> we only need at most one page when compress, and the "dlen" is also
> >>> PAGE_SIZE in acomp_request_set_params(). If the output size > PAGE_SI=
ZE
> >>> we don't wanna store the output in zswap anyway.
> >>>
> >>> So change it to one page, and delete the stale comment.
> >>
> >> I couldn't find the history of why we needed 2 * PAGE_SIZE, it would
> >> be nice if someone has the context, perhaps one of the maintainers.
> >
> > It'd be very nice indeed.
> >
> >>
> >> One potential reason is that we used to store a zswap header
> >> containing the swap entry in the compressed page for writeback
> >> purposes, but we don't do that anymore. Maybe we wanted to be able to
> >> handle the case where an incompressible page would exceed PAGE_SIZE
> >> because of that?
> >
> > It could be hmm. I didn't study the old zswap architecture too much,
> > but it has been 2 * PAGE_SIZE since the time zswap was first merged
> > last I checked.
> > I'm not 100% comfortable ACK-ing the undoing of something that looks
> > so intentional, but FTR, AFAICT, this looks correct to me.
>
> Right, there is no any history about the reason why we needed 2 pages.
> But obviously only one page is needed from the current code and no any
> problem found in the kernel build stress testing.

Could you try manually stressing the compression with data that
doesn't compress at all (i.e. dlen =3D=3D PAGE_SIZE)? I want to make sure
that this case is specifically handled. I think using data from
/dev/random will do that but please double check that dlen =3D=3D
PAGE_SIZE.
