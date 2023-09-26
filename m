Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9947AE334
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 03:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjIZBFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 21:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjIZBFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 21:05:17 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D1310A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 18:05:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so52516575ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 18:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695690310; x=1696295110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zPeeeABDN1yVUniYlgXbdBgCFDUvJ3dL9dEBeDXd3uM=;
        b=ltW9lCAkOf48CSw8sm7igCbvDlMP0TflUyuMxrKCv4IF0S8M85luaYijBAzxzwfn2o
         eeK8cR/oDPgEf9fgQfrIlYXh/WkZVNfPlY57HiR8Czj7dXtC2vFWJkDHKqS71MxPk4lQ
         P4yOchzTDySd9QXSBinMeLjN0bz4VAHFH/Q/nnV6a82AgZdsA0yeSoQFhp99IwiBDPz8
         2zFNbLF7FXxUzo7V0FJqZ7w0lAS43geDx28fNnELEEuXwzViHlY8vVwZO3vPbF3D5Ynx
         7IDfqCHKdfMqWuHP6+Y8xV5r01oKZyxF5aOnmwErfqyCndzHpGy2R4rTi8fYdIT5S+RG
         ywMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695690310; x=1696295110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPeeeABDN1yVUniYlgXbdBgCFDUvJ3dL9dEBeDXd3uM=;
        b=n9SD8fbrFlu1pvMKZvmpwB7MwjW0qjBlqGL4IC5lJrlT1CL3xMMrKhvhCbyHCYYTC6
         /D1gqDgxOyNPALvTew93QiPKqJUHjf/L5PBmiRzxjoewMGmkfoJXBW69YlHyfVL1Pj4h
         CmokAhzQAmc8RHucKnkjhaySkDNqZCxGnshTCAtCXwGiD+dCRrNPe9/emNOMwxrOS0C3
         EWQjGWUAXnv0fTH/ujBgbXQlATO/A6FjexVeqU2a8BBN86zVNcY3iKjsS2HcCHAQzt3v
         ncxpB11rdNaI8MClXU1+yiRbi1RWp0B/BVywNLnA8xisd2vdowWsLyRPDYCM9jD/t6t5
         m23g==
X-Gm-Message-State: AOJu0Yx81c9h1LtWQZgtNMlvkJAIg2kk+hp+y6keCou+812i4VXYvcc8
        1e6lpLMiC88gbsYVjh3zo6T5b+tvVDG1iQ==
X-Google-Smtp-Source: AGHT+IFtbaPRx9ZcLm71gUQXCmeBIEVrED1UkHVP6fQl58iNQS6mQpta6E3uC+Adeusc+MJBq0jTew==
X-Received: by 2002:a17:90b:1243:b0:26d:14cd:fb1a with SMTP id gx3-20020a17090b124300b0026d14cdfb1amr6249159pjb.23.1695690310427;
        Mon, 25 Sep 2023 18:05:10 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a074100b00256799877ffsm9426781pje.47.2023.09.25.18.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 18:05:10 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4883A8DBA76D; Tue, 26 Sep 2023 08:05:07 +0700 (WIB)
Date:   Tue, 26 Sep 2023 08:05:07 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     huangli05 <huangli05@inspur.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     <osmtendev@gmail.com>, <speakup@linux-speakup.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] staging: speakup: Remove repeated word in comments
Message-ID: <ZRIuQ65mCABdhKLk@debian.me>
References: <20230925054559.3857-1-huangli05@inspur.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Px7V2FwQOhhdPJkC"
Content-Disposition: inline
In-Reply-To: <20230925054559.3857-1-huangli05@inspur.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Px7V2FwQOhhdPJkC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 01:45:59PM +0800, huangli05 wrote:
> Remove the repeated word "the" in comments.
>=20
> Signed-off-by: huangli05 <huangli05@inspur.com>
> ---
>  drivers/accessibility/speakup/speakup_soft.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/accessibility/speakup/speakup_soft.c b/drivers/acces=
sibility/speakup/speakup_soft.c
> index 6d446824677b..6549bfb96e7f 100644
> --- a/drivers/accessibility/speakup/speakup_soft.c
> +++ b/drivers/accessibility/speakup/speakup_soft.c
> @@ -446,7 +446,7 @@ static int softsynth_adjust(struct spk_synth *synth, =
struct st_var_header *var)
>  	if (var->var_id !=3D PUNC_LEVEL)
>  		return 0;
> =20
> -	/* We want to set the the speech synthesis punctuation level
> +	/* We want to set the speech synthesis punctuation level
>  	 * accordingly, so it properly tunes speaking A_PUNC characters */
>  	var_data =3D var->data;
>  	if (!var_data)

You have not addressed Greg's patch email bot warnings from your v1 patch
yet [1], so I repeat it:

> - You did not specify a description of why the patch is needed, or
>   possibly, any description at all, in the email body.  Please read the
>   section entitled "The canonical patch format" in the kernel file,
>   Documentation/process/submitting-patches.rst for what is needed in
>   order to properly describe the change.
>=20
> - You did not write a descriptive Subject: for the patch, allowing Greg,
>   and everyone else, to know what this patch is all about.  Please read
>   the section entitled "The canonical patch format" in the kernel file,
>   Documentation/process/submitting-patches.rst for what a proper
>   Subject: line should look like.
>=20
> - It looks like you did not use your "real" name for the patch on either
>   the Signed-off-by: line, or the From: line (both of which have to
>   match).  Please read the kernel file,
>   Documentation/process/submitting-patches.rst for how to do this
>   correctly.

Thanks.

[1]: https://lore.kernel.org/all/20230921021349.3350-1-huangli05@inspur.com/

--=20
An old man doll... just what I always wanted! - Clara

--Px7V2FwQOhhdPJkC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZRIuQwAKCRD2uYlJVVFO
owaFAP45m2M6m+UQ3hKIhl7/GWiKz83TMTo3H91TH6zpSrSwzAEA2WojItEt9nrq
eCe/RUV8SwH4R69wDP7a53zkq9a2JAY=
=9WSw
-----END PGP SIGNATURE-----

--Px7V2FwQOhhdPJkC--
