Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A965797646
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbjIGQFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbjIGQFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:05:17 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A1233136;
        Thu,  7 Sep 2023 08:55:29 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1bee82fad0fso9376055ad.2;
        Thu, 07 Sep 2023 08:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694102003; x=1694706803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68ien6P8EjWPgIgg6+cN/j6LlnAbZ2VKZ0DZlOp5E4Y=;
        b=c4BbTeHH+WMIHOf15HGBpiSF7SH3A/TufNuq/vqGFb1F7RLNEFWEiLhCyG8uU+JWjm
         abO5H7EEUwRu1759JtTSlJ8QgaQrBs92ur6LgVdLvvAZ7w1BPnkzMONVlwg41BZhBPgY
         z5TeumX0DTmj/p/3tjd3R+v2U6UciuOjrn3Fs6lN7/eWXVP0+YH4lFUel1LkSZwcWPaL
         UDrqdb2EfJW3sm85qYiGhGWMoJaIC7uLNrOpwBRrqna8drxjNQRYZ8PXtk1DdxlOx2aa
         uPJOfX5wrFoo4vQCkwWo79uxRBNjei1ABuDBr+IYQQYteM3aU4ohTphzObOMDm6ZgVm9
         8SRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102003; x=1694706803;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68ien6P8EjWPgIgg6+cN/j6LlnAbZ2VKZ0DZlOp5E4Y=;
        b=kX6X7+QyIR1O1r7TlWni7wD2/rHhHikNE0V8I6QO+aI+Akk/PNEUIXigPY7MDeXUDt
         or0Ql/Ep57n1+qIr2iUISEog/Pu1iz/He7PQ14z+MvB2owWlKj2adYzj3HU9Iuj52Shi
         l0xRfYMw0P6YeddUd5ucr/chVOm5SDsXXrNXRaHLnNLCowi/LMVJhunxByCGC1aoyJRK
         B78P73NWgpfl9Q3Cef34fn7n0aNf+6WDLMcK6dJAq49yAOAhwsHWHIbavf1m+fx2cZ+y
         E8CJqvHzLp+Sty85pESmLA+dhx15AfFkqm0Ufok82RNVK8/EH0wivP+Sk3NWNHad+gEt
         r2Sw==
X-Gm-Message-State: AOJu0YyNX4nZzGBcFfBgDAgn+EFOJehkUPCUyxeGeu7c0Qk8LvQNztP/
        6pJPaUeeSzJsh9cTmOc3cHM6jTOxfo8=
X-Google-Smtp-Source: AGHT+IEsPigsaCPMfm4kXxqxwZDH1m2Obx1qY9653d+G+QaYngXT5/XWvrkj8yqDbz8ukOLWnMv2sw==
X-Received: by 2002:a05:620a:2982:b0:76d:f544:3426 with SMTP id r2-20020a05620a298200b0076df5443426mr23268417qkp.28.1694091541805;
        Thu, 07 Sep 2023 05:59:01 -0700 (PDT)
Received: from Gentoo ([154.16.192.36])
        by smtp.gmail.com with ESMTPSA id e20-20020a05620a12d400b0076d9e298928sm5766763qkl.66.2023.09.07.05.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 05:59:01 -0700 (PDT)
Date:   Thu, 7 Sep 2023 18:28:53 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jesper.juhl@gmail.com
Subject: Re: [PATCH] Documentation: Process: Add a note about git way of
 applying patch
Message-ID: <ZPnJDTcKb5Wf30Zl@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jesper.juhl@gmail.com
References: <20230907115420.28642-1-unixbhaskar@gmail.com>
 <87bkee40ac.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="K0i0x7Q1WPm/S9JY"
Content-Disposition: inline
In-Reply-To: <87bkee40ac.fsf@meer.lwn.net>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K0i0x7Q1WPm/S9JY
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 06:48 Thu 07 Sep 2023, Jonathan Corbet wrote:
>Bhaskar Chowdhury <unixbhaskar@gmail.com> writes:
>
>> cc: jesper.juhl@gmail.com
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  Documentation/process/applying-patches.rst | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/process/applying-patches.rst b/Documentation/process/applying-patches.rst
>> index c269f5e1a0a3..201b9900bffe 100644
>> --- a/Documentation/process/applying-patches.rst
>> +++ b/Documentation/process/applying-patches.rst
>> @@ -6,6 +6,13 @@ Applying Patches To The Linux Kernel
>>  Original by:
>>  	Jesper Juhl, August 2005
>>
>> +
>> +.. applying patch by Git::
>> +
>> +    You can use the below syntax to patch in git repository
>> +    git-apply --whitespace=error-all <patchfile>
>> +
>> +
>>  .. note::
>>
>>     This document is obsolete.  In most cases, rather than using ``patch``
>
>So why are you sending a patch ... with no changelog

My bad. Realized it once send it.


>to a document that is explicitly marked as being obsolete?

I thought if people visit that page , that note might help.

Are we taking out that page from the doc? Why that page is still there?


>jon

--
Thanks,
Bhaskar

"Here's looking at you kid"-- Casablanca
https://about.me/unixbhaskar

--K0i0x7Q1WPm/S9JY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmT5yQ0ACgkQsjqdtxFL
KRX2DAf+I8IZr0j+AMDxxdMnRNECiZQBaAaKvCssIKADPSyXaMlfV5809rCbuEIT
v6pv9siThkZ8oIADhTjumfLgWTPxc+1vAEqkSvLXVP6Al2EEGzofc3/+9MtyGQr7
geHwBRopaOlp+vdWFlSzkQHc68Y1QQsPKXXEQdbD4WD3Ps8jD7h/fOhB3L4D+WZ0
8ODxp6olt16xArLSYc4/fw5d+Jf0LSDh4Zz80WFtgvRFcvpGGX4zsC0hy/+qTJd+
Bw2FIhmmRxL51aK+t+1Su8PQh88Jngl5LJwjdKRoMqQulemc63gPkvMLAGVe3bZU
I8l0k3rbKUBdVL+QNOqZjmXKT+KyFg==
=n5Yg
-----END PGP SIGNATURE-----

--K0i0x7Q1WPm/S9JY--
