Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4B77F92CD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 14:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjKZM4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 07:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZM4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 07:56:37 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58BEE5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 04:56:43 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-332e11a977bso799628f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 04:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701003402; x=1701608202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=SWPFXDlFlzrts5eVqWnyjZp9lYVbF76um7CIGx8U4OmRfaIV4UQJ5ZkOWYASIibmHt
         kaw+SBYdHjrp8cwbo4bgEDZLxTUJRGHnEd9tB8vMCenUT4zCc/uLBGj52iq8N9GlwDDt
         S+Cwc/NTSBMJ9Zdb8O6ppBaKEGQVQRdPFpL9Q6ezFeyZYSmEST1BthbhY7Y91zwyIobs
         6hUGtCqBX8dQ6mhJ0QtU2yJ+hg+0pD9Bh0NjiUSzsAD865i2zrT0cpnzR7iWYld8zF8G
         IFCVPImbHtePDSOyqCblbMuXmTqRj7/kywF1GJ2w1qL54rI7OflxIo2K9y0HImoFPsIH
         LQBQ==
X-Gm-Message-State: AOJu0Yzm1DW6MHHlrjPEC9+eaJa2/mX4EEMtd1OYqdaOwssaBV0SuyB7
        eLxsTTzCUh8v9+gn0IIrXDU=
X-Google-Smtp-Source: AGHT+IFJh6+wqE2Mg47iY97XAH0U5KdN6S53/rpdsveQmSlaOVdUGVpRiHPNitAglT2NybGCAT4G4w==
X-Received: by 2002:adf:fd4e:0:b0:332:fbce:89e6 with SMTP id h14-20020adffd4e000000b00332fbce89e6mr1076275wrs.7.1701003402108;
        Sun, 26 Nov 2023 04:56:42 -0800 (PST)
Received: from [10.100.102.14] (46-117-95-192.bb.netvision.net.il. [46.117.95.192])
        by smtp.gmail.com with ESMTPSA id s15-20020adf978f000000b00332d41f0798sm9294435wrb.29.2023.11.26.04.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 04:56:41 -0800 (PST)
Message-ID: <5a4573ae-0ede-41ad-a382-5a5a454fe9ea@grimberg.me>
Date:   Sun, 26 Nov 2023 14:56:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] nvme: fine-tune sending of first keep-alive
Content-Language: en-US
To:     Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
        kbusch@kernel.org, hare@suse.de
References: <20231124205659.523248-1-shiftee@posteo.net>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231124205659.523248-1-shiftee@posteo.net>
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
