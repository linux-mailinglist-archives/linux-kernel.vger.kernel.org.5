Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC75080D064
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343982AbjLKQCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344655AbjLKQB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:01:58 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B5C3A82
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:59:59 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5d8ddcc433fso33609987b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702310398; x=1702915198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GmodIMBO1Qk0Y+vje8OUGjZ5BvXR/87b/qmy8RMt3ic=;
        b=N6ANyIU/Iqty41xTVjLfK56B/eG/p+DgA4Fejlp4xJ3B9XMIlpMjFcXaS1bJ885eJJ
         eNmXAx1VMv5fmsQdpUSOzTZpggUpzFVxfbRnVM6EttZVQY7Ccl+JWmh/i68cwRpbWfEK
         VTln0just8rOyquVPzNZv3FlU4KNSaL8uP7q4aEmJXf/U0weYeH+bPtuyeeRk2IEm5dh
         IWh8sbYzBSU0RKPVvZAo6yvn3LrC4oX9JNcr8XRWEwrD8FLwazL3TdKzsUFjzvheYFPv
         xeimrXxXgtfTfxYnjO1GZCjiMjcxkyToqevAAZPPWkVrXOrs3TzokhkDUZOQe/TpWdvU
         B73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702310398; x=1702915198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmodIMBO1Qk0Y+vje8OUGjZ5BvXR/87b/qmy8RMt3ic=;
        b=SP8YjEPA/dI1v9yYA8Qs/3CMPemna0yayhGQ9CEpp//9G4iVcfviEzDnYksrPWcw/0
         EYVr+Qy3Y/ZQOWfLu7wgsAgIlsWF8IIkZvO2pnRWZlcyvwa1SRQz2FC2GK2TcvNIiQB6
         pD4xrbS34tV3DVcPmx6JGtRO6VVX7ogn7WW8NhU9LAB2HbNI3paXzENGJr11pcOlfAqJ
         uBfRkQ/TH8IH0IGC4BRI9SZvHAeChDpCMUT9GzJAH2sMM7XHl5FvMIANuTmJVMbDiRXv
         xwtSWH0YHDJTwSTiHruRHoc4Jc+xBXYGZYShHSIHRwKZaPnPq2RJFYjyY5h9YD6QoIj3
         F6TQ==
X-Gm-Message-State: AOJu0YyL1jUNXe1JvdyK/ozZRhzuGFI5RGAAFMCSaYYzZ3YC/7pqfGcN
        alB35W7YOsKRvcvVB4d4mpjsAcVuetljpJsLmWc=
X-Google-Smtp-Source: AGHT+IFJDzAr52fuc8/1ih2Utb+8daDqbEMt410Vgn3UCnD00YsjCaesHmI6CL7seE5geyt+WYpNkQ==
X-Received: by 2002:a81:7b42:0:b0:5d7:1940:8dd4 with SMTP id w63-20020a817b42000000b005d719408dd4mr1675599ywc.59.1702310397969;
        Mon, 11 Dec 2023 07:59:57 -0800 (PST)
Received: from ubuntu-server-vm-macos (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id s129-20020a0dd087000000b005d361dd6454sm3061847ywd.87.2023.12.11.07.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:59:57 -0800 (PST)
Date:   Mon, 11 Dec 2023 15:59:55 +0000
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] MAINTAINERS: add myself as counter watch events
 tool maintainer
Message-ID: <ZXcx+94QW2pWDBxM@ubuntu-server-vm-macos>
References: <20231206164726.418990-1-fabrice.gasnier@foss.st.com>
 <20231206164726.418990-3-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PZCr3blPdUWJymRC"
Content-Disposition: inline
In-Reply-To: <20231206164726.418990-3-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_XBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PZCr3blPdUWJymRC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 05:47:26PM +0100, Fabrice Gasnier wrote:
> Add MAINTAINERS entry for the counter watch events tool. William has
> been asking to add at least me as the point of contact for this utility.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in v3: Add MAINTAINERS entry. This is a split of another patch
> series[1].
> [1] https://lore.kernel.org/lkml/20230922143920.3144249-1-fabrice.gasnier=
@foss.st.com/
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dd5de540ec0b..b8541ab7866a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5322,6 +5322,11 @@ F:	include/linux/counter.h
>  F:	include/uapi/linux/counter.h
>  F:	tools/counter/
> =20
> +COUNTER WATCH EVENTS TOOL
> +M:	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> +S:	Maintained
> +F:	tools/counter/counter_watch_events.c

Add an L line as well for the linux-iio@vger.kernel.org address so
discussions get sent to our public mailing list.

Thanks,

William Breathitt Gray

--PZCr3blPdUWJymRC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZXcx+wAKCRC1SFbKvhIj
K3moAQClczPRsK4fQOXT/SzSTFuFwbEXiJr0jHN4XFmq+4XImAEAqAkugSYm34wr
oGcCtS70zcIffl2iy1cXE4etZ+etxQ8=
=QVg4
-----END PGP SIGNATURE-----

--PZCr3blPdUWJymRC--
