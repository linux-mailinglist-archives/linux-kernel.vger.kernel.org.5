Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4B6770C7A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 01:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjHDXno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 19:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHDXnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 19:43:43 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7AB3AAF;
        Fri,  4 Aug 2023 16:43:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68706d67ed9so2002002b3a.2;
        Fri, 04 Aug 2023 16:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691192622; x=1691797422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEfWbMekVOis74fzGo6NQbuxIeM7Xi4X1XcgM3Do+mg=;
        b=SMCqF5PxNsYS3AXPDzUs2BrUDQtgci8nR12ZvOzyRqvl34dhz1Zkqb9L51Azs33v3B
         5Y0uJYWcI5U931YViEo5ApSG5y97oF8QZZ0CHTbi2UHwhunjN/43fUqKxZA6QiOZJvWD
         ToFbMAhKnI/Kds4SuhRAoptqqno+2CuxEmy0gMm/N76ACKA+szlOg38T4tGiwvUgZV9P
         zcI1YZLeZEsB4PYyHat/9lIyT5uZp1/B7ZZRyd14ieiiAqnQNQPF9gccheBLJelGZZV/
         Cu9ytPLAYxmm2pPsWCCS2eqYBl4E7oatF/uStl8SMchTED9nDf75Ahn4IZKEVZTHUWFu
         kHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691192622; x=1691797422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEfWbMekVOis74fzGo6NQbuxIeM7Xi4X1XcgM3Do+mg=;
        b=VVH+3k1H+c3DcNVggKv/yIiMfqLNceDP+KiPEwwIR9Z/gQGwIrmpKOKjsFnjEAytFn
         gIONOlJ0RQsa9ibeq7vILTctRpjTNepggWuvAiLnxBK/t0huBx72X9/m+vezlADt9jj2
         keO4AsCPvQum4cAMLoO1xqN0189kfmsJ8h5IKTInkMrpyARDIfSXB+yO9R66AfR+VbQQ
         hsf4c1N8Jzye1UHgtFvNmgiGffo83n57oW8WtMm/phZfs6TGNDHl0QFhTKD/LH4DAEFY
         4+c2VS/0Fgb2YQYel9UBk+aq4ZGY0TLtpuP/oisjNX0ZveejANYnCD+CyWXQN2AlGUYS
         FTNg==
X-Gm-Message-State: AOJu0YyCc1Zil8aL0szIIfmoHjORfbfBAXKAF5P7tCi2jO12DpB4EN9f
        UW/xRrI6Nj11MLgnhJepOuOyy74ZN4g=
X-Google-Smtp-Source: AGHT+IFlTqdv8UnTSYXbtFG+1ay4opH/CW4xl6RNuqQV69V9nq8s7U59R/l9yJksoDiC7b9gbjdvew==
X-Received: by 2002:a05:6a20:1051:b0:13d:5b8e:db83 with SMTP id gt17-20020a056a20105100b0013d5b8edb83mr2833735pzc.9.1691192621838;
        Fri, 04 Aug 2023 16:43:41 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-73-13.dynamic-ip.hinet.net. [36.228.73.13])
        by smtp.gmail.com with ESMTPSA id o19-20020a170902779300b001b8a897cd26sm2267941pll.195.2023.08.04.16.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 16:43:41 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     rdunlap@infradead.org
Cc:     corbet@lwn.net, linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        minhuadotchen@gmail.com, src.res@email.cn
Subject: Re: [PATCH] docs: sparse: fix invalid link addresses
Date:   Sat,  5 Aug 2023 07:43:38 +0800
Message-Id: <20230804234338.4105-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <bfab7c5b-e4d3-d8d9-afab-f43c0cdf26cf@infradead.org>
References: <bfab7c5b-e4d3-d8d9-afab-f43c0cdf26cf@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

>On 8/4/23 04:23, Min-Hua Chen wrote:
>> The http and git links are invalid, replace them with valid links.
>> 
>> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
>
>Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
>
>It would be good if someone would update/modify this
>sparse.txt file to be in Documentation/translation/zh_TW/dev-tools/
>and convert it to sparse.rst (IMO).

Thanks for your comment.
This is on my todo list next week:
1) move the file to Documentation/translation/zh_TW/dev-tools
2) move to rst format

Min-Hua

>Thanks.

