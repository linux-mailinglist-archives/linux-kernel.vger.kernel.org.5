Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBAE7BEBA8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377950AbjJIUdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377916AbjJIUdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:33:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109C1AF;
        Mon,  9 Oct 2023 13:33:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27b13d586beso3961861a91.2;
        Mon, 09 Oct 2023 13:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696883629; x=1697488429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aFyxHrkkSeD43XrBLiZbcCrIw/0ZChIaDY1vJYsvFSs=;
        b=mgwC3RyTiaEhIWyCDk4gIF4vkN6GVGeK+ZypfR9uCf1HLUkwVdjR1WYO7U0esn3CKM
         wSQmEoHrC513FR5XQ+5pzi8RfyWi2AHbc0nSJHZduCV9e+sRVxi2wgpJURgBb1tGeIYM
         vX35QX4MpQ9rOjDqSs9wrAOGw/QbWrYIp6c0PJe2Aq0M8zjTL9+NQiy6TXJj9N6otucz
         9Uxy6ZRrrSSPcP7x0KXlBFAGXfDdDzajQmF9Mo9LC5r1ZC9v+Q7evtvK/BObRs82oKXe
         lNxbrz+J4E0rckLo4pUPsdmAMFHEPPWO0RiLeATAdAE9NAgNrs1YoMtUvwMVmX5euvps
         UY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696883629; x=1697488429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aFyxHrkkSeD43XrBLiZbcCrIw/0ZChIaDY1vJYsvFSs=;
        b=RnA4Ee55aDILbDqtLYDQ1l3Ly6TiaH2zceFWqSdHwnfCNZNiWzvXi4/6yCziaz9s2p
         uilX5elXzbL1OWPaNmbFkjqcmzpq2K52HTMKAHM65uBGR071OPhpU70145mIbWcDkpL9
         eA0qZwALjCpAqADuT1L7jHu2M9rrzMGY/D+C67hz1Lxowj4Dv/53JxlRckij44jkQwE4
         6v2nqvLB6/MnwuQoHWhTdnY86G7EsfrcGSl4oYDFJbQuSND79UzPjj+bTSVeLezstHVe
         FF/425gedO0mEnAiWHzGGfrH8TXldBIz1j3UwujrTiraUlXYt+WhVAiPDPjn8YGo+5/c
         /QOA==
X-Gm-Message-State: AOJu0YzlmaXj/K3GBsoOUSWvGW9J3yCHmtCE0qBjUjUKSDZtPvqA+i3F
        WnKfSzApSwFHcOWPEk0jq/k=
X-Google-Smtp-Source: AGHT+IFRTeO4eu+VGCF5i/kTiFNUsTWv8w7x6VBYI3ei2BuMbJLKXhmRAoJeft+EyzffCzoCmH8pcA==
X-Received: by 2002:a17:90a:74cc:b0:267:ffcf:e9e3 with SMTP id p12-20020a17090a74cc00b00267ffcfe9e3mr15623478pjl.46.1696883629464;
        Mon, 09 Oct 2023 13:33:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t16-20020a17090ae51000b00267ee71f463sm6776912pjy.0.2023.10.09.13.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 13:33:48 -0700 (PDT)
Message-ID: <857037f5-6e15-47db-84db-5396dc70ec2f@gmail.com>
Date:   Mon, 9 Oct 2023 13:33:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: lantiq_gswip: replace deprecated strncpy with
 ethtool_sprintf
Content-Language: en-US
To:     Justin Stitt <justinstitt@google.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20231009-strncpy-drivers-net-dsa-lantiq_gswip-c-v1-1-d55a986a14cc@google.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231009-strncpy-drivers-net-dsa-lantiq_gswip-c-v1-1-d55a986a14cc@google.com>
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

On 10/9/23 11:24, Justin Stitt wrote:
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

