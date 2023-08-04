Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A28C77017D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjHDN2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjHDN2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:28:24 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4C73594
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:28:13 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-583ae4818c8so22584277b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 06:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691155692; x=1691760492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6hpRsVCce4RnHz/Z3fP3W+DwdjM90pnF8UifpN2OMs=;
        b=jUpwYuQoEz66vOhVy3oOAWaV8/FpL+REGsYlvxSLk1iAeAKrc2GzsqFngVng0gTayV
         S0QqBdeRNd1ZDL98kHeqTOrkWIR1QKdmPR2KNOKkKAuA3BhEk6hdm1PygCdpnt66q9zZ
         DUDjjVB0pj/qhIRN/2rrd3pSmfDgWkwISzcsXVP+ImPMXNnptEZTz7kMkuNfsDJlFVKW
         TcJABXWpCMsHjkej0mYrAPwl7D+ZomOlJGHkw/JJDXtVXWn1+SQ88FM/cPQYwAl3dYQ5
         9l13asOzFF99zcMXu612WGb9Yue9+Jv5tlKQA26T8of5sMK9nMkFNDQCKL/sq0EmH3w/
         jZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691155692; x=1691760492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6hpRsVCce4RnHz/Z3fP3W+DwdjM90pnF8UifpN2OMs=;
        b=HTAQJuY4rfu6MyY9DCUEi1sIy2Z2uL2m+nxdtTq9gXEleHj1fUY/H8WVpABGMH/N8k
         IlRWGQp10ptS4OsSy2Arj0RZWiyELqONDNV20tFAwVzh2Pm9SMbF/Hu8QABp4B52KoT9
         cDYXn6xAgYzMDdzuFso9sJErFXVp4VvdGevKh9CHDMyH7a+jdfwTZW/D4BJtQ7uR3tLu
         9tjCVlyIyNZmBJrEBOeFxRcq/2LYJQqBU7CIlHbXABfLjpLdCUh/kgljBi4shnntkR/4
         QtEx8h0instfqb5hNog6TnnfEn2eNjsDCKChCpJh8FIJCoipt8VZcii4VYusQlVWdwoJ
         7UgQ==
X-Gm-Message-State: AOJu0YzBJSu62jbmjjVwzLjwOkOM+35C2Y2miJie6t2TWbXqBKu/N01A
        RhPSNFrtxPA46tMAtAX9ju271mqc9C0=
X-Google-Smtp-Source: AGHT+IGisXvEl+fbn12qhq+M3FWOG3viroz5i3RITcOwWH8GPg1+bnjpB4HUzTiyFOghbvpVyCqn3g==
X-Received: by 2002:a17:902:b611:b0:1b8:35fa:cdb6 with SMTP id b17-20020a170902b61100b001b835facdb6mr1382017pls.13.1691155187486;
        Fri, 04 Aug 2023 06:19:47 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486? ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
        by smtp.gmail.com with ESMTPSA id be5-20020a170902aa0500b001b5247cac3dsm1740067plb.110.2023.08.04.06.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 06:19:47 -0700 (PDT)
Message-ID: <3d6794c9-60d3-b8f3-99d2-afdc69593d9f@gmail.com>
Date:   Fri, 4 Aug 2023 22:19:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/27] ASoC: amd: acp3x-rt5682-max9836: Map missing jack
 kcontrols
Content-Language: en-US
To:     Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
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
 <277be798-9bd0-baa0-9e0d-8a7a9ac67f02@gmail.com>
 <a0ba4144-7763-4d55-8517-f1c44fa4257e@sirena.org.uk>
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <a0ba4144-7763-4d55-8517-f1c44fa4257e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/08/04 22:11, Mark Brown wrote:
> On Fri, Aug 04, 2023 at 05:04:52PM +0900, Akihiko Odaki wrote:
> 
>> Mark Brown has a raised question if the jack is really not driven as a line
>> output[1], but I never answered him (sorry for that!) I don't know if the
>> hardware is capable, but I think we better to remove it for now since the
>> codec driver does not handle it.
> 
>> Mark, does it sound reasonable?
> 
> Sure.

I see. Alper, can you add a patch to remove SND_JACK_LINEOUT to your series?

Regards,
Akihiko Odaki
