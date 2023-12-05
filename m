Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3943A804CBE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344826AbjLEIjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjLEIjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:39:19 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EEBFA;
        Tue,  5 Dec 2023 00:39:24 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50be4f03b06so3085644e87.0;
        Tue, 05 Dec 2023 00:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701765562; x=1702370362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ciq8GU7iUi7LUUJHQ/Yglkc7R5BvBXgn5EFW6zsVjow=;
        b=DnuSQie5JcTnWPAfRBzmKWhltOs11rdUAIVFPZsujbN/WzvjesduNffixxgQY70Aci
         6JZHlapKrYTkWuOGeE9TGIc02xTOairl31UYQ49NecCvEYaNadKXiUXA23G5qw70GC+E
         oLYHPGPwx845eGH0B/GGKcoqGHNcg5cwF8KVA8SKnYs+6sn4H9gumJme5wbSYKN34Mga
         l/K+U/Rqqreb89/qRqiea/JWQR4H4iZv7KJ0lt9CRoAsdWxZQAxj9OvDk5icbK88FnPh
         fBUiiLaK23UOFgQRhfHneHLJekFD5TnPguupIuRWP2/BrIdwxU8ZtXipBMDI1JQweb3U
         RlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701765562; x=1702370362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ciq8GU7iUi7LUUJHQ/Yglkc7R5BvBXgn5EFW6zsVjow=;
        b=mBRdrSNWz6k1r2DTRmH28hHylTb30T48pRYBG5tR85Qqr9YzAOQKvoOzmni/4qs4y0
         X1rJE5OBblRWFVv32RwgCWkUjUYbNOvN7g7wHcfGOaFpqcEt/8M1PggDpI+jtppBlnsY
         o5Mllg/zWUFkjupflv/V1eOvV1dEgOlUVQAjGFE9lbr2M22eOGxUzeaEw7vlkhH54dtd
         SAAsq051n9Z7rcaAziUKWUndCBY+wqxbI1o+OosnvWYr1DMsLFmY7MnMSMDI0wqrpPjC
         JXxVsL3Fg7QFJXidTWYaBF/Itip81Lzew/ChF2/4h00k1EBWyd4klBkdZkpj4P/HcA84
         QRng==
X-Gm-Message-State: AOJu0YwHtcRbHREl3y/ElyAe5DleJDeuK+HqY7fs5NABMhZTCt4/dGaT
        HPJqM2xS7M3KbWawKP51xFo=
X-Google-Smtp-Source: AGHT+IEZw3Z3caEX16AO5z2q/9E+FKbTyaJHEQIiD2K1bGuD3XvtPbOJRGPBJ3jhXsTZvLLep2Yw5Q==
X-Received: by 2002:a05:6512:1056:b0:50b:fc06:7a2b with SMTP id c22-20020a056512105600b0050bfc067a2bmr970356lfb.110.1701765562074;
        Tue, 05 Dec 2023 00:39:22 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::2? (dc78bmyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::2])
        by smtp.gmail.com with ESMTPSA id p15-20020a05651238cf00b0050bf40dcb8bsm634947lft.114.2023.12.05.00.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 00:39:21 -0800 (PST)
Message-ID: <644e095d-4c01-4e8d-8036-3c04ada405f2@gmail.com>
Date:   Tue, 5 Dec 2023 10:39:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] fortify: test: Use kunit_device
Content-Language: en-US, en-GB
To:     davidgow@google.com, Rae Moar <rmoar@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
 <20231205-kunit_bus-v1-2-635036d3bc13@google.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20231205-kunit_bus-v1-2-635036d3bc13@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 09:31, davidgow@google.com wrote:
> Using struct root_device to create fake devices for tests is something
> of a hack. The new struct kunit_device is meant for this purpose, so use
> it instead.
> 
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

