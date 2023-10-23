Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1E77D2CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjJWI1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjJWI1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:27:01 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE11DA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:26:58 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-457c2d81f7fso940942137.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698049617; x=1698654417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClzLCPEn1/RDjIo1E6Nnql8+vBKZIk7KnsLu7dKI+DE=;
        b=Ta9S+tUFbkO1pznQTj1ZPi/uXlbKQloH3SphjUnFguBmJsJrPru0UPt+9VGRw23wsq
         3e6dn3LeLS+VuSV7FTIvqhRGE9W9df1ZOUtqlvyeQZSg1GTh8gQ74U/X+VfsJGIXDLtF
         sksVWVl69ANkr+XwK7EtGglf0ivZIsdd2KokE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049617; x=1698654417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClzLCPEn1/RDjIo1E6Nnql8+vBKZIk7KnsLu7dKI+DE=;
        b=d+W07ZyvOOJ8Vsjf4BPe4rkhZOCBv5S1eNoh5eDJJGJinPeUPulFP80tJxOEl4vCa/
         E5fdNR0YIUDJAnIx/PV/K0yOKupCCohdfNNVJoaI39UMRi+rNuG3iKG0vwEsUlDZxyZB
         9zUg1VjdhsKZ1j2ETCh355EgFBbLNedrRaMUYpW1cY/8tk8fv7KiMcD1cZwy0psoCk3C
         5wfSCs5Zm3jbAgMBsR3j2Zls4AU1vyXedQD9ambEhUb00ABVEfnyHJUkGh4HAOUMUM/N
         UmGMjF9BFbrrvvLokzS1uhjrPJKCceD9TnKRuHWXqWbv4h/xX1kit0H62MwJcClC9A3v
         /elQ==
X-Gm-Message-State: AOJu0YyoJhWfylHtvvhMWTqH7i/Fkg3C/5oCX2S8RYqxBeku4NHeOEGy
        t3hYOl8Lw5ORxb9FFvQpwagL6pRKTM9rPDdBZNo=
X-Google-Smtp-Source: AGHT+IF7alSVFazrO2q/nJA5hXdK3ykwOz0pssxCRwQeGLgLylO0P7FGTDeoC2C4RdUR7FfiN1fpPg==
X-Received: by 2002:a67:c118:0:b0:455:e14e:79f6 with SMTP id d24-20020a67c118000000b00455e14e79f6mr8097673vsj.7.1698049617646;
        Mon, 23 Oct 2023 01:26:57 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id w13-20020a67ffcd000000b00450fc8d2c76sm787107vsq.28.2023.10.23.01.26.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 01:26:56 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7b99b89afdbso8631241.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:26:56 -0700 (PDT)
X-Received: by 2002:a67:ac4c:0:b0:457:cd5d:6ab5 with SMTP id
 n12-20020a67ac4c000000b00457cd5d6ab5mr8578255vsh.23.1698049615911; Mon, 23
 Oct 2023 01:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231023043751.17114-1-jason-jh.lin@mediatek.com> <20231023043751.17114-4-jason-jh.lin@mediatek.com>
In-Reply-To: <20231023043751.17114-4-jason-jh.lin@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Mon, 23 Oct 2023 16:26:19 +0800
X-Gmail-Original-Message-ID: <CAC=S1njjd+-oEgmBeWJGQC0PsbOdJ5eLLw0Mf35HOjA8UHStTw@mail.gmail.com>
Message-ID: <CAC=S1njjd+-oEgmBeWJGQC0PsbOdJ5eLLw0Mf35HOjA8UHStTw@mail.gmail.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Mon, Oct 23, 2023 at 12:39=E2=80=AFPM Jason-JH.Lin <jason-jh.lin@mediate=
k.com> wrote:
>
> Add cmdq_pkt_logic_command to support match operation.
s/match/math/

>
> cmdq_pkt_logic_command can append logic command to the CMDQ packet,
> ask GCE to execute a arithematic calculate instruction,
s/arithematic/arithmetic/

> such as add, subtract, multiply, AND, OR and NOT, etc.
>
> Note that all instructions just accept unsigned calculate.
s/calculate/calculation/

Or I'd rephrase it as:
  Note that all arithmetic instructions are unsigned calculations.

> If there are any overflows, GCE will sent the invalid IRQ to notify
> CMDQ driver.
>
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-cmdq-helper.c | 36 ++++++++++++++++++++++
>  include/linux/soc/mediatek/mtk-cmdq.h  | 41 ++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediate=
k/mtk-cmdq-helper.c
> index b0cd071c4719..5194d66dfc0a 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -13,9 +13,18 @@
>  #define CMDQ_WRITE_ENABLE_MASK BIT(0)
>  #define CMDQ_POLL_ENABLE_MASK  BIT(0)
>  #define CMDQ_EOC_IRQ_EN                BIT(0)
> +#define CMDQ_IMMEDIATE_VALUE   0
>  #define CMDQ_REG_TYPE          1
>  #define CMDQ_JUMP_RELATIVE     1
>
> +#define CMDQ_OPERAND_GET_IDX_VALUE(operand) \
> +       ({ \
> +               struct cmdq_operand *op =3D operand; \
> +               op->reg ? op->idx : op->value; \
> +       })
`((operand)->reg ? (operand)->idx : (operand)->value)` fits in one line.

> +#define CMDQ_OPERAND_TYPE(operand) \
> +       ((operand)->reg ? CMDQ_REG_TYPE : CMDQ_IMMEDIATE_VALUE)
> +
>  struct cmdq_instruction {
>         union {
>                 u32 value;
> @@ -380,6 +389,33 @@ int cmdq_pkt_poll_mask(struct cmdq_pkt *pkt, u8 subs=
ys,
>  }
>  EXPORT_SYMBOL(cmdq_pkt_poll_mask);
>
> +int cmdq_pkt_logic_command(struct cmdq_pkt *pkt, enum CMDQ_LOGIC_ENUM s_=
op,
> +                          u16 result_reg_idx,
> +                          struct cmdq_operand *left_operand,
> +                          struct cmdq_operand *right_operand)
> +{
> +       struct cmdq_instruction inst =3D { {0} };
> +       u32 left_idx_value;
> +       u32 right_idx_value;
> +
> +       if (!left_operand || !right_operand)
> +               return -EINVAL;
> +
> +       left_idx_value =3D CMDQ_OPERAND_GET_IDX_VALUE(left_operand);
> +       right_idx_value =3D CMDQ_OPERAND_GET_IDX_VALUE(right_operand);
> +       inst.op =3D CMDQ_CODE_LOGIC;
> +       inst.dst_t =3D CMDQ_REG_TYPE;
> +       inst.src_t =3D CMDQ_OPERAND_TYPE(left_operand);
> +       inst.arg_c_t =3D CMDQ_OPERAND_TYPE(right_operand);
> +       inst.sop =3D s_op;
> +       inst.arg_c =3D right_idx_value;
> +       inst.src_reg =3D left_idx_value;
> +       inst.reg_dst =3D result_reg_idx;
> +
> +       return cmdq_pkt_append_command(pkt, inst);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_logic_command);
> +
>  int cmdq_pkt_assign(struct cmdq_pkt *pkt, u16 reg_idx, u32 value)
>  {
>         struct cmdq_instruction inst =3D {};
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/me=
diatek/mtk-cmdq.h
> index a253c001c861..ea4fadfb5443 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -26,6 +26,30 @@
>
>  struct cmdq_pkt;
>
> +enum CMDQ_LOGIC_ENUM {
Use lower case, and perhaps use `cmdq_logic_type` or `cmdq_operator_type`.

Regards,
Fei
