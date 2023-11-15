Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CA87ECA78
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 19:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjKOSWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 13:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjKOSWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:22:32 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2021AD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:22:29 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-582050ce2d8so888117eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 10:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700072548; x=1700677348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32VO735puFbdamdNP00HxmaLTpjFAS4aqR5oTCpG7cg=;
        b=F5EXJrPLji09LSKrAIMwiVsrye+DjJK91s1FJf5phqwUsywYaqArZRR+WXb5eoMlIt
         dqTx3JGL0/q/tPJ6E3w51pihZj64XfMLjIT4ztJhuQHQWvd8W5n89eD+0stkaXXmCGjH
         X09Lv9AFGl+fMGxY5h5T0wTwv1t/8RN9ngfYT2T9FPCSsYsNDLrqZ1ryjNa22VpLMi7R
         ojk3DYJifugEeRWEwJ0Olm0R0suhkhQb5HHxsz/iQnqc6LIxoA8gyENF4iJkBgecTL+H
         +PXuKCxilN6606LftFGtmtOcNq7+gNOnsYkbUPaQzEqGrOWL3fC5T7ao8870e3MxAJpV
         Bixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700072548; x=1700677348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32VO735puFbdamdNP00HxmaLTpjFAS4aqR5oTCpG7cg=;
        b=A+5ou0NEqcCKq/qgp5sN+qfIC3zEOdf79wnNB1mbaRCmIcgqmoFpmEuIcoF0qTVKFp
         It9sK8HFUplnTbkSiqDYiDK81XJAWl4H95ccSiwRo+cxQwD8O14CfGiV6BrFXY1MwBRG
         aiiS8+ZvlNnHlxBQLFGqcfkgjXpdYpNc7jV8+GmqqUrX28rjOtoZw4/aJbYYJetURSHw
         zPHH6dmpsXEx0A34cpJSxJ8r8NXXLVZiqKLZJASC4aeElFOwEdjE3uN5HyL9brPcPV3H
         loWD4L1CiQfl52gUT0j5e5tdhPbFGMGax8inO8X8pOQvDesVhM4hZEafgutZHT9/likt
         iPcA==
X-Gm-Message-State: AOJu0YzdULyOK1PAyfNlw3WwrUePjQjwE5gS1GH9zhqt5SnNaktK0EXF
        CN3j66kk89NvaU9RiyPoDgXddXXzE0CNHkDVKiK28WB4wplgaghCVLPVkg==
X-Google-Smtp-Source: AGHT+IEadcoahNdrfY6ZAPrKfcoQnF6RiRMMs0ykC4N9OaR6O7dANsmWRgJ1bhWI1yPaN7t07COzY6H8qCDEA7GBlPU=
X-Received: by 2002:a05:6820:2817:b0:586:abc4:2c18 with SMTP id
 dm23-20020a056820281700b00586abc42c18mr6151725oob.0.1700072548221; Wed, 15
 Nov 2023 10:22:28 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
 <CABXGCsOqbLRHSkiz79NkVQ-wUtR7y-ZFHvhMw0+JJ_cY2AZmSw@mail.gmail.com>
 <CABXGCsPE9=Qp3Jg5hkRsTQoNgODnS_cXFU1d+hg3Baob40AaAA@mail.gmail.com> <edc5b75b-c08d-4c62-ae5e-089ffac27772@amd.com>
In-Reply-To: <edc5b75b-c08d-4c62-ae5e-089ffac27772@amd.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Wed, 15 Nov 2023 23:22:17 +0500
Message-ID: <CABXGCsO=pdxorK9pO7qBPJM-xvgPPtpZqxLvQO4t2AK5qW3vcA@mail.gmail.com>
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     alvin.lee2@amd.com, hersenxs.wu@amd.com, daniel.wheeler@amd.com,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:14=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.c=
om> wrote:
>
> What version of DMUB firmware are you on?
> The easiest way to find out would be using the following:
>
> # dmesg | grep DMUB
>

Sapphire AMD Radeon RX 7900 XTX PULSE OC:
=E2=9D=AF dmesg | grep DMUB
[   14.341362] [drm] Loading DMUB firmware via PSP: version=3D0x07002100
[   14.725547] [drm] DMUB hardware initialized: version=3D0x07002100

Reference GIGABYTE Radeon RX 7900 XTX 24G:
=E2=9D=AF dmesg | grep DMUB
[   11.405115] [drm] Loading DMUB firmware via PSP: version=3D0x07002100
[   11.773395] [drm] DMUB hardware initialized: version=3D0x07002100


--=20
Best Regards,
Mike Gavrilov.
