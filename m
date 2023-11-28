Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7908C7FB003
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 03:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjK1CTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjK1CTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:19:41 -0500
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EEEC3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail3; t=1701137986; x=1701397186;
        bh=29w5NVRuek7/l0wHEq/U0JeFgdlkoLePKJ3LTCfQw+A=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=gRPZ+jKMrF07UYTmFzj2Y7vdBp0IIDNNf3RMvhzVmjos+f516TMJv7lOQERbDqXPr
         0Kr6wWZvF+RVYRBs3UBgl3zRM5YHTSDqqoKd0XSQE44Hl/t1MdiB7T1jtkx75y8VOg
         9C3QWA+zbqhNuSEiCkZH5FX57ezOB2xApBMbEQfsZrQ3K12ogBqa4SFMnvsw89LC/k
         L4TcVPSq8/RGWyyg7Hw0i2YQ0LE4wYtHgYr0chbQ4CmOuMpL757fKMwhtKxb/WNR5i
         VikLQjwXw5XiskU3158AzvcEXJXHx/VcVBpsQUgW6U2Jkbv5Y3aUtSb1TxCfv5XikG
         J9OlWY2lSenag==
Date:   Tue, 28 Nov 2023 02:19:42 +0000
To:     Rahul Rameshbabu <sergeantsagara@protonmail.com>
From:   Alexander Koskovich <AKoskovich@pm.me>
Cc:     roderick.colenbrander@sony.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] hid-playstation: Fix button maps for the DualSense Edge controller
Message-ID: <7gnt80t5c023J-Vo_c1TvJFYJ3OOpw3iaxcEtXDhFQQLmnE4eKK4VZH_sjd6hzrTtG5GwLwvgC0lD6UAeEAxJwA7N9qGsxmgONPCyDD03IM=@pm.me>
In-Reply-To: <87bkbeei6g.fsf@protonmail.com>
References: <20231126001544.747151-1-akoskovich@pm.me> <87bkbeei6g.fsf@protonmail.com>
Feedback-ID: 37836894:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To clarify, I did test this patch locally on Fedora Rawhide and confirm it =
works with games. It does resolve the issue, and is a workaround.
It's not just Steam/Proton I'm seeing this issue in, I'm seeing it in nativ=
e Linux games like SuperTuxKart.



On Monday, November 27th, 2023 at 9:16 PM, Rahul Rameshbabu <sergeantsagara=
@protonmail.com> wrote:


>=20
>=20
> On Sun, 26 Nov, 2023 00:15:49 +0000 "Alexander Koskovich" AKoskovich@pm.m=
e wrote:
>=20
> > This brings functionality of the DualSense Edge controller inline
> > with the stock PS5 controller.
> >=20
> > Signed-off-by: Alexander Koskovich akoskovich@pm.me
> > ---
>=20
>=20
> Will provide a follow-up to the relevant discussion.
>=20
> https://lore.kernel.org/linux-input/P8jVfYBAwiM_8MIgshN0osVVfshfBH2-oZCQu=
qoqh0Hy76_031zuZvYXWl0edtfTUwDOSNlc5priSRXI3G5dboVh5VPbcdxzAcEF7EvUVgo=3D@p=
rotonmail.com/T/#t
>=20
> Since I assume this patch was not actually tested to resolve the issue
> based on the evtest results, I think we should drop this patch. Will
> mention some details I might have with regards to the behavior you are
> seeing with Steam/Proton specifically.
>=20
> --
> Thanks,
>=20
> Rahul Rameshbabu
