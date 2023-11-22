Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C1E7F4EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343602AbjKVRvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344239AbjKVRvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:51:19 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EB61B5;
        Wed, 22 Nov 2023 09:51:09 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5cd0af4a7d3so295347b3.0;
        Wed, 22 Nov 2023 09:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700675469; x=1701280269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TxnpKs2F+HZNYkXf/Y5BgrPY0hki8e46Z6NdLZXo0Do=;
        b=kcC7JLIjbPuJPYoTwBkF/wGQa0H69rrhifnZGH9X9ZrTez5w9yK9d0oojDaNKxKtqo
         2pYNJAkxNjzXZd44OgQDjvziJib393yIMnLikzz1MGe0Yy8n2XKFy3ipMTv2lR0qGoIH
         /TAzciz47OR9B3ectrenTnCDwHeo3js0OvOBLAjRV71lAEPXABJqHyaTlWlQtoBFTZHt
         7+wa1/CwhAY26aB7mbhkBdjZ6SeazcGVosRxN7CKG+DoUdEESJS4awKQY9GbZDi2QV5d
         xX+6PGHM2Rccf8kCkG00VPxDABOvKQER808NES31tHFbttYOLK4WhF0idp64xaUcdiqw
         MSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700675469; x=1701280269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxnpKs2F+HZNYkXf/Y5BgrPY0hki8e46Z6NdLZXo0Do=;
        b=LMSQJtX03TOgq6cwQkHx8t5B2tCJlMhlwEJkMXPw2Ziy6wsoY1GZhBlEnFBol/OizC
         gqTvKKaJJh5f7qtUFx0f15H2mectsthw0PiWcgEwYwxHoiUya5U75A7xTWvNzEIiwRRw
         3ZpCibVBdBjzP88SHscZl8Ttt5BSYFSof8KM0iFsDCiSn/NclCOcL3BC8vQasRPT9cFE
         hbhmXeHm9beBQfoNqeLcd7gjPDd/I4QhVmirx81DccpBZuu8suZWAxq1+gRzQAs4Zg0U
         IM7QiN5yLlHooq+DuYpTqx9ARLlKbeEtFQmSV4A9daRglltqLA+iIgYtdn55tObCZzLF
         5YwA==
X-Gm-Message-State: AOJu0Yxl5RVN/6UlEpcKN90c5tdzSFDKJ9POF2pQpIakC0oa8Zrp08dU
        ezw6xkfr8/YWNerkq1A+frzgfzPAqvJgkmFy6j4=
X-Google-Smtp-Source: AGHT+IFVH/BFWt02BJRt89HCYBEkZm6l8N7OMZmIj2n4mUUQxZeU4z4Xe9RaA6X/2NVtoKOkfpeHPoOXYUDC9+dm0Xc=
X-Received: by 2002:a81:9404:0:b0:58c:b8b4:2785 with SMTP id
 l4-20020a819404000000b0058cb8b42785mr3671430ywg.45.1700675468737; Wed, 22 Nov
 2023 09:51:08 -0800 (PST)
MIME-Version: 1.0
References: <20231121151733.2015384-1-tmaimon77@gmail.com> <20231121151733.2015384-3-tmaimon77@gmail.com>
 <6aeb28f5-04c2-4723-9da2-d168025c307c@lunn.ch>
In-Reply-To: <6aeb28f5-04c2-4723-9da2-d168025c307c@lunn.ch>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Wed, 22 Nov 2023 19:50:57 +0200
Message-ID: <CAP6Zq1j0kyrg+uxkXH-HYqHz0Z4NwWRUGzprius=BPC9+WfKFQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] net: stmmac: Add NPCM support
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     alexandre.torgue@foss.st.com, tali.perry1@gmail.com,
        edumazet@google.com, krzysztof.kozlowski+dt@linaro.org,
        linux-stm32@st-md-mailman.stormreply.com, benjaminfair@google.com,
        openbmc@lists.ozlabs.org, joabreu@synopsys.com, joel@jms.id.au,
        devicetree@vger.kernel.org, j.neuschaefer@gmx.net,
        robh+dt@kernel.org, peppe.cavallaro@st.com,
        linux-arm-kernel@lists.infradead.org, avifishman70@gmail.com,
        venture@google.com, linux-kernel@vger.kernel.org,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks for your comments

On Tue, 21 Nov 2023 at 18:42, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +void npcm_dwmac_pcs_init(struct npcm_dwmac *dwmac, struct device *dev,
> > +                      struct plat_stmmacenet_data *plat_dat)
> > +{
> > +     u16 val;
> > +
> > +     iowrite16((u16)(SR_MII_CTRL >> 9), dwmac->reg + IND_AC_BA_REG);
> > +     val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);
> > +     val |= PCS_RST;
> > +     iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
> > +
> > +     while (val & PCS_RST)
> > +             val = ioread16(dwmac->reg + PCS_SR_MII_CTRL_REG);
> > +
> > +     val &= ~(PCS_AN_ENABLE);
> > +     iowrite16(val, dwmac->reg + PCS_SR_MII_CTRL_REG);
> > +}
>
> Is this a licensed PCS implementation? Or home grown? If its been
> licensed from somebody, it maybe should live in driver/net/pcs, so
> others can reuse it when they license the same core.
we are using DWC PCS, I don't see support for DWC PCS and I am not
sure it is supposed to be supported at /drivers/net/pcs
I do see a patch set to support DWC PCS but I don't think it answers my needs
https://patchwork.ozlabs.org/project/netdev/patch/1559674736-2190-3-git-send-email-weifeng.voon@intel.com/
>
>        Andrew

Thanks,

Tomer
