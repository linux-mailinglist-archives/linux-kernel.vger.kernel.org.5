Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C3A8012FC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379386AbjLASpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjLASpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:45:50 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD0E10F1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:45:55 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1f5d34235dbso401428fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701456354; x=1702061154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXMK7gYwKBc2+MSS7X0vjsoPudj5rbIJ6yvk1AkwxJg=;
        b=WplXVf4upWCCb7CSbt38ErPIoI9Z2UDLLOLNyoBFQnsRyk2Z4bjY5AF0EhPtZv0/U+
         eGgmMbF/9N7qeooIIOi0vixdaXdXVdCt7q1pieel0OM2FiPnXuGvYtP/TgF1oD6gg/va
         Q8i79uo/gXeHA0nYR9KTh1f8xccuABMnxxrLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701456354; x=1702061154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXMK7gYwKBc2+MSS7X0vjsoPudj5rbIJ6yvk1AkwxJg=;
        b=JXDYXb+1ggwN3i8E0zPBjNl7cE3y9k/l62Ca2EX+KpyI/47WDbxP7ub8sQGh6wdZpN
         I5eb3Td49hm2vSbAI0OCiPGwgpb+yCiHqY8x1vbAdbPjnUXRKsRTkdLpxijyXhL1grwb
         +6OY3InURsVWn0yzJ3+GCtjJEbYACZWuTrelJaufePe+OEvTvATcFM0QvtkCo/gaoHvs
         jP0wLD8hzD+nAc4iNNmslbXr9bX0nZWE+YKIXr+i6dJ9PMoYEFclmGdhTY9Kaqv+fR9W
         pzFoXUKTcMYARENng0gfsWadzW6NFDoWYaOaLgLy7yhhZe+M9Vl6Ht5swpyLgdmiFhXB
         OV7Q==
X-Gm-Message-State: AOJu0YzSagvS7NNHiyYEIpQz3j3/Iz1vrLB0BJqVxROjnLxtAqsLYE0V
        jKQmmKepQDCXMlCwW34R0YasA+la/qTpZ767+kgyPg==
X-Google-Smtp-Source: AGHT+IHMHMcYPYJEIHVAEic1PgqT5IKoS7UnELlwPN8I0iVdtmL68Gt5D+mP/xNOZdR+tp4wkE0Og5lhbpj2EQiyud0=
X-Received: by 2002:a05:6870:724f:b0:1fa:2fbe:21f6 with SMTP id
 y15-20020a056870724f00b001fa2fbe21f6mr11207646oaf.12.1701456354652; Fri, 01
 Dec 2023 10:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20231201181542.421077-1-dregan@broadcom.com> <20231201193834.5da80273@collabora.com>
In-Reply-To: <20231201193834.5da80273@collabora.com>
From:   David Regan <dregan@broadcom.com>
Date:   Fri, 1 Dec 2023 10:45:43 -0800
Message-ID: <CAA_RMS7DJEdC_uUcT2MF4crVvPFiDGCpx+wKGYtPP=u3xRuOAQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mtd: rawnand: Add deassert_wp comment
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     dregan <dregan@broadcom.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry my mistake, I had originally missed this comment which came from =
here:
https://github.com/bbrezillon/linux/commit/e612e1f2c69a33ac5f2c91d13669f0f1=
72d58717

On Fri, Dec 1, 2023 at 10:38=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Fri,  1 Dec 2023 10:15:42 -0800
> dregan <dregan@broadcom.com> wrote:
>
> > From: Boris Brezillon <bbrezillon@kernel.org>
>
> I'm pretty sure I shouldn't be the author. The original patch might
> have been partly written by me, but this is a fixup on top of it.
>
> >
> > Add deassert_wp description comment
> >
> > Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
>
> and you should drop my SoB too.
>
> > Signed-off-by: David Regan <dregan@broadcom.com>
> > ---
> >  include/linux/mtd/rawnand.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> > index fcad94aa0515..3049b05d8a20 100644
> > --- a/include/linux/mtd/rawnand.h
> > +++ b/include/linux/mtd/rawnand.h
> > @@ -1001,6 +1001,8 @@ struct nand_op_parser {
> >  /**
> >   * struct nand_operation - NAND operation descriptor
> >   * @cs: the CS line to select for this NAND operation
> > + * @deassert_wp: set to true when the operation requires the WP pin to=
 be
> > + *            de-asserted (ERASE, PROG, ...)
> >   * @instrs: array of instructions to execute
> >   * @ninstrs: length of the @instrs array
> >   *
>
