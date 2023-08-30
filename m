Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9915678E0DE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240369AbjH3UoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239778AbjH3Uns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:43:48 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB394B02;
        Wed, 30 Aug 2023 13:30:38 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5009969be25so370792e87.3;
        Wed, 30 Aug 2023 13:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693427312; x=1694032112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=397n/hhX7ldkNM9Y4g/lrQyQHJBzzeTmEzA3j0hE8do=;
        b=F8Xq5GFw0AW9egRCSzx1L9km5GMEd+BSV6ByjckQbRn0zJfyFqAL8vr9hqk8rKF1qO
         7TikBOgssqnWMdG4C/31ATicjgsPWChBkbSZ3uLUwRJjlJbs5KjtRhNO0QVpMAMlsV8y
         6EU63JH3C6q4qAeWc8DvKcRwAx2FUYbQRVhzMIXTL4b8UIG0JaXXfr08X9e3OqPM/P0D
         0fwAMUP3uiPxPl19rJrLc5xhW79zLNifCvHKDRcSN+Xb8LIAZx5GKqYKyxlCaFpDUa5M
         w0ioIvrVdvJVcbtaW1gmJFvj33xB0nqI21I9LVaY3Okc+jPEIJP4ERNSjgUwmNWmjgag
         RFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427312; x=1694032112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=397n/hhX7ldkNM9Y4g/lrQyQHJBzzeTmEzA3j0hE8do=;
        b=YnYAIfWqgk9POP9UV6dRcEvsA2HHzZrgo/LU4bFaLGsgY+fLN6/0izGRFbwuqyW5yp
         aDW9OsLK5RkvZvVq4GBFOqXzayloxf3wQah5DAiZ6UX8IAR0waWRgRfs08Sp2HKTyISU
         9zH/RBt3nDhejxF8Da4P+g4s4MTYG2LTg9PMEIn1G4Sbi2R5DY5yy5zal73FvYCNKVV0
         3gjGTZDvGA63aTB4E2ryjlnRuC0af3jY9Q9roXA7FFh1ZhoWnVILwQ/ifr59j5HLdMXL
         vY5JkY9vDVc5sTlT9kR3CF7P2oQEeZp0xng2RV27/FM34n63zKlJLtzmB/uQtsX+dST5
         eeZg==
X-Gm-Message-State: AOJu0YxIwAUzDsVfns2hzya8RQVx8fNqyhVt6Oi84miL6p64hCvgGtAw
        tqVQOs/RVvti+twkDMLp/36S0YQSlMsRPg==
X-Google-Smtp-Source: AGHT+IHC/2syP0VeZ5QvyGqbFKlp/a7pebLfyu7vqzZEstf6u8fCT1Lton/EOC87UIWzLJeVKnY3fg==
X-Received: by 2002:aa7:d4c4:0:b0:523:f91:fcce with SMTP id t4-20020aa7d4c4000000b005230f91fccemr2579437edr.13.1693425077244;
        Wed, 30 Aug 2023 12:51:17 -0700 (PDT)
Received: from shift (p200300d5ff1db100aaa159fffeeb01f1.dip0.t-ipconnect.de. [2003:d5:ff1d:b100:aaa1:59ff:feeb:1f1])
        by smtp.gmail.com with ESMTPSA id b4-20020aa7dc04000000b005256ae8494asm7075695edu.17.2023.08.30.12.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:51:16 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1])
        by shift with esmtp (Exim 4.96)
        (envelope-from <chunkeey@gmail.com>)
        id 1qbRDf-000ZGY-2v;
        Wed, 30 Aug 2023 21:51:15 +0200
Message-ID: <1774098a-5062-4f12-a760-f16036d095e3@gmail.com>
Date:   Wed, 30 Aug 2023 21:51:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mac80211: Use flexible array in struct
 ieee80211_tim_ie
To:     Jeff Johnson <quic_jjohnson@quicinc.com>, kernel@quicinc.com,
        Kalle Valo <kvalo@kernel.org>,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20230829-ieee80211_tim_ie-v2-0-fdaf19fb1c0e@quicinc.com>
 <20230829-ieee80211_tim_ie-v2-2-fdaf19fb1c0e@quicinc.com>
Content-Language: de-DE
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20230829-ieee80211_tim_ie-v2-2-fdaf19fb1c0e@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/29/23 15:29, Jeff Johnson wrote:
> Currently struct ieee80211_tim_ie defines:
> 	u8 virtual_map[1];
> 
> Per the guidance in [1] change this to be a flexible array.
> 
> As a result of this change, adjust all related struct size tests to
> account for the fact that the sizeof(struct ieee80211_tim_ie) now
> accounts for the minimum size of the virtual_map.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> index bd2f6e19c357..4cdc2eb98f16 100644
> --- a/include/linux/ieee80211.h
> +++ b/include/linux/ieee80211.h
> @@ -961,7 +961,7 @@ struct ieee80211_tim_ie {
>   	u8 dtim_period;
>   	u8 bitmap_ctrl;
>   	/* variable size: 1 - 251 bytes */
> -	u8 virtual_map[1];
> +	u8 virtual_map[];
>   } __packed;


Uhh, the 802.11 (my 2012 Version has this in) spec in
8.4.2.7 TIM Element demands this to be 1 - 251 bytes.
And this is why there's a comment above... With your
change this could be confusing. Would it be possible
to fix that somehow? Like in a anonymous union/group
with a flexible array and a u8?

Cheers,
Christian
