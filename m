Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BEC810C00
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378765AbjLMIHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378737AbjLMIHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:07:16 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE97CF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 00:07:22 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231213080721epoutp029742ba52e40560fa0274adcac88d4fbf~gVah6YYva1093210932epoutp02e
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:07:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231213080721epoutp029742ba52e40560fa0274adcac88d4fbf~gVah6YYva1093210932epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1702454841;
        bh=8DBEfKhO5bOCflDZ3s6qdr88OCyLEq32tUFVZ7+rRTY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=o4k633YqpYaSCu7LSGGlocJQss7v5QeTirZC60+VKJUnHFGEMsf0bzH99tWaVKUPn
         Y9DBCh4qHDUyj3jdBOANoMdprs5d5i+/hkxRLZYpCzcQgFz9ubdx0xSW2Y9NTdOwuV
         vuFmKUCgXSykxglu89MCTe59SwaK3NyIcMHE3HeQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20231213080720epcas5p3b6cbf52b14f56f7548b83ec10659b97d~gVahNQHMA0084000840epcas5p37;
        Wed, 13 Dec 2023 08:07:20 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Sqp4627Nsz4x9QS; Wed, 13 Dec
        2023 08:07:18 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.FC.09634.63669756; Wed, 13 Dec 2023 17:07:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20231213075954epcas5p25c9ee8145fcc497b97c7bc60c4c61fcf~gVUBjuj191628416284epcas5p2T;
        Wed, 13 Dec 2023 07:59:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231213075954epsmtrp1a3c28cda502007d6db0a9e07d49583e3~gVUBibPC01629516295epsmtrp15;
        Wed, 13 Dec 2023 07:59:54 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-8b-657966362f87
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.7A.08755.97469756; Wed, 13 Dec 2023 16:59:54 +0900 (KST)
Received: from FDSFTE308 (unknown [107.122.81.79]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231213075951epsmtip17f3490f1b5ca2613437f1a09bd105174~gVT_2kDWr0705607056epsmtip1G;
        Wed, 13 Dec 2023 07:59:51 +0000 (GMT)
From:   "Aakarsh Jain" <aakarsh.jain@samsung.com>
To:     "'Hans Verkuil'" <hverkuil-cisco@xs4all.nl>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     <m.szyprowski@samsung.com>, <andrzej.hajda@intel.com>,
        <mchehab@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <andi@etezian.org>,
        <gost.dev@samsung.com>, <alim.akhtar@samsung.com>,
        <aswani.reddy@samsung.com>, <pankaj.dubey@samsung.com>,
        <ajaykumar.rs@samsung.com>, <linux-fsd@tesla.com>,
        "'Smitha T Murthy'" <smithatmurthy@gmail.com>
In-Reply-To: <2c9b85dc-ebd7-43a7-bb66-d96ba9a28082@xs4all.nl>
Subject: RE: [Patch v5 09/11] media: s5p-mfc: Load firmware for each run in
 MFCv12.
Date:   Wed, 13 Dec 2023 13:29:49 +0530
Message-ID: <108e01da2d9a$5b177b50$114671f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGxC9E1LlEO2hL9VA6VgqHuySwLQAFrqdTcAuqPrBsBx+Y2QrDIK6aQ
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHvY++YDV30IUzog7vdAkYoNXSnRKZW3SmjmWyEPdwyeCuvTxG
        aZt7C44lm4yHbA7ZQBnSIMhDdJ2Iq7QDLIq16ECEgAyDwKQRB4hBB/LodHNtL2789znf8/ud
        7/mehxALmOcHC1N1RprRUVqS74fbLoeGhSuSsmhpYdNq2P7gEg7HKm18WLs0gcLbtXM4dJyz
        CuDpth4UVjl7eHCovQWFfeWjOCyadGHQcmeQB1333oc3Wiv4sPCslQeP9l5AYYNzVADrLU9Q
        WGN9JID5bU4BzPuqjve6RHWzbhZTtZhGBapa+xSqspi/4atGBu181bm6/aqiJjOi+ifnmEA1
        Z1mn6pqfE8T57U3bmkJTGpoJoXVqvSZVlxxDxsYnbE+IUkhl4TIlfJUM0VHpdAy54+248J2p
        Wk88MiST0mZ4pDiKZcnI17Yy+gwjHZKiZ40xJG3QaA1yQwRLpbMZuuQIHW2Mlkmlm6M8hYlp
        KcVVwzyDKegzW5cTz0bKAg8iIiEg5KAv91f0IOInDCDOIyD7yS0BN5hFwNFDQxg3WEDAj07v
        DNfy7S+ly1VtCPhrxoZ4JwKICQT09WzwMp+IBLe7CnneIgnRjIBq13WfCUZYMdD6sN/XISJi
        QGdDD8/LgcQe4JocwL2MExtBgbnYx2JCCUYdpRjHz4PO8nGfjhGbQH31NMZtKQS479b71pEQ
        O4G98SmPqwkCHe5CXwZAlIlA9+zCcoYdYHiygM9xILh3tWlZDwZT3x1YZjW4UzO1bKAFjfYj
        OMfbQPtAhYeFHoNQ0NgayclrQWnXGZTzXQ0OPR5HOV0Mmiuf8SugYmSJx/EacPmnE8j3CGla
        Ec20IpppRQTT/27HEdyMvEgb2PRkmo0yyHT0vv+uXK1PtyC+9x+2qxkZHXsY4UBQIeJAgBAj
        JeLO5n10gFhDZX1OM/oEJkNLsw4kynPexVjwC2q95wPpjAkyuVIqVygUcuUWhYwMEk/nH9ME
        EMmUkU6jaQPNPOtDhaLgbBQ+HlosSMqXJFZcsfWXzGIvzfw5ruk55b8ZtoeNM0/9m+9Wnuin
        snNOujd9+e4aF+/i7mt7Etf/VlR+tTth+Ozf/Ab39fi8/MyWN36enYqm7AckM43iPzqmR66w
        ueG3Xi7VhS6akQ8OZwwO2pP2Ky+UulJtIjJR+M5HN9/KdLuHWpi83sBF27b4LWp5b/CHUmXL
        mHW3KfDBFIZPimzPlUzEfh39SddCjSxLen9mMPdU9zp3Ff93ZjxlmuyMiXzz2tJeseOIv7rm
        TGW1dX5V/vagdqek44vJi9Gxp6v7BJ0byiqMM8yl9UDPhB9+NLDWnGM5+cN7JUsfn18lz2Ju
        7Pp04j6JsymULAxjWOpfgBRaZYgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsWy7bCSnG5VSmWqwfNeJosD7w+yWDyYt43N
        YvGP50wW9xd/ZrE4tHkru8WaveeYLOYfOcdqcfPATiaLizPvslj0vXjIbLHp8TVWi4evwi0u
        75rDZtGzYSurxYzz+5gs1h65y26xbNMfJotFW7+wW7TuPcJu0dK4hNVBxOP6kk/MHjtn3WX3
        WLznJZPHplWdbB53ru1h89i8pN6jb8sqRo9/TXPZPT5vkvM49fUzewBXFJdNSmpOZllqkb5d
        AlfGyQ9bmQpuilVsvriFsYHxglAXIyeHhICJRPf2qexdjFwcQgK7GSUWnP3EDpGQkfjfdgzK
        FpZY+e85VNFTRonHZ+eDJdgE9CXun+phBUmICOxhlDi6ew1YFbPAYWaJh+cPQ7V8ZpSY3PSV
        DaSFU8BW4uTac6wgtrBAsETjgs2MIDaLgKpE+6qJLCA2r4ClxN1DU5khbEGJkzOfgMWZBbQl
        eh+2MsLYyxa+Zoa4T0Hi59NlYDNFBNwk9qz/zwpRIy5x9GcP8wRG4VlIRs1CMmoWklGzkLQs
        YGRZxSiZWlCcm55bbFhgmJdarlecmFtcmpeul5yfu4kRnAS0NHcwbl/1Qe8QIxMH4yFGCQ5m
        JRHekzvKU4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzir/oTRESSE8sSc1OTS1ILYLJMnFwSjUw
        FRQ/c2LO3hHOl75M9JOh4ddFxopVn6NXfczaIlj+SG5l1trdB5fOFmrezRl/msmFt3Sd4anj
        +Q/0ewTWXdB1L5g0S7XDj/nkm0dXj83qaZyVeevJ7R9zNFonCXxUe6Et8jXOflaghRJD8Hcn
        5t+6nDeUVm+5f69oz8erMix6K7UmHE1qr49x2cMUtUV5p21kwZPJxm+sAuaULcxdUKeTfUWp
        vcmJ74nlZTN2w959FgfijUSO+zQcOSv/63Rohs2SrKgchgSr1Id/765/dCDm3JZNyYwtffGi
        oRxlduL6XZe0HOpyZS/XFmlq5d9wmGS8p3aSk9iCrPwbraVHw2qEH9z4qtkp+C395e0cth4l
        luKMREMt5qLiRABBaw1hcQMAAA==
X-CMS-MailID: 20231213075954epcas5p25c9ee8145fcc497b97c7bc60c4c61fcf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206063134epcas5p2b3b9ca0351cd9c1cb169d7a4a3a30b80
References: <20231206063045.97234-1-aakarsh.jain@samsung.com>
        <CGME20231206063134epcas5p2b3b9ca0351cd9c1cb169d7a4a3a30b80@epcas5p2.samsung.com>
        <20231206063045.97234-10-aakarsh.jain@samsung.com>
        <2c9b85dc-ebd7-43a7-bb66-d96ba9a28082@xs4all.nl>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Hans Verkuil <hverkuil-cisco=40xs4all.nl>
> Sent: 06 December 2023 18:28
> To: Aakarsh Jain <aakarsh.jain=40samsung.com>; linux-arm-
> kernel=40lists.infradead.org; linux-media=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; devicetree=40vger.kernel.org
> Cc: m.szyprowski=40samsung.com; andrzej.hajda=40intel.com;
> mchehab=40kernel.org; krzysztof.kozlowski+dt=40linaro.org;
> robh+dt=40kernel.org; conor+dt=40kernel.org; linux-samsung-
> soc=40vger.kernel.org; andi=40etezian.org; gost.dev=40samsung.com;
> alim.akhtar=40samsung.com; aswani.reddy=40samsung.com;
> pankaj.dubey=40samsung.com; ajaykumar.rs=40samsung.com; linux-
> fsd=40tesla.com; Smitha T Murthy <smithatmurthy=40gmail.com>
> Subject: Re: =5BPatch v5 09/11=5D media: s5p-mfc: Load firmware for each =
run in
> MFCv12.
>=20
> On 06/12/2023 07:30, Aakarsh Jain wrote:
> > In MFCv12, some section of firmware gets updated at each MFC run.
> > Hence we need to reload original firmware for each run at the start.
> >
> > Cc: linux-fsd=40tesla.com
> > Signed-off-by: Smitha T Murthy <smithatmurthy=40gmail.com>
> > Signed-off-by: Aakarsh Jain <aakarsh.jain=40samsung.com>
> > ---
> >  drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c =7C 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> > b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> > index b49159142c53..24dd40ae71ec 100644
> > --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> > +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> > =40=40 -51,8 +51,10 =40=40 int s5p_mfc_load_firmware(struct s5p_mfc_dev
> *dev)
> >  	 * into kernel. */
> >  	mfc_debug_enter();
> >
> > -	if (dev->fw_get_done)
> > -		return 0;
> > +	/* Load MFC v12 firmware for each run when MFC runs sequentially
> */
>=20
> You had a much longer explanation in your reply to my original question.
>=20
> I think it is better if that longer explanation is added here.
>=20
okay sure. Will add that explanation here.

> Things that are weird and unexpected need good comments, explaining why
> it is done, and also what you know and do not know about this.
>=20
> E.g. you know through trial and error that it is needed (or perhaps you g=
ot
> information on this some the fw team), but there might be open questions
> that are not yet answered.
>=20
> This is all information that you can't get from the source code since it =
has to
> do with the black box firmware. So putting all you know in a comment is t=
he
> best way of communicating this to future readers of the source code.
>=20

Thanks for the review=21

> Regards,
>=20
> 	Hans
>=20
> > +	if (=21IS_MFCV12(dev))
> > +		if (dev->fw_get_done)
> > +			return 0;
> >
> >  	for (i =3D MFC_FW_MAX_VERSIONS - 1; i >=3D 0; i--) =7B
> >  		if (=21dev->variant->fw_name=5Bi=5D)


