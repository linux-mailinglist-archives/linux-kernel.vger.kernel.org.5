Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6CB7CA1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjJPIne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjJPInc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:43:32 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B5DE5;
        Mon, 16 Oct 2023 01:43:30 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-352a1a0348fso17024435ab.1;
        Mon, 16 Oct 2023 01:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697445810; x=1698050610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xQUA2kVIK9BvRQHq7INiXTqvFwcbvDawTtrHlGAf8Qg=;
        b=lluTCjb2rbEV6RYhlHcRWXWJ9bdawhTL1SYsrbe4RjEesZRLtjgLEkcvDwSuwJ4n8P
         7gpVxSEP/SBJZFt9u9HTi/Bi7EYZDxd/JJa/jWTOULz2ympIwermojD3KEHchXwOIcEJ
         w9CTpb1grgGgnfcmgWQ2vYEgxEyTmgAAHrSTyvZR6SZNpEPywYc8Pc1B+aZv579NIPjA
         yBCiSyW77P7YtbPKwGfPLz9HSFa2Zq34E6DG0ojmNL4pMxTiGHoCNQLlfpP8npyYCLrV
         V+AEmw1zCFns45xx5/zOtWHLyJLzFXF/EC59TXJbuf7GL9+oGCBR1+8lxU22aufIoMO/
         oPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697445810; x=1698050610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQUA2kVIK9BvRQHq7INiXTqvFwcbvDawTtrHlGAf8Qg=;
        b=SwPy8RC+KmaMEqxkMaFhV20TQFjyp0Lfj97Xoia9QCpiiffOE3ZUHOonf1sTBBuYgg
         HwjNk4ErZHpDJvA+avvxL4NGhDQJtZttalfTvUETGB1j6h3UDSwQWomtsEij03fAbArT
         mRY7M3p7Tlc1lZDPqUUVna1HxvnZaSQapmtxSaYn33tvggjez0YjBsfwnRWo4hlAgrv7
         5gSEPhDxDBKq+ee34CruM0ZIpFAgTIf7h8UbOW1eL/GbyXbtJ8AxDrUtkvU34urmbDBl
         24PMAHqEo30gI8R35J5kttYgnaJjTlogPofBBEvFG9XwrT16YLkxC1IRkRu1e7ff3yqu
         1DNA==
X-Gm-Message-State: AOJu0YwNDa/9Jpi8fABKMKlW/FaxxsjMPKeDL0iFAHqDyUZU6BJGSz/A
        zuRZWIFvAPNXPQMLPftg+syKi7fACuiXjD9qXHpuWnAB
X-Google-Smtp-Source: AGHT+IGjLW7nb/ZlLwueRbrLE5qmdQxF+5HSgLfPcrsUVd2ctUvRcr8GmZwJlf4irl2Il4qJjf51CpdWBGi6yVKnO3c=
X-Received: by 2002:a92:c54d:0:b0:352:8b80:4744 with SMTP id
 a13-20020a92c54d000000b003528b804744mr39881115ilj.4.1697445809913; Mon, 16
 Oct 2023 01:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231013172033.3549476-1-robimarko@gmail.com> <20231016033202.i54nequofzea6mfd@vireshk-i7>
 <20231016082239.2onlrqp4bpcgxhbt@vireshk-i7> <CAOX2RU5paPXyG-1Fbp+T9+Aycwno9DQ8ugMwUr_8iNhhc3HiHA@mail.gmail.com>
 <CAA8EJpq9=dtemYLCeL8=+q1x_i8Gp2duMSAo90ZttgaejBXCdg@mail.gmail.com>
In-Reply-To: <CAA8EJpq9=dtemYLCeL8=+q1x_i8Gp2duMSAo90ZttgaejBXCdg@mail.gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 16 Oct 2023 10:43:18 +0200
Message-ID: <CAOX2RU6K7h8Xc0SGK2CeOCaAaimKRf9eqhMYAaySXxQLZiUNtg@mail.gmail.com>
Subject: Re: [PATCH v6] cpufreq: qcom-nvmem: add support for IPQ8074
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, rafael@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 at 10:36, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, 16 Oct 2023 at 11:29, Robert Marko <robimarko@gmail.com> wrote:
> >
> > On Mon, 16 Oct 2023 at 10:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 16-10-23, 09:02, Viresh Kumar wrote:
> > > > On 13-10-23, 19:20, Robert Marko wrote:
> > > > > IPQ8074 comes in 3 families:
> > > > > * IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
> > > > > * IPQ8172/IPQ8173/IPQ8174 (Oak) up to 1.4GHz
> > > > > * IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz
> > > > >
> > > > > So, in order to be able to share one OPP table lets add support for IPQ8074
> > > > > family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.
> > > > >
> > > > > IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
> > > > > will get created by NVMEM CPUFreq driver.
> > > > >
> > > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > > > Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > > > ---
> > > > > Changes in v6:
> > > > > * Split IPQ8074 from the IPQ8064 as IPQ8064 has additional dependencies.
> > > >
> > > > Applied. Thanks.
> > >
> > > And it failed to build, please fix it. Dropped from my tree now.
> >
> > I am looking at the error and it should not happen as the ID-s have
> > been in linux-next for a month now:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/include/dt-bindings/arm/qcom,ids.h?h=next-20231016&id=b8c889bef9797a58b8b5aad23875cc4d04b3efd3
> >
> > They are also part of Bjorns 6.7 driver PR:
> > https://lore.kernel.org/all/20231015204014.855672-1-andersson@kernel.org/T/
>
> But Bjorn's tree isn't a part of the cpufreq tree. In such cases it is
> typical to ask first maintainer to create an immutable branch / tag,
> which can later be also merged into another tree without going into
> troubles of merging the whole tree of the irrelevant subsystem.

Ok, I understand now, the thing is that the ID-s were added for
socinfo initially but recently
I finally had somebody with access to the Oak HW so I added them to
cpufreq as well.

What can I do to help this get resolved?

Regards,
Robert
>
>
> --
> With best wishes
> Dmitry
