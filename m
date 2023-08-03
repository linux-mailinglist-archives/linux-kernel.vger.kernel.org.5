Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE24776F3F3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjHCUTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHCUTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:19:18 -0400
Received: from p3plsmtpa09-02.prod.phx3.secureserver.net (p3plsmtpa09-02.prod.phx3.secureserver.net [173.201.193.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953B53C31
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 13:19:16 -0700 (PDT)
Received: from localhost ([82.27.99.45])
        by :SMTPAUTH: with ESMTPA
        id RemwqV4JViMnJRemxqtkdH; Thu, 03 Aug 2023 13:19:16 -0700
X-CMAE-Analysis: v=2.4 cv=I62jBvsg c=1 sm=1 tr=0 ts=64cc0bc4
 a=YwMIiW7BGddQzL8MrqPWMg==:117 a=YwMIiW7BGddQzL8MrqPWMg==:17
 a=ENF2c8OQyt5_Ph5qRQ4A:9 a=zgiPjhLxNE0A:10
X-SECURESERVER-ACCT: atomlin@atomlin.com
From:   Aaron Tomlin <atomlin@atomlin.com>
To:     tj@kernel.org
Cc:     atomlin@atomlin.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [RFC PATCH 0/2] workqueue: Introduce PF_WQ_RESCUE_WORKER
Date:   Thu,  3 Aug 2023 21:19:14 +0100
Message-Id: <20230803201914.1802437-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <ZMqcGUderg8v5SEz@slm.duckdns.org>
References: <ZMqcGUderg8v5SEz@slm.duckdns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfO/evbuumYY5KOSMgpzYfQ9L3GiEoM5+QS6fd9qOFWeU8XlN11HChkpFukyiHakzyML2YCCfLRl8SF+TsWHgTVrzDszPvAkwIR2nyyABljlnyx2OGTbD
 8BOyiRSu8Wyl5ec/8Mm9riMehyFYwJX7LtMkIcpjQdUfI1l612NIWyDSNzepVdZ0yIQfCWLvpq2xV6qUK1ebKQJN+kw7XWAfTYjfRjlc9S+DAgKEvzsRQTeN
 4m62+vAPZeYv8aQZqL7zjFxGNXHgSkkU7z27RwoaTyPsozsFFtrandKseftwUr+VH7K+mW6OqxAWfBPqZh1ifg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> But why do you need to identify rescue workers? What are you trying to
> achieve?

Hi Tejun,

I had a conversation with a colleague of mine. It can be useful to identify
and account for all kernel threads. From the perspective of user-mode, the
name given currently to the rescuer kworker is ambiguous. For instance,
"kworker/u16:9-kcryptd/253:0" is clearly identifiable as an unbound kworker
for the specified workqueue which can have their CPU affinity adjusted as
you mentioned before. I think if we followed the same naming convention
for a rescuer kworker then it would be more consistent. I'll send a patch
so it can be discussed further.


Kind regards,
-- 
Aaron Tomlin
