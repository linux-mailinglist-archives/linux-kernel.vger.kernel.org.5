Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F8D7888E3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244721AbjHYNpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245280AbjHYNpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:45:34 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7102139;
        Fri, 25 Aug 2023 06:45:29 -0700 (PDT)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1bf57366ccdso14271695ad.1;
        Fri, 25 Aug 2023 06:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692971129; x=1693575929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=locQDMaaxVaHhY5uaRYOvholvuvSJF5DSChbm8/qh5A=;
        b=CPZAnjzdEZhj+wEiXHb05PtYEdRZBMLbVLNyWLdIjq+ECTpkZE8hsSDNRdcConpMo/
         NAcMd/HdON5Vs2NX41wmdpFjS9Uh4nB4zFDW2rlrrSj4SvK27X2QzNDtLM7mcLsuhzKx
         nto9tL4tQ0RUmFORdhXSa72IhQ4hWHPXPvdHQi9X9wtfGODROochT6TY4mqMboNZicXP
         +rFvbeHu/F0oOPRXv/gM+xLYjOSEn/EajGPHkJ8pyJC54Y3kqrLaf6KjSRuHSftnuVy7
         erSdRCDsmXarjPYAqFMtm60Aj1PLbCQtkNFwOTaDokQ/pf3wQh+yO36fn+MojVeBhtmE
         VuDQ==
X-Gm-Message-State: AOJu0YyCh9Op0iK1TS9w+1a6ANu8tnfv/MCJXlA1Ixz0HLI7h+zF9Ruy
        XHl65lxLwtE3uGDpXyWB/jFzDD1hjcs=
X-Google-Smtp-Source: AGHT+IF8/LS9M3NEQYyGUlAZBHCHoOJ6Tn69CK8LsjyU7lgo4P/sZtjlDQ+JhRAss9UfU0aWFHgvKQ==
X-Received: by 2002:a17:902:64cf:b0:1bc:17ab:8d68 with SMTP id y15-20020a17090264cf00b001bc17ab8d68mr22626425pli.16.1692971129063;
        Fri, 25 Aug 2023 06:45:29 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b001bdc209b9a0sm1701231plk.201.2023.08.25.06.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 06:45:28 -0700 (PDT)
Message-ID: <b79c0c9d-3930-4dbf-a1cf-8ca9e00af614@acm.org>
Date:   Fri, 25 Aug 2023 06:45:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
 <fbyacmtpqfhfb763s7utwbt4kdbr3pli4rp7prj7jlklq2tit6@mkkjzy73r3a3>
 <7b5fc500-afeb-7edf-383c-0cdda77b3cf6@acm.org>
 <oss54jmgqzjcxecea4h7eeguh6lmhls4p74e7unbxmhz34asvk@a7n6vu6hauys>
 <zvu2ihivd6f4fbs7hpgowstq3li4wrdycqzso3c32qcco7zes4@s2l2solzzo6u>
 <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
Content-Language: en-US
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <saxcmve2nchhytphnknfqp2fxpwdk5v5xqfoq2g5gsdlecf3il@sypswqownxih>
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

On 8/25/23 00:34, Shinichiro Kawasaki wrote:
> Recently, you actively cleans up tests/nvme/* (which is great!), and introduced
> argument parsers in test/nvme/rc. The first one is _nvme_connect_subsys, and the
> second one is this _nvme_target_setup. It looks for me this is a bash coding
> style change in blktests, from "don't use optional arguments often" to "use
> optional arguments aggressively". If we apply this change, we should suppress
> SC2119. If we keep the old coding style, we should keep on enabling SC2119. What
> I see here is the style difference between you and Bart.
> 
> Now I'm tempted to disable SC2119, and to go with the new coding style...
> 
> If I have any misunderstanding, or if anyone has more comments on this, please
> let me know.

I don't like the "new style". What is so hard about typing "$@" to pass all function
arguments to _nvmet_target_setup()? Leaving out "$@" makes it much harder than
necessary to figure out the intent of the code author - not passing any arguments
or passing all caller arguments implicitly.

Bart.
