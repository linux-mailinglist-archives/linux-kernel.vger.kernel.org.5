Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E57D753166
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjGNFmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjGNFmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:42:02 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132DF211C;
        Thu, 13 Jul 2023 22:41:58 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-98377c5d53eso211224666b.0;
        Thu, 13 Jul 2023 22:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689313316; x=1691905316;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlZFb68wNBynoMUUWnbthgOtvqoVTjliLFFvPyquQvc=;
        b=CFkh7R00Ixw1W5er527PSsd815EGyUiP/63Ymlo9qSSkkF72+EULXet3iTHIdpAOaG
         QQQcbsn4+YMdS1VVJhi1Zn327yYJumPQlONN0xmxO6CF9OCj0nnDKVNczBRUDb6Mb6JB
         ysOImWj+h8dW4CbvV0kufXiGy3j4sOnD9Jg74js8cVBkfU+PyvPHejXq0NG9p5EZyRYh
         FQZM5e3vJN3h8iBRe0zdLytziZsYAdY8PNB++KML47NjA4BrIKmSsSTMZh/qMFBb04af
         SZOyCAUaRwjH80ndwV7dZrBqHtsQyr6lWJN6JQOFu7KtsKur8i/J3Yn3p5KUdU0wFV8A
         piEA==
X-Gm-Message-State: ABy/qLai57EycDEnM9yeMCVzqmGxG9i71UO/phTAMebZkvr0qtZi/YMp
        2vkrsdXpS4XZuXFb2FbBlIST/6NiBME=
X-Google-Smtp-Source: APBJJlGQ0OGERa3wrZmlcwpl3P1BJmz5mDsbfmNWdhgV9dRm3nwGTNOsaO5U1B9SBhMRTeG0zEHICw==
X-Received: by 2002:a17:906:20dd:b0:993:f11a:fe42 with SMTP id c29-20020a17090620dd00b00993f11afe42mr3538831ejc.6.1689313316059;
        Thu, 13 Jul 2023 22:41:56 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id n11-20020a1709061d0b00b00982cfe1fe5dsm4902403ejh.65.2023.07.13.22.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 22:41:55 -0700 (PDT)
Message-ID: <1bc521b4-5425-38bf-9600-a6efe11a2549@kernel.org>
Date:   Fri, 14 Jul 2023 07:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Markus Elfring <Markus.Elfring@web.de>,
        Minjie Du <duminjie@vivo.com>, opensource.kernel@vivo.com,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230713082433.11485-1-duminjie@vivo.com>
 <288c6005-7d0b-3eb0-514d-e2ac09ae6b00@web.de>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v4] wifi: ath5k: remove parameter check in
 ath5k_debug_init_device()
In-Reply-To: <288c6005-7d0b-3eb0-514d-e2ac09ae6b00@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 07. 23, 14:30, Markus Elfring wrote:
> Please apply the subject “[PATCH v5] wifi: ath5k: Remove an error check in ath5k_debug_init_device()”.

FWIW I personally prefer the European style: lowercase after colon. So I 
would not suggest anyone to use one or the other.

-- 
js
suse labs

