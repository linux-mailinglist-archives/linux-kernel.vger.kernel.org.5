Return-Path: <linux-kernel+bounces-68657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CD8857DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D659CB2479E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA86512BE8D;
	Fri, 16 Feb 2024 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kl5L6pNm"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF03A1292E1;
	Fri, 16 Feb 2024 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091090; cv=none; b=KgashKEWWxeZiDLu4kAzg1vgHIbkeJgHpOh+R4ZuGxt7HZNKnmw8VE9YSZxtX2JdRSPOb7Ry0ya+QLGMEFTPZPnxEDjCurJGzrXAvHv/QcvpJejP0b4MEJZvK+wkhWqf6ApasT0qpBhZyxZvEGD/DirKDjUGmsA+G7ChrBBVtw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091090; c=relaxed/simple;
	bh=S4L92NZefLEC20yFJLLOf9G1GvTAmeD77uKPAtDEInU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yyrb0g2co5kOUeTmdgra5IytzxLFn+aMZG/btiLO7Yiu/oD2XnEmeIv0XDeOR6FtjqwdpjNcI6Gcvx7ZttWaEP6jxJvFkvurzfdPSl8wJ57qE004WIxqjg200Y5nz9Ck8UguYE/bD7y7lRenX9oj04wjW2Tf9fdeElCwbMhRCuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kl5L6pNm; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-206689895bfso502027fac.1;
        Fri, 16 Feb 2024 05:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708091088; x=1708695888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=coY0/edAbFAUsr5sc75rIWJqDfxEuZndNgC2ac1TWf0=;
        b=Kl5L6pNm8WRaBF9pMzqOOnX4Utia2gymKiQTQohl/tPrVU+lZPTxxVcriA5PybwuXU
         MQENf3q8xWJwuN7Us9rIMpKQhyb/k5NPBXH3GoZnka0avZ9MNLqdkSGa4IzOWdiJ56yO
         bWJwLFT2v8AwqRjBnmnFVZJip3Zx1LosA02P+iinXFC497fSjXl6+vtD60tiKZGwnIcc
         qIZCwFUaUR53FQZdQ8hr/lxC9pp1DtucWbn4oZfxi1MTOHQ3w/faWIfcICXBGBSkxqrc
         V6jkuPYkYwP44EQ5Sy67mHAi1Q48O434EqHBUfOaFBr6Z4rSQI9ZenrTTX6CSuCCHpgf
         6cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708091088; x=1708695888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coY0/edAbFAUsr5sc75rIWJqDfxEuZndNgC2ac1TWf0=;
        b=obL02OJgVLIA4py66YAPqhfWNqlFDcWpGpZbsSAmHisfoTXl4Wk4nzJtWdv5ONVSJq
         9xMFnr51j2P7JsoIUKONqR5SFgGbhz1De5YKIi4+aHlLB+8vgqk/SZt1HggNZmBRzil6
         B5QimRf+kfvCOuUgxwZz6zh0qRqZdI24+bJlmx733i5VoP4G8C+6Pz7nZVVNDKyo4a1v
         RzkSpxnZSbzSt9G97q2NMeznqdTLVapIx/rnv9e5TIgAw7gi7blYjSeKRjphudzMKnyM
         pwkd4VEBDbPNuVB00pH19XYBaogNij5GWGxiKteEz+hEfbtuiYIcn3uygZdgh7EHQLZa
         80Jg==
X-Forwarded-Encrypted: i=1; AJvYcCX/6h5UIzZoFe+uZhXIY9snFybnr+fVQZVtWRjYfqDn2c3Q9g7InY/tuGKEdlaM7EgBwN7fgqRHNvAc77sLVM76ZRPZNMup4XVuaUkGtU0FZ0Km2MVa3qonYVEqYdCJHpYzX9fBy93w
X-Gm-Message-State: AOJu0YzaOpZlmtsxArc0FSPb6NOTYmM5ZUbbfxbDrHx8ODF44QL1M1BL
	x0uwSmqjVlXAgZhAGgaTHY75D+KV7qvZYfKqKH+2XuZzOAoDNvRR
X-Google-Smtp-Source: AGHT+IElgS92FK4m1DLWIi46UcX2f1EmeSGSn87CJJzItyfhuyEmA1PDbtcANh4MI1yqwPzl+LS7+A==
X-Received: by 2002:a05:6871:152:b0:21a:3542:2ab5 with SMTP id z18-20020a056871015200b0021a35422ab5mr4479651oab.41.1708091087679;
        Fri, 16 Feb 2024 05:44:47 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id m20-20020a63f614000000b005dab535fac2sm3249117pgh.90.2024.02.16.05.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 05:44:46 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 3BB9C18483F4A; Fri, 16 Feb 2024 20:44:42 +0700 (WIB)
Date: Fri, 16 Feb 2024 20:44:41 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Linux USB <linux-usb@vger.kernel.org>
Cc: pmalani@chromium.org, jthies@google.com,
	"Christian A. Ehrhardt" <lk@c--e.de>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Saranya Gopal <saranya.gopal@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] usb: typec: ucsi: Get PD revision for partner
Message-ID: <Zc9myZ-1oE_qsSQB@archie.me>
References: <20240209223824.622869-1-abhishekpandit@chromium.org>
 <20240209143723.v5.3.Idf7d373c3cbb54058403cb951d644f1f09973d15@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xmkz5NkVvM5TFQTX"
Content-Disposition: inline
In-Reply-To: <20240209143723.v5.3.Idf7d373c3cbb54058403cb951d644f1f09973d15@changeid>


--xmkz5NkVvM5TFQTX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 02:37:32PM -0800, Abhishek Pandit-Subedi wrote:
> +	command =3D UCSI_GET_CONNECTOR_CAPABILITY | UCSI_CONNECTOR_NUMBER(con->=
num);
> +	ret =3D ucsi_send_command(con->ucsi, command, &con->cap, sizeof(con->ca=
p));
> +	if (ret < 0) {
> +		dev_err(con->ucsi->dev, "GET_CONNECTOR_CAPABILITY failed (%d)\n", ret);
> +		return ret;
> +	}

Did you mean that above error is raised when the connector capability
isn't recognized?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--xmkz5NkVvM5TFQTX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZc9mxgAKCRD2uYlJVVFO
o4zwAP4oR4MoDeAuM/4kruIg8A3QFNP39W25pV7k9DiiprHnsAD/cmXqIp4eEyzP
g2tnAN+Z4hBZ05uI4CtQwV1FLWWM3wU=
=oYH6
-----END PGP SIGNATURE-----

--xmkz5NkVvM5TFQTX--

