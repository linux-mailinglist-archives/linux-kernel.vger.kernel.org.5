Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF6C7C8D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjJMSgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMSgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:36:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EC783;
        Fri, 13 Oct 2023 11:36:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28F4C433CA;
        Fri, 13 Oct 2023 18:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697222202;
        bh=0S2HnrquJcFNxIuazrnjhhYQjCvk3dNZd4oq+QZge1U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nx0GECoawHSXEQ0ujYqYcb3mWiqXC4RLUHFbEM5ggPUSAbt6FeLfAYN611V+Khyl8
         iTenJlcGWkLDIo1uaeFBqQhV/iDrEQjATjW04HW4/B97My6DUm3mF72plfEBFS+45X
         +R1m43kLkr0qqpEd3SsRf5MfZ7vs5paVqhl024GnyZQ50VOKpzjU9EMsWRuISmTdSE
         d+KinUwWolUsHjJ7FmJxVSv/HMbpZveJJ8opn0zZJOppdvP1LgrLqHYOuB4lPEpOg1
         AN++IsETXsuNWhRkhrpTrOHrMDlqUOM8xHnU5wMJEcBhQaTqGPc0Q5PxYTpApFMXM9
         hSQ/HpWc6UscQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5041d6d8b10so3209828e87.2;
        Fri, 13 Oct 2023 11:36:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YxUu5L2fWeg97fzcMW2duTLC9GAr3y0mnqotcEPQD1wEcH3u/Sz
        BY4eGk2Oa01rtHJP+b2hD84gnHBxYDLpqXqjjg==
X-Google-Smtp-Source: AGHT+IGqb2rSzpK7eG6lJFF3puWYynj2zHlL2G5aerjgOJhGmMzNeAnsFgJSuM3C0yNuNUHgVllQHR9OGBFVsA6fl3I=
X-Received: by 2002:a19:5e48:0:b0:500:863e:fc57 with SMTP id
 z8-20020a195e48000000b00500863efc57mr19333929lfi.25.1697222201106; Fri, 13
 Oct 2023 11:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231012192149.1546368-1-robh@kernel.org> <ZSkPjRp/xPfVQ/NB@yilunxu-OptiPlex-7050>
 <CAL_JsqLHKTQi0i-V4C5UA6WJjnMeen0WR4jjcA4YSRXOYZOrZA@mail.gmail.com>
In-Reply-To: <CAL_JsqLHKTQi0i-V4C5UA6WJjnMeen0WR4jjcA4YSRXOYZOrZA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 13 Oct 2023 13:36:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLuKF3Cnu38F9CY+_yeU8eCBpBBh82_8E6FcoAa_jU=sw@mail.gmail.com>
Message-ID: <CAL_JsqLuKF3Cnu38F9CY+_yeU8eCBpBBh82_8E6FcoAa_jU=sw@mail.gmail.com>
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: Fix unused xlnx_pr_decoupler_of_match
 warning for !CONFIG_OF
To:     Xu Yilun <yilun.xu@linux.intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@amd.com>,
        kernel test robot <lkp@intel.com>,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 8:15=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Oct 13, 2023 at 4:37=E2=80=AFAM Xu Yilun <yilun.xu@linux.intel.co=
m> wrote:
> >
> > On Thu, Oct 12, 2023 at 02:21:48PM -0500, Rob Herring wrote:
> > > Commit 8c966aadcc02 ("fpga: Use device_get_match_data()") dropped the
> >
> > Hi rob:
> >
> > Unfortunately I re-applied Commit 8c966aadcc02 and the previous commit
> > id is lost.
> >
> > Since the 2 patches are not upstreamed yet, could I just merge them int=
o
> > one?
>
> Yes, that's fine.

Looks like altera-ps-spi.c also needs the same fix. Do you mind making
the same change there?

Rob
