Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43A2751C51
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjGMIzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbjGMIzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:55:10 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ED51BB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:55:08 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-caf3a97aa3dso428001276.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689238508; x=1691830508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mvy/EMrBnpulduSmMNLqJP+nI2s3mvHLILhwx65lZzg=;
        b=n/4CMkr4qcI041dReHtmELq5ltPXDA8cbnDEnrDVW/N4+L5e3L8ni+CbAxQU/e4eP5
         s81fZfsz295AJttgBoNxIGX7U2yru2axJ6M4pCLjn7tHYzkeHlvKC/0TD8ek3UphWmVp
         05dFtg+DPS8skpG2b2VeGgh/Pt+5p38QTvjygKPWS47F5bmcjEH87Js6jWz5+SLT+dPZ
         PZJPf0M1fHyqW5i/uzrhIrvPn5QbXq9KgS12S/A896e+ZLcYxOz2AkgHYX21oDVgDRQh
         6NlYsNu4CcVtjDqZ28LpwMt2g4ZdYNNt1tV22wathsGULaafqPHisoq8qZ2VlxDtkLZm
         u/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689238508; x=1691830508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mvy/EMrBnpulduSmMNLqJP+nI2s3mvHLILhwx65lZzg=;
        b=e3WYW/DCbRACSA0W6KVhgyww2f/veLV4bhJ8EUgb9InsFOh3iv5u8zTTTtIjOzXNRC
         2C2wtczy/rrtQcxS9kd/2KZcEOOOK/+L+jGh4Crq49TuZptmHLQIbMXh5MDTnWECc9kk
         EIj7msVg06n3gi+Id/ZoqsmvEldU9w48KH3ES5BgAznVxaMJuDunslKdOyuRXgwG2PW8
         CZ9SkokT4VpwijLuBdeWZPwMUoKLvXgtt9YaxXKZNFGptZjiVm2mZpIB354OzaVMzBLY
         z3DlX4xFa709EhWszMtcpmIv5D8n7SKmzZdttNw2JLcF1PxVJoc+pEI7g+HQ7UPn1XLs
         +Ysg==
X-Gm-Message-State: ABy/qLaYYLn0colKV4xFWRdMR/zHQBdl7ysldmQvG2T6B4XZCWhWlaQJ
        NNmu7eWdU62jq1XK8cq54pUo1CvywYTKuazEWBvzZg==
X-Google-Smtp-Source: APBJJlHLk2NajIUnrpoa5kWE3qfd685DCFLowb3S1Uu55NjcG42lVYQrHMU7nHsK/lAXhXD6MXiXp51m+5u94OlNxT0=
X-Received: by 2002:a0d:c884:0:b0:579:e8de:3580 with SMTP id
 k126-20020a0dc884000000b00579e8de3580mr1101134ywd.9.1689238507937; Thu, 13
 Jul 2023 01:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <1687246361-23607-1-git-send-email-quic_taozha@quicinc.com>
 <1687246361-23607-10-git-send-email-quic_taozha@quicinc.com>
 <2023062024-sincere-tripod-95dc@gregkh> <3aca4a55-0dc7-b34c-d2c0-111a96c33ec3@quicinc.com>
 <e82385f1-de55-4c70-5c5c-35b93a5b2488@arm.com> <d3849c2a-8826-62a7-1749-0d4b3ee47259@quicinc.com>
In-Reply-To: <d3849c2a-8826-62a7-1749-0d4b3ee47259@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 13 Jul 2023 09:54:56 +0100
Message-ID: <CAJ9a7VgRFDFoZgRQ_J62We7vJ2D_yULH18S5FwAnB4S+oi2npA@mail.gmail.com>
Subject: Re: [PATCH v6 09/13] Add nodes for dsb edge control
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Tao,

On Wed, 12 Jul 2023 at 14:53, Tao Zhang <quic_taozha@quicinc.com> wrote:
>
>
> On 6/20/2023 9:41 PM, Suzuki K Poulose wrote:
> > On 20/06/2023 09:31, Tao Zhang wrote:
> >>
> >> On 6/20/2023 3:37 PM, Greg Kroah-Hartman wrote:
> >>> On Tue, Jun 20, 2023 at 03:32:37PM +0800, Tao Zhang wrote:
> >>>> Add the nodes to set value for DSB edge control and DSB edge
> >>>> control mask. Each DSB subunit TPDM has maximum of n(n<16) EDCR
> >>>> resgisters to configure edge control. DSB edge detection control
> >>>> 00: Rising edge detection
> >>>> 01: Falling edge detection
> >>>> 10: Rising and falling edge detection (toggle detection)
> >>>> And each DSB subunit TPDM has maximum of m(m<8) ECDMR registers to
> >>>> configure mask. Eight 32 bit registers providing DSB interface
> >>>> edge detection mask control.
> >>>>
> >>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> >>>> ---
> >>>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  32 +++++
> >>>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 143
> >>>> ++++++++++++++++++++-
> >>>>   drivers/hwtracing/coresight/coresight-tpdm.h       |  22 ++++
> >>>>   3 files changed, 196 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git
> >>>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> >>>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> >>>> index 2a82cd0..34189e4a 100644
> >>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> >>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
> >>>> @@ -60,3 +60,35 @@ Description:
> >>>>           Bit[3] : Set to 0 for low performance mode.
> >>>>                    Set to 1 for high performance mode.
> >>>>           Bit[4:8] : Select byte lane for high performance mode.
> >>>> +
> >>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl
> >>>> +Date:        March 2023
> >>>> +KernelVersion    6.5
> >>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao
> >>>> Zhang (QUIC) <quic_taozha@quicinc.com>
> >>>> +Description:
> >>>> +        Read/Write a set of the edge control registers of the DSB
> >>>> +        in TPDM.
> >>>> +
> >>>> +        Expected format is the following:
> >>>> +        <integer1> <integer2> <integer3>
> >>> sysfs is "one value", not 3.  Please never have to parse a sysfs file.
> >>
> >> Do you mean sysfs file can only accept "one value"?
> >>
> >> I see that more than one value are written to the sysfs file
> >> "trigout_attach".
> >>
> >>>
> >>>> +static ssize_t dsb_edge_ctrl_show(struct device *dev,
> >>>> +                       struct device_attribute *attr,
> >>>> +                       char *buf)
> >>>> +{
> >>>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
> >>>> +    ssize_t size = 0;
> >>>> +    unsigned long bytes;
> >>>> +    int i;
> >>>> +
> >>>> +    spin_lock(&drvdata->spinlock);
> >>>> +    for (i = 0; i < TPDM_DSB_MAX_EDCR; i++) {
> >>>> +        bytes = sysfs_emit_at(buf, size,
> >>>> +                  "Index:0x%x Val:0x%x\n", i,
> >>> Again, no, one value, no "string" needed to parse anything.
> >>
> >> I also see other sysfs files can be read more than one value in other
> >> drivers.
> >>
> >> Is this "one value" limitation the usage rule of Linux sysfs system?
> >>
> >> Or am I misunderstanding what you mean?
> >
> > Please fix the other sysfs tunables in the following patches.
>
> List a new solution for the similar cases below, please see if this
> design is reasonable?
>
> 1. Two SysFS files("dsb_edge_ctrl_idx" and "dsb_edge_ctrl_val") will be
> created in this case.
>
> 2. First write to the node "dsb_edge_ctrl_idx" to set the index number
> of the edge detection.
>
> 3. Then write to the node "dsb_edge_ctrl_val" to set the value of the
> edge detection.
>
> For example, if we need need to set "Falling edge detection" to the edge
> detection #220-#222, we can issue the following commands.
>
> echo 0xdc > tpdm1/dsb_edge_ctrl_idx
>
> echo 0x1 > tpdm1/dsb_edge_ctrl_val
>
> echo 0xdd > tpdm1/dsb_edge_ctrl_idx
>
> echo 0x1 > tpdm1/dsb_edge_ctrl_val
>
> echo 0xde > tpdm1/dsb_edge_ctrl_idx
>
> echo 0x1 > tpdm1/dsb_edge_ctrl_val
>
> If this design is acceptable, we will rewrite other similar nodes based
> on this solution.
>

This index / value model is used in the coresight drivers so should be
OK - eg etm4 has cntr_idx / cntrldvr / cntr_val / cntr_ctrl, where
index selects the counter, and the other val registers are applied to
that counter.

Mike

> Let me know if you have any concerns or good suggestions for this solution.
>
>
> Best,
>
> Tao
>
> >
> > Kind regards
> > Suzuki
> >
> >



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
