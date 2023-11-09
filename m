Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA7C7E741F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjKIWEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjKIWEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:04:44 -0500
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770193ABF;
        Thu,  9 Nov 2023 14:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1699567479; x=1699826679;
        bh=S1J35HbO+lUVg33fr64tkBvXBm9tFZP+6CCTZpI2ago=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=pghYXL3oDXr9i+y+OFaykpg1F3LxdwdgNJzp1rE7l7fnC/ZCfn1n1uaHLBU+Kgkdr
         E6up0ndKx0SYlXRiJ+b4afGHUdK9jZFYI83/nrMNSDFJPO6Ye/OXJqwj2c2vDsAzwC
         4CJf2LK2n8D7jtYaRKOxAdjIlQcoVTHELZMnYaBTHJGVriWggRXqiqAMl7GES/NBEL
         qJIa0qINsNfcliJVy0JCUB6KnyT3A8IRbn33skdkeJdV3Ar2g7JKpzUzwEQJqkDGXq
         k1QqaGeROD0j/d03JEO5gdNaPlEZqaBXERMXjRp8061zIuigGW3QAyBzwshUqm0GaJ
         lhMkCRN91RVlQ==
Date:   Thu, 09 Nov 2023 22:04:33 +0000
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
From:   David Revoy <davidrevoy@protonmail.com>
Cc:     =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Eric GOUYER <folays@gmail.com>,
        Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>,
        jkosina@suse.cz, jason.gerecke@wacom.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
Message-ID: <7wmtNlKuYResf5cFQ7M2QTalzIUtw0I6ohvPcz69Jo1c8flezyIlnJu1IwAgXhJ-u0NlRL3IV7HnL0Kza6fVBqd7X7jhc-Z6QCi3oqHEvpY=@protonmail.com>
In-Reply-To: <CAO-hwJKJW5jGDdaaS8eB7kcLQUvWO_1XkOzJG4HAcaRzw1cGnQ@mail.gmail.com>
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm> <20231108062306.33f5dcd0@dryade> <CAO-hwJK_xp1A=dEOV-2v3KJAf0bRLDWNcrFQeBpgEuxT-qSBnw@mail.gmail.com> <ZUtTpKyP0oxWhnn8@fedora> <CAO-hwJLjtjdr2gtrOWJFPZ-38YzKB8XfhDKWf_2jUPeiaP3EcA@mail.gmail.com> <CAO-hwJKNcwcDGEh33NZq4kSYtoxZzg9M2nzE_hVDYNFgA4g_dg@mail.gmail.com> <_DEF7tHL1p_ExY7GJlJvT5gRA7ZvNnVMJuURb8_WCV-0fbYXkLN2p5zHloi6wiJPNzGEjFAkq2sjbCU633_eNF_cGm0rAbmCOOIOfwe1jWo=@protonmail.com> <CAO-hwJ+zm=R7NwrALaLVmfPDtMNXpj0eoQgLkiS1wa6wd+hu+A@mail.gmail.com> <CAO-hwJKJW5jGDdaaS8eB7kcLQUvWO_1XkOzJG4HAcaRzw1cGnQ@mail.gmail.com>
Feedback-ID: 5460171:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

Thank you it works! =F0=9F=8E=89 =F0=9F=8E=89 =F0=9F=8E=89=20

> I've pushed an update of the file[0], turns out I made several mistakes.
> As a general rule of thumb, you can follow the MR I've opened at [1],
> click on the pipeline, open the last job ("make release"), then browse
> the artifacts and pull the file from there.
> [...]
> > But just to be sure, you don't have a custom configuration in place
> > for that tablet device?
> [...]
> [0] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/jobs/51399392/=
artifacts/file/udev-hid-bpf_0.1.0.tar.xz
> [1] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests=
/27

I tested the latest artifact on kernel 6.5.8-200.fc38.x86_64 and I also rem=
oved my custom configuration at startup (I had not much: an hwdb files for =
the 24 Pro =E2=88=92mainly for frame buttons=E2=88=92 and an xsetwacom bash=
 script for each tablet).=20

During the tests, the styluses of both 24 Pro and 16 Pro Gen2 worked perfec=
tly: right-click on upper button out-of-the-box, and the eraser tip of the =
16 Pro Gen2 continued to erase as expected.=20

I could also target with xsetwacom this 'button 3' of the styluses, and I t=
ested random available shortcuts (but I'll keep default right-click).

So, good job, and many thanks!

I want now to write a follow-up after the first blog-post. I see it is a MR=
 [1], maybe it means if it get merged it will be part of libevdev? What wou=
ld you advice to write for the ones who want to benefit from the fix?

Thanks again,
David

[1] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/merge_requests/2=
7
