Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292A77E86D7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 01:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjKKAMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 19:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjKKAMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 19:12:51 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C422B448C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:12:48 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so417465166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699661564; x=1700266364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdD5p4ZJ2xs0jbe3PMitwqM3ZIGCltDGGJH36M99UsU=;
        b=fqYN2+rU2CvlaGYYA/V27aZdltIgkzZH8YgqjH8HLg3rgfCTTVe4slozxyHFuecxjl
         4z3sZ3i0lkHvoVY47sx3Y5n2CnAIypGMJTe7rsujmeiAGmOduRJCbX0mntKmi7L/wvzL
         t7y5Sjy+2HRGt4BzJzFDVDLNlhjCuOt7uITjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699661564; x=1700266364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdD5p4ZJ2xs0jbe3PMitwqM3ZIGCltDGGJH36M99UsU=;
        b=dOuZWIoFddJj60O38Yw/RpYD4IsDoSSPFNrMsKRyd1f4hQ7uJHGJcP/VttJZEskQl1
         ik7alvAg3Zgz92Tybwb1gnYoVPuWfqZ6lkk7KZPFZhgZ5RWPophUA5tCHQn46fjm2Loi
         RAR4oq/lwaz9YCJbssxB1aBeWoFXzFvS0oVd8Volv250UqpD61MvCdr7y4GDAccY1x9K
         FFVWkCU66cxmBpkfT3h3u1ybP+LC/0+W1DHduLa/DcQ/rgsiXHnR0OQbtEIJO0Rk29lb
         R2Pu4fSheXWqJufkx4dSJlpVdB0SjBuyHxn4dN5tBI0Tp2xUWSx8t9KBlbxEbHxDt27I
         ct4Q==
X-Gm-Message-State: AOJu0Ywpm0BQLEVWbKoGiYw0f4jGNY4SKr70Jtc7HbOWleiQYieF4q6a
        TReqnwZy53JnCqfgW0sZxd48z9YRRVzohvft7I2cUEgu
X-Google-Smtp-Source: AGHT+IFICVwA9MZH7x1Pf+xMyoal0B7u9O8eVZo3WRmNvmybIg0+HCZW/Go9NxBZlr/HYq8hjVq8gA==
X-Received: by 2002:a17:906:c7ca:b0:9e1:21d:fdb1 with SMTP id dc10-20020a170906c7ca00b009e1021dfdb1mr274723ejb.29.1699661564011;
        Fri, 10 Nov 2023 16:12:44 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id l26-20020a170906231a00b009e50ea0a05asm239073eja.99.2023.11.10.16.12.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 16:12:43 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so2299a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:12:43 -0800 (PST)
X-Received: by 2002:a05:600c:1c11:b0:3f6:f4b:d4a6 with SMTP id
 j17-20020a05600c1c1100b003f60f4bd4a6mr5724wms.7.1699661542490; Fri, 10 Nov
 2023 16:12:22 -0800 (PST)
MIME-Version: 1.0
References: <20231109100606.1245545-1-wenst@chromium.org> <859ac058-c50a-4eb8-99b6-3011ef4e7529@collabora.com>
 <CAL_JsqK64w3+r_LJZoh50PzAUcsvH6ahSDCqgSiKrD3LBAXE9g@mail.gmail.com>
In-Reply-To: <CAL_JsqK64w3+r_LJZoh50PzAUcsvH6ahSDCqgSiKrD3LBAXE9g@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Nov 2023 16:12:06 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VUZy9DaZgKafSpXXopD5k8ExGSR97BjAqC5tupPoxNfQ@mail.gmail.com>
Message-ID: <CAD=FV=VUZy9DaZgKafSpXXopD5k8ExGSR97BjAqC5tupPoxNfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] of: Introduce hardware prober driver
To:     Rob Herring <robh+dt@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 9, 2023 at 5:52=E2=80=AFAM Rob Herring <robh+dt@kernel.org> wro=
te:
>
> > > End of background from Doug's cover letter.
> >
> > I think that using "status" is not a good idea, I find that confusing.
>
> "status" is what defines a device's state in terms of enabled,
> present, available. That's exactly what we're expressing here.
>
> Now, I do not think we should be mixing the device class (e.g.
> touchscreen) into status. I said this on v1, but apparently that was
> not listened to.

Interesting. I must have missed the "don't mix device class into
status" part. Do you have a link to your post about that? Maybe
there's other stuff I missed... Having the device class stuck at the
end there was at least part of my last post [1] which gathered no
response.

I think one of the reasons that I felt we needed to mux the device
class into status was that it was going to make the code a lot less
fragile. Everything I've seen indicates that you don't want us to
create a "HW prober" node that could be used to provide relevant
phandles for different classes of devices, so the "HW prober" code
needs to either search through the whole device tree for a status of
"failed-needs-probe" or needs to contain per-board, hardcoded,
fully-qualified paths.

I don't think we want to include hardcoded, fully-qualified paths in
the code. That would mean that if someone changed a node name
somewhere in the path to one of the devices that we're dealing with
then it would break.

So if we're searching the whole device tree for "failed-needs-probe"
then we need to figure out which devices are related to each other. If
a given board has second sources for MIPI panels, touchscreens, and
trackpads then we need to know which of the "failed-needs-probe"
devices are trackpads, which are touchscreens, and which are MIPI
panels. Do you have any suggestions for how we should do that? Maybe
it was in some other thread that I missed? I guess we could have a
board-specific table mapping (compatible + node name + reg) to a
class, but that feels awkward.

[1] https://lore.kernel.org/r/CAD=3DFV=3DUjVAgT-febtj4=3DUZ2GQp01D-ern2Ff9+=
ODcHeQBOsdTQ@mail.gmail.com
