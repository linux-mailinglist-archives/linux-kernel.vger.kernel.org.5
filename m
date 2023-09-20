Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCF47A8E63
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 23:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjITV0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 17:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjITV0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 17:26:36 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59524C2;
        Wed, 20 Sep 2023 14:26:29 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c44c0f9138so1919925ad.2;
        Wed, 20 Sep 2023 14:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695245188; x=1695849988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DgcqJ2M4Tq+KACj+isti3mYmi5snB7ONFF1TieuOqT4=;
        b=HwOiPZHFw+oR8PbfzOiftnsV009yuJLHkRFgX2dJaPAsgmTXnZ4Hr0Ybc3htO/25qF
         b2S/eDMOw26caR3CsXJURfbX0TiJz+1SrqujsvaDy2OCZA7phiX2l1285tN8vcL5ww0R
         wkB00cOcUYufPkx9gYn9Aj4fVNEkya6Qc3dibzUubZZ9SUASLFIg55HbMzpnebtGThNM
         2JuCPKnYBygiiArboLvrl3PLuJlb3Lk6UqSwiAVtebrZEw6eX4wbphsrvH+nGrVRl8D5
         J7u4KA24W/yD4LElZeJAEjppFJuiwCsv9RfI+VjcOHYJotoZ+b87XRGbr3yq0/vFO7dN
         KTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695245188; x=1695849988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DgcqJ2M4Tq+KACj+isti3mYmi5snB7ONFF1TieuOqT4=;
        b=e2pXlxlPqRjWRcYjn+j0Uiu6qC3mVAxGUOFPoFTmFIUXMeGIFhgZQrYPClzh5GCevY
         zjd07X6GnqIpRzRyzny6JsgFYaLWkUfjuaSIu9Hme0SUWqHRtkqGOxqOQTW0Gkujk4N1
         /O+YuYbTPYHqs6gfJrkHJZw75Q4Qv8aDgg8JvqlCz1KIeulxvZQpVPKqVmNkBKMqXVry
         T3rY6IU9KEmcrSmn1e3Tzubu08dv1BwVPGTYPcx9/gERgo1JqKIEARhPzYe1Y4fFoenS
         6xVTZD7FQBe2q1BjYduED5RMZOZ4avWR6jLaLzGkNvrMRmW3oIQqk0tmXNIxIL+JQuFQ
         vTgg==
X-Gm-Message-State: AOJu0YyRLmELSpY6yW/FF2LwMW/WRZF32Gs1MKJP8bhaeodcp+qD9yiz
        z/wRT1moRd7qbOJxTGv9ac8=
X-Google-Smtp-Source: AGHT+IHX7e1iWRt6/yApc4tiZRuq4ySdgvxYs1kzLgVoaOS+LiuBIbkwxFBUUvbp7O4VAFwePhICOA==
X-Received: by 2002:a17:902:efc1:b0:1bd:d141:f02d with SMTP id ja1-20020a170902efc100b001bdd141f02dmr2746647plb.68.1695245188507;
        Wed, 20 Sep 2023 14:26:28 -0700 (PDT)
Received: from [10.67.49.139] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u5-20020a170902b28500b001c07110f3ccsm12287439plr.247.2023.09.20.14.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 14:26:27 -0700 (PDT)
Message-ID: <3d730eca-0075-139d-79c2-0c8243eba522@gmail.com>
Date:   Wed, 20 Sep 2023 14:26:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/6] vlynq: remove bus driver
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mips@vger.kernel.org
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20230920201035.3445-1-wsa+renesas@sang-engineering.com>
 <20230920201035.3445-4-wsa+renesas@sang-engineering.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230920201035.3445-4-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 13:10, Wolfram Sang wrote:
> There are no users with a vlynq_driver in the Kernel tree. Also, only
> the AR7 platform ever initialized a VLYNQ bus, but AR7 is going to be
> removed from the Kernel. OpenWRT had some out-of-tree drivers which they
> probably intended to upport, but AR7 devices are even there not
> supported anymore because they are "stuck with Kernel
> 3.18" [1]. This code can go.
> 
> [1] https://openwrt.org/docs/techref/targets/ar7
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

