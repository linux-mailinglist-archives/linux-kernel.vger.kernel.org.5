Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB7B7F2C80
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbjKUMEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjKUME2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:04:28 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC6A122;
        Tue, 21 Nov 2023 04:04:24 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 324F340E0197;
        Tue, 21 Nov 2023 12:04:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DVvm4jo8TLeR; Tue, 21 Nov 2023 12:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1700568258; bh=CXdTAUEtdTl5TYq93mfgK/hyj77srMKuoK0d+w8u8Rg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YCYP90B265SfIeKpR+CLwhkYgSpSX5Z9+I7O25lCD7AXw/YeM/b+c0u2h0yMveNdq
         FKJevsTI8mTrMfMDv03UkEieORVDLudx7RwgN0CStz8Jb5ceEVxOPNZVW/bu08KYun
         5Yrv2UHuIDS9Xbf9b3tzgewcnA4YJBCroVxvetRgInFvliGOYusgXuoF6w+2EJ2VU/
         1svqJJO4p73JXAIlIHCQ6YkYoq03rFqp+OvkA3UA9P+8yhQlDtdRpbFFoG0X3sKOHK
         qAKWMOz/kJCOr/Ul8YwYY79eP/8DKWMY0SxeINaJmRRr/qc0IQwskO2Q6/DGRtCnrE
         5RmnF+yJZty3COGyLvU2QF/E4GIld1v4OTtVk0HZOxc3bwTbM1akL/tBZ8an1A3d0/
         iRc56cJAQwINOhQBUSdSfFuiX5/dfd9exKUIIZAfJxskEn8qJJdrcFXMvYcciTpG1x
         a+ZQYp/h3DRLDliAxx/WGOOo90GthSECvlyd+EEnsKNIXFeDKyNP7bz6kYTVJGuXcJ
         XM4m9qQcpjGsQIclB/h5fGHCs8rgKoSDxt0akRisw9fx9yQf1FAMS3fBsI50aKu3UF
         gRM74s17MAftM/BwoRptHdlEYF0hiVHScmS7AmL9FGj3uVb1xjhl2YZno97/DKgPC2
         NQvekL1GS69kDZVyEh0rwJyg=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7114840E0032;
        Tue, 21 Nov 2023 12:04:12 +0000 (UTC)
Date:   Tue, 21 Nov 2023 13:04:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
Subject: Re: [tip: x86/apic] x86/apic: Drop apic::delivery_mode
Message-ID: <20231121120411.GDZVycu2OPzz8Jqq4Z@fat_crate.local>
References: <20231102-x86-apic-v1-1-bf049a2a0ed6@citrix.com>
 <170055619380.398.4920358369820385873.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <170055619380.398.4920358369820385873.tip-bot2@tip-bot2>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 08:43:13AM -0000, tip-bot2 for Andrew Cooper wrot=
e:
> The following commit has been merged into the x86/apic branch of tip:
>=20
> Commit-ID:     b5148dfe66f5b04fdf85fbd3d0954e83792fa36c
> Gitweb:        https://git.kernel.org/tip/b5148dfe66f5b04fdf85fbd3d0954=
e83792fa36c
> Author:        Andrew Cooper <andrew.cooper3@citrix.com>
> AuthorDate:    Thu, 02 Nov 2023 12:26:19=20
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Tue, 21 Nov 2023 09:37:30 +01:00
>=20
> x86/apic: Drop apic::delivery_mode
>=20
> This field is set to APIC_DELIVERY_MODE_FIXED in all cases, and is read
> exactly once.  Fold the constant in uv_program_mmr() and drop the field=
.
>=20
> Searching for the origin of the stale HyperV comment reveals commit
> a31e58e129f7 ("x86/apic: Switch all APICs to Fixed delivery mode") whic=
h
> notes:
>=20
>   As a consequence of this change, the apic::irq_delivery_mode field is
>   now pointless, but this needs to be cleaned up in a separate patch.

Looks like you folks missed a spot or three:

drivers/iommu/amd/iommu.c: In function =E2=80=98irq_remapping_prepare_irt=
e=E2=80=99:
drivers/iommu/amd/iommu.c:3360:51: error: =E2=80=98struct apic=E2=80=99 h=
as no member named =E2=80=98delivery_mode=E2=80=99
 3360 |         iommu->irte_ops->prepare(data->entry, apic->delivery_mode=
,
      |                                                   ^~
drivers/iommu/amd/iommu.c: In function =E2=80=98amd_iommu_deactivate_gues=
t_mode=E2=80=99:
drivers/iommu/amd/iommu.c:3637:50: error: =E2=80=98struct apic=E2=80=99 h=
as no member named =E2=80=98delivery_mode=E2=80=99
 3637 |         entry->lo.fields_remap.int_type    =3D apic->delivery_mod=
e;
      |                                                  ^~
make[5]: *** [scripts/Makefile.build:243: drivers/iommu/amd/iommu.o] Erro=
r 1
make[4]: *** [scripts/Makefile.build:480: drivers/iommu/amd] Error 2
make[4]: *** Waiting for unfinished jobs....
drivers/iommu/intel/irq_remapping.c: In function =E2=80=98prepare_irte=E2=
=80=99:
drivers/iommu/intel/irq_remapping.c:1115:32: error: =E2=80=98struct apic=E2=
=80=99 has no member named =E2=80=98delivery_mode=E2=80=99
 1115 |         irte->dlvry_mode =3D apic->delivery_mode;
      |                                ^~
make[5]: *** [scripts/Makefile.build:243: drivers/iommu/intel/irq_remappi=
ng.o] Error 1
make[4]: *** [scripts/Makefile.build:480: drivers/iommu/intel] Error 2
make[3]: *** [scripts/Makefile.build:480: drivers/iommu] Error 2
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [scripts/Makefile.build:480: drivers] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/mnt/kernel/kernel/3rd/linux/Makefile:1911: .] Error 2
make: *** [Makefile:234: __sub-make] Error 2

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
