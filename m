Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9250C783C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjHVJBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjHVJBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:01:21 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48991CE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:01:20 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40a47e8e38dso174451cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692694879; x=1693299679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPEBgG45Y8MpD7W1zMd0c6pmHvwhLPDAtwYLm/BJKLA=;
        b=3wrNqYQ+7EAzvkwTwoOwP0NDvTHC/mtkHpGRvM1waGeTAxTcMsI597HtzHK3NVJeKe
         v3g6sa1Lekcr690elqNpaNVbJwkjTKKDWKJPAuSxOiWuZrWsXQQmPzabU8fkqV6w5zju
         8KkZlp4uafNA4Q5e539gxHjvf9azY/2deX5Wm59wrKKJKg1hLOmAUwfSPeiBZ7PIdqoy
         e+Vn47AaD5UNcfN4c3BGbHD3Wode0pTjL509WZW/PIZuYF5WPnAcQxnYAiamIFKbS1vo
         XdyCR5GJZ/WUJXTay48jTg/yIxvkd8ObucBmq7c7rqSfL5Fmxo2o8WONU/25IojlaV3W
         cJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692694879; x=1693299679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPEBgG45Y8MpD7W1zMd0c6pmHvwhLPDAtwYLm/BJKLA=;
        b=MGxudZ6FQIDY8dFbAAn5W7m5Hw0Ql/2su6qBHMJZzwpQapE/h+ljkdbHaurHskitG6
         qB6fQXmxXYHJQr4I33nXPybjhIIb2BRBozvym7DJsai27gwxr1rHdpg2Q7cfFdE1c47l
         QNLNQcvZG3zn9JPno2Gg08KGL5lJPNNH9D1eQqke5thodQc3PzwLU2YsijOAvI1xanQC
         akF9BBn1wsYUuuvoUwz/cga0l9q0NmkKJ3aQw9YN3RhDYBnVl3bBNnr5mRaMWDr8cTjX
         DdPNujo7/KtezPBrSvZhc6UgZPMMxGZ5MD1t9iu7DSDpACULFBy5d3cBBjhJaZbYSlsX
         +lEQ==
X-Gm-Message-State: AOJu0Yw/GgxLpMaxqJXukKqKJv5H2vwM79WWK0CxZvsYI+tsL54ddj/P
        uEO9C6klHhdsc0zCe1Z3WKXqb0/wMlmvrowLgcPlhrOJqidkGXgDaEw=
X-Google-Smtp-Source: AGHT+IER7LvBvaYnM4J9NLx4oCGgsKlywejZtCh0hhgSSGgDbc6Ffd4NpqGPxGCFSJQihm++T/7jWu9jFFNA2O3Zfuw=
X-Received: by 2002:ac8:5a47:0:b0:410:653f:90e8 with SMTP id
 o7-20020ac85a47000000b00410653f90e8mr148542qta.11.1692694879266; Tue, 22 Aug
 2023 02:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230815152712.1760046-1-amitsinght@marvell.com>
In-Reply-To: <20230815152712.1760046-1-amitsinght@marvell.com>
From:   Peter Newman <peternewman@google.com>
Date:   Tue, 22 Aug 2023 11:01:08 +0200
Message-ID: <CALPaoCh9LsUDz9320i9tvgte2+DoRvnr-RiAMJiudAVFM6AUGA@mail.gmail.com>
Subject: Re: [RFC 00/12] ARM: MPAM: add support for priority partitioning control
To:     Amit Singh Tomar <amitsinght@marvell.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        fenghua.yu@intel.com, reinette.chatre@intel.com,
        james.morse@arm.com, gcherian@marvell.com, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On Tue, Aug 15, 2023 at 5:27=E2=80=AFPM Amit Singh Tomar <amitsinght@marvel=
l.com> wrote:
> As an example, "schemata" file under resource control group contains info=
rmation about
> cache portion bitmaps, and memory bandwidth allocation, and these are use=
d to configure
> Cache portion partition (CPOR), and MPAM bandwidth partitioning controls.
>
> MB:0=3D0100
> L3:0=3Dffff
>
> But resctrl doesn't provide a way to set-up other control that ARM MPAM p=
rovides
> (For instance, Priority partitioning control as mentioned above). To supp=
ort this,
> James has suggested to use already existing schemata to be compatible wit=
h
> portable software, and this is the main idea behind this RFC is to have s=
ome kind
> of discussion on how resctrl can be extended to support priority partitio=
ning control.
>
> To support Priority partitioning control, "schemata" file is updated to a=
ccommodate
> priority field (upon priority partitioning capability detection), separat=
ed from CPBM
> using delimiter ",".
>
> L3:0=3Dffff,f where f indicates downstream priority max value.

Do we really have to mash two controls into the same schema? In the
CDP example, the code/data controls are presented as multiple schema,
for example: "L3CODE, L3DATA"

Especially when reading back the schemata file, it seems like it would
be simpler for existing software to ignore unfamiliar schema lines in
the schemata file than to overlook the introduction of a comma to the
CBM in the existing "L3" schema.

Thanks!
-Peter
