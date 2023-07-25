Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD60761D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjGYP0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGYP0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:26:37 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5D8E2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:26:35 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a3e1152c23so3949208b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690298795; x=1690903595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fUeb8wxv7pK70JGK+OzUJpuT5a5QL825TOjXkooBTM=;
        b=p4SlQTlBOX7qsNpWJHDm7lTzaQL8Y5qyTltfb4csDTCYNaRA8vscclEMiy+WAo9Omu
         TtGfjFLmQXv5CkZCDyTIjjsOQDvBy9vL2ZYzFzDJdS7Ui02dVc0j9z1FcfMn0tnMFstD
         fFm3dwv5KHD3NBdbKHxs23YWjZlhEnoiOYjaZcY5RtFrRpaeTizazIjQKOwYiXML99hK
         bqU8+OyXuPwAOxpDqSrAR7OGJeL4PGwL0aUtfkm5X5K7Eh4nG9yXPRlaHB8Oi4lv4rzE
         EuztkTxWpR8U+mhUkhUjbZp0aIPYPKRhjX11cc4jnGr/f5gc6mx9uQp2wzScbEGeRvh0
         ZvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690298795; x=1690903595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fUeb8wxv7pK70JGK+OzUJpuT5a5QL825TOjXkooBTM=;
        b=SuwFyw0EKvobkN9+knV950VGC5GxKcv5wT8/Eg6aJdjDJp9qioDOSB+CH/HDRB8sFg
         s/9frpcJFkBCMtou8rr55QhX4PfiOWBeZV+bjbuCSQ8CWoDKgoHI85/ZVCRM8pvp46Pe
         wLrwbLW4O1UsMK6lvu0dLSOlcs2vrHqB66INVWwZZUCtd2ELOjbfQbPw0S8A5FsRl/CI
         FUHA/pk5H8cnfjo48H7aug11f+lcE0CIxvPgShNxW01+8hCfKz/YdrxR/bc2Pk08U+PV
         9uMfCIkZRPpe/eyqjpk9TQukyZxUNXeZAA+Is1K2WcX6zDCl4TtuX7EWvek0Ecxp1s1j
         077Q==
X-Gm-Message-State: ABy/qLa3fJvxlhq6mnj7T+7dI/d/t7hdcvroYkkWBFB1Rr1mPvETcPuW
        RcDRR6/Pl+FEUUpyxVfOpT6MUAlCVs/XqfzbKgo=
X-Google-Smtp-Source: APBJJlEpTSUxyD+aoX0PG6FBzZg8ZBF0TeoTZhOm/IDSTSaDySFrvJAfT2bgxHD8GdcysYxS7w0r1B6khv4/MuoLp+w=
X-Received: by 2002:a05:6808:192a:b0:3a3:f237:61db with SMTP id
 bf42-20020a056808192a00b003a3f23761dbmr18906337oib.11.1690298794976; Tue, 25
 Jul 2023 08:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230725043946.33470-1-zhanglibing@cdjrlc.com> <6bf7217253d188c37004e8793bd58c88@208suo.com>
In-Reply-To: <6bf7217253d188c37004e8793bd58c88@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 25 Jul 2023 11:26:23 -0400
Message-ID: <CADnq5_Pk=zvAeHPjFT3=ZdLPKAzyMEyD-uxtfAB84nFtYsM9gA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Fix format error
To:     wuyonggang001@208suo.com
Cc:     alexander.deucher@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Tue, Jul 25, 2023 at 3:19=E2=80=AFAM <wuyonggang001@208suo.com> wrote:
>
> Fix the error(s):
>
> ERROR: space required before the open parenthesis '('
>
> Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
> ---
>   drivers/gpu/drm/radeon/r300.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/r300.c
> b/drivers/gpu/drm/radeon/r300.c
> index 9c1a92fa2af6..25201b9a5aae 100644
> --- a/drivers/gpu/drm/radeon/r300.c
> +++ b/drivers/gpu/drm/radeon/r300.c
> @@ -249,7 +249,7 @@ void r300_ring_start(struct radeon_device *rdev,
> struct radeon_ring *ring)
>
>         /* Sub pixel 1/12 so we can have 4K rendering according to doc */
>         gb_tile_config =3D (R300_ENABLE_TILING | R300_TILE_SIZE_16);
> -       switch(rdev->num_gb_pipes) {
> +       switch (rdev->num_gb_pipes) {
>         case 2:
>                 gb_tile_config |=3D R300_PIPE_COUNT_R300;
>                 break;
> @@ -638,7 +638,7 @@ static int r300_packet0_check(struct
> radeon_cs_parser *p,
>         track =3D (struct r100_cs_track *)p->track;
>         idx_value =3D radeon_get_ib_value(p, idx);
>
> -       switch(reg) {
> +       switch (reg) {
>         case AVIVO_D1MODE_VLINE_START_END:
>         case RADEON_CRTC_GUI_TRIG_VLINE:
>                 r =3D r100_cs_packet_parse_vline(p);
> @@ -1180,7 +1180,7 @@ static int r300_packet3_check(struct
> radeon_cs_parser *p,
>         ib =3D p->ib.ptr;
>         idx =3D pkt->idx + 1;
>         track =3D (struct r100_cs_track *)p->track;
> -       switch(pkt->opcode) {
> +       switch (pkt->opcode) {
>         case PACKET3_3D_LOAD_VBPNTR:
>                 r =3D r100_packet3_load_vbpntr(p, pkt, idx);
>                 if (r)
