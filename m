Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6C579B9A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345310AbjIKVTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244174AbjIKTaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:30:22 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F4118D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:30:18 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58fc4d319d2so48069107b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ixsystems.com; s=google; t=1694460617; x=1695065417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOzBaZVEt5gQY++7RqjQswx+b33XCIagh1muoGrlAno=;
        b=cLy7dpCcKCTkDIsY3lsxi72OTB55Lk97JUppEvXQ2oBu0dzvRO/MgeGlDMUhBUC6ea
         N7h8RBx0X17+PKj9r7uG0BTTu1XRyQJDcodFOXBC7RM12CUnyRd5SLNaKhJifgA110Y6
         18pUBAlsf1fbkly6EDnh8W1ZTcYjPsUxf9MmH1le+FiCfE8lsld/5acIySyirfLNKWfP
         EnpgXvdYujmiYhbE1Z7Dy3gnZzMCXovnaYCXJFiwL4U/mGFgYKAuhUeX4fj0+YL4PPSD
         Ghkkzgv8dKCwDHLV2OCX2Kq8cDYTYv2R54No+6Rdqgdk/LrQxSltGqxBP+XF1xcwOB8J
         rYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694460617; x=1695065417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOzBaZVEt5gQY++7RqjQswx+b33XCIagh1muoGrlAno=;
        b=Oh1PD11HUlu/UNE9a0Vmd8bgKLVZAt50eoFFUPrVl3Z+dKlOxHslYMsQc/uoUtgWKd
         /N+6dWdSWFJNJBcjlefoudZSQhZvWgqea5TMe0U41VenO0d41eLfHwH+o20wq5biJY2H
         OzE5gA9w+zJ+DTx4hzXpnzZgWf7kd7eX+LTJreiXghLqhjKynZPUXkjOeNZkXT9TOIq2
         1J/judyfcZe9/JT5i1hxcY/yiCn8PDI9nChveHSSLrJ/BD9bzeV5ujsYP/mSE37RHDsQ
         01tAEF6D1AMELSjuYFVkshniY7D3XuiMQ/ByafBw7AjLlVZ91NKXtX0CoG/vFi+NLBpb
         7mCQ==
X-Gm-Message-State: AOJu0YyicWhzafoh2fvXuyek38/A67a3UUSIeDcTO/9oDpliBh4J/93X
        j4TurdJOfhM1pbjTza9i3yFBUg==
X-Google-Smtp-Source: AGHT+IESxrLOaWegF5gTHmBHYw+/IUhEQGmX3/l2Ji8Z3+aAqLldkGtB6pMnrMVyRK3tlfdNewm/Zg==
X-Received: by 2002:a0d:e20e:0:b0:58c:57c1:138a with SMTP id l14-20020a0de20e000000b0058c57c1138amr10944186ywe.19.1694460616784;
        Mon, 11 Sep 2023 12:30:16 -0700 (PDT)
Received: from [10.230.45.5] ([38.32.73.2])
        by smtp.gmail.com with ESMTPSA id m83-20020a0dca56000000b00589e84acafasm2133892ywd.48.2023.09.11.12.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 12:30:16 -0700 (PDT)
Message-ID: <2f1414ab-9152-17ab-d2c6-96f4f5de7d45@ixsystems.com>
Date:   Mon, 11 Sep 2023 15:29:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nvme: prevent id ctrl csi for specs below 2.0
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Ameer Hamza <ahamza@ixsystems.com>
Cc:     linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
        sagi@grimberg.me, linux-kernel@vger.kernel.org,
        edmund.nadolski@ixsystems.com
References: <20230910212641.338438-1-ahamza@ixsystems.com>
 <ZP9fOBSl59u8u0hq@kbusch-mbp.dhcp.thefacebook.com>
From:   Alexander Motin <mav@ixsystems.com>
In-Reply-To: <ZP9fOBSl59u8u0hq@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.09.2023 14:40, Keith Busch wrote:
> On Mon, Sep 11, 2023 at 02:26:41AM +0500, Ameer Hamza wrote:
>> The 'id ctrl csi' command was introduced in version 2.0, as specified
>> in Section 5.17.2.6 of the NVME Base Specification 2.0. Executing this
>> command on previous NVMe versions returns an "Invalid Field" error,
>> and the error entry is saved in the log page. Although, Commit
>> c917dd96fe41 ("nvme: skip optional id ctrl csi if it failed") reduced
>> the error occurrences, but the error persisted during the initial
>> module load. This patch ensures the command isn't executed on versions
>> older than 2.0, and it also eliminates the skip implementation because
>> NVME_ID_CNS_CS_CTRL is expected to succeed with version 2.0.
> 
> NVMe TP's are allowed to be implemented by versions lower than the
> release that first included it. I recall the first nvme controller I'd
> seen that implemented this identification reported itself as 1.4.

Then there must be a way to detect it.  How otherwise it is not a 
standard violation to send arbitrary effectively vendor-specific 
commands to a drive?

-- 
Alexander Motin
