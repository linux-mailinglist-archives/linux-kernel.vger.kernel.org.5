Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B16F779FFA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 14:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjHLMbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 08:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjHLMbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 08:31:12 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB5AE64;
        Sat, 12 Aug 2023 05:31:15 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-790ba9cf42aso102624239f.3;
        Sat, 12 Aug 2023 05:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691843475; x=1692448275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6d4aBxj63TXYDHeoHM7HPuS93LbfiZI1E+d0mnxl1b4=;
        b=OgVix5aETByDwFW8Ny1tKrqKSx8vJcmw8gw6ZzISYxoVqNGre9vh10bcaB3nZJt1uB
         oC9ByCyNBIO8Xnoef4LxSjsu3DYlw/S6ZGMQyiwzE2Ywp/FAJYtLvFBVkLMVACBZrAz/
         HGDFYRW2atJI3S9niN3d9S+aXH/cfU+ztk8hHsp0m2Rl53tGfMnI++1rV2TXdcp6XQ/r
         YjZRfD+o6ikgd8eXCl8yJo2fk8KCmqd4YXPZTlFXmsE0TcD8OjHnyvS8gQxqpxUh0ZB1
         xILS8bzn9S4Azt4unHGFlHe/MYcL1GJD0RTIpnKnbMelaqo+Rtw/Nc0FA3LusRsADPW2
         u8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691843475; x=1692448275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6d4aBxj63TXYDHeoHM7HPuS93LbfiZI1E+d0mnxl1b4=;
        b=gnXsRWE0kkWivVxKVLUTdXFOswlSZ/sQbVl4oxyJBu058X2u4BmrYIAJOkJRLOCu0V
         MufwHRzWsJwp+IwuzEQHXEYk4eGQScdpqcePE6w23Pv6BZrAoy1uI69p98ia8hlQR94y
         G04eyu30GEVAVUMOqgiuufM59+OLCw35HKX6zpoiEJm2jWeHQv0TPoGUcqrc1sG8dCV1
         aQScUrWyMHDf0BM0KdmIhai/IEq37FNcnJQ1UI48MJf1RvaK/HagrBxRhuYD77LpFp/n
         s324Gio7/OWDP8Jt8zdf2/YVMFeALVN0fyOFrUNvTWcITayud0Ynusnp6OJHO5xqiFq/
         4k5A==
X-Gm-Message-State: AOJu0YzbJ8Tx9t/dXdLuOJOJP2Tod6qFxgZwI5ScNy0xEe7k4/ne2M/T
        FDUOpKBxpv2NOOz2si8MeiI=
X-Google-Smtp-Source: AGHT+IEL1XFE25Xkffib49Z7ZP7iXf2eHjpuKA+TNEE4QpQOXnPqPCBn9mTcDlIjFIZ+gMnfnuEn9A==
X-Received: by 2002:a6b:e017:0:b0:790:bb3e:78e9 with SMTP id z23-20020a6be017000000b00790bb3e78e9mr5868866iog.16.1691843475043;
        Sat, 12 Aug 2023 05:31:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ge5-20020a056638680500b004300d87030csm1727227jab.109.2023.08.12.05.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 05:31:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5ea824b9-b25a-5e1a-e59b-815477648082@roeck-us.net>
Date:   Sat, 12 Aug 2023 05:31:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/3] hwmon: (pmbus) Add ON_OFF_CONFIG register bits
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20230802193155.2170935-1-Naresh.Solanki@9elements.com>
 <20230802193155.2170935-2-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230802193155.2170935-2-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 12:31, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add bits found in the ON_OFF_CONFIG register.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

