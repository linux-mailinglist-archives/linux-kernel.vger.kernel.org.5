Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BCA7CA5FE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjJPKrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjJPKrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:47:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F07595
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:47:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9b2cee55056so762254066b.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1697453238; x=1698058038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSOsW3lqyVDGEO7YV9jDSsXKfAhrZdV4NxhIXBreaCc=;
        b=pBi8gtjST3EKU/hV1WHT0yPo59DA4sE3QIMnCRay8JZ8w7YaxCiHoWQCtyqfnBmXrz
         xrAvzRazTpIsEJt7qpzrgxjd5tzqabBaWEaIXhNrpwBBEzecbh4kMQPYencvjr9bAeAf
         sGSSxvOSFay1QRgmq6lW8cCs8a8jqT3f0z/6ISVEwpHqDt299Dgz07fMWgI3SLG59Faz
         V0S5IijJbFwM8L8DobokPi+TnvNvlnCSbEsCyJSKy6/DNeBCSZY67CnrBnuGfVy1Yjmn
         kw/ejxV3dRr++rzSNZolZwJih3ZGQGs1FyJU1Y6GJ+xPSrEXiMjv6P7RMY3FHzrjZN0i
         j2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697453238; x=1698058038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSOsW3lqyVDGEO7YV9jDSsXKfAhrZdV4NxhIXBreaCc=;
        b=JzXwpD+VqRq4p/VsGE70z4e90BRG4hv3DPvpO2VQdOLRb4DPTBRQPBZUEUuLOkc04C
         d45ymxuT8V3SjOMSFu/7lRkE60yIofEF6pfSq1XKsSp4srBUB+VMpZdihsxEueQz/Sli
         6lftMoVaJOvfVOE9KlgM3plh8xoQc7ZWn1W+dvtS12ORYBtpNFWD2NMxtwD/dWj/TLge
         LRsem2SckIGMyC99aVKmEeRZBahlhvZMdkXuwzliZ0rVtn3G5kv04vwGEYg4wHhSgNlI
         VUCqMHXYybLAanrM0H9lJbCPvFm14xo0Ql1zV2KwSruxXlKhmAi83KkyZse+uzvucG76
         RjyQ==
X-Gm-Message-State: AOJu0YxUALUmVY90KCWep9t/BK6o5UfnmVmUpdtqhwjhLSZnDqkAWJZl
        t1sHWzyrWIVDU99mTNFDL9SRSOnTToyH6vRlkH+3s4bozE/bPZlTASc1nw==
X-Google-Smtp-Source: AGHT+IE4rTDIFGCtxkHDTxmHZHJipHKSAGuGG/X+qZH0l607g2QnU10hsXIs4iTRUVFldU+NJUeLfr6IQgVhXcx+8ds=
X-Received: by 2002:a17:907:2cef:b0:9ba:1d08:ad43 with SMTP id
 hz15-20020a1709072cef00b009ba1d08ad43mr19381711ejc.70.1697453237825; Mon, 16
 Oct 2023 03:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231006073831.10402-1-shawn.sung@mediatek.com>
 <20231006073831.10402-5-shawn.sung@mediatek.com> <CAPj87rMUbP12uwzyhV=94wR7LkQK4JfTB4kEMGADq2YJOk8Vrw@mail.gmail.com>
 <c3fff5bcc3a7cfeffcd86d6e2c199963a720871a.camel@mediatek.com>
In-Reply-To: <c3fff5bcc3a7cfeffcd86d6e2c199963a720871a.camel@mediatek.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Mon, 16 Oct 2023 12:47:05 +0200
Message-ID: <CAPj87rMc=3tX8Fbk4LjXmqgPfp=YX3GS64V4Sb5y84xwf3wDBw@mail.gmail.com>
Subject: Re: [PATCH v7 04/23] dt-bindings: display: mediatek: padding: Add MT8188
To:     =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On Mon, 16 Oct 2023 at 06:23, Shawn Sung (=E5=AE=8B=E5=AD=9D=E8=AC=99) <Sha=
wn.Sung@mediatek.com> wrote:
> On Fri, 2023-10-13 at 17:26 +0100, Daniel Stone wrote:
> > If I understand the driver correctly, padding is automatically
> > applied
> > to compensate for unaligned dimensions. The first/last rows/columns
> > of
> > the overlay area will be filled with a specified colour (black?) to
> > preserve the area. This is unfortunately not OK to do transparently.
> > Userspace must be aware of this policy decision and specifically
> > request it. If not, the atomic request check should fail and tell
> > userspace that the requested configuration is not possible to
> > achieve.
>
> Yes, Padding works as you described, users can assign background colors
> for the filled area in 10bit RGB format, however, the rows and columns
> that are filled by Padding will be cropped by the hardware components
> after it to avoid situations as you mentioned, so users should not
> notice any difference.

Thanks for the explanation, I hadn't realised that the added padding
later gets cropped.

Cheers,
Daniel
