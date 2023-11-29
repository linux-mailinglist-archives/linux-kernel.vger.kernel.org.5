Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEC77FD4CD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjK2LAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjK2LAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:00:44 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CDCC1;
        Wed, 29 Nov 2023 03:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1701255649; x=1732791649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AKWihbdXdCcaNBGqaq4ELo/HAUelGjMVnoaPK9rZFRY=;
  b=Y2nXMf8qz7iv74FRlpkGf6UHMtTrHPdsioMcyEGc+oIWudKGRwHUgl/i
   I8pDFD1OQXXdaxsZHWfnFtYK776scUC/z/FN4Ibb5b4RJp1wB3IMbcjP7
   meejqPy358ez+Dvh7zCnb/Iv/8FgqCXpk4lrE5M5w8fFc65wM+2PQ5LUG
   zJzJfwoSXaYlcclo7IL3CRAeyGfL0C4cbrF2W4e1aC/Emy2pqMs9e/7pu
   Acfr24jD1J3K7pMeFIz5wkKlyp3ZX4sm2Sqtqep2oWcbVrdou3CWDA04i
   3U+30M8spdV6S5neQ3ED8wRYBIuQ5SJWqKWI8eUaZCjcanwXCqBsj3ssx
   w==;
X-IronPort-AV: E=Sophos;i="6.04,235,1695679200"; 
   d="scan'208";a="34235388"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 29 Nov 2023 12:00:47 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id B349B280075;
        Wed, 29 Nov 2023 12:00:47 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Paul Elder <paul.elder@ideasonboard.com>
Cc:     kieran.bingham@ideasonboard.com, tomi.valkeinen@ideasonboard.com,
        umang.jain@ideasonboard.com,
        Paul Elder <paul.elder@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] media: rkisp1: debug: Add register dump for IS
Date:   Wed, 29 Nov 2023 12:00:47 +0100
Message-ID: <5541424.44csPzL39Z@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20231129092956.250129-3-paul.elder@ideasonboard.com>
References: <20231129092956.250129-1-paul.elder@ideasonboard.com> <20231129092956.250129-3-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

thanks for the patch.

Am Mittwoch, 29. November 2023, 10:29:55 CET schrieb Paul Elder:
> Add register dump for the image stabilizer module to debugfs.
>=20
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>

Tested with a 1080p and 720p stream, without offsets.
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  .../platform/rockchip/rkisp1/rkisp1-debug.c    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c index
> 71df3dc95e6f..f66b9754472e 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> @@ -139,6 +139,21 @@ static int rkisp1_debug_dump_mi_mp_show(struct seq_f=
ile
> *m, void *p) }
>  DEFINE_SHOW_ATTRIBUTE(rkisp1_debug_dump_mi_mp);
>=20
> +static int rkisp1_debug_dump_is_show(struct seq_file *m, void *p)
> +{
> +	static const struct rkisp1_debug_register registers[] =3D {
> +		RKISP1_DEBUG_SHD_REG(ISP_IS_H_OFFS),
> +		RKISP1_DEBUG_SHD_REG(ISP_IS_V_OFFS),
> +		RKISP1_DEBUG_SHD_REG(ISP_IS_H_SIZE),
> +		RKISP1_DEBUG_SHD_REG(ISP_IS_V_SIZE),
> +		{ /* Sentinel */ },
> +	};
> +	struct rkisp1_device *rkisp1 =3D m->private;
> +
> +	return rkisp1_debug_dump_regs(rkisp1, m, 0, registers);
> +}
> +DEFINE_SHOW_ATTRIBUTE(rkisp1_debug_dump_is);
> +
>  #define RKISP1_DEBUG_DATA_COUNT_BINS	32
>  #define RKISP1_DEBUG_DATA_COUNT_STEP	(4096 / RKISP1_DEBUG_DATA_COUNT_BIN=
S)
>=20
> @@ -235,6 +250,9 @@ void rkisp1_debug_init(struct rkisp1_device *rkisp1)
>=20
>  	debugfs_create_file("mi_mp", 0444, regs_dir, rkisp1,
>  			    &rkisp1_debug_dump_mi_mp_fops);
> +
> +	debugfs_create_file("is", 0444, regs_dir, rkisp1,
> +			    &rkisp1_debug_dump_is_fops);
>  }
>=20
>  void rkisp1_debug_cleanup(struct rkisp1_device *rkisp1)


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


