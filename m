Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A76D77A040
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 16:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbjHLOHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 10:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjHLOH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 10:07:28 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29D910DF;
        Sat, 12 Aug 2023 07:07:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-563f752774fso1640159a12.1;
        Sat, 12 Aug 2023 07:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691849251; x=1692454051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gKs+nmXh2okBRRkMC1A5GYGwlm6oKTAGXOM3H5VF5U0=;
        b=L/QP2fuhNg4AWoBTIP2ff3B8Jk1X6Iq12i2GoJOQqYYxSyzGDc9WXSPhmJfiscP2a4
         VvCDHe/kV5yOD2u8YMmdwP/XNQTZCBb2IRgypAmL4A68gSf7qr9U0BPbzSk1+ymKCBgD
         wvbiirbr/TY8eygb8KQBnqyrlayvFb2+SVA2Dhe49EvvDRn9fS5eaOftglqOqS7ig5z0
         NZ2jn3kfcS0kZQsn7c+Q9zQvdtmLgOzH0ZuLipGetVBGv/G+U1G24bf7a19yYN2w1CK0
         SuwStjNiyKIxuGSZ9jJKwoLqlnbMJ/40Oy9BDK47ka8KVaIsyM+9X/OPasSqzQGwH6Xd
         GwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691849251; x=1692454051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKs+nmXh2okBRRkMC1A5GYGwlm6oKTAGXOM3H5VF5U0=;
        b=frHr/xMjuIXcovkE18ogW+rrMPhtp5DiobMSmlsmjbNFeyFkxa+XRj8D2F0tDtHV/Z
         hjKsl/2QvXPOFy7GCV5p7ERkFxWaBPBF9TqGBygfYt0SiDYf3gizujNR+nK/KkR5MLX4
         jWVgVQtvcwo7u/lXS7wlaDJiP7MVZBlAnOQRenjW204Hf+JVEzPn4IPFVuDARJQB0mQ7
         p5M1338BFHbt44bqlCJ1ffRRwPGan8RTNU8tnVVkP8XfteHw7wa5Xui7z24VpPzKa7AA
         qcxbPN79AHjYziZwaxt58BuO03BCBO3VX2KJquuB/0dfVayV6SP+MuyldQix5jFHCYER
         kyzg==
X-Gm-Message-State: AOJu0YzRTLYvbJL/03N5EcJel3535UCBI05axKU0BJxNBNY4JoqNj49l
        hGCp/6tvIFsw8MXr3It6gH9v8ZwT6+myuzDSvfc=
X-Google-Smtp-Source: AGHT+IFXZbA0I/yz6onJu4tTM/i3tiGk1z1edu3AjiBMtQmYt6zUC9gdgcjrXFw4z0fTlxfx5SecXKIVyUESQjCQAKM=
X-Received: by 2002:a17:90b:3b88:b0:268:468b:2510 with SMTP id
 pc8-20020a17090b3b8800b00268468b2510mr2799380pjb.37.1691849251165; Sat, 12
 Aug 2023 07:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230811210142.403160-1-robimarko@gmail.com> <20230811210142.403160-2-robimarko@gmail.com>
 <4c96210b-4567-4cb5-80bb-7adca6c5f124@linaro.org> <CAOX2RU6X0Tww4UkTKVfc=PLY=RKVJdsm+gomytT0vOydTF+Hnw@mail.gmail.com>
 <7116b473-7f22-43df-af39-81e5f6db4507@linaro.org> <CAOX2RU6nMvpTkGdwBoLJrES5v0qARnDDT6nCVd-DZid7p3pg6Q@mail.gmail.com>
 <e784f70f-3232-42e6-bf4c-67075abd210a@linaro.org>
In-Reply-To: <e784f70f-3232-42e6-bf4c-67075abd210a@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Sat, 12 Aug 2023 16:07:20 +0200
Message-ID: <CAOX2RU7cLoK206hLkfDr+Ry8QgS5F48EEiSbJ+gbGK_xkXBDpA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: qcom: ipq4019-ap.dk01.1: align flash node
 with bindings
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, 12 Aug 2023 at 12:47, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 12.08.2023 11:55, Robert Marko wrote:
> > On Sat, 12 Aug 2023 at 00:56, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >> On 11.08.2023 23:35, Robert Marko wrote:
> >>> On Fri, 11 Aug 2023 at 23:28, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>>>
> >>>> On 11.08.2023 23:01, Robert Marko wrote:
> >>>>> Rename the SPI-NOR node to flash@0, remove #address-cells and #size-cells
> >>>>> as they should be under the partitions subnode and use the generic
> >>>>> jedec,spi-nor compatible.
> >>>>>
> >>>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >>>>> ---
> >>>> You can also do "nandmanufacturer,mx25l25635e", "jedec,spi-nor"
> >>>
> >>> Hi,
> >>> I grepped the vendor U-Boot to make sure it's not being triggered off
> >>> the mx25l25635e
> >>> compatible but the only hit is the IC support itself.
> >>> MX25L25635 was just the original NOR IC Qualcomm used on the board so
> >>> to me it made
> >>> most sense to just use the JEDEC compatible as NOR itself is JEDEC NOR
> >>> compatible.
> >> OK if dynamic identification works fine
> >
> > It should work fine, datasheet is clear that its JEDEC compatible.
> > That being said, I dont actually have the board, just figured it was
> > time for a cleanup as
> > OpenWrt has been patching DK01 and DK04 for ages.
> Hm. Do we know whether there are still users of this boards?

I honestly doubt it as they have been broken in OpenWrt for years and
nobody complained.
So we are currently removing support for them, but I still wanted to
at least fixup the DTS state
upstream.
These boards are not obtainable anymore.

Regards,
Robert
>
> Konrad
