Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D2E797E27
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjIGV4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIGV4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:56:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEBC1BC6;
        Thu,  7 Sep 2023 14:56:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B172C433C8;
        Thu,  7 Sep 2023 21:56:36 +0000 (UTC)
Date:   Thu, 7 Sep 2023 17:56:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Nadav Amit <namit@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>
Subject: Re: [PATCH 1/6] tracefs/eventfs: Use dput to free the toplevel
 events directory
Message-ID: <20230907175650.02cba53a@gandalf.local.home>
In-Reply-To: <7C38F28D-0277-42B2-9FB1-B4B59BBEC8FF@vmware.com>
References: <20230907024710.866917011@goodmis.org>
        <20230907024803.250873643@goodmis.org>
        <7C38F28D-0277-42B2-9FB1-B4B59BBEC8FF@vmware.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2023 17:48:21 +0000
Ajay Kaher <akaher@vmware.com> wrote:

> Thinking if same problem could happen for sub folder/files of eventfs as
> free_ef() may get call earlier then dput().

Actually, they are not freed at all! Another patch coming.

-- Steve
