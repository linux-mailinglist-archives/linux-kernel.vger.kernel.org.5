Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1802976DE85
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 04:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjHCCtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 22:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjHCCtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 22:49:43 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59476E4C;
        Wed,  2 Aug 2023 19:49:42 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2680ccc1d52so220507a91.0;
        Wed, 02 Aug 2023 19:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691030981; x=1691635781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hBogplUAA+nKuf7eUAZsuJx8HLVlmtv2tCxRNycul38=;
        b=ebErbLIg2BJu+QDjNPSbHnNdKfO5DxcBcUX+DExlOhl0PNXJSdTnhrKzGL9U7oC45r
         qnnhTt8kM6icxpZYQIDBDGYuhC7OBof95fR/+3bOPi1p/sUkmq1apMC0okIlh6Jr6xAt
         5TSSKP/mY6yymSPIai39RtUVB8p8kCRorMAVMrSQxXDKz0vWVFtVfFIk0hbGXvYkRJpq
         PuTDjmfe+iSRd1wq0iZrVFN6qTVo+0saEAzOghewOp7/6n5NvkQPw3NAu+PdSbQ+e57e
         4wSZtms7IbzQlEkQ8S1j5ER3IQnEPBapM004pd4NFbfMEgL6dgGbWbXFGHEvet5lSFqi
         sQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691030981; x=1691635781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBogplUAA+nKuf7eUAZsuJx8HLVlmtv2tCxRNycul38=;
        b=Zh+NjP0vCurjRkSOS2bGDq8xPMyXbtIg914Xnajr8eTmhAEsWC2gDjh4X2q1kJkmgG
         1RyQdUG1m+DT9y8HKtWIh+MCFh+1eO5B70wtcGpyX2OUzu7OCnHzBoiUvIkTSyPe9Psi
         lv/5fyAFWXydRpTfCEzBPTHN5bk7ZszR6mGI41kwVrPImWw5HD3lF3Zm1SYd6cvfjCMQ
         XjVgZp6CHl8xlCUWHRehyGq3x939oRLVWQ54lu11ebvVZktiljge0KJruxb2OIsKKPji
         1nWtHUPUjo2VgaQAHN64UTondpBlvAjkOmRuFLWAFVw/5QLtPHnJ1gd/dHsyNYQHn150
         eqKg==
X-Gm-Message-State: ABy/qLZysCkBm83VEqgSx+nH0bH9B3WwWs5OKwyCWSSq5yc+IgS/AWX/
        wjTdrQ5e0qVf01V5dGgrzz4=
X-Google-Smtp-Source: APBJJlHgFldHH9Meu4s8csKDGJ1q8PlwRdyZ0cBqq4ZPFQWsotvHtfWRPQ27hJpZRQEsVlyRVnsGhw==
X-Received: by 2002:a17:90a:6885:b0:262:ecd9:ed09 with SMTP id a5-20020a17090a688500b00262ecd9ed09mr14995562pjd.33.1691030981035;
        Wed, 02 Aug 2023 19:49:41 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id bb3-20020a170902bc8300b001bbf7fd354csm9323535plb.213.2023.08.02.19.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 19:49:40 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id E3E738BF27A2; Thu,  3 Aug 2023 09:49:35 +0700 (WIB)
Date:   Thu, 3 Aug 2023 09:49:35 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/225] 6.1.43-rc2 review
Message-ID: <ZMsVv4+DAiJOdm4r@debian.me>
References: <20230802065510.869511253@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RRio+N2QB63cqjUu"
Content-Disposition: inline
In-Reply-To: <20230802065510.869511253@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RRio+N2QB63cqjUu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 09:41:55AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.43 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--RRio+N2QB63cqjUu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZMsVswAKCRD2uYlJVVFO
o0LrAQCtlROqK56I9iiFxy9mMNxYw89O7krhQ/KGGOthCqHOcgD+LY0YQKXrP5aO
nEC+ETC2er+yNJ226k4p/A/wnoK2mAY=
=mFvq
-----END PGP SIGNATURE-----

--RRio+N2QB63cqjUu--
