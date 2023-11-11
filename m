Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB577E86F1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 01:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345083AbjKKA3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 19:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345082AbjKKA3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 19:29:47 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BF744B3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:29:43 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c51682fddeso40189181fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699662581; x=1700267381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vc6pY2X/kV1rFostxbU0Y7TflzeE7tCSZzGD8ktPRxY=;
        b=jSAgbWkfaqPN63IjKYHgnYJy7gkJ9DsSiN63/p8YfiK7Dq1QC4+zc66Jj/NtsA6Y/M
         +EpoQtOtHxNPxiqS8ZFhCC4D4K9MKOFMv9xPfWyvDF7y33EiZXOA2ubBILs5nE+J6RCd
         9oQ84lc7z93rLwoEuqkRgdTsHiksPlEug3U9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699662581; x=1700267381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vc6pY2X/kV1rFostxbU0Y7TflzeE7tCSZzGD8ktPRxY=;
        b=dElid4QncBHNl/XogHguDUDVAKWjBDDbnFN6dAPI3EoW/7cryPrzNRUb7cgdC8LYft
         jl+PCt+XJvuVYeI9L1GmQGcjq+kXdVElQBY6JUhFZ678kqwrnKKh8k8lXTPUdSVcEQcS
         1gaEOhiQfEXeCtSVkEWHokr1yKdgjqhScbH0hfqJUvLFhYHLr1ddp8msWbVHXmPAD6IN
         2ld3MHVw7Dw/lSowIeZKdmMebrzefhk9rJ6UqytHJboMsZ/azCauUaTCR/BPvqhq2X9c
         FnNfXfg5DkfnedM8TgPou3rfjPkJOuYsjaspZbDJELh4stPeGygM0wTc9dDqPEoNMdxA
         UU7Q==
X-Gm-Message-State: AOJu0Yx1Pku89qzMB/yXnjYaP/RmtucVzaOXQ8Fl2lmb/hHK0cmn5FgX
        9wNqCv6dY4jqUolirp5wvjR19taxnnfqtwjiIOl+i56l
X-Google-Smtp-Source: AGHT+IGgQ9ebTuEpfoyE+lz0SVYi0pg9MI9g2kXxTUbjgfkCKJ/Ilq8cvYuqcZyxjaH92Yzob2if3Q==
X-Received: by 2002:a05:6512:3049:b0:508:15dc:ec11 with SMTP id b9-20020a056512304900b0050815dcec11mr228708lfb.30.1699662581647;
        Fri, 10 Nov 2023 16:29:41 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id be40-20020a056512252800b00507a62cb135sm99488lfb.179.2023.11.10.16.29.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 16:29:41 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso499e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:29:41 -0800 (PST)
X-Received: by 2002:a05:600c:1c91:b0:405:35bf:7362 with SMTP id
 k17-20020a05600c1c9100b0040535bf7362mr34662wms.0.1699662560938; Fri, 10 Nov
 2023 16:29:20 -0800 (PST)
MIME-Version: 1.0
References: <20231109100606.1245545-1-wenst@chromium.org> <20231109100606.1245545-7-wenst@chromium.org>
 <20231110210443.GA419831-robh@kernel.org>
In-Reply-To: <20231110210443.GA419831-robh@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Nov 2023 16:29:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XARZpeEZo-i+CNTAH=AQrxPfwnzSMXDWx6Pvj4k6cP8g@mail.gmail.com>
Message-ID: <CAD=FV=XARZpeEZo-i+CNTAH=AQrxPfwnzSMXDWx6Pvj4k6cP8g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/7] dt-bindings: arm: mediatek: Remove SKU
 specific compatibles for Google Krane
To:     Rob Herring <robh@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        petr.tesarik.ext@huawei.com, rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 10, 2023 at 1:04=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Nov 09, 2023 at 06:06:03PM +0800, Chen-Yu Tsai wrote:
> > In cases where the same Chromebook model is manufactured with different
> > components (MIPI DSI panels, MIPI CSI camera sensors, or trackpad /
> > touchscreens with conflicting addresses), a different SKU ID is
> > allocated to each specific combination. This SKU ID is exported by the
> > bootloader into the device tree, and can be used to "discover" which
> > combination is present on the current machine. Thus we no longer have
> > to specify separate compatible strings for each of them.
>
> You just broke an existing kernel with a new DT having this change.
>
> Just because you come up with a new way to do things, doesn't mean you
> can remove the old way.

I was wondering about that, actually. My understanding was that what
Chen-Yu was doing here was correct, but I'm happy to be educated.

Specifically, I think that after his series old device trees will
continue to boot just fine. ...so if someone took a device tree from
before his series and booted it on a kernel after his series that
everything would be hunky dory. If that doesn't work then, I agree,
that should be fixed.

However, here, he is documenting what the "latest and greatest" device
tree should look at and that matches what's checked into the "dts"
directory. In general, I thought that yaml files didn't necessarily
always document old/deprecated ways of doing things and just focused
on documenting the new/best way.

Now, obviously, if someone took a new device tree and tried to put it
on an old kernel then it wouldn't work, but I was always under the
impression that wasn't a requirement.


-Doug
