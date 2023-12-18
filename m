Return-Path: <linux-kernel+bounces-2942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBB7816508
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06593282A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D236ABD;
	Mon, 18 Dec 2023 02:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhOvEPDw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6F6566A;
	Mon, 18 Dec 2023 02:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso2179794a12.0;
        Sun, 17 Dec 2023 18:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702867623; x=1703472423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eaq3cUixvg7MLAz5lkuRSZQtnJ7RqSwvHuV70WHYlCo=;
        b=bhOvEPDwaB1Pd/iNc2tvXcGHYttPnxOoJYqmo2ZTgbySFcLv6x7jnu5IenCXqMbZDd
         +VgxCLBrq6kh2zFDtIkXBYKJ9eIj0oII3o4yLvoCexOdgvkEzqOilePwQ/E6GWc6aZcf
         OlXhG6JG/+n7LSYnHOqciVh6NDFR1hn4MQ31yIA9CBr8uicqKk7wm0Iz2o4MOoXGF9Qd
         iIq9hlzMbJVussTv385q8iAhb1fa3PfPUXA5vVhy2McSZoIhuas9XBg9bJ+iLbL7CFpl
         f4e1z8qhfFeVUgwh2sS27FY8zb5P8gq+zMFI0rhzsd3V14oaiwoHq7UKIviYkTOAe7OI
         oG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702867623; x=1703472423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eaq3cUixvg7MLAz5lkuRSZQtnJ7RqSwvHuV70WHYlCo=;
        b=TvYp33HZBQjxoXi33CoqZpl02lNX3hqi3yLVPctG6ctp1CVrssc2E5EwmsbLAf3a80
         /yizBgaEqG6nmd/U2ZgAmimlorMMPACCbw6cdK9O69pI4O5F5wsb10LrjBP12SLsG7bJ
         XgldKdtxkbqEIoAA1T9xYfqXXS6Joq7Z84vpDDzaFX0nlA+qSWQW1gI8xuMFGGjpVQP6
         D/Rem+1CxmqPHczkQ2cvWyYFpmahDRYKfw9SnHGxlGeJR3dv86dDq/SYLiyzVtb8sB4m
         ggTsvp85SfXZaPdB5L11BBrKnfv5BzwqCKkUPhPrp6NeX4HHe3lG1ngyVcBfrlO6/FPB
         Z3sQ==
X-Gm-Message-State: AOJu0YzrmxY/uRclIfWA0/Jdaem+Nxdj7M7ORxedPQbzcMLMQflNEm7P
	Ir+lqIbIMscrkuwGnV2ia4A=
X-Google-Smtp-Source: AGHT+IFI1PgEgpNBEGIrpCfLhPTXZfQ4tfNXfEy7X61EidMF2NXcLn/lwN+Be08KCbHxutHu0wQsVA==
X-Received: by 2002:a05:6a20:1390:b0:190:43fe:cdfb with SMTP id hn16-20020a056a20139000b0019043fecdfbmr15969272pzc.14.1702867623078;
        Sun, 17 Dec 2023 18:47:03 -0800 (PST)
Received: from localhost.localdomain ([106.13.249.127])
        by smtp.gmail.com with ESMTPSA id y188-20020a6364c5000000b00588e8421fa8sm104373pgb.84.2023.12.17.18.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 18:47:02 -0800 (PST)
From: Yusong Gao <a869920004@gmail.com>
To: jarkko@kernel.org
Cc: a869920004@gmail.com,
	davem@davemloft.net,
	dhowells@redhat.com,
	dimitri.ledkov@canonical.com,
	dwmw2@infradead.org,
	herbert@gondor.apana.org.au,
	juergh@proton.me,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lists@sapience.com,
	zohar@linux.ibm.com
Subject: Re: [PATCH v5 RESEND] sign-file: Fix incorrect return values check
Date: Mon, 18 Dec 2023 02:46:31 +0000
Message-Id: <20231218024631.735225-1-a869920004@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CXNF0UTRENI8.S6ZOFO151V3M@suppilovahvero>
References: <CXNF0UTRENI8.S6ZOFO151V3M@suppilovahvero>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Dec 14, 2023 at 2:25 AM Jarkko Sakkinen <jarkko@kernel.org>
wrote:
>
> On Wed Dec 13, 2023 at 4:44 AM EET, Yusong Gao wrote:
> > There are some wrong return values check in sign-file when call
> > OpenSSL
> > API. The ERR() check cond is wrong because of the program only check
> > the
> > return value is < 0 which ignored the return val is 0. For example:
> > 1. CMS_final() return 1 for success or 0 for failure.
> > 2. i2d_CMS_bio_stream() returns 1 for success or 0 for failure.
> > 3. i2d_TYPEbio() return 1 for success and 0 for failure.
> q
> >
> > Link: https://www.openssl.org/docs/manmaster/man3/
> > Fixes: e5a2e3c84782 ("scripts/sign-file.c: Add support for signing
> > with a raw signature")

Yeah, thanks for point out, I get it. 
I will add it when next time I submit patches.

>
> Given that:
>
> $ git describe --contains  e5a2e3c84782
> v4.6-rc1~127^2^2~14
>
> Should have also:
>
> Cc: stable@vger.kernel.org # v4.6+
>
>
> > Signed-off-by: Yusong Gao <a869920004@gmail.com>
> > Reviewed-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> > ---
> > V5: No change.
> > V4: Change to more strict check mode.
> > V3: Removed redundant empty line.
> > V1, V2: Clarify the description of git message.
> > ---
> >  scripts/sign-file.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> > index 598ef5465f82..3edb156ae52c 100644
> > --- a/scripts/sign-file.c
> > +++ b/scripts/sign-file.c
> > @@ -322,7 +322,7 @@ int main(int argc, char **argv)
> >                                    CMS_NOSMIMECAP | use_keyid |
> >                                    use_signed_attrs),
> >                   "CMS_add1_signer");
> > -             ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY)
> > < 0,
> > +             ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY)
> > != 1,
> >                   "CMS_final");
> > 
> >  #else
> > @@ -341,10 +341,10 @@ int main(int argc, char **argv)
> >                       b = BIO_new_file(sig_file_name, "wb");
> >                       ERR(!b, "%s", sig_file_name);
> >  #ifndef USE_PKCS7
> > -                     ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) < 0,
> > +                     ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) != 1,
> >                           "%s", sig_file_name);
> >  #else
> > -                     ERR(i2d_PKCS7_bio(b, pkcs7) < 0,
> > +                     ERR(i2d_PKCS7_bio(b, pkcs7) != 1,
> >                           "%s", sig_file_name);
> >  #endif
> >                       BIO_free(b);
> > @@ -374,9 +374,9 @@ int main(int argc, char **argv)
> > 
> >       if (!raw_sig) {
> >  #ifndef USE_PKCS7
> > -             ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) < 0, "%s",
> > dest_name);
> > +             ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) != 1, "%s",
> > dest_name);
> >  #else
> > -             ERR(i2d_PKCS7_bio(bd, pkcs7) < 0, "%s", dest_name);
> > +             ERR(i2d_PKCS7_bio(bd, pkcs7) != 1, "%s", dest_name);
> >  #endif
> >       } else {
> >               BIO *b;
> > @@ -396,7 +396,7 @@ int main(int argc, char **argv)
> >       ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s",
> >       dest_name);
> >       ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0,
> >       "%s", dest_name);
> > 
> > -     ERR(BIO_free(bd) < 0, "%s", dest_name);
> > +     ERR(BIO_free(bd) != 1, "%s", dest_name);
> > 
> >       /* Finally, if we're signing in place, replace the original.
> >       */
> >       if (replace_orig)
>
>
> BR, Jarkko


BR, Yusong Gao

