Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811E27D43B8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjJXALY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjJXALX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:11:23 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1020810C;
        Mon, 23 Oct 2023 17:11:21 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-357c94845e6so9670575ab.1;
        Mon, 23 Oct 2023 17:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698106280; x=1698711080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SxM8ogapjGL3mH2yiP7/UA3gEGZG7d192nEgnAulpr4=;
        b=dOegSviweEM8phIku5s2ePkWLNvtmv2knyqQ5iZxzpAGIupomVAzAI2nimBHZL3Bfp
         KTVJddki9wyaJ0Yn2C865Nh8cg1ss9iV1gZW/Ju4ijUeYCD0nxb0yvOb4dIUjZ3WM+Cx
         CRIpQg+NU9Rlxk2mXkn6Lvel4kvPSrWWwvfZaCj4RSKyGEFUPdt1SEtCMPpk0YvTVEJr
         qqqeMfE+YdtttLJUURagzeuAvMg+LBYMDZecGwj9uUdyQqHkUK5Wq8mrGayIJAv2d37t
         y+EL8isYvLSewQ1Q2/3JKBGXaSQXxKCx+44xl/z+vg52D+Jv/XIcjwHKpPGgf0TMzTzD
         0OJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698106280; x=1698711080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxM8ogapjGL3mH2yiP7/UA3gEGZG7d192nEgnAulpr4=;
        b=c8VHWcmert2AF0CubP+U8QpR5cy17k/LOc50ntozJMgEWNWAeXJ4gWu+oD1dRm+bR3
         jiTF3pDct7Mb/P00ep1bE1fTqmpmAlxle7+wgx4rPGFtAap5AyXbCuv/Yoj3gVS3HMaO
         cfYhfNXHHfc4yIQ5txhs2jqaL6fNoWfTQLLXQUII5QywfNrYNndipbLK3pislvMVYobi
         RqYLgsYOu2yhHvmSr9ThiWKx8GoiKSxknotaj7wacwGqnyOGvrj2hy4n9V2Eu4m5b8S6
         GEsH4lzCGXPPqj6Z3taC5RBiV+GRzvQoiy4bws+GaiHFTrL9FqC65wRWcmgI7NZK/y4F
         paXg==
X-Gm-Message-State: AOJu0YxlfMqpX0+Qd/7V99OK+AlmEYM9SUBEtA38smRjpn40qpxLtsGO
        /4nQU+BV3fSa1VwbLJ+z194=
X-Google-Smtp-Source: AGHT+IFdJ7JO3b+5zx7rnIRwyFIoFjSSEtUnKxMHtd1CIa1+tENkXvrX33uH8frn57TOlMMfdJD3Sw==
X-Received: by 2002:a05:6e02:20e5:b0:357:d0b8:c4dc with SMTP id q5-20020a056e0220e500b00357d0b8c4dcmr6592045ilv.19.1698106280246;
        Mon, 23 Oct 2023 17:11:20 -0700 (PDT)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id e4-20020a656884000000b005b488b6441esm5367592pgt.58.2023.10.23.17.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 17:11:19 -0700 (PDT)
Message-ID: <e1b1f477-e41d-4834-984b-0db219342e5b@gmail.com>
Date:   Tue, 24 Oct 2023 07:11:12 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] MAINTAINERS: Move M Chetan Kumar to CREDITS
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>
References: <20231023032905.22515-2-bagasdotme@gmail.com>
 <20231023032905.22515-3-bagasdotme@gmail.com>
 <20231023093837.49c7cb35@kernel.org>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20231023093837.49c7cb35@kernel.org>
Content-Type: text/plain; charset=UTF-8
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

On 23/10/2023 23:38, Jakub Kicinski wrote:
> On Mon, 23 Oct 2023 10:29:04 +0700 Bagas Sanjaya wrote:
>>  M Chetan Kumar <m.chetan.kumar@linux.intel.com> (commit_signer:15/23=65%,authored:14/23=61%)
> 
> 14 patches authored and 15 signed off?
> Let me be more clear this time - nak, please drop this patch.

Or maybe as well drop INTEL WWAN IOSM DRIVER entry (and let
WWAN subsystem maintainers handle it)? I don't want
people get their inboxes spammed with bounces against
his addresses, though.

He's now in a state of limbo. He has significant contribution
(and gets listed by get_maintainer script with (AFAIK) no way
to filter him out), yet emails to him bounces. What will be
the resolution then?

-- 
An old man doll... just what I always wanted! - Clara

