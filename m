Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E447FB081
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbjK1Cei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjK1Ceg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:34:36 -0500
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAF71A3;
        Mon, 27 Nov 2023 18:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1701138881; x=1701398081;
        bh=OmKNEOhmfI/LCTYuOTunAYKjcYUROIpp2HXRooB1X0c=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=G/Tyry1mef+qYx4ORvjLEUpkl/SmR23hN7EF5XOK6up6aRgShlTdw5GQrMUcB5BMh
         THAj8GGw6nVPY90y/c+9xu7/GN2s2rxe5i3/d6WVOgDwn+BWgwlZFoqjPVoYDcJLJu
         q2XcoH8GXbVJGoZxduA4W52hVEI263vxjhjeyhcrmABPwi6l5j7Lsu9BVEYmYo+OCk
         H2stKxvlclJZghpNzLr3Cq/c+ussVQEpIJxrKYaPlLwd6Aa8BUVUcldZwQnA3zTPTi
         u3UoTmStQbSD6oZc44wOnGbNPErgS6ejUkQDtHNFKT+CjVLSHlvFDBPcEqcVQkxHV0
         oTwBdTpyUX2JQ==
Date:   Tue, 28 Nov 2023 02:34:34 +0000
To:     Alexander Koskovich <AKoskovich@pm.me>
From:   Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     roderick.colenbrander@sony.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] hid-playstation: Fix button maps for the DualSense Edge controller
Message-ID: <8734wqehc9.fsf@protonmail.com>
Feedback-ID: 26003777:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov, 2023 02:19:42 +0000 "Alexander Koskovich" <AKoskovich@pm.me=
> wrote:
> To clarify, I did test this patch locally on Fedora Rawhide and confirm i=
t works with games. It does resolve the issue, and is a workaround.
> It's not just Steam/Proton I'm seeing this issue in, I'm seeing it in nat=
ive Linux games like SuperTuxKart.
>

Thanks for confirming. I am not that familiar with stk but I believe it
uses SDL2, which might be your common culprit.

  https://github.com/supertuxkart/stk-code/blob/a57ac415bbaf8e22a1c35f3ac09=
49c4dca322637/src/input/sdl_controller.cpp#L288

>
>
> On Monday, November 27th, 2023 at 9:16 PM, Rahul Rameshbabu <sergeantsaga=
ra@protonmail.com> wrote:
>
>
>>=20
>>=20
>> On Sun, 26 Nov, 2023 00:15:49 +0000 "Alexander Koskovich" AKoskovich@pm.=
me wrote:
>>=20
>> > This brings functionality of the DualSense Edge controller inline
>> > with the stock PS5 controller.
>> >=20
>> > Signed-off-by: Alexander Koskovich akoskovich@pm.me
>> > ---
>>=20
>>=20
>> Will provide a follow-up to the relevant discussion.
>>=20
>> https://lore.kernel.org/linux-input/P8jVfYBAwiM_8MIgshN0osVVfshfBH2-oZCQ=
uqoqh0Hy76_031zuZvYXWl0edtfTUwDOSNlc5priSRXI3G5dboVh5VPbcdxzAcEF7EvUVgo=3D@=
protonmail.com/T/#t
>>=20
>> Since I assume this patch was not actually tested to resolve the issue
>> based on the evtest results, I think we should drop this patch. Will
>> mention some details I might have with regards to the behavior you are
>> seeing with Steam/Proton specifically.
>>=20
>> --
>> Thanks,
>>=20
>> Rahul Rameshbabu


