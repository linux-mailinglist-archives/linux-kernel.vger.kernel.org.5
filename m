Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641E87B7655
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 03:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbjJDBiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 21:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbjJDBiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 21:38:01 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2165B7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 18:37:57 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-495eb6e2b80so687993e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 18:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696383477; x=1696988277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ut7xWoIyAkKaAS+UBG8acxM2uYnbNKB4bITE7OuyUn8=;
        b=F/5RRAKLmW2qRiZrC1rpshlSbTD/0EguwBg3QhSqyHK3S7rS4z+jFPUl32SZZd0JSQ
         YSMpuNwRMvuC386MRS+soH/aGfbDo7fFPwIIf03C8MLZtOVcStBoZ3hHOasTm/hLPdZu
         m4ldVUtwAWESkbgP5UEs7uMb3/K4uVT6L5Tuac4MtefSLpN/UnGFi6VX2QrDhFUxbtWf
         eQz2iCMcIEKJAbt5gfSPv8vUaC3fyMVmtcWu+ra1RtKI6Cws4fvUcagZjQrBAUa1Awn8
         OBFZf4sAsI4RXfyGB+svmpcX+lZpilreigTH1A5wj1jMRXX1x8/uuQMwO3/XZPF8zDzD
         4/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696383477; x=1696988277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ut7xWoIyAkKaAS+UBG8acxM2uYnbNKB4bITE7OuyUn8=;
        b=ZkAtTTK4qhDAf1hkIQnB1J+PU6VeBix26UchdgspvalacGxkmPm5UxKiQCIG4u7XNg
         hlJaoVNdieH9YeAeZMTJJaFX/rnCR23LpKMeSOGBuJqtmdQNLUJ4/H5SwlEjP0FdePCK
         6IgEnea8j0gX5kNhQ8hvT8jQ/jaKz/lzPoiPTXl23ZZVFV+Qv54Z6NhrV0f+11xlYxgd
         +zHB/uBU1vGFjqZdp39EMZ4FXqAT33G+i80bSvrdu5nJocov5poXOS3cet/WGi54q6y2
         +psidF3NxetG4BHCNFjUEYCvZVf90szfUc4jlUHMgBrjv6QcZpiaIFs5ZIL9GxzfiITT
         R40Q==
X-Gm-Message-State: AOJu0YxmrzxecPplUI2pg7Y6X2IyuZPupLAHr/5zzM47JNnpXQ8g6Rmx
        K1BQNiPIAHO/+aQVSQdM6r1zGA==
X-Google-Smtp-Source: AGHT+IFe9WGtyUnwFgSpm2oOiz9vnIspKZLXWvuP1DOW+PgtsVRIlTTNJUn1eT68WXpwzGTuIifS6Q==
X-Received: by 2002:a05:6122:2208:b0:48f:cd3a:108 with SMTP id bb8-20020a056122220800b0048fcd3a0108mr1039736vkb.12.1696383476933;
        Tue, 03 Oct 2023 18:37:56 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id c9-20020ac5c769000000b0049ab44fce7esm333804vkn.50.2023.10.03.18.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 18:37:56 -0700 (PDT)
Date:   Tue, 3 Oct 2023 21:37:53 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     lee@kernel.org, alexandre.torgue@foss.st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] tools/counter: add a flexible watch events tool
Message-ID: <ZRzB8f/SF4LSLS3c@fedora>
References: <20230922143920.3144249-1-fabrice.gasnier@foss.st.com>
 <20230922143920.3144249-2-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ud/ll0XBucuOa13p"
Content-Disposition: inline
In-Reply-To: <20230922143920.3144249-2-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ud/ll0XBucuOa13p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 04:39:15PM +0200, Fabrice Gasnier wrote:
> This adds a new counter tool to be able to test various watch events.
> A flexible watch array can be populated from command line, each field
> may be tuned with a dedicated command line sub-option in "--watch" string.
> Several watch events can be defined, each can have specific watch options,
> by using "--watch <watch 1 options> --watch <watch 2 options>".
> Watch options is a comma separated list.
>=20
> It also comes with a simple default watch (to monitor overflow/underflow
> events), used when no watch parameters are provided. It's equivalent to:
> counter_watch_events -w comp_count,scope_count,evt_ovf_udf
>=20
> The print_usage() routine proposes another example, from the command line,
> which generates a 2 elements watch array, to monitor:
> - overflow underflow events
> - capture events, on channel 3, that reads read captured data by
>   specifying the component id (capture3_component_id being 7 here).
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Hi Fabrice,

This tool is independent from the rest of the patches in this patchset,
so I suggest separating and submitting the next revision of this patch
independently.

> ---
> Changes in v2:
> Review comments from William:
> - revisit watch options to be less error prone: add --watch with
>   sub-options to properly define each watch one by one, as a comma
>   separated list
> - by the way, drop string/array parsing routines, replaced by getsubopt()
> - Improve command-line interface descriptions, e.g. like "-h, --help"
> - Makefile: adopt ARRAY_SIZE from tools/include/linux.kernel.h (via CFLAG)
> - remove reference to counter_example
> - clarify commit message, code comment: Index/overflow/underflow event
> - check calloc return value
> - Makefile: sort count_watch_events in alphabetic order
> - Makefile: add a clean rule to delete .*.o.cmd files

It looks like you implemented all the changes I requested in the first
review so I don't have much to comment inline for this revision.

It looks like the memory allocated (via calloc()) for the watches array
is never freed, so fix that in the next revision.

Also, add a MAINTAINERS entry with at least you as the point of contact
or someone else (an ST engineer?) who is willing to respond to any
bug reports the mailing list could get for this utility.

Regarding watch options, I looked up how a few other utilities handle
similar situations. Some utilities like the nftables nft command line
utility takes in a configuration file where you can specify the verbose
rule-sets, while others such as bfptrace allows entire programs to be
specified via one-liner constructs passed in a single option ("-e").

Although powerful, I found those approaches to be far too complex for
our simple test utility here. Instead, uilities with a simpler interface
take an approach similar to yours by providing several well-defined
sub-options; for example, to filter tcpdump packets users can provide
the particular sub-options they desire ("-i eth0 port 22").

The watch option solution here with sub-options is simple and clear, so
for now let's go with it as you have it. If the need arises in the
future for a more complex option interface, we'll tackle it as it comes.

Thanks,

William Breathitt Gray

--ud/ll0XBucuOa13p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZRzB8QAKCRC1SFbKvhIj
K8MOAP40On/mofJvCleupa6Ta0fCuH3zADKugk7CCkCLpyljWwD/TAi5GM0LSIWa
mlOzR+0lN8QEY6op3Qh1ojgvHuugqgQ=
=cxjL
-----END PGP SIGNATURE-----

--ud/ll0XBucuOa13p--
