Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDAD79CF0E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjILK7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbjILK7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:59:21 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E886D1BD3;
        Tue, 12 Sep 2023 03:59:07 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52f9a45b4bdso964214a12.3;
        Tue, 12 Sep 2023 03:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694516346; x=1695121146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSjAV50mzzuBwUuWzubFBOy6ZN6AN1zxdq6niZtKUvk=;
        b=CoxOiYUqQjpzbgywNRl45LHf2AvfBq/IO7smZIroXZ7jn6ZmGnbSDcXRZIYUF43hPV
         jTHV1RRkKkfOTZ3sShzMv6oLkFL+Cp3k/SDi+6NrYSRJMVmG54gbbCzqJAkvFUi6EmBo
         F5f6I7sEzPtiY8yEvXPf0JaXFJPwosAKNvWiIMLwv+3mjRwYoqCJeQTH4+eN3o3zsBpw
         HZvSvbQdrWZIiI3he+k4fIT6+thMjm7HwcMrZ2D4LKa775nqn9dKuXSjSr0GWxQTUEKH
         r+ujHAUwAw3tFW8B8rJneHB/DF/7nzCRtywaXhiaWPtyao8l6k32AZ+eAeMqjznRGqno
         oWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694516346; x=1695121146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSjAV50mzzuBwUuWzubFBOy6ZN6AN1zxdq6niZtKUvk=;
        b=Et36openYhO7PLfS1DwOQmz0B6InD2nDcgySFWud4owqQJ4X56Ug1myCW3pLxIM0p3
         K3H5X5aKDeEiTCX6mlRfdNuiqLcYJdt/nyD1DZWgHXbeiqVuYlxeFjlYARXel5JvSFIO
         Yt6StImN/qrtgpncDeqFc19bBGRApyjOSRVYixHi5E0FGnSHdNlYJ8IaGJdhxHeQAmhC
         Hzy2l1aQFEiF0MMTa1EqCi3PQA6TFXdhiM4I1qon4svNreRuBBs9K4u5haCLip6nsRKK
         G6D1539W4TExRFFo1wn9JT4b55NdFC5IsDcpVds0815YFNY5EMr4nt3iPslXnttJ49Vo
         jRZQ==
X-Gm-Message-State: AOJu0Yw/SBRLg49d1gtHn1AG/EeT+J7pE3IzPnKpdT+yu800iMigpQQb
        0iSXzMRlvyF6DapF9gbiHxycoFSU5mCap34AZLin4iNYk0U=
X-Google-Smtp-Source: AGHT+IEVlCFZ4tSz7ghuMvzE2ZMqsSJmCuli63W1krUOaTprZPVF86p3T5FDia81qb/VXQvCbVb+UB4DHRiFJTa9ht0=
X-Received: by 2002:a17:907:75f3:b0:99e:1201:48bc with SMTP id
 jz19-20020a17090775f300b0099e120148bcmr9611486ejc.64.1694516345570; Tue, 12
 Sep 2023 03:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230911224452.15739-1-iuliana.prodan@oss.nxp.com>
 <20230911224452.15739-3-iuliana.prodan@oss.nxp.com> <67de5706-d966-dd71-85c3-c95bc1b72733@linaro.org>
 <c0b32f41-46b4-81ad-9718-5f0856e42cb1@nxp.com> <32287c0a-e3c1-e474-3c90-913fe2c79879@linaro.org>
 <fe47a94e-6788-a5ee-e8ee-ca58e4fa62d6@nxp.com>
In-Reply-To: <fe47a94e-6788-a5ee-e8ee-ca58e4fa62d6@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 12 Sep 2023 13:58:51 +0300
Message-ID: <CAEnQRZA7SJ5b_JWSk_GynikKC1rkxiB_cz3Ps6TYRQnDpQbyow@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp: add reserve-memory nodes for DSP
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>, linux-imx <linux-imx@nxp.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:54=E2=80=AFPM Iuliana Prodan <iuliana.prodan@nxp=
.com> wrote:
>
> On 9/12/2023 11:26 AM, Krzysztof Kozlowski wrote:
> > On 12/09/2023 10:13, Iuliana Prodan wrote:
> >> On 9/12/2023 10:07 AM, Krzysztof Kozlowski wrote:
> >>> On 12/09/2023 00:44, Iuliana Prodan (OSS) wrote:
> >>>> From: Iuliana Prodan <iuliana.prodan@nxp.com>
> >>>>
> >>>> Add the reserve-memory nodes used by DSP when the rpmsg
> >>>> feature is enabled.
> >>>> These can be later used in a dsp node, like:
> >>>> dsp: dsp@3b6e8000 {
> >>>>    compatible =3D "fsl,imx8mp-dsp";
> >>>>    reg =3D <0x3b6e8000 0x88000>;
> >>>>    mbox-names =3D "tx0", "rx0", "rxdb0";
> >>>>    mboxes =3D <&mu2 2 0>, <&mu2 2 1>,
> >>>>            <&mu2 3 0>, <&mu2 3 1>;
> >>>>    memory-region =3D <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
> >>>>            <&dsp_vdev0vring1>, <&dsp_reserved>;
> >>>>    status =3D "okay";
> >>> Drop this example from commit msg, useless and not really correct.
> >> Ok, will drop it. But this is a correct example, is just incomplete.
> > No, status=3Dokay is redundant, thus it is not a correct example.
> ok
> >>>> };
> >>>>
> >>>> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> >>>> ---
> >>>>    arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++++++++++
> >>>>    1 file changed, 12 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/=
boot/dts/freescale/imx8mp.dtsi
> >>>> index cc406bb338fe..eedc1921af62 100644
> >>>> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> >>>> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> >>>> @@ -210,6 +210,18 @@
> >>>>                    dsp_reserved: dsp@92400000 {
> >>>>                            reg =3D <0 0x92400000 0 0x2000000>;
> >>>>                            no-map;
> >>> Please test the patches before sending. This does not build.
> >> I've tested on remoteproc tree, but it seems I missed a bracket when
> >> sending upstream. Sorry abut this, will fix it in v2.
> > No, this is not how testing works. You must test this patch. This means
> > you tested something, then ported patch to entirely different tree,
> > resolved conflicts in buggy way and send it without testing. Nope.
> >
> >> Should I test this on other tree(s)?
> > You test the patch on the tree you send it. What is the point to test i=
t
> > on some old code, cherry-pick with bugs and then send?
> >
> > If you have cross-tree dependencies between subsystem, isn't linux-next
> > for this?

linux-next tree is the tree we want.
