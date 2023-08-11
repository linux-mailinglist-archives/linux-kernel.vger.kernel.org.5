Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F18F778E44
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjHKLzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjHKLzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:55:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAFE10F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691754913; x=1723290913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wkQiXD5lhHC4BlkyLDnM817+Xs35EEJIrj//vDXJ1+E=;
  b=RGJ6fQeNMFePoIhNZryeBwT6zFMQnZQfxVsqabvUyOanBXdLUYDfBJPi
   oRRd0LXbHRS8lOLmWShg9wezElLof+jqq+VFigvyjYt/xv0DlbpNke9Jf
   ExasImZD8iXJioUIP8wj51C+IhsczWp7m7RNwaL7Y5hATvW1er+3ptEr9
   v8jRVdAI0hKrUYakR4T68A80Q3yxihLwGHDBAN59bRxcJOkK4f1XMqFqE
   M3gGBKO5I9xi9akISy4UGNb0m5mHBrvCg2lvZeWB/XsFXKWCBHZCan1sv
   ZEwEyRifmL1WoZa5/NOLYcF/BlKLfExAfFVCK0k4K/V3bWU8pHb7sY64t
   g==;
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="asc'?scan'208";a="241105573"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Aug 2023 04:55:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 11 Aug 2023 04:55:06 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 11 Aug 2023 04:55:04 -0700
Date:   Fri, 11 Aug 2023 12:54:26 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
CC:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alan Kao <alankao@andestech.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Bo YU <tsu.yubo@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH -fixes] riscv: uaccess: Return the number of bytes
 effectively copied
Message-ID: <20230811-overture-catnip-2b004303cbc5@wendy>
References: <20230811110304.1613032-1-alexghiti@rivosinc.com>
 <dff5c443-bebf-9bd9-af1c-85ebfb7c2aec@ghiti.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="utvI2jTqZvG5HlnU"
Content-Disposition: inline
In-Reply-To: <dff5c443-bebf-9bd9-af1c-85ebfb7c2aec@ghiti.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--utvI2jTqZvG5HlnU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2023 at 01:39:16PM +0200, Alexandre Ghiti wrote:
> On 11/08/2023 13:03, Alexandre Ghiti wrote:
> > It was reported that the riscv kernel hangs while executing the test
> > in [1].
> >=20
> > Indeed, the test hangs when trying to write a buffer to a file. The
> > problem is that the riscv implementation of raw_copy_from_user() does n=
ot
> > return the number of bytes written when an exception happens and is fix=
ed
> > up.
>=20
>=20
> I'll respin another version as the changelog and the title are incorrect:
> the uaccess routines should not return the number of bytes copied but
> actually the number of bytes not copied (this is what this patch
> implements).
>=20
> I'll wait for feedbacks before doing so!

While you're editing te changelog, can you make the link a regular Link:
tag? You can do `Link: <foo> [1]`.

--utvI2jTqZvG5HlnU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNYhcgAKCRB4tDGHoIJi
0hKBAQCQBCxeWgLbOKa053boEyjUTJSr9hF6K1Lz9DQbnvSa9AD/Tow8dsW2O5Nh
xIRwuL7H4GhlsBa32V3l2JqT/gkP7Q8=
=Dq+D
-----END PGP SIGNATURE-----

--utvI2jTqZvG5HlnU--
