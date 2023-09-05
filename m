Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC037792D2D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbjIESNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241225AbjIESM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:12:56 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADA815753
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 10:35:30 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3ab244f2c89so2059533b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 10:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693935249; x=1694540049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfuowvwObkut1KV19PYoCVuKvUfR++LVS9zQ0uZCb2Q=;
        b=RGgFx6hj0WkBNZMAKa5ElWMCN/iN8N7bbGXzL/Y94Uqnv3D85ASN9My/zj+jbp3Crb
         pjUy9jVAC73T9rHMYPl11JEAH9IVrohRkp6WpHVrDuQuyWzdbDDokbBBqDSzXAXmJ7kO
         j2xjJByZqP1U/SYK2j6jGX67/tABPNxJgMc1viJzIC1bp4LM+hxZrvuhqZEKd4hyI5FI
         5sK0RPCbMNgAKeNhsqtUz5axieDTAHsphulj2WnhjGBo3mJc+B+OOWw8yZJaWTuXIVNz
         AYNeSR6R1THrdtnrmlKWhFIaL+mOkNvnBN3S/SXNdUqNCpRkBTHpMT08qYCcBe2QIew8
         Fz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693935249; x=1694540049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfuowvwObkut1KV19PYoCVuKvUfR++LVS9zQ0uZCb2Q=;
        b=bF1bxpQ7PLRMLQA34hzg9MS7ghej+Y1s17i4AY//y4GXsZRTn6ty6thO0ljLYkw09F
         FaGsmF41jG3XBYBa9o4OEBBwpnOT6M9CJLhg29MWDE5g/G7JxnGlxfwWSD/8fVSpZ8MG
         koC36EthfWkXvnzqH9+kIv3uekOKOpcNxBHA3uCws+V+OFf1TZJtWuMh5acjbRNQJul9
         5Z1keeWtU5dGEJayKpEiCeJaWr0MH7fEpfnhWqyFNrX5UImki76KNAemIekPw/hvnUaw
         4gyKBj6Rn4HdmeQUzc9CX1ZRmLajxAtM28tn1LRa9/EqOoEQG/bft2KktU/2F7DDrebn
         xBJA==
X-Gm-Message-State: AOJu0YxiDudDfYUxP2s2Bc++oYGF3nHPiun3yQP6iD8zeydrvr/Edxqz
        tDIKRuhsxXJLOrl0xuu2AxH+aWqoABX1Rjd+y/z2Nd+P
X-Google-Smtp-Source: AGHT+IGg9ylwZSq88bEkF4d97ifutJU9DeuhtEPm9/ygCOF+DF9FwTwAk5NeAM2D74H+Rh1cSaJp9GP5hbCPYf+4PRM=
X-Received: by 2002:a05:6808:1406:b0:3a8:f3e7:d691 with SMTP id
 w6-20020a056808140600b003a8f3e7d691mr20687345oiv.37.1693935249151; Tue, 05
 Sep 2023 10:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230901005226.42307-1-yang.lee@linux.alibaba.com> <20230901005226.42307-2-yang.lee@linux.alibaba.com>
In-Reply-To: <20230901005226.42307-2-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 Sep 2023 13:33:58 -0400
Message-ID: <CADnq5_PRu+gzh5LHobvwN-uHaTShEoBn3rjx4C0Pc1O0mv2G=g@mail.gmail.com>
Subject: Re: [PATCH -next 2/4] drm/amd/display: Remove duplicated include in dcn35_optc.c
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, Rodrigo.Siqueira@amd.com,
        harry.wentland@amd.com, christian.koenig@amd.com,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Thu, Aug 31, 2023 at 8:52=E2=80=AFPM Yang Li <yang.lee@linux.alibaba.com=
> wrote:
>
> ./drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c: dcn35_optc.h is incl=
uded more than once.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c b/drivers/=
gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
> index d64be1a5071c..2bea1e475096 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
> @@ -23,7 +23,6 @@
>   */
>
>  #include "dcn35_optc.h"
> -#include "dcn35_optc.h"
>
>  #include "dcn30/dcn30_optc.h"
>  #include "dcn31/dcn31_optc.h"
> --
> 2.20.1.7.g153144c
>
