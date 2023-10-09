Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBDA7BEBAA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377916AbjJIUeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjJIUeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:34:07 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08761B0;
        Mon,  9 Oct 2023 13:34:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-692c70bc440so3740205b3a.3;
        Mon, 09 Oct 2023 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696883645; x=1697488445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2qyhCFIapZAKu/wCnXN+K5MLupOwIsieC6PqwP164A=;
        b=M8KjGQrK/gYOVvpoeo6f7nzgk/IBLVMKKdjWzsIlKhm1mgJSlcEWc7ybiVS2ZXIl51
         uddKRfuUPyoDknZIYWaAOX1yyCa4cKqZCYcyW2zQAj2ZWUrl3eemSTEXJ1+4lkaemKE4
         BE+jIaHWXY248R/dMbxgBTQbgqBuPVqM5X3s8Gi4OCxShvvMeyZKkk11kMd1H68ZNsAm
         r8rMGTpHDni5I4fHFdE0qW45Ez5GMh6txjWtaVzf1hpuIc3WrtBoL3WIJl/a9piRYlzg
         cxtI+AmulcUdgdSqurpasSf54daQHYomJW3jkb2wnQYe6wccvmjoHV1wLOCkHFJx5R8s
         W9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696883645; x=1697488445;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2qyhCFIapZAKu/wCnXN+K5MLupOwIsieC6PqwP164A=;
        b=U2F+kIOJksgnLdUBmVM9zgLy8qzQiQN4WR3Pwy2cH+xmtKiRBqtw8/cmUxAtxEVQ0u
         LPaoD+czLDs3JibWPawLtg5+JGWfT70bfT2kW4ZTY/XjY3v9p6eKeeF8uZWo17l4OEvy
         gidbHPU8SlhWW71EJgeJ7cLtql4RSB/qIcPjAC2JGtzcqM14E38haTUHUTzTICIlLNo1
         BXLLhPicNzx1lZ/U3VssXnYatbV71sEZCQoUiVsAXF12koyNvAka3s/y+YZqijpUUhVR
         is0kHW6qX53IE6uc8pvubcSVLD84LlUQ2+t1EyM/sBfBWUhfruNfWz/KE32LSf98kCji
         53uQ==
X-Gm-Message-State: AOJu0Yzr52AV6WTtJp1T4/pJkAlj3YBtbh3deSnOtij3qu3XyN6Wtl8c
        xN/A8s7XSbr+zBRDkze6v5M=
X-Google-Smtp-Source: AGHT+IFiPy/ssDGzLtsPS3uELgiU2iVVl3nQTF5uG4usgP3xOaS7d1dsgxUu2z1mnKS9QicN+EfMXA==
X-Received: by 2002:a17:90b:38cb:b0:274:729a:bcd9 with SMTP id nn11-20020a17090b38cb00b00274729abcd9mr13946558pjb.43.1696883645359;
        Mon, 09 Oct 2023 13:34:05 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t16-20020a17090ae51000b00267ee71f463sm6776912pjy.0.2023.10.09.13.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 13:34:04 -0700 (PDT)
Message-ID: <a66a8fa4-7ca6-4fdb-a802-d2aa05a1d9eb@gmail.com>
Date:   Mon, 9 Oct 2023 13:34:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: qca8k: replace deprecated strncpy with
 ethtool_sprintf
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20231009-strncpy-drivers-net-dsa-qca-qca8k-common-c-v1-1-34c8040e0f32@google.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009-strncpy-drivers-net-dsa-qca-qca8k-common-c-v1-1-34c8040e0f32@google.com>
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

On 10/9/23 11:34, Justin Stitt wrote:
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

