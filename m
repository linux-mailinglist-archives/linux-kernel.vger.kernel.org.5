Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0228757793
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjGRJQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjGRJPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:15:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A9B170C;
        Tue, 18 Jul 2023 02:15:38 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fa16c6a85cso8706673e87.3;
        Tue, 18 Jul 2023 02:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689671736; x=1690276536;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSJUm/Yd7shnvenHepkcjFVUM0ifKlW2CRs/h0RG3ew=;
        b=VM6EpdYIg155VnamqqOEwTGggCQ7ZoCpYTYcptTlmQEzNj6rTcEVI48PgdMu8Ji7Kj
         lpv3Jlo9BE2631bwLO+4sHveneeriZFKCITZhuDn/rmrkZ17wRJW0jMrViQP8MdxN65E
         U5gPg3VCJunDz4XHOFfo2IghTrhguK0uG1SEMu1U/7pHf2AOKR2AmCNug+tIo+wFLncy
         Tz67wzmA7OnnrLRr9a4NNPsBtDwLWTE7mupA9g5aP0osWbYnC7LSD5VI0CaWwGAjMyAe
         PVhrXB4kLZgxweJA03yTipkowJ79ZnTfvQzJbPZug2FP8eKU0yrYlOInLe4fz+yNcjTR
         bylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689671736; x=1690276536;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSJUm/Yd7shnvenHepkcjFVUM0ifKlW2CRs/h0RG3ew=;
        b=BBjP4OPMrfugOZvqX+DABbDXLmOFul72vLeTydbeiINpdI5ifNeBi/rPq9cWRKBYM1
         qrfob34kutFWVUhKwS2HTSgshQcAvl1sBERI7LxW28TL5dvD9/EmnASTVk/911v8rqZd
         /7/E1yBUF1/7H59xoR4ZG+FJhVQe19Rnv9MI9an2hikkEXOrSdlc3px9OAccqI9ADT5x
         KeIXd+TILuCegwmLUXJgMCU3sMDN8pb708wJRkhbFcgjaExT+7We+Un+1jcrMvAglVmq
         JXTG/mrEum6cCsWajk+JZDK2017hIjG093nepioBcq7mwQc3SiG6lA1xo/6HaNK+uxOd
         MkRA==
X-Gm-Message-State: ABy/qLb7I1akxWDYTqtfDMOj7mAXOwquFTgs+bE1vKGK6S7Swmkfweea
        QHXiS8u1+IHI32/tMMcGxN/v9KK/yRA=
X-Google-Smtp-Source: APBJJlEBGvUZbxDP/THXggMtb+iJuY6yuqpuZ3vuFGrFc+I7w4ab3WCbbZh+9hRriPtOPAVcXseHQg==
X-Received: by 2002:a05:6512:2202:b0:4f6:2a02:fc1a with SMTP id h2-20020a056512220200b004f62a02fc1amr11207986lfu.17.1689671736436;
        Tue, 18 Jul 2023 02:15:36 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.85.68])
        by smtp.gmail.com with ESMTPSA id p1-20020a19f001000000b004f4b42e2d7dsm338370lfc.230.2023.07.18.02.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 02:15:35 -0700 (PDT)
Subject: Re: [PATCH] wifi: ata: pata_parport: epat.c Added missing spaces
To:     hanyu001@208suo.com, dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_DAE8C1D6AAA3633E096977B14E5133F42705@qq.com>
 <5a75c59282fbe38bc4637c95c66f9151@208suo.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <e76b0b7a-6cc1-b9a4-dc99-7d88640cafee@gmail.com>
Date:   Tue, 18 Jul 2023 12:15:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5a75c59282fbe38bc4637c95c66f9151@208suo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

On 7/18/23 10:57 AM, hanyu001@208suo.com wrote:

> Added spaces needed in the proper places to address:
> 
> ./drivers/ata/pata_parport/epat.c:283: ERROR: spaces required around that '=' (ctx:VxV)
> ./drivers/ata/pata_parport/epat.c:283: ERROR: space required after that ';' (ctx:VxV)
> ./drivers/ata/pata_parport/epat.c:283: ERROR: spaces required around that '<' (ctx:VxV)
> ./drivers/ata/pata_parport/epat.c:283: ERROR: space required after that ';' (ctx:VxV)

   Is that from checkpatch.pl?

> Signed-off-by: Yu Han <hanyu001@208suo.com>

   Aside from the issue with the subject:

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

MBR, Sergey
