Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACB9784631
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237340AbjHVPuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbjHVPuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:50:05 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CDF11F;
        Tue, 22 Aug 2023 08:49:50 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76ca7b4782cso316614185a.0;
        Tue, 22 Aug 2023 08:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692719389; x=1693324189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UjZNfGDdDwl9AE3NP8wz+0UtBemnz6Iej/5/4IAARWU=;
        b=RXuYMIx2+TD383Kirc2HP3IAmDNpVNhAurlDTOVvGIxSZo+SjmEdd3BT3+SfrVwr9m
         MPVYjN73/ySMSnehNZBRdy0yhMycPtCViDGnf4zdioN4I6efgTvmKme88MVwz7c7NZBe
         82RfMBPF3/VrdcKLQtZB73mXbtIw+Yd4Rql77ZqeaeIUfzrj6cYxegDRz2XCeR1wxVEJ
         tfu9jH2co2WiaO8hNldJHw7xnhZ1Belk1FXGNffv2yiPnUh0oSJLkacguquFTCNiTAhg
         gRfm6x5oAWC+TOoerEyyqlpLbrkNErnvrUpKdO556JpscXyxNVqUEhbsCEGu0lHXpkpK
         2Pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692719389; x=1693324189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UjZNfGDdDwl9AE3NP8wz+0UtBemnz6Iej/5/4IAARWU=;
        b=bVsTMgtsB1sWjzMVT9qD44isWhwXgtxSeEy52H3pYHro+QXYf2BWU9q3ssRaTyJbdc
         hBIGK0nYodX/GEvltasXxYR6GmO8mn4Nm5V4DkSw3R4I7OTq/3H43jJqMkCDayuZshMX
         B5Frz6ynfEem/3CKQLFpH1nghfRH5XXTVDmRGvDbdADl3l0srmtDsQFFOJBh29M/3xSc
         TcJ6FGcI6nC/VzHLYHrc8FrR++y7sXL7JRjDu6VbYBd1IaGt+5GP4qSMdV0lfeJs+lja
         xH+EtJ0IQG3Qqfr/x+3ewQ06XL+YKhQmqbU9XIzBhdR8zzutA0XpTA34pVyV2EZImgRh
         hp0Q==
X-Gm-Message-State: AOJu0YxDs8ekrQtV8oq1flcl8VT0AaA5LWUsOeYPdi1+A2MhP8DvtDh2
        YuPHzKgCbLbKlerjkFPbyQ13iCqCKEs=
X-Google-Smtp-Source: AGHT+IGgkJ/1ozzuZy7ZMVEEt+ZRGDiPwfJPh584MojQmyHKJHDKjTteup64RPAIIPswxXASzqALRQ==
X-Received: by 2002:a05:620a:31a6:b0:76c:9cc0:64e2 with SMTP id bi38-20020a05620a31a600b0076c9cc064e2mr12577541qkb.28.1692719389442;
        Tue, 22 Aug 2023 08:49:49 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id z11-20020ae9c10b000000b0076745f352adsm3265941qki.59.2023.08.22.08.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 08:49:48 -0700 (PDT)
Message-ID: <5ce3a56a-7299-4ae2-ad6a-14342417fb19@gmail.com>
Date:   Tue, 22 Aug 2023 08:49:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] net: dsa: rzn1-a5psw: remove redundant logs
Content-Language: en-US
To:     =?UTF-8?Q?Alexis_Lothor=c3=a9?= <alexis.lothore@bootlin.com>,
        =?UTF-8?Q?Cl=c3=a9ment_Leger?= <clement@clement-leger.fr>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230822084112.54803-1-alexis.lothore@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230822084112.54803-1-alexis.lothore@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/2023 1:41 AM, Alexis Lothoré wrote:
> From: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> Remove debug logs in port vlan management, since there are already multiple
> tracepoints defined for those operations in DSA
> 
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
