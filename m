Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AAC7705DD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjHDQYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHDQYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:24:05 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4B049CB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:24:04 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-4475ae93951so1013714137.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20221208.gappssmtp.com; s=20221208; t=1691166243; x=1691771043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmkPH1Bvr/jHuXA813MIlzTOyB5g7yoVu7rMhg38M04=;
        b=XnI4Z6pkgjcmwtZpv8x6FMkee1/nibtf7Ma/Bxz1Z3xMUHTxRp7FGYhpBQudDChZXX
         qP+kzEQ9lw5o8Yj/sUnF7h5Wb82rIzuxXhfPad0xDXifitsP4yRPzL270zEf5zVZgfwt
         1eDuI5+7HvHW1qWSAfkz8yQWcQsDdT1mIIsPfclZx654XRFuZg0xSCLKm1ql0koFaDYw
         L2Ju/zD2mZEl2v6c+79OyU/DnpOvN7hlw5K3aPENfkdXLdQ0/pAGpggRTiq/CaaxFRwM
         1s7QOW8h3djqEk9l6jc4o9QJbDcDP2wJwwkmJGxa2+vbtpxfNzoXRrJQNdIuP/AfpcSM
         mx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691166243; x=1691771043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmkPH1Bvr/jHuXA813MIlzTOyB5g7yoVu7rMhg38M04=;
        b=KACKNgDWlYtlchYcAyOBJ16i8RBBAlTuFyQuPPiPAAp11dcBUy97RCvyg6Tm1ErPFL
         w6bvoKWwM+FbFWZVioPrOYXdlLogCkUmQoYi7FjSov42qfZbyIezJ145IRJBFaMrh5vZ
         y7p2kzb7s6LvgHScA5PgVB+9ykblTAKcJLY2nx6pJIjdLZO2R4xZ9+mMpJBVpQgXW+Tm
         oFjN43R1NmToC+y/0wz+Vf4TG+GKB0d+KnDaMnVljcPn2kPtV0Y/DsfqJiEAmCVTumKH
         zMkyo1WXO0xXG5xG/Dj7tpqYeLFZY2NvstmbrPzk1yj3qqUe6BB06qwuz1PwKYkVfNis
         9C3w==
X-Gm-Message-State: AOJu0YxCpl6Tav/TK9TTqjGVa+kPIaudG4X8u7Z1LqBZLxZ200XXd55K
        xSJGtEWFp7960hmZb2v7kKu7JBZn+1nyHtfPU3uGBg==
X-Google-Smtp-Source: AGHT+IGI+M2wXRRcEDRe0zlkG6F9e0Pa2pCE+U3TAl/AgeY1J+EybttwtFgXosRog6vBFBA4Gmufj5GHXTGOx1DCYnc=
X-Received: by 2002:a67:cd0a:0:b0:447:c1fd:4846 with SMTP id
 u10-20020a67cd0a000000b00447c1fd4846mr1835625vsl.22.1691166243247; Fri, 04
 Aug 2023 09:24:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:6209:0:b0:794:1113:bb24 with HTTP; Fri, 4 Aug 2023
 09:24:02 -0700 (PDT)
X-Originating-IP: [24.53.241.2]
In-Reply-To: <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Fri, 4 Aug 2023 12:24:02 -0400
Message-ID: <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com>
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18 (regression)
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023, Rob Herring <robh@kernel.org> wrote:
> On Fri, Aug 4, 2023 at 9:27=E2=80=AFAM Nick Bowler <nbowler@draconx.ca> w=
rote:
>>   commit e461bd6f43f4e568f7436a8b6bc21c4ce6914c36
>>   Author: Robert Hancock <robert.hancock@calian.com>
>>   Date:   Thu Jan 27 10:37:36 2022 -0600
>>
>>       arm64: dts: zynqmp: Added GEM reset definitions
>>
>> Reverting this fixes the problem on 5.18.  Reverting this fixes the
>> problem on 6.1.  Reverting this fixes the problem on 6.4.  In all of
>> these versions, with this change reverted, the network device appears
>> without delay.
>
> With the above change, the kernel is going to be waiting for the reset
> driver which either didn't exist or wasn't enabled in your config
> (maybe kconfig needs to be tweaked to enable it automatically).

The dts defines a reset-controller node with

  compatible =3D "xlnx,zynqmp-reset"

As far as I can see, this is supposed to be handled by the code in
drivers/reset/zynqmp-reset.c driver, it is enabled by CONFIG_ARCH_ZYNQMP,
and I have that set to "y", and it appears to be getting compiled in (that
is, there is a drivers/reset/zynqmp-reset.o file in the build directory).

However, unlike with the other firmware devices, I do not see this driver
under /sys/bus/platform/drivers, and there is no "driver" symlink under
/sys/bus/platform/devices/firmware:zynqmp-firmware:reset-controller

Is there some other config option that I need?  Is the reset driver just
completely not working?

>> Unfortunately, it seems this is not sufficient to correct the problem on
>> 6.5-rc4 -- there is no apparent change in behaviour, so maybe there is
>> a new, different problem?
>
> Probably. You might check what changed with fw_devlink in that period.
> (Offhand, I don't recall many changes)
>
>> I guess I can kick off another bisection to find out when this revert
>> stops fixing things...
>
> That always helps.

I'll do that.

Thanks,
  Nick
