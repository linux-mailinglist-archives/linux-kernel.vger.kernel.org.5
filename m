Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6D77F68E0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 23:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjKWWMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 17:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKWWMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 17:12:22 -0500
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2FC10CA
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 14:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1700777546; x=1701036746;
        bh=B0nDUCCc/9uAjOJNodziQT/GZceyc0SBQRRLgxTUQNA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Mctgan7gGzEAOcJ8zOaWABlAzkJTBr8DVYCzOCRktmanjkuT7EG1WXo9V6lvAGAcH
         Uok0mzUwR56aVFBu2rdu2Gx09z+0PzMsRrrssmDiYiIwyMijEmxpvQQ6PJADRl3+zj
         M2DB7Oh9NTy4DvuL4VbsZd598pR+NmBeoiY45QeXnKcfkX4c3b7x8BNJYU6ajAKtdz
         bU7Gjh/E0303HazIJ7kBGNNy2McPUkKxxkP1lYffQsS2EL727gdJrSDM9PJQq1I++1
         ed97fDxrZ6totSRyN+qeoCpeBNDIUmhe/xdQSKNM0obwpn6sy9OxJ8wwmHimL4dYCB
         FAyDWMmmVP8/g==
Date:   Thu, 23 Nov 2023 22:12:22 +0000
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
From:   David Revoy <davidrevoy@protonmail.com>
Cc:     =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Eric GOUYER <folays@gmail.com>,
        Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>,
        jkosina@suse.cz, jason.gerecke@wacom.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
Message-ID: <evHI05gyKuWwynY1WdyVvXqKPUaPE8W34cc3tFfp9FWh94TWfA9FWfHun7AAscF9lqfbiYsLKGC7kTSZ9xWNZg88-PTpbGTLcFMc9D3P2HE=@protonmail.com>
In-Reply-To: <CAO-hwJJoCp0_kxf_HHN9n9EWy9YDSY4rP8ysYNrNg2xTUYtKEQ@mail.gmail.com>
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm> <_DEF7tHL1p_ExY7GJlJvT5gRA7ZvNnVMJuURb8_WCV-0fbYXkLN2p5zHloi6wiJPNzGEjFAkq2sjbCU633_eNF_cGm0rAbmCOOIOfwe1jWo=@protonmail.com> <CAO-hwJ+zm=R7NwrALaLVmfPDtMNXpj0eoQgLkiS1wa6wd+hu+A@mail.gmail.com> <CAO-hwJKJW5jGDdaaS8eB7kcLQUvWO_1XkOzJG4HAcaRzw1cGnQ@mail.gmail.com> <7wmtNlKuYResf5cFQ7M2QTalzIUtw0I6ohvPcz69Jo1c8flezyIlnJu1IwAgXhJ-u0NlRL3IV7HnL0Kza6fVBqd7X7jhc-Z6QCi3oqHEvpY=@protonmail.com> <CAO-hwJJ+nx72_TPfxcWRPBDZdDaPrO5yMNH4Y_mj6ej651Mesw@mail.gmail.com> <nFHw6XePiH5p60JsbQSbssRkiuABiTiR_n5fIYFZjPgkV3ObjjZuwTC84BJ_1vXYVufPbG3UvZ1L7ODSrrGlq9CrI7BTKhsV5QeAQoakV18=@protonmail.com> <CAO-hwJ+jwmTE-v7FsPi3f70mB8SqUha7Ek9DtptZ0auiFpGM7w@mail.gmail.com> <CAO-hwJJoCp0_kxf_HHN9n9EWy9YDSY4rP8ysYNrNg2xTUYtKEQ@mail.gmail.com>
Feedback-ID: 5460171:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Sorry for late reply.

> So it would be nice if you could try the artifacts of job 51600738[4].
> Again, download them (udev-hid-bpf_0.1.0-4-g5ab02ec.tar.xz), unpack,
> sudo ./install --verbose, then unplug/replug the artist Pro 24.

Ok, the main change I experienced after installing is xsetwacom=20
listing the ID name of the device with twice the name Stylus on=20
"UGTABLET 24 inch PenDisplay Stylus stylus". Before it was only=20
"UGTABLET 24 inch PenDisplay stylus".

$ xsetwacom --list
UGTABLET 24 inch PenDisplay Stylus stylus       id: 10  type: STYLUS=20

Not a big deal, but I thought it was worth to mention it.

> Then, I'll need the following sequence (ideally repeated twice or
> three times, given that your last record show a slight difference in
> the first and second attempt):
>=20
> - outside of the proximity of the sensor, press the upper button
> - approach the stylus to the surface keeping the upper button pressed
> - touch the surface with the tip while holding the upper button pressed
> - release the upper button while keeping the tip pressed (like previously=
)
> - press once again the upper button while keeping the tip touching the
> surface (like previously)
> - lift of the pen, keeping the upper button pressed, and still in
> range of the sensor
> - remove the pen from the proximity of the sensor entirely (move away
> 20 cm or so), while still keeping the upper button pressed
>=20
> It's actually longer to describe than to execute :)
>=20

Thank you for the detailed steps. True, it makes sens once=20
practising it. I made the gesture three time on:=20

https://www.peppercarrot.com/extras/mailing-list/hid-records/XPPEN-Artist-2=
4-Pro/2023-11-23_XPPEN-Artist-24-Pro_pen_tip-contact-and-press-release-uppe=
r-stylus-button-while-pressed-x3.txt

> But I would also totally understand that you had enough debugging and
> you would rather focus on using the tablets, instead of debugging
> them. In which case, someone else from the community might help me.

No problem for continue testing, I'm around! Thank you again=20
for improving the behavior of the tablets.

Cheers,
David
