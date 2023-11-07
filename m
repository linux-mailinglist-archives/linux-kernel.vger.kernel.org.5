Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3220A7E3572
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjKGHCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKGHCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:02:50 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3DE11F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 23:02:47 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6c33ab26dddso3807347b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 23:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699340567; x=1699945367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MhImXZki+e3l9q5cMOcKEg5tKeJtLJw2KQuBsfan6o8=;
        b=I0+D6Ev/Y5mPuPdxVf2E8l7vrbOAxu/g66Gjwoxm//WF6UZ9ZHwsjI+R3tM0EG2WFb
         QJc09K44lMZjXHEIJ7MaJTZspMyB2J6s6jfGBl9avHl3ZJa5fiSID30w99EBBvUTeIYD
         pGI2xA2BZCRRqlajHAolLKQ/fjQ1hmM3JcaI09FpYkplAS3bSSLaVhwoscksleO0KaBM
         oK5GXnzd6gao2MhnG7Qj+QN3YEV2lJVks5iBPDnmk5iJV49VXfzTo/qemQhFGtFxgqiv
         WSJwzZ2eWsbAQ/+tBAxRp7w6wN6O/zePbh9cx9TQiFaI7zkJ3tuS29zomQP0l1+cQ+Ff
         e+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699340567; x=1699945367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhImXZki+e3l9q5cMOcKEg5tKeJtLJw2KQuBsfan6o8=;
        b=aT/U04y5rUFA0CC4NK2hvagNrgFfD6YY429OZpJPOX5xZLUElt0GPfuhYTAlFQPWfz
         Il0tMnRqKZutpEoFwm/hEuQ0k9ZFVggNoGEwlEv4EOPIKUiThMz+gh649DAhEavAx2/V
         516fVmVG0/RHT06ywTohHhU5a9nIs9MRw7dUDIrSuRly032uLmXyv71jSSqMqDvf/kVE
         CdphbF29fKILGIlk/EE+ZyROxXzraK7TCJeROBnljviFMmuO3KGFXlRMoOKcwZgLAih4
         DIxN4zqeqccKpgyQ0Ryo1wz18B2B/+A4Zmxzz3E+xYKD/zeiFGXauZeG6oj+7eeTSqDc
         SLbQ==
X-Gm-Message-State: AOJu0YziSCPWVIFom5ghaw+3Suj5CpIvgqsUljZrw8eJ1albQ4VOhd/m
        gPK6Kk29wF0bmnvfUamg2UoIo9Vkht0=
X-Google-Smtp-Source: AGHT+IHo9Z3Zf5L0UZcK0SWcgVGHEc2d9mBm3oQcU4t2hdwJYLrV5Eg0O2JJfBr6d1ES1w53hyvasQ==
X-Received: by 2002:a05:6a00:814:b0:6b2:2a2d:7a26 with SMTP id m20-20020a056a00081400b006b22a2d7a26mr32198550pfk.28.1699340567209;
        Mon, 06 Nov 2023 23:02:47 -0800 (PST)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7850f000000b006c34f198b87sm6559385pfn.203.2023.11.06.23.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 23:02:46 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id A8750812C340; Tue,  7 Nov 2023 14:02:42 +0700 (WIB)
Date:   Tue, 7 Nov 2023 14:02:42 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        o-takashi@sakamocchi.jp
Cc:     Mark Broadworth <a.mark.broadworth@gmail.com>,
        matthias.schrumpf@freenet.de, LKML <linux-kernel@vger.kernel.org>,
        aros@gmx.com,
        Linux FireWire <linux1394-devel@lists.sourceforge.net>
Subject: Re: Regression from dcadfd7f7c74ef9ee415e072a19bdf6c085159eb
Message-ID: <ZUnhEjtUihOFQ9t1@debian.me>
References: <f878b188-3fe4-420c-9bcb-b431ac6088dd@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w3q6Fnqfq+qDr1d0"
Content-Disposition: inline
In-Reply-To: <f878b188-3fe4-420c-9bcb-b431ac6088dd@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w3q6Fnqfq+qDr1d0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 02:14:39PM -0600, Mario Limonciello wrote:
> Hi,
>=20
> I recently came across a kernel bugzilla that bisected a boot problem [1]
> introduced in kernel 6.5 to this change.
>=20
> commit dcadfd7f7c74ef9ee415e072a19bdf6c085159eb (HEAD -> dcadfd7f7c7)
> Author: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Date:   Tue May 30 08:12:40 2023 +0900
>=20
>     firewire: core: use union for callback of transaction completion
>=20
> Removing the firewire card from the system fixes it for both reporters
> (CC'ed)
>=20
> As the author of this issue can you please take a look at it?
>=20

Thanks for the forwarding regression report from Bugzilla. I'm adding it
to regzbot:

#regzbot introduced: dcadfd7f7c74ef https://bugzilla.kernel.org/show_bug.cg=
i?id=3D217993
#regzbot title: completing firewire transaction callback with union bootloo=
ps AMD Ryzen 7 system
#regzbot link: https://lore.kernel.org/regressions/f878b188-3fe4-420c-9bcb-=
b431ac6088dd@amd.com/

--=20
An old man doll... just what I always wanted! - Clara

--w3q6Fnqfq+qDr1d0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUnhDQAKCRD2uYlJVVFO
o7DUAP0RP7rzxGwMmKVmB1kMWNKdIa8/UWwlBYAbo73vLrBZCAEAiVscNSgGX9ua
+Vbu034qiRymtcE7krqgrX9QZ5HheA0=
=0pXV
-----END PGP SIGNATURE-----

--w3q6Fnqfq+qDr1d0--
