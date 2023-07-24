Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C1A75EC08
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjGXGyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjGXGxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:53:54 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E3FE70;
        Sun, 23 Jul 2023 23:53:38 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso5904778e87.3;
        Sun, 23 Jul 2023 23:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690181616; x=1690786416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2MRbPLz8TFpHcgcbByErm3/k9uRtAlDJrHvhV7eK88=;
        b=hoI2EvT8VK9u5bn+VRh1413hW+3XU0i53lEyjQNgrOeQNi91zqul8/lp48ZCM+UTFn
         7+ue9qvyweY0Od8uC2/eh78ZUaqnI8QpX4tbmcHlrOZk176TfzAR0nnDXMRRzqB+U+wN
         4MvyUY9clN3lsh0E9sk9T16F6uctRWs9YBfMQxwEry+LtWHvpGU/3xfdxheJQzALhUpM
         cxSy6Vj5LGKWaeBlft1LznhsMeqBcvi6bjtwMdcDSTw/HX1VmRdBegOIu0pD+TsYwZFw
         yNJ+Oq80x+2qW7qnXO0HIwtxKQ8KsakdMFTlJhsofe6xRs0xrYsiEu+VVtqAgKcTu8+2
         QJ7w==
X-Gm-Message-State: ABy/qLayeKAEVH5+hWmvM87SSS8SYkFQnpw1eadD+imOLaGoTY2Xazb0
        4En9HxQxLBZv8pHk9PEwD8HwzIAeWF4=
X-Google-Smtp-Source: APBJJlHyUL8SddevDRp86zp9skRrtCY7ZxytlhvfUbcIGbAhM4p3M8xaCWlyhsPCCkHzHbWT0iLlng==
X-Received: by 2002:ac2:58db:0:b0:4f8:7513:8cac with SMTP id u27-20020ac258db000000b004f875138cacmr4008530lfo.48.1690181616114;
        Sun, 23 Jul 2023 23:53:36 -0700 (PDT)
Received: from [192.168.1.58] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id m14-20020a7bcb8e000000b003fbc9371193sm9467366wmi.13.2023.07.23.23.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 23:53:35 -0700 (PDT)
Message-ID: <1e4fb878-a7a5-f8cf-a4c7-cc221b02f3c2@kernel.org>
Date:   Mon, 24 Jul 2023 08:53:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] UML: use obj-y to descend into arch/um/*/
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20230721171857.3612639-1-masahiroy@kernel.org>
 <20230721171857.3612639-2-masahiroy@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20230721171857.3612639-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 07. 23, 19:18, Masahiro Yamada wrote:
> The single build rule does not work with the core-y syntax. [1]
> 
> Use the standard obj-y syntax.
> 
> [1]: https://lore.kernel.org/linux-kbuild/d57ba55f-20a3-b836-783d-b49c8a161b6e@kernel.org/T/#m7bc402e1e038f00ebcf2e92ed7fcb8a52fc1ea44
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Tested-by: Jiri Slaby <jirislaby@kernel.org>

thanks,
-- 
js
suse labs

