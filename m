Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C807DDD35
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 08:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjKAHaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 03:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjKAHaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 03:30:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C938C2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 00:30:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9d224dca585so559512766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 00:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698823806; x=1699428606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CW/G19QSts/AS5IHtohcgFR0rmH2Gai+NgYGEXSnqko=;
        b=V8zda8PbVAENVj1NtjJSxAhEt5RMz+9HrQ3HkPV9kNJTExmeh0TdpAKqe5Y0XIE7V0
         gvIpZq5bt2oin0vXOEx09EYtYT71dxGcxxw6VCjRmqm8jG8f6GmQrNeVH6++BvIvL6zL
         ty1tJtknPD8t1j1y+WyWiTdPBoGCjFggHvKNVNLUDwKuFo3qEdVkSMF7st1If2JMN+BY
         T2T1Ynft9KIIUnDiPXixNbhvVubN0rx73HPRylAQCrpMjW6N2L3wBcWIyuwkuWf7WC8k
         DOq/jAVYnpHp80A7GnUdZn0E6NYaS7NGNnEB/1I+LoT/Xy5wk2ciBpdtnC5rEF9MZyy2
         HUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698823806; x=1699428606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW/G19QSts/AS5IHtohcgFR0rmH2Gai+NgYGEXSnqko=;
        b=emxGaeOCpG+cQ5xLI6wb1A7x78sdBnUVJpEw0/9aQr1Onb5OLXVph0/WmA3YhF508z
         cucqzu0Vguayx4fKRgOvagxxvsBN3jNA5CT1J2KgtkZ+H3O4ls5qXXmuOc3kZayvDWSj
         yz18IThJiINOF7/hYMk+/H4taEsWKyhxaHCmrvhhP7WXI84WRwopqRWctAUkSLCMSdOp
         GItsLW4H7fAfI24z7vPb3mTYgUTBwILVihmKRy/drkVg4eLn4+xdL6C0fNm6LfAFvwQ5
         43l0df9uDbbDVK1gw7fqqkFWGbjJZ5fpou/nangpQkx2y5znKg0gMA87bg2Wf1b99GBx
         ag9A==
X-Gm-Message-State: AOJu0YxNogx67wUd7Pd0KAr90EydWz/LdXwGF8pwIdkQS7IQxKsLiywH
        l2HAIgmuE/inDr3Z1mFlxZEHhg==
X-Google-Smtp-Source: AGHT+IHn5OBLKdIBm9gYlbbPmKG0d7lUTKDYbGWt1aIcMqZvCFT1JsaADE8XNZhwlrSvfLYDhRJBlA==
X-Received: by 2002:a17:907:7f9e:b0:99c:6692:7f76 with SMTP id qk30-20020a1709077f9e00b0099c66927f76mr1413901ejc.16.1698823805746;
        Wed, 01 Nov 2023 00:30:05 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v9-20020a17090606c900b0098f33157e7dsm2044256ejb.82.2023.11.01.00.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 00:30:05 -0700 (PDT)
Date:   Wed, 1 Nov 2023 10:30:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, mario.limonciello@amd.com,
        venkataprasad.potturu@amd.com, arungopal.kondaveeti@amd.com,
        mastan.katragadda@amd.com, juan.martinez@amd.com,
        amadeuszx.slawinski@linux.intel.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] ASoC: amd: acp: fix for i2s mode register field
 update
Message-ID: <8b61e318-7734-4bcf-ae17-59128058e5b7@kadam.mountain>
References: <20231031135949.1064581-1-Syed.SabaKareem@amd.com>
 <20231031135949.1064581-3-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031135949.1064581-3-Syed.SabaKareem@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 07:29:34PM +0530, Syed Saba Kareem wrote:
> I2S mode register field will be set to 1 when tdm mode is enabled.
> Update the I2S mode field based on tdm_mode flag check.
> 
> This will fix below smatch checker warning.
> 
> sound/soc/amd/acp/acp-i2s.c:59 acp_set_i2s_clk()
> 	warn: odd binop '0x0 & 0x2'
> 
> Fixes: 40f74d5f09d7 ("ASoC: amd: acp: refactor acp i2s clock
> 	generation code")

I saw this yesterday but didn't comment because I didn't want you to
have to redo the patch.  Mark, of course, also saw it and didn't ask you
to redo it.  And now it's applied.

But for the future, these Fixes tags should be on one line and in the
tags section of the commit message.  (It's in chronological order).

Fixes: 40f74d5f09d7 ("ASoC: amd: acp: refactor acp i2s clock generation code")
Reported-By: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Signed-off-by: Mark Brown

regards,
dan carpenter

