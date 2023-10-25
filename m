Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720227D72FB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjJYSKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjJYSJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:09:57 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C57A1AA;
        Wed, 25 Oct 2023 11:09:53 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ca816f868fso41117485ad.1;
        Wed, 25 Oct 2023 11:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698257393; x=1698862193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gw+AcXPUUwUKlBUNb/H3ifXReKZDanNIXHIBrZtP1Gw=;
        b=FHjSI0uMTNFgIzHycBJnMI/Y9KNcENPrnFYCHXQ4b3wzzhKS14GTR0EKB7rbd2phhV
         OIdNbNhK+PalJPWq53Tec2ea6LKTlCeMEG8oFkKFAzpX6elMAhWtBfd118kOOkyATBj+
         ZqJRlhlIAVgmP20pHrmYOlx1pPnDXpVMcLLouIeQgjJzsZU9y/BvHq6W63nl7kAZtGlz
         2YjP8AcULHp+JiohzSrha4sHN/hcH7RnNNFtykd6bftvbMTpGOMKoekWI90/jMrJDLP1
         oLrq0wdUF53x3mt773bVT0ANjcQ+SsKZLG2wi3z7pixM15AJ1W2dOaHZblxpeUO8+jN+
         RbJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698257393; x=1698862193;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gw+AcXPUUwUKlBUNb/H3ifXReKZDanNIXHIBrZtP1Gw=;
        b=rLnCF1IgcGT6ewNdnT88HZ7gBk/yAjVawEq8ykAhYN4WE29r+tM0WyhnJW5SRVxYw3
         FHAXUTeG/pTOhmCGWcArs/qvLrIwvC8j0MdAD6EQdATkpqqR2RhuS3AgCniO+QhoU0RL
         vDeGjNnqvVRgctBg0zI+EPHOeGtjE/Mj3Qu5FNnx4JOBfjUuTXYwWyRmn+x9r9N5fPO0
         oP4rgNPCD+tHtX7OBmOLAuogjq6l3TnRF2Uc9z2fJqQjfk8SgOwm8zbG6u3DSXkHpwgs
         gQxnmURgI6pHZxZPf6ufHDm3yNblNvdLvysmGq1JQtb+gqXlLeANdxLKf+w00+gKtEKk
         Wvow==
X-Gm-Message-State: AOJu0Yx7ukOwRPCa8M69M5ZFJlm7BsNmLlWMtJNJrKa+fGfG2y3K10MC
        j/NNWPzJKLK7CiUbnnicnvM=
X-Google-Smtp-Source: AGHT+IHo8T5lgne0YASthzZIcst0pzNuBbVKdw5X5+m+YX9guVeldoCc+nGjQz/NfHEFtl3VJVQkQA==
X-Received: by 2002:a17:902:ec8e:b0:1c6:d70:144d with SMTP id x14-20020a170902ec8e00b001c60d70144dmr18113825plg.34.1698257392843;
        Wed, 25 Oct 2023 11:09:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u5-20020a17090282c500b001c7283d3089sm9462393plz.273.2023.10.25.11.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 11:09:52 -0700 (PDT)
Message-ID: <3682d869-072e-4656-9b26-2629d8befeee@gmail.com>
Date:   Wed, 25 Oct 2023 11:09:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] MIPS: Fix kernel in XKPHYS
Content-Language: en-US
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregory.clement@bootlin.com, vladimir.kondratiev@intel.com
References: <20231023191400.170052-1-jiaxun.yang@flygoat.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231023191400.170052-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/23 12:13, Jiaxun Yang wrote:
> Hi all,
> 
> This series fixes support for loading kernel to XKPHYS space.
> It is derived from "MIPS: use virtual addresses from xkphys for MIPS64" [1].
> 
> Boot tested on boston and QEMU with loading address set to 0xa800000090000000.
> QEMU patch on the way.
> 
> Gregory and Vladimir, do let me know if I missed anything.
> 
> Thanks
> - Jiaxun
> 
> [1]: https://lore.kernel.org/lkml/20231004161038.2818327-3-gregory.clement@bootlin.com/

FWIW, tested on a Cobalt Qube 2 (RM5231):

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

