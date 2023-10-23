Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EED7D2DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjJWJOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjJWJOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:14:47 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A554C98
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:14:44 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-49d6bd360f8so1190419e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698052483; x=1698657283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCtCjxd1RRZXLXKRsDJH4TVy7DQ5KsOabXJL+qFywbs=;
        b=lJSnHPVOV+2EVE5zr9fPzxmqG4o10YPBU2Oy5f281jmRyKYT4cLFtMlD8bHiau9i6U
         EJR5OldwgxIDwQR9U6Ce1+t2bCEnXvVt4LIHR/+NKsN4JYJVuZAVaDuilYtgRC5ASZ6u
         KHU4wyAb+Xh0luKFE4FtfT9xmuFAm6A0xfFbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698052483; x=1698657283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCtCjxd1RRZXLXKRsDJH4TVy7DQ5KsOabXJL+qFywbs=;
        b=qTShWTQbM9CyssS3CptB20W/1+l9rUOxlXPHub17aKfhzv8aNtvOw7xHlNd/iqpzSL
         zhjjNIlqj92kPuOc27y0sRrdhXvYChTjmylg3aI3sEuBBpD21Sfiq3GsQiBvP+765AyA
         lCmC9mJYxF+6D/MaCplRs92dbit6tfzx2RCp+Lv15thETYL8r6F6FCEPnSkKye/Qc0RH
         +QoxhumI8On6Wayv4KqnwXN869XCmiGSCbo8hp+Bb0yazOiLpqRNaAhxLcVUnp4YS7zt
         DE0PS71dlD6ccmz3M2d1NZ92cOrw1207yPlhBB5NS9xTlusgkdZdCoZyPADqrHzVBGF+
         Y8qQ==
X-Gm-Message-State: AOJu0Yy6Rm/F1cyUhicZ7ysTN6lxNUGxXF7xZTHX3Zo5F8UG0sabpPJO
        wUf0Df9joXP9s6skRSwNCdJWAbdmNIyndCOICh0=
X-Google-Smtp-Source: AGHT+IFnK9m0taWYr5C0xXNsGKfa7OAmT839QhlkNj8xK/+nEyjFI+g85MLOelpC6kTjdRNgiisXfw==
X-Received: by 2002:a05:6122:a03:b0:490:e790:a15b with SMTP id 3-20020a0561220a0300b00490e790a15bmr8097956vkn.10.1698052483454;
        Mon, 23 Oct 2023 02:14:43 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id 4-20020a056122070400b0049d16dfe3c0sm828913vki.13.2023.10.23.02.14.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 02:14:42 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-49d0a704ac7so1189994e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:14:42 -0700 (PDT)
X-Received: by 2002:a05:6122:3114:b0:48f:8891:296b with SMTP id
 cg20-20020a056122311400b0048f8891296bmr8084999vkb.0.1698052482441; Mon, 23
 Oct 2023 02:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com>
 <20231023043751.17114-4-jason-jh.lin@mediatek.com> <CAC=S1njjd+-oEgmBeWJGQC0PsbOdJ5eLLw0Mf35HOjA8UHStTw@mail.gmail.com>
In-Reply-To: <CAC=S1njjd+-oEgmBeWJGQC0PsbOdJ5eLLw0Mf35HOjA8UHStTw@mail.gmail.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Mon, 23 Oct 2023 17:14:05 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhuuztiA5bixa5BEsPL46-pR0Sz-rPfTu2_NNCCvZozcQ@mail.gmail.com>
Message-ID: <CAC=S1nhuuztiA5bixa5BEsPL46-pR0Sz-rPfTu2_NNCCvZozcQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] soc: mailbox: Add cmdq_pkt_logic_command to
 support math operation
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 4:26=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote=
:
>
> Hi Jason,
>
> On Mon, Oct 23, 2023 at 12:39=E2=80=AFPM Jason-JH.Lin <jason-jh.lin@media=
tek.com> wrote:
<snip>

> > diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/=
mediatek/mtk-cmdq.h
> > index a253c001c861..ea4fadfb5443 100644
> > --- a/include/linux/soc/mediatek/mtk-cmdq.h
> > +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> > @@ -26,6 +26,30 @@
> >
> >  struct cmdq_pkt;
> >
> > +enum CMDQ_LOGIC_ENUM {
> Use lower case, and perhaps use `cmdq_logic_type` or `cmdq_operator_type`=
.
I overlooked the CMDQ_CODE_LOGIC line, so cmdq_logic_type makes more sense.

Regards,
Fei
