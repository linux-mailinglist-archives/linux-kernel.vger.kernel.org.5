Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FA07A3F07
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 02:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjIRAgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 20:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjIRAfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 20:35:37 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9BD120;
        Sun, 17 Sep 2023 17:35:30 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9338e4695so62975201fa.2;
        Sun, 17 Sep 2023 17:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694997329; x=1695602129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GO29z9RignFFHbu12u74l94xcqtaPR4h8snHrNTAFJk=;
        b=QX5HLmjJD/OoyeUTxmik2NxtQTmwbkUQViAv1tQKbLEkHr1AsEvChApukWZfMOPQoh
         92gNj59ck3+gbvpMcddfLXHnutuTATN3X2jF7iUvdgWrzarl8zJnkvoto9LuDZIXpAy8
         QDe6iVjTYVUe4oMxaUXsG8U8Q8KOYjghuvJa7/IYRq/7LwWIlm5AeMCAPRsZRNN//CmQ
         KEjcQjCWsYcPWn1T6+8slJAEKlEq3+DLQg7bx9OxF9mT79rMzim9bwnzac5Ur9MxfyZS
         c6a8jT6NIfGyKd8wiTt+ZuaM6pBJsJtN2fsGGCKviwPKrtYFr6xu6SMVlEPw47rKBIP/
         Utvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694997329; x=1695602129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GO29z9RignFFHbu12u74l94xcqtaPR4h8snHrNTAFJk=;
        b=XiLgqe34ZKQZ+wABYsua0JPC5amUG/jriROR/N5aS6ZDMpriuX5n+SR5oZs29YBAKO
         5mmbE3aTFEQn5CqJ1/BcrG3PEzB4So6wSiJZShMyhTKTANMgSR/gbp2eZ8GGbOrWu1ZX
         afUyk5ysMRZnoPkdsggRG1NZNq77XHOhEa//NIARuBPfu/zhSmj6Kx7+gQKvz2KFLlA5
         cUs9fAXAoHm1jxVezXdwGPFFru6HQ494HfcPfjT0HiZC708wUbB2IZ8wBpkP5XKzz7V+
         /7haPLgsCWSiXigh3aqe7fLf13uvV2A/bLMHIpMh+LCDPgKooCIN9ojw7gxNIce+SbJh
         tk+Q==
X-Gm-Message-State: AOJu0YyJcw9wZUeSDCiHTc84F8u6XbemVUGRMmZzDgVXvpAuDBwzNcO/
        5hf0lidSdyGIEmj0+IzVm/A=
X-Google-Smtp-Source: AGHT+IHkmIWAA/lVu0Etf2C/gw42g2+fX5kkwfLGMnZ4J9YEoGLPFjeL6R3F/+OLnmA4s3CwzJ7xeA==
X-Received: by 2002:a05:651c:2115:b0:2bf:df8c:4e56 with SMTP id a21-20020a05651c211500b002bfdf8c4e56mr7212908ljq.39.1694997328320;
        Sun, 17 Sep 2023 17:35:28 -0700 (PDT)
Received: from mobilestation ([95.79.219.206])
        by smtp.gmail.com with ESMTPSA id y14-20020a05651c154e00b002bff5d46b4csm844737ljp.16.2023.09.17.17.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 17:35:27 -0700 (PDT)
Date:   Mon, 18 Sep 2023 03:35:25 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rohan G Thomas <rohan.g.thomas@intel.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 0/2] net: stmmac: Tx coe sw fallback
Message-ID: <vvgo2wqc66neeapl64g7io7abjfainjgaqb4v3rvxn7bomkwbt@jdlbs6uzfgvh>
References: <20230916063312.7011-1-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916063312.7011-1-rohan.g.thomas@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 16, 2023 at 02:33:10PM +0800, Rohan G Thomas wrote:
> Hi,
> DW xGMAC IP can be synthesized such that it can support tx checksum
> offloading only for a few initial tx queues. Also as Serge pointed
> out, for the DW QoS IP, tx coe can be individually configured for
> each tx queue. This patchset adds support for tx coe sw fallback for
> those queues that don't support tx coe. Also, add binding for
> snps,coe-unsupported property.

The series looks good to me. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> changelog v7:
> * Updated commit message.
> * Add blank lines around newly added dt binding.
> 
> changelog v6:
> * Reworked patchset to cover DW QoS Ethernet IP also.
> 
> changelog v5:
> * As rightly suggested by Serge, reworked redundant code.
> 
> changelog v4: 
> * Replaced tx_q_coe_lmt with bit flag.
> 
> changelog v3: 
> * Resend with complete email list.
> 
> changelog v2: 
> * Reformed binding description.
> * Minor grammatical corrections in comments and commit messages.
> 
> Rohan G Thomas (2):
>   dt-bindings: net: snps,dwmac: Tx coe unsupported
>   net: stmmac: Tx coe sw fallback
> 
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml |  5 +++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 10 ++++++++++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |  3 +++
>  include/linux/stmmac.h                                |  1 +
>  4 files changed, 19 insertions(+)
> 
> -- 
> 2.25.1
> 
