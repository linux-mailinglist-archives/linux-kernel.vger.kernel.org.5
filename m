Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BFA76A9ED
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjHAH1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjHAH1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:27:17 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CA6F1;
        Tue,  1 Aug 2023 00:27:16 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-799a451ca9cso1660512241.2;
        Tue, 01 Aug 2023 00:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690874835; x=1691479635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7KIGZwA5gSq1xiYPTxpABuRbYjwdKovk1doJXVlPF0=;
        b=Mq2szzo7iqnTtxwMA+MiMZjOy8JWI88T3hSU4Ly5M+atekVVUamGMZfuxhu8RpLKk0
         23NSo0d/HVGkW7N507MrR71nH/Egbwa3fcPPgefV/CtxlU8LWD40kCarHVn+hMcV936S
         +COUzPmVrVGPgPKWytcmtFUOsB7SWgJPVg+YsQjAmsEap7+nlQK8kxM1DKl7FeIGPWKh
         X05ChWVq5HTulbNwbyok21cYdGovE9HwN/y+Gbx96Hc94ZoUP345M2IxgCz2wEWPpqbC
         C3ehx9x4KeHGC4beFtNTA276KxGGX3iIfXzLqZkHXrI8n/44NR3yi7HesDf+DBeIOsqf
         giOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690874835; x=1691479635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7KIGZwA5gSq1xiYPTxpABuRbYjwdKovk1doJXVlPF0=;
        b=Osap0x3Iet8oBHi6rv4A2FgKPksLp1eAKMZMSEgyYmuiSYZJiyoMnRJFRdLkQIDpzJ
         aXfUwEtNQKZ3nlVjSO86trwdVduF/763RvKH9OVWHd3DFRLECFbvNIPCq50MDwl84aYM
         gvLIns2HZfwobPWlUO+Vof7SDNvPySC49iFQWDXGjR66wq8GFj1GE7ZNGIscmCcxicge
         k8gWqWrV2TU8klms/vPl6WzR3SgBciXM6nNDxKP2rL/f9DcGa6ny0Mr/19su3pQAJrhR
         3XdurR9Ugau/bMwARoXhac2JQRMBB/pPrEZa9ugMpmTuFbyWIdeXDx3pbeTJBxhhnoJc
         lniA==
X-Gm-Message-State: ABy/qLaGD7XdP5wiwKxc8+/602v7U6d0IBukeEiwRZ5OU7z+QnKrR1ZK
        kKQNcikIdGUCOVkIpYvBJ+bfVirRslFfy7TX5t4=
X-Google-Smtp-Source: APBJJlG2YJWKkUnkL0wBCGZ4RjdngxR+iuif/HIMGg95l3vg+dJuB+OPwijVoCVxf1TsHyoOCpaajZm9GO6R8A9Spdc=
X-Received: by 2002:a67:f84c:0:b0:445:4996:1d27 with SMTP id
 b12-20020a67f84c000000b0044549961d27mr1789438vsp.3.1690874835502; Tue, 01 Aug
 2023 00:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230801045449.156348-1-zhouscd@gmail.com> <2023080159-uncorrupt-chamber-7de0@gregkh>
 <CAN4mUXNNM-25oCx1jjVqqoPpX1P8Z4zkjh84Azprz52O4_AMNw@mail.gmail.com> <2023080108-resilient-citation-9a34@gregkh>
In-Reply-To: <2023080108-resilient-citation-9a34@gregkh>
From:   chengdong zhou <zhouscd@gmail.com>
Date:   Tue, 1 Aug 2023 15:27:04 +0800
Message-ID: <CAN4mUXNZomVDfve1p_2D6G38MXd=gWLdg3=eSUMnFcWhcyb2EA@mail.gmail.com>
Subject: Re: [PATCH] USB: gadget: Fix the function name error in sourcesink/loopback.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de, john@keeping.me.uk,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your patient response.

On Tue, Aug 1, 2023 at 2:23=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
>
> Please document this in the changelog text.

But I can't find the changelog text anywhere.

>
>
> But you changed the name:
>
> > > > -     ss->function.name =3D "source/sink";
> > > > +     ss->function.name =3D "sourcesink";
>
> isn't that visable to userspace?

Yes, I removed the "/". Because the macro definition
DECLARE_USB_FUNCTION_INIT does not support "/".
Should I stick with the original "SourceSink"? I think using the
Linux-style "sourcesink" is better. By the way, due to the current
bug, no one should be able to use "source/sink" in userspace.


thanks.
