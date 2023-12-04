Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D0A803939
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjLDPwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjLDPws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:52:48 -0500
Received: from ar2.dbzero.it (unknown [IPv6:2a00:6d41:10:195b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C016BB0;
        Mon,  4 Dec 2023 07:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dividebyzero.it; s=20160415; h=Message-ID:References:In-Reply-To:Cc:To:
        Subject:From:Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tjPTAXiVGnrEMpxM75gAFv9NoZuFL91goO+rxxj9KDI=; b=Q0v1Anjz091GstyiSuyBG4yIyc
        JOR0xAIWuoNiT8MAUkuOjUh6vmFRRdT0MWqFaKhTzw9nDcOD8xGbN/OFN77heG70w5gG6Kc2sHqdR
        rU5t+0JAcd/ODtQiFaVfZxAuIV3/moFlrWIjuLJys/YwUOoHQDMa5X5ko+Bioeo9LaF8=;
Received:  by ar2.dbzero.it with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (Authenticated user: juri@dividebyzero.it)
        (envelope-from <juri@dividebyzero.it>)
        id 1rABFF-0004le-0S; Mon, 04 Dec 2023 16:52:29 +0100
MIME-Version: 1.0
Date:   Mon, 04 Dec 2023 15:52:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From:   juri@dividebyzero.it
TLS-Required: No
Subject: Re: PROBLEM: asus_nb_wmi sends KEY_BRIGHTNESSDOWN on pressing CAPS 
 Lock and PrntScrn on Zenbook S 13 UX5304VA
To:     "Hans de Goede" <hdegoede@redhat.com>,
        "James John" <me@donjajo.com>,
        "Corentin Chary" <corentin.chary@gmail.com>,
        "=?utf-8?B?SWxwbyBKw6RydmluZW4=?=" <ilpo.jarvinen@linux.intel.com>,
        "Mark Gross" <markgross@kernel.org>
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <93b172c0-79ad-47d0-9948-e286917c18bb@redhat.com>
References: <a2c441fe-457e-44cf-a146-0ecd86b037cf@donjajo.com>
 <39b5f902-3a7e-fc04-254e-776bf61f57e2@redhat.com>
 <024c4ad4-1a73-8c24-5e6f-f8c9f2f7b98f@redhat.com>
 <1884918.tdWV9SEqCh@dividebyzero.it>
 <77b3eed7-825d-41c5-a802-ea891a16f992@redhat.com>
 <07b057618b72f301142585844ccdcaab75a716fe@dividebyzero.it>
 <f656f81bb288e69878ca001ec3e27c3ad647e7ea@dividebyzero.it>
 <93b172c0-79ad-47d0-9948-e286917c18bb@redhat.com>
Message-ID: <fc826113b0fdb26e99e9e1f3faa84db327a19035@dividebyzero.it>
X-Original-Message-ID: <fc826113b0fdb26e99e9e1f3faa84db327a19035@dividebyzero.it>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the reply.

December 4, 2023 at 14:54, "Hans de Goede" <hdegoede@redhat.com> wrote:

>=20
>=20Ok, that is good to know. Is there any specific reason why you are pa=
ssing
>  "acpi_osi=3D!Windows 2012" on the kernel commandline?
>=20=20
>=20 Generally speaking passing any other kernel arguments then those use=
d
>  to specify the root filesystem and things like "quiet" is not advisabl=
e.
>=20=20
>=20 Everything should just work without passing any special options and =
if things
>  do not work without special options then that is a bug which needs to =
be fixed.
>=20=20
>=20 Regards,
>=20=20
>=20 hans
>=20

Honestly=20I don't remember the exact reason, but I had it since the begi=
nning, possibly due to not working hotkeys.
I removed it now, and everything seems to be working without any issue, o=
ther that now the brightness is no longer being controlled by the EC and =
cannot be adjusted outside of a graphical interface.
I'm going to keep it like this, I'll let you know if any issue should ari=
se.

As for the other cmdline arguments (which I had quite too many) I realize=
d that the only non-standard one I really need is `nouveau.modeset=3D0`, =
without which the driver - and sometimes the whole system - hangs (as thi=
s laptop has an old NVidia GPU I don't use but keep always disabled).
Do you suggest opening another thread regarding that on this mailing list=
, or should it be better somewhere else?

Regards,

Juri
