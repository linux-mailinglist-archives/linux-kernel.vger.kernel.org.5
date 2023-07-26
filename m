Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CAC7639A1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjGZOyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjGZOy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:54:29 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FD810F3;
        Wed, 26 Jul 2023 07:54:28 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6862842a028so3993400b3a.0;
        Wed, 26 Jul 2023 07:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690383268; x=1690988068;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UuWS2k+JCf/SgvTmKSTe79OiavDylfF6Nt3w3ojyWpk=;
        b=PtzMfJDQkIWOIa6U9nbWN7kT+7YZLNwB7xabAY/YJtPj8ifglB5GSB+uqTthTeonD7
         S9VOi8ZyFlRF89BjZ5La8MYNXV75XsIr6eA7swUZ5B3RmzRMNNhT+JfcQbx9ldvdXkZ5
         zpoPtGnANSlls164U8iboWUP5XNo83Dbr5XAF71R+yQj6V9OlS4jUssq2ugnC9QU1bSi
         nWxt4EnNeP77/1D6DJq14pOOM8OiO3KfLhcHahTiXL/K4AJPu//RzSUFmwjH8sjNEBbN
         q8LlQFo4uZtezQ9g/4NRccd60oSXpnEFKx37/la/tJUHWeabi/yrnpjpiIfUUi36WOGd
         86Mw==
X-Gm-Message-State: ABy/qLbulgKjMF9jcrf2WSGIPfe8h0JzkXnyvBHKLHttrZJVp8T/pago
        At4HCwTbE8eV9ceoaacWEpQ=
X-Google-Smtp-Source: APBJJlEOjtuRs+yoPYTIYSKyIRh5TosXj3onTsKaVnOJp3v0HP4gI8BK5fv4FbwBZFrJ8xlLo2ziuA==
X-Received: by 2002:a05:6a20:3ca3:b0:132:1e76:6f02 with SMTP id b35-20020a056a203ca300b001321e766f02mr2350185pzj.34.1690383267614;
        Wed, 26 Jul 2023 07:54:27 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:7ecb:b0e6:dc38:b05f? ([2620:15c:211:201:7ecb:b0e6:dc38:b05f])
        by smtp.gmail.com with ESMTPSA id k11-20020aa792cb000000b0067aea93af40sm11587369pfa.2.2023.07.26.07.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 07:54:27 -0700 (PDT)
Message-ID: <7e4f6c51-43f4-c039-07bc-6724748a1d3e@acm.org>
Date:   Wed, 26 Jul 2023 07:54:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH blktests v1 01/11] nvme/{003,004,005,013,046,049}: Group
 all variables declarations
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>
References: <20230726124644.12619-1-dwagner@suse.de>
 <20230726124644.12619-2-dwagner@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230726124644.12619-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 05:46, Daniel Wagner wrote:
> Group all variable declarations together at the beginning of the
> function.

An explanation of why this change has been proposed is missing from the 
patch description.

I think the current style, with variable declarations occurring just 
before the first use of a variable, is on purpose. I like that style.

Bart.

