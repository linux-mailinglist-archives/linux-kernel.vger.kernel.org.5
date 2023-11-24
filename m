Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9625F7F69B6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 01:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjKXAPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 19:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKXAPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 19:15:33 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A492DD73
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:15:39 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cf74ad87e0so11276155ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700784939; x=1701389739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UOQxpoxQBCNJvC6K8xY7JNQFw7lekkoXyyaiOUVybHI=;
        b=jtwphVtU/iWozORdBU2epC7GS/AfJ2eiyIIwd/rCflPAq0v2pnkTEqAX/YghXGv5ES
         7mKWQD166w6A5sJpDnemAKAX/PRY8zS+KqsZyi6ixnfapCfJ94XU0I7+lsKb1QbDfqft
         Zs2EwXfpzqf+3tfQQ1pMO/M2HQhdF3zk6iS+MZHPGLcj/57gkrx7n8G7Gs+BPwhDqXP0
         p7L3P85tPNWp1egNNfyVCXiv89P/XZJBkPL2NEe28b06MdPajW2wPyc1ziznO97W24IY
         J1mrj6YcW5GpZQ/kbfJsPwG0peOHP+KBSVxF11Uj2sEbuGPKLpS4oqtYxWOoIBEiK5PI
         sfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700784939; x=1701389739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOQxpoxQBCNJvC6K8xY7JNQFw7lekkoXyyaiOUVybHI=;
        b=ScbF/XlS8QHQBxDxs2M3nCnENx64BucZ9PT/JYhtJLzeQ65MD2MQ+zuFUaxRA1jY/J
         jmgE7d8DnmrR2m4iBna10Wbg6B8E6HE9r8D2k+hjOMKuO1e2CZHUM4Hx6Am6I1PXPTD7
         kbdNoHR+UmwCKiV7N1YZoT6B9S/9eqZnYCSvEDNwQBxbBmr5PNFb/lJQTLrxVfqOGUBJ
         KjY5clVdTT0iLglBkNAvKkVYpKUhhnF5ddw/gunqzog/nxTxS9bZdoaG1rvp1p2XfM/3
         IXdxBppR1zX6UdTaU0QeyAouQWhFz4pgoVv34S8ZPfblwD4ZNSFhFBVWZNFcKrPP/tdS
         XT3Q==
X-Gm-Message-State: AOJu0Yz+Bp4Q+tj3HLELFbfo0yl2Xny2HLtzUbg3sG5avw15afq4HUJg
        SWbfIWahIjqRB/fRzWW2rkg=
X-Google-Smtp-Source: AGHT+IF2N+iIqdw7ZHI5UTpWEk8mydR61zWnnhEX3hodaYJl763l3Si0dDToYHt8dV9hcaqvgpGxXA==
X-Received: by 2002:a17:903:11c8:b0:1cc:511d:eb43 with SMTP id q8-20020a17090311c800b001cc511deb43mr1032137plh.61.1700784939083;
        Thu, 23 Nov 2023 16:15:39 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902b94700b001cc2ebd2c2csm1907659pls.256.2023.11.23.16.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:15:37 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id AD2F310210547; Fri, 24 Nov 2023 07:15:34 +0700 (WIB)
Date:   Fri, 24 Nov 2023 07:15:34 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chun Ng <chunn@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Ankita Garg <ankitag@nvidia.com>
Subject: Re: [REGRESSION]: mmap performance regression starting with k-6.1
Message-ID: <ZV_rJtxdn1dU9ip0@archie.me>
References: <PH7PR12MB7937B0DF19E7E8539703D0E3D6BAA@PH7PR12MB7937.namprd12.prod.outlook.com>
 <ZV7eHE2Fxb75oRpG@archie.me>
 <ZV9x6qZ5z8YTvTC4@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EoRIruQuJ6zaLywE"
Content-Disposition: inline
In-Reply-To: <ZV9x6qZ5z8YTvTC4@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EoRIruQuJ6zaLywE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 03:38:18PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 23, 2023 at 12:07:40PM +0700, Bagas Sanjaya wrote:
> > Anyway, I'm adding this regression to regzbot:
> >=20
> > #regzbot ^introduced: v6.0..v6.1
>=20
> this is not a regression.  close it, you idiot.
>=20
>=20

why?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--EoRIruQuJ6zaLywE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZV/rJgAKCRD2uYlJVVFO
o6hyAP9fiTuPiFsneZoBQnhzNsR1BsG/B71Gz5mNrcD7gDPc2gD/UyYGMzZWtopz
kk8xCnTgdiyHgKx8WzJEMF+Hmw+T1g0=
=i6TV
-----END PGP SIGNATURE-----

--EoRIruQuJ6zaLywE--
