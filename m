Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108FB78CEF5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjH2Vta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbjH2VtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:49:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D914ACC3;
        Tue, 29 Aug 2023 14:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us;
 s=s31663417; t=1693345720; x=1693950520; i=fan.ni@gmx.us;
 bh=a9Wnn2WFAKosOzabvPuR9+jFl4rAp8iJnreXsjbwH0Q=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Q2Z27HapZN0BavqN1ThoOPaAeM9dDonJ5ssWsvbCt/tKqCaRa866100nQaG5+7ZxUj5KCGo
 37u+RZc3sLxfhnVvEqh3IdRYXvqvgUAQ/o2gQtS9W6QXxTZgYTX3tMofPNG7pYY+dyc/0ZSbC
 8tr7/bRPxLpVW9h4Gud99qpl6n1Z5d6AEWKdui2CTtq6E3mwiwpw6VAR9YDG8BJ1Qjk3g7dtV
 ybIeOE+TLMtvUGvCUiHXg1FDZysIDdx5gieBSPaIHoTfA2DMTKTCRcEZ6t9srdPzI1m5iWfc5
 vuIVrYJsxwfxPxE4qk4qtnKCIUyuuygYY+Dp3qC4o55+ujlGD73A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([50.205.20.42]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MryXH-1pwnSs2d8v-00nylh; Tue, 29
 Aug 2023 23:48:40 +0200
Date:   Tue, 29 Aug 2023 14:48:28 -0700
From:   Fan Ni <fan.ni@gmx.us>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 01/18] cxl/hdm: Debug, use decoder name function
Message-ID: <ZO5nrKyE/snTdE9D@debian>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-1-f740c47e7916@intel.com>
 <20230829150320.00007f08@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829150320.00007f08@Huawei.com>
X-Provags-ID: V03:K1:NHousnP49LQdt2FZt+BuG85wA2deMqMCR17CP+ov3XNePx0V9t9
 khkmI1CQj09ejvZB5jI4lHuZmwkf8y5MlnOlnzVXxo39oUhLEu8d05qGEJ3nZ+LKCu80rJ8
 oCbzOtkAa2/mK3NYIcmuRcSM4s7aMgOEH2YV85ZV6hPsAIyHnCtFTnlaT6rjOdSpjRjPlZq
 lHlc9XN6whtMGiryLt+rg==
UI-OutboundReport: notjunk:1;M01:P0:UbirIdvpEZQ=;83OU6fRnDwzmVaJV+wlbK60rZd5
 117TRmSHk4n+1HFQGiNhVuGwWdRfdCmPSCmtOgErCymN7CR2KUDXhbL80+JQmEYFmCQy5gUuE
 /EleYr9WRqJ/SW22jvhp5guDV6SDfsq0kJSfv442/l9y1KJ0qjbng0NDyDsNNkmKABQVG5c3w
 NXt+G7tk1ulcBngi+h7mYjXsZNQYTRCkjZ0B5TVgwjBnrZnqpvO94zoCRWDsVcPUqxVzkJrmH
 BFwiDdsLicuZ37+Eoc1l1LCKFBm7dIKUwyhnqGhe/2xgGsJpgLpWRYXpuwhkUc201ZSOU5b3u
 5Y2T+jrY7SY3H57NAXTeRUxSeLaOEWR5YmkfJcXwjGSrUwvtADceirgCpuEfMk968S7C0q4BI
 8iG9WMcA0KiOGY+ImvA4wwMPAkH/3Gbw/Xn90iOVL93ETL+POPju537C+ojSjpUsAhnQyndfX
 nqULu8w0QynHAiwneu9OWmACSGyjPCIV1f94kQCaT64VfuWRwMZ2jnFkXbm+VBC4/Rs+d3in6
 57eAXDClJ0IFkoPq4vDFv2yxlfzb1T64HlnOwetwGoHDyTP0bnRA0QnH9nnZO3EXL6NRk8fL4
 A9EHTYunZ3/QszrofB5QhNHOvPehyCN+YhED9+F15BtQHxsff/mwA+S/fVOw1hg6AagcO9557
 03nDeNxJ522kqmXif+JPgV1lH4RzS5/dbEWdWzhH1NfbMBu8mOzv9n+DLq6v3kiRMleZDKSoi
 6ZWKAgu5YerHMZLnsl9ONIrAdXRHEZaHCT5DcY7Doo4sd8XtmQMDot2946XWYXc5wZK4LQ0i6
 xDngN1Q01A1wu0dsVZUFUeF2bZoI2Q3uhkcrwREQw8o1bjTobsD4MvIO7jb9ElvCbGlyd+roK
 fNdUdv0FRXcKI67TQdQl45C39t7Sse2/dosznCtseU7Wkgjp1Sa3Av/zV+BXvtnPDYXHC8O6c
 p8Qjxg+xJw63eiLAk6Yct+7MSG0=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 03:03:20PM +0100, Jonathan Cameron wrote:
> On Mon, 28 Aug 2023 22:20:52 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
>
> > The decoder enum has a name conversion function defined now.
> >
> > Use that instead of open coding.
> >
> > Suggested-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> >
>
> Perhaps pull this one out so it can go upstream before the rest are read=
y,
> or could be picked up from here.
>
> Whilst we probably won't see the other decoder modes in here, there
> is no reason why anyone reading the code should have to figure that out.
> As such much better to use the more generic function.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>

Agreed. This patch can be pulled out and picked up before the rest.


Reviewed-by: Fan Ni <fan.ni@samsung.com>


> > ---
> > Changes for v2:
> > [iweiny: new patch, split out]
> > ---
> >  drivers/cxl/core/hdm.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index b01a77b67511..a254f79dd4e8 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -550,8 +550,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxl=
ed, unsigned long long size)
> >
> >  	if (size > avail) {
> >  		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
> > -			cxled->mode =3D=3D CXL_DECODER_RAM ? "ram" : "pmem",
> > -			&avail);
> > +			cxl_decoder_mode_name(cxled->mode), &avail);
> >  		rc =3D -ENOSPC;
> >  		goto out;
> >  	}
> >
>
