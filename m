Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E427757458
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjGRGhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjGRGhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:37:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEA813D;
        Mon, 17 Jul 2023 23:37:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8a8154f9cso33522495ad.1;
        Mon, 17 Jul 2023 23:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689662258; x=1692254258;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Er8WWTcPm9hPiYV9Q5eay4IPujW7i5ClYzsHk5DzEuQ=;
        b=T02EBqEEy3oQVTg8fLLEH6pRN96oQJGN3QOkjvnWoDKLi0a22ovDqJ5Dy5KEYPP2Yj
         Vtt/WLRy0YP0PDnaXOuykJQx7pQXW8twAFxFTQ/1wADMI087E65OHgQ8mYVEDDpF4nk7
         YRmnp1w3s8Ejv6aBgQT3/cNVpf0e1Rg6KKQUOfY+YTcQxUSPmIk5wzHvBiSOl3gC6TZw
         ghmPT45WrAzQnhTuGA5eot6RqlCk4b2lL95tPwwzNECND2pAKkAfsCrN+aZTwulzlWxj
         5/G4ZIm/VLgpiNceTfu76oxPwV4S3eJgih2WBIWSvyY2YyIB4WPw7WBjs7rxArvdBPR9
         PYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689662258; x=1692254258;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Er8WWTcPm9hPiYV9Q5eay4IPujW7i5ClYzsHk5DzEuQ=;
        b=PY0Z9ei+OXysdO9Kwjy/mhuP1hFfT9uuZPCS/wuoanM9gWOfXqcIO6czpCbsI3t2QF
         uJyFhhulAbDH1BBcOn3tiL4m3J+4+D5iipuIiYzDxwa3lcE1XXdWCbnjjH9i6mOVhDzf
         4R4cE3VUAEEr8muX4I66rmKQc4sysP3+NdMcAKyPu0RjA/kbkqf3u5ubKCreeZExaMet
         RZFxn/J+e9OmuK0pwBl0gr3/lyjAf7xb+hKMfzB9AD2rxE4FlZG6EwlUJ8/4YDXznF/7
         xhTNPyDC4DPrsqhbJmwWlllQy/EyRVtVWFuCDoe/6x0QK/vGvO/ittB5Xrw7CCmIb0lZ
         o5FA==
X-Gm-Message-State: ABy/qLbrdivjeWtNKHNW0fKUkeKlTqgGpYBx44yf1zCpG9Dro+ZyehtE
        C+52Ix5hfzIDtr5gn6c3k8YnlDFh9jD6NQ==
X-Google-Smtp-Source: APBJJlH5RQGSDKJYGrh1882Mxn+Nxd1qvw9+VQepeeTY5Bz+Pe5XLvPELg1g64Yj8cn0iHV4a6PfPw==
X-Received: by 2002:a17:902:ea11:b0:1b9:d38d:efb1 with SMTP id s17-20020a170902ea1100b001b9d38defb1mr15532618plg.8.1689662258208;
        Mon, 17 Jul 2023 23:37:38 -0700 (PDT)
Received: from ?IPV6:2601:1c2:980:9ec0::2764? ([2601:1c2:980:9ec0::2764])
        by smtp.gmail.com with ESMTPSA id w4-20020a170902e88400b001b6740207d2sm963190plg.215.2023.07.17.23.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 23:37:37 -0700 (PDT)
Message-ID: <d31387c2-7411-ae98-93d3-418b9d5b87f6@gmail.com>
Date:   Mon, 17 Jul 2023 23:37:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] pwm: fi pwm-rz-mtu3.c build errors
Content-Language: en-US
From:   Randy Dunlap <rd.dunlab@gmail.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <8a4de6c6-8d7c-a115-2a14-d264d6d28ccf@gmail.com>
In-Reply-To: <8a4de6c6-8d7c-a115-2a14-d264d6d28ccf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 22:59, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> 
> Fixes: 254d3a727421 ("pwm: Add Renesas RZ/G2L MTU3a PWM driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Oops, I should resend that with corrected email addresses. Sorry.

-- 
~Randy

