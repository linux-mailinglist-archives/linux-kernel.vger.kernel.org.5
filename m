Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C787FD405
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjK2KVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjK2KVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:21:31 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F736BA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:21:38 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-285afc7d53aso3281340a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701253298; x=1701858098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GM3p2UtlK0W9YPFHg+M2QYAU7NbevdATmwLhz/x5LRU=;
        b=OdgViA6TIlhPPmn2Iwm9JAIDpzwTjjTF00tsDRPL9YfJ1/Lm06gQClD2ziTGoah481
         qW+3btJFyzdDNC7ofmO6l0EC9FYJjAaJrjbEr91bchD/5RTWPqywIRr0vljnqmtdQdXK
         Ae9oXNH5j36FcYDomVc25lXc7SSWxAoPcKnnNv9JHZFnT+IHO8kpTh4u5V8ey8jEaEZN
         Iipzo6bcsP4O8l2kw9sxW0yQqTeV+tsY7sv38VR6OB4jfFZCAUCnios6jH3mEtABBM6n
         MltaStrA5MBGjBD1uCliymLRQjkCK232yQ2Y5UzNQGnhR3R1lfMvyUOIy602+E935uiR
         7CkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701253298; x=1701858098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GM3p2UtlK0W9YPFHg+M2QYAU7NbevdATmwLhz/x5LRU=;
        b=rxWtrBMEcBg7d4Zk2vwvwfVroesFHSZzXsrq4sHO7Jeo7v2Xc/TGvkWw1MqxtBRPBJ
         BV5EcOtRDQo2BpYFa6ayVbvyO3zFsanD6ufaqAmnjH0PV3DnNPdMVM4eYYiLWe//TjYi
         hgrBk4so/LjuGZ5jR1woEGFrfA4PBi3yUwdnjGGsdwU6KFbb1fd3FWAi7xaxO9cH1ebB
         lZXeoJSIr32P06Q3zeqU+ibx9iBVFepQn1yJ/z/me4yURcRwWbXIM9Rx6n4LL7wemT/t
         6GhvVVh/CGlkukAlNNFDCzicdyT2B9yAFPT4onqtBlkaWza4M/H7up8HC9sWsBcasTE4
         ha6A==
X-Gm-Message-State: AOJu0YyMLQf3RBTJfmeDeuphrOGAKOCYS0gdDKpUvTJfg9KcYPk31w5M
        e1Wc/RauUISUMbpjrwjpuqa7XXSd9+7KHwkvQe3xif69
X-Google-Smtp-Source: AGHT+IHitoVBXyIbwOJl5RStegGRIO2odoVSIWkxMBXT4OjACbafVVaQTIJKd7Pw4xmIC4XxM/avm0hCwa4ed1Pss44=
X-Received: by 2002:a17:90a:190e:b0:285:8cb1:7f53 with SMTP id
 14-20020a17090a190e00b002858cb17f53mr17372416pjg.31.1701253297768; Wed, 29
 Nov 2023 02:21:37 -0800 (PST)
MIME-Version: 1.0
References: <20231124090919.23687-1-ilpo.jarvinen@linux.intel.com> <20231124090919.23687-3-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20231124090919.23687-3-ilpo.jarvinen@linux.intel.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 29 Nov 2023 02:21:26 -0800
Message-ID: <CAMo8Bf+SwzUaYEt-V1gVfrgJ=DWxwZgMc0n4o2TOE11Ws656aQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] xtensa: Use PCI_HEADER_TYPE_MFD instead of literal
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 1:09=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Replace literal 0x80 with PCI_HEADER_TYPE_MFD. While at it, convert
> found_multi into boolean.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  arch/xtensa/lib/pci-auto.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Thanks. Applied to my xtensa tree.

--=20
Thanks.
-- Max
