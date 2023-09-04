Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A697916E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239410AbjIDMJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjIDMJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:09:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E35197
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 05:09:36 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52a06f5f556so1815005a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 05:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1693829375; x=1694434175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fe52d7wymHVSRnUd4doTrEpU+qOQW0Adu/PC0B+zMbY=;
        b=YNqXSgqLsJy3i7I6q49MptnBqj9GP7FZ3krzpUaMcLNJlfRW83RT9yDMDAG0gIu97A
         GbPfVh+Q+sgngbCqAzoAVA8ZAzJtbPzb0DwqvoVUlPSonWnczdQ8AU0tw7G9FT7Fsh+3
         /bPrdpQ3z3vtOgqik6sLvxR6azAY9uirg1R1zPyEKzpZEYTVPNIiZZFatLBMSOTT6dz6
         U/Y2u70VtUzMoPUSP2W9KANO9XIGjc4eqFIeM4B41mub8QVr09RC37UUSsslU3fZZhmp
         wDXqBTBybcmIkOBig3k1ElXbRgoLl+/tSnEMqR06Wm/1OifnNWDNWLLDrwae1MYDoQ3q
         p53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693829375; x=1694434175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fe52d7wymHVSRnUd4doTrEpU+qOQW0Adu/PC0B+zMbY=;
        b=Va9K+TWQONzDRJ1eV0H2PEuRf619C8Ky3aPTeAZ0iAvLgspxPMnUjfOJ+04g794I8E
         Za7uVbKFRskIJJUlyNIK5VT7vh5BcccfnowMZ5Eg0KJ+XBCzuBwbg35u3OfgCYF6AlEc
         0hh7jQRu0L/BpcidUXLE7YdPxW/SML6aCqlRcCGZ6F3fv0/mZmCbjbYnk+WYvQHWFwg2
         bMD2Mp/3oidPvYrMukHKHoYD/J1mSdzx6zQUCgl+3qM8ZkRnb31jdRukhxBGXwHsQWE5
         rRtaRFySRWy20UCu+d2D2n6NTEPFnJOhOvIOg9uStTTwFM3ksp/XSM/NNMYFg+of7lPl
         eEag==
X-Gm-Message-State: AOJu0YwJ0FtSst2mZgBZTk/m7rosouQ1v+5ujJcFwemLZ0+XseWuo5rE
        HbAz+LXs6IEe//AuX0nH4m137EmiH1VdyPZQmPc=
X-Google-Smtp-Source: AGHT+IG4htU9jlytfOWTOOiTRhiMXfK1Yx8nBb4GGdVYDdsVmhh1c205BCxily+P8XS3+GVSvF6GUg==
X-Received: by 2002:a05:6402:1f82:b0:52c:b469:bb01 with SMTP id c2-20020a0564021f8200b0052cb469bb01mr3263539edc.38.1693829374607;
        Mon, 04 Sep 2023 05:09:34 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id g9-20020a056402320900b0052e2472f884sm1443153eda.21.2023.09.04.05.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 05:09:34 -0700 (PDT)
Message-ID: <e380a452-ce93-8af2-4075-ef23987d693a@baylibre.com>
Date:   Mon, 4 Sep 2023 14:09:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/mediatek: Add spinlock for setting vblank event in
 atomic_begin
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230822132646.9811-1-jason-jh.lin@mediatek.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230822132646.9811-1-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 22/08/2023 15:26, Jason-JH.Lin wrote:
> Add spinlock protection to avoid race condition on vblank event
> between mtk_drm_crtc_atomic_begin() and mtk_drm_finish_page_flip().

-- 
Regards,
Alexandre
