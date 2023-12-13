Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C6F8112FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379243AbjLMNcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379247AbjLMNcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:32:05 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6583418A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:32:06 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3333b0e0e02so719104f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474325; x=1703079125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ljSerH4CSQISv9rEFxm5KxMF6Q8CS5Sr+WG9qYnPfHuOOJ0v5tmcBVBhDAEqFA4J3h
         vFzG5nKrs1L+A1YnANAI40s+KsLaZRWh8UeeanqjYHu4ginDHiT28Ktfg8PFF9Ah18et
         9Y+dMrhf7m1FgZjE1Sznt5spsaCyD7o9WS6Y7xtF3cvJtgv7ZET2oKL8067S1gUbKVVP
         DxnQH/AthiqDkhJitcsuN4/Y+aRF9jiZAqRrPahjgyJGiyAUJUuNe2wLxT5GkuIGwuHl
         NqqK0oR54246lPapSDo0EPg9+fp10T9vkTSF5pEFk26TYxBNzgl2/JmBOkzO1EBEhG0/
         qYMA==
X-Gm-Message-State: AOJu0Yy/ScfK8kTLtKNUPaw0CT2Od3VggyrtAC9fFENh+ABeH41PFhZN
        JjrmvMolxCGQ5glYCOW7HBc=
X-Google-Smtp-Source: AGHT+IHXsDE9trL/Px/tkEAZE7u67Q9HUWPkNuKGxXOCifeipZqvtHEOmEcoyazz8F1Or/KsHfFJ7g==
X-Received: by 2002:a5d:44ca:0:b0:336:34d8:3da with SMTP id z10-20020a5d44ca000000b0033634d803damr2201839wrr.4.1702474324657;
        Wed, 13 Dec 2023 05:32:04 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k14-20020a5d524e000000b00333479734a7sm13308331wrc.99.2023.12.13.05.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:32:04 -0800 (PST)
Message-ID: <72e633b2-13d8-45c3-a7ea-1075dbb95aa8@grimberg.me>
Date:   Wed, 13 Dec 2023 15:32:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] nvme: rename ns attribute group
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20231208105337.23409-1-dwagner@suse.de>
 <20231208105337.23409-5-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231208105337.23409-5-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
