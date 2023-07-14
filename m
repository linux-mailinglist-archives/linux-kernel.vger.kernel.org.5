Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53025752FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbjGNDLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjGNDKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:10:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EA22D69;
        Thu, 13 Jul 2023 20:10:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbfa811667so16454645e9.1;
        Thu, 13 Jul 2023 20:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689304241; x=1691896241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVbGas4sEoJ5xKhGSZng8WB8CQUp85wRHLkOJJze9Yw=;
        b=RtAxwvL7tSyWs9YPQHGmidAnld0e98gHfLIQcrZTKlGDLkBWmSMOGu92Cqm3SD5rrx
         LVJC5UxwStUshoDLbh6XGfB15qR5rI9Wg8vs2jvPq2UZKBfMhrDcKnOG0n9ZV6bYozBx
         70CN1f5rIVwMUxANrQI+wiwEl6n0TK9jp4rxg3KnLLcT4+h/VnCsDh6drugbIxEoNyJu
         WFZnxbB5Z7fNFe6F+XxuaFjAO05873JtRPet6MKxJWKqiVUS6Jlkmj3OVpHuzYaD0hbm
         TuDV7gJF7ifsZhxbL5YHL/GczNZt1P1x9fzyAcX44oRiNFGarQEUBAKZvAE2yBn+ogw3
         JDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689304241; x=1691896241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVbGas4sEoJ5xKhGSZng8WB8CQUp85wRHLkOJJze9Yw=;
        b=MQFcGHCuyaSUxv01zbW/2QDxtO8n7Kq86i31EbjoMafY9z3esu0YNQbBJSX7OD+THT
         8QTkzHSIXM3nhaYysnRVA+U2n3MpgrBK3vFY13uKNVm4ybrPm5PNlOuH1LlR5vstzN8X
         4O+vMAq12CpcmhKr3zrhFXitsk7+sJ6XyaFHpZzU1wVxHlLQKR+qmJSo/G5uarNVKPng
         QkMknQMLm43yGibdPnU1GRTQex9tdAm1m10qd+AtkLEfPjYoVx3LYsHHOHDVkZ1gZZVt
         lY2RXilNuP+C2bLp74FlR44Hyq0acY/jeXi71iHpGCGu4zFXtpPJAl/Owcxwn9dmjyg/
         k2Nw==
X-Gm-Message-State: ABy/qLa6RfyObD4jDklf5YDFq4Zl5UFgdvc9CVMX60hZy4G0dHz3McL0
        r4lW6l/GMET+zSY+kyn9mk08SZRhDU740wCj/Nuk0LL+
X-Google-Smtp-Source: APBJJlFnIEOcZV1Dbg6ruKXb80B2q6+E3ao3M3Y4tSAq2bkMRl3Kz91K90OFEtp00f0Yjd3rqTmeQ9IFU2YrF8qmfV4=
X-Received: by 2002:adf:ed82:0:b0:314:2736:ba3e with SMTP id
 c2-20020adfed82000000b003142736ba3emr1059146wro.3.1689304241153; Thu, 13 Jul
 2023 20:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAJNi4rMK6hc6vh8hwU_zb_p2uQn=FLOmAuAJuF1DxMfyG8nixg@mail.gmail.com>
 <3cdbddeb-bab9-789e-d9bc-8358dc5a635e@gmail.com>
In-Reply-To: <3cdbddeb-bab9-789e-d9bc-8358dc5a635e@gmail.com>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Fri, 14 Jul 2023 11:10:29 +0800
Message-ID: <CAJNi4rMiMXMxdyWGBk15TvEb0M4cabJYFLYny=Jx5RGoq8xuaA@mail.gmail.com>
Subject: Re: Question about the 'bw' field in the fio output
To:     Vincent Fu <vincentfu@gmail.com>
Cc:     fio@vger.kernel.org, linux-kernel@vger.kernel.org
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

The information is very very helpful, thank you Vincent !!

On Fri, Jul 14, 2023 at 12:44=E2=80=AFAM Vincent Fu <vincentfu@gmail.com> w=
rote:
>
> On 7/13/23 11:43, richard clark wrote:
> > Hi,
> >
> > I found that sometimes the fio command will have an additional 'bw'
> > field as below:
> > ...
> > clat percentiles (usec):
> >    |  1.00th=3D[.  51]...
> > bw (  KiB/s): min=3D45689, max=3D49753, per=3D100.00%, avg=3D49658.56,
> > stdev=3D89.23, samples =3D5
> > iops            : min=3D.....
> > ...
> >
> > Please there is a line beginning with 'bw (  KiB/s)...', but sometimes
> > the 'bw' line doesn't show, does anybody know the reasons?
> >
> > Thanks.
>
> See:
>
> https://lore.kernel.org/fio/7b2f76ca-42bb-dc73-dd07-2cc79729ecb0@gmail.co=
m/T/#t
>
> https://github.com/vincentkfu/fio-blog/wiki/Periodic-performance-measurem=
ents
