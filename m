Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C317528F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjGMQof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjGMQod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:44:33 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CF51BF8;
        Thu, 13 Jul 2023 09:44:33 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40348601753so7202981cf.2;
        Thu, 13 Jul 2023 09:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689266672; x=1691858672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXdwFHfILmXMZPqzWaKgPH+49WO2TT1+7RbodHVq2ig=;
        b=lAsanCKgYX9/LrkCcZmfsuVUp9yBivSH9AYIAc5OtE+Pa8EUJU9rJ4+ylyUdBSytbw
         l/qi8b6R1YR8G3ttDAx4VXC83nBd+Q6tiRGP2IMRNOPSoyIvTy6E580eTv1xSWlJsOas
         kViBOx1nXGB4lqOt5cdHXUX7vCT3PvUTYxMl3YFQYgHoaX2W9U6VppF9KuDUTpUgle02
         F1x50O2CylmGo5GquV6IAaTD/soXghYCN/ey8iLTQgsg5JyAg0DGWflX3YHAO/301as8
         qYBJtU6EmwaxdNF+vWGCUMRZULMFBDBbu4wQRt6i+H8pAs/IAEFDh9xiT36xuspXO/oU
         BQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266672; x=1691858672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXdwFHfILmXMZPqzWaKgPH+49WO2TT1+7RbodHVq2ig=;
        b=cRRG4crXJtNT8Nv5p2Ed9bqnptzK9+LMLUoZ5ZL64aCrwrsS8BHxzcLYWjVAJ8vsjd
         F7qeeym20GAr2t6DhFL15b9vrXhGhD+eNqakt52z88+/EhSYydcDfQkhqMglrA/aOGEu
         SnSiGps9GGTsJFQfQLd2/NFM0hv+35JMzIZTVf6in8L81QZhsz3/WRqNk/54ef4kIdtn
         pdVrGrq7hYGyrA1pDiv3xVM6zOTGeO7LGDHOYXi79mpmEwV0N5+YquBWq+R+iDLkUbC4
         wksRpYGUeKVX7dnlNynudEEAYKeQJWLeppQUy3RvcVx9s9t0UIVl+W+CY6kS7rTxZ+7D
         EGIw==
X-Gm-Message-State: ABy/qLZTEMm+S5SQAFIoJQzWIMH3gLn91M5whFrjBc7D9SNjGRIw/sNX
        I9sA14XJ4ZIa2O5PiG53Tp0h+UI47aP+vA==
X-Google-Smtp-Source: APBJJlGh8sojoadtyZOdE3HwKq4LsQ8SvIBCGgq7FqeYfvWkzMCjQiUBgtKJ4LpiR/WDpqhGTfmtCQ==
X-Received: by 2002:a05:622a:1752:b0:403:b112:1176 with SMTP id l18-20020a05622a175200b00403b1121176mr2644978qtk.37.1689266672109;
        Thu, 13 Jul 2023 09:44:32 -0700 (PDT)
Received: from [192.168.1.208] (pool-173-79-40-147.washdc.fios.verizon.net. [173.79.40.147])
        by smtp.gmail.com with ESMTPSA id ay14-20020a05622a228e00b003f9e58afea6sm3203398qtb.12.2023.07.13.09.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 09:44:31 -0700 (PDT)
Message-ID: <3cdbddeb-bab9-789e-d9bc-8358dc5a635e@gmail.com>
Date:   Thu, 13 Jul 2023 12:44:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Question about the 'bw' field in the fio output
Content-Language: en-US
To:     richard clark <richard.xnu.clark@gmail.com>, fio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <CAJNi4rMK6hc6vh8hwU_zb_p2uQn=FLOmAuAJuF1DxMfyG8nixg@mail.gmail.com>
From:   Vincent Fu <vincentfu@gmail.com>
In-Reply-To: <CAJNi4rMK6hc6vh8hwU_zb_p2uQn=FLOmAuAJuF1DxMfyG8nixg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/23 11:43, richard clark wrote:
> Hi,
> 
> I found that sometimes the fio command will have an additional 'bw'
> field as below:
> ...
> clat percentiles (usec):
>    |  1.00th=[.  51]...
> bw (  KiB/s): min=45689, max=49753, per=100.00%, avg=49658.56,
> stdev=89.23, samples =5
> iops            : min=.....
> ...
> 
> Please there is a line beginning with 'bw (  KiB/s)...', but sometimes
> the 'bw' line doesn't show, does anybody know the reasons?
> 
> Thanks.

See:

https://lore.kernel.org/fio/7b2f76ca-42bb-dc73-dd07-2cc79729ecb0@gmail.com/T/#t

https://github.com/vincentkfu/fio-blog/wiki/Periodic-performance-measurements
