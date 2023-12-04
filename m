Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA39F803B25
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjLDRI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjLDRI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:08:57 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F502CB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:09:03 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1b7b6bf098so182899066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701709742; x=1702314542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwXL8BrRM8BseBFb+FVnbs3rnml2/q46Wk4gm1RfHQc=;
        b=mQ7w64KVcahmF99STsf781e+ZAJbzal+Ez3+SoeyMeGAdWmCdBNdAyLaeiv5I32IVh
         xDYtwRjaosGN4/NDMZpodkgOozDUlNFBWaUCTkkJ9Exq3TpIVGpHedDgAnver1YWTE3D
         A/k5ta8nU4A99G5tKOYopSJXtw9LV2um7DlPGFiFXppKQbkp00ecmo+l26U7t2yQ2IpQ
         yaRgqYNu+zOb2wN2jb9yCVV+SHHXZo7k9ILAZk1XOgfY8KAj2U6/esb7yCVe1szuejdk
         B2wZXBQ+AtkQ+9XeY5pMM+n5GS2lgSrbYYkQ0l/lXMJpjiP4zKIipFSyAYcGS42Dn33G
         7msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701709742; x=1702314542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwXL8BrRM8BseBFb+FVnbs3rnml2/q46Wk4gm1RfHQc=;
        b=uie/ab2JMEElvf2pFldtYcfSv5Pktp1azn9LmC7IPt7lr+RuAWdw6j25Q9wPqnmqX9
         /wrHk8SfmTueDS9rTPNWzenqtB8P+AH8bWm+pAyZvPpaGCNpO9oWNzq5ty7qV/Ex2G8y
         nQFqD5+b5aG73EcwMDVYLXBhmz/kNsyPvZoM0/8x4/zW4v72WEC8b8k2DPktxSbbbzWj
         W390Ow0XO1sWGsLZTQtJe3BIN+wN/vBMxT61XrJ4BtTYRuAfJRXy+O+knkfWFAO/Rxey
         G8hN/UawCsjGSaOBIkffk8nYTfC4ba921FQxmfZudB/E2OdbJ7tDrsLMetu8mai9lFrc
         WgpA==
X-Gm-Message-State: AOJu0YxNmGmUpdlIBes9d7CJzDL+9Ji/bCuqjb/3yLljwBLFVxSvRhPu
        9nWWMHZst/cUAwXSPs19Ui8ycA==
X-Google-Smtp-Source: AGHT+IE6/SlKllvBRaAuPlE58JB7LAAvR5NP8IT6OxfCtQahmBOANENbG1qEgyja3170l7I7Cx6YCw==
X-Received: by 2002:a17:907:100a:b0:a04:e1e7:d14c with SMTP id ox10-20020a170907100a00b00a04e1e7d14cmr5225697ejb.32.1701709741738;
        Mon, 04 Dec 2023 09:09:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:d925:8508:67e3:fb10? ([2a01:e0a:3cb:7bb0:d925:8508:67e3:fb10])
        by smtp.gmail.com with ESMTPSA id b8-20020aa7c908000000b0054c738b6c31sm17013edt.55.2023.12.04.09.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 09:09:01 -0800 (PST)
Message-ID: <b66dc60e-78ad-46f6-9ad6-430f288af018@linaro.org>
Date:   Mon, 4 Dec 2023 18:08:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: optee: os: toolchains would include linux target macros likes
 __linux__
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Randy Li <ayaka@soulik.info>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <bfba8d2c-646d-4d62-9f71-8e388e70f782@soulik.info>
 <CAHUa44FEkdtA+4AuoQnNEnObKzcUX3qkFD8iV8Z_pGJ7ZPWw2A@mail.gmail.com>
Content-Language: en-US
From:   Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAHUa44FEkdtA+4AuoQnNEnObKzcUX3qkFD8iV8Z_pGJ7ZPWw2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/23 17:34, Jens Wiklander wrote:
> Hi Randy,
> 
> On Mon, Dec 4, 2023 at 2:39 PM Randy Li <ayaka@soulik.info> wrote:
>>
>> Hello
>>
>> I wonder why Optee OS would use a linux target toolchains but not a bare
>> metal target(none os)?
> 
> I guess it started with that we didn't want to download both one Linux
> and one bare metal toolchain. We need both AArch32 and AArch64
> versions so it doubles up.

To expand on this: when building a complete OP-TEE setup like we do with
https://github.com/OP-TEE/manifest, there are many different runtime
environments: the Linux kernel, client applications, OP-TEE OS, Trusted
Applications, EL3 firmware... Some of them require a Linux toolchain
(the OP-TEE client library, tee-supplicant as well as the client
applications). So the idea was, if we could build all the software with a
Linux toolchain, it would simplify things. Since then we found out there
are caveats but it mostly works.

-- 
Jerome
