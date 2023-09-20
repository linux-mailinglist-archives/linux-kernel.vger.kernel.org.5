Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542877A8E61
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjITV0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjITV0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:26:12 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE26D9;
        Wed, 20 Sep 2023 14:26:05 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c5c91bec75so1895785ad.3;
        Wed, 20 Sep 2023 14:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695245165; x=1695849965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDky5cMjhAdH0XJ0lHaGj/gCp8pUga3o69CncHMTrXA=;
        b=eLLazJkKlfB1YT9Hw7EQZlbxK8cZMvPlZr6yEL9Lcw0f8eEkKxbGQ3zmYkNeWCSkA7
         G5kiKDZlrPL48BWZYojoFiapJKaWQZ4HntTMx/0o1g8rJtc57/sJQsw8eNvU/8sU6UhU
         BI8oy1ExFbATOkx2SF28O++7Cpg8nL9z4tpfEjjQqo4XiwAkb3H4wPKkESZwhT70sgpW
         psDgkrC4UMCaRhbpsGruULHVNAjMgoXrbpgAS8znR+kVk86pj83wkWUVGb8JOtSO5FSl
         NBPlbPXWMHVb8p0Cc6m45n4wnkqIla/L97shPDpgXiG383VsSZ2ByYqNUaS2jt1XkWwU
         aveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695245165; x=1695849965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDky5cMjhAdH0XJ0lHaGj/gCp8pUga3o69CncHMTrXA=;
        b=R/ty/GPWCk4G0cj0GiDSmYetT049kZlLElCZ1E9LcEoBvTd5Fe2+CHvtsXKhA8Klgh
         gM+MZY7AeiPVuGhUHBrcuF7p3vQprplUDNSpGYRAadcWKbWqiJdot0Phxy2tpWBAIsy6
         4Jq8Kp8wF9OIE9VVo5L+JXqv+lojYc2RBnoDDNB3it3tx4eI08BJgc2YsZ0wG4KYwLXg
         LB+B3DoEhFeCkjwbUmWrV4huBJ0/IypnvQOac8cWrQdQTzKTCCqAix/4/JNA6ZZsqO5X
         CwkI0UcBAyaC16oxPUFLcbkpU7+n9q05fSa3vbNfDkQMYfQOKqUaOeRGOwhQsfMdJe1r
         poVQ==
X-Gm-Message-State: AOJu0YyYGR1zAGvMEerhLRuJIjrtXQA6ajvn+jqHDh9ZC0BjWr2c7QPg
        CavIxISGZH+uQweXr2/wVOxvQMQgKyQjaA==
X-Google-Smtp-Source: AGHT+IHcAvgXhDYx2lkefhWfeaa8+dmAicl4g02UBEsy+n2QB988lCu6OOvdMJZ3YymOi4uZKs00Kg==
X-Received: by 2002:a17:902:d2cb:b0:1c2:218c:3762 with SMTP id n11-20020a170902d2cb00b001c2218c3762mr4003650plc.42.1695245164701;
        Wed, 20 Sep 2023 14:26:04 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e6-20020a170902cf4600b001bf5e24b2a8sm1466185plg.174.2023.09.20.14.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 14:26:03 -0700 (PDT)
Message-ID: <78ca6618-27ac-811e-a37c-d83cc5426e0c@gmail.com>
Date:   Wed, 20 Sep 2023 14:26:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/6] mtd: parsers: ar7: remove support
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
 <20230920201035.3445-3-wsa+renesas@sang-engineering.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230920201035.3445-3-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 13:10, Wolfram Sang wrote:
> AR7 is going to be removed from the Kernel, so remove its support for
> MTD.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

