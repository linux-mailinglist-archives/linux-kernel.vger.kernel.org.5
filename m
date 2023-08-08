Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25034774724
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjHHTKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbjHHTJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:09:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ADDD928A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:31:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8b2b60731so36825155ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691512259; x=1692117059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ltz12NOpHyjZqCIkd2IaVupLAgjkSMjjrx877B/cAhU=;
        b=jky9poE06iJKjqizaU0sSisRQB0V4bXS/OozcLBLgmBjaCD9ifu+8Fm4IufzYhiT0R
         nPHxHd/P+iBRTKox2nZp64v+4lWnC16KMv7YjzoTI56XOTRem8zJ0B4idUeSyiKx/0tq
         t7uyPeccN8h9CGfobCYrlb9vT7JQKSt/feshHvARVlyO+4Gohtq6flXW9PTpZU0k13LF
         K1p5Q+lAz8DiW49jzTnKt/hWrQ0n6T6T+yjHuZJ2QXQq9wRxmXoInOADgMOtRszeKeaO
         GicAxVWrCxHNlDrTpOklzsS3oFGWDfXPlNkfMt1/IYvaSb//4xz4eF72OGdVxQBiHWDN
         nwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691512259; x=1692117059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltz12NOpHyjZqCIkd2IaVupLAgjkSMjjrx877B/cAhU=;
        b=AqyJmJmkUisS3Q0InG/j0qGm+4urpPCifdvuGHTMz8giOnJHxs1DOQ4lIgVH5Qa4df
         Rs5DFnbV0KA9aA3AE2t4p8zi2EemqtgoA/gsDSQ6DlOKOtoKWz9dgaMMmnZaBVaJwNSs
         6+x5lu6XOPNd/azw5WcqvGvbIlJPeTCqugTtp6uwSCazxL+OylzaSlgr8qomun6WRWcF
         aEed9eA/xYo7BxXiGm0pNo+3oBVAtRsRPtO4iHVHDrxvBweAEg70uxgupyzUjyelmjbM
         Gx4xy4uScciaG2uowcXwnESFrCB68OCAuvsNvK2sMLIu6YHz8aeTIbJ8M35hGnfWfkXo
         ocUw==
X-Gm-Message-State: AOJu0YyBjFHbLYnTSwQJCXLJjCkWj4BITnzHKWRagn/gzIJI78P1EiCV
        jFY6ninELVUTtH3QxPUqz55Zxgo8kzoE5FVs9Ko=
X-Google-Smtp-Source: AGHT+IFsCZuYChk39itTcm/6BoMiS9/hbTzdPl3afaAVttOoLE9K+8dZStY23z3dSbf8ALVaBEkYPA==
X-Received: by 2002:a17:903:41d1:b0:1a9:40d5:b0ae with SMTP id u17-20020a17090341d100b001a940d5b0aemr12365211ple.12.1691480834133;
        Tue, 08 Aug 2023 00:47:14 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id q10-20020a17090311ca00b001bbdd44bbb6sm8235828plh.136.2023.08.08.00.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 00:47:13 -0700 (PDT)
Message-ID: <1add0731-8e3b-438a-88b0-3334d8b35dee@daynix.com>
Date:   Tue, 8 Aug 2023 16:47:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/27] ASoC: amd: acp3x-rt5682-max9836: Map missing jack
 kcontrols
To:     Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
        <nfraprado@collabora.com>
References: <20230802175737.263412-1-alpernebiyasak@gmail.com>
 <20230802175737.263412-5-alpernebiyasak@gmail.com>
Content-Language: en-US
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230802175737.263412-5-alpernebiyasak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/08/03 2:57, Alper Nebi Yasak wrote:
> This driver does not properly map jack pins to kcontrols that PulseAudio
> and PipeWire need to handle jack detection events. The RT5682, RT1015
> and RT1015p codecs used here can detect Headphone and Headset Mic
> connections. Expose the former two to userspace as kcontrols.
> 
> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
