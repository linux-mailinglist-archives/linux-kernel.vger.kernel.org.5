Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252FC7ED1CC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344315AbjKOUJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344093AbjKOUJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:09:00 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338BFAF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:08:57 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5af15c3f734so5434587b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700078936; x=1700683736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dudJu8bqmoA0uQm5mbpxz9Q3fjggrbI693boctNIlwg=;
        b=C9P0Osyqjw2MahNSc6AVyHVGIhJOQJe71JwTbyFHzBL+790bo5Y0z5+72A8Htzfcic
         r2uquAL+Opc+D5H0Aln67KdvUQEsAup738ir6HNzSkvNxo+vzYA1Zy2Ug6XOh2ZtTYmw
         z2IqkH/pATleEfVbPM+5GNC5FlGdxmgx6J06LZKbhsWYDqbUF+/v3IvKJP+ECsrbHqcN
         Z6nrfC/lbcfOjFBRLuIGFXEUDwBbUl9edDvYPyTmtAxxIet7hDG7WOWGoPTCwvf7/B6H
         x+EsRQisWfU7ghopbtdzTaY0dEcVEMM9oXRqTXj1YRJ5polBviNLd4pdlqRqKayXL0No
         w28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700078936; x=1700683736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dudJu8bqmoA0uQm5mbpxz9Q3fjggrbI693boctNIlwg=;
        b=IOILeY6i0Vb0XUMTHFDR8nJbn/uDkcv55vRBq9Dcg1PLVCJridwntFSh7f+xTvYeAX
         GowIX096nB8QUXIxHIvj04bfFraO96376ELxJNjDTgQRP1ntVdl/USpjdmGa6L3NuaeF
         QbALqiA/llThjkN7fUu0DJbWX+gonb9UU+jml3Unplg0nRLuCt4Dt94aPvMTsRDQyM/z
         /zTT7Tkc7BWBNi9GW2K6Kg3vJHyhDJnxXFoUifWJZeroyjEHKLUodyloKwaFMnRxC2+J
         ZNTGd0Mg9oNLj46noFOM4+wIq7FBIGott+29pAn2KS3NjrmAm+woQ4ULHC4bcHR1LVe+
         VNDw==
X-Gm-Message-State: AOJu0YxMXxMgqOMHlc0tkd0DwDQrx4ORbzaWBP9qWPT0ytlEagHqr+7u
        CotudqPTwNRYf8O9fnSbBGZwaGQ5Qjz1ErkMlP8=
X-Google-Smtp-Source: AGHT+IHRkkHlie4UQ1NReHZ8gGxmxQucffqCVtYpZbaibyoZxtH1P8lpv4HNZVkT5YfCpALDmktBsBV2BTTL3WdoRvk=
X-Received: by 2002:a05:690c:4887:b0:5a8:9e9:e661 with SMTP id
 hd7-20020a05690c488700b005a809e9e661mr4614841ywb.1.1700078936216; Wed, 15 Nov
 2023 12:08:56 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
 <CABXGCsOqbLRHSkiz79NkVQ-wUtR7y-ZFHvhMw0+JJ_cY2AZmSw@mail.gmail.com>
 <CABXGCsPE9=Qp3Jg5hkRsTQoNgODnS_cXFU1d+hg3Baob40AaAA@mail.gmail.com>
 <edc5b75b-c08d-4c62-ae5e-089ffac27772@amd.com> <CABXGCsO=pdxorK9pO7qBPJM-xvgPPtpZqxLvQO4t2AK5qW3vcA@mail.gmail.com>
 <DM8PR12MB5400EAB81E5FA10F4309A732D1B1A@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5400EAB81E5FA10F4309A732D1B1A@DM8PR12MB5400.namprd12.prod.outlook.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 16 Nov 2023 01:08:44 +0500
Message-ID: <CABXGCsNpEh7GjFPvx=rz6ZeB7Kx4iqV-e8HyFKyhNau2S5gENw@mail.gmail.com>
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
To:     "Lee, Alvin" <Alvin.Lee2@amd.com>
Cc:     "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>,
        "Wu, Hersen" <hersenxs.wu@amd.com>,
        "Wheeler, Daniel" <Daniel.Wheeler@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
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

On Wed, Nov 15, 2023 at 11:39=E2=80=AFPM Lee, Alvin <Alvin.Lee2@amd.com> wr=
ote:
>
> This change has a DMCUB dependency - are you able to update your DMCUB ve=
rsion as well?
>

I can confirm this issue was gone after updating firmware.

=E2=9D=AF dmesg | grep DMUB
[   11.496679] [drm] Loading DMUB firmware via PSP: version=3D0x07002300
[   12.000314] [drm] DMUB hardware initialized: version=3D0x07002300



--=20
Best Regards,
Mike Gavrilov.
