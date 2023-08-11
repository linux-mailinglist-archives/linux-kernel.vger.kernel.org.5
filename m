Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F4E778D24
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbjHKLJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbjHKLJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:09:42 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622503592
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:09:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe501e0b4cso17291665e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691752159; x=1692356959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KX9hqV0zskRK5OaD5DugwhktsOLn+sDNYThqE6fMwQc=;
        b=g6mgQru0bhMZCH1A8HevYnzTiKTOaXTOS7u4uZG61NUaEDA80dYEhY9SDNJoRRX2Nj
         Q354eqZZWpvDvdE+UfhcwAWI3NsgjCJa0YX++RKzte7Ekc4eb83ossEMmJ+4/1MPUf5q
         bucxgvncF5O7ogC8V73p9zCsGlH3oU8h5zX5SuItreyF0x/8z2T2S9GUl/H+so6eoPeV
         vTl1GEocXtOWLr1NlZJsJ93g8ktXxZ0XA1LLC2RXjpUqhEhUdT4dK9pfAVddybqm+vUk
         +kMecwfxIFbBfn0eSFOPAlYoS1bwHHTg+naW+VCrOHB1jxm6SQukaaCrgsmEwYs+vIoO
         G/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691752159; x=1692356959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KX9hqV0zskRK5OaD5DugwhktsOLn+sDNYThqE6fMwQc=;
        b=dGS8lE/0tPTd1rjf+fiMlm3fIiezgb/TrwJpIST5bBNp6H3zAyBP9MzkiJuduKWxcc
         3QksAl7fL6BeHqxN/45LzzJ20m37eq/gBawBi6ae+UjLaaex2wpKW9Xu977ZnyFBYTGA
         EcGbmev/0YXOT7cJDb52zoAU+pY2KTSySR/4be/K6ETpmoZZoUKwNk6a1tUqIUhJMGWZ
         lf9I20xWSj0Tbp4p74UfPlAAVWVIIZJ0G/35DdaleC2f6jl41jQEtQC5AxCPm/lypeJk
         QhHrUUMuiOT/uBXL8L9d8PnXGPeTDjOn3js9svJaAinEpdPY0x7pY8XfJB/84qnlyN+U
         wIzg==
X-Gm-Message-State: AOJu0Yy6GHw9NVkOAtbkJAAsiDJ2Xo4eHL0Y9llioliXTDhRV3bvtQn/
        TgH/XoQsmGKr5mEwyzdQfqvM2A==
X-Google-Smtp-Source: AGHT+IHcNm4hdhkNSFEzx0s9rsAiJpNxzgPz/RG9vyafP/LWZuKwRYte/96gHS7ydYnStSxDYks07g==
X-Received: by 2002:a7b:c453:0:b0:3fc:1bd:95a6 with SMTP id l19-20020a7bc453000000b003fc01bd95a6mr1318137wmi.31.1691752158817;
        Fri, 11 Aug 2023 04:09:18 -0700 (PDT)
Received: from [192.168.3.194] ([89.226.188.33])
        by smtp.gmail.com with ESMTPSA id o11-20020a056000010b00b0031431fb40fasm5082632wrx.89.2023.08.11.04.09.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 04:09:18 -0700 (PDT)
Message-ID: <22fd0d8e-ef10-8ce5-09d1-ff136f594c8c@baylibre.com>
Date:   Fri, 11 Aug 2023 13:09:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] spmi: mtk-pmif: Serialize PMIF status check and
 command submission
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@google.com>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        James Lo <james.lo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230724154739.493724-1-nfraprado@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230724154739.493724-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

On 24/07/2023 17:47, Nícolas F. R. A. Prado wrote:
> Before writing the read or write command to the SPMI arbiter through the
> PMIF interface, the current status of the channel is checked to ensure
> it is idle. However, since the status only changes from idle when the
> command is written, it is possible for two concurrent calls to determine
> that the channel is idle and simultaneously send their commands. At this
> point the PMIF interface hangs, with the status register no longer being
> updated, and thus causing all subsequent operations to time out.
> 
> This was observed on the mt8195-cherry-tomato-r2 machine, particularly
> after commit 46600ab142f8 ("regulator: Set PROBE_PREFER_ASYNCHRONOUS for
> drivers between 5.10 and 5.15") was applied, since then the two MT6315
> devices present on the SPMI bus would probe assynchronously and
> sometimes (during probe or at a later point) read the bus
> simultaneously, breaking the PMIF interface and consequently slowing
> down the whole system.
> 
> To fix the issue at its root cause, introduce locking around the channel
> status check and the command write, so that both become an atomic
> operation, preventing race conditions between two (or more) SPMI bus
> read/write operations. A spinlock is used since this is a fast bus, as
> indicated by the usage of the atomic variant of readl_poll, and
> '.fast_io = true' being used in the mt6315 driver, so spinlocks are
> already used for the regmap access.

-- 
Regards,
Alexandre
