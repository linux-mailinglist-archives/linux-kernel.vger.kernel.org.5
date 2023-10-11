Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A087C45D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344239AbjJKAFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjJKAFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:05:08 -0400
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE528F;
        Tue, 10 Oct 2023 17:05:07 -0700 (PDT)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-565334377d0so5012055a12.2;
        Tue, 10 Oct 2023 17:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696982706; x=1697587506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAjMvZW79vccJfUDZIzN9hyHUALf36JDC62fnVe1DfI=;
        b=fe0hZLTcGptmijr6eXFBeL2Ouf9mTmEdNYC+GqQI9kO7g2x4Q4btnW+AjHlNJp5Bgc
         Pgyikw+F60DFgONcvV4m3HWSlphF+4jwE3V+vOEs6Hix0J15zazoy3xJLvbnuoCCaWrK
         PvoDxIgRjMfyCXJ7qi2WWB0mLu3dW5J9tlNLRXqdXaPVweuCsXT9sOo50IEquSIr9gka
         6LebclBTdvgPCW/UT0zmHByE0HzBVlNxF0XbC1u8+zI/DLk0+nBw/Ez7NimMEIlodgqy
         mS9OI9JD9G0omF7EoRxanEE7u7EzFbdibBnUnLAwHUtBHb/ag+95k06g6wzU0AGbrfQ0
         CeSw==
X-Gm-Message-State: AOJu0YztaZcF24HECIkl1hZV3TcBYKMGXYpzTfhtmwPW1g2CaeaSpdlZ
        aIW4GTczICUlUwKuH0vonag=
X-Google-Smtp-Source: AGHT+IE9R4JMP+o7XHMi3pIy1xuDrmXmEiJOUAlVOuMathk1en8QYKGWrtdWExuoY0uzJOxmnqrMaw==
X-Received: by 2002:a17:903:234d:b0:1c9:ca45:f86 with SMTP id c13-20020a170903234d00b001c9ca450f86mr717052plh.18.1696982706365;
        Tue, 10 Oct 2023 17:05:06 -0700 (PDT)
Received: from ?IPV6:2601:647:4d7e:54f3:667:4981:ffa1:7be1? ([2601:647:4d7e:54f3:667:4981:ffa1:7be1])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b001c61e628e98sm12413378plg.175.2023.10.10.17.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 17:05:06 -0700 (PDT)
Message-ID: <cf850508-498b-4748-955c-382906eff676@acm.org>
Date:   Tue, 10 Oct 2023 17:05:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: blk-ioprio: Standardize a few names
Content-Language: en-US
To:     yizhou.tang@shopee.com, houtao1@huawei.com, jack@suse.cz,
        kch@nvidia.com
Cc:     axboe@kernel.dk, tj@kernel.org, corbet@lwn.net,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, yingfu.zhou@shopee.com,
        chunguang.xu@shopee.com
References: <20231009100349.52884-1-yizhou.tang@shopee.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231009100349.52884-1-yizhou.tang@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/23 03:03, yizhou.tang@shopee.com wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>

The title of this patch is misleading. The title suggests that the
user interface is changed, which is not the case. What this patch does
is to bring the documentation in sync with the implementation.

Otherwise this patch looks fine to me.

Thanks,

Bart.
