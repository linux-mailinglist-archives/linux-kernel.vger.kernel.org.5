Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F22813496
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573753AbjLNPWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573678AbjLNPWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:22:45 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D53128
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:22:51 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5ca5b61f101so579640a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702567371; x=1703172171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcT2Jb1TBj0DcJUl7sM6tUpyzWt4ekggVFEBQkp4qCE=;
        b=HaYtexrNJbGiaDO9zlSIZeh6h74aZvIK+U9xf0Sq+Oep5wgHxBwC4U1we8x5XwUSwY
         Qz0lrqTmLMzoysyXFxkgFuopeliNDMjhoHD7oBhp1gXLKGJ4hV6dQ1soFe50iQhiD/GV
         mDr+C+F77vJPUoI8JGTF/MhlRUVQ6Ff/uwnwkDPdBxmtu5+k/v8M8ock2LiXp24ESrtW
         1bizF1Qjh5sFA+Wc2LK5Zf9NDwDJc/oMq/YRVFfMWSJqJMp/w5YQX5ekj55+IYIDegXN
         j7JDU+ey9gOZw/jF1/SOVJL5MoNvupR4gBy0W8/8TG6FsVJQx++7GnHWAT6cMEtVd7Cy
         C4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702567371; x=1703172171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcT2Jb1TBj0DcJUl7sM6tUpyzWt4ekggVFEBQkp4qCE=;
        b=mJB3sD2Fpywlnb2wj4Svoo/eXhPH9MBOUMl/2yWu0ij7EqPIrDHYnVrjQB4DCCJ9zQ
         8ETAOavP/QJdxKezoVLm9SCZAVnAoZXp7SX1SnlLDgpgaSHO/k1SSuxRyfgkxQjPrLyo
         mtcb2vrOPxPcyAEoRgIFVNYLDVIHs0QzCDQu0EVVWWUfKoGxO2FWAqtFQoR72SbqhQQn
         BrPBI2pr78aDOLkPcLkqTSP+l48x4ny5qlNs2WmdgVhW8xZP9qrSVxeJtVT3Jod7HTWy
         u7wIifGtr6CTCgEu4aKjyeb2WPnBiuI2virWLB+hCX1PtHBQ2uklpehP8vmnnfRr/4DL
         4erg==
X-Gm-Message-State: AOJu0YxaJqGo19raweKMamtHI7kETzH6Tk7gLSeI9bNKQjwQij1yH6vx
        f87tCwVLkto9cm6Z2n84qQ3cVU1WXoRTXFp5j7FMjg==
X-Google-Smtp-Source: AGHT+IGg/odB2Osxk9lczN4UnKuRrAxLwMC4GTU+Il1sBDYBfVUA0edf/1fZr1ZpXwv3dxbCvs+tLYcBum3fRFhMJHU=
X-Received: by 2002:a17:90a:590e:b0:286:55f1:5257 with SMTP id
 k14-20020a17090a590e00b0028655f15257mr4847377pji.17.1702567371411; Thu, 14
 Dec 2023 07:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
 <20231214105243.3707730-2-tudor.ambarus@linaro.org> <CAPLW+4kr=aVjuqGz3ps5f6EzM+QASTFEoB57g+fR7jKH0s+1Zw@mail.gmail.com>
 <0d3ae184-5ded-42ab-97cf-13bbb296083a@linaro.org>
In-Reply-To: <0d3ae184-5ded-42ab-97cf-13bbb296083a@linaro.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 14 Dec 2023 09:22:40 -0600
Message-ID: <CAPLW+4mpV0cy32MPS72-z=WYTZusnS7uTO7fbmOruVjAvcoBeA@mail.gmail.com>
Subject: Re: [PATCH 01/13] dt-bindings: clock: google,gs101: fix CMU_TOP gate
 clock names
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, andre.draszik@linaro.org,
        saravanak@google.com, willmcvicker@google.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 9:16=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
>
>
> On 12/14/23 15:07, Sam Protsenko wrote:
> > On Thu, Dec 14, 2023 at 4:52=E2=80=AFAM Tudor Ambarus <tudor.ambarus@li=
naro.org> wrote:
> >>
> >> The gs101 clock names are derived from the clock register names under
> >> some certain rules. In particular, for the gate clocks the following i=
s
> >> documented and expected in the gs101 clock driver:
> >>
> >>   Replace CLK_CON_GAT_CLKCMU      with CLK_GOUT_CMU and gout_cmu
> >>   Replace CLK_CON_GAT_GATE_CLKCMU with CLK_GOUT_CMU and gout_cmu
> >>
> >>   For gates remove _UID _BLK _IPCLKPORT and _RSTNSYNC
> >>
> >
> > Doesn't it break existing gs101 device tree?
>
> No, compilation went fine at this point. The TOP gates are not used in
> the device tree at this point. And since the bindings patch was just
> applied I think we should fix it, so that we avoid name clashes as
> described below (I found a clash with a gate from PERIC0).
>

Ok, in that case feel free to add:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> >
> >> The CMU TOP gate clock names missed to include the required "CMU"
> >> differentiator which will cause name collisions with the gate clock na=
mes
> >> of other clock units. Fix the TOP gate clock names and include "CMU" i=
n
> >> their name.
> >>
> >> Fixes: 0a910f160638 ("dt-bindings: clock: Add Google gs101 clock manag=
ement unit bindings")
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> >> ---
> >
> > (snip)
>
> Thanks for the review!
> ta
