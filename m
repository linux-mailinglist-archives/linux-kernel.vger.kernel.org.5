Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0951A78FFB5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350131AbjIAPMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350114AbjIAPMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC7D10D2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693581066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PjPKhI43vIfzzZd2VhUjYTOy+VZHsBkuOPPi/NbdW0w=;
        b=DippyOvfcg4BwqcXNLpcW32bzpVwJ+/EPX31o0R8Jn87GEmvyAlGt3h0Xg9HGDvvNtlfx3
        +LgixHHOC31OJSioGwN7CkcTYO1fSxIFpiLXGgCzB2uacAI86f++nK7/gEHIeDDDGakGi8
        G67230XaJLPBUR9vk/ekl5Ls7tv3eD4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-u4ehhMJuNSqMc1yKj6PK3g-1; Fri, 01 Sep 2023 11:11:00 -0400
X-MC-Unique: u4ehhMJuNSqMc1yKj6PK3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A14429AA382;
        Fri,  1 Sep 2023 15:11:00 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.39.193.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23C652012F37;
        Fri,  1 Sep 2023 15:10:58 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/4] Minor v6.6 trace_events_filter fixes
Date:   Fri,  1 Sep 2023 17:10:35 +0200
Message-Id: <20230901151039.125186-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These are small fixes incorporating feedback on the trace filters part of [1].

Based on top of trace-v6.6.

Cheers,
Valentin

[1]: https://lore.kernel.org/all/20230720163056.2564824-1-vschneid@redhat.com/

Valentin Schneider (4):
  tracing/filters: Fix error-handling of cpulist parsing buffer
  tracing/filters: Fix double-free of struct filter_pred.mask
  tracing/filters: Change parse_pred() cpulist ternary into an if block
  tracing/filters: Fix coding style issues

 kernel/trace/trace_events_filter.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

--
2.31.1

