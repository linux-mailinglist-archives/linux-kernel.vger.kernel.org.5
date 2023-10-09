Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23627BEE89
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378941AbjJIWxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378920AbjJIWxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:53:45 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ACA9D;
        Mon,  9 Oct 2023 15:53:44 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41810cfc569so33189161cf.2;
        Mon, 09 Oct 2023 15:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696892023; x=1697496823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ecHb6IFvKu9pAeTqrU5o2/Zc1by6L4Tl6dEoc4oFd78=;
        b=ZQEjbAvnV2i/xKe9GaBvw8dZTkEj8hUTb+nUQQLiz58/Zl6Q4CK9eWuvWXmyj854Q+
         umW7Lf9Ly73/QLW2s+kfjWLQhpy7Q9h8bR+e0c/6XO6yrH4rZnrgeFqlcxA/sMMRiqky
         4lT7J9pZyQa1pG2SXCxgb95Cxd9kkICssmn0CSL7P5lX7Oesfm7ZkUQZqBCkoyrjWwx9
         uw1MlP6ekvjDsD/1TV7f6HRlD7VGUrn90QbKUocdiQYo+QnpoI2cOvbGEeCOnpPZF7CJ
         Pr5mhMtQpa9rbexPWseKOwkD2igLOGMqRUoJIQVNpPo9kWUd9YCZfxk7PSoa9iWU3dog
         O67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892023; x=1697496823;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecHb6IFvKu9pAeTqrU5o2/Zc1by6L4Tl6dEoc4oFd78=;
        b=Um9dWo0bTt2M+vGMI51FXRCNYUUZOQQyHjqJl7eXURy/ttZkD0ucvmo3l+7iZqg86t
         mJ8iHKZEGvCKbYE6gInceNE0o+ohFf77Ou8aFrT0Jz98tPzjqszbpUcmII6rb1jjtVUk
         YxqUDRXpqHcMSH410i8E9KNE7KCWYw0x3RGa2+iZ7il12m6U0VavDAOj0hkyl8ZYB8uu
         JVmAElp6+pLd5yXOFXxMYiCRTYRAsQ70hIUi7J6MaA1W3+DnYUQGvCpugw6ix/x8FktH
         rvN0R0gTGkHX7U0spVPtRw1wOabmAG+b+vgX127BqInHlI7VoL6JcHn06qHrF10rEzOW
         LctQ==
X-Gm-Message-State: AOJu0Yzx95RamdS21pYo6CzZUo16XPb4o4tG+VZCoK8UPBVSuyCLVYS5
        b4DPbRPlWRIRFC+LGs4Kfck=
X-Google-Smtp-Source: AGHT+IFWWiL+l/kWgDsElVgnI3Jkf5AjwOHD8VXpDZujc0N/KYxENKMV+8dSGiIxsfiTqPoWIVBt0g==
X-Received: by 2002:a05:6214:398a:b0:656:4a21:2c5a with SMTP id ny10-20020a056214398a00b006564a212c5amr17009754qvb.9.1696892022853;
        Mon, 09 Oct 2023 15:53:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id os7-20020a05620a810700b00767e2668536sm3860565qkn.17.2023.10.09.15.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 15:53:42 -0700 (PDT)
Message-ID: <24136e9f-8e36-4dcf-88bb-f9189df40269@gmail.com>
Date:   Mon, 9 Oct 2023 15:53:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: realtek: replace deprecated strncpy with
 ethtool_sprintf
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-v1-1-74e1b5190778@google.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009-strncpy-drivers-net-dsa-realtek-rtl8366-core-c-v1-1-74e1b5190778@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 15:47, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

