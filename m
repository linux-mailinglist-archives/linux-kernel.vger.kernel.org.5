Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579BD753AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 14:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbjGNM3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 08:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235324AbjGNM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 08:29:02 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64DA3A88;
        Fri, 14 Jul 2023 05:28:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso18227735e9.0;
        Fri, 14 Jul 2023 05:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689337696; x=1691929696;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HsH5BhWMqpapCjo+dPiG/QjqD9vBy5DSGQneLw018qY=;
        b=qi2dMtc6j/ohACXD06K/c1LyKQ4IDpYDzEbLxVCoDfoHcg1voNg31x6vxcDuDnicNG
         3bXK8AXZ5GlnirbSD6Zz4Q+5DcaZZNszReREu2dOvt8xsWFXsHSn0B8JARE5EH4LmlFj
         FoxQfoyVUbbsjH5mo92KoHKwfuYPpLWTZqYmPuDsCevPkIi1X2nDPl5zxTzzNSlC5wi2
         hRZb9I0LzNnDxaACJ/375L5hv56vBLeHpmIXfBZr7X9e40zDNM4tcaopawvzzZ6IT40b
         JpyfnqqKShsS9l+inoIQcGN4uaM0b20g0u/0zbMqSO0ycGKs396DAglxjXbwVDqLyFyP
         HSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689337696; x=1691929696;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HsH5BhWMqpapCjo+dPiG/QjqD9vBy5DSGQneLw018qY=;
        b=IQQcAQApTlPG+wgTwGNAA29qkEnBd/A9fmK2gnUd1lS8OQZh0s8iFFqttFyCd2hqcG
         /gkViyFdE+15AXDbbRmPMeb0Gyyat//xrI+CHHca02BbM8i6XRw+Bz9DJjA+hcGbTIHg
         SjutQOMwvKh5EqOTsVT5gwhcSq9VhGYxoprdmQGEwDBkZOx+a7KmRNUDINpi0/OUtlyt
         tA52VXRy2Mq0LhKjKwmtIEy33nv7VPT/HKXU5tGnC+pBmzB4JEEdUX2/lLQlTkEuQn4C
         5ok+7JD3IDdotIcKErw8dKlyrvJ+8whKIa90hmea9RpFiLc1mhz+eR3Y/vW9/LKdch2X
         7T0w==
X-Gm-Message-State: ABy/qLZNZHwphGBgJYBOIhxHDuVRmKCgQhhBpmHf8+PBYTfxQzmj5dsn
        DwcNQc2R6dYWoVSUmAvzc4DBSa1CYtJinq/m
X-Google-Smtp-Source: APBJJlHJQywVsEdNGq398BgzB8IbvwaHfHsJOA95oLJmnl5vEn113aG8tCQ3cIGcFAbTT0NKUMDu8w==
X-Received: by 2002:a05:600c:2353:b0:3fc:8a:7c14 with SMTP id 19-20020a05600c235300b003fc008a7c14mr4717710wmq.18.1689337695920;
        Fri, 14 Jul 2023 05:28:15 -0700 (PDT)
Received: from [10.0.0.98] (snat-11.cgn.sat-an.net. [176.222.226.11])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bc5d6000000b003fa968e9c27sm1324977wmk.9.2023.07.14.05.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 05:28:15 -0700 (PDT)
Message-ID: <c9ab901161e8c1cc552e8486a847296ce3662be2.camel@gmail.com>
Subject: Re: [PATCH v2] Revert "usb: dwc3: core: Enable AutoRetry feature in
 the controller"
From:   Jakub =?iso-8859-2?Q?Van=ECk?= <linuxtardis@gmail.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mauro Ribeiro <mauro.ribeiro@hardkernel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Fri, 14 Jul 2023 14:28:15 +0200
In-Reply-To: <20230714003032.qcl7jnnm2ou34ucy@synopsys.com>
References: <20230712224037.24948-1-linuxtardis@gmail.com>
         <20230712225518.2smu7wse6djc7l5o@synopsys.com>
         <aad3936c41c6520f6863a859eb4c4cdb5fdc0549.camel@gmail.com>
         <20230714003032.qcl7jnnm2ou34ucy@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On Fri, 2023-07-14 at 00:30 +0000, Thinh Nguyen wrote:
> On Thu, Jul 13, 2023, Jakub Van=C4=9Bk wrote:
> > Hi Thinh,
> >=20
> > On Wed, 2023-07-12 at 22:55 +0000, Thinh Nguyen wrote:
> > > On Thu, Jul 13, 2023, Jakub Vanek wrote:
> > > > This reverts commit b138e23d3dff90c0494925b4c1874227b81bddf7.
> > > >=20
> > > > AutoRetry has been found to cause some issues. This feature
> > > > allows
> > > > the controller in host mode (further referred to as the xHC) to
> > > > send
> > > > non-terminating/burst retry ACKs (Retry=3D1 and Nump!=3D0) instead
> > > > of
> > > > terminating retry ACKs (Retry=3D1 and Nump=3D0) to devices when
> > > > a transaction error occurs.
> > > >=20
> > > > Unfortunately, some USB devices fail to retry transactions when
> > > > the xHC sends them a burst retry ACK. When this happens, the
> > > > xHC
> > >=20
> > > For some clarity: if the device continues to respond with CRC
> > > error,
> > > the xHC will not complete endpoint related commands while it
> > > keeps
> > > autoretry.
> >=20
> > Acknowledged. Do you think it it would be better to respin this
> > patch
> > once more to include this in the changelog?
> >=20
>=20
> It'll be better to provide more detail. However, I'm fine whether you
> want to send v3 with this or not.

The urge to scratch the itch was too strong :D I have sent a v3 in
https://lore.kernel.org/linux-usb/20230714122419.27741-1-linuxtardis@gmail.=
com/
with an updated changelog.

>=20
> Thanks,
> Thinh

Thanks,
Jakub
