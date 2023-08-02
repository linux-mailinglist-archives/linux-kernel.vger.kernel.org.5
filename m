Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5D076C5AD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjHBGvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjHBGvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:51:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278D52101
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 23:50:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe11652b64so10785083e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 23:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690959036; x=1691563836;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lU+E4yafuV6EQTEck7cJ9TqAerBQYWi6XJ2y5f9cSHc=;
        b=UhFy44WljPZvQFwXudxGUBGSQFCDb0wdcwNvLa6zgHk5EipUsa5MDWRGR53TSAzGbH
         sw3fNT4YARCu0ghblM5gj9UCxrum9SPG5XSaYY3SLs9XQsuEvHrXu2l61H8eqVNKBqm5
         KkOILZEZnUjkAu1iIjPfka77zPToi1C/6XXX/SJAv+yyUCwxOvAAZrcXfkw6bPWrPS6e
         BdeHW8WRnn0HFPzX0GDg3IG3wZzHfB0NqIXiUj7eUOaQbSR2ueFhjqL5aLZ5qCzgJOna
         ztZafc25zawTK3MKkNynhaqUQK+tc6XCMZjmmam9T54Gnbd3My6OZaEw4tW9KHQLZ1cf
         58Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690959036; x=1691563836;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lU+E4yafuV6EQTEck7cJ9TqAerBQYWi6XJ2y5f9cSHc=;
        b=jka7Cy5Ic3cce/d0X72Nt/rtlMohNF3jhIg3ayB1vBN0jyuy/0s17XcaHmWmofqX+V
         sbv07jbh0ZizkD7eL4BotIg5JHV9gZLti3R/AHO/dtiHapquNCqAK40dZc2gfMGTF064
         M0wy3FYfkQcPuN4r+2VAtV2zs8q68+h8CNFfYgDZl0pifEQ2HFHcT+mGYfYun+YIu8Am
         Df+neN48IhSQq+v0aK0v/XmLIto41RRePQgftjkpgqFYBjZdFLKWkIrmV1HxXLV8Nj7D
         g0wg1DPXIyP5g1ZuGZVjIc+KxIYzWyCqeBat7tqueQp2BImAk5db8uruLVqjVQzi/lkL
         NF7A==
X-Gm-Message-State: ABy/qLaTrW46o5tXpqgYGF1v5PowZLW4roOYT0Rjg2o73hiWaabuZzus
        aTP2Lb7/h4nQlDXd3XxOspjbxfl6Zso=
X-Google-Smtp-Source: APBJJlE2SZ4Pne2N8C5vEIlffY6TXsEGavFl8SbuRUWjjGC+kueHZThtNgGn9FTcKR1VAUsbseLsSw==
X-Received: by 2002:ac2:518a:0:b0:4fb:744e:17db with SMTP id u10-20020ac2518a000000b004fb744e17dbmr3554005lfi.1.1690959035493;
        Tue, 01 Aug 2023 23:50:35 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::5? (dc78bmyyyyyyyyyyyyyct-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::5])
        by smtp.gmail.com with ESMTPSA id o12-20020a05651238ac00b004f61187363asm2865653lft.66.2023.08.01.23.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 23:50:35 -0700 (PDT)
Message-ID: <76c7a68f-a448-cda1-ef4f-81a4ddf36dc1@gmail.com>
Date:   Wed, 2 Aug 2023 09:50:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Chen-Yu Tsai <wenst@chromium.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230714081408.274567-1-wenst@chromium.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3] regulator: Use bitfield values for range selectors
In-Reply-To: <20230714081408.274567-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 11:14, Chen-Yu Tsai wrote:
> Right now the regulator helpers expect raw register values for the range
> selectors. This is different from the voltage selectors, which are
> normalized as bitfield values. This leads to a bit of confusion. Also,
> raw values are harder to copy from datasheets or match up with them,
> as datasheets will typically have bitfield values.
> 
> Make the helpers expect bitfield values, and convert existing users. The
> field in regulator_desc is renamed to |linear_range_selectors_bitfield|.
> This is intended to cause drivers added in the same merge window and
> out-of-tree drivers using the incorrect variable and values to break,
> preventing incorrect values being used on actual hardware and potentially
> producing magic smoke.
> 
> Also include bitops.h explicitly for ffs(), and reorder the header include
> statements. While at it, also replace module.h with export.h, since the
> only use is EXPORT_SYMBOL_GPL.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v2:
> - Changed .linear_range_selectors to .linear_range_selectors_bitfield,
>    as suggested by David
> - Dropped Matti's Reviewed-by due to this intrusive change

Sorry for late reply, I assume this is already merged... I was mostly 
offline for a month or so - I can recommend, works wonders ;)

Just wanted to say (and in case this is not yet merged) - still looks 
good to me (helpers and bd718x7 parts).

Yours,
	Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

