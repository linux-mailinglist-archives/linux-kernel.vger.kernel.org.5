Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBD8801AC6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 05:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjLBEtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 23:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBEtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 23:49:14 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E847910C2;
        Fri,  1 Dec 2023 20:49:20 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5c21e185df5so947600a12.1;
        Fri, 01 Dec 2023 20:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701492560; x=1702097360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDM7c+J640phVwZ5XAJUWTL/q6brdZPnES26u51DJ/M=;
        b=LR68eEvHvn4cBOMIj029ghGq+rxu4lf9++Y/FylRtrfsdVWwZidYGl0/W1pV4EXJZ7
         BSCQgxueGYyNchPmUAD+MZGC3gMjQWWkPxcjJx9I0b1JvLadUJabFO0POkf+cu3BWEgr
         cAZiOzun4nOlpPhfcy03HnUt1VuRVD8Vd+TcZYgwDIUSQa5kB/Cc5tuEULqStxArtFQ0
         Qxpn1ezUxuXN2CgRM0DG2rmtBZD8BgIZTj+jlwT/1iyNQPCvFo/VovRngLNsjVQw90mN
         fs3QCTQR8UROdkXCqUTIThFuaFyfNswmmc9conQWcxeqr+sUabK02HhUeEzWk+pZgRQy
         eeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701492560; x=1702097360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDM7c+J640phVwZ5XAJUWTL/q6brdZPnES26u51DJ/M=;
        b=RIlx7yUuP625QoWn8rycCXzBapBKXeYtCIvsmtqHthnE6ZaowKDrZ19BwL+bquxMN2
         IZliV5aP2uNMk0BKBZc0tBl9SFI7WtCO4vGlMp0KASPOSbSGvNo02/osZgUcwY2DtdrO
         4Ty3IYcp0HARa9GwrnPXNdJPTdly98mhX/hL/kfigVXC7Lfnxcicdag9U+nuABb/zSGe
         2E/WHb+g4Mtu5i2mCJrXnxfzlFs4qD5QrxkseM35aQgZvsNv3xnsSwyNP45Z1NYqX9nb
         Zr4m/VNDSQv4QUqg0ViCwtNyhK/4JmalUq8Q12BcpkX1fAicQy7QLw4Itxt5WqvRueLT
         PsHg==
X-Gm-Message-State: AOJu0YzIkbI3ro6dbmgMDLxANY6CAuM+k/b+FuNiv7qXV4+7W7UXJAAR
        edFOJeuXPl6r824fPCucn0k=
X-Google-Smtp-Source: AGHT+IFZYcp1sHZaaQ1PH+HUoGIIaqmYaZeowIbuF4MCveJ2xYTvOeak3SGKUDxBGl1uQRjQPOxvMA==
X-Received: by 2002:a05:6a20:c1aa:b0:18f:97c:978f with SMTP id bg42-20020a056a20c1aa00b0018f097c978fmr940032pzb.119.1701492560286;
        Fri, 01 Dec 2023 20:49:20 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id js3-20020a17090b148300b002809822545dsm3925725pjb.32.2023.12.01.20.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 20:49:19 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id 1FFB710211875; Sat,  2 Dec 2023 11:49:16 +0700 (WIB)
Date:   Sat, 2 Dec 2023 11:49:15 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jiri Pirko <jiri@resnulli.us>,
        Linux Networking <netdev@vger.kernel.org>
Cc:     kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
        edumazet@google.com, corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Subject: Re: [patch net-next v3] docs: netlink: add NLMSG_DONE message format
 for doit actions
Message-ID: <ZWq3S_EEFfCaaEGf@archie.me>
References: <20231201180154.864007-1-jiri@resnulli.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o4mQa6Zyb7za6H4+"
Content-Disposition: inline
In-Reply-To: <20231201180154.864007-1-jiri@resnulli.us>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o4mQa6Zyb7za6H4+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 01, 2023 at 07:01:54PM +0100, Jiri Pirko wrote:
> diff --git a/Documentation/userspace-api/netlink/intro.rst b/Documentatio=
n/userspace-api/netlink/intro.rst
> index 7b1d401210ef..aacffade8f84 100644
> --- a/Documentation/userspace-api/netlink/intro.rst
> +++ b/Documentation/userspace-api/netlink/intro.rst
> @@ -234,6 +234,10 @@ ACK attributes may be present::
>    | ** optionally extended ACK                 |
>    ----------------------------------------------
> =20
> +Note that some implementations may issue custom ``NLMSG_DONE`` messages
> +in reply to ``do`` action requests. In that case the payload is
> +implementation-specific and may also be absent.
> +
>  .. _res_fam:
> =20
>  Resolving the Family ID

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--o4mQa6Zyb7za6H4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWq3SwAKCRD2uYlJVVFO
oxjbAP9AarUu2n9EKnzgCkkOwiMGjbpkoBRqtCz7KNLFrriFEAD/XzJJwUEScOXU
6vmxKU/hTr1RceftTUwLRdPL0eTN3gU=
=nDqC
-----END PGP SIGNATURE-----

--o4mQa6Zyb7za6H4+--
