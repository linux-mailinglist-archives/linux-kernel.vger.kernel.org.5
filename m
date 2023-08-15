Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8966477CF84
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjHOPsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbjHOPsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:48:22 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598B519A5;
        Tue, 15 Aug 2023 08:48:07 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1bc7e65ea44so37612435ad.1;
        Tue, 15 Aug 2023 08:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692114487; x=1692719287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56LIeDt1iyVJwWjqDv8awcpNYpEag0enuy0hhcJlIbM=;
        b=EKnxV7S1XRby17wcnCKYbmyc83VTlrw7twvURBYWXF/4r3YWusd6DwWYzByB0B7z9I
         B4Xz5vasVYkXn+xcebGLyUAhsm0mf6mSXKeRFL2ulY0FfMEVX8D78QUI1tAgZcRsa4aD
         0HbPXrCLP+Yvh+RG1fq92YQMsj1p0HnzFR3/CPuHPylPDeX2DdpDjmYLi2PNFloIkpuf
         HfViwuiQDT9+PkWyVSIsSHIZVJvX9UzF/Dr4e4fjWkvNDM4sl6Hl0ljSA5UXtEAIC1Mm
         vglyzCfOVZTleWwbsTfn/uZNmlsOBfgDQiyzug3xbK+p5MCJ0DaXLtDaEkimrpxumJQD
         no4Q==
X-Gm-Message-State: AOJu0YxDjDn2aLLsd3eJSMK22EqvmNF0r80iXm95QMveYI1e/KUznk0P
        vIFRYtptWvecTIhIbYo/jpc=
X-Google-Smtp-Source: AGHT+IEVXp0SBmcVdojMyzvf8gzVkPb+m2qKbTBEWeRmJKeiDig1PblXjpao6Tx0/Ns7VqolqBf6Yw==
X-Received: by 2002:a17:902:e5c8:b0:1bc:7001:6e69 with SMTP id u8-20020a170902e5c800b001bc70016e69mr2960687plf.23.1692114486679;
        Tue, 15 Aug 2023 08:48:06 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:a40d:28ad:b5b9:2ae2? ([2620:15c:211:201:a40d:28ad:b5b9:2ae2])
        by smtp.gmail.com with ESMTPSA id ji6-20020a170903324600b001bdf046ed63sm2668193plb.141.2023.08.15.08.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 08:48:06 -0700 (PDT)
Message-ID: <bbf42f55-1f85-9d9f-db72-1d1c08d254ea@acm.org>
Date:   Tue, 15 Aug 2023 08:48:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 00/13] scsi: Support LUN/target based error handle
Content-Language: en-US
To:     "haowenchao (C)" <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <error27@gmail.com>, louhongxiang@huawei.com
References: <20230723234422.1629194-1-haowenchao2@huawei.com>
 <1eb055e9-6343-260c-de04-c08d8fb24789@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1eb055e9-6343-260c-de04-c08d8fb24789@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/23 07:17, haowenchao (C) wrote:
> We can reduce probability of blocking whole host when handle error
> commands with this patchset, which is important for servers which
> deploy large scale disks. And the new error handler is not enabled
> default, so it would not affect drivers which do not need it.

Which drivers need this new error handler? I don't see any changes for
SCSI drivers in this patch series other than scsi_debug. Has this patch
series perhaps been developed for a pass-through driver between virtual
machine guests and their host? If so, has it been considered to
configure pass-through such that there is one disk per SCSI host instead
of multiple?

Thanks,

Bart.

