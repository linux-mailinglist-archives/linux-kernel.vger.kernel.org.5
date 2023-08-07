Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA8B77268A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbjHGNuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjHGNul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:50:41 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A047B92
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:50:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52164adea19so5892348a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691416238; x=1692021038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJvK32hfp7W2IiN/EvVttylVS5EgMni1Y/4T65DWePg=;
        b=L5ZeOA4RaGuzqdd+ADcWzq9s/f1sZ4yf3ThmLa07nCL0zuDUx5mgGPA6nvy47kNdyj
         S+ASwiMDNoWGciC4wW+UaqyQLBhvyiQhSlwp+Ikr6iIKtqp4iC65B7YKOU7mBzPKFQFL
         Awn/67aAFv+VBTrNhXedHHEIY/3ka9vR6MyKCE/nDoNm64E7/1VVxGHPdnGWQZ+Akw6K
         ZJlEOJilxd/sOHVsJ0uDEYOOAtKHhMC4Dx60yd+PJQ+mGgO+GipECtK4d+WJ/8TI9XuU
         j2E/qNXWukiehaVOAAsh+2/R8fIrJEe/ro1EupSBg+nzTbaRbhNh0kaMqjTrrKfvHwKn
         RVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691416238; x=1692021038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJvK32hfp7W2IiN/EvVttylVS5EgMni1Y/4T65DWePg=;
        b=Gj5B4X8S9YRt1SEHflwrjIXCAUtkmzvxOS8++OW7+kXH889G6HTmOUseHTnMpP6G+j
         UpA9z/jesh315W9tKSY4buuAX56x5thCPjvwcnsQRYcENpo67T5pvibYFhvS4FR0T9Ah
         Y2eBr/IfysHE0BvyRwrdcVz/p3jbYwiSJxynSvnBLFCdLXD58rA/vUKB5BZjpg1ZQdZX
         TQffXNxn+n2uvWeKYZdvP7KwhKVWtuDJAaf4ao7Upbt30ayi3xtMpHEi2UtGBBGP3Fqv
         92VUcN6UEuDJx8Q93REB3coH+HYqE2TeabgVPwavw4+Mgrv4NOusqN/S00XQFmze6KOD
         D4LA==
X-Gm-Message-State: AOJu0YybwoziJI03UL3uRm3sQkfPpNUdPeBoh7g5OXd0oEg82+pWrBza
        CQDpTHOFxnnL89dFSC6gAG/iDQ==
X-Google-Smtp-Source: AGHT+IEpZcOZrB1JjhLGm3EtdG7FGURcI374JR8G6zMsbVKzVKzlpVS/LBHaKsa06lDjpvqguJ0d1g==
X-Received: by 2002:aa7:c651:0:b0:522:3ea4:81a9 with SMTP id z17-20020aa7c651000000b005223ea481a9mr7731992edr.34.1691416238152;
        Mon, 07 Aug 2023 06:50:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id i22-20020a50fc16000000b005232e637c24sm2512196edr.84.2023.08.07.06.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 06:50:37 -0700 (PDT)
Message-ID: <9967fa81-f3f4-04c4-a837-d507a19989cc@linaro.org>
Date:   Mon, 7 Aug 2023 15:50:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] tty: serial: samsung: Set missing PM ops for hibernation
 support
Content-Language: en-US
To:     Anton Eliasson <anton.eliasson@axis.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
References: <20230803-samsung_tty_pm_ops-v1-1-1ea7be72194d@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230803-samsung_tty_pm_ops-v1-1-1ea7be72194d@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2023 13:26, Anton Eliasson wrote:
> At least freeze, restore and thaw need to be set in order for the driver
> to support system hibernation. The existing suspend/resume functions can
> be reused since those functions don't touch the device's power state or
> wakeup capability. Use the helper macros SET_SYSTEM_SLEEP_PM_OPS and
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS for symmetry with similar drivers.
> 

Looks sensible, although you should also test the other sleep methods,
e.g. suspend to idle.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

