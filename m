Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718E2810A46
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378589AbjLMG2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjLMG2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:28:51 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9739DB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:28:57 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67efae9b294so1187936d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702448937; x=1703053737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfWoOAEhzWz13IJUnmfWVXR60VzlBOfp6v3VoGhg56s=;
        b=sPuRKQ9KcluEdVi/NBmzQxaHkbg3PykAxMMSCJ9nuOCs849mHju7EdFzzEY8c+NgpO
         vsG9pyuHaEJoYXtH1EQE3kyP6qfdCqs5KuUNhJPaUFqNnRT6NkuqCLca9megHpuBXvar
         y08a1vAN/mXkscTsWS1tyBjaYxJYirC/VuaSNKYBuWRsQhvh2llI4C+DYK3dNI46vIWp
         /zGCbQ217/uADDdBuwPMHorXs5tr2h0Bl6d5/7GwM1O5f98ugMhctr+reh21OOXnaygc
         tUyUWEOJj3/7WVOUAXWwm0jj2pcOSTrbDdJNM2xYGtn/ov7j31pgzSlIiBfCYaedfTx5
         5HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702448937; x=1703053737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfWoOAEhzWz13IJUnmfWVXR60VzlBOfp6v3VoGhg56s=;
        b=tifdLftSwzhpHftVBL98CdpyA/tPWEGC3C7vvUbAwz2fOtf29jeMYeN8FXk5jz21cl
         Pds244+dtOkQ6trxXRFA7usqGQbgLpw2rL1UOacwTePl8Cohsh7DR+UYNRcFtRGxf3be
         haTA8904VtXB6+tXKbCL71Pi8FKL/42OIwaiR79FjKQ2YBYgKms/Dnv4zBPif81KLo7m
         gXWYvJzCSt1zglKla7pWv98HuRc5WSjQUsq2VHKgTAK3Jqzybp3ir55SscDMuj2z1vUA
         RnTHK09KcnQrURfoyE4MEedKwZ6By2B8DIW2T35eBEVERQVPhwAHffUtYx4Qc4T7kWVD
         SizQ==
X-Gm-Message-State: AOJu0YwBbwi+sZt2sFv/U4EV985B0THcG6s0kOEhW6p9kqZUEES8sAHK
        xPMGeTgMXdhdhKxMCwyzAGHeLIcxWCB4nwanIzBDVA==
X-Google-Smtp-Source: AGHT+IFQIALeeHZfeI0B1ULSgy5thPX1OIRpkDObxEfGi6ASSsgY2ykbUyVoeC3I1DCJrp+0TasdOJ/qJIJAelSGiLU=
X-Received: by 2002:a05:6214:1191:b0:67e:f5c8:fcab with SMTP id
 t17-20020a056214119100b0067ef5c8fcabmr691381qvv.87.1702448937006; Tue, 12 Dec
 2023 22:28:57 -0800 (PST)
MIME-Version: 1.0
References: <20231213080638.59f5d189@canb.auug.org.au>
In-Reply-To: <20231213080638.59f5d189@canb.auug.org.au>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 13 Dec 2023 07:28:45 +0100
Message-ID: <CAHUa44HTwOE+LZEg=kAnwzox3P9u2O0U42KL-fdRtVAyZs7Mog@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the tee tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Dec 12, 2023 at 10:06=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>
> Hi all,
>
> Commit
>
>   225e518c12a1 ("tee: Use iov_iter to better support shared buffer regist=
ration")
>
> is missing a Signed-off-by from its committer.

I'm sorry. Thanks for reporting, I've pushed an update now.

Cheers,
Jens

>
> --
> Cheers,
> Stephen Rothwell
