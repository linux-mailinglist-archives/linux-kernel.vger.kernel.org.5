Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBD07D44EA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjJXBZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJXBY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:24:58 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFA2110;
        Mon, 23 Oct 2023 18:24:55 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b2f5aed39cso2724061b6e.1;
        Mon, 23 Oct 2023 18:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698110695; x=1698715495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qWzdoSbVk/wvciOyV4nXI5Z0JYBfHSRkx33CdJrdgao=;
        b=P9vIaZt7/UEswJwzn2bziumyZJXGMbhOGEH9GzEKwA8wvWGv0hMbNxZ7ijQRp8anGj
         Y7p7SsNPIwhnUBkKIGBTo0YJhKw6aOnhyE598qcJaCHRG/f1oFgaeKQd3+VJMxgbDqtr
         umrBHYi3pV6weKD84qvdZJDfUoxRk0Bm54TzaWphmYgYDgy+enwGibfhgEEdiD7JVACG
         ZTxlucLC08tQYOTFF2/2kjqTYc5MattpFFAvMx6FgMSxx4bjP/gYpXDnVGQ9oSsOTDXz
         k/w0/B37skm5G7szjn9QyF/wk94drC4+Eiok7HUhYl+2HbfBQA1yZr/XuLA9MpCTQts/
         /P5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698110695; x=1698715495;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWzdoSbVk/wvciOyV4nXI5Z0JYBfHSRkx33CdJrdgao=;
        b=udJ01Hom5jCbD0hUdaEi7mXRfxpg19EAlmfOgpEeZtHHSnlAfmV+9e4HjN0c6SsZZz
         TCJ7Z3UzY2sCdkF0uKIPJ2QnKuqkg1FTLW2oDNKzN4g2vQs+mIoOgjz+UkUILFhdGZvc
         awS660Z9y35/L8dvjDekeukcUa2yO1xkRP1KILfdMn5zdNgPLKh1otbijhZzC/wv6iTO
         QNi3Y7susiPk1I6HtAHSn9v23Z9fia0LBEqc26mJKKgVznPGwRoSaLj26DTWykOW+YVj
         Y9mMGYnSGF4kYi5No+h0G0RJ6LEASIgBN+PKuM7z+5h6lo8FnXMt5YlQnoMHsGZOMmPI
         S22w==
X-Gm-Message-State: AOJu0YzAO8gqU6iPOfdhgJP1lYc4kafTqID2G3HDFQVELAulQx+r525J
        z/MBycm0LQzzJ9wjhUXnnauJ5RhjBkM=
X-Google-Smtp-Source: AGHT+IG13oZEvnYdT8MN0PiCZ5lmQG6IbHjQ/2seM0xTgG8O9046qPt/UYDQC3pGUsSpgX8vpZuaqQ==
X-Received: by 2002:a05:6808:138f:b0:3ab:88a0:78f8 with SMTP id c15-20020a056808138f00b003ab88a078f8mr14045322oiw.23.1698110694820;
        Mon, 23 Oct 2023 18:24:54 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79d03000000b006bc3e8f58besm6757110pfp.56.2023.10.23.18.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 18:24:54 -0700 (PDT)
Message-ID: <ced1531b-ba67-4302-8bfa-3003219582e5@gmail.com>
Date:   Mon, 23 Oct 2023 18:24:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/8] r8152: Cancel hw_phy_work if we have an error in
 probe
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>, linux-usb@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20231020210751.3415723-1-dianders@chromium.org>
 <20231020140655.v5.3.I33c8decabd2e77c37524db02b4e6b9b4dbc3a8d6@changeid>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20231020140655.v5.3.I33c8decabd2e77c37524db02b4e6b9b4dbc3a8d6@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/2023 2:06 PM, Douglas Anderson wrote:
> The error handling in rtl8152_probe() is missing a call to cancel the
> hw_phy_work. Add it in to match what's in the cleanup code in
> rtl8152_disconnect().
> 
> Fixes: a028a9e003f2 ("r8152: move the settings of PHY to a work queue")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
