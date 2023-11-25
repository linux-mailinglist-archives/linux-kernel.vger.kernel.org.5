Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 797C27F8CBC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 18:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjKYRYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 12:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjKYRYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 12:24:44 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DBF11F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:24:51 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b83432ca31so1916804b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 09:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700933091; x=1701537891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgCNIjA6kRIohLhrbsEu2soT/m7w6m7hIgikkWVonLQ=;
        b=GCzxoqg2MOT+KvvaKRQWH1/2Kw1F+XA8Xx2o9ymI9EcJT3dgmFKoioC5OA39sUNwpW
         kL0gaNiKf+Fw926/t7WfzILTWPDWj26IytTozCM0wRMicqkLdpYDhfZDBCSjSZ2PXW4e
         iUyCyP4xuTwRo++hRpFfZRngFDjllZ4uZ9zcNbdbiXmOoa3YBvzL+XmB0rwOPkfAzqar
         ua12JIQr2vQfCoefE8qF2nIbpkuMKvjcy/LS2vNySfL3hDS7rohGBbJowRt8j+pPUFBW
         Q+dEFIP88u2EGZ++fSKPjuTgMIGT+RWbnDj9Zt+nPLhrX1PTLWwX1Hwnqg2prYMZaXMd
         2F4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700933091; x=1701537891;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgCNIjA6kRIohLhrbsEu2soT/m7w6m7hIgikkWVonLQ=;
        b=Hh4W4V8LibbxcfiQK44DZWpIehZhGq/718N57QYtQdHuCm0+TqQXPbAx6PHuk6a/zM
         gw/7qXi2TjcLtJnbR/Tq1G6kFYH03g4x97XXWoRU8z4S9d+aa2f/eJx1VcjkVo//zceW
         7yHSuonbvWdKOrA2y+0RRppCBwfjg+moFx9PymLwxW3I9oHpcVlR3ALaoSEp87d3fkmm
         ZNfn9N7V86ZfxudheScG3idNj3lDKKA0lQhnxt8qK/OuncqPv7Brnc/jeqgglC2eDD6T
         urZPbPwzUO85DBTq25m2165Ehyr4K6QtfE/nclZINt6XHoCq+V6BSv6oFR6S73gTWRvh
         MzEQ==
X-Gm-Message-State: AOJu0YxfyIoHPurC/JlWPUsIY/y8ig8TCmfKCS/oSvkPoskP/dXcdnFD
        9sV2G+lPfojS22ejQurQSbM=
X-Google-Smtp-Source: AGHT+IH+vmz0pypM3aVazc0hGfac4233b3yk8LdK5PqmXlTMiA+Cz1SmhAQSseYEOwnikgte+lmrag==
X-Received: by 2002:a05:6808:1790:b0:3a4:8251:5f43 with SMTP id bg16-20020a056808179000b003a482515f43mr9553833oib.40.1700933090730;
        Sat, 25 Nov 2023 09:24:50 -0800 (PST)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id g6-20020aa78746000000b0068be3489b0dsm4721079pfo.172.2023.11.25.09.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Nov 2023 09:24:50 -0800 (PST)
Message-ID: <bad42fa4-679b-408e-99a7-008aead0302f@gmail.com>
Date:   Sat, 25 Nov 2023 09:24:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] mtd: rawnand: Add destructive operation
Content-Language: en-US
To:     dregan@broadcom.com, miquel.raynal@bootlin.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, rafal@milecki.pl,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        dan.beygelman@broadcom.com, william.zhang@broadcom.com,
        frieder.schrempf@kontron.de, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, richard@nod.at, bbrezillon@kernel.org,
        kdasu.kdev@gmail.com, JaimeLiao <jaimeliao.tw@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>
References: <20231125012438.15191-1-dregan@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20231125012438.15191-1-dregan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/2023 5:24 PM, dregan@broadcom.com wrote:
> From: Boris Brezillon <bbrezillon@kernel.org>
> 
> Erase and program operations need the write protect (wp) pin to be
> de-asserted to take effect. Add the concept of destructive
> operation and pass the information to exec_op() so controllers know
> when they should de-assert this pin without having to decode
> the command opcode.
> 
> Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: David Regan <dregan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
