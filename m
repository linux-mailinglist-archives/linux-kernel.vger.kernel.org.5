Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C314A7CECA3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 02:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjJSAN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 20:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjJSANz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 20:13:55 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2F3122
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 17:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1697674428;
        bh=+sC6wSrBTAo3kMI6/R3w/jOiRwJn1ifgVMygdiXfbqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lq6xUNza6rTJ1bLIhkiFGy5+mHXKZ2uDEL5cvkAi95gHe35ixSG4lHrZWQeqNS21c
         6zoRyTGxqWSY+V3ioC7q9WxiOEg9qiJJrfrJOVM9jJFcqjRSiJHWHXbpXDTX0yo6nH
         GbQ7d5r1W2bm/pbBGb19m1BHm4+pOMNtwudWM68M=
Received: from RT-NUC.. ([39.156.73.12])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 36E25AB7; Thu, 19 Oct 2023 08:13:46 +0800
X-QQ-mid: xmsmtpt1697674426t1e9h94ms
Message-ID: <tencent_44E6924065ED557F140791CCE04BC824CB05@qq.com>
X-QQ-XMAILINFO: NSObNE1Kae7Zzzod1N7QKTZnNc5KUoY96qI96ALGZsAsMdHi+xGA2+auyuGc6u
         +vQtPovkccDGXCIxx0zlp552gqSsmj9i7gmDAY7QYqpH6XiGO8wkhbbYVEzEXo3WY/x83/VEBGNz
         vYatAbK26leEVHyclF72vB4zZvrJGsDe3zGwJ16fBKggHGJSznjZJ5pVbTYPryt1Xf6LyBHReP+e
         bJjIp22ykDYHpbh8s867HFwKWS8zQqAioSF1zOTC8ZMum8790e2V7DwH0NGnkvE2ISu/Ho3NgS2z
         MAUJoGqcpbPv44W6dQLg3CIycq+i6Yo9L+pCVfSo9S6+5DtbuB48CaKfwvKmoY7ufRA8jAPsn1cu
         P5YqecLS4HIHoVnrKzRV3FHu6WjJgxkcRTSw5KjP7WKS+Xt0eQCtAVaAYjagzuU5RNfAFFTm+0gB
         Y1csvAtxDjVBu9NRKuIGpZUqmPFrlhNhPZCHoQs2btQYsNkUULJc5yKt2p3yUt/jEYDPQpXTTtYR
         sI4L5suR0I0WCZCQ8gaNfgLmLs+ocBedIjG8ANLsf8XFk3WAREriT8NeKV4x9JYuW/T2fq1Urj35
         gGYbO+raOVd8sJioNNrWfqwRjn7Fu5Uc+J53xiIeQSOn5r2LFqYATeVntH4ovLquBggOuj2/Scd/
         RRjGLxUsuwzJHcdp1QLhaGuzXwEZfPJlBmAYmaVGGUSbLsWkO7hLuHQehZtrucQyP4a3RShFrrZN
         A26L9unt9YfWopMbeP2F0w8slHvDF3B95RmMSteFsVu1Jarz2+3Vyuo72GCsMnFvzpu/Yb+LQLck
         VNyFqtyI0zxmz3XxpWa9AaC1VyfJRIt6Lguvy7YO0dP3VImfk6GEij79ifvXwzOrPHON/QKojtx0
         BZ7aueFisX/0zw7XR6uP5NWF/sat51c/Ob4WlW4ukKEjoRZuDJ5exwPLWBTQAa3ExkBA99ydYt3E
         l+81ZKRlPIxx+YzC8V0JlPTe2LTWjTnZdU007kSF3pqmBnYqyJfA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From:   Rong Tao <rtoax@foxmail.com>
To:     mark.rutland@arm.com, peterz@infradead.org
Cc:     elver@google.com, linux-kernel@vger.kernel.org, rongtao@cestc.cn,
        rtoax@foxmail.com, tglx@linutronix.de
Subject: Re: [PATCH] stop_machine: Avoid potential race behaviour of multi_stop_data::state
Date:   Thu, 19 Oct 2023 08:13:46 +0800
X-OQ-MSGID: <20231019001346.289818-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <ZS5g6I-UtUnihToH@FVFF77S0Q05N>
References: <ZS5g6I-UtUnihToH@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Mark and Peter, I just submit v2, please review.

Rong Tao

