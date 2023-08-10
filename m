Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F3C7774D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjHJJo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjHJJo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:44:27 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841901BCF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:44:26 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-63fbfc0b817so2683306d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20221208.gappssmtp.com; s=20221208; t=1691660665; x=1692265465;
        h=message-id:date:content-transfer-encoding:mime-version:references
         :in-reply-to:subject:cc:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8N5qvppFagZ3/tTB5uDHm2P4arYErRxqlmJ6dmhhhE=;
        b=xN6cFEhFHyEsngG5emJdOap4+V+nE6gFuMUzdro7EScDcVOWsmda4a5Yw6aRYSrt8n
         jm6Qhipnw5nThRxhfFbcBO1m2y5tY2Ujx3HgkIjezxPQVeIv1v9hHy1pHLyfoDsAnXGj
         /Ylx9F9FHNKWVrZBMKqTl26kNfACgEs9xzcd5TJ4orblhIamQjkHYgTfnXWo1XhtIBmj
         y1VFqUqNVnZLVgbDuZbbxpiacez7Vyr+rjFYdLFRKFbS0UnsgVHbOGIHGLNOgQnVTd/Q
         UL3HE11PZFFHeTizd0aJPaX5X2DsdjBvoj1OOfHioowZCvCVBUbZ5sR5HHbzdGe+8wFu
         o7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691660665; x=1692265465;
        h=message-id:date:content-transfer-encoding:mime-version:references
         :in-reply-to:subject:cc:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8N5qvppFagZ3/tTB5uDHm2P4arYErRxqlmJ6dmhhhE=;
        b=kw3w6uHZ19fWm5/UFxLaEA32GHjegSqarCU8DqzIW0UTxfuBGkQS8c50Q22Iu1BZDB
         oJMe0fMkMpHYjP63oToMHEzaLkV91J0478v/DSBEZSSHVjYC2eHkk7KRcVq03ND2fzAZ
         TvBBJcF0gh97ceonIwaDOzIxH4upQ/Mxq+6iuuIqlcNCqZfmNtJr4Rfg5YlNhPxXMBbp
         Xd1uNn8Rw0lQwhMa0oOesLy8CwsJj5OCV5rA3pm3rFZ4NEemTab05MZ6f4FFm6cb7Suz
         D+092b7TXTnJySSHgmPluEqT0IGRaSHBI2HgjxJFyqcTI7tC5eEM23ZC7KhvaabMLWjy
         lIig==
X-Gm-Message-State: AOJu0YzTr8RKZ2XtYKV7nmK3Rcie/M62RIfFVUn/DRHb+6SAxr4iENc4
        Odg8ropx3sdqb2DAHZe75Cjons3lS5RQIlzr+7w=
X-Google-Smtp-Source: AGHT+IEESh4xDID3zF+wAoEy9DnzJiY8LmKtY7N2rL3KylyDhQ2C7CAYIv8R76yPbkgFvDGO0D11aA==
X-Received: by 2002:a0c:edc7:0:b0:636:60c6:2034 with SMTP id i7-20020a0cedc7000000b0063660c62034mr1813651qvr.38.1691660665704;
        Thu, 10 Aug 2023 02:44:25 -0700 (PDT)
Received: from turing-police (c-174-179-75-62.hsd1.va.comcast.net. [174.179.75.62])
        by smtp.gmail.com with ESMTPSA id x6-20020a0cda06000000b00631f02c2279sm352804qvj.90.2023.08.10.02.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:44:25 -0700 (PDT)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.8+dev
Cc:     Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: next-20230726 and later - crash in radeon module during init
In-Reply-To: <129403.1691660102@turing-police>
References: <129403.1691660102@turing-police>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1691660664_2972P";
         micalg=pgp-sha256; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Aug 2023 05:44:24 -0400
Message-ID: <130185.1691660664@turing-police>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,MISSING_HEADERS,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1691660664_2972P
Content-Type: text/plain; charset=us-ascii

On Thu, 10 Aug 2023 05:35:02 -0400, "Valdis Klētnieks" said:

> I am seeing the following consistent crash at boot:

> Some quick digging indicates the most likely culprit is:
>
> commit cbd0606e6a776bf2ba10d4a6957bb7628c0da947
> Author: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Date:   Thu Jul 20 15:39:24 2023 +0530
>
>     drm/radeon: Prefer dev_* variant over printk

Nevermind - I see it was already reverted...

--==_Exmh_1691660664_2972P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQEcBAEBCAAGBQJk1LF4AAoJEI0DS38y7CIcCQMH/0Z74jwPSDcxxmLstOYKJ7lY
ApFXhH94MxeGEa7o0qtmysWn54I7/MmPHQMOZ3ZZWHHOF0QqpgahtO9Dm7XpFG9j
jwlFr+vODziew8p4dBjJ4BEZk9TpVoE8BOA2yUMpSylOGmw5t8uz3fUjEVGhtG8a
x/i+mZ/adPxymbtZ0h0NnhLabGXMYF5VZ2R2ZAbBwKOYR82UcNMEzm/IIWUOtapw
sa0+tgnGXe4PasXSXvx/TOaGJVIsPLLy2DwMu8EKwLT/KelLDS+cTPYlwZ06A1pg
CmYDOTTaB7cl0UxTmSfOduHo9o+Twx5ziyAuBfJ2540A2LXa2zDlgU//mb28jA4=
=kY7M
-----END PGP SIGNATURE-----

--==_Exmh_1691660664_2972P--
