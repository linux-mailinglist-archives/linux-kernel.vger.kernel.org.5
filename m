Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348C87A9F0F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjIUURC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjIUUQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:16:38 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDD4566D1;
        Thu, 21 Sep 2023 10:18:01 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50300cb4776so2218662e87.3;
        Thu, 21 Sep 2023 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316679; x=1695921479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+xyRZs23RX5AHoGJB5gcE16Cz7O3txtIzFcTvtP4PY=;
        b=BNutHcbdM7LVtUslrB8kJGG84lA72dg2y5RTNOpTz4P3pfZzZLIpi21tddcR0e9Z5y
         RENe3xcYzUcq6GJ+jEMR2noPLxCsqzv94GuGdvdbT+vAYNuEFS6/fOfJp85sqhBc+ogV
         GsuA38bb4q9zo1ntUZTf2Ra8mZrPczssu4OOSaqOs5eDPOOWE7kHPEscbLJ0H0iNIZPc
         DgmodCle5RmPVqcaYDUdBSquLWLxE1AS+myCUG8MiJsayaHA153j4/m0qwdYv3PrUT4B
         fDN1qAb+AQXNUQ2iBdzpJkTQp1LQr7LPBDjVcx5o8Mpoqxd5csfsP7rhiU7aDgh7ossG
         GNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316679; x=1695921479;
        h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+xyRZs23RX5AHoGJB5gcE16Cz7O3txtIzFcTvtP4PY=;
        b=CaJAxWfU6O8Vs6St5YlX3h7Ad2TBIDWudhtvE/rT4r/6MGxkEPCxXXWlmliYdFqILU
         HjxlnCEwz+6LvimwWD0aTPYuOmk09ixs2jbyPJDI+TGTgctgCXjCtiJ/ZSp9Y7/sWDhk
         BzgelCXNLJGQIiXq+0NtMV/no+D7l5B0O21dmZAC7DukRUEIuNlQ7DjH8kmjlKlbN0xw
         v0e3mCfrTRUTOETZ1+Lkcz2f35EFmxnHsx+ZBMIsPCukVFUXpudHdw5RSbgiqHk1ICZd
         xggxZ3cQZbqCH9ew8qwpGRwE3YoG1VkUMIvKCCVbB43cxuTkEompzxsRWtWvcdKGZ9hm
         cbTA==
X-Gm-Message-State: AOJu0YxgEg1khF+4OqJ+pNZDMGaQ2IW3Fnndz0JszOarFk9urGPR5AYk
        jZiVjw7V80BOUS2n2dB3zgIzlQKaPfg=
X-Google-Smtp-Source: AGHT+IH6mLuj70FlTaqIhx8/T+0keQ6w7ItVLphi7jndl0Pnvh8yaK/u/QOoZngbKJT0qvIWQsDujg==
X-Received: by 2002:a2e:9cd5:0:b0:2b9:dd5d:5d0c with SMTP id g21-20020a2e9cd5000000b002b9dd5d5d0cmr3929582ljj.52.1695286841257;
        Thu, 21 Sep 2023 02:00:41 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id w7-20020a2e9587000000b002c12ac4f280sm245247ljh.37.2023.09.21.02.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 02:00:40 -0700 (PDT)
Message-ID: <9d929df3-ac51-7d1f-ec00-856849cc70c7@gmail.com>
Date:   Thu, 21 Sep 2023 12:00:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Benjamin Bara <bbara93@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1694760170.git.mazziesaccount@gmail.com>
 <f378a401cec4fb0b9287b52ab159f00dd77569a6.1694760170.git.mazziesaccount@gmail.com>
 <20230917113518.7c4bb1a0@jic23-huawei>
 <a5c19874-32ba-60bf-6e72-9139a2873c7e@gmail.com>
 <c987f401-81c4-00e5-51a7-88a6a38a2ca2@gmail.com>
 <20230919155340.0000076f@Huawei.com>
 <7181e56e-9488-25c9-3d03-64e49b2c952a@gmail.com>
Subject: Re: [PATCH v2 2/3] iio: pressure: Support ROHM BU1390
In-Reply-To: <7181e56e-9488-25c9-3d03-64e49b2c952a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/23 11:17, Matti Vaittinen wrote:

> Another thing to note is that, when we build the available_scan_mask 
> array - we should either pay attention to the order of masks - or change 
> the iio_scan_mask_match() to not accept first matching subset but to go 
> through all of the masks unless it finds and exactly matching one (and 
> in general prefer the smallest subset). Not sure this is worth the extra 
> cycles though.

Replying to myself and to those who I perhaps managed to confuse :)

As a result of above pondering I wrote this:

@@ -411,6 +418,8 @@ static const unsigned long 
*iio_scan_mask_match(const unsigned long *av_masks,
                                                 const unsigned long *mask,
                                                 bool strict)
  {
+       const unsigned long *smallest = NULL;
+
         if (bitmap_empty(mask, masklength))
                 return NULL;
         while (*av_masks) {
@@ -418,12 +427,16 @@ static const unsigned long 
*iio_scan_mask_match(const unsigned long *av_masks,
                         if (bitmap_equal(mask, av_masks, masklength))
                                 return av_masks;
                 } else {
-                       if (bitmap_subset(mask, av_masks, masklength))
-                               return av_masks;
+                       if (bitmap_subset(mask, av_masks, masklength)) {
+                               if (!smallest ||
+                                   bitmap_weight(av_masks, BITS_PER_LONG) <
+                                   bitmap_weight(smallest, BITS_PER_LONG))
+                                       smallest = av_masks;
+                       }
                 }
                 av_masks += BITS_TO_LONGS(masklength);
         }
-       return NULL;
+       return smallest;
  }

but ...
... I see a problem that some of the channels may be more costly to 
access than the other. It could be that reading some of the channels is 
just a matter of getting a cached value, while other could require a 
long measurement time and access to significant amount of registers. So, 
the knowledge of preferred scan masks should indeed be on the driver 
side. Hence, the ordering of the masks in the order of preference makes 
perfect sense. What we could do in the IIO core side is still go through 
all of the available masks to see if we find an exact match. I guess we 
could also document the fact that the order of masks matters.

Thanks for listening - and sorry for the noise :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

