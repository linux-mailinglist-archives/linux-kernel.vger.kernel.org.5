Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC097C478F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344731AbjJKB4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344209AbjJKB4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:56:31 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F1692;
        Tue, 10 Oct 2023 18:56:28 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9a6b21d1daso1361093276.3;
        Tue, 10 Oct 2023 18:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696989388; x=1697594188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XC8PueYOq+Wqn3z5e3szqjiYXCBBwjuhKP8Z06nA7jo=;
        b=ZS1pCZZbUzmq8Sbt5G4nuLpxVTWnF4KMDYUV7fYXgawEpxooqBmOL95xISiTvSIDM0
         wury6fKjKOngzFzs9nKjomUE7gzOhUbgvjKS1/grUiI8CgOiEyE4ESTIeb9Q+Dudf+Kd
         SYwNI5+YkYfAtjAy1fGZVtHf/bMFQRj811WUWS+uDFsiFEsLW+fdWBGYbytyP3O5lROk
         5bMO/dVx9XvlsWNiKhngrQ5EQMazOxw/nCMKyhh3dWRy1HBTQdGiJyTjhURSRqsd5gFQ
         IKuDRr8C7E8pPGUxRQlXYE7K5W6KkyA0WW4XOUmf32A7VhByHFroyrbNwlwyKEDiqXjg
         AReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696989388; x=1697594188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XC8PueYOq+Wqn3z5e3szqjiYXCBBwjuhKP8Z06nA7jo=;
        b=kpyyRRpaPRmxLGIFPBC3c+CKhTygwmtLF8dJFmqH61PFNNgYwuIV7mCGvrzeE7T9v2
         LKP87hTbVUEo0x1BSmejd5zJ2rPf0buuDdkWIx/eDypmoPCU+AgbyRfY/4gNR7PcM/Sx
         e38KP+DFDzoaT0hxplexEZ1e8+qTR1Kpfp1BfOS54sEI5J7FMUOiGM0bCAHjxa0ivK6n
         1UhXrbxB+j5gnOf/Ukt0NZ9IL/qLn0/X3zr8uxxpLyZ9RyTl8REZ6VTxpb5YsKKBfd6F
         BKN2Z+KSmu+Av803YSuSgp4d/WVzdzyL2dWY7Evikvyo64rmO3e7Rg0Uez4asKHRuN4A
         DPPg==
X-Gm-Message-State: AOJu0YyxjoWGJGEiYf5kaD5vV83ASdAvtFLyisRBzj9qpKDhPWi9vIKG
        sQivUGVNuk71BIXF5tg6K7lg7DPgHC9zwEr2/1A=
X-Google-Smtp-Source: AGHT+IFBPmknZnGhZ1ErD5xVPYQ4SLsQM4mNULHR3goKFPrtKDGF7axQoNhjZX5Ssec1Ue983aiMxqGLy8KoXKHYAvI=
X-Received: by 2002:a5b:151:0:b0:d81:8da3:348e with SMTP id
 c17-20020a5b0151000000b00d818da3348emr17706213ybp.41.1696989388082; Tue, 10
 Oct 2023 18:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231008075221.61863-1-hayatake396@gmail.com> <20231010123235.4a6498da@kernel.org>
In-Reply-To: <20231010123235.4a6498da@kernel.org>
From:   takeru hayasaka <hayatake396@gmail.com>
Date:   Wed, 11 Oct 2023 10:56:17 +0900
Message-ID: <CADFiAcKF08osdvd4EiXSR1YJ22TXrMu3b7ujkMTwAsEE8jzgOw@mail.gmail.com>
Subject: Re: [PATCH net-next] ethtool: ice: Support for RSS settings to GTP
 from ethtool
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub san
Thank you for your reply!

GTP generates a flow that includes an ID called TEID to identify the
tunnel. This tunnel is created for each UE (User Equipment).
By performing RSS based on this flow, it is possible to apply RSS for
each communication unit from the UE.
Without this, RSS would only be effective within the range of IP addresses.
For instance, the PGW can only perform RSS within the IP range of the SGW.
What I'm trying to say is that RSS based solely on IP addresses can be
problematic from a load distribution perspective, especially if
there's a bias in the terminals connected to a particular base
station.
As a reference that discusses a similar topic, please see the link
below(is not RSS, is TEID Flow):
https://docs.nvidia.com/networking-ethernet-software/cumulus-linux-56/Layer=
-3/Routing/Equal-Cost-Multipath-Load-Sharing/#gtp-hashing

Thank you for your understanding.
---
Sorry! My email was blocked because it wasn't sent in plain text mode.
I've made the necessary changes and will resend it.

2023=E5=B9=B410=E6=9C=8811=E6=97=A5(=E6=B0=B4) 4:32 Jakub Kicinski <kuba@ke=
rnel.org>:
>
> On Sun,  8 Oct 2023 07:52:22 +0000 Takeru Hayasaka wrote:
> > This is a patch that enables RSS functionality for GTP packets using
> > ethtool.
> > A user can include her TEID and make RSS work for GTP-U over IPv4 by
> > doing the following:
> > `ethtool -N ens3 rx-flow-hash gtpu4 sd`
> > In addition to gtpu(4|6), we now support gtpc(4|6), gtpu(4|6)e,
> > gtpu(4|6)u, and gtpu(4|6)d.
>
> This is for tunneling, right? IDK much about GTP but we don't have flow
> types for other tunneling protos. What makes this one special?
