Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD6380A706
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574305AbjLHPNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574335AbjLHPNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:13:24 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEAD19BE;
        Fri,  8 Dec 2023 07:12:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702048366; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Qtj4EdP4so68Ffcy9/6AJF/A8uD9kAcoRlqtjMMQEV271oaMiAHaX86fApJCwhlJNr
    Xv0x86cUpq3ZazTaEaJ+o8MeAU11zGxO2CtqV1OhL4vgMRueW1tTjSwvtwHp8m/8qREs
    NK5d5V/8WBeWcj9NHq3Q3R8sZi21w0k5fXNLVQJMzRG8B4SVE+9qKo8eonirMdcdivYa
    1GIgBSgqrjHfBtNnGv+XgElzQ0rsPjP6dpgMsip+rqw7JB1I41XwLXj9aynv4rOLeczc
    soexL/0/BBDlMq46FIqYwaNOH3YEPU0VacX3WZis+B7iAiMjRmmxj7jNP9O6OlltDNlS
    5kDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1702048366;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lhsrLh6Tpj4P9K5cubUK772KFrEGbhEVFA2KMXDo9uc=;
    b=dOiU+5h6IhAuMiDEbSs2Feiyvh/+ak4KGFt9iNxh3ZTkQynqpIztbGXqftQZIAJ2li
    IkUSvpa9XYz+jBlHnR1iAo80eGuRkQDK/9hzUH3loExR6s77xexQSVoB8jyTvvTgUcJp
    ppjERxCSUIKVO+xELnV5ULutNToqi9rSOUBSNHeL2TP98WSzH1U6K4rtApduregbgaaR
    3oSpf4Z+QcBF39/u9yDPXZZnDGv/5GfGSGQjx+XJOP8aZ4L9d387z0GVkHUG1wKGj+sE
    xsTQq4PKuR1N9xevl1uQoyT63Mz9AcnHVVMP3OwHHlcRQ+fGmv+Z0IfTIFKnT3iS85tG
    1QJQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1702048365;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lhsrLh6Tpj4P9K5cubUK772KFrEGbhEVFA2KMXDo9uc=;
    b=Tcdgrf4WFJ9M3ImclY4n5CROhi26S9+KbhZ4b0VMe6pxc3fFT42cNHqPKi/XXdr+es
    8U6NM90fkjy65fF3hNwju7HB7HcIkKBqnkOqsDvS8mlfZ+irvQJfX7p8zUASQ32xAxzj
    Aqawt9yPbbVKD4ct6ZVG3Ahrc5bxyvC62fZArICEFGsMLzmFkwMcztQtNqpXwCBRjeDa
    4NY7mVRqQ/JvIR4kZnb4t4EiNsy5QrYDaYCmPLWJ1A6zu0u9kRuJT1mz3esxE7b+VLgv
    29RlhelO6+xCTN3lyHIXCwloUVz2zsm5KzZqVwM6QOFUklrdheAlgSKy8zUc40jrTI3r
    1jEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1702048365;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=lhsrLh6Tpj4P9K5cubUK772KFrEGbhEVFA2KMXDo9uc=;
    b=jf/OEuW9N9VfvRs7wb9IyzSoOjO3tSo07hc+jTxJn2Uo1atdVhXX0dEIPMx2s/p9FY
    kmIvU07ojPeRG+cQALAA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
Received: from [10.176.235.119]
    by smtp.strato.de (RZmta 49.10.0 AUTH)
    with ESMTPSA id z4c2a6zB8FCiCbx
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 8 Dec 2023 16:12:44 +0100 (CET)
Message-ID: <89c02f8b999a90329f2125380ad2d984767d25ae.camel@iokpp.de>
Subject: Re: [PATCH v4 2/3] scsi: ufs: core: Add UFS RTC support
From:   Bean Huo <beanhuo@iokpp.de>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com, thomas@t-8ch.de, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikebi@micron.com, lporzio@micron.com
Date:   Fri, 08 Dec 2023 16:12:44 +0100
In-Reply-To: <20231208145021.GC15552@thinkpad>
References: <20231208103940.153734-1-beanhuo@iokpp.de>
         <20231208103940.153734-3-beanhuo@iokpp.de>
         <20231208145021.GC15552@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-08 at 20:20 +0530, Manivannan Sadhasivam wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0val =3D ts64.tv_sec - hba->d=
ev_info.rtc_time_baseline;
> > +
>=20
> This logic will work if the host has RTC. But if there is no RTC,
> then tv_sec
> will return time elapsed since boot. The spec clearly states that
> host should
> use absolute mode if it has RTC and relative otherwise.
>=20
> Maybe you should add a logic to detect whether RTC is present or not
> and
> override the mode in device?

Thank you for your reviews. I will incorporate the suggested changes
into the patch, addressing all comments except for the RTC mode switch.
The proposal is to perform the RTC mode switch during UFS provisioning,
not at runtime in the UFS online phase. This approach ensures that the
UFS configuration is populated based on the RTC configuration
established during provisioning. It is advisable not to change the RTC
mode after provisioning is complete. Additionally, the usage of tv_sec,
which returns time elapsed since boot, suggests that there is no issue
with utilizing the RTC in this context.

Kind regards,
Bean
