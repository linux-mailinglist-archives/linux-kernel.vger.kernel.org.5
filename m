Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5167B8E04
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243946AbjJDU27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjJDU24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:28:56 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638F993
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 13:28:53 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-79fb8f60374so2714739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 13:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1696451333; x=1697056133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=21cBEUSjF4TZhsDOLZLhdwXsG9t3AJsN/zN+Wwuijrc=;
        b=iNQChHV5T/CHEshLWavEPjwVYgN7joApUKBQw5QjJXJwv2cbQiZzV7JeTrpSQLDtWr
         xotZRQ61F8iIVJZAiIZwQTpi1sM7fG8wPE/jG6cFrCnsyb0irH7eFrB2YyE5Zuhy8ekN
         zI5te5lSEW++ea7So7iMd2bALval9dd1M6SVLIWB+H9V0WKsqagFRkjEd0qGElKnBsoh
         Y62SOQD7DVeAvof9TYGd+hs9i9W6bK9MiWjk7C5/JVVT2nRsxV9Q7me7lPAG7WZGASDy
         7sxTb5IdLovYckPnBxCDY14UE/CoGD+q6jntvXKENwDjffqXU71qhqz6rce7Qtr/d1ew
         98ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696451333; x=1697056133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=21cBEUSjF4TZhsDOLZLhdwXsG9t3AJsN/zN+Wwuijrc=;
        b=Z97f6XnLN38Phx6ZfZQxi0g3aQckmBJCnFBlYUb2C+yddV1opbmHYxFitCDC5X3kiM
         dZRrmxtBFl6XK1i9iFwS9t9NQfUwzxpkUU/mN9BHqifrHoseAfty3fUhW8GYmPOsjA/O
         05l8/fWWSWraybyRxDfAw2j6rcvd009OMpCT0CW1UWGTcWJujqTZqkJFy6iHeSEbUdl2
         zxEZn0MgkrBBOwiLxx3gTqE5mdmZ6oXLI3Ph+5cngbFR9kwCZdU459gkJyEZktnu1ENp
         8TWHCajUgc1s7dph+/ZMwtvyaayqBjAJTnHRt5KEKl5fLlD9OuhMIV4AKkHqvQB2SPOf
         ZqoA==
X-Gm-Message-State: AOJu0YwtadbLXGyQ3uhxK3iQcvvLGNWd5B4j1bUqYAq9kT1Bpb00U/oq
        gXJD5uVrjCyiiShbXnJnWxiBXlzC9nXwn/JQSak=
X-Google-Smtp-Source: AGHT+IGnED8kVpBtGrfQrHoqH87z4y55vamJMb4nxM1//BpBi7Lotw0mZly67kx58aeD6ggT+yLUgg==
X-Received: by 2002:a05:6602:3a05:b0:792:6be4:3dcb with SMTP id by5-20020a0566023a0500b007926be43dcbmr3319534iob.2.1696451332812;
        Wed, 04 Oct 2023 13:28:52 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j29-20020a02cb1d000000b00439fa6ff6a9sm13989jap.70.2023.10.04.13.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 13:28:52 -0700 (PDT)
Message-ID: <43b1a228-9a60-40ef-936b-c8a062d7eb21@kernel.dk>
Date:   Wed, 4 Oct 2023 14:28:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix regression in sed-opal for a saved key.
Content-Language: en-US
To:     Milan Broz <gmazyland@gmail.com>, linux-block@vger.kernel.org
Cc:     gjoyce@linux.vnet.ibm.com, jonathan.derrick@linux.dev,
        linux-kernel@vger.kernel.org, Ondrej Kozina <okozina@redhat.com>
References: <20231003100209.380037-1-gmazyland@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231003100209.380037-1-gmazyland@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 4:02 AM, Milan Broz wrote:
> The commit 3bfeb61256643281ac4be5b8a57e9d9da3db4335
> introduced the use of keyring for sed-opal.
> 
> Unfortunately, there is also a possibility to save
> the Opal key used in opal_lock_unlock().
> 
> This patch switches the order of operation, so the cached
> key is used instead of failure for opal_get_key.
> 
> The problem was found by the cryptsetup Opal test recently
> added to the cryptsetup tree.

Greg, please review this.

-- 
Jens Axboe


