Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0524E76C21D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjHBBUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjHBBUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:20:43 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A376D2704
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:20:40 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230802012037epoutp01d7ca355f4d8f3d19450c1cc55b22083f~3bEb9O6Dc0154101541epoutp01W
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:20:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230802012037epoutp01d7ca355f4d8f3d19450c1cc55b22083f~3bEb9O6Dc0154101541epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690939237;
        bh=zEt/qzNGDrujNLPFvLIQQlKrZFFHDkvLgjLlxlQ+/3k=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=Qxs4eX98gQv15YZcllXMNst0b8VcBTTWSz/t1y+6EFOy+1N4hl51F1rCSW0BAEmjP
         +rRMhJQS1Y/j04asLQRdHRo/wAJAQMulq53NnS4YGLjla7FvMrA0nMc/IyU/9VVl8H
         oiGicU3J0vXwtvHxYtoru2LaO7xRYRXs5BCW+R5M=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230802012036epcas2p17c0aa82f2980d05a6fd4a72464909d05~3bEbgGldl1900019000epcas2p14;
        Wed,  2 Aug 2023 01:20:36 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.68]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RFvLC6wltz4x9Q7; Wed,  2 Aug
        2023 01:20:35 +0000 (GMT)
X-AuditID: b6c32a4d-853ff70000047356-e5-64c9af636f26
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.9D.29526.36FA9C46; Wed,  2 Aug 2023 10:20:35 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH] scsi: ufs: ufs-pci: Add support for QEMU
Reply-To: jeuk20.kim@samsung.com
Sender: Jeuk Kim <jeuk20.kim@samsung.com>
From:   Jeuk Kim <jeuk20.kim@samsung.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "dlunev@chromium.org" <dlunev@chromium.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <9bb7ac58-db99-238f-0d2c-450470f05c74@acm.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230802012035epcms2p4a6827b9192dc50b7ebd2d24de72f3fb5@epcms2p4>
Date:   Wed, 02 Aug 2023 10:20:35 +0900
X-CMS-MailID: 20230802012035epcms2p4a6827b9192dc50b7ebd2d24de72f3fb5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmqW7y+pMpBl3PzS1OPlnDZvHy51U2
        i2kffjJbvDykaXH80FcWi0U3tjFZXN41h82i+/oONovlx/8xOXB6XL7i7TG74SKLx+I9L5k8
        Jiw6wOjx8ektFo++LasYPT5vkvNoP9DNFMARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pm
        YKhraGlhrqSQl5ibaqvk4hOg65aZA3SdkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUg
        JafAvECvODG3uDQvXS8vtcTK0MDAyBSoMCE748fVsoK7nBUNz06zNzDO4uxi5OSQEDCReNV2
        hqWLkYtDSGAPo8S6H3eAHA4OXgFBib87hEFqhAVsJe5e3sgCYgsJKEjM2dbBDhHXlJi+fiIT
        SDmbgLrE6YXmIKaIQLDEtqVcIBOZBY4wSbze0MAOsYpXYkb7UxYIW1pi+/KtjCA2p4C1xMzZ
        i5kg4hoSP5b1MkPYohI3V79lh7HfH5vPCGGLSLTeOwtVIyjx4OduqLikxKlvj1kh7OmMEgv+
        m4IcISGwgFHiV/N0qAZ9iWsdEL/wCvhKHLgxgxXkaBYBVYkzTyogSlwk9t2+AFbOLKAtsWzh
        a2aQEmagd9fv0gcxJQSUJY7cYoGo4JPoOPwX7sOGjb+xsnfMewL1oYrE4ubDrBMYlWchgnkW
        kl2zEHYtYGRexSiVWlCcm56abFRgqJuXWg6P3OT83E2M4ISq5buD8fX6v3qHGJk4GA8xSnAw
        K4nwSv8+niLEm5JYWZValB9fVJqTWnyI0RTo0YnMUqLJ+cCUnlcSb2hiaWBiZmZobmRqYK4k
        znuvdW6KkEB6YklqdmpqQWoRTB8TB6dUA9OaZovWRhnGEuUoSYPz9fZbXnTZpXrNdnwqd3LZ
        SuYpfaZ3J7Axz/9bZJQ7ad/0Z+GXVrn+Pvi5wHX18u8T8vI+R6n7cRl0X+JMCt6o0em/k2Gl
        9IcZty8n3LGS5nj63GfWIv2HrXPOb1QRzvTI2SXdPb86UeNWX+GsqYsrQm+JnSzXaD5n/kdf
        wpxvTa6U9vzFs3/NfzMn6TDjtuQ97k/r3j5z/q+5rPmf73KtMy0/b6wzU8o7njI9JuT1Zy/T
        6x7PFq1lW3zwZ0re5RZWyWmLKwQ/PWns27hIjUtg6hwGGx/7ZmfGtvt3M4Jv/J33ML/U6OH1
        Vv99qpMf6L6R0SvJCd28wXyP7EZdTaNz53uUWIozEg21mIuKEwH8mSUtMQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230801073750epcms2p121c08e452aaafdda301c5562f4ccff5b
References: <9bb7ac58-db99-238f-0d2c-450470f05c74@acm.org>
        <48f05875-5255-70d2-0737-36fa95470037@intel.com>
        <20230801073750epcms2p121c08e452aaafdda301c5562f4ccff5b@epcms2p1>
        <20230801092000epcms2p44c99d2c15bc6169e38693cb64cf946db@epcms2p4>
        <3551d65c-2295-b6cd-b5b1-9264026cff61@intel.com>
        <CGME20230801073750epcms2p121c08e452aaafdda301c5562f4ccff5b@epcms2p4>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/23, Bart Van Assche wrote:
> On 8/1/23 04:12, Adrian Hunter wrote:
> > I was really hoping for an explanation of =22Why?=22 i.e.
> > why does anyone want a virtual UFS device?=C2=A0=20Why=20not=20use=0D=
=0A>=20>=20any=20existing=20virtual=20block=20device?=0D=0A>=20=0D=0A>=20I=
=20hope=20this=20will=20enable=20testing=20of=20the=20UFS=20driver=20inside=
=20a=20virtual=20machine=0D=0A>=20on=20systems=20without=20UFS=20host=20con=
troller.=20Jeuk,=20is=20that=20correct?=0D=0A>=20=0D=0A>=20Thanks,=0D=0A>=
=20=0D=0A>=20Bart.=0D=0A=0D=0AHi=20Bart=21=0D=0AThat's=20right.=0D=0A=0D=0A=
I=20would=20say=20there=20are=203=20main=20reasons=20why=20we=20need=20UFS=
=20virtualization.=0D=0A=0D=0A1)=20As=20Bart=20said,=20it=20enables=20to=20=
test=20UFS=20drivers=20on=20virtual=20machines=20on=20=0D=0A=20=20=20system=
s=20without=20UFS=20host=20controller.=0D=0A2)=20It=20works=20as=20an=20emu=
lation,=20so=20it's=20easier=20to=20reproduce=20and=20debug=20bug=0D=0A=20=
=20=20situations=20on=20the=20device=20than=20on=20a=20real=20device.=0D=0A=
3)=20It=20is=20easy=20to=20preemptively=20implement=20and=20test=20new=20fe=
atures=20before=20the=0D=0A=20=20=20real=20device=20is=20created.=0D=0A=0D=
=0AThanks,=0D=0AJeuk
