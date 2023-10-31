Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870167DCAEA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343640AbjJaKcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbjJaKcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:32:21 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED72EA;
        Tue, 31 Oct 2023 03:32:18 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507ad511315so7960529e87.0;
        Tue, 31 Oct 2023 03:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698748337; x=1699353137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2EcXXb07HwmX+NKag4u1J9dCkLQ+vbQgj8O5yieG1U=;
        b=gn51hoyuM/0EWlEXHzWg6opqUfOEO1rFftHZsLMO+m/34c423tuE5/O25/x9jA95tE
         EAutpPYQiO9j4SRD4JhmoFpi76wGkrFUMrrn13rwEw7gkI89AocPy5wtXNkNeYoLCeHg
         JYeUpCW3rofd/5r4hO0EkSOKiGGkOL8v1KeY/NHV4j728cvzWN2vdI12Y38VHjdacI6W
         PpGRI8vgfsLTFMkHaStJxALqvKAQLDZeZB7JhW9BraTuPaY3t1Ilpy3IMYD+CZtoOykN
         W4xcoD0/8I1HYS88OCFx39nod6GoUbsFTJOMVSHFqa8zLw6Ok2PBnmk8F9ZGfd6ta1M+
         ipBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698748337; x=1699353137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2EcXXb07HwmX+NKag4u1J9dCkLQ+vbQgj8O5yieG1U=;
        b=s3fTQ+XsHDqGwyKifBpoZQqyCSFbxEGoX3YFUqtUdBH0CDW2R2/riuCj010WEG/sNO
         pAJLq9LQevSy3kXHTArrCDXxGpV/uAtw81ttuIOxvH0HcMGy9KnFanc1diakkys4jk/6
         dvxrrUmjSJStWrxr0U/a8xHbmjqeuGjVAxj7m+ApYbczFuSfy184I0vaggkDvRjLQRo2
         5QcUJ9P7+CTR79HpLbclqkXujeSMZYlnlZUaSdgZEsG+QhQIhBW0+nWw3Zm6KnrU1uLL
         WEXx02lFxisW1ri4R5d83hcDhF5/KvdVrG4TM7cZaSM4coEwZygsO3fe4oRFW9QjrDr8
         pyGQ==
X-Gm-Message-State: AOJu0Yxpr8hMw/X8yzczb8PGikGZCVwGezpdf7yIDA36CkdE8taSI8im
        VAGy8F25Vj/kMga0PXTYem8=
X-Google-Smtp-Source: AGHT+IGJwLuxMYrTKC33uhg0n2AffamtWMz+ALnEYm4KltCHV35cdvrMhXSxJwkHCNK7V66cu77AMg==
X-Received: by 2002:a05:6512:312f:b0:507:9ae3:6ba7 with SMTP id p15-20020a056512312f00b005079ae36ba7mr8656903lfd.67.1698748336364;
        Tue, 31 Oct 2023 03:32:16 -0700 (PDT)
Received: from mobilestation (srv1.baikalchip.ru. [87.245.175.227])
        by smtp.gmail.com with ESMTPSA id s12-20020a056512202c00b005056fb1d6fbsm169248lfs.238.2023.10.31.03.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 03:32:15 -0700 (PDT)
Date:   Tue, 31 Oct 2023 13:32:13 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: stmmac: Wait a bit for the reset to take effect
Message-ID: <j37ktiug7vwbb7h7s44zmng5a2bjzbd663p7pfowbehapjv3by@vrxfmapscaln>
References: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 07:01:11AM +0100, Bernd Edlinger wrote:
> otherwise the synopsys_id value may be read out wrong,
> because the GMAC_VERSION register might still be in reset
> state, for at least 1 us after the reset is de-asserted.

From what have you got that delay value?

-Serge(y)

> 
> Add a wait for 10 us before continuing to be on the safe side.
> 
> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 5801f4d50f95..e485f4db3605 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7398,6 +7398,9 @@ int stmmac_dvr_probe(struct device *device,
>  		dev_err(priv->device, "unable to bring out of ahb reset: %pe\n",
>  			ERR_PTR(ret));
>  
> +	/* Wait a bit for the reset to take effect */
> +	udelay(10);
> +
>  	/* Init MAC and get the capabilities */
>  	ret = stmmac_hw_init(priv);
>  	if (ret)
> -- 
> 2.39.2
> 
> 
