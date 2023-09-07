Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18147979D1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbjIGRVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243146AbjIGRVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:21:07 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EA01FCF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:20:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a6190af24aso148883766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694107191; x=1694711991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G88lP2VW9W0ey1BM427zqcg+F+UpGhl5q2J3uTfo6Co=;
        b=diiDLZ1dx0CtonxndSG/PP3Xy8U/h7eMFc4ZqfWx2JzaoRSEP+GaClH+MuYbmoITTr
         Bbtzim4+rywZRV7137MV5Ny+K2TY8wCnmSfma8LLpXekkJq3Gczen5vO6SVxBIuKQU/w
         6vYYysL10252DrngrjsiSZv5OqTXqexKwrNFY6Kl4lwi4Y1hpsqdbqQA56x71FD+9g2n
         +gDvUnSjnQDMO8YOTh+j0ri2e36MveURi/oHU/3aYoABHhcq5/xTVDKTk1+0h/+cyyWu
         kMrZb4+IXJNS3gxClk3N2L7a7oYAiqJgC4BzIF56mERpkUMAnz54vx62SkgIteExlPNx
         oKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694107191; x=1694711991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G88lP2VW9W0ey1BM427zqcg+F+UpGhl5q2J3uTfo6Co=;
        b=L7DV+YttCYuIlwc2JL/yaJg9vPLT3F9BMcn6quZENoZv5CV2t5cxCzoE2N+7VC3oJL
         PJlDCyRACqaj4WQh5tHwwlmPR5FVBzJRa6+UAr/XOEzzdHEHOp/Ld+o5ggFn+e1j9BIX
         M24V/QzwsMSc02ohOqcY16/E80hJtQGi3hQU66EzjcJef90eA1p7X+2HpTmhwVyaLo59
         nVGadRoG8S5NCZycqcgTu7g6QuYM5aGfWKV/a5Zz5igHkT5klLkYW0fDbcdp+VkqTsLp
         r3OdoKmwO/VEJV1+/Ygnd+73bpjXoAQlM9VyCWyXWOZ8UR/mO8pUGZd874GVPvTxQ5/x
         4GxQ==
X-Gm-Message-State: AOJu0Yx8mU86PbHPL/8RXnwHBA6IrTrr//svyc/bWKtfffb/qE4i9Sff
        xcn4Cj+w5oD/VXM06LkgXm2MJjb/Jc5mIjUUXRw=
X-Google-Smtp-Source: AGHT+IHGT591APG6CRNW4zuyJuEfxCr1FfGrojCK5qI1ehGXhuwAoMXIKQPf6+hAJXIGsQZ5/i+wTg==
X-Received: by 2002:a1c:ed08:0:b0:3fe:2b60:b24e with SMTP id l8-20020a1ced08000000b003fe2b60b24emr4801517wmh.29.1694084900263;
        Thu, 07 Sep 2023 04:08:20 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id ay30-20020a5d6f1e000000b0031f65cdd271sm3999677wrb.100.2023.09.07.04.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 04:08:19 -0700 (PDT)
Date:   Thu, 7 Sep 2023 14:08:17 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Sebastian Reichel <sre@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH] power: supply: mt6370: Fix missing error code in
 mt6370_chg_toggle_cfo()
Message-ID: <1092ffb3-0238-4dc0-baf3-344a653fca3f@kadam.mountain>
References: <20230906084815.2827930-1-harshit.m.mogalapalli@oracle.com>
 <cd6eea67-df0f-08b1-61cd-57a3b4f9cf0d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd6eea67-df0f-08b1-61cd-57a3b4f9cf0d@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 12:43:12PM +0200, AngeloGioacchino Del Regno wrote:
> Il 06/09/23 10:48, Harshit Mogalapalli ha scritto:
> > When mt6370_chg_field_get() suceeds, ret is set to zero and returning
> > zero when flash led is still in strobe mode looks incorrect.
> > 
> > Fixes: 233cb8a47d65 ("power: supply: mt6370: Add MediaTek MT6370 charger driver")
> > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > ---
> > This is based on static analysis with smatch, only compile tested.
> > ---
> >   drivers/power/supply/mt6370-charger.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
> > index f27dae5043f5..a9641bd3d8cf 100644
> > --- a/drivers/power/supply/mt6370-charger.c
> > +++ b/drivers/power/supply/mt6370-charger.c
> > @@ -324,7 +324,7 @@ static int mt6370_chg_toggle_cfo(struct mt6370_priv *priv)
> >   	if (fl_strobe) {
> >   		dev_err(priv->dev, "Flash led is still in strobe mode\n");
> > -		return ret;
> > +		return -EINVAL;
> 
> I think that returning 0 here was intentional, but I agree on a return ret
> here being both confusing and wrong.

If it's a success path then probably we should remove the dev_err().

regards,
dan carpenter

