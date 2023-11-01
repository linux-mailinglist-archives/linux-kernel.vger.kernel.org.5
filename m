Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C104F7DDC2C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346855AbjKAEnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 00:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344644AbjKAEnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:43:21 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796F2FC
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 21:43:19 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-457c82cd837so2692898137.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 21:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698813798; x=1699418598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgzUATk4aTDwLV5ETkynjjS36FynkenHN7MQBidatBs=;
        b=SmpH5xchV/kk/yj3fxtZYQJGwRtZ6wfSTVjR3LfLM/EOoRSVUz9GjTl9JAafCsUm68
         za+7rnGBrnELeUycXQi989f+JH0nrEPTKvY0Bar0dkflmp5L87+4dKfMDn6N5bGljoka
         kQy0FJHg6qE3JaoiONtEEd8t5M5jGD/j6UTKftdXScB+xqa27wd1INPtrqQImqVXm2iQ
         ++AhmIGRuI9/oj2tDevmwsmJTDXJ+N2EmQJ3duY1LW80ih6xYu8oHK+doV+BeNzNsNxY
         B7o+prGkK54KPPCsVXtkuv/fXrTP+L1BxQ7NAHhAlw0wlPICpiDmwRNGvqyVs5qxoFY2
         ydpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698813798; x=1699418598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgzUATk4aTDwLV5ETkynjjS36FynkenHN7MQBidatBs=;
        b=YnzvE6EzthrZUJHpk8hCU5M5XfGnfsHhph42egkzs2F7p5vAx+GWOh13ualV+2JgsG
         GcBhlh4bzUMTdJqQIHYmzMfWgbv9DzAIFo8Bf66iFdyTwsvC1a/J5ewrf0Pnq5ikxJjo
         Fe4xUdZWK2msWr0yiUneEoo2juP1/Bbx+kARTQJiETlUwqNqSAEF9Qs8LsejSigDUnwr
         0l3L9mYAih6HgGW+hGpHP1+zfwKYsl+9huy3crkoJMe9Un92ZdapAFZUgAKY/Wem/tpN
         H/1myfXYyXWV6Nc6f30FMFD2fJL5vMQUF1StSpRUQ7cFNyNGyk94Wh4D5w2T+RCf72Nu
         oySg==
X-Gm-Message-State: AOJu0YwDqrFvJOJqL4r4fVEaEThajy/71/ms7bfgtOT8+7xq+kdqAGP+
        WE4oDSYan5a+Wugk/lg0wKG2rEUv5nlkJUqW3xfrRA==
X-Google-Smtp-Source: AGHT+IGiJ2dXrF26oqY/t33QqLa6W5Q3zXHlE16Nhs1v668ybIE4h6rrhKm13xdbut+rPybUdSDFjHkOz/ki7psGPhE=
X-Received: by 2002:a05:6102:471e:b0:457:4645:a339 with SMTP id
 ei30-20020a056102471e00b004574645a339mr13663582vsb.1.1698813798503; Tue, 31
 Oct 2023 21:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231031044021.1162403-1-mnkumar@google.com> <20231031044021.1162403-2-mnkumar@google.com>
In-Reply-To: <20231031044021.1162403-2-mnkumar@google.com>
From:   Naveen Kumar M <mnkumar@google.com>
Date:   Wed, 1 Nov 2023 10:13:08 +0530
Message-ID: <CA+Hc5+6Zb65gL1tCOZ6bYQThVn3HFS_gzj+_P+y-TkrHKw6zbw@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: host: xhci-plat: Add quirk-no-64-bit-support
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        royluo@google.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the reviewers/maintainers I missed in the previous mail to this patc=
h

On Tue, Oct 31, 2023 at 10:10=E2=80=AFAM Naveen Kumar <mnkumar@google.com> =
wrote:
>
> From: Naveen Kumar M <mnkumar@google.com>
>
> This patch exposes the existing quirk XHCI_NO_64BIT_SUPPORT so that dwc3
> clients can also use this flag. Despite HCCPARAMS1 being set to 1 some
> clients may not support 64 bit addressing.
>
> Signed-off-by: Naveen Kumar M <mnkumar@google.com>
> ---
>  drivers/usb/host/xhci-plat.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index b93161374293..d5f37decb7da 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -249,6 +249,9 @@ int xhci_plat_probe(struct platform_device *pdev, str=
uct device *sysdev, const s
>                 if (device_property_read_bool(tmpdev, "quirk-broken-port-=
ped"))
>                         xhci->quirks |=3D XHCI_BROKEN_PORT_PED;
>
> +               if (device_property_read_bool(tmpdev, "quirk-no-64-bit-su=
pport"))
> +                       xhci->quirks |=3D XHCI_NO_64BIT_SUPPORT;
> +
>                 device_property_read_u32(tmpdev, "imod-interval-ns",
>                                          &xhci->imod_interval);
>         }
> --
> 2.42.0.820.g83a721a137-goog
>
