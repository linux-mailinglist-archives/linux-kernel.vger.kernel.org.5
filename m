Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B7880D036
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344579AbjLKP5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344402AbjLKP50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:57:26 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C097A106
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:57:32 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d3c7ef7b31so43722547b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702310252; x=1702915052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgnFsD1rGgCy3ClJpDI9oqAdCvPdJ7fZQsiqLqMiah4=;
        b=HE440x8bW4ivJ/FnJToCuXSWaSfYNrshA24kBJWkka43pvnWHamxqzAmOuBySjoHPK
         iMqTSBemht7BXYe63CuQyy9D8PlaUJab6eN6v63svBqK/p7M9/HRGp06p032eDJdxV2j
         tvD7zvmXeIApnJnDlvRNMS2gggQWQZKa3wsHr1oabl0UekJj2a700KvY+w7+ZomJvzLn
         Q6YzhLVJnkDgTuiFcZ1Pb98t8mttTYoHxuzTDH6pHj0ac4V4dhHMFUe0Fsgqf5swVA5N
         bmtPAAv8B+m5CJ9rFowIAeoBfVdO1LiDlYu/BJWZzURfRsTR54csFz/JpdcrUXCnLfYP
         H4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702310252; x=1702915052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgnFsD1rGgCy3ClJpDI9oqAdCvPdJ7fZQsiqLqMiah4=;
        b=GUqMAnx9HvZjS8xrdLklyaxYUxF4ARqiAfCva3pg62BtdTYRJiLWJIYxcpgN0hPeDR
         whCGbQzeSO5EqVg0EUvi0fwHRh3v/ucOTiudnT/7Acz2kpmExDxHFCbJa/3u/ioTRlZo
         3Y88BpQ3Oi+w1f7c8RVZ8iPSLRVlYkJgF5ZFCUStDfVxLybvvxp2A6k7gE231g8Wba3Y
         FDDt+oa8hS3RUF6vDNS1cWURD8qFy+AoPdwWY/z126plt7Lfj9OCS79QI7YSMA/BbihM
         AQ7B13yd0lLrqP9Jau83ieMZqrhVqD2/au9yZWVJCGBM+ln/sOy41WS53GaHTeAtBgBB
         68fg==
X-Gm-Message-State: AOJu0YyarelwtfLojHZGbGS1Ms4q+up1/V+CPNDqe6ape5IrJJQq86O3
        BxLxQnQRxi+DXaay+ZNMdPvKLybs55P2qshZnhk=
X-Google-Smtp-Source: AGHT+IHTxt/NnusInkDn2gTlMNXzFT8tYbqqoQzEFJIeydEKudIkHqXrZd4hI95UwOkxyQCP0MFlEA==
X-Received: by 2002:a05:690c:2c90:b0:5e1:8d19:4e77 with SMTP id ep16-20020a05690c2c9000b005e18d194e77mr287921ywb.8.1702310251910;
        Mon, 11 Dec 2023 07:57:31 -0800 (PST)
Received: from ubuntu-server-vm-macos (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id d201-20020a814fd2000000b005cc5f5aa533sm3066544ywb.43.2023.12.11.07.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:57:31 -0800 (PST)
Date:   Mon, 11 Dec 2023 15:57:28 +0000
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] tools/counter: add a flexible watch events tool
Message-ID: <ZXcxaFRuGJg6kYuT@ubuntu-server-vm-macos>
References: <20231206164726.418990-1-fabrice.gasnier@foss.st.com>
 <20231206164726.418990-2-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DgK1nOAauTq8w6Yp"
Content-Disposition: inline
In-Reply-To: <20231206164726.418990-2-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_XBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DgK1nOAauTq8w6Yp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2023 at 05:47:25PM +0100, Fabrice Gasnier wrote:
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
> ---
> Changes in v3:
> - Free the allocated memory, also close the char device
> - Split of another patch series[1].
> [1] https://lore.kernel.org/lkml/20230922143920.3144249-1-fabrice.gasnier=
@foss.st.com/

Hi Fabrice,

Thank you for splitting this from the other patches. I think you may
still be leaking memory in a few places below.

> +	if (nwatch) {
> +		watches =3D calloc(nwatch, sizeof(*watches));
> +		if (!watches) {
> +			perror("Error allocating watches");
> +			return 1;
> +		}
> +	} else {
> +		/* default to simple watch example */
> +		watches =3D simple_watch;
> +		nwatch =3D ARRAY_SIZE(simple_watch);
> +	}

If we go down the calloc() path, then we should free the memory
before any return.

> +				case WATCH_CHANNEL:
> +					if (!value) {
> +						fprintf(stderr, "Missing chan=3D<number>\n");
> +						return -EINVAL;

Such as here.

> +					}
> +					watches[i].channel =3D strtoul(value, NULL, 10);
> +					if (errno)
> +						return -errno;

Here.

> +					break;
> +				case WATCH_ID:
> +					if (!value) {
> +						fprintf(stderr, "Missing id=3D<number>\n");
> +						return -EINVAL;

Here.

> +					}
> +					watches[i].component.id =3D strtoul(value, NULL, 10);
> +					if (errno)
> +						return -errno;

Here.

> +					break;
> +				case WATCH_PARENT:
> +					if (!value) {
> +						fprintf(stderr, "Missing parent=3D<number>\n");
> +						return -EINVAL;

Here.

> +					}
> +					watches[i].component.parent =3D strtoul(value, NULL, 10);
> +					if (errno)
> +						return -errno;

Here.

> +					break;
> +				default:
> +					fprintf(stderr, "Unknown suboption '%s'\n", value);
> +					return -EINVAL;

Here.

> +	ret =3D asprintf(&device_name, "/dev/counter%d", dev_num);
> +	if (ret < 0)
> +		return -ENOMEM;

Here.

> +	fd =3D open(device_name, O_RDWR);
> +	if (fd =3D=3D -1) {
> +		perror("Unable to open counter device");
> +		return 1;

Here.

> +	}
> +
> +	for (i =3D 0; i < nwatch; i++) {
> +		ret =3D ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches + i);
> +		if (ret =3D=3D -1) {
> +			fprintf(stderr, "Error adding watches[%d]: %s\n", i,
> +				strerror(errno));
> +			return 1;

Here.

> +		}
> +	}
> +
> +	ret =3D ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
> +	if (ret =3D=3D -1) {
> +		perror("Error enabling events");
> +		return 1;

Here.

> +	}
> +
> +	for (i =3D 0; loop <=3D 0 || i < loop; i++) {
> +		ret =3D read(fd, &event_data, sizeof(event_data));
> +		if (ret =3D=3D -1) {
> +			perror("Failed to read event data");
> +			return 1;

Here.

> +		}
> +
> +		if (ret !=3D sizeof(event_data)) {
> +			fprintf(stderr, "Failed to read event data\n");
> +			return -EIO;

And here.

> +	if (watches !=3D simple_watch)
> +		free(watches);
> +	close(fd);
> +
> +	return 0;

We finally free watches here, close the file descriptor, and return. So
instead of returning an error code directly when you encounter a
problem, I would do an unwinding goto section like the following
instead.

First, the open() call occurs after the calloc(), so move the close()
call above the watches check so that we unwind in a first-in-last-out
order. Next, add a label to mark the file descriptor close section, and
another label to mark the watches free section. Then, rather than
returning 0 directly, return a retval that we can set. That way, when
you need to return on an error, set retval to the error code and goto
the file descriptor close label if we're past the open() call, or the
watches free label if we're just past the calloc() call.

William Breathitt Gray

--DgK1nOAauTq8w6Yp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZXcxaAAKCRC1SFbKvhIj
KyH7AQDS6pGsvZkqLTWO56L/iANt86BNInqaN0ixwVhpsDcpBgD/dVb/3cacHHOH
q1S50LhsUQ4jogqKhU20axDclAOqvQQ=
=3Fgn
-----END PGP SIGNATURE-----

--DgK1nOAauTq8w6Yp--
