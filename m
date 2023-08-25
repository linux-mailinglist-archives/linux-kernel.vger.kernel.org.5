Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704E0788FED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 22:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjHYUhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 16:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjHYUhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:37:13 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F412133
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:37:10 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68a520dba33so1118249b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692995830; x=1693600630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TPFsDM2aS22oJkp4VKW1ExTBHZejf9jyFe0+feyfd/8=;
        b=mVu8QcoKmRZGFyMEw5zhhZB9hgAkvVpPZgwSNIdByZWsNEpUoP6zjccLbvAPnGaHMf
         XlsE7Ri967gFlG05B6gHkZ5MhJwjIW85r8Gv1x1n/hCCNu5YRnNKxYoqQ4j8fq2SXg6h
         U5WQass8Y5x6l2yyFVNmqIu87TdSUqYnxntH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692995830; x=1693600630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPFsDM2aS22oJkp4VKW1ExTBHZejf9jyFe0+feyfd/8=;
        b=QEln9dJAt+5OtY6TZ145vHjFMP0amCDBOtkJwotjVATwh0+KATj2vt/QEPxFtpFZUP
         Va5wdbSEn2XCo/a5jE/qxAUm5TkEa/mZ2GJSSXr6XP4t5FyCceLgXz9u42VSxBfOufl/
         HxaguCb9NfzkhX7HluhC4SmNNuhmI7hK0nCjw07AqLTTYrZe6BMJ/6MGslt8ww03NTmp
         5L/qB3BVjPzougv568e1PDLUAYF5wPEgUkhFJa16hHCDvHM2LzeC6cwmpRiJnNl68feb
         L2xbKK844hKQ6K0dqoU6g1Xhz6tvST+0pgRdki6evY8OiyAcw7gGg8ARxz1+lgbZYjzd
         K21g==
X-Gm-Message-State: AOJu0Yz2HXTMfWhKyfWUhjLDd6N4Gb6J4et2DKce/p1rRIFWFPj6UAhO
        Nm/Kka4Gtlf73CieSuMW3N/Mkg==
X-Google-Smtp-Source: AGHT+IHZeULT+i0DWpVrCSGuQ58y7gjL44hyK89F2DmJUhpzLU7kjzmSUnoK42OQIsZSrnZP5t77tg==
X-Received: by 2002:a05:6a00:a13:b0:68a:3c7a:129e with SMTP id p19-20020a056a000a1300b0068a3c7a129emr20589880pfh.27.1692995830400;
        Fri, 25 Aug 2023 13:37:10 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m9-20020aa79009000000b00688435a9915sm1949344pfo.189.2023.08.25.13.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 13:37:09 -0700 (PDT)
Date:   Fri, 25 Aug 2023 13:37:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Seo <james@equiv.tech>
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/12] scsi: mpt3sas: Make
 MPI2_CONFIG_PAGE_IO_UNIT_8::Sensor[] a flexible array
Message-ID: <202308251334.A4A10C2@keescook>
References: <20230806170604.16143-1-james@equiv.tech>
 <20230806170604.16143-3-james@equiv.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806170604.16143-3-james@equiv.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2023 at 10:05:54AM -0700, James Seo wrote:
> This terminal 1-length variable array can be directly converted into
> a C99 flexible array member.
> 
> As all users of MPI2_CONFIG_PAGE_IO_UNIT_8 (Mpi2IOUnitPage8_t) do not
> use Sensor[], no further source changes are required to accommodate
> its reduced sizeof():
> 
> - mpt3sas_config.c:mpt3sas_config_get_iounit_pg8() fetches a
>   Mpi2IOUnitPage8_t into a caller-provided buffer, assuming
>   sizeof(Mpi2IOUnitPage8_t) as the buffer size. It has one caller:
> 
>   - mpt3sas_base.c:_base_static_config_pages() passes the address of
>     the Mpi2IOUnitPage8_t iounit_pg8 member of the per-adapter struct
>     (struct MPT3SAS_ADAPTER *ioc) as the buffer. The assumed buffer
>     size is therefore correct.
> 
>     However, the only subsequent use in mpt3sas of the thus populated
>     ioc->iounit_pg8 is a little further on in the same function, and
>     this use does not involve ioc->iounit_pg8.Sensor[].
> 
>     Note that iounit_pg8 occurs in the middle of the per-adapter
>     struct, not at the end. The per-adapter struct is extensively

This is especially bad/weird. Flex arrays aren't supposed to live there,
so I think it'd be best to avoid this conversion (see below).

>     used throughout mpt3sas even if its iounit_pg8 member isn't,
>     resulting in an especially large amount of noise when comparing
>     binary changes attributable to this commit.

Since the size reduction makes it hard to validate, how about just
leaving it alone? Since nothing is using Sensor[], you could just make
it a single instance:

-     MPI2_IOUNIT8_SENSOR
-             Sensor[MPI2_IOUNITPAGE8_SENSOR_ENTRIES];/*0x10 */
+     MPI2_IOUNIT8_SENSOR     Sensor;                 /*0x10 */


or leave it as-is (i.e. drop this patch).

> 
> Signed-off-by: James Seo <james@equiv.tech>
> ---
>  drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
> index 42d820159c44..12b656bd883d 100644
> --- a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
> +++ b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
> @@ -1200,12 +1200,9 @@ typedef struct _MPI2_IOUNIT8_SENSOR {
>  #define MPI2_IOUNIT8_SENSOR_FLAGS_T0_ENABLE         (0x0001)
>  
>  /*
> - *Host code (drivers, BIOS, utilities, etc.) should leave this define set to
> - *one and check the value returned for NumSensors at runtime.
> + *Host code (drivers, BIOS, utilities, etc.) should check the value returned
> + *for NumSensors at runtime before using Sensor[].
>   */
> -#ifndef MPI2_IOUNITPAGE8_SENSOR_ENTRIES
> -#define MPI2_IOUNITPAGE8_SENSOR_ENTRIES     (1)
> -#endif
>  
>  typedef struct _MPI2_CONFIG_PAGE_IO_UNIT_8 {
>  	MPI2_CONFIG_PAGE_HEADER Header;                 /*0x00 */
> @@ -1214,8 +1211,7 @@ typedef struct _MPI2_CONFIG_PAGE_IO_UNIT_8 {
>  	U8                      NumSensors;             /*0x0C */
>  	U8                      PollingInterval;        /*0x0D */
>  	U16                     Reserved3;              /*0x0E */
> -	MPI2_IOUNIT8_SENSOR
> -		Sensor[MPI2_IOUNITPAGE8_SENSOR_ENTRIES];/*0x10 */
> +	MPI2_IOUNIT8_SENSOR     Sensor[];               /*0x10 */
>  } MPI2_CONFIG_PAGE_IO_UNIT_8,
>  	*PTR_MPI2_CONFIG_PAGE_IO_UNIT_8,
>  	Mpi2IOUnitPage8_t, *pMpi2IOUnitPage8_t;
> -- 
> 2.39.2
> 

-- 
Kees Cook
