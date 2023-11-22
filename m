Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADB27F479E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344001AbjKVNVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343964AbjKVNVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:21:18 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDADE193;
        Wed, 22 Nov 2023 05:21:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cf73e25b72so3323665ad.0;
        Wed, 22 Nov 2023 05:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700659273; x=1701264073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNGFlXpLeFTnJCRR6Y2M9TMyhiU71gt62Qctjghc6I8=;
        b=fdLMBnnPP6LoerFhnTOGVm+pI2puYNOvqEWNY/+Z7zrrdqDOWRZRBUMNx/pVJUc9cL
         fsDrkNvoXzEQP4Cju0aO4GsCB1jtLrFpH243rQASuD1TvjH8dhwoMQHBTxrX8rvkwIcP
         xtv0sIdydELCJH/Jje2xQo8uiJ5rj3OKvPTdPP9dh+xGDgANZuNpEGj2794fLyFCuiRx
         aXz/nIG8EjMjT8YM1TyVWvw9OKUGdyW7eb2BUcWsVShBS4xuHKUhkRG8CG9kqb8Vnt3h
         lo58OhTYkmeWPXUyPLLLPOcjBNGyPxG04bf7OqQhamI6yh/zyivlmZHFGhLkdKcA1ooU
         DohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700659273; x=1701264073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNGFlXpLeFTnJCRR6Y2M9TMyhiU71gt62Qctjghc6I8=;
        b=jV60AAHaNv+k7wgcT5FsHZTquP2dCJDH9oTqvBo10MtT0ux8zA+ebOrjS06J8A9z0U
         kYr7VPuHYIF7yDGkPVoek5HAE/XfP8BANy7yD558pfBXcUBdhbvOkUqcvi5kuUpsVgzq
         orm1HQvmA9fvQo6SDIQZ3TxmVY7dBTujei60gZNUIu0ryfYmvwZjqthXUF+yFXD2QQwi
         FQWG/gmZHa3eI3eM4hFNeBBETbGTk+FymoQXiquA4JDWLZWPIcgCW1GoPtTAtAX+YE8P
         EO8KtrIdvq3N5qEMcq8hxP2R7PDH3B5CbLsT3ypxszpk9sSVXZmEfhYt3mZ6ylg26nYN
         XHmA==
X-Gm-Message-State: AOJu0YwzZl4uWVMeCJ1d7y5aDInBACdz9DRHPWDKeW0vmHN+0RtmI2sL
        es1V15Z2VFSK8HYmtrhcLFUR8SigVA1RbwrtibQ=
X-Google-Smtp-Source: AGHT+IGzBPf4hDlXNcGQRCu8WY4gcdSOLM7a7oO6hsUAEw72nGXyHtvJtwrK9TdLMRMrIoNMgAb/QwNGirnNQOyx2Cg=
X-Received: by 2002:a17:90b:3606:b0:281:2d56:e751 with SMTP id
 ml6-20020a17090b360600b002812d56e751mr2322112pjb.0.1700659273253; Wed, 22 Nov
 2023 05:21:13 -0800 (PST)
MIME-Version: 1.0
References: <20231122-imx-csis-v1-0-0617368eb996@ideasonboard.com>
In-Reply-To: <20231122-imx-csis-v1-0-0617368eb996@ideasonboard.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 22 Nov 2023 10:21:01 -0300
Message-ID: <CAOMZO5AW0qft5ciGAWuX=RC0zHwAWEpLCyB5TbeE0QH3Nb+nQQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] media: imx-mipi-csis: csis clock fixes
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Martin Kepplinger <martink@posteo.de>,
        Purism Kernel Team <kernel@puri.sm>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

Hi Tomi,

On Wed, Nov 22, 2023 at 10:14=E2=80=AFAM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> Two fixes to the csis driver: One to fix remove() another to only enable
> the clocks when needed.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
> Tomi Valkeinen (2):
>       media: imx-mipi-csis: Fix clock handling in remove()
>       media: imx-mipi-csis: Drop extra clock enable at probe()

Shouldn't both patches contain a Fixes tag?
