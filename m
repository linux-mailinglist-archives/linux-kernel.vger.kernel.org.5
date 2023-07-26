Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC1E763BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjGZQEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGZQEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:04:31 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDB219B6;
        Wed, 26 Jul 2023 09:04:30 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-563de62f861so746691a12.1;
        Wed, 26 Jul 2023 09:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690387470; x=1690992270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WemSbbi4nmxYWdvYoU1QjodfrKLGaKVRJYiHpPTC3RM=;
        b=J0uZTtexUewfxyw8NOt1QJaabWMwcKVAmRiNXdw7EIVcafRcbFpmWYJpX070uwkLeK
         Apemi6nazciA4BoUOE5uFffUn0Fe7lTaMygTPnBYt9xtiqF1RtRUPFXHQez2i3proKBG
         eQ1aGXhownS9FM/d67rYQXP89cZx7X9o4Q+/B1B2jvXZwFu6M6NdNvb0VVgOhlcsdB6I
         LRN6wYwinE67cmw7ZY0L7Cx8by++iVSlczDTexCz5jFu9Auc5S5jOTd9Y3xJfng/L/iP
         IBbmKWmGmkUxQTOX/2qecqjkHl4kFnxlyQAAUB3MWXI/Qp08AGcQhvCoe53NZy9cMbGm
         6SFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690387470; x=1690992270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WemSbbi4nmxYWdvYoU1QjodfrKLGaKVRJYiHpPTC3RM=;
        b=KPUs5lQXfEL5HEbGuKcrDNrd0R6xYs2/OS7H+1zwVkhlNRVwB2oZhh2ahXH4WmBm5t
         VbqvbOQFQk1NnALikUfWgHnTVp8dufPGO3o8frMPYQFH2sKO//c+oqBNs1pG3mINgV1V
         vjQfXbMG871GLQWSxLifYmNPYtGJBC7B6cWTnUwcKsOUedmqkbV0Vc3PH+XvCzv+/geR
         eIi8P+JK4XhD+M0iireoXcQIUc2YlSpWRDLcPg+SFBDvqWQGJt4lonTra8wkW/vM6uQs
         /AeRp9kGQZ1eXSdFr4W/fkwrTDHu+IRgKcxwHjpQvZx2stj2UZmDvZYHnIbt4+VEldQa
         JtpA==
X-Gm-Message-State: ABy/qLYXcJnftDvMNzCUkRTBtGTQpUP1Qj3aS9FUTGr2+ysvOawC2MrK
        vnKhnpPHyUcpctsmEgGoqL4yTs6/CeZtQsApOjo=
X-Google-Smtp-Source: APBJJlF3raRu7/V95hjDIqFG7tdPTZZsjE+OlqvOdwQaOS4lGXOjZbMI2nXIx5RVa9d1ARY03sOAeDCNzU7ZCYQjNyM=
X-Received: by 2002:a17:90b:4018:b0:262:f449:4492 with SMTP id
 ie24-20020a17090b401800b00262f4494492mr1928327pjb.30.1690387469576; Wed, 26
 Jul 2023 09:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <ZK9mXE00xEHZV4fi@makrotopia.org>
In-Reply-To: <ZK9mXE00xEHZV4fi@makrotopia.org>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 26 Jul 2023 18:04:18 +0200
Message-ID: <CAOiHx=m5jRYd70ymvX=-9Xh4ZDApJ04G39j9+U0YB18W1QPv7A@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: support per-band MAC addresses from OF child nodes
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 13 Jul 2023 at 04:53, Daniel Golle <daniel@makrotopia.org> wrote:
>
> With dual-band-dual-congruent front-ends which appear as two independent
> radios it is desirable to assign a per-band MAC address from device-tree,
> eg. using nvmem-cells.
> Support specifying MAC-address related properties in band-specific child
> nodes, e.g.
>         mt7915@0,0 {
>                 reg = <0x0000 0 0 0 0>;
>                 #addr-cells = <1>;
>                 #size-cells = <0>;
>
>                 band@0 {
>                         /* 2.4 GHz */
>                         reg = <0>;
>                         nvmem-cells = <&macaddr 2>;
>                         nvmem-cell-names = "mac-address";
>                 };
>
>                 band@1 {
>                         /* 5 GHz */
>                         reg = <1>;
>                         nvmem-cells = <&macaddr 3>;
>                         nvmem-cell-names = "mac-address";
>                 };
>         };
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/net/wireless/mediatek/mt76/eeprom.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/eeprom.c b/drivers/net/wireless/mediatek/mt76/eeprom.c
> index dce851d42e083..90ee138843a55 100644
> --- a/drivers/net/wireless/mediatek/mt76/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/eeprom.c
> @@ -106,7 +106,20 @@ void
>  mt76_eeprom_override(struct mt76_phy *phy)
>  {
>         struct mt76_dev *dev = phy->dev;
> -       struct device_node *np = dev->dev->of_node;
> +       struct device_node *child_np, *np = dev->dev->of_node;
> +       u32 reg;
> +       int ret;
> +
> +       for_each_child_of_node(np, child_np) {
> +               ret = of_property_read_u32(child_np, "reg", &reg);
> +               if (ret)
> +                       continue;
> +
> +               if (reg == phy->band_idx) {
> +                       np = child_np;
> +                       break;

When breaking out of the loop here you still hold an additional
reference to child_np, so you need to call of_node_put() for it,
probably after calling of_get_mac_address().

> +               }
> +       }
>
>         of_get_mac_address(np, phy->macaddr);
>

probably just add a of_node_put(child_np); here, of_node_put() seems
to be NULL safe.


Regards,
Jonas
