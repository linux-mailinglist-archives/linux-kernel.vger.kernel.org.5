Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F77E802A60
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjLDCkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDCkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:40:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D4DC3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 18:40:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE94C433C7;
        Mon,  4 Dec 2023 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701657630;
        bh=+1h7orpNR6s8aU7j2WouWuvwhoBP56nu407wmiCjx6o=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=sqWUdAghbTGgJmbgMKCZNEYQLXSRx8zdfcx1nDdIJqXu+okcOeYaOIg/8c30Q6Kjv
         upHpZS/ldRcH3EASHRlREI3D4FKPti1iHTYJsYcBbGj7XRSHMDNaYYai9laZbyds7s
         t2cxOLLWckmgK/D7yFCHaVeR1dMsExdzTyg5+TPgPVbbq1oBH0z7Oi9CjlsAOyDCYt
         qHIKdpX5M4SrCvntX1kV3zkdHREgQclWKGvdGIgYsxfwTRnaL2V9MS32TfVaofsIa1
         3z+TeriMuScbayosVDhERIhhVn+2zWATcGcjKb1eOyvPVmZ4VOjeI23S+zCIGid4yk
         11SnCC11JKZsg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 04 Dec 2023 04:40:24 +0200
Message-Id: <CXF7A8PSEKNX.SM7LV367AYHW@suppilovahvero>
Subject: Re: [PATCH v6 4/8] tpm: Update struct tpm_buf documentation
 comments
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Stefan Berger" <stefanb@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "James Bottomley" <James.Bottomley@HansenPartnership.com>,
        "William Roberts" <bill.c.roberts@gmail.com>,
        "David Howells" <dhowells@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        "Jerry Snitselaar" <jsnitsel@redhat.com>
X-Mailer: aerc 0.15.2
References: <20231124020237.27116-1-jarkko@kernel.org>
 <20231124020237.27116-5-jarkko@kernel.org>
 <ba84a7c1-f397-45f3-b76c-7faed89a005d@linux.ibm.com>
In-Reply-To: <ba84a7c1-f397-45f3-b76c-7faed89a005d@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 27, 2023 at 10:41 PM EET, Stefan Berger wrote:
>
>
> On 11/23/23 21:02, Jarkko Sakkinen wrote:
> > Remove deprecated portions and document enum values.
> >=20
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v1 [2023-11-21]: A new patch.
> > v2 [2023-11-24]: Refined the commit message a bit.
> > ---
> >   include/linux/tpm.h | 9 ++++-----
> >   1 file changed, 4 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index bb0e8718a432..0a8c1351adc2 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -297,15 +297,14 @@ struct tpm_header {
> >   	};
> >   } __packed;
> >  =20
> > -/* A string buffer type for constructing TPM commands. This is based o=
n the
> > - * ideas of string buffer code in security/keys/trusted.h but is heap =
based
> > - * in order to keep the stack usage minimal.
> > - */
> > -
> >   enum tpm_buf_flags {
> > +	/* the capacity exceeded: */
>
> was exceeded

+1, agreed a better form :-)

>
> >   	TPM_BUF_OVERFLOW	=3D BIT(0),
> >   };
> >  =20
> > +/*
> > + * A string buffer type for constructing TPM commands.
> > + */
> >   struct tpm_buf {
> >   	unsigned int flags;
> >   	u8 *data;
>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

If possible give this to the James' patch set, thank you for the review.

BR, Jarkko
