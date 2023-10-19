Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F9D7CEE43
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjJSCzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjJSCzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:55:51 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA49106
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:55:47 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-57be3d8e738so4223580eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697684146; x=1698288946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjvl1fV//Z3DAmMVM5mc7jqsIEKxC7jjiLUBClRZgVQ=;
        b=LYJ/2VTbT6HKhz3S/4wE47370OFm/XQwHs8KzNxH9Epeh9h3wzVF3080lMrVlXQ5r1
         5bzHrcX9reUiJ+Nmw8gXKS2cSvmdjDMjetJAVpScCOrfC3lS7GSLEFK90+qItWP2HYXt
         qxPlfeHed3IMEG3MkItCisG5Cw8xO9xJqE/Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697684146; x=1698288946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjvl1fV//Z3DAmMVM5mc7jqsIEKxC7jjiLUBClRZgVQ=;
        b=SQHcyKF0bJVQ29b7BEKOVbvgtgUR8zMJfTpx/7iGoD+crCLJ8YSaBymad8TnDGTAwa
         t7YH4lBWijz0u2jWTrbx6u2vAkrQNYzKZmLhzXdP/GbKivgCNbrEFoi+iztJPQlY9zNV
         zOvk5Ottzml9PDfOe0D7sWrhdXt3t8/IcM1lFZOqFOVHLDBt/Jjm7XBhOEDc+YZVLZup
         /Dp5qg4WP0JWleRPd99cAR1NRsmKqcVhsrcj4DLsqENrKki/YRPsowto+6M5cj+cLHeA
         I1br6eZ0OkYpqJ0awAjnE3Lpm+J3UIzt5uZ0xyt6QVom3BTnW/7XCcKSaMVV1tc3S04g
         EPMg==
X-Gm-Message-State: AOJu0YwCTz+HgK7lHzvIMd/wI/72kUWCH2qbCHPUgDUZmAE714jxRkQN
        78tqr8LwJ6EpfuOP6OEFVhmVr4ouY9cWyClak1Cc9g==
X-Google-Smtp-Source: AGHT+IFSkiTIzKucqYACIEkT1mbAUXytYZj44oycOpJPUGvjGXMmZVMQgQTHi/yOZZAqD34ul6HEhfGp9OoQYF0aJOo=
X-Received: by 2002:a4a:bb83:0:b0:581:eef8:131f with SMTP id
 h3-20020a4abb83000000b00581eef8131fmr1111415oop.1.1697684146435; Wed, 18 Oct
 2023 19:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231017201417.129872-4-dregan@broadcom.com> <202310180553.Zfa2ryoa-lkp@intel.com>
In-Reply-To: <202310180553.Zfa2ryoa-lkp@intel.com>
From:   David Regan <dregan@broadcom.com>
Date:   Wed, 18 Oct 2023 19:55:35 -0700
Message-ID: <CAA_RMS4PGTA3nr_AXxZ8+dT+DQpW-_siQTxCeKaZvFe5FzP9qA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mtd: rawnand: brcmnand: exec_op implementation
To:     kernel test robot <lkp@intel.com>
Cc:     David Regan <dregan@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, Joel Peshkin <joel.peshkin@broadcom.com>,
        computersforpeace@gmail.com,
        Dan Beygelman <dan.beygelman@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>,
        frieder.schrempf@kontron.de, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, richard@nod.at, bbrezillon@kernel.org,
        kdasu.kdev@gmail.com, JaimeLiao <jaimeliao.tw@gmail.com>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Adam Borowski <kilobyte@angband.pl>,
        oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will make helper functions static

On Tue, Oct 17, 2023 at 2:50=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi,
>
> kernel test robot noticed the following build warnings:
>
...
>
> >> drivers/mtd/nand/raw/brcmnand/brcmnand.c:2393:5: warning: no previous =
prototype for 'brcmnand_exec_op_is_status' [-Wmissing-prototypes]
>     2393 | int brcmnand_exec_op_is_status(const struct nand_operation *op=
)
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/mtd/nand/raw/brcmnand/brcmnand.c:2404:5: warning: no previous =
prototype for 'brcmnand_exec_op_is_reset' [-Wmissing-prototypes]
>     2404 | int brcmnand_exec_op_is_reset(const struct nand_operation *op)
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~~


...
