Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9AB773E4D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjHHQ3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjHHQ1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:27:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2600111F64
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:50:41 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686b643df5dso4040034b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691509838; x=1692114638;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oqa2rz3uz/mytEi+k5RXx0Vu4GvvDI70ZcmBN+bwj7w=;
        b=AWJavVe5MflgxhhGgYUSGHIaWAKfpyujBmrGvSsNvl1caFUkydBEtCSPbjRM4Stu5P
         jkTw+wCzyr7xXpn2P8p9zVv1dHxeh8tpftyUartM2D9hEQ/KZYCloyT/YLfnGSZexuOs
         Z6LpIav8bQOPY26GfOA/v5Y+nYyOO1xCLchAAWGCBaDNiIqUpCUGbdRse8p9V28ag+rH
         s2K/DMBr3RcKPwlH6c38fc1a4htZ/Hx1PlKzkCAYgx3bxWcTgMeaDEacv9Qib7n7nECw
         noEZ45aQm+dx7dVqY1B178ljqEMG8uhbhw75WofjQasME3vMuolqWN7Cf88C+KsaSCsC
         7NbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509838; x=1692114638;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oqa2rz3uz/mytEi+k5RXx0Vu4GvvDI70ZcmBN+bwj7w=;
        b=SbGjwpVGaMraevi0ET6/lPR8KKrbPTzo6OoDK/F3dJbf8UtNyHyr8xyHrLIKjN/Y2+
         Neos79X9bd26n4ZqT8TmqAAYRRwuQP+z66TSq5iaHsWkYI4GBIKXeuPm2G2wppwhinpt
         jeO5D7uE1SJWf2l95X2AsOliqFuN5NCeqHZcsnYyuG2zTbZmNY1tz64rVshj6VPAid6U
         o9btAmG1QKgXVWcCEq6UZjCjHhlvtDD8ljoUmkj6j7fyRnJHTlRyMWgPbW8ZYt4lzTFK
         6FsnKk3nTbJ4yvTmmSRJlWhn6B/G6Eds+2zgiCGDd9lkQCzcYjyGk0YkNrmJDhw4qSnR
         yMXg==
X-Gm-Message-State: AOJu0YyNgKZqmbquNxTxvznKvqmYn+Bblv7irGDkagdlKY1c2Krlr+qn
        AjttFCguk9sOBkaDnUAIAZtqZAJ8YxH3DUCTm/I=
X-Google-Smtp-Source: AGHT+IFufKLdffur63lJtwd7othy2JUIo3PkP6vkkFnMc+2X7aJvW+HRXR91TsU1UPsl6ar7TJziyA==
X-Received: by 2002:a17:902:d48c:b0:1bc:1df2:4c07 with SMTP id c12-20020a170902d48c00b001bc1df24c07mr12074543plg.63.1691480946230;
        Tue, 08 Aug 2023 00:49:06 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001bba7aab822sm8261067plh.5.2023.08.08.00.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 00:49:06 -0700 (PDT)
Message-ID: <4a0827fd-5e22-4ecb-a451-ec9aa6476649@daynix.com>
Date:   Tue, 8 Aug 2023 16:49:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/27] ASoC: amd: acp3x-rt5682-max9836: Map missing jack
 kcontrols
Content-Language: en-US
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
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
 <1add0731-8e3b-438a-88b0-3334d8b35dee@daynix.com>
In-Reply-To: <1add0731-8e3b-438a-88b0-3334d8b35dee@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/08/08 16:47, Akihiko Odaki wrote:
> On 2023/08/03 2:57, Alper Nebi Yasak wrote:
>> This driver does not properly map jack pins to kcontrols that PulseAudio
>> and PipeWire need to handle jack detection events. The RT5682, RT1015
>> and RT1015p codecs used here can detect Headphone and Headset Mic
>> connections. Expose the former two to userspace as kcontrols.
>>
>> Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> 
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
