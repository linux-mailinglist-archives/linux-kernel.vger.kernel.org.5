Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69269754F0F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 16:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGPOrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 10:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGPOrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 10:47:46 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312D51A1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 07:47:45 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso4763682a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 07:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689518863; x=1692110863;
        h=content-transfer-encoding:from:to:content-language:subject:reply-to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHMPfaSl9jKwSiF3RAZuU0OvxFWigdTYjgEMP/YkWwM=;
        b=i6y9CIgqun4QivoDxfNwYSYh1q1nuAvL0wEMYxHrOQGR1gU1bUQBJovswCLiJNDsxZ
         HmZTTa8rmRRApo2T5Ef7GWojcKFoovmptDYmCencYrvsj9mrJjSEpnLvTPasrvq4hUkJ
         COl8Sb+m7HlhuNdVPtoJKFCoGCK0JBFx8OyMWVNidEETQpH/KYeqFwN7ild34THt0oKm
         Sm+mWj9pHKwpbupH5WlUA6zu+BnyNpSzrdWE2+xpHpUu8twF2QXp5eTvrCKRTBBGyJmC
         EsaKhuHBg6bNeRbVGU9Az51zfBKUARBReW2XueOYtLqNCgiRVo85PGK9/xnbRIW0CIua
         mmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689518863; x=1692110863;
        h=content-transfer-encoding:from:to:content-language:subject:reply-to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uHMPfaSl9jKwSiF3RAZuU0OvxFWigdTYjgEMP/YkWwM=;
        b=L86S6kncNssK4rNAXApc1rgfIu1OkwBC5FN0Sk68gwbCokLfRfGIsWLRVWvOjm8+zC
         RRQJJLST2Mzwz+mGAfoWqUAcxrn5qDBEomt+rp48tUa5dplzqgPm+xEgP8Avy8wG3vBI
         6//RULzIVUHQNemRmzI6iOLypuKUvGgAUTbW/HH8Zgd5XhqVhzAvvagGhSQsgj8BZ2OR
         ccu9gHN/twNo5CF+dglGtHhbQWRrI+WWSq7wDU9saoIFA6Cs7Jb8X5/EmLC4fkVBlkgF
         +F5EltvgHNrLE8yme+FNhpiZ2weJNytaV76wAR6iVRIiON+lo/kkVVUxy43Y/8q9sPKK
         F6dw==
X-Gm-Message-State: ABy/qLaUHejG7sNOCddSAEgTdGoUZ2iLo0e8fte6RKfQDAY7+X4d0UZg
        gOAmEC7OHXvNeeco4TS+I67DkxT79U2patSq
X-Google-Smtp-Source: APBJJlHe90niz6zUU0mCo3V42t1NPOO4vtrQOb6T15yJJBP1glI1dlBBj/Pkv4SuBIjGn96ackdMlA==
X-Received: by 2002:aa7:d751:0:b0:51f:e92a:62ba with SMTP id a17-20020aa7d751000000b0051fe92a62bamr8644981eds.9.1689518862880;
        Sun, 16 Jul 2023 07:47:42 -0700 (PDT)
Received: from [10.5.0.2] ([176.97.206.225])
        by smtp.gmail.com with ESMTPSA id dy23-20020a05640231f700b0051e22d3f328sm8426330edb.96.2023.07.16.07.47.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 07:47:42 -0700 (PDT)
Message-ID: <d8e72d86-1dac-cc15-f559-99db89d52749@gmail.com>
Date:   Sun, 16 Jul 2023 17:47:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: yigw@mail.lv
Subject: Re: Proposal to consider
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
From:   GongWang <margtkenn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To Whom It May Concern,

I hope this email finds you well amidst your busy schedule. I wanted to 
reach out to you with a business proposition that I believe might 
capture your interest.

I am confident that we can collaborate on this proposition that can 
yield us great returns. If you are intrigued by this message, I kindly 
request a moment of your time to discuss the details further.

Once you express your interest, I will provide you with comprehensive 
insights and all the necessary information regarding this proposition. I 
assure you that it is an opportunity worth considering.

Please let me know if you consider hearing this offer so that we can 
delve into the specifics and explore the potential of working together.

Thank you for considering my proposal, and I eagerly await your positive 
response.

Best regards,
Gong Wang

