Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094FA7DDD64
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjKAHsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjKAHsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:48:00 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8860EA;
        Wed,  1 Nov 2023 00:47:57 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b2e4107f47so4457474b6e.2;
        Wed, 01 Nov 2023 00:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698824877; x=1699429677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vq75HFuS4A35ZWzrdjOrcmcD2ljcMSxdfwEcqETU+OY=;
        b=NJn4SuBLZibqC26kg04p458GB5O4vbm7jEGjjq0LUhIjndkYVSEQH4zeAC0Lz2JGC6
         gLureWv9bHSiircVjxLUBBvSabkw8KtQZVjPdw3xcIUnwFx5FzGtgKqBAvJ0ZwABw0rJ
         BhB168FKyyRC0LGl4NYmKgQS7RLc3tAIxvktfxxCG0kCtkUfCBB61UmLFUSFJ35DEtT9
         4abLmZS60Ixb2z05Mx1x6SJMrM3mqerE8KLZ9c7Q8y/whRGHm+BAvmcKvXXVgB6HsN3i
         KE9jG99bUl1YbjfM+uks5lIPqkcuhTetbdYqA45UZLU4ETRNGMY1+1Nnpa0M9r39xjlI
         zdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698824877; x=1699429677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vq75HFuS4A35ZWzrdjOrcmcD2ljcMSxdfwEcqETU+OY=;
        b=duaQZG2SjvaqXsKzAXF6N6D9bnAnCmxj1cM0kNnRY4iZl7RX+lLPvI9dN903d6FdIW
         vecmnwPCSVehW5/xrYGY3ZAnYfAK8tkRQk86VLNY5qznW3ZlEP9+Xcna4Zaq6A8AC9Ek
         VcE3L7W7ReXhUdCrrPf4h8tPDgE4NLAbFE9x/XOt9tGZx2DQsrmjUOkmkN2QPEiuF2LV
         9+S+WVMvL8E7KyhWn+wMC/pOIsB8OSIflBG8iLIZmNKu+GubVWt+ruWHilIkfSLhUBwh
         r+mrN6PIUfKQGmzmz7eJF0Ui2quTiI0y4/GnOeazoO2R7BEE+ffRRSJTL8mi0j+KWqOK
         H/vg==
X-Gm-Message-State: AOJu0YyBHAnRWRJgDynW+Tt3b4p0Ld3RxyFJ1FMhQiwL4SRrzQ3Blg+O
        W7jOxZWpBd1M+delqu7LvhzFDX9vpzU=
X-Google-Smtp-Source: AGHT+IFIwNFck0nKrCGVoz9nr7AvOYqdj4i3mxCgWePquNugOQoZHSkQOjOmzxXNBsLKXLjhPkEhPw==
X-Received: by 2002:a05:6808:2102:b0:3ae:2bc8:2b93 with SMTP id r2-20020a056808210200b003ae2bc82b93mr21387577oiw.3.1698824876989;
        Wed, 01 Nov 2023 00:47:56 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c10-20020aa781ca000000b00692c5b1a731sm735362pfn.186.2023.11.01.00.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 00:47:56 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0EA2180A734F; Wed,  1 Nov 2023 14:47:51 +0700 (WIB)
Date:   Wed, 1 Nov 2023 14:47:51 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Li Zhijian <lizhijian@fujitsu.com>, corbet@lwn.net,
        Linux Documentation <linux-doc@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH] docs: dma: update a reference to a moved document
Message-ID: <ZUICp1WnLLtW-8K-@debian.me>
References: <20231101070201.4066998-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hBgg93ZdR5ygBfa9"
Content-Disposition: inline
In-Reply-To: <20231101070201.4066998-1-lizhijian@fujitsu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hBgg93ZdR5ygBfa9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 03:02:01PM +0800, Li Zhijian wrote:
>  This is a guide to device driver writers on how to use the DMA API
>  with example pseudo-code.  For a concise description of the API, see
> -DMA-API.txt.
> +Documentation/core-api/dma-api.rst.
> =20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--hBgg93ZdR5ygBfa9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUICpwAKCRD2uYlJVVFO
ozxMAQCTdcl+6YsoVzJTHMArcUDJGrLMXHkKspxmtHtzwMvRPQEA5GL2mzNE7vHQ
QV3WacDKSuPjB/LDqH/u5MWGi+CAMgk=
=vKr0
-----END PGP SIGNATURE-----

--hBgg93ZdR5ygBfa9--
