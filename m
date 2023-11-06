Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F09D7E1CA3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjKFIuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjKFIuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:50:37 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0A8DB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:50:32 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507c78d258fso5441214e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699260631; x=1699865431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IvsRfYdBOBRI+2J2urSL+yk+k1mRSeviqg4tt/tKPu4=;
        b=hO1dO19A4v401DrpNXgLuzSL0P+oB2qcFAqt1L7t9KGJU04IIN5uXcRdXaxpDeko2O
         mP+hBlE1K1UttF9J2OVmx4oKR4Pmz090OmI/9xOMungGXdWRz35vtI98Dp0iD+PCHlyC
         ydBpKYlg2lFfthsSxZVSrolqEmHBnYC0j/YT9mIoa0u6T+xlWHEnGxFa2fUgZ2SxJZgw
         HZq+NcuXuY8z9ZSqVRGEV/ir3PJenUnXKLfCNPabMlqJ/gu87H67aMl51zJJDwIN1Xm0
         5erkkjT8n2idogH8zfCSn0t85Q/Rwrx+xtSxsZZjMr7Mv3rzsFpQZwdS+ulPua/pe384
         m/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699260631; x=1699865431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvsRfYdBOBRI+2J2urSL+yk+k1mRSeviqg4tt/tKPu4=;
        b=pu1r6KlsxJiyjMkIsjXM4f1quhxW2nugUFroz0ROB6Nv3+1vxEI4DBxT55TDbwMX5c
         wEZ2y+ad46ut5h61kocbq8TwntT/h1mlwDrWBWOeLwuD7Y1s4Tm4uy1UZFCtOl6ZDLjY
         ZFWGw/XqdA5TXSvsWbc6s2+eqEmmS2L17faaDwdgUlha9cPCmVWukaYZQAbWtjHohcDc
         9vCfiuOkLVAPSaPJZoTyXvtZTFNW3OgwH9FJtCpAfi8+MkAGAvlR6bctmTxoNLteWCi+
         h3gJJxJZw0dwI06WpRwbwLujHqcYYx3vca/UsT5NlPlrm5QYBqQnCopt3tl5F+wAfUYD
         afww==
X-Gm-Message-State: AOJu0YxwLx8Qg8LuCy8WSIvJoYa7dk5qURAuuhF3Hl/dtaVPV9NJs41t
        ysaIXJ0mVvu3fSlmV7G6+h988A==
X-Google-Smtp-Source: AGHT+IFtG/faO87cJotALJcL+BJ0/q9GgEd4szJRDFIiNksFhPa1PUp3VBl0axOB+aGZEJFN0JWOIQ==
X-Received: by 2002:ac2:5626:0:b0:507:9ff6:75b6 with SMTP id b6-20020ac25626000000b005079ff675b6mr19451969lff.50.1699260630822;
        Mon, 06 Nov 2023 00:50:30 -0800 (PST)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c1d0700b00405bbfd5d16sm11521401wms.7.2023.11.06.00.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 00:50:30 -0800 (PST)
Message-ID: <34b7503e-5d1e-4fd2-a909-d7f50e45c8e6@baylibre.com>
Date:   Mon, 6 Nov 2023 09:50:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] clk: mediatek: mt8188-topckgen: Refactor parents
 for top_dp/edp muxes
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, sboyd@kernel.org
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        wenst@chromium.org, msp@baylibre.com, yangyingliang@huawei.com,
        u.kleine-koenig@pengutronix.de, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20231103102533.69280-1-angelogioacchino.delregno@collabora.com>
 <20231103102533.69280-4-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20231103102533.69280-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/11/2023 11:25, AngeloGioacchino Del Regno wrote:
> The top_dp and top_edp muxes can be both parented to either TVDPLL1
> or TVDPLL2, two identically specced PLLs for the specific purpose of
> giving out pixel clock: this becomes a problem when the MediaTek
> DisplayPort Interface (DPI) driver tries to set the pixel clock rate.
> 
> In the usecase of two simultaneous outputs (using two controllers),
> it was seen that one of the displays would sometimes display garbled
> output (if any at all) and this was because:
>   - top_edp was set to TVDPLL1, outputting X GHz
>   - top_dp was set to TVDPLL2, outputting Y GHz
>     - mtk_dpi calls clk_set_rate(top_edp, Z GHz)
>   - top_dp is switched to TVDPLL1
>   - TVDPLL1 changes its rate, top_edp outputs the wrong rate.
>   - eDP display is garbled
> 
> To solve this issue, remove all TVDPLL1 parents from `top_dp` and
> all TVDPLL2 parents from `top_edp`, plus, necessarily switch both
> clocks to use the new MUX_GATE_CLR_SET_UPD_INDEXED() macro to be
> able to use the right bit index for the new parents list.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
