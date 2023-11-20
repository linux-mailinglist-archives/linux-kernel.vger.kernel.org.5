Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D0F7F18C3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjKTQjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjKTQjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:39:02 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AB5C5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:38:58 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-35b0b36716fso405865ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700498338; x=1701103138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r2RQ820cC686EcqNlIVK+j1vz6wK5IexeuwOn8xmLzg=;
        b=fqt7mxD7sUfZ5ocKo7ZLAZKVDRA4J/wcMUpsGctXC8DPB2YIgk/ugl3tWJ2PTlSx6o
         itmoPiQYA58QwDB7WFE0/t4sApyRKsi9H7EEhKTld+KdrbPtS8xqmQbGdPiLhfZyIdTT
         ul00q2+qTrj6GvNtPsdNS2bwmlAQSZORo2dDAhO2Ncbao0KRxONxOoHuJp3G+3cW/vSH
         llLftf/iVn4eoUEgmPLlNDcVS9tSkT790KtgVsB/Yp3vRvUUxEWCKs90A5D7orNDqn8n
         0oriOVXGeoz1FoaWrnDUp+G1sud7ib5YcILkp7hYHnBJFN4ucM3wVZ2AhX9rmgGLrmrz
         61oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700498338; x=1701103138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2RQ820cC686EcqNlIVK+j1vz6wK5IexeuwOn8xmLzg=;
        b=OL4G+44zln9W9ZEx06P6YRiVUyH9I70v5bCIqeMcfg11D9ljsMv7ejIpCcCTbW97RU
         RJRhMgOjF3vLzWQXQIFbXo6Lhx/NcWsh8G7izA9eiYyyRtqVm2lAJueuaxE1ZzgxvCu2
         VXa9OcXbFdfiMImLiFHQcpWWvONLvWeTXjtyP32GwlmC5IwaBnNVw8LAWsxrSwNKwuuK
         x73qa846LFYqsv2bsPRUH/qb4y18rtNRCIFsf31oI2FP+NH7NsnNuqlbcngP8524cQPM
         ri5g3yTBcKc3fBeQFb6olDPQHldBoGYYyzqyUfGctNsEoSIoXzgNK9oIS9HHeTM7QcWv
         JnWg==
X-Gm-Message-State: AOJu0Yyv+9b6Ned2RLy94Z5dI0w10zom1pSPsmG36FAQIIVCNXZzlEV2
        Z66fj01054GGV/UEeBA+vGQx0w==
X-Google-Smtp-Source: AGHT+IF5Go4liIvNyvGx9ZajPCVJjV0EEZpjieU8RV2xgqmksNAJoh3rLDngxGSoAd4FEaYS8CSyBg==
X-Received: by 2002:a6b:fc0b:0:b0:7b0:7a86:2952 with SMTP id r11-20020a6bfc0b000000b007b07a862952mr7153354ioh.1.1700498337987;
        Mon, 20 Nov 2023 08:38:57 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gt17-20020a0566382dd100b00463f7eb97d8sm2086256jab.69.2023.11.20.08.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 08:38:57 -0800 (PST)
Message-ID: <b7a7627a-da93-47e7-b26d-08f918de10ea@kernel.dk>
Date:   Mon, 20 Nov 2023 09:38:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/fs: consider link->flags when getting path for
 LINKAT
Content-Language: en-US
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel@vger.kernel.org, asml.silence@gmail.com,
        io-uring@vger.kernel.org, stable@vger.kernel.org
References: <20231120105545.1209530-1-cmirabil@redhat.com>
 <8818a183-84a3-4460-a8ca-73a366ae6153@kernel.dk>
 <CABe3_aHtkDm0y2mhKF0BJu5VUcMvzRWSd7sPeyTFCZEFZt05rA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CABe3_aHtkDm0y2mhKF0BJu5VUcMvzRWSd7sPeyTFCZEFZt05rA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/23 9:34 AM, Charles Mirabile wrote:
> On Mon, Nov 20, 2023 at 10:59 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 11/20/23 3:55 AM, Charles Mirabile wrote:
>>> In order for `AT_EMPTY_PATH` to work as expected, the fact
>>> that the user wants that behavior needs to make it to `getname_flags`
>>> or it will return ENOENT.
>>
>> Looks good - do you have a liburing test case for this too?
> Yes, see here https://github.com/axboe/liburing/issues/995 and here
> https://github.com/axboe/liburing/pull/996.

Ah thank you - for some reason github stopped notifying me...

-- 
Jens Axboe


