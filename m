Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2D17BA950
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjJESmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjJESmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:42:04 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1878CAD;
        Thu,  5 Oct 2023 11:42:01 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-352a1a0348fso5325585ab.1;
        Thu, 05 Oct 2023 11:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696531320; x=1697136120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C38Q1C9r7lwS5fW7UNhnL/vCgr/OGwg6SzySJrMoliQ=;
        b=k7VnANBmadqwur+QcdDRV4m2Twrlu1VMrFTDWDSrlCAus7VrjdhfQi1CRt1BPLguZZ
         G0ktkDIIMOEk7/UcVXlZmk6M4wVFpeL2x2h+Krhwmd+wd7oBiHg3Nn2XBpKUaqt3N1/b
         AzVvduEEV9gaR/lVUsrsyKIp/IiwkqDR3w7swXGlbKVleEo2t02tWaQ/Z1eL8BaM7pMM
         k+Mm2uJnW4ees2NQhhyScmcokveR0za6zYmUKpJujifyr5YPBiIdqDk5nxlMV4yWp9Hu
         YtMdBN8Aj1WC6EZlBb3zgXwLzP8teU5wlKBKaRG0i22i8EYtb7+o7vcF5QQ4QKeVdLaf
         yMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696531320; x=1697136120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C38Q1C9r7lwS5fW7UNhnL/vCgr/OGwg6SzySJrMoliQ=;
        b=ssHDSsyEkCcVLli0kpj13J6WBKQVLtn4wnnVldbY5+MCByk3TfhEICc9JCC60gUgzi
         zA9yH+NA4SSL79NrVMYeu9P/4QuusToVdQS4ZvYZw1F8KWeJgN6lLp2UGsuQBn+MTdIK
         g6rHiXg/8vmwYYy4fIU2xUQqqUkNtrk1BXnmpmUmgsDeiDd4grkRSuTMdz4IpfZh5T4q
         +mY63EVIJBCaUQip6XNdSiFt45mDTZsHR0zkhd8G1u6Q/m73AHrBbpSqUPTvPVYfHWzr
         BrC95opCRepxlwx0UikSiSSqtr4gOuJifWMts8t1hCc5i3S2l4LQP1288TzxMHFvvdNz
         e5sA==
X-Gm-Message-State: AOJu0YwdYnM0iD2p+mOmocw37TXCa3wYauWPjII2+TMUQZsevhW2m6x2
        sEovGeHRyTmSoEFSnT+25aU=
X-Google-Smtp-Source: AGHT+IH/MiC5uTZ2tc7c7WqzhaItMMseY+YztPQrfyluZFiivc3EvIyxz9Vgf3PzyA0zY0+JYrUNZw==
X-Received: by 2002:a92:c54d:0:b0:352:8b80:4744 with SMTP id a13-20020a92c54d000000b003528b804744mr6937010ilj.4.1696531320295;
        Thu, 05 Oct 2023 11:42:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id m123-20020a633f81000000b00577f8f4df6bsm1741553pga.18.2023.10.05.11.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 11:41:59 -0700 (PDT)
Message-ID: <1c5df4b9-faeb-49c1-a276-964ba96f22b7@gmail.com>
Date:   Thu, 5 Oct 2023 11:41:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] net: phy: broadcom: add support for BCM5221 phy
Content-Language: en-US
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Giulio Benetti <giulio.benetti+tekvox@benettiengineering.com>,
        Jim Reinhart <jimr@tekvox.com>,
        James Autry <jautry@tekvox.com>,
        Matthew Maron <matthewm@tekvox.com>
References: <20231005182915.153815-1-giulio.benetti@benettiengineering.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231005182915.153815-1-giulio.benetti@benettiengineering.com>
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

On 10/5/23 11:29, Giulio Benetti wrote:
> From: Giulio Benetti <giulio.benetti+tekvox@benettiengineering.com>
> 
> This patch adds the BCM5221 PHY support by reusing brcm_fet_*()
> callbacks and adding quirks for BCM5221 when needed.
> 
> Cc: Jim Reinhart <jimr@tekvox.com>
> Cc: James Autry <jautry@tekvox.com>
> Cc: Matthew Maron <matthewm@tekvox.com>
> Signed-off-by: Giulio Benetti <giulio.benetti+tekvox@benettiengineering.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

