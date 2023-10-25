Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5507D7301
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 20:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjJYSLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 14:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjJYSLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 14:11:05 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37610128;
        Wed, 25 Oct 2023 11:11:03 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ca215cc713so40362875ad.3;
        Wed, 25 Oct 2023 11:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698257462; x=1698862262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2iMDVchob+o0oV/0w+uz7B6gj0y4M0k4PlyjKILH9gA=;
        b=kakwnop5YKW5A/1QduLU5CmgOPA9hmCBGJYyrgVHkixLlQVxiDigm/oWJnnp1E8bTi
         UCbY5e/OHx2DEzr9xsq+9ZTGiDj/PeFHhO797dz2KaWGST7HvrUd51u/K4XQRt4DyMPW
         WxJbAVVHtfp37o3JI0VO2yGc2k3wfdl/ySh31WL5t6+v0Hmm2oiOi2ys/DQNqZnxllmf
         k7RAdQtHIFIkbvtUxRn/PDKSPB3MjkybPIWOyR7rgm8K5oselq3Yz+9hDqUXDXwiAG1L
         lRqXrnkpSQUJlYWEM0gS/QB5vZyc0/fPZPcmaLuZw64plUR9HIwZVebJFk6j2NGfGQZi
         +8Qw==
X-Gm-Message-State: AOJu0Yxt0kGoSyZjzkVbBwjOk1TiP1zla2saBstxfgnhtPy3c7A+KHOv
        43JrJTcXrcm6UhKU9A49C8o=
X-Google-Smtp-Source: AGHT+IGtLL78u4rxM6Ezz9EpLFh9pOezvZDqe0pqsvnGikICyGsJSHiluvDfQH+FuAEE/xdAf7UhSA==
X-Received: by 2002:a17:902:c404:b0:1c7:8345:f377 with SMTP id k4-20020a170902c40400b001c78345f377mr17227158plk.29.1698257462403;
        Wed, 25 Oct 2023 11:11:02 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:4dcf:e974:e319:6ce8? ([2620:15c:211:201:4dcf:e974:e319:6ce8])
        by smtp.gmail.com with ESMTPSA id jw15-20020a170903278f00b001bb99e188fcsm9560717plb.194.2023.10.25.11.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 11:11:02 -0700 (PDT)
Message-ID: <3056c6d8-1e54-4954-9141-e0760a0d935a@acm.org>
Date:   Wed, 25 Oct 2023 11:10:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] ufs: core: Add host quirk
 QUIRK_MCQ_EXPAND_QUEUE_SLOT
Content-Language: en-US
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Can Guo <quic_cang@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D . Nguyen" <quic_nguyenb@quicinc.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Eric Biggers <ebiggers@google.com>,
        Keoseong Park <keosung.park@samsung.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>
Cc:     wsd_upstream@mediatek.com, casper.li@mediatek.com,
        peter.wang@mediatek.com, powen.kao@mediatek.com,
        alice.chao@mediatek.com, naomi.chu@mediatek.com,
        cc.chou@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com, tun-yu.yu@mediatek.com,
        lin.gui@mediatek.com, eddie.huang@mediatek.com,
        qilin.tan@mediatek.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel-team@android.com
References: <20231025085656.10848-1-chun-hung.wu@mediatek.com>
 <20231025085656.10848-2-chun-hung.wu@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231025085656.10848-2-chun-hung.wu@mediatek.com>
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

On 10/25/23 01:56, Chun-Hung Wu wrote:
> This quirk needs to be enabled if the host controller cannot 
> distinguish queue full or empty.

 From the UFSHCI 4.0 specification: "When the head and tail doorbells are
equal, the queue is empty. [ ... ] When the head and tail doorbells are
not equal, the queue contains queue entries."

How is it possible that a host controller cannot distinguish queue full
or queue empty? Which (head - tail) values cause trouble? More
information is needed.

Thanks,

Bart.

