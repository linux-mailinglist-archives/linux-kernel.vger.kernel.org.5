Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C8F811C71
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442323AbjLMS2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbjLMS22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:28:28 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FC0107
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:28:30 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-59067f03282so4269536eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702492110; x=1703096910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2suwt8vSdQ/DeMNrSZbO0otw3V4vmPXaSVKVeklDiw=;
        b=aXeFM2sgrn9xAEVa4MxlqreJNn+PbIJHmepHvKd+P+7G1ChnBzUwsHFRyErvg8ztx2
         uj+X8ttgDynezFB0GtnX4hAMLs+Svk8Uk+0+PDfNmLTuJvvKCbdxkC2qWsowtJ83Yhiq
         pMu9rz1FS7HvuFzOTl1g/aBl9A26xI4jF3REkyIh1dq2OGjexDTqXwQOc+As9C/QvxSn
         tzhIKaOBOrOnXQotnvEtS5Dcdev73S3KxvKb6vLtCjWLaPtLm3f66KR97dxvF0zDG7a/
         ix1lVyU6bloW6iK8sIJhKsEK/7I63iHbX7+wS8ElQe+GDTNVDNE+LZCs/XuBEwB2SYx7
         MMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492110; x=1703096910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2suwt8vSdQ/DeMNrSZbO0otw3V4vmPXaSVKVeklDiw=;
        b=R1THVMrsNW9CSvEuZoEUEpxhxvElrxIfBAUtw8vP3gJOYvl5ktigQjWdM4huqm3rPu
         G3KtUStXbYJPc1CPeu1kxj8rlFGOWI+yFPw8wFN9lWlh7urFGc62kavbS78ZdbHe5s59
         wrh+dHVWuq0s3gpdfIAOT1VrTEYy+vU1Dv9K2mPS8au7fxti53rEoISzDGX0kqn/vWbg
         75sAOqwWU7XGfAqWjAmSKuFkeNWXcEu5vgdxFyiQ6OQ9xbwoeUG0GmNJVNfSrnVlMV/4
         kLSynaOCDNfCTIZfSLKzt5Zq6buBidvSHre/ARKLwn1bP3E69e9UgSoAJFqSUuualcrW
         uWXQ==
X-Gm-Message-State: AOJu0Yy0H7cVPfMW55JwxaP9+6sLEsfV/6f30oLHxQcrawrZOICHyN/B
        6g4QHQYjluA9q6orEou2lfWvAULlzqrnakjHMMI=
X-Google-Smtp-Source: AGHT+IEE8NGbqkyFPIlrmSp4009XZ22BdueAT9TWg3vReqvOQyrtrSyGp1oHJ2Dq1q9nFO7I20ZYRQZL43VNElqArto=
X-Received: by 2002:a05:6870:a68a:b0:203:294a:50da with SMTP id
 i10-20020a056870a68a00b00203294a50damr1305331oam.75.1702492110198; Wed, 13
 Dec 2023 10:28:30 -0800 (PST)
MIME-Version: 1.0
References: <90172f4c-7cf7-b4ac-d630-42198bb80d62@gmail.com> <b236ff60-085b-460a-b1eb-ddcea1c79094@amd.com>
In-Reply-To: <b236ff60-085b-460a-b1eb-ddcea1c79094@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 13 Dec 2023 13:28:18 -0500
Message-ID: <CADnq5_OxNQGebrUT=F_ir9GGLGCHummgZpqsc-ma63t-H=mqGQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon: Prevent multiple debug error lines on suspend
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Woody Suwalski <terraluna977@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        "Deucher, Alexander" <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied manually.  Please double check how you are sending the
patches.  git complained about a malformed patch.  I'd suggest using
git-send-email.

Thanks,

Alex

On Wed, Dec 13, 2023 at 1:45=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 13.12.23 um 00:31 schrieb Woody Suwalski:
> > Fix to avoid multiple debug error lines printed on every suspend by
> > Radeon driver's debugfs.
> >
> > radeon_debugfs_init() calls debugfs_create_file() for every ring.
> >
> > This results in printing multiple error lines to the screen and dmesg
> > similar to this:
> >
> > [   92.378726] debugfs: File 'radeon_ring_gfx' in directory
> > '0000:00:01.0' already present!
> > [   92.378732] debugfs: File 'radeon_ring_cp1' in directory
> > '0000:00:01.0' already present!
> > [   92.378734] debugfs: File 'radeon_ring_cp2' in directory
> > '0000:00:01.0' already present!
> > [   92.378737] debugfs: File 'radeon_ring_dma1' in directory
> > '0000:00:01.0' already present!
> > [   92.378739] debugfs: File 'radeon_ring_dma2' in directory
> > '0000:00:01.0' already present!
> > [   92.380775] debugfs: File 'radeon_ring_uvd' in directory
> > '0000:00:01.0' already present!
> > [   92.406620] debugfs: File 'radeon_ring_vce1' in directory
> > '0000:00:01.0' already present!
> > [   92.406624] debugfs: File 'radeon_ring_vce2' in directory
> > '0000:00:01.0' already present!
> >
> >
> > Patch v1: The fix was to run lookup() for the file before trying to
> > (re)create that debug file.
> > Patch v2: Call the radeon_debugfs_init() only once when radeon ring is
> > initialized (as suggested  by Christian K. - thanks)
> >
> > Signed-off-by: Woody Suwalski <terraluna977@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Thanks for the help,
> Christian.
>
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_ring.c
> > b/drivers/gpu/drm/radeon/radeon_ring.c
> > index e6534fa9f1fb..38048593bb4a 100644
> > --- a/drivers/gpu/drm/radeon/radeon_ring.c
> > +++ b/drivers/gpu/drm/radeon/radeon_ring.c
> > @@ -413,6 +413,7 @@ int radeon_ring_init(struct radeon_device *rdev,
> > struct radeon_ring *ring, unsig
> >              dev_err(rdev->dev, "(%d) ring map failed\n", r);
> >              return r;
> >          }
> > +        radeon_debugfs_ring_init(rdev, ring);
> >      }
> >      ring->ptr_mask =3D (ring->ring_size / 4) - 1;
> >      ring->ring_free_dw =3D ring->ring_size / 4;
> > @@ -421,7 +422,6 @@ int radeon_ring_init(struct radeon_device *rdev,
> > struct radeon_ring *ring, unsig
> >          ring->next_rptr_gpu_addr =3D rdev->wb.gpu_addr + index;
> >          ring->next_rptr_cpu_addr =3D &rdev->wb.wb[index/4];
> >      }
> > -    radeon_debugfs_ring_init(rdev, ring);
> >      radeon_ring_lockup_update(rdev, ring);
> >      return 0;
> >  }
> >
>
