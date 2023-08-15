Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE4377D5CD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbjHOWLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239459AbjHOWK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:10:59 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11E91FEC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:10:56 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76c93abeb83so405213585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 15:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692137456; x=1692742256;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3unScrRXv43WQA+MynDYU+5hV19Pl9H1g9d0YfpwsE4=;
        b=SBvy/9m5P2epu0i4uxixgn5Id8suYTQeE1NN7DZ+A18Hk/7T6eGmX01I3VhCncnmtg
         eXqOTIRLJcXALgGwmKIvNCbOgWLJdkU5kPJ1uA1KpRvvI2ABPO596ioNFI+KrERYol8W
         S/oojtxlTOZUIyYRNjv4fYFW79kh5nuT84zRotvBYIFPpRadHxLcYpyuW7sQThlZbKXf
         xtXZ2zi+u+JS76Hp28Jv/btB6XFoII9yAx88soA4T0dYJa5fiAtVQ1DfK+1A3QBDEIYC
         MB6A2GWlrOsDdujYU1+zGRzVvsKWdsy7UY4Gg+4OoCe3Ed47Zwpt/TalOVCC16P66ib5
         y16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692137456; x=1692742256;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3unScrRXv43WQA+MynDYU+5hV19Pl9H1g9d0YfpwsE4=;
        b=DlcYyhu9XbRiOUlo7H29E8hQqBhD/5MSDBmWlTzqCD3vyN8eNhgz8bPMcD6sjAMS/D
         Yk+7JjR6YGsYYa4EMeMC7ntMGEN9kLqkaHNRn58gnAIIExx/M3COWpiYBEl+n7cWKYT4
         DE2bZrlHWm4G8OPulV6WPZMAFhdRBCnmXiTe99vHhyO8741mnlvVGF0X6FmzOr+3kPD1
         aSA+RXmLEBtr0d72/fqCiOf6woeMbVq1cp5/XcoJN/wZQ/qqYbCorh7Y12swD7ETZ3L6
         LnGSFtyWIc7VBYX7lTJtiV10fkvYEpBJZVrM7wRnyx/89ZZkAoo0MNV9hMGAl5bZeKxN
         bvCQ==
X-Gm-Message-State: AOJu0Yz0ZYpB+pIRXmizTZ4LoI+egxMRk5Bl8gwlMw5UIRDXT8TGJ+NO
        /znZL2FG3XYrjPyGQ+Dy1M8e
X-Google-Smtp-Source: AGHT+IGlY9pOEe+b2UWKQVm4gn4podkZSAriIh+lc/ht2OtMhsFHyPAzzK13QqNIRbmZ51q16gKZCw==
X-Received: by 2002:a0c:da02:0:b0:641:8878:29a5 with SMTP id x2-20020a0cda02000000b00641887829a5mr43106qvj.61.1692137456053;
        Tue, 15 Aug 2023 15:10:56 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id v19-20020a05620a123300b00767b37256ecsm4030036qkj.107.2023.08.15.15.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 15:10:55 -0700 (PDT)
Date:   Tue, 15 Aug 2023 18:10:55 -0400
Message-ID: <20b96495d277cb2007541a119bb09def.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Atul Kumar Pant <atulpant.linux@gmail.com>, eparis@redhat.com
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v1] kernel: auditsc: Removes use of assignment in if  condition and moves open brace following function definitions to the next  line.
References: <20230815204644.52358-1-atulpant.linux@gmail.com>
In-Reply-To: <20230815204644.52358-1-atulpant.linux@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 15, 2023 Atul Kumar Pant <atulpant.linux@gmail.com> wrote:
> 
> The patch fixes following checkpatch.pl issue:
> ERROR: open brace '{' following function definitions go on the next line
> ERROR: do not use assignment in if condition
> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>  kernel/auditsc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Merged into audit/next, thanks.

--
paul-moore.com
