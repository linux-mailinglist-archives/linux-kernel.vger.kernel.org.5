Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0DD779D24
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 06:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjHLE5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 00:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHLE5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 00:57:09 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BF11736;
        Fri, 11 Aug 2023 21:57:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe8a158fcbso9260905e9.2;
        Fri, 11 Aug 2023 21:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691816227; x=1692421027;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WgqIkLkub4eHxHReFBW8WNmllVH5KUIYHbD1VTbSRzs=;
        b=Y0b40I548mOCcSdOBW1Y1cDfp1wSd+FO7Zg2yR9slRNRo4nwoS65nefcwDHJw0NxrF
         rXL0AqFkV7NR10HfDAHRh6LKZP9ysnePUOWruOAvT4+vABJafiZtcb63Qs8bZjv53Gvf
         3IlYf8RvWFM2EnEObPiiRSOM5GetjM3fAgkHSidcZGbqtoWMU449ejQLojFxn5jNkqER
         vPUJUQPbsLjBRo2pd4Al5isZ6pq4RHIAOjcdSSBIUkrod3BlodqdK/K82a/BfMydXaYU
         DYxT4Uckqf3oOfNmZZGxy3qJX/EV3PUsIA2NawBJ5jxM+UjoMmlcmwmhInnC0ZbrQPpw
         joew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691816227; x=1692421027;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WgqIkLkub4eHxHReFBW8WNmllVH5KUIYHbD1VTbSRzs=;
        b=jpol0fDs6aRVg3bSY1yA2q7PXjLGKjGzulwm/7pY0mqQ9uzLNylKzreNrbwOYQd3Cz
         GnJ2Vs5iZcLaVB86CNvkXR+GALhPH/WZN1imt0ospSrnmlv7EzGnIggPY5kDuDPIOKaV
         98UBzS5uLCpMbJHSKX7N66Y9xJjRDcCx0KSoiu8Vyg72Vc5vSG8pEgdbU44/R2wk/TPe
         TiWIfYYpaNSNUG1OKZkgZ0Np6eqCv9q1nJOdjpF7RNAqvMcdlxPa8OuHetUlGHFezbOv
         CxJSj7qFiHZXmhDJQbvvYR2sep0gjy5E/07JV+p7vVb90QoRdixYB4YkY4HG3dgJsyhq
         gMmg==
X-Gm-Message-State: AOJu0Yxurcy+iN/EYo9aLsgV534OGescQdULjMb787uBs7Eg+HNtgo8z
        Ioq9CPrmYSxjoybUz1sm2rQrapzMsfluz7oNkbo=
X-Google-Smtp-Source: AGHT+IHsD7B35EAOq9G3nAXsQjp6ojolRnbIUjzlKPOq3wniPNfmeOz40kue9w5Q017etvxgBRsXnw==
X-Received: by 2002:a05:600c:214d:b0:3fc:62c:8275 with SMTP id v13-20020a05600c214d00b003fc062c8275mr3057637wml.35.1691816226548;
        Fri, 11 Aug 2023 21:57:06 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx ([2001:8f8:1163:15aa:d:47bf:868:52f2])
        by smtp.gmail.com with ESMTPSA id m8-20020a7bca48000000b003fa96fe2bd9sm10155580wml.22.2023.08.11.21.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 21:57:06 -0700 (PDT)
Date:   Sat, 12 Aug 2023 08:57:01 +0400
From:   Mahmoud Matook <mahmoudmatook.mm@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>, mickflemm@gmail.com,
        mcgrof@kernel.org, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        mahmoudmatook.mm@gmail.com
Subject: Re: [PATCH] ath5k: fix WARNING opportunity for swap.
Message-ID: <20230812045701.erg57tzebp4nebpo@mmaatuq-HP-Laptop-15-dy2xxx>
Mail-Followup-To: Jiri Slaby <jirislaby@kernel.org>, mickflemm@gmail.com,
        mcgrof@kernel.org, kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20230807201057.340371-1-mahmoudmatook.mm@gmail.com>
 <92a26f67-1b24-ea35-2f39-7c0b75027617@kernel.org>
 <20230808194258.ocxnmqwzqlr6jpe4@mmaatuq-HP-Laptop-15-dy2xxx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808194258.ocxnmqwzqlr6jpe4@mmaatuq-HP-Laptop-15-dy2xxx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 08. 23, 21:42, Mahmoud Matook wrote:
>> On 08/08, Jiri Slaby wrote:
>> 
>>>> On 07. 08. 23, 22:10, Mahmoud Maatuq wrote:
>>>> coccinielle reported the following:
>>>> ./drivers/net/wireless/ath/ath5k/phy.c:1573:25-26: WARNING opportunity for swap()
>>>>
>>>>
>>> OK, once again:
>>> https://lore.kernel.org/all/0c3acbd4-6ab2-5cc5-6293-54e30093cce2@kernel.org/
>> 
>> 
>> I had a look at the commit history, to see why the original developer
>> didn't use sort() function, and name the array variable sort but found
>> nothing.
>> I have some doubts that he might did that intentionally, so not to call
>> sort() function for such small array

> It happens once in 10 s and in a work. No worries about that.

if it's the case so make sense to use sort().
but should I send the modifications on the same thread?
as the subject needs to be changed.
ex: repalce double loop with sort function
    replace bubble sort with heap sort. 

>> and avoid the cost of context switching.

> What context switching?

I used the wrong expression, I meant function call overhead 
e.g store/load registers.

>>>> diff --git a/drivers/net/wireless/ath/ath5k/phy.c b/drivers/net/wireless/ath/ath5k/phy.c
>>>> index 5797ef9c73d7..f87eb684f223 100644
>>>> --- a/drivers/net/wireless/ath/ath5k/phy.c
>>>> +++ b/drivers/net/wireless/ath/ath5k/phy.c
>>>> @@ -1562,16 +1562,13 @@ static s16
>>>>    ath5k_hw_get_median_noise_floor(struct ath5k_hw *ah)
>>>>    {
>>>>    	s16 sort[ATH5K_NF_CAL_HIST_MAX];
>>>> -	s16 tmp;
>>>>    	int i, j;
>>>>    	memcpy(sort, ah->ah_nfcal_hist.nfval, sizeof(sort));
>>>>    	for (i = 0; i < ATH5K_NF_CAL_HIST_MAX - 1; i++) {
>>>>    		for (j = 1; j < ATH5K_NF_CAL_HIST_MAX - i; j++) {
>>>>    			if (sort[j] > sort[j - 1]) {
>>>> -				tmp = sort[j];
>>>> -				sort[j] = sort[j - 1];
>>>> -				sort[j - 1] = tmp;
>>>> +				swap(sort[j], sort[j - 1]);
>>>>    			}
>>>>    		}
>>>>    	}
>>>
>>> -- 
>>> js
>>> suse labs
>
> -- 
> js
> suse labs
