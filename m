Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1651477A73A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjHMO76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 10:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjHMO7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 10:59:55 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C95E4B;
        Sun, 13 Aug 2023 07:59:57 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fe8d816a40so3470205e9.1;
        Sun, 13 Aug 2023 07:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691938796; x=1692543596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Il0m/lOqz0vfB+XlsodsH9+I+amK+zd4Tb9YP5hNen0=;
        b=aUiSB33sknPd6+50yVb0jYxhDQjmQfd2DN/n2ivQTr7onpmeoD2DkbfzHHP5jAyCWy
         UN5mSw42vMW0to2XzKbWyC718/pcM5IW+murwBlYQlHfJsa+pQ1oBpNa96dNXKAwXebg
         5PZFyELVxFW8wrj1s0tO+phYUfJIW5C6xM35IMjk0SSnXUoMDVZWgolTAHXxsl5cxeMO
         oxyL8tqNI+vATObhjiCwvVk2G1H8IO7g3/Qv/M9P7MqeCPuVuICD0/x77lBxCCrYJY1i
         0bxMjVxOVwp4FJRavwkFPnBPaSi2hsncu2IP40Jhx3EBsINQmzP0MoHBqN8N4mNmkUL8
         aMDg==
X-Gm-Message-State: AOJu0YxpVHT+odnmvS35wbnyST1MUfd3zTmekJDDMVaDBYHovUTfkjtq
        A3u/pHkqhDJjUvN6s2IHoRs=
X-Google-Smtp-Source: AGHT+IHTrX97QvCgayVEBdbqNUrzi0Oa+3iNx1L7BGPGmJ1HsLfOLo9itX/W7HaXgjAK5iLkZmhtQw==
X-Received: by 2002:a5d:5484:0:b0:319:7624:4c8d with SMTP id h4-20020a5d5484000000b0031976244c8dmr711423wrv.0.1691938795912;
        Sun, 13 Aug 2023 07:59:55 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id pk15-20020a170906d7af00b0099bcf9c2ec6sm4690166ejb.75.2023.08.13.07.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 07:59:55 -0700 (PDT)
Message-ID: <1098c6a6-50cb-8704-9041-03c431155dfb@grimberg.me>
Date:   Sun, 13 Aug 2023 17:59:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH blktests v3 00/13] Switch to allowed_host
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20230811093614.28005-1-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230811093614.28005-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Addressed the comments from v2. I also added cleanup code to _nvmet_cleanup() to
> make sure we do not leak resources when something goes wrong. I run into this
> while testing and all tests after the first failure failed then.

The name of the patch series suggest that it switches to allowed_hosts
where it does that in 2 patches 11+12 out of 13 patches. The rest are
just bug fixes and unifications. It's true that any series will include
fixes, cleanups and prep patches, but this is too far :)

I'll let Shinichiro accept as he wish though.

The cleanups look fine to me.
